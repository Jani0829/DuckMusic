package kr.co.duck.service;

import static kr.co.duck.util.StatusCode.ALREADY_PLAYING;
import static kr.co.duck.util.StatusCode.CANT_ENTER;
import static kr.co.duck.util.StatusCode.MEMBER_DUPLICATED;
import static kr.co.duck.util.StatusCode.NOT_EXIST_ROOMS;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.duck.beans.MemberBean;
import kr.co.duck.beans.QuizRoomBean;
import kr.co.duck.beans.QuizRoomListBean;
import kr.co.duck.domain.Member;
import kr.co.duck.domain.MemberCommand;
import kr.co.duck.domain.MemberQuery;
import kr.co.duck.domain.QuizCommand;
import kr.co.duck.domain.QuizMessage;
import kr.co.duck.domain.QuizQuery;
import kr.co.duck.domain.QuizRoom;
import kr.co.duck.domain.QuizRoomAttendee;
import kr.co.duck.repository.SessionRepository;
import kr.co.duck.util.CustomException;
import kr.co.duck.util.StatusCode;
import kr.co.duck.util.UserDetailsImpl;

@Service
public class QuizRoomService {
	// 의존성 주입
	private final QuizService quizService;
	private final MemberQuery memberQuery;
	private final MemberCommand memberCommand;
	private final QuizQuery quizQuery;
	private final QuizCommand quizCommand;
	private final SessionRepository sessionRepository;

	// 생성자
	public QuizRoomService(QuizService quizService, MemberQuery memberQuery, MemberCommand memberCommand,
			QuizQuery quizQuery, QuizCommand quizCommand, SessionRepository sessionRepository) {
		this.quizService = quizService;
		this.memberQuery = memberQuery;
		this.memberCommand = memberCommand;
		this.quizQuery = quizQuery;
		this.quizCommand = quizCommand;
		this.sessionRepository = sessionRepository;
	}

	// QuizRoomService 클래스
	@Transactional
	public QuizRoomListBean getAllQuizRooms(Pageable pageable) {
	    Page<QuizRoom> rooms = quizQuery.findQuizRoomByPageable(pageable);
	    List<QuizRoomBean> quizRoomList = new ArrayList<>();

	    for (QuizRoom room : rooms) {
	        List<QuizRoomAttendee> quizRoomAttendeeList = quizQuery.findAttendeeByQuizRoom(room);
	        List<MemberBean> memberList = new ArrayList<>();

	        for (QuizRoomAttendee quizRoomAttendee : quizRoomAttendeeList) {
	            Member eachMember = memberQuery.findMemberById(quizRoomAttendee.getMember().getId());
	            MemberBean memberBean = new MemberBean(eachMember.getId(), eachMember.getNickname(), eachMember.getEmail());
	            memberList.add(memberBean);
	        }

	        QuizRoomBean quizRoomBean = new QuizRoomBean(room.getQuizRoomId(), room.getQuizRoomName(), room.getQuizRoomPassword(), room.getOwner(), room.isStatus(), memberList.size(), memberList);

	        if (!memberList.isEmpty()) {
	            quizRoomList.add(quizRoomBean);
	        }
	    }

	    int totalPage = rooms.getTotalPages();
	    return new QuizRoomListBean(totalPage, quizRoomList);
	}


	// 퀴즈룸 생성
	@Transactional
	public Map<String, String> makeQuizRoom(Member member, QuizRoomBean quizRoomBean) {
	    member.updateMakeRoom(1); // 퀴즈방 생성 횟수 업데이트
	    memberCommand.saveMember(member); // 멤버 정보 저장

	    // QuizRoom 객체 생성
	    	QuizRoom quizRoom = new QuizRoom(
	        quizRoomBean.getRoom_name(),      // 방 이름
	        quizRoomBean.getRoom_password(),  // 방 비밀번호
	        member.getNickname(),            // 방장 닉네임
	        true                              // 방 상태 (true로 설정)
	    );

	    quizCommand.saveQuizRoom(quizRoom); // 퀴즈 방 저장

	    // 퀴즈 방 참가자 객체 생성
	    QuizRoomAttendee quizRoomAttendee = new QuizRoomAttendee(quizRoom, member);
	    quizCommand.saveQuizRoomAttendee(quizRoomAttendee); // 참가자 정보 저장

	    // 방 정보 반환
	    Map<String, String> roomInfo = new HashMap<>();
	    roomInfo.put("quizRoomName", quizRoom.getQuizRoomName());
	    roomInfo.put("roomId", Integer.toString(quizRoom.getQuizRoomId()));
	    roomInfo.put("quizRoomPassword", quizRoom.getQuizRoomPassword());
	    roomInfo.put("owner", quizRoom.getOwner());
	    roomInfo.put("status", String.valueOf(quizRoom.isStatus()));

	    return roomInfo;
	}


	// 퀴즈룸 입장
	@Transactional
	public Map<String, String> enterQuizRoom(int roomId, Member member) {
		QuizRoom enterQuizRoom = quizQuery.findQuizRoomByRoomIdLock(roomId);

		if (!enterQuizRoom.isStatus()) {
			throw new CustomException(ALREADY_PLAYING);
		}

		List<QuizRoomAttendee> quizRoomAttendeeList = quizQuery.findAttendeeByQuizRoom(enterQuizRoom);

		if (quizRoomAttendeeList.size() > 3) {
			throw new CustomException(CANT_ENTER);
		}

		member.updateEnterGame(1);
		memberCommand.saveMember(member);

		for (QuizRoomAttendee quizRoomAttendee : quizRoomAttendeeList) {
			if (member.getId() == quizRoomAttendee.getMember().getId()) {
				throw new CustomException(MEMBER_DUPLICATED);
			}
		}

		QuizRoomAttendee newAttendee = new QuizRoomAttendee(enterQuizRoom, member);
		quizCommand.saveQuizRoomAttendee(newAttendee);

		Map<String, String> roomInfo = new HashMap<>();
		roomInfo.put("quizRoomName", enterQuizRoom.getQuizRoomName());
		roomInfo.put("roomId", String.valueOf(enterQuizRoom.getQuizRoomId()));
		roomInfo.put("owner", enterQuizRoom.getOwner());
		roomInfo.put("status", String.valueOf(enterQuizRoom.isStatus()));

		return roomInfo;
	}

	// 퀴즈방 키워드 조회
	public QuizRoomListBean searchQuizRoom(Pageable pageable, String keyword) {
		Page<QuizRoom> rooms = quizQuery.findQuizRoomByContainingKeyword(pageable, keyword);

		if (rooms.isEmpty()) {
			throw new CustomException(NOT_EXIST_ROOMS);
		}

		List<QuizRoomBean> quizRoomList = new ArrayList<>();
		for (QuizRoom room : rooms) {
			List<QuizRoomAttendee> quizRoomAttendeeList = quizQuery.findAttendeeByQuizRoom(room);
			List<MemberBean> memberList = new ArrayList<>();

			for (QuizRoomAttendee quizRoomAttendee : quizRoomAttendeeList) {
				Member eachMember = memberQuery.findMemberById(quizRoomAttendee.getMember().getId());
				MemberBean memberBean = new MemberBean();
				memberBean.setMember_id(eachMember.getId());
				memberBean.setNickname(eachMember.getNickname());
				memberBean.setEmail(eachMember.getEmail());
				memberList.add(memberBean);
			}

			QuizRoomBean quizRoomBean = new QuizRoomBean(room.getQuizRoomId(), room.getQuizRoomName(),
					room.getQuizRoomPassword(), room.getOwner(), room.isStatus(), memberList.size(), memberList);

			if (!memberList.isEmpty()) {
				quizRoomList.add(quizRoomBean);
			}
		}

		int totalPage = rooms.getTotalPages();
		return new QuizRoomListBean(totalPage, quizRoomList);
	}

	// 방장 정보 조회
	public Map<String, String> ownerInfo(int roomId) {
		QuizRoom enterRoom = quizQuery.findQuizRoomByRoomId(roomId);
		String ownerNickname = enterRoom.getOwner();
		Member member = memberQuery.findMemberByNickname(ownerNickname);
		String ownerId = String.valueOf(member.getId());

		Map<String, String> ownerInfo = new HashMap<>();
		ownerInfo.put("ownerId", ownerId);
		ownerInfo.put("ownerNickname", ownerNickname);

		return ownerInfo;
	}

	// 세션 끊김 시 방에서 참가자 정보 정리
	public void exitGameRoomAboutSession(String nickname, int roomId) {
		Member member = memberQuery.findMemberByNickname(nickname);
		List<QuizRoomAttendee> quizRoomAttendeeList = quizQuery.findAttendeeByRoomId(roomId);
		for (QuizRoomAttendee quizRoomAttendee : quizRoomAttendeeList) {
			if (nickname.equals(quizRoomAttendee.getMemberNickname())) {
				roomExit(roomId, member);
			}
		}
	}

	// 방 나가기
	@Transactional
	public void roomExit(int roomId, Member member) {
		QuizRoom enterQuizRoom = quizQuery.findQuizRoomByRoomId(roomId);
		QuizRoomAttendee quizRoomAttendee = quizQuery.findAttendeeByMember(member);
		quizCommand.deleteQuizRoomAttendee(quizRoomAttendee);

		List<QuizRoomAttendee> existQuizRoomAttendee = quizQuery.findAttendeeByQuizRoom(enterQuizRoom);

		if (existQuizRoomAttendee.isEmpty()) {
			member.updateSoloExit(1);
			memberCommand.saveMember(member);
			quizCommand.deleteQuizRoom(enterQuizRoom);
			sessionRepository.deleteAllClientsInRoom(roomId);
		}

		if (!enterQuizRoom.isStatus()) {
			quizService.forcedEndQuiz(roomId, member.getNickname());
		}

		Map<String, Object> contentSet = new HashMap<>();
		contentSet.put("memberCount", existQuizRoomAttendee.size());
		contentSet.put("alert", member.getNickname() + " 님이 방을 나가셨습니다!");

		quizService.sendQuizMessage(roomId, QuizMessage.MessageType.LEAVE, contentSet, null, member.getNickname());

		// 만약 나간 사람이 방장이고, 남은 인원이 있다면 새로운 방장을 선정
		if (member.getNickname().equals(enterQuizRoom.getOwner()) && !existQuizRoomAttendee.isEmpty()) {
			String nextOwner = existQuizRoomAttendee.get((int) (Math.random() * existQuizRoomAttendee.size()))
					.getMemberNickname();
			enterQuizRoom.setOwner(nextOwner);
			quizService.sendQuizMessage(roomId, QuizMessage.MessageType.NEWOWNER, null, null, nextOwner);
		}
	}

	// 퀴즈방 입장 검증
	public void enterVerify(int roomId, UserDetailsImpl userDetails) {
		// 비회원일 경우 에러 메시지 보내기
		if (userDetails == null) {
			throw new CustomException(StatusCode.INVALID_TOKEN);
		}

		int cnt = 0;
		// 해당 방의 모든 참가자들을 리스트로 저장
		List<QuizRoomAttendee> quizRoomAttendeeList = quizQuery.findAttendeeByRoomId(roomId);

		// 참가자의 닉네임과 접속한 사람의 닉네임이 동일하면 카운트 증가
		for (QuizRoomAttendee quizRoomAttendee : quizRoomAttendeeList) {
			if (userDetails.getMember().getNickname().equals(quizRoomAttendee.getMemberNickname())) {
				cnt++;
			}
		}

		// cnt가 1이 아닐 경우, 잘못된 접근으로 판단하여 에러 메시지 전송
		if (cnt != 1) {
			throw new CustomException(StatusCode.BAD_REQUEST);
		}
	}
}

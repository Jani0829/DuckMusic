package kr.co.duck.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import kr.co.duck.beans.MemberBean;

public class MemberValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		
		return MemberBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberBean memberBean = (MemberBean) target;
		
		String beanName = errors.getObjectName();
		System.out.println(beanName);

		//비밀번호 확인 또는 수정시
		if (beanName.equals("joinMemberBean") || beanName.equals("modifyMemberBean")) {
			if (memberBean.getPassword().equals(memberBean.getPassword2()) == false) {
				errors.rejectValue("password", "NotEquals");
				errors.rejectValue("password2", "NotEquals");
			}
		

			//회원가입시
			if (beanName.equals("joinMemberBean")) {

				if (memberBean.isMemberNameExist() == false) {
					errors.rejectValue("membername", "DontCheckMemberNameExist");
				}
			}
		}
		
	}

}

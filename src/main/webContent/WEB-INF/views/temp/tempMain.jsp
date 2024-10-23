<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var='root' value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" type="image/png" sizes="48x48" href="${root}/img/favicon.png">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/background_animation.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/locomotive-scroll@4.1.0/dist/locomotive-scroll.css" />
<script src="https://cdn.jsdelivr.net/npm/gsap@3.11.5/dist/gsap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.11.5/dist/ScrollTrigger.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/locomotive-scroll@4.1.0/dist/locomotive-scroll.min.js"></script>
<script src="${pageContext.request.contextPath}/js/finisher-header.es5.min.js" type="text/javascript"></script>
<title>DuckMusic</title>
   
<style>
html, body {
  margin: 0;
}
@keyframes wave {
  0%   { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
.wave {
  position: absolute;
  height: 750px;
  width: 750px;
  opacity: 0.6;
  left: 50%;          /* 중앙 정렬 */
  top: -125px;           /* 중앙 정렬 */
  margin-left: -375px; /* 가로 중앙 정렬 */
  margin-top: -375px;  /* 세로 중앙 정렬 */
  background: radial-gradient(#0d2233, #2b1e38);
  border-radius: 44%;
  animation: wave 6000ms infinite linear;
  z-index: 1;
}
.wave:nth-child(2) {
  animation-duration: 4000ms;
}
.wave:nth-child(3) {
  animation-duration: 5000ms;
}

.card-container{
   display: flex;
   flex-direction: column;
     box-shadow: 0px 8px 28px -9px rgba(0,0,0,0.45);
     overflow: hidden;
     position: relative;
     width: 365px;
     height: 435px;
     margin: 0 40px;
     border-radius: 20px;
     text-align: center;
     object-fit: cover;
     padding: 0;
}

.card-title {
    width: 100%;
	height: 40%;
	background: black;
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
}

.card-title img {
    width: 100%;
    height: auto;
}

.card-con {
	width: 100%;
	height: 60%;
    flex: 1;
    padding: 20px;
    background-color: #f9f9f9;
}

body {
  font-family: termina, sans-serif;
  transition: 0.3s ease-out;
  overflow-x: hidden;
  max-width: 100%;
  width: 100%;
  overscroll-behavior: none;
  margin: 0;
  -ms-overflow-style: none;
}

::-webkit-scrollbar{
   display: none;
}

section:not(#sectionPin) {
  min-height: 100vh;
  width: 100%;
  position: relative;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  grid-gap: 3.5rem;
  margin: auto;
  place-items: center;
}

section#payment{
  min-height: 100vh;
  width: 100%;
  position: relative;
  display: flex;
  flex-direction: column; /* 세로 방향으로 배치 */
  justify-content: center; /* 수직 중앙 정렬 */
  background: #000000;
}

img {
  height: 50vh;
  width: auto;
  object-fit: cover;
}

h1 {
  font-size: 5rem;
  line-height: 1;
  font-weight: 800;
  margin-bottom: 0;
  position: absolute;
  top: 15vh;
  left: 10vw;
  z-index: 4;
  overflow-wrap: break-word;
  hyphens: auto;
}

@media (max-width: 768px) {
  h1 {
    font-size: 16vw;
  }
}

h1 span {
  color:white;
  display: block;
}

h2 {
  font-size: 2rem;
  max-width: 400px;
}

.credit {
  font-family: Termina, sans-serif;
}

.credit a {
  color: var(--text-color);
}

* {
  box-sizing: border-box;
}

#sectionPin {
  height: 100vh;
  overflow: hidden;
  display: flex;
  left: 0;
  background: black;
  color: var(--bg-color);
  margin: 0;
  background: cover;
}

.pin-wrap {
  height: 100vh;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  padding: 50px 5vw;
  margin: 0;
  background: cover;
}

.pin-wrap > h2 {
  min-width: 26vw;
  padding: 0 2vw;
}

c-scrollbar{
   background-color: white;
}

.pay{
   display: flex;
   border-radius: 8px;
   /* margin-top: 60px; */
}

.by-month, .by-year {
   position: relative;
   overflow: hidden;
   height: 350px;
   width: 400px;
   background: #2f3b4c;
   opacity: 0.95;
   border-radius: 15px;
    flex: 1; /* 각 div가 동일한 너비를 가지도록 설정 */
    padding: 10px; /* 내부 여백 설정 */
    border: 1px solid wheat;
    text-align: center; /* 텍스트 중앙 정렬 */
    color: white;
    margin: 0 45px;
}

.btn{
   margin-top: 55PX;
}

</style>
</head>

<body style="overs">
   <header>
      <!-- top_menu.jsp 포함 -->
      <jsp:include page="/WEB-INF/views/include/top_menu.jsp" />

      <!-- Sidebar 포함 -->
         <jsp:include page="/WEB-INF/views/include/sidebar.jsp" />
   </header>
	<div class="container">
		<section>
			<div class="header finisher-header"
				style="width: 100%; height: 110vh; z-index: 10;">
				<h1 style="position: relative; z-index: 20;" data-scroll
					data-scroll-speed="1">
					<span>당신의 일상에</span> <span>음악을 더하다</span>
					<!-- <span>section</span> -->
					<span
						style="position: fixed; top: 200px; left: 5px; color: white; font-size: 30px">언제
						어디서나 음악과 함께!</span>
				</h1>

				<div class="test-pic"
					style="position: fixed; top: 35vh; margin-left: 48vw;">
					<img alt="예시" src="${root}/img/고양이와헤드셋여자아이.jpg">
				</div>
				
			</div>
		</section>

		<section id="sectionPin">
			<div class="pin-wrap">
				<h2 style="color: white;">
					전 세계 음악 팬들과 <br /> 소통하는 커뮤니티, <br /> 그리고 즐거운 퀴즈 게임! <br /> 최신
					음악부터 <br /> 숨겨진 명곡까지, <br /> 음악을 더 재미있게 <br /> 즐겨보세요
				</h2>

				<div class="card-container">
					<div class="card-title">
						<img src="${root}/img/미래도시,비.jpg" alt="사진" />
					</div>
					<div class='card-con'>
						<h3>더 풍부하게 음악을 들어보세요.</h3>
						<div style="display: block; margin: 15% 0;">DuckMusic에서 이전에
							경험하지 못한 새로운 방식으로 음악을 즐기세요.</div>
					</div>
				</div>

				<div class="card-container">
					<div class="card-title">
						<img src="${root}/img/미래도시,비.jpg" alt="사진" />
					</div>
					<div class='card-con'>
						<h3>1억개 이상의 트랙을 제공합니다.</h3>
						<div style="display: block; margin: 15% 0;">광고 없는 음악 라이브러리에서
							인기 아티스트나 좋아하는 노래를 발견해 보세요.</div>
					</div>
				</div>

				<div class="card-container">
					<div class="card-title">
						<img src="${root}/img/미래도시,비.jpg" alt="사진" />
					</div>
					<div class='card-con'>
						<h3>믹스와 라디오</h3>
						<div style="display: block; margin: 15% 0;">My Mix에서 당신의 취향에
							맞춘 개인화된 플레이리스트를 받아보거나, Artist Radio에서 새로운 음악을 탐험해보세요.</div>
					</div>
				</div>

				<div class="card-container">
					<div class="card-title">
						<img src="${root}/img/미래도시,비.jpg" alt="사진" />
					</div>
					<div class='card-con'>
						<h3>DuckMusic 라이브</h3>
						<div style="display: block; margin: 15% 0;">친구, 가족 또는 다른 팬들과
							함께 실시간으로 음악을 경험해 보세요.</div>
					</div>
				</div>
			</div>
		</section>

		<section id="payment">
		<div id="stars"></div>
		<div id="stars2"></div>
		<div id="stars3"></div>
			<h1 style="position: relative; top: 0; left: 0;"
				data-scroll data-scroll-speed="1">
				<span>광고 없이 무제한 스트리밍!</span> 
				<span style="font-size: 4rem; margin-top: 10px;"> 지금 구독하고 더 자유롭게 음악을 즐겨보세요.</span>
			</h1>
			<div class="pay">
				<div class="by-month">
					<div class="wave"></div>
					<div class="wave"></div>
					<div class="wave"></div>
					<div class="wave"></div>
					<h2 style="position: inherit; z-index: 2;">월간결제</h2>
					<div style="position: inherit; z-index: 2;">Experience
						best-in-class sound quality that opens up every detail with HiRes
						Free Lossless Audio Codec (HiRes FLAC). Best enjoyed on 5G or
						WiFi with a hardware connection.</div>
					<div style="position: inherit; z-index: 2; margin-top: 25px;">9,900원</div>
					<button class="btn">결제하기</button>
				</div>
					<div class="by-year">
					<div class="wave"></div>
					<div class="wave"></div>
					<div class="wave"></div>
					<h2 style="position: inherit; z-index: 2;">연간결제</h2>
					<div style="position: inherit; z-index: 2;">Get the music
						you love on the go without worrying about data. Useful when you
						have a weak signal, are reaching your data cap, or are running
						out of download space.</div>
					<div style="position: inherit; z-index: 2; margin-top: 25px;">99,000원</div>
					<button class="btn">결제하기</button>
				</div>	
		</div>
		<div class="pay" style="margin-bottom: 20px;">
				<div class="by-month">
					<div class="wave"></div>
					<div class="wave"></div>
					<div class="wave"></div>
					<div class="wave"></div>
					<h2 style="position: inherit; z-index: 2;">월간결제</h2>
					<div style="position: inherit; z-index: 2;">Experience
						best-in-class sound quality that opens up every detail with HiRes
						Free Lossless Audio Codec (HiRes FLAC). Best enjoyed on 5G or
						WiFi with a hardware connection.</div>
					<div style="position: inherit; z-index: 2; margin-top: 25px;">9,900원</div>
					<button class="btn">결제하기</button>
				</div>
					<div class="by-year">
					<div class="wave"></div>
					<div class="wave"></div>
					<div class="wave"></div>
					<h2 style="position: inherit; z-index: 2;">연간결제</h2>
					<div style="position: inherit; z-index: 2;">Get the music
						you love on the go without worrying about data. Useful when you
						have a weak signal, are reaching your data cap, or are running
						out of download space.</div>
					<div style="position: inherit; z-index: 2; margin-top: 25px;">99,000원</div>
					<button class="btn">결제하기</button>
				</div>	
		</div>
		
		<footer>
      	<!-- bottom_info.jsp 포함 -->
      	<jsp:include page="/WEB-INF/views/include/bottom_info.jsp" />
   		</footer>
		
		</section>
	</div>
	
	
   
	<script>
   	//1번째 섹션 배경 애니메이션
	new FinisherHeader({
        "count": 12,
        "size": {
          "min": 1300,
          "max": 1500,
          "pulse": 0
        },
        "speed": {
          "x": {
            "min": 3,
            "max": 4.5
          },
          "y": {
            "min": 3,
            "max": 4.5
          }
        },
        "colors": {
          "background": "#000000",
          "particles": [
            "#000000",
            "#e2cd7b",
            "#1e1ace",
            "#ce0e47"
          ]
        },
        "blending": "lighten",
        "opacity": {
          "center": 0.35,
          "edge": 0
        },
        "skew": 0,
        "shapes": [
          "c"
        ]
      });
   
   //수평 스크롤
   gsap.registerPlugin(ScrollTrigger);

   const pageContainer = document.querySelector(".container");

   /* SMOOTH SCROLL */
   const scroller = new LocomotiveScroll({
     el: pageContainer,
     smooth: true
   });

   scroller.on("scroll", ScrollTrigger.update);

   ScrollTrigger.scrollerProxy(pageContainer, {
     scrollTop(value) {
       return arguments.length
         ? scroller.scrollTo(value, 0, 0)
         : scroller.scroll.instance.scroll.y;
     },
     getBoundingClientRect() {
       return {
         left: 0,
         top: 0,
         width: window.innerWidth,
         height: window.innerHeight
       };
     },
     pinType: pageContainer.style.transform ? "transform" : "fixed"
   });

   ////////////////////////////////////
   ////////////////////////////////////
   window.addEventListener("load", function () {
     let pinBoxes = document.querySelectorAll(".pin-wrap > *");
     let pinWrap = document.querySelector(".pin-wrap");
     let pinWrapWidth = pinWrap.offsetWidth;
     let horizontalScrollLength = pinWrapWidth - window.innerWidth;

     // Pinning and horizontal scrolling

     gsap.to(".pin-wrap", {
       scrollTrigger: {
         scroller: pageContainer, //locomotive-scroll
         scrub: true,
         trigger: "#sectionPin",
         pin: true,
         // anticipatePin: 1,
         start: "top top",
         end: pinWrapWidth
       },
       x: -horizontalScrollLength,
       ease: "none"
     });

     ScrollTrigger.addEventListener("refresh", () => scroller.update()); //locomotive-scroll

     ScrollTrigger.refresh();
   });
   

   </script>
</body>
</html>

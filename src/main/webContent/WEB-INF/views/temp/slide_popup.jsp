<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var='root' value="${pageContext.request.contextPath}/" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 옵션</title>
    <link rel="stylesheet" href="${root}/css/popup.css">
</head>
<body>
    <div class="payment-options">
        <label>
            <input type="radio" name="payment" id="monthly" onclick="openPopup('monthly-popup')"> 월간결제
        </label>
        <label>
            <input type="radio" name="payment" id="yearly" onclick="openPopup('yearly-popup')"> 연간결제
        </label>
    </div>

    <div id="monthly-popup" class="popup">
        <div class="popup-section red">
            <h2 align="center" style="margin-bottom: 30px;">선택한 구독 상품</h2>
        </div>
        <div class="popup-section yellow">
            <div class="product-info">
                <div class="product-text">
                    <h3 style="margin-bottom: 9px; margin-left: -10px;">오리궁둥이 월 정기구독</h3>
                    <p style="color: #333; margin: 0; margin-left: -10px;">9,900원/월</p>
                </div>
                <button class="close-button" onclick="closePopup('monthly-popup')" style="margin-left: -10px;">X</button>
            </div>
        </div>
        <div class="popup-section green"></div>
    </div>

    <div id="yearly-popup" class="popup">
        <div class="popup-section red">
            <h2 align="center" style="margin-bottom: 30px;">선택한 구독 상품</h2>
        </div>
        <div class="popup-section yellow">
            <div class="product-info">
                <div class="product-text">
                    <h3 style="margin-bottom: 9px; margin-left: -10px;">오리궁둥이 년 정기구독</h3>
                    <p style="color: #333; margin: 0; margin-left: -10px;">99,000원/년</p>
                </div>
                <button class="close-button" onclick="closePopup('yearly-popup')" style="margin-left: -10px;">X</button>
            </div>
        </div>
        <div class="popup-section green"></div>
    </div>

    <script src="${root}/js/popup.js"></script>
</body>
</html>
 --%>




<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='root' value="${pageContext.request.contextPath}/" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결제 옵션</title>
<link rel="stylesheet" href="${root}/css/popup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
	<h3 class="title">
		<b>오리둥둥이</b> 멤버가 되어보세요
	</h3>





	<div class="btn-group">
		<!-- <button class="mocean-modal-button" data-mocean-type="slide-in-bottom">월간결제</button> -->
		<button class="mocean-modal-button" data-mocean-type="slide-in-bottom"
			data-mocean-out-type="slide-out-top">연간결제</button>
		<!-- 추가된 버튼: 2번 바뀐 모달을 위한 버튼 -->
		<button class="mocean-modal-button" data-mocean-type="slide-in-bottom"
			data-target="#mocean-modal-2">Slide In (2번 바뀐 것)</button>


	</div>





	<div class="mocean-wrap mocean-modal-wrap" id="mocean-modal-wrap">
		<div class="mocean-content mocean-modal" id="mocean-modal">
			<h3>The Mocean Modal</h3>
			<div class="mocean-modal-content">
				<p>Modal content goes here. Customize it as needed.</p>
				<button class="mocean-modal-close">Close me!</button>
			</div>
		</div>
	</div>



	<div class="mocean-wrap mocean-modal-wrap" id="mocean-modal-2">
		<!-- ID 변경 -->
		<div class="mocean-content mocean-modal">
			<h3>2번 바뀐것</h3>
			<div class="mocean-modal-content">
				<p>완도 청산도는 더딘 풍경으로 삶의 쉼표가 되는 섬이다. 푸른 바다와 돌담길, 구들장논, 해녀의 미소 등은
					슬로시티 청산도를 단장하는 주요 매개다.</p>
				<button class="mocean-modal-close">Close me!</button>
			</div>
		</div>
	</div>






	<script src="${root}js/popup.js"></script>
</body>
</html>





























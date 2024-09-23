<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var='root' value='${pageContext.request.contextPath }/' />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/board.css">
<link rel="stylesheet"
	href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css">
<style>
.main-container {
	width: auto;
	height: 600px;
	margin-left: auto;
	margin-right: auto;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<c:import url="/WEB-INF/views/include/sidebar.jsp" />
	<div class="container">
		<div style="font-size: 13px; margin-bottom: 20px;">
			<div>(���� �α������� ����)</div>
		</div>
		<div style="margin-left: 30px">
			<div>
				<span class="custom-select"> <select name="category"
					id="drop-down">
						<option value="" disabled selected style="color: black;">ī�װ�</option>
						<option style="color: #74E885">�����Խ���</option>
						<option style="color: #BC5ADC">�ҽ�/����</option>
						<option style="color: yellow;">���� ��õ</option>
				</select>
				</span> <input
					style="width: 400px; font-size: 16px; padding: 3px 3px; margin-right: 20px;"
					placeholder="����"> <span style="float: right;">
					<button class="write-btn">���</button>
					<button class="write-btn">�ۼ�</button>
				</span>
			</div>
			<div class="main-container">
				<div id="editor">
					<p></p>
				</div>
			</div>
		</div>
	</div>
	<script type="importmap">
        {
            "imports": {
                "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.js",
                "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/43.1.0/"
            }
        }

    </script>
	<script type="module">
        import {
            ClassicEditor,
            Essentials,
            Paragraph,
            Bold,
            Italic,
            Font
        } from 'ckeditor5';
        ClassicEditor
            .create(document.querySelector('#editor'), {
                plugins: [ Essentials, Paragraph, Bold, Italic, Font ],
                toolbar: [
                    'undo', 'redo', '|', 'bold', 'italic', '|',
                    'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor'
                ]
            })
            .then(editor => {
                window.editor = editor;
            })
            .catch(error => {
                console.error(error);
            });
    </script>
</body>
</html>

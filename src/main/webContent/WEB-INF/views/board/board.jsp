<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Board</title>
<style>
* {
	background: black;
	color: white;
}

body {
	background: black;
	display: flex;
	justify-content: center;
	min-height: 100vh; /* ȭ�� ��ü ���̸� ��� */
	margin: 0;
}

.container {
	flex-direction: column; /* ���� �������� ���� */
	width: 80%; /* ���ϴ� �ʺ� ���� */
	max-width: 1200px; /* �ִ� �ʺ� ���� */
	background: black; /* ��� ���� �߰� (���� ����) */
	padding: 20px; /* �е� �߰� */
}

button.c_btn {
	margin: 10px;
	border: none; /* �׵θ� ���� */
	border-radius: 20px; /* �𼭸� �ձ۰� */
	padding: 10px 20px; /* ���� ���� */
	font-weight: bolder;
	font-size: 18px; /* ���� ũ�� */
	cursor: pointer; /* Ŀ�� ��� */
	transition: background-color 0.3s, transform 0.3s; /* ȿ�� ��ȯ */
}

button.c_btn:hover {
	background: white;
	color: black;
}

input {
	border: none;
	border-bottom: 1px solid gray;
	margin-bottom: 10px;
}

input:focus {
	outline: none;
	border-bottom-color: #33FF33;
}

table {
	border-collapse: collapse;
	width: 100%;
}

thead {
	position: relative;
	border-top: 1px solid white;
}

thead th {
	padding: 10px;
}

.on-table {
	display: flex;
}

span {
	margin-left: auto;
	margin-right: 20px;
	margin-bottom: 12px;
}

.write-btn {
	background: #74E885;
	color: black;
	border: none;
	border-radius: 3px;
	padding: 5px 20px;
	font-size: 14px;
	text-decoration: none;
	cursor: pointer;
	transition: background-color 0.3s
}

.write-btn:hover {
	background: #BC5ADC;
}

.pagination {
	display: flex; /* Flexbox�� ����Ͽ� ���� ���� */
	justify-content: center; /* �߾� ���� */
	padding-left: 0; /* �⺻ ���� ���� */
	margin: 0; /* �⺻ ���� ���� */
	margin-top: 10px;
	list-style: none; /* �⺻ ����Ʈ ��Ÿ�� ���� */
}

.pagination .page-item {
	margin: 0 5px; /* ������ �׸� ���� ���� ���� */
	text-decoration: none;
}

.page-link {
text-decoration: none;
}

/* .fixed-section: �������� ���� �ϴܿ� ������ ���� */
.fixed-section {
    position: fixed; /* ������ ��ũ�Ѱ� ������� ȭ�鿡 ������ */
    bottom: 0; /* ȭ�� �ϴܿ� ��ġ */
    right: 0; /* ȭ�� ������ ��ġ */
    margin: 30px 50px; /* ȭ�� �����ڸ��κ��� 16px �Ÿ� ���� */
    z-index: 1000; /* �ٸ� ��ҵ� ���� ǥ�õǵ��� ���� (���� ���ϼ��� ���� ǥ�õ�) */
}

/* .fixed-button: ���� ���� ���� ��ư ��Ÿ�� */
.fixed-button {
    display: block; /* ��� ��ҷ� ���� (flexbox ���� �Ӽ��� ������� ����) */
    width: 65px; /* ��ư�� �ʺ� 40px�� ���� */
    height: 65px; /* ��ư�� ���̸� 40px�� ���� */
    /* 
    background-image: url('path/to/button-image.png');  �̹��� ������ ��� 
    background-size: cover; ��ư ũ�⿡ �°� �̹��� ����
    background-repeat: no-repeat; �̹��� �ݺ� ���� 
    */
    background-color: #007BFF; /* ��ư�� ������ �Ķ������� ���� */
    border: none; /* ��ư�� �׵θ��� ���� */
    border-radius: 50%; /* ��ư�� �������� ���� */
    font-size: 40px;
    cursor: pointer; /* ��ư ���� ���콺�� �÷��� �� �� ����� Ŀ�� ǥ�� */
    outline: none; /* ��ư�� ��Ŀ�� �ƿ������� ���� */
}

/* .fixed-content: ��ư Ŭ�� �� ǥ�õ� ������ ������ */
.fixed-content {
    display: none; /* �⺻������ �������� ���� */
    position: absolute; /* ��ư�� ���� ��ġ�� ��������� ��ġ ���� */
    bottom: 100px; /* ��ư �� 50px �Ÿ����� ���� */
    right: 0; /* ��ư�� ���� ������ ��ġ */
    width: 300px; /* �������� �ʺ� 200px�� ���� */
    background-color: #fff; /* ������ ������ ������� ���� */
    border: 1px solid #ddd; /* ������ �׵θ��� ���� ȸ������ ���� */
    border-radius: 4px; /* �������� �𼭸��� �ձ۰� ���� */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* �������� �׸��ڸ� �߰��Ͽ� ��ü���� �� */
    padding: 10px; /* ������ ���ο� 10px�� ���� �߰� */
}

.fixed-content h3 {
	color: black;
	background: white;
	margin: 10px 5px;
}

.fixed-content p {
    color: black; /* ���� ���� ���� */
    background: white; /* ���� ���� (�ʿ��� ���) */
    margin: 10px 0px; /* �ܶ� ���� ���� ���� */
}

.fixed-content input {
    color: black; /* ���� ���� ���� */
    background: white; /* ���� ���� */
    border: 1px solid gray; /* �׵θ� ���� */
    padding: 5px; /* ���� ���� �߰� */
    width: 100%; /* �Է�â �ʺ� 100%�� ���� */
    box-sizing: border-box; /* �е��� �׵θ��� ������ �ʺ� ���� */
}

</style>
<script>
        function toggleContent() {
            var content = document.querySelector('.fixed-content');
            if (content.style.display === 'block') {
                content.style.display = 'none'; // �̹� ���̸� ����
            } else {
                content.style.display = 'block'; // ������ ������ ǥ��
            }
        }
    </script>
</head>
<body>
	<header>
		<!-- ============ -->
	</header>
	<div class="container">
	
		<h1>Ŀ�´�Ƽ</h1>
		<div>
			<button class="c_btn">��ü</button>
			<button class="c_btn">�����Խ���</button>
			<button class="c_btn">�ҽ�/����</button>
			<button class="c_btn">���� ��õ</button>
			<p></p>
		</div>
		<div class="on-table">
			<input placeholder="search">
			<%-- <form:input path="title"/> --%>
			<span class="right-align"> <a
				href="${root }board/write?board_info_idx=${board_info_idx}"
				class="write-btn">�۾���</a>
			</span>
		</div>
		
			<div>
				<table>
					<thead>
						<tr>
							<th>ī�װ�</th>
							<th>����</th>
							<th>�۾���</th>
							<th>�ۼ���</th>
							<th>���ƿ�</th>
						</tr>
					</thead>
					<tbody align="center">
						<tr>
							<td>�����Խ���</td>
							<td>����1~~~~~~~~~~~~~~~~~</td>
							<td>�۾���1</td>
							<td>2024-09-13</td>
							<td>5</td>
						</tr>
						<tr>
							<td>�ҽ�/����</td>
							<td>����2</td>
							<td>�۾���2</td>
							<td>2024-09-13</td>
							<td>9</td>
						</tr>
						<tr>
							<td>������õ</td>
							<td>����3</td>
							<td>�۾���3</td>
							<td>2024-09-13</td>
							<td>8</td>
						</tr>
						<%-- <c:forEach var='obj' items="${contentList }">
		<tr>
			<td class="text-center d-none d-md-table-cell">${obj.content_idx }</td>
			<td><a href='${root }board/read?board_info_idx=${board_info_idx}&content_idx=${obj.content_idx}&page=${page}'>${obj.content_subject }</a></td>
			<td class="text-center d-none d-md-table-cell">${obj.content_writer_name }</td>
			<td class="text-center d-none d-md-table-cell">${obj.content_date }</td>
		</tr>
		</c:forEach> --%>
					</tbody>
				</table>


			</div>


			<div class="pagination">
				<ul class="pagination justify-content-center">
					<c:choose>

						<c:when test="${pageBean.prevPage <= 0 }">
							<li class="page-item disabled"><a href="#" class="page-link">��</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a
								href="${root }board/main?board_info_idx=${board_info_idx}&page=${pageBean.prevPage}"
								class="page-link">��</a></li>
						</c:otherwise>
					</c:choose>

					<c:forEach var='idx' begin="${pageBean.min }"
						end='${pageBean.max }'>
						<c:choose>
							<c:when test="${idx == pageBean.currentPage }">
								<li class="page-item active"><a
									href="${root }board/main?board_info_idx=${board_info_idx}&page=${idx}"
									class="page-link">${idx+1 }</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a
									href="${root }board/main?board_info_idx=${board_info_idx}&page=${idx}"
									class="page-link">${idx+1 }</a></li>
							</c:otherwise>
						</c:choose>

					</c:forEach>

					<c:choose>

						<c:when test="${pageBean.max >= pageBean.pageCnt }">
							<li class="page-item disabled"><a href="#" class="page-link">��</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a
								href="${root }board/main?board_info_idx=${board_info_idx}&page=${pageBean.nextPage}"
								class="page-link">��</a></li>
						</c:otherwise>
					</c:choose>

				</ul>
			</div>
		
	</div>
	<div class="fixed-section">
        <button class="fixed-button" onclick="toggleContent()">
        +
        </button>
        <div class="fixed-content">
            <h3>�����ϱ�</h3>
            <p>�̸�/�����ּ�/���ǳ���</p>
            <input>
            <button class="write-btn">���� ������</button>
        </div>
    </div>
	<footer>
		<!-- ========== -->
	</footer>
</body>
</html>
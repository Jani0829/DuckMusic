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

button{
	margin: 10px;
    border: none; /* �׵θ� ���� */
    border-radius: 20px; /* �𼭸� �ձ۰� */
    padding: 10px 20px; /* ���� ���� */
    font-weight: bolder;
    font-size: 18px; /* ���� ũ�� */
    cursor: pointer; /* Ŀ�� ��� */
    transition: background-color 0.3s, transform 0.3s; /* ȿ�� ��ȯ */
}

button:hover {
	background: white;
	color: black;
	
}

input{
	border: none;
	border-bottom: 1px solid gray;
	margin-bottom: 10px;
}

input:focus{
	outline: none;
	border-bottom-color: #33FF33;
}

table{
	border-collapse: collapse;
	width: 100%; 
}

thead {
	position: relative;
	border-top: 1px solid white;
}

thead th{
	padding: 10px;
}

.on-table{
	display: flex;
}

span {
    margin-left: auto;
    margin-right: 20px;
    margin-bottom: 12px;
}
.write-btn{
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
</style>
</head>
<body>
<header>
<!-- ============ -->
</header>
<div class="container">
<h1>Ŀ�´�Ƽ</h1>
<div>
<button>��ü</button>
<button>�����Խ���</button>
<button>�ҽ�/����</button>
<button>���� ��õ</button>
<p></p>
</div>
<div class="on-table">
<input placeholder="search"> <%-- <form:input path="title"/> --%>
<span class="right-align">
	<a href="${root }board/write?board_info_idx=${board_info_idx}" class="write-btn">�۾���</a>
</span>
</div>
<div>
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
								<li class="page-item disabled"><a href="#"
									class="page-link">����</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
								<a href="${root }board/main?board_info_idx=${board_info_idx}&page=${pageBean.prevPage}" class="page-link">����</a></li>
							</c:otherwise>
						</c:choose>

						<c:forEach var='idx' begin="${pageBean.min }" end='${pageBean.max }'>
							<c:choose>
								<c:when test="${idx == pageBean.currentPage }">
									<li class="page-item active"><a
										href="${root }board/main?board_info_idx=${board_info_idx}&page=${idx}"
										class="page-link">${idx }</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a
										href="${root }board/main?board_info_idx=${board_info_idx}&page=${idx}"
										class="page-link">${idx }</a></li>
								</c:otherwise>
							</c:choose>

						</c:forEach>

						<c:choose>
						
							<c:when test="${pageBean.max >= pageBean.pageCnt }">
								<li class="page-item disabled"><a href="#"
									class="page-link">����</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a
									href="${root }board/main?board_info_idx=${board_info_idx}&page=${pageBean.nextPage}"
									class="page-link">����</a></li>
							</c:otherwise>
						</c:choose>

					</ul>
				</div>
		</div>
</div>
<footer>
<!-- ========== -->
</footer>
</body>
</html>
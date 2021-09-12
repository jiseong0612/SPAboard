<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>spaRead</title>
<script>
	$(function() {
		$("#list").click(function() {
			listPageAjax();
		});
		$("#modify").click(function() {
			var bno = $("#bno").val();
			let id = $("#id").val();
			let sessionid ='${id}';
			if(id != sessionid){
				alert("권한이 없습니다.");
			}else{
			modifyPageAjax(bno); //여기다가 값 3개를 다 줘야한다.
			}
		});
		function listPageAjax() {
			let params ={
					pageNum:$("#pageNum").val(),
					amount:$("#amount").val(),
					bno :$("#bno").val()
			}
			$.ajax({
				url : "/board/spaList",
				type : "get",
				data :params,
				success : function(result) {
					$("#mainCase").html(result);
				},
			});
		}
		function modifyPageAjax(bnoVal) {
			let params ={
					pageNum:$("#pageNum").val(),
					amount:$("#amount").val(),
					bno :$("#bno").val()
			}
			$.ajax({
				url : "/board/spaModify",
				type : "get",
				data : params,
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		}
	});
</script>
</head>

<body>
	<div id="center">
		<form action="#">
			<input type="hidden" id="bno" name="bno" value='<c:out value="${cri.bno }"/>'>
			<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
			<input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount }"/>'>
			<table border="1" style="text-align: center; width:600px;">
				<caption>spa Read</caption>
				<tr>
					<td>글번호</td>
					<td><input type="text" id="title" name="title"
						value='<c:out value="${board.bno }"/>' disabled></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" id="title" name="title"
						value='<c:out value="${board.title }"/>' disabled></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" id="id" name="id"
						value='<c:out value="${board.id }"/>' disabled></td>
				</tr>
				<tr>
					<td colspan="2">
					<pre><c:out value="${board.content }"/></pre>
					</td>
				</tr>
			</table>
			<div>
				<button type="button" id="modify">수정</button>
				<button type="button" id="list">목록</button>
			</div>
		</form>
	</div>

</body>

</html>
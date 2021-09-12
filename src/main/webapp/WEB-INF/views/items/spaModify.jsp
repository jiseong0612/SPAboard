<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>spaModify</title>
<script>
	$(function() {
		$("#modify").click(function() {
			modifyAjax();
		});
		$("#delete").click(function() {
			let con = confirm("정말 삭제하시겠습니까");
			if (con == true) {
				deleteAjax();
			} else {
				return false;
			}
		});
		function deleteAjax() {
			var bnoVal = $("#bno").val();
			$.ajax({
				url : "/board/spaDelete",
				type : "post",
				data : {
					bno : bnoVal
				},
				success : function() {
					$.ajax({
						url:"board/spaList",
						success:function(result){
							$("#mainCase").html(result);
						}
					});
				
				}
			});
		}
		function modifyAjax() {
			
			var params = $("form").serialize();
			
			$.ajax({
				url : "/board/spaModify",
				type : "post",
				data : params,
				success : function(result) {
					alert("수정 성공!");
					listPageAjax();
				}
			});
		}
		$("#list").click(function() {
			listPageAjax();
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
	});
</script>
</head>
<body>
	<div id="center">
		<form action="#">
			<input type="hidden" id="bno" name="bno" value='<c:out value="${cri.bno }"/>'>
			<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
			<input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount }"/>'>
			<table border="1" style="text-align: center; width: 600px;">
				<caption>spa Modify</caption>
				<tr>
					<td>글번호</td>
					<td><input type="text" id="title" name="title"
						value=<c:out value="${board.bno }"/> disabled></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" id="title" name="title"
						value='<c:out value="${board.title }"/>'></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" id="id" name="id"
						value='<c:out value="${board.id }"/>' disabled></td>
				</tr>
				<tr>
				<tr>
					<td colspan="2"><textarea id="content" name="content"
							cols="80" rows="10"><c:out value="${board.content }" /></textarea></td>
				</tr>
				</tr>
			</table>
			<div>
				<button type="button" id="modify">수정</button>
				<button type="button" id="list">목록</button>
				<button type="button" id="delete">삭제</button>
			</div>
		</form>
	</div>
</body>

</html>
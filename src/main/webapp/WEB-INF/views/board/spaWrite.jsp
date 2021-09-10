<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>spaWrite</title>
<script>
	$(function() {
		$("#writeBtn").click(function() {
			boardWriteCheck();
		});

		function writeAjax() {
			var params = $("#spaBoardForm").serialize();
			$.ajax({
				url : "/board/spaWrite",
				type : "post",
				data : params,
				success : function(data) {
					listPageAjax();
				},
				error : function(e) {
					alert("ajax통신 실패!!!");
					console.log(e);
				}
			});
		};
		$("#list").click(function() {
			listPageAjax();
		});
		function listPageAjax() {
			$.ajax({
				url : "/board/spaList",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		}
		function boardWriteCheck() {
			if ($.trim($("#title").val()) == "") {
				alert("제목을 입력해 주세요!");
				$("#title").focus();
				return false;
			}
			if ($.trim($("#content").val()) == "") {
				alert("내용을 입력해 주세요!");
				$("#content").focus();
				return false;
			}
			writeAjax();
		}
		
	});
</script>
</head>

<body>
	<div id="spaWriteBox">
		<div id="center">
			<form id="spaBoardForm">
				<input type="hidden" name="boardId" value="<c:out value="${id}"/>">
				<table border="1" style="text-align: center; width: 600px;">
					<caption>spa Write</caption>
					<tr>
						<td>제목</td>
						<td><input type="text" id="title" name="title"
							placeholder="제목을 입력해 주세요"></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td><input type="text" id="boardId" name="boardId"
							value='<c:out value="${id}"/>' disabled></td>
					</tr>
					<tr>
						<td colspan="2"><textarea id="content" name="content"
								cols="80" rows="10"></textarea></td>
					</tr>
				</table>
				<div></div>
			</form>
			<form>
				<button type="button" id="writeBtn">작성</button>
				<button type="button" id="list">목록</button>
			</form>
		</div>
	</div>
</body>

</html>
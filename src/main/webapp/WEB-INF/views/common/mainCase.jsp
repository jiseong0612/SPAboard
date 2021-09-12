<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainCase</title>
<script>
	$(function() {
		const listPageAjax = function() {
			$.ajax({
				url : "/board/spaList",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		}

		$("#cancle").click(function() {
			console.log("test")
		});

		listPageAjax();

		$("#boardwriteBtn").click(function() {
			boardWriteCheck();
		});
	});
</script>
</head>
<body>
	<div id="mainCase"></div>
</body>
</html>
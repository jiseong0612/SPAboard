<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainCase</title>
<script>
	$(function() {
		function listPageAjax() {
			$.ajax({
				url : "/board/spaList",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		}
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
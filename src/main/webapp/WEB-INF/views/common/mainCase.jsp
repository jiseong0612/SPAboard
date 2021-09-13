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
			console.log("mainCase.jsp...............")
			$.ajax({
				url : "/board/spaList",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				},
				error:function(request,status,error){
			        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			       }
			});
		}
		
		listPageAjax();
		
		$("#cancle").click(function() {
			console.log("test")
		});

	

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
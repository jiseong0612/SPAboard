<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<script>
	$(function() {
	/* 	const listPageAjax = () =>{
			$.ajax({
				url : "/board/spaList",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		} */
		$("#cancle").click(function() {
			listPageAjax();
		});
		$("#cancle2").click(function() {
			console.log("test")
		});
		const signUpPageAjax =()=>{
			$.ajax({
				url : "/user/signUp",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		}
		$("#signUpBtn").click(function() {

			signUpPageAjax();
		});

		$("#logInBtn").click(function() {
			logInCheck();
		});

		//로그인유효성 검사
		$("#id").keyup(function() {
			var koreanRegEx = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			let idVal = $("#id").val();

			if (koreanRegEx.test(idVal) == true) {
				alert("아이디는 영숫자 사용가능")
				$("#id").val("");
				return false;
			}
		});
		//유효성검사
		var koreanRegEx = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		var regExPasswd = /^.*(?=^.{4,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		//아이디 중복 검사
		$("#lgId").keyup(function() {
			let idVal = $("#lgId").val();
			if (koreanRegEx.test(idVal) == true) {
				alert("아이디는 영어, 숫자만 사용가능합니다!")
				$("#lgId").val("");
				return false;
			}
		});
		function logInCheck() {
			if ($.trim($("#lgId").val()) == "") {
				alert("아이디를 입력해 주세요!");
				$("#lgId").focus();
				return false;
			}
			if ($.trim($("#lgPasswd").val()) == "") {
				alert("비밀번호를 입력해 주세요!");
				$("#lgPasswd").focus();
				return false;
			}
			if (!regExPasswd.test($("input[id='lgPasswd']").val())) {
				alert("비밀번호에 특수문자, 문자, 숫자를 포함 하세요!");
				$("#lgPasswd").focus();
				return false;
			}
			logInAjax();
		}//로그인유효성끝
		//로그인 아작스
		function logInAjax() {
			var params = $("#loginForm").serialize();
			$.ajax({
				url : "/user/logIn",
				type : "post",
				data : params,
				success : function(data) {
					alert("로그인 성공!");
					listPageAjax();
				},
				error : function(e) {
					alert("아이디 또는 비밀번호를 확인하새요!");
					$("#lgId").focus();
					$("#lgPasswd").val("");
					console.log(e);
				}
			});
		}
	})
</script>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>logIn</title>
</head>
<body>
	<div id="logInBox">
		<div id="center">
			<form method="post" id="loginForm">
				<table border="1" style="text-align: center; width: 500px;">
					<caption>logIn</caption>
					<tr>
						<td>아이디</td>
						<td><input type="text" id="lgId" name="lgId"
							placeholder="아이디를 입력해주세요"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" id="lgPasswd" name="lgPasswd"
							placeholder="비밀번호를 입력해주세요"></td>
					</tr>
				</table>
				<div>
					<div>
						<button type="button" id="logInBtn">로그인</button>
						<button type="button" id="cancle2">취소</button>
						<button type="button" id="signUpBtn">회원가입</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>

</html>
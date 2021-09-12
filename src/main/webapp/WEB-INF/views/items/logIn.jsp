<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<script>
$(function() {
	//얼럿
	const divAlert= function(msg){
		let msgs = msg;
			$("#divAlert").html(msgs); //` ${msgs}` 사용이 안된다;
			$("#divAlert").fadeOut(1500);
			$("#divAlert").show();
			return false;
		}
	//리스트 페이지 이동
	const listPageAjax = function(){
			$.ajax({
				url : "/board/spaList",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		} 
	//회원가입 페이지 이동
	const signUpPageAjax =function(){
		$.ajax({
			url : "/user/signUp",
			type : "get",
			success : function(result) {
				$("#mainCase").html(result);
			}
		});
	}
	//로그인 버튼 클릭
	$("#logInBtn").click(function() {
		//유효성 검사
		logInCheck();
	});
	//취소 버튼 클릭
	$("#cancle").click(function() {
		listPageAjax();
	});
	//회원가입 버튼 클릭
	$("#signUpBtn").click(function() {
		signUpPageAjax();
	});
	

	//유효성 검사
	const koreanRegEx = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	const regExPasswd = /^.*(?=^.{4,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	
	//아이디 중복 검사
	$("#lgId").keyup(function() {
		let idVal = $("#lgId").val();
		if (koreanRegEx.test(idVal) == true) {
			divAlert("아이디는 영어, 숫자만 사용가능합니다!");
			$("#lgId").val("");
			return false;
		}
	});
	
	//로그인 유효성
	const logInCheck=function(){
		if ($.trim($("#lgId").val()) == "") {
			divAlert("아이디를 입력해 주세요!");
			$("#lgId").focus();
			return false;
		}
		if ($.trim($("#lgPasswd").val()) == "") {
			divAlert("비밀번호를 입력해 주세요!");
			$("#lgPasswd").focus();
			return false;
		}
		if (!regExPasswd.test($("input[id='lgPasswd']").val())) {
			
			divAlert("비밀번호에 특수문자, 문자, 숫자를 포함 하세요!");
			$("#lgPasswd").focus();
			return false;
		}
		//로그인 성공 아작스
		logInAjax();
	}
	//로그인 성공 아작스
	const logInAjax= function() {
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
				divAlert("아이디 또는 비밀번호를 확인하세요");
				$("#lgId").focus();
				$("#lgPasswd").val("");
				console.log(e);
			}
		});
	}
	
})
</script>
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
						<button type="button" id="cancle">취소</button>
						<button type="button" id="signUpBtn">회원가입</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div id="divAlert"></div>
</body>

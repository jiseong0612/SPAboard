$(function() {
	//글작성유효성 검사
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
		boardWriteAjax();
	}//글작성유효성 끝

	//로그인유효성 검사
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
		logInAjax();
	}//로그인유효성끝
	//회원가입유효성 검사
	function signUpCheck() {
		if ($.trim($("#id").val()) == "") {
			alert("아이디를 입력해 주세요!");
			$("#id").focus();
			return false;
		}
		if ($.trim($("#phnum").val()) == "") {
			alert("휴대폰 번호를 입력해 주세요!");
			$("#phnum").focus();
			return false;
		}

		if ($.trim($("#email").val()) == "") {
			alert("메일을 입력해 주세요!");
			$("#email").focus();
			return false;
		}

		if ($.trim($("#passwd").val()) == "") {
			alert("비밀번호를 입력해 주세요!");
			$("#passwd").focus();
			return false;
		}
		if ($.trim($("#passwdChk").val()) == "") {
			alert("비밀번호확인을 입력해 주세요!");
			$("#passwdChk").focus();
			return false;
		}
		if ($.trim($("#passwd").val()) != $.trim($("#passwdChk").val())) {
			alert("비번이 다릅니다!");
			$("#M_PASSWD").val("");
			$("#M_PASSWD2").val("");
			$("#M_PASSWD").focus();
			return false;
		}
		signAjax();
	}//회원가입 유효성 끝

});
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<script>
	$(function() {
		
		//얼럿
		const divAlert=function(msg){
			let msgs = msg;
				$("#divAlert").html(msgs); //` ${msgs}` 사용이 안된다;
				$("#divAlert").fadeOut(1500);
				$("#divAlert").show();
				return false;
			}
		
		let flag = false;
		const id = $("#id").val();
		function listPageAjax() {
			$.ajax({
				url : "/board/spaList",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		}
		const logInPageAjax= function(){
			$.ajax({
				url : "/user/logIn",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		}
		$("#cancle").click(function() {
			listPageAjax();
		});

		$("#signUpJnBtn").on("click", function() {
			signUpCheck();
		});

		//아이디 중복 검사
		$("#id").keyup(function() {
			let ids = $("#id").val().length;
			let idVal = $("#id").val();

			if (koreanRegEx.test(idVal) == true) {
				divAlert("아이디는 영어, 숫자만 사용가능합니다!");
				$("#id").val("");
				return false;
			}
			if (ids > 4) {
				$("#idDiv").show();
				$.ajax({
					url : "/user/idDup",
					type : "post",
					data : {
						id : idVal
					},
					success : function(result) {

						if (result === 0) {
							$("#idDiv").text("사용가능").css("color", "green");
							flag = true;
						} else {
							$("#idDiv").text("아이디중복").css("color", "red");
							$("#id").focus();
							return false;
						}
					},
				});//아작스 끝
			} else {
				$("#idDiv").hide();
			}
		})

		//회원가입유효성 검사
		var koreanRegEx = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		var regExId = /^ [a-zA-Z0-9]{4,20}$/;
		var regExPhNum = /^01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/
		var regExPasswd = /^.*(?=^.{4,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		var regExEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[com|net]{3}$/i;

		const autoHypenPhone=function(str) {
			str = str.replace(/[^0-9]/g, '');
			var tmp = '';
			if (str.length < 4) {
				return str;
			} else if (str.length < 7) {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3);
				return tmp;
			} else if (str.length < 11) {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3, 3);
				tmp += '-';
				tmp += str.substr(6);
				return tmp;
			} else {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3, 4);
				tmp += '-';
				tmp += str.substr(7);
				return tmp;
			}
			return str;
		}

		let cellPhone = document.getElementById('phnum');
		cellPhone.onkeyup = function(event) {
			event = event || window.event;
			let _val = this.value.trim();
			this.value = autoHypenPhone(_val);
		}
		const signUpCheck= function(){
			//아이디 중복검사
			if ($.trim($("#id").val()) == "") {
				divAlert("아이디를 입력해 주세요!");
				$("#id").focus();
				return false;
			}
			if (($.trim($("#id").val()).length <= 4)
					|| ($.trim($("#id").val()).length >= 20)) {
				divAlert("아이디를 4~20자 사이로 입력해 주세요!");
				$("#id").focus();
				return false;
			}
			if ($.trim($("#phnum").val()) == "") {
				divAlert("휴대폰 번호를 입력해 주세요!");
				$("#phnum").focus();
				return false;
			}
			if (!regExPhNum.test($("input[id='phnum']").val())) {
				divAlert("올바른 휴대번호를 입력하세요!");
				$("#phnum").focus();
				return false;
			}

			if ($.trim($("#email").val()) == "") {
				divAlert("메일을 입력해 주세요!");
				$("#email").focus();
				return false;
			}

			if (!regExEmail.test($("input[id='email']").val())) {
				divAlert("이메일을 입력해 주세요!");
				$("#email").focus();
				return false;
			}
			
			if ($.trim($("#passwd").val()) == "") {
				divAlert("비밀번호를 입력해 주세요!");
				$("#passwd").focus();
				return false;
			}
			if ($.trim($("#passwdChk").val()) == "") {
				divAlert("비밀번호확인을 입력해 주세요!");
				$("#passwdChk").focus();
				return false;
			}
			if ($.trim($("#passwd").val()) != $.trim($("#passwdChk").val())) {
				divAlert("비번이 다릅니다!");
				$("#passwd").val("");
				$("#passwdChk").val("");
				$("#passwd").focus();
				return false;
			}
			if (!regExPasswd.test($("input[id='passwd']").val())) {
				divAlert("비밀번호에 특수문자, 문자, 숫자를 포함 하세요!");
				$("#passwd").focus();
				return false;
			}
			if (flag == true) {
				signAjax();
			}
		}//회원가입 유효성 끝

		//회원가입 아작스
		const signAjax=function() {
			var params = $("#signUpForm").serialize();
			$.ajax({
				url : "/user/signUp",
				type : "post",
				data : params,
				success : function(data) {
					alert("회원가입 성공");
					logInPageAjax();
				},
				error : function(e) {
					divAlert("회원가입 실패");
					$("#id").focus();

				}
			});
		}
		;//회원가입 아작스끝
	});
</script>
<body>
	<div id="signUpBox">
		<div id="center">
			<form id="signUpForm" method="post">
				<table border="1" style="text-align: center; width: 500px;">
					<caption>signUp</caption>
					<tr>
						<td>아이디</td>
						<td>
							<input type="text" id="id" name="id" placeholder="아이디를 입력해주세요" autofocus="autofocus">
							<div class="error_next_box" id="id"  aria-live="assertive">필수 정보입니다.</div>
							<div class="error_next_box" id="id"  aria-live="assertive">아이디는 영어, 숫자만 사용가능합니다</div>
							<div class="error_next_box" id="id"  aria-live="assertive">필수 정보입니다.</div>
							<div class="error_next_box" id="id"  aria-live="assertive">필수 정보입니다.</div>
						</td>
							
					</tr>
					<tr>
						<td>휴대번호</td>
						<td><input type="text" id="phnum" name="phnum"
							placeholder="010-0000-0000" maxlength="13"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="email" id="email" name="email" placeholder="_______@______"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" id="passwd" name="passwd"
							placeholder="비번을 입력해주세요"></td>
					</tr>
					<tr>
						<td>비밀번호확인</td>
						<td><input type="password" id="passwdChk" name="passwdChk"
							placeholder="비번확인을 해주세요"></td>
					</tr>
				</table>
				<div>
					<button type="button" id="signUpJnBtn">가입</button>
					<button type="button" id="cancle">취소</button>
				</div>
			</form>
		</div>
	</div>
		<div id="divAlert"></div>
</body>
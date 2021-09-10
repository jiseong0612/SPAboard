$(function() {

	//메인
	//메인 리스트화면 이동
	goSpaList();
	function goSpaList() {
		$("#spaListBox").show();
		$("#logInBox").hide();
		$("#signUpBox").hide();
		$("#spaWriteBox").hide();
	}
	function hideAll() {
		$("#spaListBox").hide();
		$("#logInBox").hide();
		$("#signUpBox").hide();
		$("#spaWriteBox").hide();
	}

	//회원가입
	//회원가입 화면 이동
	$(".signUpBtn").click(function() {
		$("#signUpBox").show();
		$("#spaListBox").hide();
		$("#logInBox").hide();
	})
	//회원가입 버튼클릭
	$("#signUpJnBtn").on("click", function() {
		signUpCheck();
	});

	//로그인
	//로그인 화면 이동
	$("#logInBtn").click(function() {
		hideAll();
		$("#logInBox").show();
	});
	//로그인 버튼 클릭
	$("#logInJnBtn").click(function() {
		logInCheck();
	});

	//로그아웃 버튼 클릭
	$("#userLogOutBtn").click(function() {
		$.ajax({
			url: "/user/logOut",
			success: function(result) {
				alert("로그아웃 되었습니다.");
				location.reload(true); //화면을 새로고침하여 url변경을 막음;
			}
		});
		/* location.href="/user/logOut";
		alert("로그아웃 되었습니다."); */
	});//로그아웃 끝

	//취소, 목록버튼
	$(".goList").click(function() {
		goSpaList()
	});

	//글작성 버튼 클릭
	$("#boardwriteBtn").click(function() {
		boardWriteCheck();
	});

	//리스트의 작성버튼 클릭 화면이동
	$("#boardWriteBtn").click(function() {
		var id = "<c:out value='${id}'/>";
		hideAll();
		//비로그인 상태일 경우
		if (id === "") {
			console.log("Null");
			$("#logInBox").show();
			//로그인 상태일경우
		} else {
			console.log("<c:out value='${id}'/>");
			$("#spaWriteBox").show();
		}
	});

});
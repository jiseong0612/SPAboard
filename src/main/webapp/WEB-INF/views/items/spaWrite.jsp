<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<script>
	$(function() {
		
		//얼럿
		const divAlert=(msg)=>{
			let msgs = msg;
				$("#divAlert").css("background-color","red").css("color","white");
				$("#divAlert").html(msgs); //` ${msgs}` 사용이 안된다;
				$("#divAlert").fadeOut(1500);
				$("#divAlert").show();
				return false;
			}
		
		
		$("#writeBtn").click(function() {
			boardWriteCheck();
		});

		const writeAjax= function() {
			var params = $("#spaBoardForm").serialize();
			$.ajax({
				url : "/board/spaWrite",
				type : "post",
				data : params,
				success : function(data) {
					listPageAjax();
				},
				error : function(e) {
					divAlert("ajax통신 실패!!!");
					console.log(e);
				}
			});
		};
		$("#list").click(function() {
			listPageAjax();
		});
		const listPageAjax= function() {
			$.ajax({
				url : "/board/spaList",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		}
		const boardWriteCheck= function() {
			if ($.trim($("#title").val()) == "") {
				divAlert("제목을 입력해 주세요!");
				$("#title").focus();
				return false;
			}
			if(($("#title").val()).length > 10){
				divAlert("너무 길다");
				$("#title").val("");
				return false;
			}
			if ($.trim($("#content").val()) == "") {
				divAlert("내용을 입력해 주세요!");
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
	<div id="divAlert"></div>
</body>

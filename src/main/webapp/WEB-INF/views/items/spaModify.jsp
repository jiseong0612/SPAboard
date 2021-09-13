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
		const listPageAjax =function() {
			let params ={
					pageNum:$("#pageNum").val(),
					amount:$("#amount").val(),
					bno :$("#bno").val()
			}
			$.ajax({
				url : "/board/spaList",
				type : "get",
				data :params,
				success : function(result) {
					$("#mainCase").html(result);
				},
			});
		}
		const modifyAjax= function() {
			var params = $("form").serialize();
			$.ajax({
				url : "/board/spaModify",
				type : "post",
				data : params,
				success : function(result) {
					if(result ==='0'){
						divAlert("삭제에 실패하였습니다.");
						return false;
					}else{
					listPageAjax();
					}
				}
			});
		}
		//수정 버튼 클릭
		$("#modify").click(function() {
			modifyAjax();
		});
		
		//삭제 버튼 클릭
		$("#delete").click(function() {
			let con = confirm("정말 삭제하시겠습니까");
			if (con == true) {
				let bno = '${board.bno}';
		 		$.ajax({
					url:"/board/spaRemove",
					data : {bno :"${board.bno }" },
					type:"post",
					success:function(result){
						if(result==='1'){
							$.ajax({
								url : "/board/spaList",
								type : "get",
								data :bno,
								success : function(result) {
									$("#mainCase").html(result);
								},
							});
						}else{
							return false;
						}
					}
				}); 	
			} else { //confirm :no
				return false;
			}
		});
		$("#list").click(function() {
			listPageAjax();
		});
	});
</script>
</head>
<body>
	<div id="center">
		<form action="#">
			<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno }"/>'>
			<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
			<input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount }"/>'>
			<table border="1" style="text-align: center; width: 600px;">
				<caption>spa Modify</caption>
				<tr>
					<td>글번호</td>
					<td><input type="text" id="title" name="title"
						value=<c:out value="${board.bno }"/> disabled></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" id="title" name="title"
						value='<c:out value="${board.title }"/>'></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" id="id" name="id"
						value='<c:out value="${board.id }"/>' disabled></td>
				</tr>
				<tr>
				<tr>
					<td colspan="2"><textarea id="content" name="content"
							cols="80" rows="10"><c:out value="${board.content }" /></textarea></td>
				</tr>
				</tr>
			</table>
			<div>
				<button type="button" id="modify">수정</button>
				<button type="button" id="list">목록</button>
				<button type="button" id="delete">삭제</button>
			</div>
		</form>
	</div>
	<div id="divAlert"></div>
</body>

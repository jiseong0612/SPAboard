<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

</head>

<body>
	<div id="center">
		<table border="1" style="text-align: center; width: 600px;">
			<caption>spa Read</caption>
			<tr>
				<td>글번호</td>
				<td><input type="text" id="bno" name="bno" value='<c:out value="${board.bno }"/>' disabled></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" id="title" name="title" value='<c:out value="${board.title }"/>' disabled></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" id="id" name="id" value='<c:out value="${board.id }"/>' disabled></td>
			</tr>
			<tr>
				<td colspan="2"><pre><c:out value="${board.content }" /></pre></td>
			</tr>
			<tr>
				<c:if test="${empty before }">
					<td>이전글</td><td class="lastContent">마지막 글입니다</td>
				</c:if>
				<c:if test="${not empty before	 }">
					<td>이전글</td><td><a class="swift-link" href="${before.bno }">${before.title }</a></td>
				</c:if>
			</tr>
			<tr>
				<c:if test="${empty after }">
					<td>다음글</td><td class="lastContent">마지막 글입니다</td>
				</c:if>
				<c:if test="${not empty after }">
					<td>다음글</td><td><a class="swift-link"href="${before.bno }">${after.title }</a></td>
				</c:if>
			</tr>
			<script>
				let swiftLink = $(this).attr("class","swift-link").attr("href");
				console.log(swiftLink);
			</script>
			
			
		</table>
		<form id="actionForm">
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" value="${cri.amount }"> 
			<input type="hidden" name="bno" value="${board.bno}"> 
			<input type="hidden" name="type" value="${cri.type}"> 
			<input type="hidden" name="keyword" value="${cri.keyword}">
			<input type="hidden" name="id" value="${id }">
		</form>
		<div>
			<button type="button" id="modify">수정</button>
			<button type="button" id="list">목록</button>
		</div>
		<script>
			$(function() {
				//얼럿
				const divAlert = function(msg) {
					let msgs = msg;
					$("#divAlert").html(msgs); //` ${msgs}` 사용이 안된다;
					$("#divAlert").fadeOut(1500);
					$("#divAlert").show();
					return false;
				}

				$("#list").click(function(e) {
					e.preventDefault();
					let params = $("#actionForm").serialize();
					$.ajax({
						url : "/board/spaList",
						type : "get",
						data : params,
						success : function(result) {
							$("#mainCase").html(result);
						},
					});
				});

				$("#modify").click(function(e) {
					e.preventDefault();
					if ('${id }' != '${board.id}') {
						divAlert("권한이 없습니다.");
						return false;
					}
					let params = $("#actionForm").serialize();
					console.log(params);
					 $.ajax({
						url : "/board/spaModify",
						type : "get",
						data : params,
						success : function(result) {
							$("#mainCase").html(result);
						},
					}); 
				});
			});
		</script>
	</div>
	<div id="divAlert"></div>
</body>

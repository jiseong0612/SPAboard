
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>

</head>
<body>
	<div id="spaListBox">
		<div id="center">
			<table border="1" style="text-align: center; width: 600px;">
				<caption>spa List</caption>
				<caption>
					<div id="headLine">
						<c:if test="${empty id }">
							<div>
								<a href="#" id="logInBtn">login</a> <a href="#" id="signUpBtn">signUp</a>
							</div>
						
							<div>
								<span>로그인 해주세요</span>
							</div>
						</c:if>
						<c:if test="${not empty id }">
							<div>
								<a href="#" id="userLogOutBtn">logOut</a>
							</div>
							<div>
								<span><c:out value="${id } 님" /></span>
							</div>
						</c:if>
					</div>
				</caption>
				<thead>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>조회수</td>
						<td>등록일</td>
						<td>수정일</td>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list }">
						<tr>
							<td colspan="6" style="color: red;">작성된 글이 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty list }">
						<c:forEach var="board" items="${list}">
							<tr>
								<td><c:out value="${board.bno}" /></td>
								<td><a class="move" href="${board.bno }"
									bno="${board.bno }"> <c:out value="${board.title}" />
								</a></td>
								<td><c:out value="${board.id}" /></td>
								<td><c:out value="${board.views}" /></td>
								<td><fmt:formatDate value="${board.regdate}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td><fmt:formatDate value="${board.updateDate}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
							</tr>
						</c:forEach>
					</c:if>

				</tbody>
			</table>
				<div>
				 <form id="searchForm" action="#" method="get">
                 	<input type="hidden" name="type" value="TCW">
                 	<input type="text" name="keyword" value="${pageMaker.cri.keyword }">
                 	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
             		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                 	<button class="btn btn-default">search</button>
                 </form>
				</div>
			<div id="pagination">
				<div>
					<div id="pagingDiv">
						<c:if test="${pageMaker.prev}">
							<a class="page-link" href="${pageMaker.startPage - 1 }">이전</a>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage}"
							end="${pageMaker.endPage }">
				&nbsp;
				<span class="paginate_button"${pageMaker.cri.pageNum == num ? 'style=" background-color: lemonchiffon; border-radius: 45px;':""} ">
								<a href="${num }" class="page-link">${num }</a>
							</span>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<a class="page-link" href="${pageMaker.endPage + 1 }">다음</a>
						</c:if>
					</div>
					   <form id="actionForm" method="get" >
                       		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                        	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                        	<input type="hidden" name="type" value="TCW">
                 			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
                        </form>
					<script>
						$(function() {
							//리스트 화면 이동
							const listPageAjax = function(params) {
								$.ajax({
									url : "/board/spaList",
									type : "get",
									data : params,
									success : function(result) {
										$("#mainCase").html(result);
									},
									error : function(request, status, error) {
										console.log("code:" + request.status
												+ "\n" + "message:"
												+ request.responseText + "\n"
												+ "error:" + error);
									}
								});
							}
							//페이지 번호 이동
							var actionForm=$("#actionForm");
								$(".page-link").on("click",function(e){
									e.preventDefault();
									var targetPage = $(this).attr("href");
									actionForm.find('input[name="pageNum"]').val(targetPage);
									let params = actionForm.serialize();
									listPageAjax(params);
								});
							//글상세 이동
							$(".move") .on( "click", function(e) {
												e.preventDefault();
												let targetBno = $(this).attr(
														"href");
												actionForm
														.append("<input type='hidden' name='bno' value='"+targetBno+"'>");
												actionForm.attr("action",
														"/board/get");
												let params = actionForm
														.serialize();

												$.ajax({
													url : "/board/spaRead",
													data : params,
													success : function(result) {
														$("#mainCase").html(
																result);
													}
												});
												console.log(params);
											});

							//로그인 버튼 클릭, 비회원 글작성 버튼 클릭시
							const logInPageAjax = function() {
								$.ajax({
									url : "/user/logIn",
									type : "get",
									success : function(result) {
										$("#mainCase").html(result);
									}
								});
							}
							$("#logInBtn").click(function(e) {
								e.preventDefault();
								logInPageAjax();
							});
							$("#signUpBtn").click(function(e) {
								e.preventDefault();
								$.ajax({
									url : "/user/signUp",
									type : "get",
									success : function(result) {
										$("#mainCase").html(result);
									}
								});

								signUpPageAjax();
							});
							$("#boardWriteBtn").click(function(e) {
								e.preventDefault();
								let id = "${id}";
								if (id == "") {
									//로그인 페이지로 이동
									logInPageAjax();
								} else {
									//글작성 페이지로 이동
									$.ajax({
										url : "/board/spaWrite",
										type : "get",
										success : function(result) {
											$("#mainCase").html(result);
										},
									});
								}
							});
							$("#userLogOutBtn").click(function(e) {
								e.preventDefault();
								//로그아웃.
								$.ajax({
									url:"/user/logOut",
									type:"get",
									success:function(result){
										$("#mainCase").html(result);
									}
								});
	
							})
							$("#searchForm button").on("click",function(e){
								e.preventDefault();
								let params = $("#searchForm").serialize();
								listPageAjax(params);
							});
						});
					</script>
				</div>
			</div>
			<div>
				<button type="button" id="boardWriteBtn">글작성</button>
			</div>
		</div>
	</div>
</body>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<script>
$(function(){
$(document).ready(function(){
		//페이지 번호 이동 아작스
		$('#pagingDiv a').click(function(e){
			e.preventDefault();
			$('#pageNum').val($(this).attr("href"));
			let pageNum = $(this).attr("href");
			let amount = 10; // 임의로 10을 준다.
			let params ={pageNum: pageNum , amount :amount};
			$.ajax({
				url:"/board/spaList",
				data : params,
				type : "get",
				success:function(result){
					$("#mainCase").html(result);
				},
			});
		});
		
		//게시글에 pageNum, amount, bno넘기기
		$(".titles").click(function(e) {
			e.preventDefault();
			let bnoVal = $(this).attr('bno');
			let pageNum =${paging.cri.pageNum }; //일단 1줌
			let amount = ${paging.cri.amount }; // 임의로 10을 준다.
			let params ={pageNum: pageNum , amount :amount, bno : bnoVal};
			//제목눌렀을때 글상세 아작스.
			$.ajax({
				url : "/board/spaRead",
				type : "get",
				data : params,
				success : function(result) {
					$("#mainCase").html(result);
				},
			});
		});
	});
});




	$(function() {
		const listPageAjax= function() {
			$.ajax({
				url : "/board/spaList",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		}
		$("#userLogOutBtn").click(function() {
			logOutPageAjax();
		});
		$("#logInBtn").click(function() {
			logInPageAjax();
		});
		$("#boardWriteBtn").click(function() {
			let id = "${id}";
			if (id == "") {
				logInPageAjax();
			} else {
				spaWritePageAjax();
			}
		});
		$("#signUpBtn").click(function() {
			signUpPageAjax();
		});
		const logInPageAjax= function() {
			$.ajax({
				url : "/user/logIn",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		}
		const spaWritePageAjax= function() {
			$.ajax({
				url : "/board/spaWrite",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		}
		const logOutPageAjax= function() {
			$.ajax({
				url : "/user/logOut",
				type : "get",
				success : function(result) {
					alert("로그아웃 되었습니다");
					listPageAjax();
				}
			});
		}

		const signUpPageAjax= function() {
			$.ajax({
				url : "/user/signUp",
				type : "get",
				success : function(result) {
					$("#mainCase").html(result);
				}
			});
		}
	})
</script>
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
								<button type="button" id="logInBtn">login</button>
								<button type="button" id='signUpBtn'>signUp</button>
							</div>
							<!-- <div>
								<select name="condition">
									<option>
										작성자
									</option>
									<option>
										제목
									</option>
									<option>
										내용
									</option>
									<option>
										작성자+제목
									</option>
								</select>
								<input type="text" id="searchVal" name="searchVal">
								<button type="button" id="searchBtn">검색</button>
							</div> -->
							<div>
								<span>로그인 해주세요</span>
							</div>
						</c:if>
						<c:if test="${not empty id }">
							<div>
								<button id="userLogOutBtn">logOut</button>
							</div>
							<div>
								<span><c:out value="${id } 님" /></span>
							</div>
						</c:if>
					</div>
				</caption>
				<thead>
					<tr id="trBoardNone">
					</tr>
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
						<c:forEach var="board" items="${list }">
							<tr>
								<td><c:out value="${board.bno}" /></td>
								<td><a class="titles" href="#" bno="${board.bno }"> <c:out
											value="${board.title}" />
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
			<div id="pagination">
				<div>
				<div id="pagingDiv">
			<c:if test="${paging.prev}">
				<a href="${paging.startPage - 1 }">이전</a>
			</c:if>
			<c:forEach var="num" begin="${paging.startPage}" end="${paging.endPage }">
				&nbsp;
				<span class="paginate_button"  
				${paging.cri.pageNum == num ? 'style=" background-color: lemonchiffon; border-radius: 45px;':""} ">
				
				<a href="${num }" >${num }</a>&nbsp;</span>
			</c:forEach>
			<c:if test="${paging.next}">
				<a id="next" href="${paging.endPage + 1 }">다음</a>
			</c:if>
	</div>
	
	<form id="pagingFrm" name="pagingForm" action="/spaList" method="get">
		<input type="hidden" id="pageNum" name="pageNum" value="${paging.cri.pageNum }">
		<input type="hidden" id="amount" name="amount" value="${paging.cri.amount }">
	</form>
				</div>
			</div>
			<div>
				<form>
					<input type="button" id="boardWriteBtn" value="글작성">
				</form>
			</div>
		</div>
	</div>
</body>

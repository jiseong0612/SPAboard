$(function() {

	//글목록 받아오는 펑션 화면의 새로고침없이 글을 받아오는 아작스인데.. 어캐해 인터넷에선 못한다는데
	function getList() {
		var sHtml = ''; s
		$.ajax({
			url: "/board/spaList",
			type: "post",
			success: function(result) {
				console.log(result);
				sHtml += '<div>'

				sHtml += '</div>'
				$("")
			},
		});
	}

	//글작성 아작스
	function boardWriteAjax() {
		var params = $("#spaBoardForm").serialize();
		$.ajax({
			url: "/board/spaWrite",
			type: "post",
			data: params,
			success: function(data) {
				hideAll();
				getList();
				$("#spaListBox").show();
				//location.reload(true); //화면을 새로고침하여 url변경을 막음;
			},
			error: function(e) {
				alert("ajax통신 실패!!!");
				console.log(e);
			}
		});
	};//글작성 아작스끝

});
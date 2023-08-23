<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="관리자에게 문의하기" name="title" />
</jsp:include>
<style>

div#search-title {
	display: inline-block;
}

div#search-writer {
	display: none;
}

div#search-content {
	display: none;
}
</style>
<script>
	window.onload = ()=>{
		renderBoardList(0);
	};
</script>


<section id="Inquiry-list-sec" class="">
	<div>
		<button type="button" class="btn btn-primary"
			onclick="location.href = '${pageContext.request.contextPath}/member/memberAdminInquiry.do'">문의 하기</button>
	</div>
	<select class="custom-select custom-select-lg mb-3" id="boardType">
		<option value="0" selected>전체보기</option>
		<option value="1" >회원 정보 문의</option>
		<option value="2">소모임 관련 문의</option>
		<option value="3">결제 문의</option>
		<option value="4">신고 문의</option>
	</select>
	<div class="form-check">
		<input class="form-check-input" type="radio" name="open" id="openAll" value="0" checked>
		<label class="form-check-label" for="openAll">전체 공개</label>
	    </br>
		<input class="form-check-input" type="radio" name="open" id="openPrivate" value="1">
		<label class="form-check-label" for="openPrivate">비공개</label>
		</br>
	</div>
	<div id="search-container">
		<div>
			<label for="searchType">검색타입 :</label> <select id="searchType">
				<option value="title">제목</option>
				<option value="writer">작성자</option>
				<option value="content">내용</option>
			</select>
		</div>
			<div id="search-title" class="search-type">
			<form onsubmit="searchClubBoard(event)">
				<input type="hidden" name="searchType" value="title" /> <input
					type="text" name="searchKeyword" size="25"
					placeholder="게시글의 제목을 입력하세요." value="" />
				<button type="submit">검색</button>
			</form>
		</div>
		<div id="search-writer" class="search-type">
			<form onsubmit="searchClubBoard(event)">
				<input type="hidden" name="searchType" value="writer" /> <input
					type="text" name="searchKeyword" size="25"
					placeholder="검색할 아이디를 입력하세요." value="" />
				<button type="submit">검색</button>
			</form>
		</div>
		<div id="search-content" class="search-type">
			<form onsubmit="searchClubBoard(event)">
				<input type="hidden" name="searchType" value="content" /> <input
					type="text" name="searchKeyword" size="25"
					placeholder="게시글의 내용을 입력하세요." value="" />
				<button type="submit">검색</button>
			</form>
		</div>
	</div>
	<div class="form-check">
	    <input class="form-check-input" type="checkbox" name="open" id="openAll" value="0" checked>
	    <label class="form-check-label" for="openAll">내가 문의한 글만 보기</label>
	</div>

	<table class="table" id="boardTable">
		<thead class="thead-light">
			<tr>
				<th scope="col">제목</th>
				<th scope="col">카테고리</th>
				<th scope="col">날짜</th>
				<th scope="col">내용</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

</section>


<script>

	const searchClubBoard=(e)=>{
		e.preventDefault();
		const frm =e.target;
		const searchKeywordVal= frm.searchKeyword.value;
		const searchTypeVal= frm.searchType.value;
		const boardTypeVal= document.querySelector("#boardType").value;
		
		console.log(boardTypeVal);
		 $.ajax({
			url : '${pageContext.request.contextPath}/club/${domain}/searchClubBoard.do',
			method:"GET",
			data :{searchKeywordVal,searchTypeVal,boardTypeVal},
			success(boards){
				console.log(boards);
				
				const tbody =document.querySelector("#boardTable tbody");
				let html='';
				if(boards.length>0){
					html = boards.reduce((html,board)=>{	
						
					const {boardId,clubId,content,createdAt,likeCount,status,title,type,writer} = board;
					let typeText;
					switch(type){
						case 1: typeText ="회원 정보 문의"; break;
						case 2: typeText ="소모임 관련 문의"; break;
						case 3: typeText ="결제 문의"; break;
						case 4: typeText ="신고 문의"; break;
					
					}
					
						return html + `
							<tr>
							<td>\${typeText}</td>
							<td>
							🔒<a href="${pageContext.request.contextPath}/club/${domain}/boardDetail.do?no=\${boardId}">\${title}</a>
							</td>
							<td>\${writer}</td>
							<td>\${likeCount}</td>
							<td>\${createdAt}</td>
						</tr>
						`;
						
					},"");
					
				}else{
					html=`
						<tr>
							<td colspan="4">조회된 게시글이 없습니다😁</td>
						</tr>
					`;
				}
				
				tbody.innerHTML= html;
			}
		});
	};
	
	

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
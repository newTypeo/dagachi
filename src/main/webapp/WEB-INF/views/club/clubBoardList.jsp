<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title" />
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


<section id="club-board-sec" class="">


	<select class="custom-select custom-select-lg mb-3" id="boardType">
		<option value="0" selected>전체보기</option>
		<option value="1">자유글</option>
		<option value="2">정모후기</option>
		<option value="3">가입인사</option>
		<option value="4">공지사항</option>
	</select>

	<div>
		<button type="button" class="btn btn-primary"
			onclick="location.href = '${pageContext.request.contextPath}/club/&${domain}/clubBoardCreate.do'">작성</button>
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

	<table class="table" id="boardTable">
		<thead class="thead-light">
			<tr>
				<th scope="col">게시판</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">좋아요</th>
				<th scope="col">작성일</th>
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
						case 1: typeText ="자유게시판"; break;
						case 2: typeText ="정모후기"; break;
						case 3: typeText ="가입인사"; break;
						case 4: typeText ="공지사항"; break;
					}
					
						return html + `
							<tr>
							<td>\${typeText}</td>
							<td>
							<a href="${pageContext.request.contextPath}/club/${domain}/boardDetail.do?no=\${boardId}">\${title}</a>
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
	
	document.querySelector("select#searchType").onchange = (e) => {
		searchKeywordReset();
		document.querySelectorAll(".search-type").forEach((elem) => {
			elem.style.display = "none";
		});
		
		document.querySelector(`#search-\${e.target.value}`).style.display = "inline-block";
	};
	
	const searchKeywordReset=()=>{
		document.querySelectorAll(`input[name="searchKeyword"]`).forEach((elem)=>{
			elem.value="";
		});
	}


	document.querySelector("#boardType").addEventListener("change",(e)=>{
		const boardType =e.target.value;
		const tbody =document.querySelector("#boardTable tbody");
		renderBoardList(boardType);
	});
	
	
	const renderBoardList =(boardType)=>{
		$.ajax({
			url : '${pageContext.request.contextPath}/club/${domain}/findBoardType.do',
			method:"GET",
			data :{boardType},
			success(boards){
				console.log(boards);
				
				const tbody =document.querySelector("#boardTable tbody");
				let html='';
				if(boards.length>0){
					html = boards.reduce((html,board)=>{	
						
					const {boardId,clubId,content,createdAt,likeCount,status,title,type,writer} = board;
					let typeText;
					switch(type){
						case 1: typeText ="자유게시판"; break;
						case 2: typeText ="정모후기"; break;
						case 3: typeText ="가입인사"; break;
						case 4: typeText ="공지사항"; break;
					}
					
						return html + `
							<tr>
							<td>\${typeText}</td>
							<td>
							<a href="${pageContext.request.contextPath}/club/${domain}/boardDetail.do?no=\${boardId}">\${title}</a>
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
							<td colspan="4">게시글이 없습니다. 제일먼저 게시글을 작성해보세요😁</td>
						</tr>
					`;
				}
				
				tbody.innerHTML= html;
			}
		});
	}
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
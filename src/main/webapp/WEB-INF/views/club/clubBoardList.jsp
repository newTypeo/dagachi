<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/club.css"/>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp">
	<jsp:param value="게시판" name="title" />
</jsp:include>
<style>
div#search-title {display: inline-block;}
div#search-writer {display: none;}
div#search-content {display: none;}
</style>

<script>
window.onload = () => {
	const boardLoadType = ${no};
	renderBoardList(boardLoadType);
	document.querySelector("#boardType").value= boardLoadType;
};
</script>


<section id="club-board-sec" class="">

	<nav id="club-title" class="">
		<c:if test="${layout.title eq null}">
			<div id="default-title">
				<h2>${domain}</h2>
			</div>
		</c:if>
		
		<c:if test="${layout.title ne null}">
			<img src="${pageContext.request.contextPath}/resources/upload/club/title/${layout.title}">
		</c:if>
	</nav>
	
	<nav id="club-nav-bar" style="border-color: ${layout.pointColor}">
		<h5><a href="${pageContext.request.contextPath}/club/${domain}">🚩${clubName}</a></h5>
		<div class="fontColors">
			<ul>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=4">📢공지사항</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=1">🐳자유게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=3">✋가입인사</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubBoardList.do?no=2">🎉정모후기</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubGallery.do">📷갤러리</a></li>
				<li><a href="${pageContext.request.contextPath}/club/${domain}/clubSchedule.do">📅일정</a></li>
			</ul>
		</div>
	</nav>
	
			

	<div>
		<button type="button" class="btn btn-primary" style="margin-left: 1255px; transform: translate(8px, 70px);"
			onclick="location.href = '${pageContext.request.contextPath}/club/${domain}/clubBoardCreate.do'">작성</button>
	</div>

	<div id="search-container" style="margin-top: -20px;">
		<div class="searchType-place" style="display: flex;">
			<label for="searchType" style="transform: translate(0px, 2px);">◾게시물 타입</label>
			<select id="boardType" style="height: 28px; margin-left: 5px;">
				<option value="0" selected>전체보기</option>
				<option value="1">자유글</option>
				<option value="2">정모후기</option>
				<option value="3">가입인사</option>
				<option value="4">공지사항</option>
			</select>
	
			<div>
				<label for="searchType" style="margin-left:5px;">◾검색타입</label> <select id="searchType">
					<option value="title">제목</option>
					<option value="writer">작성자</option>
					<option value="content">내용</option>
				</select>
			</div>
		</div>
		

		<div id="search-title" class="search-type">
			<form onsubmit="searchClubBoard(event)">
				<input type="hidden" name="searchType" value="title" /> <input
					type="text" name="searchKeyword" size="25"
					placeholder="게시글의 제목을 입력하세요." style="height: 37px;" value="" />
				<button type="submit" class="btn btn-outline-secondary">검색</button>
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
	
	<table class="table fontColors" id="mustTable" style="margin-top: 5px; text-align: center">
		<thead class="thead-light">
			<tr>
				<th scope="col">필독</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<table class="table fontColors" id="boardTable" style="margin-top: 5px; text-align: center">
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

	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<li id="prevPage" class="page-item disabled"><a class="page-link">이전</a></li>
					
			<li id="nextPage" class="page-item"><a class="page-link">다음</a></li>
		</ul>
	</nav>
</section>


<script>

//레이아웃 및 네브바
document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});

document.body.style.fontFamily = "${layout.font}";

//page script

	let currentPage=1;
	let lastPage;
 
	//이전버튼
	document.querySelector("#prevPage").addEventListener("click",()=>{
		const boardTypeVal= document.querySelector("#boardType").value;
		
		pageButtonChange(currentPage);
		
		if(currentPage>1){
			currentPage--;
			renderBoardList(boardTypeVal);
		}
		
	});
	
	//다음버튼
	document.querySelector("#nextPage").addEventListener("click",()=>{
		const boardTypeVal= document.querySelector("#boardType").value;
		
		if(currentPage<lastPage){
			currentPage++;
			renderBoardList(boardTypeVal);
		}
	});
    
	//이전 다음 활성, 비활성화
	const pageButtonChange=(currentPage)=>{
		const prevPage = document.getElementById("prevPage");
		const nextPage = document.getElementById("nextPage");
		
		if(currentPage===1)
			prevPage.classList.add("disabled");
		else
			prevPage.classList.remove("disabled");
		
		
		if(lastPage===currentPage)
			nextPage.classList.add("disabled");
		else
			nextPage.classList.remove("disabled");
		
		
	};
	


	const searchClubBoard=(e)=>{
		e.preventDefault();
		const frm =e.target;
		const searchKeywordVal= frm.searchKeyword.value;
		const searchTypeVal= frm.searchType.value;
		const boardTypeVal= document.querySelector("#boardType").value;
		
		 $.ajax({
			url : '${pageContext.request.contextPath}/club/${domain}/searchClubBoard.do',
			method:"GET",
			data :{searchKeywordVal,searchTypeVal,boardTypeVal},
			success(data){
				
				const tbody =document.querySelector("#boardTable tbody");
				let html='';
				if(data.boards.length>0){
					html = data.boards.reduce((html,board)=>{	
						
					const {boardId,clubId,content,createdAt,likeCount,status,title,type,writer} = board;
					let typeText;
					switch(type){
						case 1: typeText ="자유게시판"; break;
						case 2: typeText ="정모후기"; break;
						case 3: typeText ="가입인사"; break;
						case 4: typeText ="공지사항"; break;
					}
					
					
					const parsedDate =new Date(createdAt);
					const options={   year: '2-digit',
							  month: '2-digit',
							  day: '2-digit',
							  hour: '2-digit',
							  minute: '2-digit',
							  hour12: false};
					const formattedDate = parsedDate.toLocaleDateString('ko-KR', options);
				
					
						return html + `
							<tr>
							<td>\${typeText}</td>
							<td>
							<a href="${pageContext.request.contextPath}/club/${domain}/boardDetail.do?no=\${boardId}">\${title}</a>
							</td>
							<td>\${writer}</td>
							<td>\${likeCount}</td>
							<td>\${formattedDate}</td>
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
				renderPage(data.boardSize);
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
		currentPage =1;
	});
	
	
	const renderBoardList =(boardType)=>{

		const page=currentPage;
		
		$.ajax({
			url : '${pageContext.request.contextPath}/club/${domain}/findBoardType.do',
			method:"GET",
			data :{boardType,page},
			success(data){
				const tbody =document.querySelector("#boardTable tbody");
				let html='';
				if(data.boards.length>0){
					html = data.boards.reduce((html,board)=>{	
						
					const {boardId,clubId,content,createdAt,likeCount,status,title,type,writer} = board;
					let typeText;
					switch(type){
						case 1: typeText ="자유게시판"; break;
						case 2: typeText ="정모후기"; break;
						case 3: typeText ="가입인사"; break;
						case 4: typeText ="공지사항"; break;
						case 5: typeText ="필독"; break;
					}
					
					if(type === 5){
						const mustReadBody=document.querySelector("#mustTable tbody");
						
						mustReadBody.innerHTML=`
							<td>
								[필독] <a href="${pageContext.request.contextPath}/club/${domain}/boardDetail.do?no=\${boardId}">\${title}❗</a>
							</td>
						`;
					}
					
					const parsedDate =new Date(createdAt);
					const options={   year: '2-digit',
							  month: '2-digit',
							  day: '2-digit',
							  hour: '2-digit',
							  minute: '2-digit',
							  hour12: false};
					const formattedDate = parsedDate.toLocaleDateString('ko-KR', options);
					
						return html + `
							<tr>
							<td>\${typeText}</td>
							<td>
							<a href="${pageContext.request.contextPath}/club/${domain}/boardDetail.do?no=\${boardId}">\${title}</a>
							</td>
							<td>\${writer}</td>
							<td>\${likeCount}</td>
							<td>\${formattedDate}</td>
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
				
				renderPage(data.boardSize);
			}
		});
	}
	

	
	
	//페이지 이동

	const pageChange=(page)=>{
		currentPage=page;
		
		const boardTypeVal= document.querySelector("#boardType").value;
		renderBoardList(boardTypeVal);
		pageButtonChange(currentPage);
	};
	
	
//페이지 바 렌더 
	
	const renderPage=(boardSize)=>{
		
		 const totalPosts =boardSize;
		 const postsPerPage = 10;
		 lastPage = Math.ceil(totalPosts / postsPerPage);
		 const pagebarSize=5;
		 
        const showPage = Math.floor((currentPage-1)/pagebarSize)*pagebarSize;
		
        document.querySelector("#nextPage").insertAdjacentHTML('beforebegin',"");
		// 페이지바 삭제
        document.querySelectorAll(".pageLiTag").forEach((li) => {
        	while (li.firstChild) {
        		li.removeChild(li.firstChild);
            }
        	li.parentNode.removeChild(li);
        });
        
		for(let i=1; i<=pagebarSize; i++) {
			if(showPage+i <= lastPage){
				if(showPage+i===currentPage) {
					document.querySelector("#nextPage").insertAdjacentHTML('beforebegin',
								`<li class="page-item pageLiTag" ><a class="page-link" style="background-color : #ddd;">\${showPage+i}</a></li>`
					);
				}else{
					document.querySelector("#nextPage").insertAdjacentHTML('beforebegin',
								`<li class="page-item pageLiTag"><a class="page-link" onclick="pageChange(\${showPage+i})">\${showPage+i}</a></li>`
					);
				}
			}
		}
		
		if(lastPage===0) {
			document.querySelector("#nextPage").insertAdjacentHTML('beforebegin',
					`<li class="page-item pageLiTag"><a class="page-link" >1</a></li>`
			)
		}
	};
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
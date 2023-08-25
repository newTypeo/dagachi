<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="문의 관리" name="title" />
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
		renderInquiryList(0);
	};
</script>


<section id="admin-inquiry-sec" class="">


	<select class="custom-select custom-select-lg mb-3" id="inquiryType">
		<option value="0" selected>전체보기</option>
		<option value="1">회원 정보 문의</option>
		<option value="2">소모임 관련 문의</option>
		<option value="3">결제 문의</option>
		<option value="4">신고 문의</option>
	</select>
	<div>
		<label for="answerType">답변 여부 :</label>
		<input type="radio" id="answerType" name="answerType" value="0"> 답변
		<input type="radio" id="answerType" name="answerType" value="1"> 비답변
		<input type="radio" id="answerType" name="answerType" value="2"> 전체
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
			<form onsubmit="searchAdminInquiry(event)">
				<input type="hidden" name="searchType" value="title" /> <input
					type="text" name="searchKeyword" size="25"
					placeholder="게시글의 제목을 입력하세요." value="" />
				<button type="submit">검색</button>
			</form>
		</div>

		<div id="search-writer" class="search-type">
			<form onsubmit="searchAdminInquiry(event)">
				<input type="hidden" name="searchType" value="writer" /> <input
					type="text" name="searchKeyword" size="25"
					placeholder="검색할 아이디를 입력하세요." value="" />
				<button type="submit">검색</button>
			</form>
		</div>

		<div id="search-content" class="search-type">
			<form onsubmit="searcInquirydAdmin(event)">
				<input type="hidden" name="searchType" value="content" /> <input
					type="text" name="searchKeyword" size="25"
					placeholder="게시글의 내용을 입력하세요." value="" />
				<button type="submit">검색</button>
			</form>
		</div>

	</div>

	<table class="table" id="inquiryTable">
		<thead class="thead-light">
			<tr>
				<th scope="col">카테고리</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">답변</th>
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
//page script
	let currentPage=1;
	let lastPage;
	//이전버튼00
	document.querySelector("#prevPage").addEventListener("click",()=>{
		const inquiryTypeVal= document.querySelector("#inquiryType").value;
		pageButtonChange(currentPage);
		if(currentPage>1){
			currentPage--;
			renderInquiryList(inquiryTypeVal);
		}
	});
	//다음버튼00
	document.querySelector("#nextPage").addEventListener("click",()=>{
		const inquiryTypeVal= document.querySelector("#inquiryType").value;
		if(currentPage<lastPage){
			currentPage++;
			renderInquiryList(inquiryTypeVal);
			console.log(currentPage);
		}
	});
    
	//이전 다음 활성, 비활성화00
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
	
	//
	const searchAdminInquiry=(e)=>{
		e.preventDefault();
		const frm =e.target;
		const searchKeywordVal= frm.searchKeyword.value;
		const searchTypeVal= frm.searchType.value;
		const inquiryTypeVal= document.querySelector("#inquiryType").value;
		
		console.log(inquiryTypeVal);
		 $.ajax({
			 //url : '${pageContext.request.contextPath}/club/${domain}/searchClubBoard.do',
			url : '${pageContext.request.contextPath}/admin/searchInquiryType.do',
			method:"GET",
			data :{searchKeywordVal,searchTypeVal,inquiryTypeVal},
			success(data){
				console.log(data);
				const tbody =document.querySelector("#inquiryTable tbody");
				let html='';
				if(data.inquirys.length>0){
					html = data.inquirys.reduce((html,inquiry)=>{	
					
					// 가져오는 값 수정하기 (작성사, 날자, 오픈 , 카데고리, 목 , 답변여부)
					const {inquiryId,writer,title,content,createdAt,type,status,adminId,response,open,responseAt} = inquiry;
					
					let typeText;
					let openText;
					let statusText;
					switch(type){
						case 1: typeText ="회원 정보 문의"; break;
						case 2: typeText ="소모임 관련 문의"; break;
						case 3: typeText ="결제 문의"; break;
						case 4: typeText ="신고 문의"; break;
					}
					switch(open){
					case 1: openTextText ="🔒"; break;
					case 0: openTextText ="🔓"; break;
					}
					switch(status){
					case 0: statusText ="답변 하기"; break;
				  /*<form action="${pageContext.request.contextPath}/admin/adminInquiryUpdate.do" method="GET">
					<input type="hidden" name="inquiryId" value="${inquiry.inquiryId}">
					<button type="submit">답변하기</button>
					</form>*/
					case 1: statusText ="답변 완료"; break;

					}
					
						return html + `
							<tr>
							<td>\${open}</td>
							<td>\${inquiryId}}</td>
							<td>\${type}</td>
							<td>\${title}</td>
							<td>\${writer}</td>
							<td>\${createdAt}</td>
							<td>\${writer}</td>
							<td>\${status}</td>
						</tr>
						`;
						
					},"");
					
				}else{
					html=`
						<tr>
							<td colspan="8">조회된 게시글이 없습니다😁</td>
						</tr>
					`;
				}
				tbody.innerHTML= html;
				renderPage(data.inquirySize);
			}
		});
		
		
		
	};
	
	//0
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
	//0
	document.querySelector("#inquiryType").addEventListener("change",(e)=>{
		const inquiryType =e.target.value;
		const tbody =document.querySelector("#inquiryTable tbody");
		renderInquiryList(inquiryType);
		currentPage =1;
	});
	
	
	const renderInquiryList =(inquiryType)=>{
		const page=currentPage;
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/findAdminInquiry.do',
			method:"GET",
			data :{inquiryType,page},
			success(data){
				console.log(data);
				const tbody =document.querySelector("#inquiryTable tbody");
				let html='';
				if(data.inquirys.length>0){
					html = data.inquirys.reduce((html,inquiry)=>{	
						
					// 수정 할것
					const {inquiryId,writer,title,content,createdAt,type,status,adminId,response,open,responseAt} = inquiry;
					
					let typeText;
					let openText;
					let statusText;
					switch(type){
						case 1: typeText ="회원 정보 문의"; break;
						case 2: typeText ="소모임 관련 문의"; break;
						case 3: typeText ="결제 문의"; break;
						case 4: typeText ="신고 문의"; break;
					}
					switch(open){
					case 1: openTextText ="🔒"; break;
					case 0: openTextText ="🔓"; break;
					}
					switch(status){
					case 0: statusText ="답변 하기"<form action="${pageContext.request.contextPath}/admin/adminInquiryUpdate.do" method="GET">
					<input type="hidden" name="inquiryId" value="${inquiry.inquiryId}">
					<button type="submit">답변하기</button>
					</form>; break;
				  /**/
					case 1: statusText ="답변 완료"; break;
					}
						return html + `
							<tr>
							<td>\${open}</td>
							<td>\${inquiryId}}</td>
							<td>\${type}</td>
							<td>\${title}</td>
							<td>\${writer}</td>
							<td>\${createdAt}</td>
							<td>\${writer}</td>
							<td>\${status}</td>
						</tr>
						`;
					},"");
				}else{
					html=`
						<tr>
							<td colspan="8">게시글이 없습니다. 제일먼저 게시글을 작성해보세요😁</td>
						</tr>
					`;
				}
				
				tbody.innerHTML= html;
				
				renderPage(data.inquirySize);
			}
		});
	}
	

	
	
//페이지 이동
	const pageChange=(page)=>{
		currentPage=page;
		const binquiryTypeVal= document.querySelector("#inquiryType").value;
		renderInquiryList(inquiryTypeVal);
		pageButtonChange(currentPage);
	};
	
	
//페이지 바 렌더 
	const renderPage=(inquirySize)=>{
		 const totalPosts =inquirySize;
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
        
		for(let i=1; i<=pagebarSize; i++){
			if(showPage+i <= lastPage){
				if(showPage+i===currentPage){
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
		
		if(lastPage===0){
			document.querySelector("#nextPage").insertAdjacentHTML('beforebegin',
					`<li class="page-item pageLiTag"><a class="page-link" >1</a></li>`
			)
		}
		
		
	};
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="문의 관리" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css"/>

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
		renderInquiryList(0,0);
	};
</script>


<section id="admin-inquiry-sec"  class="p-2 quit-member-list sectionList">

	<h1>문의 목록/관리 페이지</h1>
	<div id="member-list-wrapper">
		<div id="search-container">
			<div id="searchBar-wrap">

	<select class="searchType" id="inquiryType">
		<option value="0" selected>카테고리 전체보기</option>
		<option value="1">회원 정보 문의</option>
		<option value="2">소모임 관련 문의</option>
		<option value="3">결제 문의</option>
		<option value="4">신고 문의</option>
	</select>
	
	<select class="searchType" id="inquiryStatus">
		<option value="1">답변</option>
		<option value="2"> 비답변</option>
		<option value="0" selected>답변여부 / 전체</option>
	</select>

		<div>
			<label for="searchType">검색타입 :</label>
			 <select id="searchType">
				<option id="searchOption" value="title">제목</option>
				<option id="searchOption" value="writer">작성자</option>
				<option id="searchOption" value="content">내용</option>
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

	<table  class="listTable" id="inquiryTable">
		<thead class="thead-light">
			<tr>
				<th scope="col">번호</th>
				<th scope="col">질문 공개 여부</th>
				<th scope="col">카테고리</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">질문 일자</th>
				<th scope="col">답변하기</th>
				<th scope="col">답변 상세 보기</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<nav aria-label="Page navigation example"  class="text-center">
		<ul class="pagination justify-content-center">
			<li id="prevPage" class="page-item disabled"><a class="page-link">이전</a></li>
			<li id="nextPage" class="page-item"><a class="page-link">다음</a></li>
		</ul>
	</nav>
	
		</div>
	  </div>
	</div>
</section>


<script>
//page script
	let currentPage=1;
	let lastPage;
	//이전버튼
	document.querySelector("#prevPage").addEventListener("click",()=>{
		const inquiryTypeVal= document.querySelector("#inquiryType").value;
		const inquiryStatusVal= document.querySelector("#inquiryStatus").value;
		pageButtonChange(currentPage);
		if(currentPage>1){
			currentPage--;
			renderInquiryList(inquiryTypeVal,inquiryStatusVal);
		}
	});
	//다음버튼
	document.querySelector("#nextPage").addEventListener("click",()=>{
		const inquiryTypeVal= document.querySelector("#inquiryType").value;
		const inquiryStatusVal= document.querySelector("#inquiryStatus").value;
		if(currentPage<lastPage){
			currentPage++;
			renderInquiryList(inquiryTypeVal,inquiryStatusVal);
			console.log(currentPage);
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
	
	//
	const searchAdminInquiry=(e)=>{
		e.preventDefault();
		const frm =e.target;
		const searchKeywordVal= frm.searchKeyword.value;
		const searchTypeVal= frm.searchType.value;
		const inquiryTypeVal= document.querySelector("#inquiryType").value;
		const inquiryStatusVal= document.querySelector("#inquiryStatus").value;
		console.log("바바바"+searchKeywordVal);
		console.log("바바바"+searchTypeVal);
		console.log("바바바"+inquiryTypeVal);
		console.log("바바바"+inquiryStatusVal);
		
		 $.ajax({
			url : '${pageContext.request.contextPath}/admin/searchInquiryType.do',
			method:"GET",
			data :{searchKeywordVal,searchTypeVal,inquiryTypeVal,inquiryStatusVal},
			success(data){
				const tbody =document.querySelector("#inquiryTable tbody");
				let html='';
				if(data.inquirys.length>0){
					html = data.inquirys.reduce((html,inquiry)=>{	
					
					// 가져오는 값 수정하기 (작성사, 날자, 오픈 , 카데고리, 목 , 답변여부)
					const {inquiryId,writer,title,content,createdAt,type,status,adminId,response,open,responseAt} = inquiry;
					
					let typeText;
					let openText;
					let statusText;
					let _statusText;
					switch(type){
						case 1: typeText ="회원 정보 문의"; break;
						case 2: typeText ="소모임 관련 문의"; break;
						case 3: typeText ="결제 문의"; break;
						case 4: typeText ="신고 문의"; break;
					}
					switch(open){
					case 1: openText ="공개 질문"; break;
					case 0: openText ="비공개 질문"; break;
					}
					
					switch(status){
					case 1: statusText =`
					<form action="${pageContext.request.contextPath}/admin/adminInquiryUpdate.do" method="GET">
					<input type="hidden" name="inquiryId" value=\${inquiryId}>
					<button type="submit">답변</button>
					</form>`; break;
					case 2: statusText ="답변 완료"; break;
					}
					switch(status){
					case 1: _statusText = "아직 답변하지 않은 문의입니다."; break;
					case 2: _statusText =`답변자 : \${adminId}</br> 답변 내용: \${response} </br> 답변일자 : \${responseAt} `; break;
					}
					
					return html + `
						<tr>
							<td>\${inquiryId}</td>
							<td>\${openText}</td>
							<td>\${typeText}</td>
							<td>\${title}</td>
							<td>\${writer}</td>
							<td>\${createdAt}</td>
							<td>\${statusText}</td>
							<td>\${_statusText}</td>
						</tr>
						`;
					},"");
				}else{
					html=`
						<tr>
							<td colspan="8">문의가 없습니다.😁</td>
						</tr>
					`;
				}
				
				tbody.innerHTML= html;
				
				renderPage(data.inquirySize);
			}
		});
	}
	
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
		const inquiryStatusVal= document.querySelector("#inquiryStatus").value;
		renderInquiryList(inquiryTypeVal,inquiryStatusVal);
		currentPage =1;
	});
	
	document.querySelector("#inquiryStatus").addEventListener("change",(e)=>{
		const inquiryStatus =e.target.value;
		const tbody =document.querySelector("#inquiryTable tbody");
		const inquiryTypeVal= document.querySelector("#inquiryType").value;
		renderInquiryList(inquiryTypeVal,inquiryStatusVal);
		currentPage =1;
	});
	
	
	
	const renderInquiryList =(inquiryType,inquiryStatus)=>{
		const page=currentPage;
		$.ajax({
			url : '${pageContext.request.contextPath}/admin/findAdminInquiry.do',
			method:"GET",
			data :{inquiryType,inquiryStatus,page},
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
					let _statusText;
					switch(type){
						case 1: typeText ="회원 정보 문의"; break;
						case 2: typeText ="소모임 관련 문의"; break;
						case 3: typeText ="결제 문의"; break;
						case 4: typeText ="신고 문의"; break;
					}
					switch(open){
					case 1: openText ="공개 질문"; break;
					case 0: openText ="비공개 질문"; break;
					}
					switch(status){
					case 1: statusText =`
					<form action="${pageContext.request.contextPath}/admin/adminInquiryUpdate.do" method="GET">
					<input type="hidden" name="inquiryId" value=\${inquiryId}>
					<button type="submit">답변</button>
					</form>`; break;
					case 2: statusText ="답변 완료"; break;
					}
					switch(status){
					case 1: _statusText = "아직 답변하지 않은 문의입니다."; break;
					case 2: _statusText =`답변자 : \${adminId}</br> 답변 내용: \${response} </br> 답변일자 : \${responseAt} `; break;
					}
					return html + `
						<tr>
							<td>\${inquiryId}</td>
							<td>\${openText}</td>
							<td>\${typeText}</td>
							<td>\${title}</td>
							<td>\${writer}</td>
							<td>\${createdAt}</td>
							<td>\${statusText}</td>
							<td>\${_statusText}</td>
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
		const inquiryTypeVal= document.querySelector("#inquiryType").value;
		const inquiryStatusVal= document.querySelector("#inquiryStatus").value;
		renderInquiryList(inquiryTypeVal,inquiryStatusVal);
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
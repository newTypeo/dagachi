// 사용법 총 게시물 수랑, 게시글 로우바운즈로 잘라서 사용하시면 됩니다
//자세한 내용은 상윤님에게 dm주세요


/*	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<li id="prevPage" class="page-item disabled"><a class="page-link">이전</a></li>
					
			<li id="nextPage" class="page-item"><a class="page-link">다음</a></li>
		</ul>
	</nav> */

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
	
	
	
	
	
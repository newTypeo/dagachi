<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글 작성" name="title" />
</jsp:include>

<section id="club-board-sec" class="">

	<div class="chat_wrap">
		<div class="header">CHAT</div>
		<div class="chat">
			<ul>
				<!-- 동적 생성 -->
			</ul>
		</div>
		<div class="input-div">
			<textarea placeholder="Press Enter for send message."></textarea>
		</div>

		<!-- format -->

		<div class="chat format">
			<ul>
				<li>
					<div class="sender">
						<span></span>
					</div>
					<div class="message">
						<span></span>
					</div>
				</li>
			</ul>
		</div>
	</div>


</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
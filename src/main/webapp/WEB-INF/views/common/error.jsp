<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="exception" value="<%= exception %>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러페이지</title>
<style>
body {text-align: center;}
h1 {font-size: 250px; margin: 0;}
#message {color: red;}
</style>
</head>
<body>
	<h1>에러페이지</h1>
	<p>이용에 불편을 드려 죄송합니다.</p>
	<p id="message">${exception.message}</p>
	<p><a href="<%= request.getContextPath() %>/">홈으로</a></p> 
</body>
</html>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
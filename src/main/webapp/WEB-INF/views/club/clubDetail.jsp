<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/clubHeader.jsp"></jsp:include>

<jsp:include page="/WEB-INF/views/club/clubLayout/clubLayoutType0.jsp"></jsp:include>

<script>
// 준한(모임 비활성화)
	const domain = "<%= request.getAttribute("domain") %>"; // 서버 사이드에서 domain 값을 가져와서 설정
    document.querySelector("#clubDisabled").onclick = (e) => {
        const userConfirmation = confirm("정말 비활성화 하시겠습니까?");
        if (userConfirmation) {
            // 도메인 값을 사용하여 컨트롤러로 이동하는 코드를 추가
            window.location.href = "${pageContext.request.contextPath}/club/&" + domain + "/clubDisabled.do";
            alert('모임이 성공적으로 비활성화 되었습니다.');
        }
    };
    
document.querySelector("#club-update-btn").onclick = () => {
	location.href = '${pageContext.request.contextPath}/club/&'+domain+'/clubUpdate.do';
}

console.log('${layout}');
document.body.style.background = '${layout.backgroundColor}';

document.querySelectorAll('.fontColors').forEach((elem) => {
	elem.style.color = '${layout.fontColor}';
});

document.querySelectorAll('.pointColors').forEach((elem) => {
	elem.style.color = '${layout.pointColor}';
});

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
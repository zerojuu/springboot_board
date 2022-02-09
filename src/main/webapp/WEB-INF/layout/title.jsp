<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<c:set var="root" value="<%=request.getContextPath() %>"/>
<body>
<a href="${root}/">
<img alt="" src="${root}/photo/9.JPG" style="width: 300px;"></a>
<b>SpringBoot+Mybatis+Tiles</b>&nbsp;&nbsp;&nbsp;&nbsp;
<span style="margin-right: 50px;">
  <c:if test="${sessionScope.loginok==null }">
  <!-- 로그아웃 상태 -->
    <button type="button" class="btn btn-info" onclick="location.href='${root}/login/main'">로그인</button>
  </c:if>
  
  <c:if test="${sessionScope.loginok!=null }">
    <b style="font-size: 0.7em; color: blue;">${sessionScope.myid}님</b>
    <button type="button" class="btn btn-info" onclick="location.href='${root}/login/logoutprocess'">로그아웃</button>
  </c:if>
</span>
</body>
</html>
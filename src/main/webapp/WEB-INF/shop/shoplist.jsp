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
<body>
<div class="alert alert-info" style="width: 800px; margin-left: 50px;">
  <b>총 ${totalCount }개의 상품이 있습니다</b>
</div>

<table class="table table-bordered" style="width: 800px; margin-left: 50px;">
  <caption><span><button type="button" class="btn btn-default" onclick="location.href='form'">상품추가</button></span></caption>
  
    <c:forEach var="dto" items="${list }">
      <tr>
        <td width="400" rowspan="4" align="center">
          <img alt="" src="../photo/${dto.photoname }" style="width: 300px;">
        </td>
        <td>
          <b>상품명: ${dto.sangpum }</b>
        </td>        
      </tr>
      
      <tr>
        <td><b>가격: <fmt:formatNumber value="${dto.price }" type="currency"/></b></td>
      </tr>
      
      <tr>
        <td>
          <b>입고일: <fmt:formatDate value="${dto.ipgoday }" pattern="yyyy년 MM월 dd일"/></b>
        </td>
      </tr>
      
      <tr>
        <td align="center">
          <button type="button" class="btn btn-default" onclick="location.href='updateform?num=${dto.num}'">수정</button>
          <button type="button" class="btn btn-default" onclick="location.href='delete?num=${dto.num}'">삭제</button>
        </td>
      </tr>
    </c:forEach>
</table>
</body>
</html>
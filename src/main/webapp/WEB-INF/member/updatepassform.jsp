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
<div style="margin-left: 200px;">
  <form action="updatepass" method="post">
  <!-- hidden -->
  <input type="hidden" name="num" value="${num }">
  
    <b>수정에 필요한 비밀번호 입력해주세요</b>
    <br><br>
      <div>
        <input type="text" name="pass" class="form-control" style="width: 120px;" required="required" autofocus="autofocus">
        <button type="submit" class="btn btn-default">확인</button>
      </div>
  </form>
</div>
</body>
</html>
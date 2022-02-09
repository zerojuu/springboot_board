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
<form action="update" method="post" enctype="multipart/form-data">
<input type="hidden" name="num" value="${dto.num }">

  <table class="table table-bordered" style="width: 500px; margin-left: 30px;">
    <caption><b>상품정보 수정</b></caption>
      <tr>
        <th bgcolor="#fff0f5">상품명</th>
          <td>
            <input type="text" name="sangpum" class="form-control" style="width: 200px;" value="${dto.sangpum }">
          </td>
      </tr>
      
      <tr>
        <th bgcolor="#fff0f5">가격</th>
          <td>
            <input type="text" name="price" class="form-control" style="width: 200px;" value="${dto.price }">
          </td>
      </tr>
      
      <tr>
        <th bgcolor="#fff0f5">이미지</th>
          <td>
            <input type="file" name="upload" class="form-control" style="width: 200px;" >
          </td>
      </tr>
      
      <tr>
        <td colspan="2" align="center">
          <button type="submit" class="btn btn-default" style="width: 100px;">수정</button>
          <button type="button" class="btn btn-default" style="width: 100px;" onclick="location.href='list'">목록</button>
        </td>
      </tr>
  </table>
</form>
</body>
</html>
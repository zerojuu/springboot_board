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
<form action="insert" method="post" enctype="multipart/form-data">
<!-- hidden -->
<input type="hidden" name="num" value="${dto.num }">

  <span class="glyphicon glyphicon-camera photo" style="font-size: 30px;"></span>
  <input type="file" name="photos" id="photos" style="width: 200px;" multiple="multiple" value="${dto.photo }">
    
    <table class="table table-bordered" style="width: 600px;">     
     <tr>
        <th style="width: 120px;">닉네임</th>
          <td>
            <input type="text" name="nickname" class="form-control">
          </td>
      </tr>
     
      <tr style="height: 100px;">
          <td colspan="2" align="center">
            <textarea style="width: 550px; height: 90px;" name="content">${dto.content }</textarea><br>
            <button type="submit" class="btn btn-default">저장</button>
          </td>
      </tr>
    </table>
</form>
</body>
</html>
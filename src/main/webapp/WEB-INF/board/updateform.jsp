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
<!-- hidden -->
<input type="hidden" name="num" value="${dto.num }">
<input type="hidden" name="currentPage" value="${currentPage }">

  <table class="table table-bordered" style="width: 500px;">
    <caption>회원전용 게시판 수정</caption>
    
    <tr>
      <th width="120">제목</th>
        <td>
          <input type="text" name="subject" class="form-control" required="required" autofocus="autofocus" value="${dto.subject }">
        </td>
    </tr>
    
    <tr>
      <th width="120">업로드</th>
        <td>
    <!-- boarddto의 multipartfile인 upload와 name이 같아야 함 -->
          <input type="file" name="upload" class="form-control" autofocus="autofocus">
        </td>
    </tr>
    
    <tr>
      <td colspan="2">
        <textarea style="width: 480px; height: 150px;" class="form-control" name="content" required="required">${dto.content }</textarea>
      </td>
    </tr>
    
    <tr>
      <td colspan="2" align="center">
        <button type="submit" class="btn btn-default" style="width: 100px;">수정</button>
        <button type="button" class="btn btn-default" style="width: 100px;" onclick="location.href='history.back()'">이전</button>
        <button type="button" class="btn btn-default" style="width: 100px;" onclick="location.href='list?currentPage=${currentPage}'">목록</button>
      </td>
    </tr>
  </table>
</form>
</body>
</html>
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
<style type="text/css">
th {
	text-align: center;
}
</style>
</head>
<body>
<div style="margin-left: 130px;">
  <form action="loginprocess" method="post" class="form-inline">
    <table class="table table-bordered" style="width: 300px;">
       <caption><b>세션 로그인</b></caption>
         <tr>
           <td colspan="2" align="center">
             <input type="checkbox" name="cbsave"
             ${sessionScope.saveok==null?"":"checked"}>아이디저장
            
           </td>
         </tr>
         <tr>
           <th width="100" bgcolor="#fffff0">아이디</th>
           <td align="center">
             <input type="text" name="id" class="form-control" autofocus="autofocus"
             required="required" style="width: 120px;"
             value="${sessionScope.saveok==null?"":sessionScope.myid }">
           </td>
         </tr>
         <tr>
           <th width="100" bgcolor="#fffff0">비밀번호</th>
           <td align="center">
             <input type="password" name="pass" class="form-control" 
             required="required" style="width: 120px;">
           </td>
         </tr>
         <tr>
           <td colspan="2" align="center">
             <button type="submit" class="btn btn-success" style="width: 100px;">로그인</button>
           </td>
         </tr>
    </table>
  </form>
</div>
</body>
</html>
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
<c:if test="${sessionScope.loginok!=null }">
  <button type="button" class="btn btn-default" style="width: 100px; margin-left: 600px;" onclick="location.href='form'">글작성</button>
</c:if>

<br><br>
<table class="table table-bordered" style="width: 750px;">
  <tr bgcolor="#f5f5f5">
    <th width="70">번호</th>
    <th width="350">제목</th>
    <th width="100">작성자</th>
    <th width="70">조회</th>
    <th width="150">작성일</th>
  </tr>
  
  <c:if test="${totalCount==0 }">
    <tr height="50">
      <td colspan="5" align="center">
        <h4><b>등록된 글이 없습니다</b></h4>
      </td>
    </tr>
  </c:if>
  
  <c:if test="${totalCount>0 }">
    <c:forEach var="a" items="${list }">
      <tr>
        <td align="center">${no }</td>
          <!-- 증감식 -->
          <c:set var="no" value="${no-1 }"></c:set>
        <td><a href="content?num=${a.num}&currentPage=${currentPage}">${a.subject }</a>
        
        <!-- 댓글개수 -->
        <c:if test="${a.acount>0 }">
          <a style="color: red;" href="content?num=${a.num}&currentPage=${currentPage}">[${a.acount}]</a>
        </c:if>
        
          <c:if test="${a.uploadfile!='no' }">
            <span class="glyphicon glyphicon-picture" style="color: gray;"></span>
          </c:if>
        </td>
        <td>${a.name }</td>
        <td>${a.readcount }</td>
        <td><fmt:formatDate value="${a.writeday }" pattern="yyyy-MM-dd"/></td>
      </tr>
    </c:forEach>
  </c:if>
</table>


<!-- 페이징처리 -->
<!-- 페이징 처리 -->
<c:if test="${totalCount>0}">
	<div style="width: 600px; text-align: center;" class="container">
  		<ul class="pagination">
  			 <!-- 이전 -->
				<c:if test="${startPage>1}">
				<li><a href="list?currentPage=${startPage-1}">이전</a></li>
				</c:if>
			
   			<c:forEach var="pp" begin="${startPage}" end="${endPage}">
				<c:if test="${currentPage==pp}">
					<li class="active"><a href="list?currentPage=${pp}">${pp}</a></li>
				</c:if>
				<c:if test="${currentPage!=pp}">
					<li><a href="list?currentPage=${pp}">${pp}</a></li>
				</c:if>
			</c:forEach>
   
	    	<!-- 다음 -->
			<c:if test="${endPage<totalPage}">
				<li><a href="list?currentPage=${endPage+1}">다음</a></li>
			</c:if>
      </ul>
  </div>
</c:if>
</body>
</html>
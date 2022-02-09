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

<script type="text/javascript">
$(function() {
	
	$("span.photo").click(function() {
		$("#photos").trigger("click");
	});
});
</script>

</head>
<body>
<c:if test="${sessionScope.loginok!=null }">
<form action="insert" method="post" enctype="multipart/form-data">
  <span class="glyphicon glyphicon-camera photo" style="font-size: 30px;"></span>
  <input type="file" name="photos" id="photos" style="display: none; width: 200px;" multiple="multiple">
    
    <table class="table table-bordered" style="width: 600px;">
      <tr>
        <th style="width: 120px;">닉네임</th>
          <td>
            <input type="text" name="nickname" class="form-control">
          </td>
      </tr>
      
      <tr style="height: 100px;">
          <td colspan="2" align="center">
            <textarea style="width: 550px; height: 90px;" name="content"></textarea><br>
            <button type="submit" class="btn btn-default">저장</button>
          </td>
      </tr>
    </table>
</form>
</c:if>

<!-- 리스트 출력 -->
<br><br>
<hr>
<div class="alert alert-success" style="width: 700px;">
  <b>총 ${totalCount }개의 방명록</b>
  
  <c:forEach var="a" items="${list }">
    <table id="guestlist" class="table table-bordered" style="width: 700px;">
      <tr>
        <td>
          <c:if test="${a.photo!='null'}">
            <c:forTokens var="pp" items="${a.photo }" delims=",">
              <a href="${root}/photo/${pp}">
                <img alt="" src="${root}/photo/${pp}" style="max-width: 100px;">
              </a>
            </c:forTokens>
          </c:if>
            <pre><h6>${a.content }</h6></pre>
            <hr>
            
            <h6 style="color: gray;">${a.nickname}<span style="float: right; color: gray;">
            작성일: <fmt:formatDate value="${a.writeday}" pattern="yyyy-MM-dd HH:mm"/></span></h6>
            <br>
            <button type="button" class="btn btn-default btn-xs" style="width: 60px;"
            onclick="location.href='updateform?num=${a.num}&currentPage=${currentPage}'">수정</button>
            <button type="button" class="btn btn-default btn-xs" style="width: 60px;"
            onclick="location.href='delete?num=${a.num}&currentPage=${currentPage}'">삭제</button>
        </td>
      </tr>
    </table>
  </c:forEach>
</div>


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
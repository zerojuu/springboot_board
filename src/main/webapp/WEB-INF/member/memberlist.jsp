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
<h3 class="alert alert-info" style="width: 900px;">총 ${count }명의 회원</h3>

<table class="table table-bordered" style="width: 900px;">
  <caption>전체 회원 목록</caption>
  <tr bgcolor="#fff0f5">
    <th width="50">번호</th>
    <th width="70">이름</th>
    <th width="70">아이디</th>
    <th width="150">핸드폰</th>
    <th width="180">주소</th>
    <th width="110">이메일</th>
    <th width="110">가입일</th>
    <th width="90">편집</th>
  </tr>
  
  <c:forEach var="a" items="${list }" varStatus="i">
    <tr>
      <td align="center">${i.count }</td>
      <td align="center">${a.name }</td>
      <td align="center">${a.id }</td>
      <td align="center">${a.hp }</td>
      <td align="center">${a.addr }</td>
      <td align="center">${a.email }</td>
      <td align="center"><fmt:formatDate value="${a.gaipday }" pattern="yyyy-MM-dd"/></td>   
      <td align="center">
        <button type="button" class="btn btn-default btn-xs" onclick="location.href='updatepassform?num=${a.num}'">수정</button>
        <button type="button" class="btn btn-default btn-xs del" num="${a.num}">삭제</button>
      </td>
    </tr>
  </c:forEach>
</table>

<!-- 삭제 modal..name이 아닌 id -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">삭제확인</h4>
      </div>
      
      <div class="modal-body form-inline">     
<!-- hidden처리 -->
<input type="hidden" id="delnum" >
      
        <b>삭제 비밀번호: </b>
        <input type="password" id="delpass" class="form-control" style="width: 120px;">
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default delbtn" data-dismiss="modal">삭제</button>
      </div>
    </div>

  </div>
</div>

<script type="text/javascript">
$("button.del").click(function() {
	
	var num=$(this).attr("num");  //삭제버튼에 num 심어놓기
	//alert(num);  확인용
	
	//hidden으로 읽은 num
	$("#delnum").val(num);
	
	//modal창 띄우기
	$("#myModal").modal();
	
	
	//삭제 이벤트
	$("button.delbtn").click(function() {	
		//num,pass읽기
		var num=$("#delnum").val();
		var pass=$("#delpass").val();
		console.log(num+","+pass);
		
		//삭제는 ajax로
		$.ajax({
			type:"get",
			dataType:"json",  //xml또는 json인데 json이 쉬움
			data:{"num":num,"pass":pass},
			url:"memberdelete",  //매핑주소
			success:function(data){
				
				if (data.check==1) {
					//비번이 맞은 경우..현재페이지 새로고침
					location.reload();
				}else {
					//비번이 틀린 경우
					alert("비밀번호가 틀립니다");
				}
			}
		});
	});
});
</script>

</body>
</html>
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
	
	//자바스크립트에서 var 안 붙이면 전역변수..이따 리스트에서 쓰기 위해
	num=$("#num").val();
	//alert(num);
	
	loginok="${sessionScope.loginok}";
	myid="${sessionScope.myid}";
	//alert(loginok);
	//alert(myid);
	
	//댓글목록
	list();
	
	//버튼 클릭시 insert
	$("#btnansweradd").click(function() {
		var content=$("#content").val();
		
		if(content.trim().length==0){
			alert("댓글 내용을 입력해주세요");
			return;  //입력 안하면 종료
		}
		
		//입력했을시 ajax로
		$.ajax({
			type:"post",  //insert 타입..postmapping
			//dataType:"text",  생략가능//controller에서 보면 ainsert는 void이기에 returntype이 없음..json은 returntype있을 때
			url:"ainsert",
			data:{"num":num,"content":content},
			success:function(data){
				//alert("성공");
				
				//댓글목록 가져오기
				list();
			}
		});
	});
	
	
	//댓글삭제
	$(document).on("click","span.adel",function(){
		
		var idx=$(this).attr("idx");
		//alert(idx);
		var a=confirm("해당 댓글을 삭제할까요?");
		
		if(a==true){
			$.ajax({
				type:"get",
				url:"adelete",
				data:{"idx":idx},
				success:
					function(data) {
						list();
					}
			});
		}
	});
	
	
	//수정 다이얼로그 띄우기
	$(document).on("click","span.amod",function(){
		var idx=$(this).attr("idx");
		
		$.ajax({
			type:"get",
			dataType:"json",
			url:"adata",
			data:{"idx":idx},
			success:
				function(data) {
					$("#ucontent").val(data.content);
				}
		});
		$("#myModal").modal();
	});
	
	//수정
	$(document).on("click","#btnaupdate",function(){
		
		var content=$("#ucontent").val();
		var idx=$(this).attr("idx");
		
		$.ajax({
			type:"post",
			dataType:"text",
			url:"aupdate",
			data:{"idx":idx,"content":content},
			success:
				function(data) {
					list();
				}
		});
	});
});

//리스트 ajax
//controller에서 보면 alist는 list<BoardAnswerDto>라는 반환타입이 있기에 json
function list() {
	$.ajax({
		type:"get",
		dataType:"json",
		url:"alist",
		data:{"num":num},
		success:function(data){
			
			$("span.acount").text(data.length);  //댓글 개수
			
			var s="";
			$.each(data, function(i,dto) {
				s+="<b>"+dto.name+" | </b>"+dto.content;
				s+="<span class='day'>("+dto.writeday+")</span>";
				
				//내가 쓴 글에만 수정,삭제 버튼 보이게
				if (loginok=='yes' && myid==dto.myid) {
					s+="<span class='glyphicon glyphicon-pencil amod' idx='"+dto.idx+"'></span>";
					s+="<span class='glyphicon glyphicon-trash adel' idx='"+dto.idx+"'></span>";
				}
				s+="<br>";
			});
			
			$("div.alist").html(s);
		}
	});
}

</script>

</head>
<c:set var="root" value="<%=request.getContextPath() %>"/>

<body>
<table class="table table-bordered" style="width: 600px; font-family: Do Hyeon; font-size: 17px;">
  <tr>
    <td>
      <h3><b>${dto.subject }</b>
        <span style="font-size: 14px; color: gray; float: right;"><fmt:formatDate value="${dto.writeday}" pattern="yyyy-MM-dd HH:mm"/></span>
      </h3>
        <span>작성자: ${dto.name}(${dto.myid})</span>
        <c:if test="${dto.uploadfile!='no' }">
          <span>
          <!-- downloadcontroller에서 매핑주소 참고 -->
            <a href="download?clip=${dto.uploadfile }">
              <span class="glyphicon glyphicon-download-alt"></span>
              <b style="font-size: 0.8em;">${dto.uploadfile }</b>
            </a>
          </span>
        </c:if>
    </td>
  </tr>
  
  <tr>
    <td>
      <c:if test="${bupload==true }">
        <h5>업로드 이미지파일</h5>
          <img alt="" src="${root}/photo/${dto.uploadfile }" style="max-width: 400px;">
      </c:if>
      <br><br>
      <pre>${dto.content }</pre><br>
      <b>조회 ${dto.readcount }</b> &nbsp;&nbsp;&nbsp;
      <b>댓글 <span class="acount"></span></b>
    </td>
  </tr>
  
<!-- ajax 댓글 -->
  <tr>
    <td>
      <div class="alist"></div>
      
<!-- hidden..반드시 조건문 밖에서 주기 -->
<!-- 해당 num에 접근할수 있는지 보기위해 hidden처리 -->
<input type="hidden" id="num" value="${dto.num }">

      <c:if test="${sessionScope.loginok!=null }">
        <div class="aform">
          <div class="form-inline">
            <input type="text" class="form-control" style="width: 500px;" placeholder="댓글을 입력하세요" id="content">
            <button type="button" class="btn btn-default" style="width: 60px;" id="btnansweradd">등록</button>
          </div>
        </div>
      </c:if>
    </td>
  </tr>
  
  <tr>
    <td align="center">
    <!-- 로그인중일 때만 버튼 보이기 -->
    <!-- 페이징처리하면 currentPage 필요 -->
      <c:if test="${sessionScope.loginok!=null }">
        <button type="button" class="btn btn-default" style="width: 100px;" onclick="location.href='form'">작성</button>
      </c:if>
        <button type="button" class="btn btn-default" style="width: 100px;" onclick="location.href='list?currentPage=${currentPage}'">목록</button>
   <!-- 로그인중이면서 세션의 아이디와 같은 아이디로 쓴 글에만 수정,삭제 버튼 보이기 -->
      <c:if test="${sessionScope.loginok!=null and sessionScope.myid==dto.myid }">
        <button type="button" class="btn btn-default" style="width: 100px;" onclick="location.href='updateform?num=${dto.num}&currentPage=${currentPage}'">수정</button>
        <button type="button" class="btn btn-default" style="width: 100px;" onclick="location.href='delete?num=${dto.num}&currentPage=${currentPage}'">삭제</button>
      </c:if>
    </td>
  </tr>
</table>

<!-- 수정 Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">댓글 수정</h4>
      </div>
      <div class="modal-body">
        <input type="text" id="ucontent" class="form-control">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" id="btnaupdate">수정</button>
      </div>
    </div>

  </div>
</div>
</body>
</html>
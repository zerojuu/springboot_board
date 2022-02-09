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
$(function () {
	
	//이메일 선택 이벤트
	$("#selemail").change(function() {
		if($(this).val()=='-'){
			$("#email2").val('');  //지정된 메일 지워주기
			$("#email2").focus();  //email2에 포커스 주기
		}else {
			$("#email2").val($(this).val());  //선택한 값 주기
		}
	});
	
	
	//아이디 입력후 포커스 벗어나며 체크
	$("#id").blur(function() {
		var id=$(this).val().trim();  //입력값 앞뒤 공백제거
		
		if(id.length==0){
			alert("아이디 입력해주세요");
			return;
		}
		
		//ajax
		$.ajax({
			type:"get",
			dataType:"json",
			data:{"id":id},
			url:"idcheck",
			success:function(data){
				if (data.check==1) {
					$("b.idmsg").html("<font color='red'>이미 등록된 아이디입니다</font>");
					$("#id").val("");
					$("#id").focus();
				}else {
					$("b.idmsg").html("<font color='blue'>사용 가능한 아이디입니다</font>");
				}
			}
		});
	});
});

//비밀번호 체크
function check(f) {
	if(f.pass.value!=f.pass2.value){
		alert("비밀번호가 틀립니다");
		f.pass.value="";  //pass값 지워주기
		f.pass2.value="";  //pass2값 지워주기
		return false;
	}
}
</script>

<style type="text/css">
th {
	text-align: center;
}
</style>

</head>
<body>
<form action="insert" method="post" class="form-inline" name="memberfrm"
onsubmit="return check(this)">
	
<table class="table table-bordered" style="width: 500px;">
	<caption><b>회원 가입</b></caption>
	<tr>
		<th width="100" bgcolor="#faf0e6">아이디</th>
		<td>
			<input type="text" name="id" id="id" maxlength="8" class="form-control"
				required="required" style="width: 120px;">
			<b class="idmsg"></b>   <!-- ajax -->
		</td>
	</tr>
	<tr>
		<th width="100" bgcolor="#faf0e6">비밀번호</th>
		<td>
			<input type="password" name="pass" class="form-control"
				required="required" style="width: 120px;"
				placeholder="비밀번호">
			<input type="password" name="pass2" class="form-control"
				required="required" style="width: 120px;"
				placeholder="비밀번호확인">
		</td>
	</tr>
	<tr>
		<th width="100" bgcolor="#faf0e6">이름</th>
		<td>
			<input type="text" name="name"  class="form-control"
				required="required" style="width: 120px;">			
		</td>
	</tr>
	<tr>
		<th width="100" bgcolor="#faf0e6">핸드폰</th>
		<td>
			<input type="text" name="hp"  class="form-control"
				required="required" style="width: 200px;">			
		</td>
	</tr>
	<tr>
		<th width="100" bgcolor="#faf0e6">주소</th>
		<td>
			<input type="text" name="addr"  class="form-control"
				required="required" style="width: 400px;">			
		</td>
	</tr>
	<tr>
		<th width="100" bgcolor="#faf0e6">이메일</th>
		<td>
			<input type="text" name="email1"  class="form-control"
				required="required" style="width: 80px;">	
			<b>@</b>
			<input type="text" name="email2" id="email2" class="form-control"
				required="required" style="width: 150px;">	
			<select id="selemail" class="form-control">
				<option value="-">직접입력</option>
				<option value="naver.com">네이버</option>
				<option value="nate.com">네이트</option>
				<option value="gmail.com">구글</option>
				<option value="hanmail.net">다음</option>				
			</select>	
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<button type="submit" class="btn btn-default"
			style="width: 100px;">저장</button>
			
			<button type="reset" class="btn btn-default"
			style="width: 100px;">다시</button>
			
		</td>		
	</tr>
</table>
</form>

</body>
</html>
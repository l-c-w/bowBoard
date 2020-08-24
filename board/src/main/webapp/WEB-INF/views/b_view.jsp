<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${b_view.b_title} : 자유게시판</title>
<style type="text/css">
#whole_wrap{width: 1000px; margin: 0 auto; margin-bottom: 100px;}
table{width: 1000px; }
#view_table tr{display:block; word-break:break-all; border: 1px solid #ddd; padding: 10px;}
#title{font-weight: bold; border-bottom: 5px double #ddd;}
#writer{padding-top:10px; padding-bottom: 20px;}
#writer{width:700px;}
#id{color: #2a6496; font-weight: bold;}
#date{font-size: 14px; color: grey;}
#content{height: 300px; vertical-align: top; padding-top: 10px;}
pre{width: 1000px; font-family: sans-serif; font-size: 14px; word-break:break-all; white-space: pre-wrap;}
#btnwrap{float: right; margin-top: 10px;}
#reply{width: 1030px; border-bottom: 5px double #ddd; border-top: 5px double #ddd; margin-top: 100px;}
#reply_write{width: 1030px; margin-top: 5px; padding-bottom: 5px;}
#reply_list{}

input:focus{outline: none;}
#r_name{border:none; border-bottom: 2px solid  #ddd;}
#r_pw{border:none; border-bottom: 2px solid  #ddd;}
#r_content{width:900px; height:100px; border:none; border: 2px solid  #ddd;}
#r_submit{width:100px; height:108px; background: black; color: white; border: 0; cursor: pointer;}

	
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div id="whole_wrap">
	<h3 onclick="location.href='board'" style="cursor: pointer;">자유게시판 ></h3>
	<table id="view_table">
		<tr id="title">
		<td><c:out value="${b_view.b_title }"/></td>
		</tr>
		<tr>
		<td><img alt="멤버" src="resources/images/member.png" width="60px" height="40px;"> </td>
		<td id="writer"><span id="id"><c:out value="${b_view.b_name }"/></span><br>
		<span id="date"><fmt:formatDate value="${b_view.b_date }" pattern="yy-MM-dd"/>
		<c:if test="${not empty b_view.u_date }">
		<br>최근수정 <fmt:formatDate value="${b_view.u_date }" pattern="yy-MM-dd hh:mm:ss"/>
		</c:if>
		</span>
		</td>
		
		</tr>
		<tr>
		<td id="content"><pre><c:out value="${b_view.b_content }"/></pre></td>
		</tr>
	</table>
	<div id="btnwrap">
	<button onclick="location.href='bwrite_page?type=reply&b_group=${b_view.b_group}&b_step=${b_view.b_step }&b_indent=${b_view.b_indent }'">답변달기</button>
	<button onclick="pw_check('${b_view.b_num}','${cur_page }','${b_view.b_group }','${b_view.b_step }')">수정</button>
	<button onclick="b_delete('${b_view.b_num }','${cur_page }','${b_view.b_group }','${b_view.b_step }')">삭제</button>
	<button onclick="location.href='board?cur_page=${cur_page}'">목록</button>
	</div>
	
	<div id="reply">
	<div id="reply_write">
	<h3>댓글 작성</h3>
	<form action="r_write" method="post" name="r_write" id="r_write">
	<table>
	<tr>
	<td style="width: 300px;"><label>작성자<input type="text" name="r_name" id="r_name"></label>
	<label>비밀번호<input type="password" name="r_pw" id="r_pw"></label>
	</td>
	</tr>
	<tr>
	<td><textarea name="r_content" id="r_content"></textarea></td>
	<td style="vertical-align: top;"><button type="button" id="r_submit" onclick="r_check()">등록</button></td>
	</tr>
	<tr>
	<td>
	0/300
	</td>
	</tr>
	</table>	
	</form>
	</div>
	<div id="reply_list">
	</div>
	</div>
	</div>
	
	<script>
	
		function pw_check(b_num,cur_page,b_group,b_step) {
			
			
			var popupWidth = 400;
			var popupHeight = 200;
			var popupX = (window.screen.width / 2) - (popupWidth / 2);
			var popupY= (window.screen.height / 2) - (popupHeight / 2);
			window.open('pw_check?type=update&b_num='+b_num+'&cur_page='+cur_page+'&b_group='+b_group+'&b_step='+b_step,'viewer', 'width='+popupWidth+', height='+popupHeight+',left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);	
		}
	
	
		function b_delete(b_num,cur_page,b_group,b_step) {
			var delete_check = confirm("삭제하시겠습니까?");
			
			if(delete_check){
				
				var popupWidth = 400;
				var popupHeight = 200;
				var popupX = (window.screen.width / 2) - (popupWidth / 2);
				var popupY= (window.screen.height / 2) - (popupHeight / 2);
				window.open('pw_check?type=delete&b_num='+b_num+'&cur_page='+cur_page+'&b_group='+b_group+'&b_step='+b_step,'viewer', 'width='+popupWidth+', height='+popupHeight+',left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
				
				
			}else{
				return;
			}
		}
		
		function r_check() {
			var r_data = $("form[name=r_write]").serialize();
			
			$.ajax({
				type:"post",
				url:"r_write",
				data:r_data,
				success: function(data) {
					if(data==1){
					}else{
						alert("작성에 실패했습니다.");
					}
				},
				error: function() {
					alert("통신실패");
				}
				
			});
			
		}
	
	
	
	</script>
	
	
</body>
</html>
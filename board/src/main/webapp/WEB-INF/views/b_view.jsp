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
tr{display:block; word-break:break-all; border: 1px solid #ddd; padding: 10px;}
#title{font-weight: bold; border-bottom: 5px double #ddd;}
#writer{padding-top:10px; padding-bottom: 20px;}
#writer{width:700px;}
#id{color: #2a6496; font-weight: bold;}
#date{font-size: 14px; color: grey;}
#content{height: 300px; vertical-align: top; padding-top: 10px;}
pre{width: 1000px; font-family: sans-serif; font-size: 14px; word-break:break-all; white-space: pre-wrap;}
#btnwrap{float: right; margin-top: 10px;}

	
</style>
</head>
<body>
	<div id="whole_wrap">
	<h3 onclick="location.href='board'" style="cursor: pointer;">자유게시판 ></h3>
	<table>
		<tr id="title">
		<td><c:out value="${b_view.b_title }"/></td>
		</tr>
		<tr>
		<td><img alt="멤버" src="resources/images/member.png" width="60px" height="40px;"> </td>
		<td id="writer"><span id="id"><c:out value="${b_view.b_name }"/></span><br>
		<span id="date"><fmt:formatDate value="${b_view.b_date }" pattern="yy-MM-dd"/></span>
		</td>
		
		</tr>
		<tr>
		<td id="content"><pre><c:out value="${b_view.b_content }"/></pre></td>
		</tr>
	</table>
	<div id="btnwrap">
	<button onclick="pw_check('${b_view.b_num}')">수정</button>
	<button onclick="b_delete('${b_view.b_num }')">삭제</button>
	<button onclick="history.go(-1)">목록</button>
	</div>
	</div>
	
	<script>
	
		function pw_check(b_num) {
			
			var popupWidth = 400;
			var popupHeight = 200;
			var popupX = (window.screen.width / 2) - (popupWidth / 2);
			var popupY= (window.screen.height / 2) - (popupHeight / 2);
			window.open('pw_check?type=update&b_num='+b_num,'viewer', 'width='+popupWidth+', height='+popupHeight+',left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);	
		}
	
	
		function b_delete(b_num) {
			var delete_check = confirm("삭제하시겠습니까?");
			
			if(delete_check){
				
				var popupWidth = 400;
				var popupHeight = 200;
				var popupX = (window.screen.width / 2) - (popupWidth / 2);
				var popupY= (window.screen.height / 2) - (popupHeight / 2);
				window.open('pw_check?type=delete&b_num='+b_num,'viewer', 'width='+popupWidth+', height='+popupHeight+',left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
				
				
			}else{
				return;
			}
		}
	
	
	
	</script>
	
	
</body>
</html>
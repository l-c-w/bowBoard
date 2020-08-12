<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정하기</title>
<style type="text/css">
#whole_wrap{width: 800px; margin: 0 auto;}
#b_title{width: 785px;}
#b_content{width: 785px;}
table{width: 800px; }
tr{display:block; border-bottom: 1px solid black;}
#writer{width:700px;}
#btnwrap{float: right; margin-top: 10px;}
.checking{font-size: 14px; color: red;}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

	<div id="whole_wrap">
<h3 onclick="location.href='board'" style="cursor: pointer;">자유게시판 ></h3>
	<form action="b_update" method="post" name="b_update">
	<table>
		<input type="hidden" value="${b_view.b_num }" name="b_num">
		<tr id="title">
		<td><input type="text" value="${b_view.b_title }" name="b_title" id="b_title">
			<span id="title_check" class="checking"></span>
		</td>
		</tr>
		<tr>
		<td id="writer">${b_view.b_name }</td>
		<td id="date"><fmt:formatDate value="${b_view.b_date }" pattern="yy-MM-dd"/></td>
		</tr>
		<tr>
		<td id="content"><textarea rows="10" cols="100" name="b_content" id="b_content">${b_view.b_content }</textarea>
		<span id="content_check" class="checking"></span>
		<span id="content_count" class="count">0/2000자</span>
		</td>
		</tr>
	</table>
	</form>
	<div id="btnwrap">
	<button onclick="update()">수정</button>
	<button onclick="history.go(-1)">이전</button>
	</div>
	</div>
	
	<script >
	$(document).ready(function() {
		
		/* 			$("#b_title").keypress(function(e) {
						if (e.keyCode == 13) e.preventDefault();
					});
		 */			$("#b_title").keyup(function() {
						var content = $(this).val();
						/* $("#title_count").html("<span id='title_count' class='count'>("+content.length+"/100)</span>"); */
						$("#title_check").text("");
						if(content.length>100){
							alert("제목은 최대 100자까지 입력가능합니다.");
							$(this).val($(this).val().substring(0, 100));
							/* $("#title_count").html("<span id='title_count' class='count'>(100/100)</span>"); */
						}				
					});
					
					
					
					$("#b_content").keyup(function() {
						var content = $(this).val();
						$("#content_count").html("<span id='content_count' class='count'>("+content.length+"/2000)</span>");
						if(content.length>2000){
							alert("본문은 최대 2000자까지 입력가능합니다.");
							$(this).val($(this).val().substring(0, 2000));
							$("#content_count").html("<span id='content_count' class='count'>(2000/2000)</span>");
						}	
					});
					
				});
	
	
			function update() {
			
				if($("#b_title").val()==""){
					$("#b_title").focus();
					$("#title_check").text("※제목란을 채워주세요.");
					return;
				}
			
				if($("#b_content").val()==""){
					$("#b_content").focus();
					$("#b_content").attr("placeholder","내용을 채워주세요.");
					return;
				}
			
			var update_check= confirm("수정하시겠습니까?");
			if (update_check) {
				b_update.submit();
			}else{
				return;
			}
		}
	
	
	</script>

</body>
</html>
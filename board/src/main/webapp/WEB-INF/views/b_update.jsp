<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<style type="text/css">
#whole_wrap{width: 1000px; margin: 0 auto;}
label {display: inline-block; width: 130px; margin-bottom: 10px; font-weight: bold;}
input:focus{outline: none;}
#b_title{width: 1000px; border:none; border-bottom: 2px solid black;}
#b_content{width: 785px;}
table{width: 1000px; }
tr{display:block;}
#writer{padding-top:10px; padding-bottom: 20px;}
#writer{width:700px;}
#id{color: #2a6496; font-weight: bold;}
#date{font-size: 14px; color: grey;}
#b_content{width: 1000px; border: 2px solid black;}
.count{color: #aaa}
#btnwrap{float: right; margin-top: 10px;}
.checking{font-size: 14px; color: red;}

.files{margin-bottom: 5px;}
	.input_files{width: 500px;}
	#select_file button{width: 10px; height: 10px;}
	.cancle{width: 15px; height: 15px; cursor: pointer; margin-left: 5px;}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

	<div id="whole_wrap">
		<h3 onclick="location.href='board'" style="cursor: pointer;">자유게시판 ></h3>
		<h1>글수정</h1>
	<form action="b_update" method="post" name="b_update" enctype="multipart/form-data">
	<table>
		<input type="hidden" value="${b_view.b_num }" name="b_num">
		<input type="hidden" value="${cur_page }" name="cur_page">
		<tr id="title">
		<td>
		<label for="b_title">제목</label><br><input type="text" value="${b_view.b_title }" name="b_title" id="b_title">
		<br>
		<span id="title_check" class="checking"></span>
		<br>
		</td>
		</tr>
		</tr>
		<tr>
		<td><img alt="멤버" src="resources/images/member.png" width="60px" height="40px;"> </td>
		<td id="writer"><span id="id"><c:out value="${b_view.b_name }"/></span><br>
		<span id="date"><fmt:formatDate value="${b_view.b_date }" pattern="yy-MM-dd"/></span>
		</td>
		
		</tr>
		<tr>
		<td id="content">
		<textarea rows="10" cols="100" name="b_content" id="b_content">${b_view.b_content }</textarea>
		<span id="content_count" class="count">0/2000자</span>
		<span id="content_check" class="checking"></span>
		</td>
		</tr>
		<tr>
		<td>
		<c:choose>
		<c:when test="${empty b_view.b_files }">
		<h3>첨부파일<span style="color: #FF5E00;" id="file_count">(0)</span></h3>
		<div id="input_file">
		</div>
		</c:when>
		<c:when test="${not empty b_view.b_files }">
		<c:set var="file_names" value="${fn:split(b_view.b_file_names,'*') }"/>
		<h3>첨부파일<span style="color: #FF5E00;" id="file_count">(${fn:length(file_names) })</span><span style="font-size: 14px;" >&nbsp&nbsp※최대 5개</span></h3>
		
			<div id="input_file">
		<c:forEach var="files1" items="${file_names }" varStatus="status">
				<div class="file${status.index+1 }"><span class="files">${files1 }</span>
				<label class="input_files"><button type="button" onclick="remove_file('file${status.index+1 }')" style="display: none;"></button>
				<img class="cancle" alt="취소" src="resources/images/cancle.png"></label><br>
		</c:forEach>
		</c:when>		
		</c:choose>
			</div>
		
		</div>
		<div id="select_file">
		<input type="file" name="files" id="file${fn:length(file_names)+1 }" class="files" onchange="after_input(this.id)"><br>
		</div>
		</td>
		</tr>
		
	</table>
	</form>
	<div id="btnwrap">
	<button type="button" onclick="update()">수정</button>
	<button type="button" onclick="history.go(-1)">이전</button>
	</div>
	</div>
	
	<script >
	$(document).ready(function() {
		
		$("#content_count").html("<span id='content_count' class='count'>("+$("#b_content").val().length+"/2000)</span>");
		
		$("#b_title").on("input",function() {
			var content = $(this).val();
			if(content.length>100){
				alert("제목은 최대 100자까지 입력가능합니다.");
				$(this).val($(this).val().substring(0, 100));
				$(this).focus();
			}				
		});
		
		$("#b_content").on("input",function() {
			var content = $(this).val();
			$("#content_count").html("<span id='content_count' class='count'>("+content.length+"/2000)</span>");
			if(content.length>2000){
				alert("본문은 최대 2000자까지 입력가능합니다.");
				$(this).val($(this).val().substring(0, 2000));
				$(this).focus();
				$("#content_count").html("<span id='content_count' class='count'>(2000/2000)</span>");
			}	
		});
					
				});
	
	
			function update() {
				if($("#b_title").val().replace(/ /g, "").length==0){
					$("#b_title").val('');
					$("#b_title").attr("placeholder","제목을 입력하세요.");
					$("#b_title").focus();
					$("#title_check").text("※제목이 비어있습니다.");
					return;
				}
			
				if($("#b_content").val().replace(/ /g, '').length==0){
					$("#b_content").val('');
					$("#b_content").attr("placeholder","내용을 입력하세요.");
					$("#b_content").focus();
					$("#content_check").text("※내용이 비어있습니다.");
					return;
				}
			
			var update_check= confirm("수정하시겠습니까?");
			if (update_check) {
				b_update.submit();
			}else{
				return;
			}
		}
			
			function remove_file(get_class) {
				var remove_id="#"+get_class;
				var remove_class="."+get_class;
				$(remove_id).remove();
				$(remove_class).remove();
				 $("#file_count").html('('+($(".files").length-1)+')');
			}
			
			function after_input(this_id) {
				
				$("#file_count").html('('+$(".files").length+')');
				
				//id값 셋팅
				var thisId= "#"+this_id;
				var set_num= (this_id.substring(4, 5)*1)+1;
				var set_id= "file"+set_num;
				
				
				if($(".files").length>5){
					alert("파일 업로드는 5개까지 가능합니다.");
					$("#file_count").html('(5)');
					$(thisId).val("");
					return;
				}
				
								
				//파일명 가져오기
				var file_id="#"+this_id;
				var fileValue=$(file_id).val().split("\\");
				
				var fileName=fileValue[fileValue.length-1];
				
				
				$(file_id).css("display","none");
				$("#input_file").append('<div class='+this_id+'><span>'+fileName+'</span><label class="input_files"><button type="button" onclick="remove_file(`'+this_id+'`)" style="display: none;"></button><img class="cancle" alt="취소" src="resources/images/cancle.png"></label><br></div>');
				$("#select_file").append('<input type="file" name="files" id='+set_id+' class="files" onchange="after_input(this.id)" >');
				
				
				
			}
	
	
	</script>

</body>
</html>
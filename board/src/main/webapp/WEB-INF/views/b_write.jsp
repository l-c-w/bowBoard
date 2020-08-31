<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
	<style type="text/css">
	div{width: 1000px; margin: 0 auto;}
	
	label {display: inline-block; width: 130px; margin-bottom: 10px; font-weight: bold;}
	input:focus{outline: none;}
	#b_title{width: 1000px; border:none; border-bottom: 2px solid black;}
	#b_name{border:none; border-bottom: 2px solid black;}
	#b_content{width: 1000px; border: 2px solid black;}
	#b_pw{vertical-align: top; border:none; border-bottom: 2px solid black;}
	#notice{font-size: 12px; color: #666}
	#pw_wrap{height: 50px; padding: 0px;}
	#btn_wrap{width:500px; text-align: center; margin-bottom: 100px;}
	.count{color: #aaa}
	.checking{font-size: 14px; color: red;}
	
	.files{margin-bottom: 5px;}
	.input_files{width: 500px;}
	#select_file button{width: 10px; height: 10px;}
	.cancle{width: 15px; height: 15px; cursor: pointer; margin-left: 5px;}
	</style>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div>
	<h3 onclick="location.href='board'" style="cursor: pointer;">자유게시판 ></h3>
	<c:choose>
		<c:when test="${empty type }">
		<h1>글쓰기</h1>
		</c:when>
		<c:when test="${type eq 'reply' }">
		<h1>답변 작성</h1>
		</c:when>
	</c:choose>
	<form action="b_write" method="post" name="b_write" enctype="multipart/form-data">
		<label for="b_title">제목</label><br><input type="text" name="b_title" id="b_title" class="all_check" placeholder="제목을 입력하세요.">
		<br>
		<span id="title_check" class="checking"></span>
		<br>
		
		<label>작성자</label><br><input type="text" name="b_name" id="b_name" class="all_check" placeholder="작성자명을 입력하세요.">
		<br>
		<span id="name_check" class="checking"></span>
		<br>
		
		<div id="pw_wrap">
		<label>비밀번호</label><br><input type="password" name="b_pw" id="b_pw" class="all_check" placeholder="비밀번호를 입력하세요.">
		<span id="notice">*수정,삭제시 사용됩니다. 최대 10자리, 영문/숫자만 입력가능합니다.</span>
		<br>
		<span id="pw_check" class="checking"></span>
		<br>
		
		</div>
		<br>
		<br>
		
		<textarea rows="10" cols="100" name="b_content" id="b_content" class="all_check" placeholder="내용을 입력하세요."></textarea>
		<span id="content_count" class="count">0/2000자</span>
		<span id="content_check" class="checking"></span>
		
		<h3>첨부파일<span style="color: #FF5E00;" id="file_count">(0)</span><span style="font-size: 14px;" >&nbsp&nbsp※최대 5개(파일당 최대 10MB)</span></h3>
		<div id="input_file">
		</div>
		
		<div id="select_file">
		<input type="file" name="files" id="file1" class="files"  onchange="after_input(this.id)"><br>
		</div>
		
		
	</form>
	<div id="btn_wrap">
	<c:choose>
		<c:when test="${empty type }">
		<button style="margin-right: 5px;" onclick="write_check()">작성</button>
		<button onclick="history.go(-1)">목록</button>
		</c:when>
		<c:when test="${type eq 'reply' }">
		<button style="margin-right: 5px;" onclick="write_check('${type}','${b_group }','${b_step }','${b_indent }')">작성</button>
		<button onclick="history.go(-1)">이전</button>
		</c:when>
	</c:choose>
		
	</div>
	</div>
	
	<script>
		$(document).ready(function() {
			
		$(".cancle").hide();	
			
		
		
			
		$("#b_title").on("input",function() {
				var content = $(this).val();
				if(content.length>100){
					alert("제목은 최대 100자까지 입력가능합니다.");
					$(this).val($(this).val().substring(0, 100));
					$(this).focus();
				}				
			});
			
			
			$("#b_name").on("input",function() {
				var content = $(this).val();
				if(content.length>10){
					alert("작성자명은 최대 10자까지 입력가능합니다.");
					$(this).val($(this).val().substring(0, 10));
					$(this).focus();
				}	
			});
			
			$("#b_pw").on("input",function() {
				var content = $(this).val();
				if(content.length>10){
					alert("비밀번호는 최대 10자까지 입력가능합니다.");
					$(this).val($(this).val().substring(0, 10));
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
		
			
		function write_check(type,b_group,b_step,b_indent) {
			
			if($("#b_title").val().replace(/ /g, "").length==0){
				$("#b_title").val('');
				$("#b_title").focus();
				$("#b_title").attr("placeholder","제목을 입력하세요.");
				$("#title_check").text("※제목이 비어있습니다.");
				return;
			}
			
			if($("#b_name").val().replace(/ /g, '').length==0){
				$("#b_name").val('');
				$("#b_name").focus();
				$("#name_check").text("※작성자란이 비어있습니다.");
				return;
			}
			
			if($("#b_pw").val().replace(/ /g, '').length==0){
				$("#b_pw").val('');
				$("#b_pw").focus();
				$("#pw_check").text("※비밀번호란이 비어있습니다.");
				return;
			}
			
			var pw_check=/^[A-Za-z0-9+]*$/; 
			
			if(!(pw_check.test(b_write.b_pw.value))){
				alert("비밀번호는 영문/숫자만 입력가능합니다.");
				form.id.focus();
				return false;
			}
			
			if($("#b_content").val().replace(/ /g, '').length==0){
				$("#b_content").val('');
				$("#b_content").focus();
				$("#content_check").text("※내용이 비어있습니다.");
				return;
			}else{
				
					
				if(type=="reply"){
					b_write.action='b_reply?b_group='+b_group+'&b_step='+b_step+'&b_indent='+b_indent;
					b_write.method='post';
					b_write.submit();
					
					
				}else{
					b_write.action='b_write';
					b_write.method='post';
					b_write.submit();
					
				}
				
				
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
			
			var thisId= "#"+this_id;
			//파일 사이즈 
			var fileSize= document.getElementById(this_id).files[0].size;
			//최대 사이즈
			var maxSize = 1024 * 1024 * 10;
			
			//파일사이즈 제한
			if(fileSize>maxSize){
				alert("파일용량은 10MB까지 가능합니다.");
				$(thisId).val("");
				return;
			}
			//파일 업로드 갯수 제한
			if($("input[name='files']").length>5){
				alert("파일 업로드는 5개까지 가능합니다.");
				$("#file_count").html('(5)');
				$(thisId).val("");
				return;
			}
			//첨부파일 갯수 변경
			$("#file_count").html('('+$(".files").length+')');
			
			//id값 셋팅
			var set_num= (this_id.substring(4, 5)*1)+1;
			var set_id= "file"+set_num;
			
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
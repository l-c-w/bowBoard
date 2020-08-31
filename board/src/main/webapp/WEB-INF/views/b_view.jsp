<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${b_view.b_title} : 자유게시판</title>
<style type="text/css">
a{scroll-behavior: smooth;}
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
#reply_list{font-size: 14px; color: grey;}

input:focus{outline: none;}
#r_name{border:none; border-bottom: 2px solid  #ddd;}
#r_pw{border:none; border-bottom: 2px solid  #ddd;}
#r_content{width:912px; height:100px; border:none; border: 2px solid  #ddd;}
#r_submit{width:100px; height:108px; background: black; color: white; border: 0; cursor: pointer;}

ul{width:1000px; height:100%; text-decoration: none; list-style: none; padding-left: 0;}
li{width: 1000px;}
#r_Lname{color: #2a6496; font-weight: bold; margin-right: 5px;}
#r_date{font-size: 12px; color: grey;}

.count{color: #aaa}

	
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div id="whole_wrap">
	<h3 onclick="location.href='board'" style="cursor: pointer;" id="top">자유게시판 ></h3>
	<table id="view_table">
		<tr id="title">
		<td>
		<c:choose>
		<c:when test="${not empty b_view.b_content }">		
		<c:out value="${b_view.b_title }"/>
		</c:when>
		<c:when test="${empty b_view.b_content }">
		<del><em><c:out value="${b_view.b_title }"/></em></del>
		</c:when>
		</c:choose>
		</td>
		</tr>
		<tr>
		<td><img alt="멤버" src="resources/images/member.png" width="60px" height="40px;"> </td>
		<td id="writer"><span id="id"><c:out value="${b_view.b_name }"/></span><br>
		<span id="date"><fmt:formatDate value="${b_view.b_date }" pattern="yy-MM-dd"/>
		<c:if test="${not empty b_view.u_date }">
		<br>
		<c:choose>
		<c:when test="${not empty b_view.b_content }">
		최근수정 
		</c:when>
		<c:when test="${empty b_view.b_content }">
		삭제일시
		</c:when>
		</c:choose>
		<fmt:formatDate value="${b_view.u_date }" pattern="yy-MM-dd HH:mm:ss"/>
		</c:if>
		</span>
		</td>
		
		</tr>
		
		<tr>
		<td id="content"><pre><c:out value="${b_view.b_content }"/></pre></td>
		</tr>
		
		<tr>
		<c:choose>
		<c:when test="${empty b_view.b_files }">
		<td><h3>첨부파일<span style="color: #FF5E00;">(0)</span></h3>
		</c:when>
		<c:when test="${not empty b_view.b_files }">
		<c:set var="files" value="${fn:split(b_view.b_files,'*') }"/>
		<c:set var="file_names" value="${fn:split(b_view.b_file_names,'*') }"/>
		<td><h3>첨부파일<span style="color: #FF5E00;">(${fn:length(files) })</span></h3>
		<c:forEach var="files1" items="${files }" varStatus="status">
			<div>
				<label style="margin-right: 10px; cursor: pointer;"><button type="button" onclick="download('${file_names[status.index] }','${files1 }')" style="display: none;"></button>
				<img src="resources/images/download.png" width="20px" height="20px" >
				${file_names[status.index] }</label></div><br>
		</c:forEach>
		</c:when>
		</c:choose>
		</td>
		</tr>
	</table>
	<div id="btnwrap">
	<c:choose>
	<c:when test="${not empty b_view.b_content }">
	<button type="button" onclick="location.href='bwrite_page?type=reply&b_group=${b_view.b_group}&b_step=${b_view.b_step }&b_indent=${b_view.b_indent }'">답변달기</button>
	<button type="button" onclick="pw_check('${b_view.b_num}','${cur_page }','${b_view.b_group }','${b_view.b_step }')">수정</button>
	<button type="button" onclick="b_delete('${b_view.b_num }','${cur_page }','${b_view.b_group }','${b_view.b_step }')">삭제</button>
	</c:when>
	<c:when test="${empty b_view.b_content }"></c:when>
	</c:choose>
	<button type="button" onclick="location.href='board?cur_page=${cur_page}'">목록</button>
	</div>
	
	<div id="reply">
	<div id="reply_write">
	<h3>댓글 작성</h3>
	<form action="r_write" method="post" name="r_write" id="r_write">
	<input type="hidden" name="m_num" id="m_num" value="${b_view.b_num}">
	<table>
	<tr>
	<td style="width: 300px;"><label>작성자&nbsp&nbsp&nbsp<input type="text" name="r_name" id="r_name"></label>&nbsp&nbsp&nbsp&nbsp&nbsp
	<label>비밀번호&nbsp&nbsp&nbsp<input type="password" name="r_pw" id="r_pw"></label>
	</td>
	</tr>
	<tr>
	<td><textarea name="r_content" id="r_content"></textarea></td>
	<td style="vertical-align: top;"><button type="button" id="r_submit" onclick="r_check()">등록</button></td>
	</tr>
	<tr>
	<td>
	<span id="r_content_count" class="count">(0/300)</span>
	</td>
	</tr>
	</table>	
	</form>
	</div>
	<div id="reply_list">
	</div>
	</div>
	
	<div id="save_point">
	<h3><span style="color: #FF5E00; padding-left: 10px;">${r_count }</span> 개의 댓글이 달려있습니다.</h3>
			<c:forEach var="rList" items="${r_list }">
		<ul style="width:1010px; border-bottom: 1px solid #ddd; padding: 10px;" id="${rList.r_num }ul">
			<li style="height: 30px;">
			<img alt="멤버" src="resources/images/member.png" width="30px" height="20px;">
				<span id="${rList.r_num }r_Lname">${rList.r_name }</span>
			<fmt:formatDate var="r_date" value="${rList.r_date }" pattern="yy-MM-dd"/>
			<fmt:formatDate var="today" value="${now }" pattern="yy-MM-dd" />
			<span id="r_date" class="${rList.r_num }r_date">[
			<c:choose>
			<c:when test="${today eq r_date }">
			<fmt:formatDate value="${rList.r_date }" pattern="HH:MM"/>
			</c:when>
			<c:when test="${today ne r_date }">
			<c:out value="${r_date }"/> 
			</c:when>
			</c:choose>
			]</span>	
			</li>
			<div id="${rList.r_num }">
			<li style="margin-bottom: 10px; width: 1000px; word-break:break-all;" id="${rList.r_num }r_content"><c:out value="${rList.r_content }"/></li>
			<li  style="width:1030px; height:20px; margin-left: 920px;">
				<button class="btn" type="submit" onclick="rpw_check('${rList.r_num }')">수정</button>
				<button class="btn" type="submit" onclick="r_delete('${rList.r_num }')">삭제</button>
			</li>
			</div>	
		</ul>
			</c:forEach>
	</div>
	
	</div>
	<div style="position: fixed; bottom: 10px; right: 100px;">
		<a href="#top"><img alt="최상단으로" src="resources/images/go_top.png" style="width: 100px; height: 100px;"> </a>
	</div>
	<script>
		$(document).ready(function() {
			
			$("#r_name").on("input",function() {
				var content = $(this).val();
				if(content.length>10){
					alert("작성자명은 최대 10자까지 입력가능합니다.");
					$(this).val($(this).val().substring(0, 10));
					$(this).focus();
				}	
			});
			
			$("#r_pw").on("input",function() {
				var content = $(this).val();
				if(content.length>10){
					alert("비밀번호는 최대 10자까지 입력가능합니다.");
					$(this).val($(this).val().substring(0, 10));
					$(this).focus();
				}	
			});
			
			$("#r_content").on("input",function() {
				var content = $(this).val();
				$("#r_content_count").html("<span id='r_content_count' class='count'>("+content.length+"/300)</span>");
				if(content.length>300){
					alert("본문은 최대 300자까지 입력가능합니다.");
					$(this).val($(this).val().substring(0, 300));
					$(this).focus();
					$("#r_content_count").html("<span id='r_content_count' class='count'>(300/300)</span>");
				}	
			});
			
			$("#ru_content").on("input",function() {
				var content = $(this).val();
				$("#ru_content_count").html("<span id='ru_content_count' class='count'>("+content.length+"/300)</span>");
				if(content.length>300){
					alert("본문은 최대 300자까지 입력가능합니다.");
					$(this).val($(this).val().substring(0, 300));
					$(this).focus();
					$("#ru_content_count").html("<span id='ru_content_count' class='count'>(300/300)</span>");
				}	
			});
			
			$("a[href='#top']").click(function() {
				$("html").animate({scrollTop:0},"slow");
				return false;
			});
			
		});
	
		//본글 수정 비밀번호 체크
		function pw_check(b_num,cur_page,b_group,b_step) {
			
			
			var popupWidth = 400;
			var popupHeight = 200;
			var popupX = (window.screen.width / 2) - (popupWidth / 2);
			var popupY= (window.screen.height / 2) - (popupHeight / 2);
			window.open('pw_check?type=update&b_num='+b_num+'&cur_page='+cur_page+'&b_group='+b_group+'&b_step='+b_step,'viewer', 'width='+popupWidth+', height='+popupHeight+',left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);	
		}
	
		//본글 삭제 비밀번호 체크
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
		
		//댓글 등록
		function r_check() {
			
			if($("#r_name").val().replace(/ /g, '').length==0){
				$("#r_name").val('');
				alert("작성자를 입력해주세요.");
				$("#r_name").focus();
				return;
			}
			
			if($("#r_pw").val().replace(/ /g, '').length==0){
				$("#r_pw").val('');
				alert("비밀번호를 입력해주세요");
				$("#r_pw").focus();
				return;
			}
			
			var pw_check=/^[A-Za-z0-9+]*$/; 
			
			if(!(pw_check.test(r_write.r_pw.value))){
				alert("비밀번호는 영문/숫자만 입력가능합니다.");
				$("#r_pw").focus();
				return;
			}
			
			if($("#r_content").val().replace(/ /g, '').length==0){
				$("#r_content").val('');
				alert("내용을 입력해주세요.");
				$("#r_content").focus();
				return;
			}else{
				var r_data = $("form[name=r_write]").serialize();
				
				$.ajax({
					type:"post",
					url:"r_write",
					data:r_data,
					success: function(data) {
						if(data==1){
							alert("댓글이 등록되었습니다.");
							window.location.reload();
							$(window).scrollTop($("#save_point").offset().top);
						}else{
							alert("작성에 실패했습니다.");
						}
					},
					error: function() {
						alert("통신실패");
					}
					
				});
					
			}
							}
		
	
	//댓글 수정 비밀번호 체크
	function rpw_check(r_num) {
		
				var popupWidth = 400;
				var popupHeight = 200;
				var popupX = (window.screen.width / 2) - (popupWidth / 2);
				var popupY= (window.screen.height / 2) - (popupHeight / 2);
				window.open('pw_check?type=r_update&r_num='+r_num,'viewer', 'width='+popupWidth+', height='+popupHeight+',left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);	
				
		}
	
	//수정창으로 변경
	function r_change(r_num) {
		
		$("#reply_write").hide();
		$(".btn").hide();
		var r_num_id="#"+r_num;
		var r_content_id= "#"+r_num+"r_content";		
		var r_content = $(r_content_id).text();
		var r_c_length = r_content.length;
		
		
		
		
		var html='<textarea name="ru_content" id="ru_content" rows="5" cols="138" style="margin-bottom:5px;">'+r_content+'</textarea>'
					+'<span id="ru_content_count" class="count">('+r_c_length+'/300)</span>'
					+'<li  style="width:1030px; height:20px; margin-left: 920px;">'
					+'<button type="button" onclick="r_update('+r_num+')" style="margin-right:5px;">확인</button>'
					+'<button type="button" onclick="go_back()">취소</button>'
					+'</li>';		
					
		$(r_num_id).html(html);
		
		$("#ru_content").on("input",function() {
			var content = $(this).val();
			$("#ru_content_count").html("<span id='ru_content_count' class='count'>("+content.length+"/300)</span>");
			if(content.length>300){
				alert("본문은 최대 300자까지 입력가능합니다.");
				$(this).val($(this).val().substring(0, 300));
				$(this).focus();
				$("#ru_content_count").html("<span id='ru_content_count' class='count'>(300/300)</span>");
			}	
		});
			
	}
	
	//댓글 삭제 비밀번호 체크
	function r_delete(r_num) {
		
		
		
		
		var del_check= confirm("댓글을 삭제하시겠습니까?");
		
		if(del_check){
			var popupWidth = 400;
			var popupHeight = 200;
			var popupX = (window.screen.width / 2) - (popupWidth / 2);
			var popupY= (window.screen.height / 2) - (popupHeight / 2);
			window.open('pw_check?type=r_delete&r_num='+r_num,'viewer', 'width='+popupWidth+', height='+popupHeight+',left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);	
		}else{
			return;
		}
		
	
		
			
	}
	//리플 수정
	 function r_update(r_num) {
		var ul_id = "#"+r_num+"ul";
		 if($("#ru_content").val().replace(/ /g, '').length==0){
				$("#ru_content").val('');
				alert("내용을 입력해주세요.");
				$("#ru_content").focus();
				return;
			}else{
		var r_content =$("#ru_content").val();
		
		   $.ajax({
			type:"post",
			url:"r_update",
			data:{"r_num":r_num,"r_content":r_content},
			success: function(data) {
				document.location.reload(true);
			},error: function () {
				alert("통신실패");
			}
			
		}); 
			}
		
	}
	
	function go_back() {
		document.location.reload(true);
	}
	
	//파일 다운로드
	function download(ori_name,full_name) {
		
		location.href = "file_down?full_name="+full_name+"&ori_name="+ori_name;
		
	}
	
	</script>
	
	
</body>
</html>
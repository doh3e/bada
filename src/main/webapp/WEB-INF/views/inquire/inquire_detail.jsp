<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/review_detail.css" rel="stylesheet" type="text/css">
    <meta charset="UTF-8">
    <title>바라는 바다! :: 문의글</title>
    <style>
    
    	html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        table {
            width: 80%;
            margin: 0 auto;
            font-size: 14px;
            border-collapse: collapse;
            height: 500px
        }
        th, td {
            text-align: left;
            padding: 8px;
        }
        th {
            border-bottom: 1px solid #ddd;
            width: 10%;
        }
        td {
            border-bottom: 1px solid #ddd;
            vertical-align: top;
        }
        .right-align {
            text-align: right;
        }
    </style>
</head>
<body>
<div class="review-box">
    <form action="inquire_reply_save" method="post">
        <table>
            <tr>
                <th>제목</th>
                <td style="text-align: left;">${dto.title} <span style="float: right;">[${dto.category}]</span></td>
            </tr>
            <tr>
                <th>답변 상태</th>
                <td style="text-align: left;">${dto.reply == 0 ? '미응답' : '완료'} <span style="float: right;">${dto.name}(${fn:substring(dto.id, 0, 4)}****) 님</span></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: left;">추천수: ${dto.rec} &nbsp; 조회수: ${dto.cnt}
                <span style="float: right;">${fn:substring(dto.i_date, 0, 19)}</span>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="border: 2px solid #000; padding: 8px; height: 80%; padding-left: 50px;">
    				<div class="inquire-images" style="width: 90%; height: 90%;">
				        ${dto.content}
				        <br><br><br><br><br>
				        <c:choose>
						    <c:when test="${not dto.pic1.equals('nope')}">
						        <img src="./resources/image_user/${dto.pic1}" width="200px">
						    </c:when>
						    <c:otherwise> </c:otherwise>
						</c:choose>
						<c:choose>
						    <c:when test="${not dto.pic2.equals('nope')}">
						        <img src="./resources/image_user/${dto.pic2}" width="200px">
						    </c:when>
						    <c:otherwise> </c:otherwise>
						</c:choose>
						<c:choose>
						    <c:when test="${not dto.pic3.equals('nope')}">
						        <img src="./resources/image_user/${dto.pic3}" width="200px">
						    </c:when>
						    <c:otherwise> </c:otherwise>
						</c:choose>
						<c:choose>
						    <c:when test="${not dto.pic4.equals('nope')}">
						        <img src="./resources/image_user/${dto.pic4}" width="200px">
						    </c:when>
						    <c:otherwise> </c:otherwise>
						</c:choose>
						<c:choose>
						    <c:when test="${not dto.pic5.equals('nope')}">
						        <img src="./resources/image_user/${dto.pic5}" width="200px">
						    </c:when>
						    <c:otherwise> </c:otherwise>
						</c:choose>
				    </div>
				</td>
            </tr>
            
            <c:choose>
            	<c:when test="${loginid eq dto.id || position=='admin'}">
            	<tr>
                <td colspan="2" style="text-align: center;">
                	<span style="float: left;">
                		<a href="#" onclick="confirmDelete('${dto.inquire_num}')">
    						<img src="./resources/image/delete_icon.png" width="20px" class="report_icon"></a>
		        		<br> 삭제하기
		        	</span>
			        <a href="inquire_listout"><input type="button" value="목록으로 돌아가기"></a>
			        <span style="float: right;">
			        	<a href="inquire_modify?inquire_num=${dto.inquire_num}"> <img src="./resources/image/modify_icon.png" width="20px" class="like_icon"> </a>
			        	<br>수정하기
			        </span>
			    </td>
            </tr>
            	</c:when>
            	
            	<c:otherwise>
            
            <c:choose>
				<c:when test="${loginstate==true}">
            <tr>
            
                <td colspan="2" style="text-align: center;">
                	<span style="float: left;">
                		<a href="inquire_report_view?inquire_num=${dto.inquire_num}&loginid=${loginid}"> <img src="./resources/image/report_icon.png" width="20px" class="report_icon"></a>
		        		<br> 신고하기
		        	</span>
			        <a href="inquire_listout"><input type="button" value="목록으로 돌아가기"></a>
			        <span style="float: right;">
			        	<a href="inquire_recommand?inquire_num=${dto.inquire_num}&loginid=${loginid}"> <img src="./resources/image/like_icon.png" width="20px" class="like_icon"> </a>
			        	<br>추천 ${dto.rec}
			        </span>
			    </td>
            </tr>
            </c:when>
            
            <c:otherwise>
            <tr>
                <td colspan="2" style="text-align: center;">
			        <a href="inquire_listout"><input type="button" value="목록으로 돌아가기"></a>
				        <br><br><br><br><br>
				        로그인한 회원만 추천, 신고 기능을 이용할 수 있습니다.
				        <br><br><br>
				</td>
            </tr>
            </c:otherwise>
            </c:choose>
            
            </c:otherwise>
            
            </c:choose>
            
         </table>
    </form>      
    
  </div> 


<div class="comments-container">  
    <!-- 댓글 영역 -->   
    <c:forEach items="${list}" var="l">
            <tr>
            	<td colspan="2" style="text-align: left;">관리자
                	<span style="float: right;">${fn:substring(l.inquire_reply_date, 0, 19)}</span>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="border: 2px solid #000; padding: 8px; height: 80%; padding-left: 50px;">
    				<div style="width: 90%; height: 90%;">
    				${l.content}
				    </div>
				</td>
            </tr>
            </c:forEach>
            <c:choose>
				<c:when test="${loginstate==true && position=='admin'}">
				
				<tr id="reply_${l.inquire_reply_num}">
			    <td colspan="2">
			        &nbsp;
			        <a href="#" onclick="confirm_reply_Delete('${l.inquire_reply_num}' , '${dto.inquire_num}')">
			            <img src="./resources/image/delete_icon.png" width="15px"></a>
			        &nbsp; &nbsp; &nbsp;
			        <a href="#" onclick="createEditForm('${l.inquire_reply_num}', '${dto.inquire_num}', '${l.content}')">
			            <img src="./resources/image/modify_icon.png" width="15px">
			        </a>
			        <br> 삭제 &nbsp; &nbsp;수정
			    
			    
			    </td>
			</tr>
            <tr>
                <td>
                
                	<div class="reply_input_area">
                	<textarea name="reply" id="reply" placeholder="문의에 대한 답은 1500자 이하로 입력하세요." required></textarea>
                	</div>
                	<div class="button_area">
                		<input type="hidden" name="inquire_num" value="${dto.inquire_num}">
                		<input type="submit" id="replybtn" value="답 작성하기">
                	</div>
                </td>
            </tr>
            
            </c:when>
            
            </c:choose>
            

</div>    
    





<script type="text/javascript">
function confirmDelete(inquire_num) {
    if(confirm('문의를 정말 삭제하시겠습니까?')) {
        location.href = 'inquire_delete?inquire_num=' + inquire_num;
    }
}
</script>

<script type="text/javascript">
function confirm_reply_Delete(inquire_reply_num, inquire_num) {
    if(confirm('답변을 정말 삭제하시겠습니까?')) {
        location.href = 'inquire_reply_delete?inquire_reply_num=' + inquire_reply_num + '&inquire_num=' + inquire_num;
    }
}
</script>

<script type="text/javascript">
function createEditForm(inquire_reply_num, inquire_num, content) {
    console.log('inquire_reply_num:', inquire_reply_num);
    console.log('inquire_num:', inquire_num);
    console.log('content:', content);
    
    // 수정 폼 HTML 생성
    var formHtml = '<form id="editForm_' + inquire_reply_num + '">' +
                       '<textarea cols="90" rows="5" id="content_' + inquire_reply_num + '" name="newcontent">' + content + '</textarea><br>' +
                       '<span style="float: right;"> <input type="button" value="답변 수정" onclick="submitEditedReply(\'' + inquire_reply_num + '\', \'' + inquire_num + '\')"> </span>' +
                       '<input type="hidden" name="inquire_reply_num" value="' + inquire_reply_num +'">' +
                       '<input type="hidden" name="inquire_num" value="' + inquire_num +'">' +
                   '</form>';
    
    // 수정 폼을 해당 댓글 영역에 추가
    var targetElement = document.getElementById('reply_' + inquire_reply_num);
    if(targetElement) {
        console.log('targetElement found:', targetElement);
        var parentElement = targetElement.parentNode; // 부모 요소를 찾습니다.
        var newRow = parentElement.insertRow(targetElement.rowIndex + 1); // 새로운 행을 삽입합니다.
        var newCell = newRow.insertCell(); // 새로운 셀을 삽입합니다.
        newCell.colSpan = "2"; // 새로운 셀이 전체 행을 차지하도록 설정합니다.
        newCell.innerHTML = formHtml; // 수정 폼 HTML을 삽입합니다.
    } else {
        console.error('Target element not found:', 'reply_' + inquire_reply_num);
    }
}

function submitEditedReply(inquire_reply_num, inquire_num) {
    var newcontent = document.getElementById('content_' + inquire_reply_num).value;
    var formData = new FormData();
    formData.append('inquire_reply_num', inquire_reply_num);
    formData.append('inquire_num', inquire_num);
    formData.append('newcontent', newcontent);

    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                console.log('답변 수정이 성공적으로 완료되었습니다.');
                window.location.reload(); // 답변 수정 후 페이지 새로고침
            } else {
                console.error('서버 오류:', xhr.status);
                alert('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
            }
        }
    };
    xhr.open('POST', 'inquire_reply_modify');
    xhr.send(formData);
}
</script>





</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
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



    <form action="#" method="post">
        <table>
            <caption>문의 사항 자세히 보기</caption>
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
    				<div style="width: 90%; height: 90%;">
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
			    </td>
            </tr>
            </c:otherwise>
            </c:choose>
            
            
            <c:choose>
				<c:when test="${loginstate==true}">
            <tr>
            	<th>댓글 입력창
            	</th>
                <td>
                	<br><br><br><br><br>
                	<textarea cols="90" rows="5" name="reply_comment" id="reply_comment" placeholder="댓글은 1500자 이하로 입력하세요." required></textarea>
                	<br>
                	<span style="float: right;">
                		<a href="inquire_reply_save?inquire_num=${dto.inquire_num}&loginid=${loginid}"><input type="button" value="댓글 쓰기"></a>
                	</span>
                </td>
            </tr>
            </c:when>
            
            <c:otherwise>
            <tr>
                <td colspan="2" style="text-align: center;">
                	<br><br><br>
                	로그인한 회원만 댓글 작성, 추천, 신고 기능을 이용할 수 있습니다.
                	<br><br><br>
                </td>
            </tr>
            </c:otherwise>
            </c:choose>
        </table>
    </form>
			        	
</body>
</html>
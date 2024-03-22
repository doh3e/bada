<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="member_search.jsp" %>

<!DOCTYPE html>

<html>

<head>
	<style>
        table {
            margin: 0 auto;
        }
        th, td {
            text-align: center;
        }
    </style>
<meta charset="UTF-8">
<title>바라는 바다! :: 회원 기본정보 확인</title>
</head>



<body>
	
	<table border="1" align="center" width="80%">
	
		<caption>회원 기본 정보 확인란</caption>
		      <tr>
		         <th>회원 일련번호</th>
		         <th>회원 아이디</th>
		         <th>회원 성명</th>
		         <th>회원 성별</th>
		         <th>회원 나이대</th>
		         <th>비고</th>
		         
		      <c:forEach items="${list}" var="m">
		      <tr>
		      	<td>${m.user_number}</td>
				<td>${m.id}</td>
		        <td>${m.name}</td>
		        <td>
		        	<c:choose>
						    <c:when test="${m.gender == 'male'}">남성</c:when>
						    <c:when test="${m.gender == 'female'}">여성</c:when>
						    <c:when test="${m.gender == 'other'}">밝히고 싶지 않음(기타)</c:when>
					</c:choose>
		        </td>
		        <td>
		        	<c:choose>
						    <c:when test="${m.age == 10}">10대 이하</c:when>
						    <c:when test="${m.age == 20}">20대</c:when>
						    <c:when test="${m.age == 30}">30대</c:when>
						    <c:when test="${m.age == 40}">40대</c:when>
						    <c:when test="${m.age == 50}">50대</c:when>
						    <c:when test="${m.age == 60}">60대 이상</c:when>
					</c:choose>
		        </td>
		        <td colspan="2" align="center">
		        	<a href="member_delete"><input type="button" value="회원 삭제"></a>
		        	<a href="member_modify_admin"><input type="button" value="관리자 권한으로 회원 정보 수정"></a>
		        </td>
		      </tr>
		      </c:forEach>
		      </table>
	   
	<br> <br>
	<a href="main">메인으로</a>
	
</body>



</html>
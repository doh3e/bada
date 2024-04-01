<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.hashtag-box {
	    border: 1px solid #ccc;
	    display: inline-block;
	    padding: 5px 10px;
	    margin: 5px;
	    cursor: pointer;
	}
	
	.hashtag-box.selected {
	    background-color: #007bff;
	    color: white;
	    border-color: #007bff;
	}
	
	.visit-box {
	    border: 2px solid #ccc;
	    display: inline-block;
	    padding: 10px 20px;
	    margin: 5px;
	    cursor: pointer;
	    transition: background-color 0.3s, color 0.3s;
	}
	
	.visit-box.selected {
	    background-color: #007bff;
	    color: white;
	    border-color: #007bff;
	}	
	
	fieldset{
	    display: inline-block;
	    direction: rtl;
	    border:0;
	}
	fieldset legend{
	    text-align: right;
	}
	input[type=radio]{
	    display: none;
	}
	label{
	    font-size: 1.5em;
	    color: transparent;
	    text-shadow: 0 0 0 #9c9c9c;
	}
	label:hover,
		#star input[type=radio]:hover ~ label,
		#star input[type=radio]:checked ~ label{
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	
	
	input[type=radio]:checked + label {
	   text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	
	#star label:hover ~ label,
	#star input[type=radio]:checked + label ~ label {
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}

	.insert {
	    display: block;
	    width: 300px;
	    margin: 5vh auto;
	    height: 20vh;
	    border: 1px solid #dbdbdb;
	    -webkit-box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    box-sizing: border-box;
	}
	.insert .file-list {
	    height: 200px;
	    overflow: auto;
	    border: 1px solid #989898;
	    padding: 10px;
	}
	.insert .file-list .filebox p {
	    font-size: 14px;
	    margin-top: 10px;
	    display: inline-block;
	}
	.insert .file-list .filebox .delete i{
	    color: #ff5353;
	    margin-left: 5px;
	}
</style>
</head>
<body>
	<form action="review_save" method="post" enctype="multipart/form-data">
		<table align="center">
		<caption>바다후기 게시글 입력</caption>
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="name" id="name" value="${dto.name}" readonly="readonly">
					<input type="hidden" name="id" id="id" value="${dto.id}" >
					<input type="hidden" name="write_day" id="write_day">
				</td>
			</tr>
			
			<tr>
				<th>방문일</th>
				<td>
					<input type="date" name="visit_day">
				</td>
			</tr>
			
			<tr>
				<th>후기 바다</th>
				<td>
					<select name="beach" id="beach" required="required">
					    <c:forEach items="${beachList}" var="beach">
					        <option value="${beach.beach_code}">${beach.beach}</option>
					    </c:forEach>
					</select>    
				</td>
			</tr>
			<tr>
				<th>제목 &nbsp;&nbsp;</th>
				<td><input type="text" name="review_title" id="review_title" required="required" placeholder="제목을 입력하세요."></td>
			</tr>
			<tr>
				<th>사진첨부(최대 5장)</th>
				<td>
					<div class="insert_file">
      				  	<input type="file" onchange="addFile(this);" multiple />
        				<div class="file-list"></div>
        			</div>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea cols="60" rows="30" name="review_contents" id="review_contents" placeholder="후기를 입력하세요." ></textarea>
				</td>
			</tr>
			<tr>
				<th>별점</th>
				<td>
					<fieldset id="star">
					    <input type="radio" name="review_score" value="5" id="rate1"><label for="rate1">★</label>
					    <input type="radio" name="review_score" value="4" id="rate2"><label for="rate2">★</label>
					    <input type="radio" name="review_score" value="3" id="rate3"><label for="rate3">★</label>
					    <input type="radio" name="review_score" value="2" id="rate4"><label for="rate4">★</label>
					    <input type="radio" name="review_score" value="1" id="rate5"><label for="rate5">★</label>
					</fieldset>
			    </td>
			</tr>
			<tr>
                <th>해시태그</th>
                <td id="hasjtagFields">
                	<div class="hashtag-box" data-value="#사람이적어요">#사람이 적어요</div>
			        <div class="hashtag-box" data-value="#맛집이많아요">#맛집이 많아요</div>
			        <div class="hashtag-box" data-value="#깨끗해요">#깨끗해요</div>
			        <div class="hashtag-box" data-value="#바다색이예뻐요">#바다 색이 예뻐요</div>
			        <div class="hashtag-box" data-value="#모래가고와요">#모래가 고와요</div>
                </td>
            </tr>
	            <tr>
	                <th>재방문 의사</th>
				    <td id="re_visit">
				        <div class="visit-box" data-value="Yes">Yes</div>
				        <div class="visit-box" data-value="No">No</div>
				    </td>
	            </tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="전송">
					<input type="reset" value="취소">
				</td>
			</tr>
		</table>
	</form>


<script>
var fileNo = 0;
var filesArr = new Array();

/* 첨부파일 추가 */
function addFile(obj){
    var maxFileCnt = 5;   // 첨부파일 최대 개수
    var attFileCnt = document.querySelectorAll('.filebox').length;    // 기존 추가된 첨부파일 개수
    var remainFileCnt = maxFileCnt - attFileCnt;    // 추가로 첨부가능한 개수
    var curFileCnt = obj.files.length;  // 현재 선택된 첨부파일 개수

    // 첨부파일 개수 확인
    if (curFileCnt > remainFileCnt) {
        alert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
    } else {
        for (const file of obj.files) {
            // 첨부파일 검증
            if (validation(file)) {
                // 파일 배열에 담기
                var reader = new FileReader();
                reader.onload = function () {
                    filesArr.push(file);
                };
                reader.readAsDataURL(file);

                // 목록 추가
                let htmlData = '';
                let htmlData = `<div id="file${fileNo}" class="filebox">
                    <p class="name" onclick="deleteFile(${fileNo});" style="cursor: pointer;">${file.name}</p>
                </div>`;
                $('.file-list').append(htmlData);
                fileNo++;
            } else {
                continue;
            }
        }
    }
    // 초기화
    document.querySelector("input[type=file]").value = "";
}

/* 첨부파일 검증 */
function validation(obj){
    const fileTypes = ['application/pdf', 'image/gif', 'image/jpeg', 'image/png', 'image/bmp', 'image/tif', 'application/haansofthwp', 'application/x-hwp'];
    if (obj.name.length > 100) {
        alert("파일명이 100자 이상인 파일은 제외되었습니다.");
        return false;
    } else if (obj.size > (100 * 1024 * 1024)) {
        alert("최대 파일 용량인 100MB를 초과한 파일은 제외되었습니다.");
        return false;
    } else if (obj.name.lastIndexOf('.') == -1) {
        alert("확장자가 없는 파일은 제외되었습니다.");
        return false;
    } else if (!fileTypes.includes(obj.type)) {
        alert("첨부가 불가능한 파일은 제외되었습니다.");
        return false;
    } else {
        return true;
    }
}

/* 첨부파일 삭제 */
function deleteFile(num) {
    document.querySelector("#file" + num).remove();
    filesArr[num].is_delete = true;
}

/* 폼 전송 */
function submitForm() {
    // 폼데이터 담기
    var form = document.querySelector("form");
    var formData = new FormData(form);
    for (var i = 0; i < filesArr.length; i++) {
        // 삭제되지 않은 파일만 폼데이터에 담기
        if (!filesArr[i].is_delete) {
            formData.append("attach_file", filesArr[i]);
        }
    }

    $.ajax({
        method: 'POST',
        url: '/register',
        dataType: 'json',
        data: formData,
        async: true,
        timeout: 30000,
        cache: false,
        headers: {'cache-control': 'no-cache', 'pragma': 'no-cache'},
        success: function () {
            alert("파일업로드 성공");
        },
        error: function (xhr, desc, err) {
            alert('에러가 발생 하였습니다.');
            return;
        }
    })
}


	document.addEventListener("DOMContentLoaded", function() {
	    // 해시태그 박스 선택 기능
	    var hashtagBoxes = document.querySelectorAll('.hashtag-box');
	    hashtagBoxes.forEach(function(box) {
	        box.addEventListener('click', function() {
	            // 선택된 박스의 수 확인
	            var selectedBoxes = document.querySelectorAll('.hashtag-box.selected');
	            if (!box.classList.contains('selected') && selectedBoxes.length >= 3) {
	                alert('최대 3개까지만 선택할 수 있습니다.');
	                return;
	            }
	            
	            // 박스의 선택 상태를 토글
	            box.classList.toggle('selected');
	        });
	    });

	    // 재방문 의사 선택 기능
	    var visitBoxes = document.querySelectorAll('.visit-box');
	    visitBoxes.forEach(function(box) {
	        box.addEventListener('click', function() {
	            // 다른 박스의 선택 해제
	            visitBoxes.forEach(function(otherBox) {
	                otherBox.classList.remove('selected');
	            });
	            
	            // 현재 박스의 선택 상태를 설정
	            box.classList.add('selected');
	        });
	    });
	});

</script>
</body>
</html>
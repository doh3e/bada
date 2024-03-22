<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">

.main {
    width: 350px;
    height: 450px;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    border: 1px solid lightgrey;
    border-radius: 5px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); 
    
}

.logo {
    margin-top: 0px;
    margin-bottom: 40px;
}

.input_field, .button_field {
    display: block;
    width: 100%; 
    margin: 5px 10px;
    padding: 3px;
    border: 1px solid lightgray;
    box-sizing: border-box;
}

.input_field {
    height: 40px; 
    border-radius: 3px; 
}

.button_field {
    margin-bottom: 5px;
    border-radius: 5px;
    cursor: pointer;
    color: white;
    background-color: skyblue;
}        
          

.container {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 20px;
}

.forgot {
    display: block; 
    margin-top: 20px;
    font-weight: bold;
    color: skyblue;
    text-decoration: none;
}

.div_line {
 width : 100%;
 border-bottom: 1px solid lightgrey;
 margin: 20px 0 7px;
}



.remember_id {
    display: flex; 
    align-items: center; 
    justify-content: flex-start;
    margin-top: 10px; 
    margin-bottom: 20px;
    width: 100%;
}


.remember_id label {
    margin-left: 5px;
    font-size: 0.8em;
}



#login {
    width: 100%;
    background-color: skyblue;
    border-color: transparent;
    color: white;
}

#sign {
    width: 100%;
    background-color: #fba600;
    border-color: transparent;
    color: white;
}



</style>

<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">


$(document).ready(function(){
	
	var errstack = parseInt(localStorage.getItem("errstack") || "0");
	
	  if(localStorage.getItem("remember") === "true") {
	        $("#remember").prop('checked', true);
	        $("#id").val(localStorage.getItem("savedId"));
	    } else {
	        $("#remember").prop('checked', false);
	        $("#id").val('');
	    }
	
	
	$("#login").click(function(){
		
		var id = $("#id").val();
		var pw = $("#pw").val();
		
		
		if(id=="") {
			alert("아이디를 입력해주세요!");
			$("#id").focus();
			return;
		}
		
		if(pw==""){
			alert("비밀번호를 입력해주세요!");
			$("#pw").focus();
			return;
		}
		
		$.ajax({
			
			type:"post",
			url:"login_save",
			async:true,
			dataType:"text",
			data:{"id":id,"pw":pw},
			success:function(result){
				
				if(result=="no"){
					
					errstack ++;
					localStorage.setItem("errstack", errstack.toString());
					
					if(errstack>=3){
						alert("로그인 3회 오류! 회원정보 찾아드릴게요!")
						window.location="info_search" // 회원가입창으로 이동 or (회원정보 찾기)
					}
					else{
						alert("일치하는 회원정보가 존재하지 않습니다!")
						window.location="login"
					}
					
				}
				else{
					alert(id+"님, 로그인 되었습니다!")
					localStorage.setItem("errstack", "0");
					window.location.replace("./")
				}	
			},
			
			error: function(){
				alert("데이터 전송 과정에 에러가 발생했습니다!")
			}
			
		});
		
		
	     if($("#remember").is(":checked")){
	            localStorage.setItem("savedId", id);
	            localStorage.setItem("remember", "true");
	        } else {
	            localStorage.removeItem("savedId");
	            localStorage.setItem("remember", "false");
	        }
		
		
	});
	
});


</script>
<title>바라던 바다 :: 로그인</title>
</head>
<body>

<div class="main">
        <h1 class="logo">bada_login</h1>
        <div class="container">
            <input type="text" name="id" placeholder="ID" id="id" class="input_field">
            <input type="password" name="pw" placeholder="Password" id="pw" class="input_field">
                 <div class="remember_id" style="margin-bottom: 20px;">
   					 <input type="checkbox" id="remember" name="remember">
  					 <label for="remember">아이디 저장하기</label>
				</div>
               
            	<button id="login" class="button_field">로그인</button>
            	<button id="sign" class="button_field">회원가입</button>

			<div class="div_line"></div>
			<div class="search_info">
                    <a class="forgot" onclick="location.href='info_search'">아이디 / 비밀번호를 잊으셨나요?</a>
            </div>
        </div>
    </div>   


</body>
</html>

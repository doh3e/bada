package com.ezen.bada.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
public class MemberController {
	
	@Autowired
	SqlSession sqlsession;
	
	@RequestMapping(value = "/member_join")
	public String member1() {
		
		return "member_join";
	}
	

	
	@RequestMapping(value = "/login")
	public String login1() {
		
		return "login";
	}
	
	
	@RequestMapping(value = "/info_search")
	public String search_login() {
		
		return "info_search";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/login_save", method = RequestMethod.POST)
	public String login2(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		Service ss = sqlsession.getMapper(Service.class);
		String logincount = ss.login_check(id,pw);
		
<<<<<<< HEAD
		System.out.println("�α��� �õ� ���̵� : "+id);
		System.out.println("�α��� �õ� ��� : "+pw);
		System.out.println("�α��� ��� : "+logincount);
=======
		System.out.println("로그인 시도 아이디 : "+id);
		System.out.println("로그인 시도 비밀번호 : "+pw);
		System.out.println("로그인체크 : "+logincount);
>>>>>>> 3f6088f8b43f4a8553153006873e7251bc326464
		
		
		String result = "";
		
		if(logincount==null) {
			result = "no";
		}
		else {
			
			HttpSession hs = request.getSession();
			hs.setAttribute("loginstate", true);
			hs.setAttribute("loginid", id);
			hs.setAttribute("pw", pw);
			hs.setAttribute("position", logincount);
			hs.setMaxInactiveInterval(600);
			result = "yes";
		}
	
<<<<<<< HEAD
		System.out.println("��� : "+result);
=======
		System.out.println("결과 : "+result);
>>>>>>> 3f6088f8b43f4a8553153006873e7251bc326464
		
		return result;
	}

	
	@ResponseBody
	@RequestMapping(value = "/idcheck")
	public String idcheck(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		Service ss=sqlsession.getMapper(Service.class);
<<<<<<< HEAD
		String result=""; //originid�� ���� ���η� ����� result�� ��ȯ�ϱ� ���� ���� ����
=======
		String result=""; //originid로 얻어온 결과로 if문 실행
>>>>>>> 3f6088f8b43f4a8553153006873e7251bc326464
		String originid="";
		
		System.out.println("���� ���̵� : "+id);
		
<<<<<<< HEAD
		originid=ss.idcheck(id); //originid: table �ȿ��� ������ ������ �����ϴ� id
		if(originid==null) {result="ok";} //�ߺ��� ���̵� ���� ���
		else {result="nope";} //�ߺ��� ���̵� ���� ���	
=======
		originid=ss.idcheck(id); //originid: table에서 id로 select where 해서 나온 값
		if(originid==null) {result="ok";} // 결과가 null이면 ok반환
		else {result="nope";} //select 결과가 있으면 nope 반환
>>>>>>> 3f6088f8b43f4a8553153006873e7251bc326464

		System.out.println("sql��� : "+originid);
		System.out.println("������� : "+result);
		
		return result;
<<<<<<< HEAD
	} //public String idcheck ��
=======
	} //idcheck 종료
>>>>>>> 3f6088f8b43f4a8553153006873e7251bc326464
	
	
	
	@RequestMapping(value = "/member_save", method = RequestMethod.POST)
	public String membersave(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String age = request.getParameter("age");

        Service ss=sqlsession.getMapper(Service.class);
        ss.membersave(id, pw, name, email, gender, age);
 	
		return "main";
	}
	
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request,HttpServletResponse response) throws IOException {
		HttpSession hs=request.getSession();
		
		hs.removeAttribute("loginstate");
		hs.setAttribute("loginstate", false);
		hs.removeAttribute("loginid");
		hs.removeAttribute("pw");
		hs.removeAttribute("position");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
	    PrintWriter out = response.getWriter();
	    out.print("<script type='text/javascript'> alert('로그아웃 되었습니다!'); window.location.replace('main')");
	    out.print("</script>");
		
		
		return null;
	} //logout ��
	
	
	
	
	
	
	
}

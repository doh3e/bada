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
		
		System.out.println("�α��� �õ� ���̵� : "+id);
		System.out.println("�α��� �õ� ��� : "+pw);
		System.out.println("�α��� ��� : "+logincount);
		
		
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
	
		System.out.println("��� : "+result);
		
		return result;
	}

	
	@ResponseBody
	@RequestMapping(value = "/idcheck")
	public String idcheck(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		Service ss=sqlsession.getMapper(Service.class);
		String result=""; //originid�� ���� ���η� ����� result�� ��ȯ�ϱ� ���� ���� ����
		String originid="";
		
		System.out.println("���� ���̵� : "+id);
		
		originid=ss.idcheck(id); //originid: table �ȿ��� ������ ������ �����ϴ� id
		if(originid==null) {result="ok";} //�ߺ��� ���̵� ���� ���
		else {result="nope";} //�ߺ��� ���̵� ���� ���	

		System.out.println("sql��� : "+originid);
		System.out.println("������� : "+result);
		
		return result;
	} //public String idcheck ��
	
	
	
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
	    out.print("<script type='text/javascript'> alert('�α׾ƿ� �Ǿ����ϴ�!'); window.location.replace('main')");
	    out.print("</script>");
		
		
		return null;
	} //logout ��
	
	
	
	
	
	
	
}

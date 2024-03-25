package com.ezen.bada.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	
	@ResponseBody
	@RequestMapping(value = "/login_save", method = RequestMethod.POST)
	public String login2(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		Service ss = sqlsession.getMapper(Service.class);
		String logincount = ss.login_check(id,pw);
		
		System.out.println("로그인 시도 아이디 : "+id);
		System.out.println("로그인 시도 비밀번호 : "+pw);
		System.out.println("로그인체크 : "+logincount);
		
		
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
	
		System.out.println("결과 : "+result);
		
		return result;
	}

	
	@ResponseBody
	@RequestMapping(value = "/idcheck")
	public String idcheck(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		Service ss=sqlsession.getMapper(Service.class);
		String result=""; //originid로 얻어온 결과로 if문 실행
		String originid="";
		
		System.out.println("받아온 id : "+id);
		
		originid=ss.idcheck(id); //originid: table에서 id로 select where 해서 나온 값
		if(originid==null) {result="ok";} // 결과가 null이면 ok반환
		else {result="nope";} //select 결과가 있으면 nope 반환

		System.out.println("sql결과 : "+originid);
		System.out.println("최종결과 : "+result);
		
		return result;
	} //idcheck 종료
	
	
	
	@RequestMapping(value = "/member_save", method = RequestMethod.POST)
	public String membersave(HttpServletRequest request) throws IOException {
		
		String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        int age = Integer.parseInt(request.getParameter("age"));

        Service ss=sqlsession.getMapper(Service.class);
        ss.membersave(id, pw, name, email, gender, age);
 	
		return "main";
	}
	
	
	@RequestMapping(value = "/member_try_bbti")
	public String membertrybbti() {
		
		return "member_try_bbti";
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
	} //logout 끝
	
	
	
	@RequestMapping(value = "/member_out")
	public String memberout(HttpServletRequest request, Model mo) {
		
		Service ss=sqlsession.getMapper(Service.class);
		ArrayList<MemberDTO> list=ss.memberout();
		mo.addAttribute("list", list);
		
		return "member_out";
	}
	
	
	
	@RequestMapping(value = "/member_search")
	public String membersearch(HttpServletRequest request, Model mo) {
		
		String keyword=request.getParameter("search_keyword");
		String value=request.getParameter("search_value");
		String gender=request.getParameter("gender");
		int age=Integer.parseInt(request.getParameter("age"));
		
		Service ss=sqlsession.getMapper(Service.class);
		ArrayList<MemberDTO> list;
		
		if(keyword.equals("user_number")) { //검색 키워드가 회원 번호인 경우
			
			if(gender.equals("") && age==0) { //성별과 나이를 모두 입력하지 않은 경우
				list=ss.member_search_num_n_n(value);
			}//내부 if문 끝
			else if(gender.equals("") && age!=0) { //성별은 입력하지 않고 나이는 입력한 경우
				list=ss.member_search_num_n_a(value, age);
			}//내부 else if문 끝
			else if(gender!=null && age==0) { //성별은 입력하고 나이는 입력하지 않은 경우
				list=ss.member_search_num_g_n(value, gender);
			}//내부 else if문2 끝
			else { //성별과 나이 모두 입력한 경우
				list=ss.member_search_num_g_a(value, gender, age);
			}//내부 else문 끝
		}
		
		else if(keyword.equals("id")) { //검색 키워드가 아이디인 경우
			if(gender.equals("") && age==0) {
				list=ss.member_search_id_n_n(value);
			}//내부 if문 끝
			else if(gender.equals("") && age!=0) {
				list=ss.member_search_id_n_a(value, age);
			}//내부 else if문 끝
			else if(gender!=null && age==0) {
				list=ss.member_search_id_g_n(value, gender);
			}//내부 else if문2 끝
			else {
				list=ss.member_search_id_g_a(value, gender, age);
			}//내부 else문 끝
		}
		
		else { //검색 키워드가 이름인 경우
			if(gender.equals("") && age==0) {
				list=ss.member_search_name_n_n(value);
			}//내부 if문 끝
			else if(gender.equals("") && age!=0) {
				list=ss.member_search_name_n_a(value, age);
			}//내부 else if문 끝
			else if(gender!=null && age==0) {
				list=ss.member_search_name_g_n(value, gender);
			}//내부 else if문2 끝
			else {
				list=ss.member_search_name_g_a(value, gender, age);
			}//내부 else문 끝
		}
		
		System.out.println(list);
		
		mo.addAttribute("list", list);
		
		return "member_out";
	}
	
	
}

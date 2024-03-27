package com.ezen.bada.member;

import java.util.ArrayList;

public interface Service {

	String login_check(String id, String pw);

	String idcheck(String id);

	void membersave(String id, String pw, String name, String email, String gender, int age);

	ArrayList<MemberDTO> memberout();

	ArrayList<MemberDTO> member_search_num_n_n(String value);

	ArrayList<MemberDTO> member_search_num_n_a(String value, int age);

	ArrayList<MemberDTO> member_search_num_g_n(String value, String gender);

	ArrayList<MemberDTO> member_search_num_g_a(String value, String gender, int age);

	ArrayList<MemberDTO> member_search_id_n_n(String value);

	ArrayList<MemberDTO> member_search_id_n_a(String value, int age);

	ArrayList<MemberDTO> member_search_id_g_n(String value, String gender);

	ArrayList<MemberDTO> member_search_id_g_a(String value, String gender, int age);

	ArrayList<MemberDTO> member_search_name_n_n(String value);

	ArrayList<MemberDTO> member_search_name_n_a(String value, int age);

	ArrayList<MemberDTO> member_search_name_g_n(String value, String gender);

	ArrayList<MemberDTO> member_search_name_g_a(String value, String gender, int age);

	MemberDTO lookid(String name, String email);

	MemberDTO lookpw(String id, String email);
	
	ArrayList<MemberDTO> member_detail_out(int user_number);

	void member_modify(String id, String pw, String name, String email, String gender, int age, int user_number);

	String emailcheck(String email);

	MemberDTO myinfo_main(String loginid);

	MemberDTO myinfo_modify(String id);

	void info_update1(String id, String pw, String email, String gender, int age);

	void info_update2(String id, String email, String gender, int age);

}

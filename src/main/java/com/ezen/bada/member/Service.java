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

}

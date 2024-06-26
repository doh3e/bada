package com.ezen.bada.inquire;

public class Inquire_ban_DTO2 {
	
	int i_banned_num;
	String title, name, id;
	int ban_inquire_num;
	String ban_name, ban_id, category, content, ban_date;
	int ban_counting, ban_user_number;
	
	public Inquire_ban_DTO2() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Inquire_ban_DTO2(int i_banned_num, String title, String name, String id, int ban_inquire_num, String ban_name,
			String ban_id, String category, String content, String ban_date, int ban_counting, int ban_user_number) {
		super();
		this.i_banned_num = i_banned_num;
		this.title = title;
		this.name = name;
		this.id = id;
		this.ban_inquire_num = ban_inquire_num;
		this.ban_name = ban_name;
		this.ban_id = ban_id;
		this.category = category;
		this.content = content;
		this.ban_date = ban_date;
		this.ban_counting = ban_counting;
		this.ban_user_number = ban_user_number;
	}
	public int getI_banned_num() {
		return i_banned_num;
	}
	public void setI_banned_num(int i_banned_num) {
		this.i_banned_num = i_banned_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getBan_inquire_num() {
		return ban_inquire_num;
	}
	public void setBan_inquire_num(int ban_inquire_num) {
		this.ban_inquire_num = ban_inquire_num;
	}
	public String getBan_name() {
		return ban_name;
	}
	public void setBan_name(String ban_name) {
		this.ban_name = ban_name;
	}
	public String getBan_id() {
		return ban_id;
	}
	public void setBan_id(String ban_id) {
		this.ban_id = ban_id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getContent() {
		return content.replaceAll("\n", "<br>");
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBan_date() {
		return ban_date;
	}
	public void setBan_date(String ban_date) {
		this.ban_date = ban_date;
	}
	public int getBan_counting() {
		return ban_counting;
	}
	public void setBan_counting(int ban_counting) {
		this.ban_counting = ban_counting;
	}
	public int getBan_user_number() {
		return ban_user_number;
	}
	public void setBan_user_number(int ban_user_number) {
		this.ban_user_number = ban_user_number;
	}
	
}
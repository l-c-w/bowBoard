package com.javalec.ex.Dto;


import java.sql.Date;
import java.sql.Timestamp;

public class BDto {
	
	public BDto() {
	}
	
	private int b_num;
	private String b_title,b_name,b_content;
	private Timestamp b_date;
		
	public BDto(int b_b_num, String b_title, String b_name, String b_content, Timestamp b_date) {
		
		this.b_num=b_b_num;
		this.b_title=b_title;
		this.b_name=b_name;
		this.b_content=b_content;
		this.b_date=b_date;
	}

	public int getb_num() {
		return b_num;
	}

	public void setb_num(int b_num) {
		this.b_num = b_num;
	}

	public String getB_title() {
		return b_title;
	}

	public void setB_title(String b_title) {
		this.b_title = b_title;
	}

	public String getB_name() {
		return b_name;
	}

	public void setB_name(String b_name) {
		this.b_name = b_name;
	}

	public String getB_content() {
		return b_content;
	}

	public void setB_content(String b_content) {
		this.b_content = b_content;
	}

	public Timestamp getB_date() {
		return b_date;
	}

	public void setB_date(Timestamp b_date) {
		this.b_date = b_date;
	}

	
	
	
}
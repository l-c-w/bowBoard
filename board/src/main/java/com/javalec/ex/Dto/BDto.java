package com.javalec.ex.Dto;


import java.sql.Date;
import java.sql.Timestamp;

public class BDto {
	
	public BDto() {
	}
	
	private int b_num,b_group,b_step,b_indent, repl_count;
	private String b_title,b_name,b_content,b_pw;
	private Timestamp b_date,u_date;
		
	public BDto(int b_b_num, String b_title, String b_name, String b_content, Timestamp b_date,String b_pw,
				int b_group, int b_step, int b_indent,Timestamp u_date,int repl_count) {
		
		this.b_num=b_b_num;
		this.b_title=b_title;
		this.b_name=b_name;
		this.b_content=b_content;
		this.b_date=b_date;
		this.b_pw=b_pw;
		this.b_group=b_group;
		this.b_step=b_step;
		this.b_indent=b_indent;
		this.u_date=u_date;
		this.repl_count=repl_count;
	}

	
	
	public String getB_pw() {
		return b_pw;
	}



	public void setB_pw(String b_pw) {
		this.b_pw = b_pw;
	}


	public int getB_num() {
		return b_num;
	}



	public void setB_num(int b_num) {
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



	public int getB_group() {
		return b_group;
	}



	public void setB_group(int b_group) {
		this.b_group = b_group;
	}



	public int getB_step() {
		return b_step;
	}



	public void setB_step(int b_step) {
		this.b_step = b_step;
	}



	public int getB_indent() {
		return b_indent;
	}



	public void setB_indent(int b_indent) {
		this.b_indent = b_indent;
	}



	public Timestamp getU_date() {
		return u_date;
	}



	public void setU_date(Timestamp u_date) {
		this.u_date = u_date;
	}



	public int getRepl_count() {
		return repl_count;
	}



	public void setRepl_count(int repl_count) {
		this.repl_count = repl_count;
	}
	
	

	
	
	
}
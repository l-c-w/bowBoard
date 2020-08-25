package com.javalec.ex.Dto;

import java.sql.Timestamp;

public class RDto {
	
	private int m_num;
	private int r_num;
	private String r_name,r_pw,r_content;
	private Timestamp r_date,ru_date;
	
	public RDto() {
	}
	
	public RDto(int m_num, int r_num, String r_name, String r_pw, String r_content, Timestamp r_date, Timestamp ru_date) {
		this.m_num=m_num;
		this.r_num=r_num;
		this.r_name=r_name;
		this.r_pw=r_pw;
		this.r_content=r_content;
		this.r_date=r_date;
		this.ru_date=ru_date;
	}
	
	public int getm_num() {
		return m_num;
	}

	public void setm_num(int m_num) {
		this.m_num = m_num;
	}

	public int getR_num() {
		return r_num;
	}

	public void setR_num(int r_num) {
		this.r_num = r_num;
	}

	public String getR_name() {
		return r_name;
	}

	public void setR_name(String r_name) {
		this.r_name = r_name;
	}

	public String getR_pw() {
		return r_pw;
	}

	public void setR_pw(String r_pw) {
		this.r_pw = r_pw;
	}

	public String getR_content() {
		return r_content;
	}

	public void setR_content(String r_content) {
		this.r_content = r_content;
	}

	public Timestamp getR_date() {
		return r_date;
	}

	public void setR_date(Timestamp r_date) {
		this.r_date = r_date;
	}

	public Timestamp getRu_date() {
		return ru_date;
	}

	public void setRu_date(Timestamp ru_date) {
		this.ru_date = ru_date;
	}
	
	
}

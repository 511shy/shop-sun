package com.beans;

import java.util.Date;

public class MemberInfo {
	private int id;
	private String memberNo;
	private String memberName;
	private String phone;
	private String email;
	private Date registerDate;
	private String idCard;
	private int loginCounts;
	private Date lastLoginDate;
	private String ip;
	private String memberLevel;
	private String pwdQue;//密保问题
	private String pwdAnswer;//密保答案
	private String zipCode;//邮编
	private String address;//地址
	private String password;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public int getLoginCounts() {
		return loginCounts;
	}
	public void setLoginCounts(int loginCounts) {
		this.loginCounts = loginCounts;
	}
	public Date getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getMemberLevel() {
		return memberLevel;
	}
	public void setMemberLevel(String memberLevel) {
		this.memberLevel = memberLevel;
	}
	public String getPwdQue() {
		return pwdQue;
	}
	public void setPwdQue(String pwdQue) {
		this.pwdQue = pwdQue;
	}
	public String getPwdAnswer() {
		return pwdAnswer;
	}
	public void setPwdAnswer(String pwdAnswer) {
		this.pwdAnswer = pwdAnswer;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Override
	public String toString() {
		return "MemberInfo [id=" + id + ", memberNo=" + memberNo + ", memberName=" + memberName + ", phone=" + phone
				+ ", email=" + email + ", registerDate=" + registerDate + ", idCard=" + idCard + ", loginCounts="
				+ loginCounts + ", lastLoginDate=" + lastLoginDate + ", ip=" + ip + ", memberLevel=" + memberLevel
				+ ", pwdQue=" + pwdQue + ", pwdAnswer=" + pwdAnswer + ", zipCode=" + zipCode + ", address=" + address
				+ ", password=" + password + "]";
	}
	
}

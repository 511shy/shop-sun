package com.beans;

import java.util.Date;

public class OrderInfo {
	private int id;
	private String orderNo;
	private int memberId;
	private float postage;
	private String postMethod;
	private String payMethod;
	private Date orderDate;
	private String address;
	private String orderState;
	private float amount;
	private Date sendDate;
	private Date editDate;
	@Override
	public String toString() {
		return "OrderInfo [id=" + id + ", orderNo=" + orderNo + ", memberId=" + memberId + ", postage=" + postage
				+ ", postMethod=" + postMethod + ", payMethod=" + payMethod + ", orderDate=" + orderDate + ", address="
				+ address + ", orderState=" + orderState + ", amount=" + amount + ", sendDate=" + sendDate
				+ ", editDate=" + editDate + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public float getPostage() {
		return postage;
	}
	public void setPostage(float postage) {
		this.postage = postage;
	}
	public String getPostMethod() {
		return postMethod;
	}
	public void setPostMethod(String postMethod) {
		this.postMethod = postMethod;
	}
	public String getPayMethod() {
		return payMethod;
	}
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getOrderState() {
		return orderState;
	}
	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}
	public float getAmount() {
		return amount;
	}
	public void setAmount(float amount) {
		this.amount = amount;
	}
	public Date getSendDate() {
		return sendDate;
	}
	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	public Date getEditDate() {
		return editDate;
	}
	public void setEditDate(Date editDate) {
		this.editDate = editDate;
	}
	
}

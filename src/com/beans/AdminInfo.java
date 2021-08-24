package com.beans;

import java.io.Serializable;
import java.util.Date;

public class AdminInfo implements  Serializable{
	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private String adminName;
	private String password;
	private String note;
	private String state;  //用户的状态 0, 1, 2 三种    1表示正常 2 表示禁用 0 表示暂停
	private Date editDate;  //用户最后更新的时间,在数据库中是时间戳类型
	private Integer roleId;  //用户所属的角色ID, 它是指象角色表(roleInfo) 的外键
	private String roleName;  //角色名称,adminInfo表中没有这个字段,它是用来关联查询角色信息的
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Date getEditDate() {
		return editDate;
	}
	public void setEditDate(Date editDate) {
		this.editDate = editDate;
	}
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "AdminInfo [id=" + id + ", adminName=" + adminName + ", password=" + password + ", note=" + note
				+ ", state=" + state + ", roleId=" + roleId + ", roleName=" + roleName + "]";
	}
	
}

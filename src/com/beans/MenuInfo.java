package com.beans;

import java.util.List;

public class MenuInfo {
	private int id;
	private String menuName;
	private String url;
	private String target;
	private String icon;
	private int parentId;
	
	private List<MenuInfo> subMenuList;
	private int roleId;

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentid) {
		this.parentId = parentid;
	}

	public List<MenuInfo> getSubMenuList() {
		return subMenuList;
	}

	@Override
	public String toString() {
		return "MenuInfo [id=" + id + ", menuName=" + menuName + ", url=" + url + ", target=" + target + ", icon="
				+ icon + ", parentId=" + parentId + ", subMenuList=" + subMenuList + "]";
	}

	public void setSubMenuList(List<MenuInfo> subMenuList) {
		this.subMenuList = subMenuList;
	}

	
	
}


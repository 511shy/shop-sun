package com.dao;

import java.util.List;

import com.beans.AdminInfo;
import com.beans.PageInfo;
import com.beans.RoleInfo;
import com.jdbc.DBUtil;

public class AdminDao {
	public AdminInfo login(String adminName, String password) {
		String sql="select * from adminInfo where adminName=? and password=? ";
		return DBUtil.getSingleObject(sql, AdminInfo.class, adminName,password);
	}

	public int addAdmin(AdminInfo admin) {
		String sql="insert into adminInfo (adminName,password,note,state) values (?,?,?,?)";
		return DBUtil.update(sql, admin.getAdminName(),admin.getPassword(),admin.getNote(),admin.getState());
	}
	public List<AdminInfo> getAdminInfos(PageInfo page){
		String sql = "select * from admininfo where state != '0' limit ?,?";
		return DBUtil.getList(sql, AdminInfo.class, page.getBeginRow(),page.getPageSize());
	}
	public int getAdminCount() {
		String sql="select count(*) from admininfo where state != '0' ";
		long count= DBUtil.getScalar(sql) ; 
		return Integer.parseInt(count+"");
	}
	public int adminResState(String state, int id) {
		String sql = "update admininfo set state = ? where id = ?";
		return DBUtil.update(sql, state,id);
	}

	public AdminInfo getAdminByName(String adminName) {
		String sql = "select * from admininfo where adminName = ?";
		return DBUtil.getSingleObject(sql, AdminInfo.class, adminName);
	}

	public AdminInfo getAdminById(int id) {
		String sql = "select * from admininfo where id = ?";
		return DBUtil.getSingleObject(sql, AdminInfo.class, id);
	}

	public int adminRes(AdminInfo admin) {
		String sql = "update admininfo set adminName=? ,password=? ,note=?,roleId=? where id =?";

		return DBUtil.update(sql, admin.getAdminName(),admin.getPassword(),admin.getNote(),admin.getRoleId(),admin.getId());
		
	}
	public List<RoleInfo> getAllRoleInfo(){
		String sql = "select * from roleinfo";
		return DBUtil.getList(sql, RoleInfo.class);
	}

	public List<AdminInfo> selAdminInfo(PageInfo page){	 
		String sql="select a.* ,b.roleName from adminInfo a left join roleInfo b on a.roleId=b.id  where state !=0 limit ?, ? ";
		List<AdminInfo> list=DBUtil.getList(sql, AdminInfo.class, page.getBeginRow(),page.getPageSize());
		return list;
	 }
	public List<AdminInfo> selAdminInfoRoleName(PageInfo page){
		String sql="select a.* ,b.roleName from adminInfo a,roleInfo b where a.roleId=b.id and state='1' or state='2' limit ?, ? ";
		List<AdminInfo> list=DBUtil.getList(sql, AdminInfo.class, page.getBeginRow(),page.getPageSize());
		return list;
	}
}

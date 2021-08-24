package com.dao;

import java.util.List;

import com.beans.AdminInfo;
import com.beans.RoleInfo;
import com.jdbc.DBUtil;


public class RoleDao {
	public int roleAdd(RoleInfo role) {
		String sql = "insert into roleinfo(roleName,des) values(?,?)";
		return  DBUtil.update(sql, role.getRoleName(),role.getDes());
	}
	public List<RoleInfo> getRoleInfos(){
		String sql = "select * from roleinfo";
		return DBUtil.getList(sql,RoleInfo.class);	
	}
	public List<AdminInfo> getAllAdminRole(){
		String sql = "select a.id,adminName,state,roleName,editDate from admininfo a left join roleinfo r on r.id=a.roleid;";
		return DBUtil.getList(sql,AdminInfo.class);
	}
	public List<RoleInfo> getAllRoleInfo(){
		String sql = "select * from roleinfo";
		
		return DBUtil.getList(sql, RoleInfo.class);
	}
	public int resAdminRole(int roleid, int id){
		String sql = "update admininfo set roleId=? where id=?";
		
		return DBUtil.update(sql, roleid, id);
	}
	public RoleInfo getRoleByName(String roleName) {
		String sql = "select * from roleinfo where roleName=?";
		
		return DBUtil.getSingleObject(sql, RoleInfo.class, roleName);
	}
	public int whetherAdminHaveThisRole(int roleId) {
		String sql="select count(*) from admininfo where roleId=?";
		return Integer.parseInt(DBUtil.getScalar(sql,roleId)+"");
	}
	public RoleInfo getRoleById(int id) {
		String sql = "select * from roleinfo where id=?";
		
		return DBUtil.getSingleObject(sql, RoleInfo.class, id);
	}
	public int updateRoleInfo(String roleName, String des, int id) {
			String sql = "update roleinfo set roleName=? ,des=? where id=?";
		
		return DBUtil.update(sql, roleName,des,id);
	}
	public int delRoleInfoById(int id) {
		String sql = "delete from roleinfo where id=?";
		return DBUtil.update(sql,id);
	}
	public int delAuthoryFromRolemenu(int roleid) {
		String sql = "delete from rolemenu where roleid=?";
		return DBUtil.update(sql,roleid);
	}
	public int addAuthoryOnRolemenu(int roleid,int menuId) {
		String sql = "insert into rolemenu(roleId,menuId) values(?,?)";
		return DBUtil.update(sql,roleid,menuId);
	}
	public List<Integer> getMenuIdByRoleId(int roleid) {
		String sql = "select menuId from rolemenu where roleid=?";
		
		return DBUtil.getOneList(sql, roleid);
	}
	// 查询所有角色列表(由于角色数据不会太多,所以没有分页查询)
		public List<RoleInfo> getRoleList() {
			return DBUtil.getList("select * from roleInfo", RoleInfo.class);
		}
	
}

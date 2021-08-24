package com.dao;

import java.util.List;

import com.beans.CateInfo;
import com.jdbc.DBUtil;

public class CateDao {
	public int cateAdd(CateInfo cate) {
		String sql="insert into cateinfo(cateName,des,parentId) values(?,?,?)";
		return DBUtil.update(sql, cate.getCateName(), cate.getDes(),cate.getParentId());
	}

	public CateInfo getAdminByName(String cateName) {
		String sql="select * from cateinfo where cateName=?";
		return DBUtil.getSingleObject(sql, CateInfo.class, cateName);
	}
	public List<CateInfo> getAllAdminByName(String cateName) {
		String sql="select * from cateinfo where cateName=?";
		return DBUtil.getList(sql, CateInfo.class, cateName);
	}
	public CateInfo getAdminById(int id) {
		String sql="select * from cateinfo where id=?";
		return DBUtil.getSingleObject(sql, CateInfo.class, id);
	}
	public List<CateInfo> getCateInfoByParentID(int parentId){
		List<CateInfo> cateList=DBUtil.getList("select * from cateinfo where parentId=?", CateInfo.class, parentId);
		for(CateInfo c: cateList) {
			if(c.getParentId()==0){
				c.setSubCateList(getCateInfoByParentID(c.getId()));
			}
		}
		return cateList;
	}
	public int cateDel(int id) {
		String sql="delete from cateinfo where id = ?";
		return DBUtil.update(sql,id);
	}
	public int cateRes(CateInfo cate) {
		String sql="update cateinfo set cateName=?, des=?,parentId=? where id=?";
		return DBUtil.update(sql,cate.getCateName(),cate.getDes(),cate.getParentId(),cate.getId());
	}
	
}

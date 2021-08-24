package com.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.beans.GoodsInfo;
import com.jdbc.DBUtil;
import com.beans.PageInfo;

import com.utils.Utils;

public class GoodsDao {
	public int goodsAdd(GoodsInfo goods) {
		String sql = "insert into goodsinfo(goodsName,bigCateId,smallCateId,price,des,unit,producter,pictureData) values(?,?,?,?,?,?,?,?)";
		return  DBUtil.addAndReturnId(sql, goods.getGoodsName(),goods.getBigCateId(),goods.getSmallCateId(),goods.getPrice(),goods.getDes(),goods.getUnit(),goods.getProducter(),goods.getPictureData());
	}
	public GoodsInfo getGoodsByName(String goodsName) {
		String sql="select * from goodsinfo where goodsName=?";
		return DBUtil.getSingleObject(sql, GoodsInfo.class, goodsName);
	}
	public GoodsInfo getGoodsById(int id) {
		String sql="select * from goodsinfo where id=?";
		return DBUtil.getSingleObject(sql, GoodsInfo.class, id);
	}
	
	public int getGoodsCount() {
		String sql="select count(*) from goodsinfo";
		long count= DBUtil.getScalar(sql);
		return Integer.parseInt(count+"");
	}
	public List<GoodsInfo> getGoodsByCondition(String goodsName,int bigId, int smallId, PageInfo page) {
		List<GoodsInfo> list = new ArrayList<GoodsInfo>();
		Connection conn=null;
		Statement stm=null;
		ResultSet rs=null;
		conn=DBUtil.getConn();
		
		try {
			stm=conn.createStatement();
			String sql="select a.id id, goodsName, unit, price, a.CateName bigCateName, b.CateName smallCateName from"
					+ "(select g.id,goodsName,unit,price,CateName,c.id cid from goodsinfo g left join cateinfo c on bigcateid=c.id) a"
					+ " left join (select g.id,CateName,c.id cid from goodsinfo g left join cateinfo c on smallcateid=c.id) b"
					+ " on a.id = b.id where 1=1 ";
			
			if(!Utils.StrIsNullOrEmpty(goodsName)) {
				sql+=" and goodsName like '%"+goodsName+"%'";
			}
			if(bigId != -1) {
				sql+=" and a.cid ='"+bigId+"'";
			}
			if(smallId != -1) {
				sql+=" and b.cid ='"+smallId+"'";
			}
			sql+= "limit "+page.getBeginRow()+","+page.getPageSize();
			
			rs=stm.executeQuery(sql);
			while(rs.next()) {
				GoodsInfo goods= new GoodsInfo();
				goods.setId(rs.getInt("id"));
				goods.setGoodsName(rs.getString("goodsName"));
				goods.setUnit(rs.getString("unit"));
				goods.setPrice(rs.getFloat("price"));
				goods.setBigCateName(rs.getString("bigCateName"));
				goods.setSmallCateName(rs.getString("smallCateName"));
				list.add(goods);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	public int getGoodsByConditionCount(String goodsName,int bigId, int smallId) {
		int result = 0;
		Connection conn=null;
		Statement stm=null;
		ResultSet rs=null;
		conn=DBUtil.getConn();
		try {
			stm=conn.createStatement();
			String sql="select count(*) count from"
					+ "(select g.id,goodsName,unit,price,CateName,c.id cid from goodsinfo g left join cateinfo c on bigcateid=c.id) a"
					+ " left join (select g.id,CateName,c.id cid from goodsinfo g left join cateinfo c on smallcateid=c.id) b"
					+ " on a.id = b.id where 1=1 ";
			
			if(!Utils.StrIsNullOrEmpty(goodsName)) {
				sql+=" and goodsName like '%"+goodsName+"%'";
			}
			if(bigId != -1) {
				sql+=" and a.cid ='"+bigId+"'";
			}
			if(smallId != -1) {
				sql+=" and b.cid ='"+smallId+"'";
			}
			
			rs=stm.executeQuery(sql);
			while(rs.next()) {
				result = rs.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	public int goodsRes(GoodsInfo goods) {
		String sql = "update goodsInfo set goodsName=?,bigCateId=?,smallCateId=?,price=?,des=?,unit=?,producter=?,pictureData=? where id=?";
		
		return DBUtil.update(sql, goods.getGoodsName(),goods.getBigCateId(),goods.getSmallCateId(),goods.getPrice(),goods.getDes(),goods.getUnit(),goods.getProducter(),goods.getPictureData(),goods.getId());
	}
	public int goodsDel(int id) {
		String sql = "delete from goodsInfo where id = ?";
		return DBUtil.update(sql, id);
		
	}
}


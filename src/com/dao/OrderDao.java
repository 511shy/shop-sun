package com.dao;

import java.util.List;

import com.beans.OrderInfo;
import com.jdbc.DBUtil;
import com.utils.Utils;
import com.beans.PageInfo;

public class OrderDao {
	public List<OrderInfo> getAllOrder(String orderNo,String startTime,String endTime, int findOrderState, PageInfo page){
		String sql = "select * from OrderInfo where 1=1 ";
		if(!Utils.StrIsNullOrEmpty(orderNo)) {
			sql += " and orderNo = '" + orderNo + "' ";
		}
		if(!Utils.StrIsNullOrEmpty(startTime)) {
			sql += " and orderDate > '" + startTime + "' ";
		}
		if(!Utils.StrIsNullOrEmpty(endTime)) {
			sql += " and orderDate < '" + endTime + "' ";
		}
		if(findOrderState != 0) {
			sql += " and OrderState = '" + findOrderState + "' ";
		}
		sql += " limit ?,?";
		return DBUtil.getList(sql, OrderInfo.class,page.getBeginRow(),page.getPageSize());
		
	}
	public int getAllOrderCount(String orderNo,String startTime,String endTime,int findOrderState){
		String sql = "select count(*) from OrderInfo where 1=1 ";
		if(!Utils.StrIsNullOrEmpty(orderNo)) {
			sql += " and orderNo = '" + orderNo + "' ";
		}
		if(!Utils.StrIsNullOrEmpty(startTime)) {
			sql += " and orderDate > '" + startTime + "' ";
		}
		if(!Utils.StrIsNullOrEmpty(endTime)) {
			sql += " and orderDate < '" + endTime + "' ";
		}
		if(findOrderState != 0) {
			sql += " and OrderState = '" + findOrderState + "' ";
		}
		long count = DBUtil.getScalar(sql);
		return Integer.valueOf(count+"");
		
	}
}

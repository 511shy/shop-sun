package com.beans;

public class PageInfo {
	private int pageSize;//当前页面大小
	private int rowCount;//全部数据条数
	private int pageIndex;//当前页数
	private int pageCount;//全部页数
	private int beginRow;//从哪行开始
	
	private boolean hasBefore;//是否有上一页
	private boolean hasNext;//是否有下一页
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getRowCount() {
		return rowCount;
	}
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getBeginRow() {
		return beginRow;
	}
	public void setBeginRow(int beginRow) {
		this.beginRow = beginRow;
	}
	public boolean isHasBefore() {
		return hasBefore;
	}
	public void setHasBefore(boolean hasBefore) {
		this.hasBefore = hasBefore;
	}
	public boolean isHasNext() {
		return hasNext;
	}
	public void setHasNext(boolean hasNext) {
		this.hasNext = hasNext;
	}
	
}

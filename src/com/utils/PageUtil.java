package com.utils;

import com.beans.PageInfo;

public class PageUtil {
	public static PageInfo getPageInfo(int pageSize, int rowCount, int pageIndex) {
		PageInfo page = new PageInfo();
		page.setPageSize(pageSize==0?10:pageSize);
		page.setRowCount(rowCount);
		page.setPageIndex(pageIndex);
		page.setPageCount((rowCount+pageSize-1)/pageSize);
		page.setBeginRow(page.getPageSize()*(pageIndex-1));
		page.setHasNext(pageIndex<page.getPageCount());
		page.setHasBefore(!(pageIndex==1));
		return page;
	}
}

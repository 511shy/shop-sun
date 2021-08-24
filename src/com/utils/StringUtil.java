package com.utils;

public class StringUtil {
	public static boolean isNullOrEmpty(String str){
		if(str==null || "".equals(str)){
			return true;
		}
		else{
			return false;
		}
	}
	public static boolean tf(String str) {
		if(!"".equals(str)&&str!=null)
		return true;
		return false;
	}
}

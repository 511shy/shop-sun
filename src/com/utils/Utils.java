package com.utils;

import java.util.List;

public class Utils {
	//首字母大写
	public static String FirstToUpper(String str,String gs) {
		return gs+str.substring(0, 1).toUpperCase()+str.substring(1);
	}
	//字符串是否为空
	public static boolean StrIsNullOrEmpty(String str) {
		return str == null || str.isEmpty();
	}
	//字符数组转int
	public static int[] StrToInt(String[] strArr) {
		int[] intArr = new int[strArr.length];
		for(int a=0;a<strArr.length;a++){
			intArr[a] = Integer.valueOf(strArr[a]);
		}
		return intArr;
	}
}

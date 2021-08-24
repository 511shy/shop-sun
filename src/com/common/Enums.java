package com.common;

import com.common.Enums;
import com.common.Enums.EmnuAdminState;

//这个类里专门用来装程序中用到的各种玫举,及程序中用到的常见的常量
public final class Enums {
	//表示页面大小
	public final static int PAGESIZE=10;
	
	private Enums(){}
	
	enum  weekday {
		 周一,
		 周二,
		 周三,
		 周四,
		 周五 
	}

	//付款方式
	public enum EnumPayMethod{
		网上银行转账,
		邮局汇款,
		霸王餐不付款,
		其他付款方式
	}
	
	//邮递方式
	public enum EnumPostMethod{
		平邮,
		快递,
		EMS,
		卡车运输
	}
	
	//表示会员等级
	public enum EmnuMemberLevel{
		黄金会员,
		白银会员,
		青铜会员,
		普通会员
	}
	
	//表示管理员状态
	public enum EmnuAdminState {

		正常 {
			public String getValue() {
				return "1";
			}
		},

		
		删除{
			public String getValue() {
				return "0";
			}
		},

		
		锁定 {
			public String getValue() {

				return "2";
			}
		};

		public abstract String getValue();
		
	}


	//表示订单状态
	public enum EnumOrderState {
		
		  未付款 {
			public String getValue() {
				return "未付款";
			}
		},

		
		已发货 {
			public String getValue() {

				return "已发货";
			}
		},

		已支付
		{
			public String getValue() {
				return "已支付";
			}
		};   //最后一个,必须是分号

		public abstract String getValue();
	}

	
	public static void main(String[] args) {
		EmnuAdminState [] data = Enums.EmnuAdminState.values();
		
		for(EmnuAdminState  i:data){
			System.out.println(i+":"+i.getValue());
		}
	}

}

package com.git.base.util;

import java.util.Calendar;

public class KeyGenerator {
	/**
	 * 生成流水号
	 * @return
	 */
	public synchronized static String genTransFlowNo() {
		//		String str = Long.toString(System.currentTimeMillis());
		//		System.out.println(str);
		//		return str.substring(str.length() - 8);
		Calendar cal = Calendar.getInstance();
		return Integer.toString(cal.get(Calendar.HOUR_OF_DAY) * 10000 + cal.get(Calendar.MINUTE) * 100 + cal.get(Calendar.SECOND));
	}

	public static void main(String[] args) {
		System.out.println(Integer.parseInt(genTransFlowNo()));
	}
}

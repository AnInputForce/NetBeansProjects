package com.git.base.util;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class DateHelper {
	private static final Log log = LogFactory.getLog(DateHelper.class);

	private DateHelper() {
	}

	public static String DATE_FORMAT = "yyyy-MM-dd";

	public static String DATE_YYYYMMDD_FORMAT = "yyyyMMdd";

	public static String TIME_FORMAT = "HH:mm:ss ";

	public static String TIME_HHMMSS_FORMAT = "HHmmss ";

	private static int[] LAST_DAY_OF_MONTH = new int[] { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

	private static DateFormat df = new SimpleDateFormat(DATE_FORMAT);;

	private static DateFormat dtf = new SimpleDateFormat(DATE_FORMAT + " " + TIME_FORMAT);

	private static DateFormat tf = new SimpleDateFormat(TIME_FORMAT);;

	public static String formatDate(Date aValue) {
		if (aValue == null) {
			return ""; // in order to deal with null object
		}
		return df.format(aValue);
	}

	public static String formatDateYYYYMMDD(Date aValue) {
		if (aValue == null) {
			return ""; // in order to deal with null object
		}

		DateFormat vFormat = new SimpleDateFormat(DATE_YYYYMMDD_FORMAT);
		return vFormat.format(aValue);
	}

	public static String dateAdd(String interval, int count, String dateStr) throws Exception {

		if (dateStr == null || dateStr.equals(""))
			return "";
		Calendar cl = Calendar.getInstance();
		Date d1 = getDate(dateStr);
		cl.setTime(d1);
		if (interval.equalsIgnoreCase("y")) {
			cl.add(Calendar.YEAR, count);
		} else if (interval.equalsIgnoreCase("m")) {
			cl.add(Calendar.MONTH, count);
		} else if (interval.equalsIgnoreCase("d")) {
			cl.add(Calendar.DAY_OF_MONTH, count);
		} else {
			throw new Exception("�����������Ͳ��ԣ�");
		}
		Date d2 = cl.getTime();

		return formatDate(d2);
	}

	/**
	 * DateFormat
	 * 
	 * @return ��ȡ���ڸ�ʽ��2004-01-01
	 */
	public static String formatDate() {
		//Date today = new Date();
		//DateFormat vFormat = new SimpleDateFormat(DATE_FORMAT);
		return df.format(Calendar.getInstance().getTime());
	}

	/**
	 * DateFormat
	 * 
	 * @return ��ȡ���ڸ�ʽ��20040101
	 */
	public static String formatDateYYYYMMDD() {
		Date today = new Date();
		DateFormat vFormat = new SimpleDateFormat(DATE_YYYYMMDD_FORMAT);
		return vFormat.format(today);
	}

	/**
	 * 
	 * @param aValue
	 * @return ��ȡ���ڸ�ʽ��2004-01-01 00��00��01
	 */
	public static String formatDateTime(Date aValue) {
		if (aValue == null) {
			return ""; // in order to deal with null object
		}
		return dtf.format(aValue);
	}

	/**
	 * 
	 * @param aValue
	 * @return ��ȡ���ڸ�ʽ��20040101000001
	 */
	public static String formatDateTimeYYYYMMDDHHMMSS(Date aValue) {
		if (aValue == null) {
			return ""; // in order to deal with null object
		}

		DateFormat vFormat = new SimpleDateFormat(DATE_YYYYMMDD_FORMAT + TIME_HHMMSS_FORMAT);
		return vFormat.format(aValue);
	}

	/**
	 * ���ز�ͬ�ָ�ʽ������
	 * 
	 * @param args
	 *            ��ȡ���ڸ�ʽ��2004��1��31��
	 */
	public static String formatCDate() {
		Date today = new Date();
		DateFormat vFormat = DateFormat.getDateInstance(DateFormat.LONG);
		return vFormat.format(today);
	}

	/**
	 * ���ز�ͬ�ָ�ʽ������
	 * 
	 * @param args
	 *            ��ȡ���ڸ�ʽ��2004��6��23�� ������
	 */
	public static String formatCDay() {
		Date today = new Date();
		DateFormat vFormat = DateFormat.getDateInstance(DateFormat.FULL);
		return vFormat.format(today);
	}

	public static String foramteDate(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return "";

		SimpleDateFormat vFormat = new SimpleDateFormat(DATE_FORMAT);
		Date sDate = vFormat.parse(aValue);
		return vFormat.format(sDate);
	}

	public static String foramteDateYYYYMMDD(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return "";

		SimpleDateFormat vFormat = new SimpleDateFormat(DATE_YYYYMMDD_FORMAT);
		Date sDate = getDate(aValue);
		// Date sDate=new Date(aValue);

		return vFormat.format(sDate);
		// return sDate.toLocaleString();
	}

	public static Date getDate(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return null;
		return df.parse(aValue);
		//		SimpleDateFormat vFormat = new SimpleDateFormat(DATE_FORMAT);
		//		Date sDate = vFormat.parse(aValue);
		//		return sDate;
	}

	public static Date getDateYYYYMMDD(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return null;
		SimpleDateFormat vFormat = new SimpleDateFormat(DATE_YYYYMMDD_FORMAT);
		Date sDate = vFormat.parse(aValue);
		return sDate;
	}

	public static Date getDateTime(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return null;
		SimpleDateFormat vFormat = new SimpleDateFormat(DATE_FORMAT + " " + TIME_FORMAT);
		Date sDate = vFormat.parse(aValue);
		return sDate;
	}

	public static Date getDateTimeYYYYMMDDHHMMSS(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return null;
		SimpleDateFormat vFormat = new SimpleDateFormat(DATE_YYYYMMDD_FORMAT + TIME_HHMMSS_FORMAT);
		Date sDate = vFormat.parse(aValue);
		// Date sDate=getDate(aValue);
		return sDate;
	}

	/**
	 * formatDateTimeYYYYMMDDHHMMSS
	 * 
	 * @return ��ȡ���ڸ�ʽ��20040101000000
	 */
	public static String formatDateTimeYYYYMMDDHHMMSS() {
		Date today = new Date();
		DateFormat vFormat = new SimpleDateFormat(DATE_YYYYMMDD_FORMAT + TIME_HHMMSS_FORMAT);
		return vFormat.format(today);
	}

	/**
	 * ����ͬ��
	 * 
	 * @param aValue
	 * @return
	 * @throws java.lang.Exception
	 */
	public static String getPreYearDay(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return "";
		Date d0 = getDate(aValue);
		d0.setDate(1);
		d0.setMonth(d0.getMonth() + 1);
		d0.setYear(d0.getYear() - 1);
		d0.setDate(d0.getDate() - 1);
		return formatDate(d0);

	}

	public static String getPreYearLastDay(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return "";
		return calculateDate(aValue, -1, 0, 0).substring(0, 4) + "-12-31";

	}

	public static String getPreMonthLastDay(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return "";
		String val = calculateDate(aValue, 0, -1, 0);
		return val.substring(0, 8) + lastDayOfMonth(val);
	}

	public static String getPreDay(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return "";
		return calculateDate(aValue, 0, 0, -1);
	}

	public static String getYear(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return "";
		String[] array = aValue.split("-");
		return array[0];

	}

	public static String getMonth(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return "";
		String[] array = aValue.split("-");
		return array[1];

	}

	public static String getDay(String aValue) throws Exception {
		if (aValue == null || aValue.equals(""))
			return "";
		String[] array = aValue.split("-");
		return array[2];

	}

	/**
	 * 
	 * @param rq
	 * @return
	 */
	public static Integer dateToInt(String rq) {
		if (rq == null || rq.length() < 10) {
			return new Integer(0);
		}
		return Integer.valueOf(rq.substring(0, 4) + rq.substring(5, 7) + rq.substring(8, 10));
	}

	/**
	 * ��ȡĳ�µ����һ��
	 * @param year
	 * @param month �·�����Ϊ 1-12
	 * @return
	 */
	public static String lastDayOfMonth(String year, String month) {
		String lt = Integer.toString(lastDayOfMonth(Integer.parseInt(year), Integer.parseInt(month) - 1));
		return lt.length() == 1 ? ("0" + lt) : lt;
	}

	/**
	 * ��ȡĳ�µ����һ��
	 * @param date ��ʽΪ yyyy*MM*dd �·ݵ�����Ϊ 1-12
	 * @return
	 */
	public static String lastDayOfMonth(String date) {
		return lastDayOfMonth(date.substring(0, 4), date.substring(5, 7));
	}

	/**
	 * ��ȡĳ�µ����һ��
	 * @param date
	 * @return
	 */
	public static int lastDayOfMonth(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return lastDayOfMonth(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH));
	}

	/**
	 * ��ȡĳ�µ����һ��
	 * @param year
	 * @param month �·ݵ�����Ϊ 0-11
	 * @return
	 */
	public static int lastDayOfMonth(int year, int month) {
		if (month == 2 && (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))) {
			return 29;
		}
		return LAST_DAY_OF_MONTH[month];
	}

	/**
	 * ��Date�Ļ����ϼ� year�꣬month�£�day�� �������Ϊ��1.��Date�����ϼ� year�� 2.�ڼ� year ��Ļ����ϼ�
	 * month �� 3.�ڼ� month �µĻ����ϼ� day �� <b>ע��</b>�˴�Ϊ�������յ�˳����мӼ����밴������˳����д���Ľ����һ��
	 * 
	 * @param date
	 *            ���ڼ���Ļ�������
	 * @param year
	 *            �Ӽ���������������ʾ����������ʾ��
	 * @param month
	 *            �Ӽ���������������ʾ����������ʾ��
	 * @param day
	 *            �Ӽ���������������ʾ����������ʾ��
	 * @return ���������ڣ�������ʾ����������ʾ��
	 */
	public static String calculateDate(String date, int year, int month, int day) {
		try {
			Date calDate = calculateDate(df.parse(date), year, month, day);
			return df.format(calDate);
		} catch (Exception e) {
			log.error("���ڼ������", e);
		}
		return "";
	}

	/**
	 * ��Date�Ļ����ϼ� year�꣬month�£�day�� �������Ϊ��1.��Date�����ϼ� year�� 2.�ڼ� year ��Ļ����ϼ�
	 * month �� 3.�ڼ� month �µĻ����ϼ� day �� <b>ע��</b>�˴�Ϊ�������յ�˳����мӼ����밴������˳����д���Ľ����һ��
	 * 
	 * @param date
	 *            ���ڼ���Ļ�������
	 * @param year
	 *            �Ӽ���������������ʾ����������ʾ��
	 * @param month
	 *            �Ӽ���������������ʾ����������ʾ��
	 * @param day
	 *            �Ӽ���������������ʾ����������ʾ��
	 * @return ���������ڣ�������ʾ����������ʾ��
	 */
	public static Date calculateDate(Date date, int year, int month, int day) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.YEAR, year);
		calendar.add(Calendar.MONTH, month);
		calendar.add(Calendar.DATE, day);
		return calendar.getTime();
	}

	/**
	 * ��ȡ��ǰ�����ں�ʱ�� yyy-MM-dd HH:mm:ss ��ʽ
	 * @return
	 */
	public static String currDateAndTime() {
		return dtf.format(Calendar.getInstance().getTime()).trim();
	}

	/**
	 * ��ȡ��ǰ���� yyyy-MM-dd ��ʽ
	 * @return
	 */
	public static String currDate() {
		return df.format(Calendar.getInstance().getTime()).trim();
	}

	/**
	 * ��ȡ��ǰʱ�� HH:mm:ss��ʽ
	 * @return
	 */
	public static String currTime() {
		return tf.format(Calendar.getInstance().getTime()).trim();
	}

	/**
	 * �Ƚϵ�һ������ͬ�ڶ������ڵıȽ�ֵ
	 * @param d1
	 * @param d2
	 * @return
	 */
	public static int compare(String d1, String d2) throws ParseException {
		return compare(df.parse(d1), df.parse(d2));
	}

	/**
	 * �Ƚϵ�һ������ͬ�ڶ������ڵıȽ�ֵ
	 * @param d1
	 * @param d2
	 * @return
	 */
	public static int compare(Date d1, Date d2) {
		return d1.compareTo(d2);
	}

	public static void main(String[] args) throws Exception {
		System.out.println(compare("2007-7-4", "2007-07-05"));
		//		System.out.println(currDateAndTime() + "]");
		//		System.out.println(currDate() + "]");
		//		System.out.println(currTime() + "]");
		//		Calendar cal = Calendar.getInstance();
		//		cal.set(2006, 06, 07, 14, 30, 35);
		//		System.out.println(cal.getTime());
		//		System.out.println(cal.get(Calendar.YEAR) + " " + cal.get(Calendar.MONTH));
		//System.out.println(getPreMonthLastDay("2007-01-06"));
		//		String t1 = "2003-5-1";
		//		System.out.println(getPreYearLastDay(t1));	
		//		System.out.println(getPreMonthLastDay(t1));
		// DateHelper dhp=new DateHelper();
		// Date today=new Date();
		// String s="2004-06-11";
		//
		// SimpleDateFormat df = new SimpleDateFormat("yyyy-mm-dd");
		// try {
		// Date fDate = df.parse("2004-06-188");
		// s=df.format(fDate);
		// }catch (ParseException ex) {
		// ex.printStackTrace();
		// }

		// System.out.println("d:"+Date.parse(s));
		// String da=dhp.formatDateTime(fDate);
		// System.out.println("dates:"+da);
		// ///
		/*
		 * Date now = new Date();
		 * 
		 * DateFormat df = DateFormat.getDateInstance(); DateFormat df1 =
		 * DateFormat.getDateInstance(DateFormat.SHORT); DateFormat df2 =
		 * DateFormat.getDateInstance(DateFormat.MEDIUM); DateFormat df3 =
		 * DateFormat.getDateInstance(DateFormat.LONG); DateFormat df4 =
		 * DateFormat.getDateInstance(DateFormat.FULL); String s =
		 * df.format(now); String s1 = df1.format(now); String s2 =
		 * df2.format(now); String s3 = df3.format(now); String s4 =
		 * df4.format(now);
		 * 
		 * System.out.println("(Default) Today is " + s);
		 * System.out.println("(SHORT) Today is " + s1);
		 * System.out.println("(MEDIUM) Today is " + s2);
		 * System.out.println("(LONG) Today is " + s3);
		 * System.out.println("(FULL) Today is " + s4); // Date now = new
		 * Date(); // // DateFormat defaultFormat =
		 * DateFormat.getDateTimeInstance(); // DateFormat shortFormat =
		 * DateFormat.getDateTimeInstance (DateFormat.SHORT,DateFormat.SHORT); //
		 * DateFormat mediumFormat =
		 * DateFormat.getDateTimeInstance(DateFormat.MEDIUM,DateFormat.MEDIUM); //
		 * DateFormat longFormat =
		 * DateFormat.getDateTimeInstance(DateFormat.LONG,DateFormat.LONG); //
		 * DateFormat fullFormat =
		 * DateFormat.getDateTimeInstance(DateFormat.FULL,DateFormat.FULL); //
		 * String defaultDate = defaultFormat.format(now); // String shortDate =
		 * shortFormat.format(now); // String mediumDate =
		 * mediumFormat.format(now); // String longDate =
		 * longFormat.format(now); // String fullDate = fullFormat.format(now); // //
		 * System.out.println("(Default) Today :" + defaultDate); //
		 * System.out.println("(SHORT) Today : " + shortDate); //
		 * System.out.println("(MEDIUM) Today :" + mediumDate); //
		 * System.out.println("(LONG) Today : " + longDate); //
		 * System.out.println("(FULL) Today : " + fullDate); //
		 */
	}
}

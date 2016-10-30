package com.guloulou.tools;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 *
 * @author kangcunhua
 */
public class MyDateFormat {
	public MyDateFormat() {
	}
    public static MyDateFormat getInstance(){
    	return new MyDateFormat();
    }
	/**
	 * 
	 * @param tmpdate 中文日期 "yyyy-MM-dd"
	 * @return 中文日期到英文日期（'2006-11-23' to 'November 23, 2006'）
	 * @throws java.text.ParseException
	 * SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");   
	 * java.util.Date cnDate = df.parse(tmpdate);   
	 * DateFormat usDate = DateFormat.getDateInstance(DateFormat.LONG,Locale.US);
	 * return usDate.format(cnDate); 
	 */
	public String getUsdate(String tmpdate) throws ParseException {

		return (new SimpleDateFormat("dd MMMM, yyyy", Locale.US))
				.format((new SimpleDateFormat("yyyy-MM-dd")).parse(tmpdate));
		//return (new SimpleDateFormat("dd MMMM,yyyy")).format((new SimpleDateFormat("yyyy-MM-dd")).parse(tmpdate)) ; 

	}

	/**
	 * 
	 * @return 当前日期对应的英文日期
	 */
	public String getNowUsdate() {
		//return (DateFormat.getDateInstance(DateFormat.LONG,Locale.US)).format(new Date()); 
		return (new SimpleDateFormat("dd MMMM, yyyy", Locale.US))
				.format(new Date());
	}

	/**
	 * 
	 * @return 当前日期对应的简写日期
	 */
	public String getNowSimpledate() {
		//return (DateFormat.getDateInstance(DateFormat.LONG,Locale.US)).format(new Date()); 
		return (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.CHINA))
				.format(new Date());
	}

	public static void main(String[] args) throws ParseException {
		System.out.println((DateFormat.getDateInstance(DateFormat.LONG,
				Locale.US)).format((new SimpleDateFormat("yyyy-MM-dd"))
				.parse("2006-11-23")));
		System.out.println((DateFormat.getDateInstance(DateFormat.LONG,
				Locale.US)).format(new Date()));
		System.out.println((new SimpleDateFormat("dd MMMM,yyyy", Locale.US))
				.format((new SimpleDateFormat("yyyy-MM-dd"))
						.parse("2006-11-23")));
		//System.out.println( (new SimpleDateFormat("dd MMMM,yyyy")).format((new SimpleDateFormat("yyyy-MM-dd")).parse("2006-11-23")));
		System.out.println((new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",
				Locale.CHINA)).format(new Date()));

	}
}

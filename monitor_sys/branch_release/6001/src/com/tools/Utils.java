package com.tools;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.GregorianCalendar;

/**
 * 工具箱
 * 
 */
public class Utils {
    public static void closeResultSet(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void closePreparedStatement(PreparedStatement ps) {
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void closeConnection(Connection con) {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // 将Exception转换成String
    public static String getStackTrace(Exception e) {
        StringWriter stringWriter = new StringWriter();
        PrintWriter printWriter = new PrintWriter(stringWriter);
        e.printStackTrace(printWriter);
        return stringWriter.toString();
    }

    // 字符串转码
    public static String convertEncode(String str, String origEncode, String destEncode) {
        try {
            byte[] temp = str.getBytes(origEncode);
            return new String(temp, destEncode);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 左补齐0
     * 
     * @param s
     *            原始字符串
     * @param length
     *            要求的字符串长度, 如果s的长度不够, 则左补齐0, 如果s的长度超过length, 则报错
     * @return
     */
    public static String getFixedLengthString(String s, int length) {
        if (s.getBytes().length > length) {
            throw new RuntimeException("the length of string is too long.");
        }
        int diff = length - s.getBytes().length;
        String ret = s;
        for (int i = 0; i < diff; i++) {
            ret = "0" + ret;
        }
        return ret;
    }

    // 获取当前日期前几天的日期, 如果day为负值, 则为当前日期几天后的日期
    public static Date getDateBefore(Date thisDate, int day) {
        GregorianCalendar worldTour = new GregorianCalendar();
        worldTour.setTimeInMillis(thisDate.getTime());
        worldTour.add(GregorianCalendar.DATE, day * -1);
        return new Date(worldTour.getTimeInMillis());
    }

    // 获取当前日期后几天的日期, 如果day为负值, 则为当前日期前几天的日期
    public static Date getDateAfter(Date thisDate, int day) {
        GregorianCalendar worldTour = new GregorianCalendar();
        worldTour.setTimeInMillis(thisDate.getTime());
        worldTour.add(GregorianCalendar.DATE, day);
        return new Date(worldTour.getTimeInMillis());
    }

    // 取出某月第一天, month中只取year, month, 日期是被忽略的
    public static Date getFirstMonthDate(Date month) {
        GregorianCalendar gc = new GregorianCalendar();
        gc.setTimeInMillis(month.getTime());

        gc.set(GregorianCalendar.DATE, gc.getMinimum(GregorianCalendar.DAY_OF_MONTH));
        return new Date(gc.getTimeInMillis());
    }

    // 取出某月最后一天, month中只取year, month, 日期是被忽略的
    public static Date getLastMonthDate(Date month) {
        GregorianCalendar gc = new GregorianCalendar();
        gc.setTimeInMillis(month.getTime());
        gc.set(GregorianCalendar.DAY_OF_MONTH, gc.getActualMaximum(GregorianCalendar.DAY_OF_MONTH));

        return new Date(gc.getTimeInMillis());
    }

    // 取出当前月的上几个月, month中只取year, month, 日期是被忽略的
    public static Date getMonthBeforeThisMonth(int month) {
        return getMonthBefore(getToday(), month);
    }

    // 取出指定月的上几个月, month中只取year, month, 日期是被忽略的
    public static Date getMonthBefore(Date month, int months) {
        GregorianCalendar gc = new GregorianCalendar();
        gc.setTimeInMillis(month.getTime());
        gc.add(GregorianCalendar.MONTH, months * -1);
        return new Date(gc.getTimeInMillis());
    }

    // 取出当前月的下几个月, month中只取year, month, 日期是被忽略的
    public static Date getMonthAfterThisMonth(int month) {
        return getMonthAfter(getToday(), month);
    }

    // 取出指定月的下几个月, month中只取year, month, 日期是被忽略的
    public static Date getMonthAfter(Date month, int months) {
        GregorianCalendar gc = new GregorianCalendar();
        gc.setTimeInMillis(month.getTime());
        gc.add(GregorianCalendar.MONTH, months * 1);
        return new Date(gc.getTimeInMillis());
    }

    // 比较两月的大小, month1 - month2,
    // >0 表示 month1 > month2, =0 表示 month1 = month2, <0 表示 month1 < month2,
    public static int compareMonth(Date month1, Date month2) {
        if (month1.getYear() > month2.getYear()) {
            return 1;
        }
        if (month1.getYear() < month2.getYear()) {
            return -1;
        }

        return month1.getMonth() - month2.getMonth();
    }

    // 比较两天的大小, day1 - day2,
    // >0 表示 day1 > day2, =0 表示 day1 = day2, <0 表示 day1 < day2,
    public static int compareDay(Date day1, Date day2) {
        if (day1.getYear() > day2.getYear()) {
            return 1;
        }
        if (day1.getYear() < day2.getYear()) {
            return -1;
        }
        if (day1.getMonth() > day2.getMonth()) {
            return 1;
        }
        if (day1.getMonth() < day2.getMonth()) {
            return -1;
        }

        int d1 = day1.getDate();
        int d2 = day2.getDate();
        return d1 - d2;
    }

    // 计算day1和day2相差几天, day1 - day2
    public static int getDayDiff(Date day1, Date day2) {
        int diff = 0;
        if (Utils.compareDay(day1, day2) == 0) {
            return 0;
        } else if (Utils.compareDay(day1, day2) > 0) { // day1 > day2
            while (Utils.compareDay(day1, day2) > 0) {
                diff++;
                day2 = Utils.getDateAfter(day2, 1);
            }
        } else { // day2 > day1
            while (Utils.compareDay(day2, day1) > 0) {
                diff--;
                day1 = Utils.getDateAfter(day1, 1);
            }
        }

        return diff;
    }

    // 取出当天年份
    public static Date getThisYear() {
        return new Date(System.currentTimeMillis());
    }

    // 取出当天月份
    public static Date getThisMonth() {
        return new Date(System.currentTimeMillis());
    }

    // 取出当天日期
    public static Date getToday() {
        return new Date(System.currentTimeMillis());
    }

    // 取出当前时间
    public static Timestamp getNow() {
        return new Timestamp(System.currentTimeMillis());
    }

    // 取出指定月共有多少天
    public static int getDaysInMonth(Date month) {
        GregorianCalendar gc = new GregorianCalendar();
        gc.setTimeInMillis(month.getTime());
        return gc.getActualMaximum(GregorianCalendar.DAY_OF_MONTH);
    }

    // 根据年月日构造日期
    public static Date getDate(int year, int month, int day) {
        return new Date(year - 1900, month - 1, day);
    }

    // 根据年月构造月份
    public static Date getMonth(int year, int month) {
        return getDate(year, month, 1);
    }

    // 取出今年的第一个月
    public static Date getFirstMonthThisYear() {
        return getMonth(getThisYear().getYear() + 1900, 1);
    }

    // 取出今年的最后一个月
    public static Date getLastMonthLastYear() {
        return getMonth(getThisYear().getYear() + 1900 - 1, 12);
    }

    // 取出指定日期一年前的日期, 即如果date是2006-3-28日, 则返回2005-3-29日
    public static Date getOneYearAgo(Date date) {
        return Utils.getDateAfter(new Date(date.getYear() - 1, date.getMonth(), date.getDate()), 1); // 一年前的相同日期的下一天
        // return new Date(date.getYear() - 1, date.getMonth() + 1, 1);
    }

    public static String convertMonth(Date month) {
        SimpleDateFormat todayDateFormatter = new SimpleDateFormat("yyyy-MM");
        return todayDateFormatter.format(month);
    }

    public static String convertDate(Date date) {
        SimpleDateFormat todayDateFormatter = new SimpleDateFormat("yyyy-MM-dd");
        return todayDateFormatter.format(date);
    }

    public static String convertTimestamp(Timestamp time) {
        SimpleDateFormat todayDateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        return todayDateFormatter.format(time);
    }

    public static Date convertDate(String str) throws IllegalArgumentException {
        // string should be in yyyy-mm-dd hh:mm:ss.fffffffff format
        try {
            // assuming yyyy-MM-dd
            return Date.valueOf(str); // + " 00:00:00.000000000");
        } catch (IllegalArgumentException e) {
        }

        throw new IllegalArgumentException(str + " is not in valid Date format.");
    }

    // return java.sql.Date
    public static java.sql.Date getSqlDate(String strDate) {
        // System.out.println("-----------------strDate:"+strDate);
        java.util.Date udate = new java.util.Date();
        java.sql.Date qdate = new java.sql.Date(udate.getTime());
        if (strDate.indexOf("-") >= 0 || strDate.indexOf("/") >= 0) {
            String str[] = null;
            if (strDate.indexOf("-") >= 0) {
                str = strDate.split("-");
            } else {
                str = strDate.split("/");
            }
            udate.setYear(Integer.parseInt(str[0]) - 1900);
            udate.setMonth(Integer.parseInt(str[1]) - 1);
            int blank = str[2].indexOf(" ");
            if (blank >= 0) {
//                String temp = str[2];
                str[2] = str[2].substring(0, blank);
            }
            udate.setDate(Integer.parseInt(str[2]));
            qdate = new java.sql.Date(udate.getTime());
        }
        return qdate;
    }

    public static void main(String[] args) {
        System.out.println(Utils.getDayDiff(Utils.getDate(2005, 12, 1), Utils.getDate(2005, 12, 1)));
        System.out.println(Utils.getDayDiff(Utils.getDate(2005, 12, 31), Utils.getDate(2005, 12, 1)));
        System.out.println(Utils.getDayDiff(Utils.getDate(2005, 12, 1), Utils.getDate(2005, 12, 31)));
        System.out.println(Utils.getDayDiff(Utils.getDate(2005, 12, 1), Utils.getDate(2005, 11, 28)));
        System.out.println(Utils.getLastMonthDate(Utils.getMonth(2005, 2)));
        System.out.println(Utils.getLastMonthDate(Utils.getMonth(2005, 2)));
        System.out.println(Utils.getLastMonthDate(Utils.getMonth(2005, 2)));
        System.out.println(Utils.getLastMonthDate(Utils.getMonth(2005, 2)));
        System.out.println(Utils.getLastMonthDate(Utils.getMonth(2005, 2)));
        System.out.println(Utils.getDate(2005, 12, 31));
        System.out.println(Utils.getFirstMonthThisYear());
        System.out.println(Utils.getLastMonthLastYear());
        System.out.println(Utils.compareDay(Utils.getDate(2005, 1, 9), Utils.getDate(2005, 1, 3)));

        System.out.println(Utils.getOneYearAgo(Utils.getDate(2005, 1, 31)));
        System.out.println(Utils.getOneYearAgo(Utils.getDate(2005, 2, 28)));
        System.out.println(Utils.getOneYearAgo(Utils.getDate(2005, 3, 31)));
        System.out.println(Utils.getOneYearAgo(Utils.getDate(2005, 4, 30)));
        System.out.println(Utils.getOneYearAgo(Utils.getDate(2005, 5, 31)));
        System.out.println(Utils.getOneYearAgo(Utils.getDate(2005, 6, 30)));
        System.out.println(Utils.getOneYearAgo(Utils.getDate(2005, 7, 31)));
        System.out.println(Utils.getOneYearAgo(Utils.getDate(2005, 8, 31)));
        System.out.println(Utils.getOneYearAgo(Utils.getDate(2005, 9, 30)));
        System.out.println(Utils.getOneYearAgo(Utils.getDate(2005, 10, 31)));
        System.out.println(Utils.getOneYearAgo(Utils.getDate(2005, 11, 30)));
        System.out.println(Utils.getOneYearAgo(Utils.getDate(2005, 12, 31)));
    }
}
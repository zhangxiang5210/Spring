package org.jrc.common.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.TimeZone;

/**
 * comment go to Window - Preferences - Java - Code Style - Code Templates
 */
public class DatetimeUtil {
	public final static String DATE_PATTERN = "yyyy-MM-dd";

	public final static String TIME_PATTERN = "HH:mm:ss";

	public final static String DATE_TIME_PATTERN = DATE_PATTERN + " "
			+ TIME_PATTERN;
	public final static String YMDHMS = "yyyyMMddHHmmss";
	
	 /**
     * Date to String 
     * */
	public static String formatDate(Date date,String formatStyle) {
		if(date!=null){
			SimpleDateFormat sdf = new SimpleDateFormat(formatStyle);
			String formatDate = sdf.format(date);
			return formatDate;
		}else{
			return "";
		}
		
	}
	
	 /**
     * Date to Date 
     * */
	public static Date formatDate(String formatStyle,Date date) {
		if(date!=null){
			SimpleDateFormat sdf = new SimpleDateFormat(formatStyle);
			String formatDate = sdf.format(date);		
			try {
				return sdf.parse(formatDate);
			} catch (ParseException e) {
				e.printStackTrace();
				return new Date();
			}
		}else{
			return new Date();
		}
		
	}

	public static final Date convertStringToDate(String pattern, Locale locale,
			TimeZone zone, String strDate) throws ParseException {
		if (locale == null)
			locale = Locale.getDefault();
		if (zone == null)
			zone = TimeZone.getDefault();
		SimpleDateFormat df = new SimpleDateFormat(pattern, locale);
		df.setTimeZone(zone);
		try {
			return df.parse(strDate);
		} catch (ParseException pe) {
			throw new ParseException(pe.getMessage(), pe.getErrorOffset());
		}
	}

	public static final Date convertStringToDate(String strDate) {
		Locale locale = Locale.CHINESE;
		try {
			return convertStringToDate(DATE_PATTERN, locale, null, strDate);
		} catch (Exception e) {
			return null;
		}
	}

	public static final Date convertStringToDate(String strDate, String sytle) {
		Locale locale = Locale.CHINESE;
		try {
			return convertStringToDate(sytle, locale, null, strDate);
		} catch (Exception e) {
			return null;
		}
	}

	public static final String convertDateToString(String pattern,
			Locale locale, TimeZone zone, Date aDate) {
		if (locale == null)
			locale = Locale.getDefault();
		if (zone == null)
			zone = TimeZone.getDefault();
		SimpleDateFormat df = new SimpleDateFormat(pattern, locale);
		df.setTimeZone(zone);
		try {
			return df.format(aDate);
		} catch (Exception e) {
			return "";
		}
	}

	public static final String convertDateToString(String pattern, Date aDate) {
		Locale locale = Locale.CHINESE;
		return convertDateToString(pattern, locale, null, aDate);
	}

	/**
	 * 提供yyyy-MM-dd类型的日期字符串转化
	 */
	public static final Date getBeginDate(String beginDate) {
		Locale locale = Locale.CHINESE;
		try {
			return convertStringToDate("yyyy-MM-dd HH:mm:ss", locale, null,
					beginDate + " 00:00:00");
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 提供yyyy-MM-dd类型的日期字符串转化 专门提供Web页面结束日期转化 如输入2006-07-27，则转化为2006-07-28
	 * 00:00:00
	 */
	public static final Date getEndDate(String endDate) {
		Locale locale = Locale.CHINESE;
		try {
			Date date = convertStringToDate("yyyy-MM-dd HH:mm:ss", locale,
					null, endDate + " 00:00:00");
			return new Date(date.getTime() + 24 * 3600 * 1000);
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 提供yyyy-MM-dd类型的日期字符串转化 专门提供Web页面前一日日期转化 如输入2006-07-27，则转化为2006-07-26
	 * 00:00:00
	 */
	public static final Date getPreDate(String endDate) {
		Locale locale = Locale.CHINESE;
		try {
			Date date = convertStringToDate("yyyy-MM-dd HH:mm:ss", locale,
					null, endDate + " 00:00:00");
			return new Date(date.getTime() - 24 * 3600 * 1000);
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 提供yyyy-MM-dd类型的日期字符串转化 专门提供Web页面前N日日期转化 如输入2006-07-27，则转化为2006-07-26
	 * 00:00:00
	 */
	public static final Date getPreDate(String endDate,int day) {
		Locale locale = Locale.CHINESE;
		try {
			Date date = convertStringToDate("yyyy-MM-dd HH:mm:ss", locale,
					null, endDate + " 00:00:00");
			return new Date(date.getTime() - day*24 * 3600 * 1000);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * yyyy年mm月dd日 星期w
	 */
	public static String getFullDateStr() {
		DateFormat format = DateFormat.getDateInstance(DateFormat.FULL,
				Locale.CHINESE);
		return format.format(new Date());
	}

	/**
	 * 计算两个日期之间相差的天数
	 * 
	 * @param date1
	 * @param date2
	 * @return
	 */

	public static int diffdates(Date date1, Date date2) {
		int result = 0;

		GregorianCalendar gc1 = new GregorianCalendar();
		GregorianCalendar gc2 = new GregorianCalendar();

		gc1.setTime(date1);
		gc2.setTime(date2);
		result = getDays(gc1, gc2);

		return result;
	}

	public static int getDays(GregorianCalendar g1, GregorianCalendar g2) {
		int elapsed = 0;
		GregorianCalendar gc1, gc2;

		if (g2.after(g1)) {
			gc2 = (GregorianCalendar) g2.clone();
			gc1 = (GregorianCalendar) g1.clone();
		} else {
			gc2 = (GregorianCalendar) g1.clone();
			gc1 = (GregorianCalendar) g2.clone();
		}

		gc1.clear(Calendar.MILLISECOND);
		gc1.clear(Calendar.SECOND);
		gc1.clear(Calendar.MINUTE);
		gc1.clear(Calendar.HOUR_OF_DAY);

		gc2.clear(Calendar.MILLISECOND);
		gc2.clear(Calendar.SECOND);
		gc2.clear(Calendar.MINUTE);
		gc2.clear(Calendar.HOUR_OF_DAY);

		while (gc1.before(gc2)) {
			gc1.add(Calendar.DATE, 1);
			elapsed++;
		}
		return elapsed;
	}

	/**
	 * 功能：将表示时间的字符串以给定的样式转化为java.util.Date类型
	 * 且多于或少于给定的时间多少小时（formatStyle和formatStr样式相同）
	 * 
	 * @param:formatStyle 要格式化的样式,如:yyyy-MM-dd HH:mm:ss
	 * @param:formatStr 待转化的字符串(表示的是时间)
	 * @param:hour 多于或少于的小时数(可正可负) 单位为小时
	 * @return java.util.Date
	 */
	public static Date formartDate(String formatStyle, String formatStr,
			int hour) {
		SimpleDateFormat format = new SimpleDateFormat(formatStyle,
				Locale.CHINA);
		try {
			Date date = new Date();
			date.setTime(format.parse(formatStr).getTime() + hour * 60 * 60
					* 1000);
			return date;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}

	/**
	 * 获取现在时刻
	 */
	public static Date getNow() {
		return new Date(new Date().getTime());
	}

	/**
	 * 获取前一小时
	 */
	public static Date getPreHour() {
		return new Date(new Date().getTime() - 3600 * 1000L);
	}

	/**
	 * 获取下一小时
	 */
	public static Date getNextHour() {
		return new Date(new Date().getTime() + 3600 * 1000L);
	}

	/**
	 * 获取昨天
	 */
	public static Date getYesterday() {
		return new Date(new Date().getTime() - 24 * 3600 * 1000L);
	}
	
	/**
	 * 获取前天
	 */
	public static Date getPreYesterday() {
		return new Date(new Date().getTime() - 48 * 3600 * 1000L);
	}

	/**
	 * 获取昨天
	 */
	public static Date getYesterdayDate(Date day) {
		return new Date(day.getTime() - 24 * 3600 * 1000L);
	}

	/**
	 * 获取明天
	 */
	public static Date getTomorrowDate(Date day) {
		return new Date(day.getTime() + 24 * 3600 * 1000L);
	}

	/**
	 * 获取上周
	 */
	public static Date getLastWeek(Date day) {
		return new Date(day.getTime() - 7 * 24 * 3600 * 1000L);
	}

	/**
	 * 获取下周
	 */
	public static Date getNextWeek(Date day) {
		return new Date(day.getTime() + 7 * 24 * 3600 * 1000L);
	}

	/**
	 * 获取上个月
	 */
	public static Date getLastMonth() {
		return getLastMonth(new Date());
	}

	/**
	 * 获得指定时间的某月的第一天
	 * 
	 * @param date
	 * @return
	 * 
	 */
	public static Date getMonthFirstDay(Date date) {
		int[] dateArr = getDateArray(date);
		String year = String.valueOf(dateArr[0]);
		String month = String.valueOf(dateArr[1]);
		month = month.length() == 1 ? "0" + month : month;
		Date retDate = convertStringToDate(year + month + "01", "yyyyMMdd");
		return retDate;
	}

	/**
	 * 获得指定时间的某月的最后一天
	 * 
	 * @param date
	 * @return
	 * 
	 */
	public static Date getMonthLastDay(Date date) {
		int[] dateArr = getDateArray(date);
		int year = dateArr[0];
		int month = dateArr[1];
		int maxDayOfMonth = getMaxDayOfMonth(year, month);
		String monStr = String.valueOf(month);
		monStr = monStr.length() == 1 ? "0" + monStr : monStr;
		Date retDate = convertStringToDate(String.valueOf(year)
				+ String.valueOf(monStr) + String.valueOf(maxDayOfMonth),
				"yyyyMMdd");
		return retDate;
	}

	/**
	 * 获取制定时间的上个月
	 */
	public static Date getLastMonth(Date date) {
		Calendar cal = Calendar
				.getInstance(TimeZone.getDefault(), Locale.CHINA);
		cal.clear();
		cal.setTime(date);
		cal.set(Calendar.MONTH, cal.get(Calendar.MONTH) - 1);
		cal.getTime();
		return cal.getTime();
	}
	
	/**
	 * 获取制定时间的下个月
	 */
	public static Date getNextMonth(Date date, int month) {
		Calendar cal = Calendar
				.getInstance(TimeZone.getDefault(), Locale.CHINA);
		cal.clear();
		cal.setTime(date);
		cal.set(Calendar.MONTH, cal.get(Calendar.MONTH) + month);
		cal.getTime();
		return cal.getTime();
	}

	/**
	 * 获取指定年和月中该月的最大天数
	 * 
	 * @param year
	 *            指定年
	 * @param month
	 *            指定月 1-12
	 * @return 该月最大天数
	 */
	public static int getMaxDayOfMonth(int year, int month) {
		Calendar cal = Calendar
				.getInstance(TimeZone.getDefault(), Locale.CHINA);
		cal.clear();
		cal.set(year, month - 1, 1);
		return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	}

	/**
	 * 根据指定的年份和指定的第多少周序号得到该周的第一天和最后一天日期
	 * 
	 * @param year
	 *            指定的年份,如2006
	 * @param weekNo
	 *            指定年份中的第多少周,如37
	 * @return 该周的起始日期后该周的结束日期<br>
	 *         Date[0] 起始日期<br>
	 *         Date[1] 结束日期
	 */
	public static Date[] getGivenWeekDates(int year, int weekNo) {
		Calendar cal = Calendar
				.getInstance(TimeZone.getDefault(), Locale.CHINA);
		cal.clear();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.WEEK_OF_YEAR, weekNo);
		Date begin = cal.getTime();
		cal.add(Calendar.DAY_OF_YEAR, 6);
		Date end = cal.getTime();
		return new Date[] { begin, end };
	}

	/**
	 * 根据指定日期获取其在一年中的第多少周
	 * 
	 * @param date
	 *            指定的日期,为null默认为当时日期
	 * @return 当年的第多少周序号,如37
	 */
	public static int getWeekNo(Date date) {
		if (date == null)
			date = new Date();
		Calendar cal = Calendar
				.getInstance(TimeZone.getDefault(), Locale.CHINA);
		cal.clear();
		cal.setTime(date);
		return cal.get(Calendar.WEEK_OF_YEAR);
	}

	/**
	 * 获取制定时间的年份
	 * 
	 * @param date
	 *            制定时间
	 * @return 年份
	 */
	public static int getYear(Date date) {
		if (date == null)
			date = new Date();
		Calendar cal = Calendar
				.getInstance(TimeZone.getDefault(), Locale.CHINA);
		cal.clear();
		cal.setTime(date);
		return cal.get(Calendar.YEAR);
	}

	/*
	 * public static void main(String[] args) { Date dd =
	 * convertStringToDate("2006-9-1"); Date d = getLastMonth(dd);
	 * System.out.println(fmtDate(d, "yyyy-MM-dd")); }
	 */

	/**
	 * 格式化日期
	 * 
	 * @param date
	 *            被格式化的日期
	 * @param style
	 *            显示的样式，如yyyyMMdd
	 */
	public static String fmtDate(Date date, String style) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(style);
		return dateFormat.format(date);
	}

	/**
	 * 得到当前日期
	 * 
	 * @return int[] int[0] 年 int[1] 月 int[2] 日 int[3] 时 int[4] 分 int[5] 秒
	 */
	public static int[] getCurrentDate() {
		Calendar cal = Calendar
				.getInstance(TimeZone.getDefault(), Locale.CHINA);
		cal.setTime(new Date());
		int[] date = new int[6];
		date[0] = cal.get(Calendar.YEAR);
		date[1] = cal.get(Calendar.MONTH) + 1;
		date[2] = cal.get(Calendar.DATE);
		date[3] = cal.get(Calendar.HOUR_OF_DAY);
		date[4] = cal.get(Calendar.MINUTE);
		date[5] = cal.get(Calendar.SECOND);
		return date;
	}

	/**
	 * 得到指定日期
	 * 
	 * @return int[] int[0] 年 int[1] 月 int[2] 日 int[3] 时 int[4] 分 int[5] 秒
	 * 
	 */
	public static int[] getDateArray(Date date) {
		Calendar cal = Calendar
				.getInstance(TimeZone.getDefault(), Locale.CHINA);
		cal.setTime(date);
		int[] dateArr = new int[6];
		dateArr[0] = cal.get(Calendar.YEAR);
		dateArr[1] = cal.get(Calendar.MONTH) + 1;
		dateArr[2] = cal.get(Calendar.DATE);
		dateArr[3] = cal.get(Calendar.HOUR_OF_DAY);
		dateArr[4] = cal.get(Calendar.MINUTE);
		dateArr[5] = cal.get(Calendar.SECOND);
		return dateArr;
	}

	/**
	 * 设置制定的年份和月份，再得到该日期的前多少月或后多少月的日期年份和月份
	 * 
	 * @param year
	 *            指定的年份，如 2006
	 * @param month
	 *            制定的月份，如 6
	 * @param monthSect
	 *            月份的差值 如：现在为2006年5月份，要得到后4月，则monthSect = 4，正确日期结果为2006年9月
	 *            如：现在为2006年5月份，要得到前4月，则monthSect = -4，正确日期结果为2006年1月
	 *            如：monthSect = 0，则表示为year年month月
	 * @return int[] int[0] 年份 int[1] 月份
	 */
	public static int[] getLimitMonthDate(int year, int month, int monthSect) {
		year = year < 1 ? 1 : year;
		month = month > 12 ? 12 : month;
		month = month < 1 ? 1 : month;
		Calendar cal = Calendar.getInstance(TimeZone.getDefault(), new Locale(
				"zh", "CN"));
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month);
		cal.add(Calendar.MONTH, monthSect);
		int[] yAndM = new int[2];
		yAndM[0] = cal.get(Calendar.YEAR);
		yAndM[1] = cal.get(Calendar.MONTH);
		if (yAndM[1] == 0) {
			yAndM[0] = yAndM[0] - 1;
			yAndM[1] = 12;
		}
		return yAndM;
	}

	public static Date getDate(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-ddHH:mm:ss");
		try {
			return format.parse(format.format(date));
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static Date getSimpleDate(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			return format.parse(format.format(date));
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 得到本月的第一天和最后一天的字符串的数组
	 *
	 * @param month 格式 'yyyyMM'
	 * @return
	 *
	 */
	public static String[] getMonFirstLastDays(String month) {
		Date thisDate = convertStringToDate(month, "yyyyMM");
		Date firstDay = getMonthFirstDay(thisDate);
		Date lastDay = getMonthLastDay(thisDate);
		return new String[]{convertDateToString("yyyyMMdd", firstDay), convertDateToString("yyyyMMdd", lastDay)};
	}
	
	/**
	 * 获取传入时间的当月的日期 yyyymmdd  author:Liu Liming
	 * @param yyyymmdd
	 * @return 
	 */
	public static String getFirstDate(String yyyymmdd){
		try {
			Date date = DatetimeUtil.convertStringToDate("yyyyMMdd",null,null,yyyymmdd);
			Calendar curCal = Calendar.getInstance();
			curCal.setTime(date);
			curCal.set(Calendar.DATE,1);
			return DatetimeUtil.convertDateToString("yyyyMMdd",curCal.getTime());
		} catch (ParseException e) {
			return "";
		} 
	}
	
	/**
	 * 获取传入时间的当月的日期 yyyymmdd  author:Liu Liming
	 * @param yyyymmdd
	 * @return yyyymmdd
	 */
	public static String getLastDate(String yyyymmdd){
		try {
			String sDate = getFirstDate(yyyymmdd);
			Date date = DatetimeUtil.convertStringToDate("yyyyMMdd",null,null,sDate);
			Calendar retVal = Calendar.getInstance();
			retVal.setTime(date);
			retVal.add(Calendar.MONTH, 1);
			retVal.add(Calendar.DATE, -1);
			return DatetimeUtil.convertDateToString("yyyyMMdd",retVal.getTime());
			
		} catch (ParseException e) {
			return "";
		} 
	}
	/**
	 * 获取Next天
	 */
	public static Date getNextDayDate(Object date ,int amount){
		SimpleDateFormat frm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		try {
			if(date instanceof String){
				calendar.setTime(frm.parse(date.toString()));
			}else if(date instanceof Date){
				calendar.setTime((Date) date);
			}
			calendar.add(Calendar.DATE,amount);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return calendar.getTime();
	}
	
	/**
	 * 获取Next天
	 */
	public static String getNextDay(Object date ,int amount){
		SimpleDateFormat frm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		try {
			if(date instanceof String){
				calendar.setTime(frm.parse(date.toString()));
			}else if(date instanceof Date){
				calendar.setTime((Date) date);
			}
			calendar.add(Calendar.DATE,amount);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return frm.format(calendar.getTime());
	}
	
	/**
	 * 获取Next天
	 */
	public static String getNextDay(Object date ,int amount,String pattern){
		SimpleDateFormat frm = new SimpleDateFormat(pattern);
		Calendar calendar = Calendar.getInstance();
		try {
			if(date instanceof String){
				calendar.setTime(frm.parse(date.toString()));
			}else if(date instanceof Date){
				calendar.setTime((Date) date);
			}
			calendar.add(Calendar.DATE,amount);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return frm.format(calendar.getTime());
	}
	
	/**
	 * 获取Next  MINUTE
	 */
	public static String getNextMinute(Object date ,int amount){
		SimpleDateFormat frm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		try {
			if(date instanceof String){
				calendar.setTime(frm.parse(date.toString()));
			}else if(date instanceof Date){
				calendar.setTime((Date) date);
			}
			calendar.add(Calendar.MINUTE,amount);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return frm.format(calendar.getTime());
	}
	
	/**
	 * @Description:计算给定date在给定day后的值
	 * @param date 合法的java日期格式
	 * @param day	计算的天数
	 * @param format 日期格式化参数 与date格式一致
	 * @return
	 */
	public static String calculateDate(String date,int day,String format){
		SimpleDateFormat df = new SimpleDateFormat(format);
		try{
			Date d = df.parse(date);
			Calendar c = Calendar.getInstance();

			c.setTime(d);
			c.set(Calendar.DAY_OF_YEAR, c.get(Calendar.DAY_OF_YEAR) + day);
			
			return df.format( c.getTime() );
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	/**
	 * 获取该日期的day
	 * @param date
	 * @return
	 */
	public static int getDayOfMonth(Date date){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.get(Calendar.DAY_OF_MONTH);
	}
	
	/**
	 * 获取该日期的最大day
	 * @param date
	 * @return
	 */
	public static int getMaxDayOfMonth(Date date){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	}
	
	/**
	 * 获取该日期当月最后一天
	 * @param date
	 * @return
	 */
	public static Date getEndDayOfMonth(Date date){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		return cal.getTime();
	}
	
	
	/**
	 * 返回偏移月份的第一天
	 * @param date 日期
	 * @param month 增减月份数
	 * @return
	 */
	public static Date getShiftingMonthFirstDay(Date date,int month){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.DATE, 1);
		cal.set(Calendar.MONTH, cal.get(Calendar.MONTH)+month);
		
		return cal.getTime();
	}
	
	public static int getDiffMonth(Date date1,Date date2){
		int diffMonth = 0;
		diffMonth = date1.getYear()*12+date1.getMonth() - (date2.getYear()*12+date2.getMonth());
		return diffMonth;
	}
	
	/**
	 * @param args
	 * @throws ParseException
	 */
	public static void main(String[] args) throws ParseException {
		//SimpleDateFormat df = new SimpleDateFormat("yyyy-mm-dd");
		//System.out.println("====="+diffdates(DatetimeUtil.convertStringToDate("", "yyyyMMdd"), DatetimeUtil.convertStringToDate("", "yyyyMMdd")));
		Date c  = convertStringToDate("2016-11-03","yyyy-MM-dd HH:mm:ss");
		
		System.out.println(c);
		Date date1 = convertStringToDate("2014-07-15", "yyyy-MM-dd");
		Date date2 = convertStringToDate("2012-07-15", "yyyy-MM-dd");
		System.out.println(getDiffMonth(date1,date2));
		
		
		
	}
	
	/**
	 * 计算两个日期之间相差的月数  
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static Integer getMonths(Date date1, Date date2){     
	       int iMonth = 0;     
	       int flag = 0;     
	       try{     
	           Calendar objCalendarDate1 = Calendar.getInstance();     
	           objCalendarDate1.setTime(date1);     
	    
	           Calendar objCalendarDate2 = Calendar.getInstance();     
	           objCalendarDate2.setTime(date2);     
	    
	           if (objCalendarDate2.equals(objCalendarDate1))     
	               return 0;     
	           if (objCalendarDate1.after(objCalendarDate2)){     
	               Calendar temp = objCalendarDate1;     
	               objCalendarDate1 = objCalendarDate2;     
	               objCalendarDate2 = temp;     
	           }     
	           if (objCalendarDate2.get(Calendar.DAY_OF_MONTH) < objCalendarDate1.get(Calendar.DAY_OF_MONTH))     
	               flag = 1;     
	    
	           if (objCalendarDate2.get(Calendar.YEAR) > objCalendarDate1.get(Calendar.YEAR))     
	               iMonth = ((objCalendarDate2.get(Calendar.YEAR) - objCalendarDate1.get(Calendar.YEAR))     
	                       * 12 + objCalendarDate2.get(Calendar.MONTH) - flag)     
	                       - objCalendarDate1.get(Calendar.MONTH);     
	           else    
	               iMonth = objCalendarDate2.get(Calendar.MONTH)     
	                       - objCalendarDate1.get(Calendar.MONTH) - flag;     
	    
	       } catch (Exception e){     
	        e.printStackTrace();     
	       }     
	       return iMonth;     
	   }
	
	/**
	 * 比较2个日期大小
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static Boolean compareDate(Date date1, Date date2) {   
        try {               
                if (date1.getTime() <= date2.getTime()) { 
                        return true; 
                }  else { 
                        return false; 
                } 
        } catch (Exception exception) { 
                exception.printStackTrace(); 
        } 
        return null; 
	}
	
	/**
	 * 比较2个日期大小
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static Boolean compareDate2(Date date1, Date date2) {   
        try {               
                if (date1.getTime() < date2.getTime()) { 
                        return true; 
                }  else { 
                        return false; 
                } 
        } catch (Exception exception) { 
                exception.printStackTrace(); 
        } 
        return null; 
	} 
	
	/**
	 * @return 当前时间，格式：yyyy-MM-dd HH:mm:ss
	 * */
	public static String getCurrentTime(String format) {
		try {
			Calendar date = Calendar.getInstance();
			SimpleDateFormat dateFormat = new SimpleDateFormat(format);
			return dateFormat.format(date.getTime());
		} catch (Exception e) {
			return "";
		}
	}
	
	/**
	 * 根据年月判断该月有多少天
	 */
	public static int howManyDays ( String date ){
        Calendar calendar = Calendar.getInstance ();
        String[] dates = date.split ("[^\\d]");
        int year = Integer.parseInt (dates[0]);
        int month = Integer.parseInt (dates[1]) - 1;
        calendar.set (year, month, 1);
        return calendar.getActualMaximum (Calendar.DAY_OF_MONTH);
    }
	
	
}

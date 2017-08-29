package org.jrc.common.utils;

import java.math.BigDecimal;

/**
 * BigDecimal转化成String类型才能完美解决二进制的问题
 * @author Administrator
 *
 */
public class Arith 
{
	/**
	 *  提供精确加法计算的add方法
	 * @param value1
	 * @param value2
	 * @return
	 */
	public static double add(Object value1,Object value2)
	{
		BigDecimal b1 = new BigDecimal(value1.toString());
		BigDecimal b2 = new BigDecimal(value2.toString());
		return b1.add(b2).doubleValue();
	}
	
	/**
	 * 提供精确减法运算的sub方法
	 * @param value1
	 * @param value2
	 * @return
	 */
	public static double sub(Object value1,Object value2)
	{
		BigDecimal b1 = new BigDecimal(value1.toString());
		BigDecimal b2 = new BigDecimal(value2.toString());
		return b1.subtract(b2).doubleValue();
	}
	
	/**
	 * 提供精确乘法运算的mul方法
	 * @param value1
	 * @param value2
	 * @return
	 */
	public static double mul(Object value1,Object value2)
	{
		BigDecimal b1 = new BigDecimal(value1.toString());
		BigDecimal b2 = new BigDecimal(value2.toString());
		return b1.multiply(b2).doubleValue();
	}
	
	 public static double div(Object value1,Object value2,int scale)
	 {
		/* if(scale<0)
		 {
			 scale = 2;
		 }*/
		 BigDecimal b1 = new BigDecimal(value1.toString());
		 BigDecimal b2 = new BigDecimal(value2.toString());
		 return b1.divide(b2, scale, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	 }
	 
	
	public static void main(String[] args)
	{
		double num = add(555.06,0.01);
		System.out.println(num);
		System.out.println(div(500,3,2));
	}
}

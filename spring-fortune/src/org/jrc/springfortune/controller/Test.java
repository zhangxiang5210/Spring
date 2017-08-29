package org.jrc.springfortune.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class Test {

	public static void main(String[] args) 
	{
		 System.out.println(0.06+0.01);
		 System.out.println(1.0-0.42);
		 System.out.println(4.015*100);
		 System.out.println(303.1/1000);
		 
		 
		 BigDecimal b1 = new BigDecimal(Double.valueOf(0.06));
		 BigDecimal b2 = new BigDecimal(Double.valueOf(0.01));
		 System.out.println("*************");
		 double c = b1.add(b2).doubleValue();
		 System.out.println(c);
		 
		 
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		 
		 Calendar calendar = Calendar.getInstance();
		 calendar.add(Calendar.DATE, 1);
		 
		 String date = sdf.format(calendar.getTime());
		 System.out.println(date);
		 
		 calendar.add(Calendar.DATE, -1);
		 System.out.println(sdf.format(calendar.getTime()));
		 
		 System.out.println("***************");
		 
		 int q = calendar.MONDAY;
		 System.out.println(q);
		 
		 
		 Calendar c1 = Calendar.getInstance();
		 c1.set(Calendar.DATE, 1);	
		 System.out.println(sdf.format(c1.getTime()));
		 
		 Calendar c2 = Calendar.getInstance();
		 c2.set(Calendar.DAY_OF_MONTH, c2.getActualMaximum(Calendar.DAY_OF_MONTH));//最后一天
		 System.out.println(sdf.format(c2.getTime()));
		
			
			
			
	        
	        
	}
}

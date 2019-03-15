/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : com.rainbow.test
 * File Name   : Test4.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年10月26日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */ 
package com.rainbow.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author zong.yq
 *
 */
public class Test4 {

	public static void main(String[] args) {
//		String str1 = "Hello";
//		String str2 = "He" + new String("llo");
//
//		System.out.println(str1 == str2);
		String time = "2019-03-07 17:00:00";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date date = sdf.parse(time);
			System.out.println(date);
			System.out.println(date.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
//		String tagValue = "[AppointmentCollection(''00163E7329A91EE990F9464BFED0AFEE''), AppointmentCollection(''00163E7329D91ED990F946808303A898''), AppointmentCollection(''00163E7329A91EE990F946B3E1E2CFF3'')]";
//		tagValue = tagValue.replace("[","").replace("]","").replace("''","'");
//		System.out.println(tagValue);
//		String a = "AppointmentCollection('00163E7329D91ED990F9880DAE3429FC'), AppointmentCollection('00163E7329D91ED990F98831AD0769FC'), AppointmentCollection('00163E7329A91EE990F9886842C4B140')";
//		System.out.println("a的长度为: " + a.length());
	}

	
}

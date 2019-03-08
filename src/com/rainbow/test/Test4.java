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
	}

	
}

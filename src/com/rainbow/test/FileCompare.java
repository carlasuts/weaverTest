/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : com.rainbow.test
 * File Name   : FileCompare.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年11月2日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */ 
package com.rainbow.test;

import java.util.ArrayList;
import java.util.List;

import weaver.docs.webservices.DocService;
import weaver.docs.webservices.DocServiceImpl;

/**
 * @author zong.yq
 *
 */
public class FileCompare {
	private static final String d = ",";
	
	public static void main(String[] args) {
		
		String a = "001,002,456456,789789";
		String b = "003";
		
		List<String> lists = new ArrayList<String>();
		
		lists.add(a);
		lists.add(b);
		
		StringBuilder sb = new StringBuilder();
		
		for (String list : lists) {
			sb.append(list);
			sb.append(d);
		}
		
		String e = sb.toString();
		
		String[] changes = e.split(",");
		
		for (String change : changes) {
			System.out.println(change.trim());
		}
		
		
		DocService doc = new DocServiceImpl();
		
	}
	
}

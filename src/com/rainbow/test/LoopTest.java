/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : com.rainbow.test
 * File Name   : LoopTest.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年1月23日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package com.rainbow.test;

import java.util.ArrayList;

/**
 * @author zong.yq
 *
 */
public class LoopTest {

	public static void main(String[] args) {

		ArrayList<String> list = new ArrayList<String>();

		list.add("S");
		list.add("S");
		list.add("E");
		list.add("S");

		for (String l : list) {
			if (!l.equals("S")) {
				break;
			}
			System.out.println(l);
		}

	}

}

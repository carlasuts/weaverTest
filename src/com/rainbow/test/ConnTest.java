/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : com.rainbow.test
 * File Name   : ConnTest.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年8月23日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package com.rainbow.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * @author zong.yq
 *
 */
public class ConnTest {

	public static void main(String[] args) {

		String username = "oaprod_new";
		String password = "oaprod";
		ResultSet rs = null;
		Statement stmt = null;
		Connection conn = null;
		String sql = "";
		String test = "";

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = (Connection) DriverManager.getConnection("jdbc:oracle:thin:@172.16.20.6:1521:RPTDB", username,
					password);
			sql = "select * from  USERS_SATISFACTION_RULE where WORKFLOWID = '82'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			int USE_QTY = rs.getInt("USE_QTY");
			System.out.println(USE_QTY);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}

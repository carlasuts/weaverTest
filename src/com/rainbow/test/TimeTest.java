package com.rainbow.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class TimeTest {

	public static void main(String[] args) {

		String username = "oaprod_new";
		String password = "oaprod";
		ResultSet rs = null;
		Statement stmt = null;
		Connection conn = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = (Connection) DriverManager.getConnection("jdbc:oracle:thin:@172.16.20.6:1521:RPTDB", username,
					password);
			String sql = "select * from workflow_requestbase where REQUESTID = '161917'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			String INF_TIME = rs.getString("CREATEDATE") + rs.getString("CREATETIME");
			INF_TIME = INF_TIME.replace(":", "");
			INF_TIME = INF_TIME.replace("-", "");
			System.out.println(INF_TIME);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

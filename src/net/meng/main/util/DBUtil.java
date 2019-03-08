/**
 * ****************************************************************************
 * System      : TestWebService
 * Module      : net.meng.main.util
 * File Name   : DBUtil.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018Äê4ÔÂ13ÈÕ     wei.wang     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package net.meng.main.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author wei.wang
 *
 */
public class DBUtil {
	
	public static Connection getConnection() throws Exception{
		
		String driver = "oracle.jdbc.driver.OracleDriver";
    	String dbName = "RPTDB";
    	String passwrod = "oaprod";
    	String userName = "oaprod_new";
    	String url = "jdbc:oracle:thin:@//172.16.20.6:1521/"+ dbName;
    	Connection conn = null;
    	
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, userName, passwrod);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return conn;
	}
	public static void close(Connection conn){
		if(conn !=null){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(getConnection());
	}
}

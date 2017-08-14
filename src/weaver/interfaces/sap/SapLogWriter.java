package weaver.interfaces.sap;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import weaver.general.BaseBean;

/**
 * Created by Administrator on 2017/2/21.
 */
public class SapLogWriter {

	public static void writerlog(List<Map<String, String>> loglist, String tablename) {
		String sql = "";
		// BaseBean bb = new BaseBean();
		DBUtil db = new DBUtil();
		try {
			Connection conn = db.getConnection();
			PreparedStatement ps = null;

			for (int i = 0; i < loglist.size(); i++) {
				Map<String, String> logmap = loglist.get(i);
				String filedString = "";
				String valueString = "";
				for (String key : logmap.keySet()) {
					filedString += key + ",";
					valueString += "'" + logmap.get(key) + "',";
				}
				if (!"".equals(filedString)) {
					filedString = " (" + filedString.substring(0, filedString.length() - 1) + ")";
					valueString = " (" + valueString.substring(0, valueString.length() - 1) + ")";
					sql = "insert into " + tablename + filedString + " values " + valueString;
					// bb.writeLog("sap插入日志sql", sql);
					System.out.println("sql" + sql);
					ps = conn.prepareStatement(sql);
					ps.execute();
				} else {
					return;
				}

			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static List<Map<String, String>> selectByRequestId(String tableName, String rid) {
		Connection conn = null;
		Statement stmt = null;
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		try {
			conn = DBUtil.getConnection();
			stmt = conn.createStatement();
			String sql = "select * from " + tableName + " where REQUESTID ='" + rid + "'";
			ResultSet rs = stmt.executeQuery(sql);
			ResultSetMetaData md = rs.getMetaData();
			int columns = md.getColumnCount();
			while (rs.next()) {
				Map<String, String> row = new HashMap<String, String>();
				for (int i = 1; i <= columns; ++i) {
					Object value = rs.getObject(i);
					if (value == null || value.toString().equals("")) {
						value = " ";
					}
					row.put(md.getColumnName(i), value.toString());
				}
				list.add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException se2) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		return list;
	}
}

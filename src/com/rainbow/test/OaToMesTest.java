package com.rainbow.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import net.sf.json.JSONObject;
import weaver.interfaces.sap.HttpClientJson;

public class OaToMesTest {

	public static void main(String[] args) {
		String username = "oaprod_new";
		String password = "oaprod";
		ResultSet rs = null;
		Statement stmt = null;
		Connection conn = null;
		String sql = "";
		JSONObject req = new JSONObject();
		JSONObject json = new JSONObject();

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = (Connection) DriverManager.getConnection("jdbc:oracle:thin:@172.16.20.6:1521:RPTDB", username,
					password);
			sql = "SELECT a.LOT_CODE,a.MATERIAL FROM FORMTABLE_MAIN_68_DT1 a INNER JOIN FORMTABLE_MAIN_68 b ON b.ID = a.MAINID WHERE b.REQUESTID = '161986'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				json.put("userId", "OA");
				json.put("factory", "FGS");
				json.put("lotId", rs.getString("LOT_CODE"));
				json.put("matId", rs.getString("MATERIAL"));
				json.put("matVer", "1");
				json.put("delCode", "NOSENDSAP");
				req.put("message", json);
				req.put("fromSystem", "TEST");
				req.put("functionName", "MES_TERMINATELOT");
				req.put("token", "TESTTOKEN");
				System.out.println(req);
				String retSrcs = HttpClientJson.readInterfacePost("http://172.16.59.54:8080/MesWebService/req",
						req.toString());
				System.out.println("retSrcs" + retSrcs);
				System.out.println();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}

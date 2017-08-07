package com.rainbow.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import weaver.interfaces.entity.CInfSpeDat;
import weaver.interfaces.sap.HttpClientJson;

public class JavaToJason {

	public static void main(String[] args) {

		String username = "oaprod_new";
		String password = "oaprod";
		ResultSet rs = null;
		Statement stmt = null;
		Connection conn = null;
		CInfSpeDat cInfSpeDat = new CInfSpeDat();
		String sql = "";
		JSONArray cInfSpeDatList = new JSONArray();
		JSONObject req = new JSONObject();
		JSONObject message = new JSONObject();
		try {
			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPLOADMASTERDATA");
			req.put("token", "OATESTTOKEN");
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = (Connection) DriverManager.getConnection("jdbc:oracle:thin:@172.16.20.6:1521:RPTDB", username,
					password);
			sql = "select count(*) as length from cinfspedat where requestid = 161822";// 获取当前requestID共有多少条记录
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			int length = Integer.valueOf(rs.getString("length"));
			System.out.println(length);
			sql = "select * from cinfspedat where requestid = 161822";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				cInfSpeDat.setInfTime(rs.getString("INF_TIME"));
				cInfSpeDat.setInfSeq(Integer.valueOf(rs.getString("INF_SEQ")));
				cInfSpeDat.setFactory(rs.getString("FACTORY"));
				cInfSpeDat.setMatId(rs.getString("MAT_ID"));
				cInfSpeDat.setCustId(rs.getString("CUST_ID"));
				cInfSpeDat.setCustMatDesc(rs.getString("CUST_MAT_DESC"));
				cInfSpeDat.setDbMatId(rs.getString("DB_MAT_ID"));
				cInfSpeDat.setPkgType(rs.getString("PKG_TYPE"));
				cInfSpeDat.setPackCode(rs.getString("PACK_CODE"));
				cInfSpeDat.setPkldCode(rs.getString("PKLD_CODE"));

				cInfSpeDatList.add(cInfSpeDat);
				message.put("cInfSpeDatList", cInfSpeDatList);
			}
			req.put("message", message);
			System.out.println(req);
			String retSrcs = HttpClientJson.readInterfacePost("http://172.16.60.96:8099/MesWebService/req",
					req.toString());
			System.out.println("retSrcs" + retSrcs);
		} catch (Exception e) {
			e.printStackTrace();
		} // classLoader,加载对应驱动
	}

}

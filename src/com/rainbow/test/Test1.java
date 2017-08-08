package com.rainbow.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import weaver.interfaces.entity.CInfPatDat;
import weaver.interfaces.sap.HttpClientJson;

public class Test1 {

	public static void main(String[] args) {

		String username = "oaprod_new";
		String password = "oaprod";
		ResultSet rs = null;
		Statement stmt = null;
		Connection conn = null;
		CInfPatDat cInfPatDat = new CInfPatDat();
		List cInfPatDatList = new ArrayList();
		String sql = "";
		JSONArray json = new JSONArray();
		JSONObject req = new JSONObject();
		JSONObject message = new JSONObject();

		try {
			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPLOADMASTERDATA");
			req.put("token", "OATESTTOKEN");
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = (Connection) DriverManager.getConnection("jdbc:oracle:thin:@172.16.20.6:1521:RPTDB", username,
					password);
			sql = "select * from cinfpatdat where requestid = 161822";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				cInfPatDat.setInfTime(rs.getString("INF_TIME"));
				cInfPatDat.setInfSeq(Integer.valueOf(rs.getString("INF_SEQ")));
				cInfPatDat.setMatnr(rs.getString("MATNR"));
				cInfPatDat.setWerks(rs.getString("WERKS"));
				cInfPatDat.setStlan(rs.getString("STLAN"));
				cInfPatDat.setStlal(rs.getString("STLAL"));
				cInfPatDat.setPlnnr(rs.getString("PLNNR"));
				cInfPatDat.setPosnr(rs.getString("POSNR"));
				cInfPatDat.setIdnrk(rs.getString("IDNRK"));
				cInfPatDat.setMenge(rs.getString("MENGE"));
				cInfPatDat.setMeins(rs.getString("MEINS"));
				cInfPatDat.setAusch(rs.getString("AUSCH"));
				cInfPatDat.setAlpgr(rs.getString("ALPGR"));
				cInfPatDat.setAlprf(rs.getString("ALPRF"));
				cInfPatDat.setAlpst(rs.getString("ALPST"));
				cInfPatDat.setEwahr(rs.getString("EWAHR"));
				cInfPatDat.setItsob(rs.getString("ITSOB"));
				cInfPatDat.setLgort(rs.getString("LGORT"));
				cInfPatDat.setSanka(rs.getString("SANKA"));
				cInfPatDat.setReadFlag(rs.getString("READ_FLAG"));
				cInfPatDat.setInfMsg(rs.getString("INF_MSG"));
				cInfPatDat.setInfFlag(rs.getString("INF_FLAG"));
				cInfPatDat.setCmf1(rs.getString("CMF_1"));
				cInfPatDat.setCmf2(rs.getString("CMF_2"));
				cInfPatDat.setCmf3(rs.getString("CMF_3"));
				cInfPatDat.setCmf4(rs.getString("CMF_4"));
				cInfPatDat.setCmf5(rs.getString("CMF_5"));
				cInfPatDat.setCmf6(rs.getString("CMF_6"));
				cInfPatDat.setCmf7(rs.getString("CMF_7"));
				cInfPatDat.setCmf8(rs.getString("CMF_8"));
				cInfPatDat.setCmf9(rs.getString("CMF_9"));
				cInfPatDat.setCmf10(rs.getString("CMF_10"));
				cInfPatDat.setDeleteFlag(rs.getString("DELETE_FLAG"));
				cInfPatDat.setCreateTime(rs.getString("CREATE_TIME"));
				cInfPatDat.setCreateUserId(rs.getString("CREATE_USER_ID"));
				cInfPatDat.setUpdateTime(rs.getString("UPDATE_TIME"));
				cInfPatDat.setUpdateUserId(rs.getString("UPDATE_USER_ID"));
				cInfPatDat.setDeleteTime(rs.getString("DELETE_TIME"));
				cInfPatDat.setDeleteUserId(rs.getString("DELETE_USER_ID"));
				cInfPatDatList.add(cInfPatDat);
				json = JSONArray.fromObject(cInfPatDatList);
				message.put("cInfPatDatList", json);
			}
			req.put("message", message);
			System.out.println(req);
			String retSrcs = HttpClientJson.readInterfacePost("http://172.16.60.96:8099/MesWebService/req",
					req.toString());
			System.out.println("retSrcs" + retSrcs);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

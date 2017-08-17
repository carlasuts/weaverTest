package com.rainbow.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import weaver.interfaces.mes.entity.CInfBomDat;
import weaver.interfaces.mes.entity.CInfFlwDat;
import weaver.interfaces.sap.HttpClientJson;

public class Test3 {

	public static void main(String[] args) {

		String username = "oaprod_new";
		String password = "oaprod";
		ResultSet rs = null;
		Statement stmt = null;
		Connection conn = null;
		CInfBomDat cInfBomDat = new CInfBomDat();
		List cInfBomDatList = new ArrayList();
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
			sql = "select * from cinfbomdat where requestid = 161822";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				cInfBomDat.setInfTime(rs.getString("INF_TIME"));
				cInfBomDat.setInfSeq(Integer.valueOf(rs.getString("INF_SEQ")));
				cInfBomDat.setMatnr(rs.getString("MATNR"));
				cInfBomDat.setWerks(rs.getString("WERKS"));
				cInfBomDat.setPlnnr(rs.getString("PLNNR"));
				cInfBomDat.setPlnal(rs.getString("PLNAL"));
				cInfBomDat.setPlnfl(rs.getString("PLNFL"));
				cInfBomDat.setVornr(rs.getString("VORNR"));
				cInfBomDat.setIdnrk(rs.getString("IDNRK"));
				cInfBomDat.setPosnr(rs.getString("POSNR"));
				cInfBomDat.setStlan(rs.getString("STLAN"));
				cInfBomDat.setStlal(rs.getString("STLAL"));
				cInfBomDat.setReadFlag(rs.getString("READ_FLAG"));
				cInfBomDat.setInfMsg(rs.getString("INF_MSG"));
				cInfBomDat.setInfFlag(rs.getString("INF_FLAG"));
				cInfBomDat.setCmf1(rs.getString("CMF_1"));
				cInfBomDat.setCmf2(rs.getString("CMF_2"));
				cInfBomDat.setCmf3(rs.getString("CMF_3"));
				cInfBomDat.setCmf4(rs.getString("CMF_4"));
				cInfBomDat.setCmf5(rs.getString("CMF_5"));
				cInfBomDat.setCmf6(rs.getString("CMF_6"));
				cInfBomDat.setCmf7(rs.getString("CMF_7"));
				cInfBomDat.setCmf8(rs.getString("CMF_8"));
				cInfBomDat.setCmf9(rs.getString("CMF_9"));
				cInfBomDat.setCmf10(rs.getString("CMF_10"));
				cInfBomDat.setDeleteFlag(rs.getString("DELETE_FLAG"));
				cInfBomDat.setCreateTime(rs.getString("CREATE_TIME"));
				cInfBomDat.setCreateUserId(rs.getString("CREATE_USER_ID"));
				cInfBomDat.setUpdateTime(rs.getString("UPDATE_TIME"));
				cInfBomDat.setUpdateUserId(rs.getString("UPDATE_USER_ID"));
				cInfBomDat.setDeleteTime(rs.getString("DELETE_TIME"));
				cInfBomDat.setDeleteUserId(rs.getString("DELETE_USER_ID"));
				cInfBomDatList.add(cInfBomDat);
				json = JSONArray.fromObject(cInfBomDatList);
				message.put("cInfBomDatList", json);
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

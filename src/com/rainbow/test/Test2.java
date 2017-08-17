package com.rainbow.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import weaver.interfaces.mes.entity.CInfFlwDat;
import weaver.interfaces.sap.HttpClientJson;

public class Test2 {

	public static void main(String[] args) {

		String username = "oaprod_new";
		String password = "oaprod";
		ResultSet rs = null;
		Statement stmt = null;
		Connection conn = null;
		CInfFlwDat cInfFlwDat = new CInfFlwDat();
		List cInfFlwDatList = new ArrayList();
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
			sql = "select * from cinfflwdat where requestid = 161822";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				cInfFlwDat.setInfTime(rs.getString("INF_TIME"));
				cInfFlwDat.setInfSeq(Integer.valueOf(rs.getString("INF_SEQ")));
				cInfFlwDat.setMatnr(rs.getString("MATNR"));
				cInfFlwDat.setWerks(rs.getString("WERKS"));
				cInfFlwDat.setPlnnr(rs.getString("PLNNR"));
				cInfFlwDat.setPlnal(rs.getString("PLNAL"));
				cInfFlwDat.setPlnfl(rs.getString("PLNFL"));
				cInfFlwDat.setVornr(rs.getString("VORNR"));
				cInfFlwDat.setArbpl(rs.getString("ARBPL"));
				cInfFlwDat.setSteus(rs.getString("STEUS"));
				cInfFlwDat.setKtsch(rs.getString("KTSCH"));
				cInfFlwDat.setLtxa1(rs.getString("LTXA1"));
				cInfFlwDat.setVgw01(rs.getString("VGW01"));
				cInfFlwDat.setVgw02(rs.getString("VGW02"));
				cInfFlwDat.setVgw03(rs.getString("VGW03"));
				cInfFlwDat.setVgw04(rs.getString("VGW04"));
				cInfFlwDat.setVgw05(rs.getString("VGW05"));
				cInfFlwDat.setVgw06(rs.getString("VGW06"));
				cInfFlwDat.setInfnr(rs.getString("INFNR"));
				cInfFlwDat.setEkorg(rs.getString("EKORG"));
				cInfFlwDat.setSakto(rs.getString("SAKTO"));
				cInfFlwDat.setBmsch(rs.getString("BMSCH"));
				cInfFlwDat.setUemus(rs.getString("UEMUS"));
				cInfFlwDat.setMinwe(rs.getString("MINWE"));
				cInfFlwDat.setSpmus(rs.getString("SPMUS"));
				cInfFlwDat.setSplim(rs.getString("SPLIM"));
				cInfFlwDat.setUmrez(rs.getString("UMREZ"));
				cInfFlwDat.setMeinh(rs.getString("MEINH"));
				cInfFlwDat.setReadFlag(rs.getString("READ_FLAG"));
				cInfFlwDat.setInfMsg(rs.getString("INF_MSG"));
				cInfFlwDat.setInfFlag(rs.getString("INF_FLAG"));
				cInfFlwDat.setCmf1(rs.getString("CMF_1"));
				cInfFlwDat.setCmf2(rs.getString("CMF_2"));
				cInfFlwDat.setCmf3(rs.getString("CMF_3"));
				cInfFlwDat.setCmf4(rs.getString("CMF_4"));
				cInfFlwDat.setCmf5(rs.getString("CMF_5"));
				cInfFlwDat.setCmf6(rs.getString("CMF_6"));
				cInfFlwDat.setCmf7(rs.getString("CMF_7"));
				cInfFlwDat.setCmf8(rs.getString("CMF_8"));
				cInfFlwDat.setCmf9(rs.getString("CMF_9"));
				cInfFlwDat.setCmf10(rs.getString("CMF_10"));
				cInfFlwDat.setDeleteFlag(rs.getString("DELETE_FLAG"));
				cInfFlwDat.setCreateTime(rs.getString("CREATE_TIME"));
				cInfFlwDat.setCreateUserId(rs.getString("CREATE_USER_ID"));
				cInfFlwDat.setUpdateTime(rs.getString("UPDATE_TIME"));
				cInfFlwDat.setUpdateUserId(rs.getString("UPDATE_USER_ID"));
				cInfFlwDat.setDeleteTime(rs.getString("DELETE_TIME"));
				cInfFlwDat.setDeleteUserId(rs.getString("DELETE_USER_ID"));
				cInfFlwDatList.add(cInfFlwDat);
				json = JSONArray.fromObject(cInfFlwDatList);
				message.put("cInfFlwDatList", json);
			}
			req.put("message", message);
			System.out.println(req);
//			String retSrcs = HttpClientJson.readInterfacePost("http://172.16.60.96:8099/MesWebService/req",
//					req.toString());
//			System.out.println("retSrcs" + retSrcs);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

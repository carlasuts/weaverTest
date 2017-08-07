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
				cInfSpeDat.setAddBondDiagramNo(rs.getString("ADD_BOND_DIAGRAM_NO"));
				cInfSpeDat.setAddBondDiagramRev(rs.getString("ADD_BOND_DIAGRAM_REV"));
				cInfSpeDat.setFlowId(rs.getString("FLOW_ID"));
				cInfSpeDat.setOrgCustDeviceId(rs.getString("ORG_CUST_DEVICE_ID"));
				cInfSpeDat.setTopMarkFormatId(rs.getString("TOP_MARK_FORMAT_ID"));
				cInfSpeDat.setBackMarkFormatId(rs.getString("BACK_MARK_FORMAT_ID"));
				cInfSpeDat.setRecipeGroup(rs.getString("RECIPE_GROUP"));
				cInfSpeDat.setStdLotSize(rs.getString("STD_LOT_SIZE"));
				cInfSpeDat.setMatUnit(rs.getString("MAT_UNIT"));
				cInfSpeDat.setBuOper(rs.getString("BU_OPER"));
				cInfSpeDat.setTnrStdOutboxQty(rs.getString("TNR_STD_OUTBOX_QTY"));
				cInfSpeDat.setTubeStdOutboxQty(rs.getString("TUBE_STD_OUTBOX_QTY"));
				cInfSpeDat.setTubeRealPackQty(rs.getString("TUBE_REAL_PACK_QTY"));
				cInfSpeDat.setStdPackQty(rs.getString("STD_PACK_QTY"));
				cInfSpeDat.setHalfPackQty(rs.getString(""));
				cInfSpeDat.setTnrQty(rs.getString(""));
				cInfSpeDat.setTubeQty(rs.getString(""));
				cInfSpeDat.setTrNeedFullInbox(rs.getString(""));
				cInfSpeDat.setInfo1(rs.getString(""));
				cInfSpeDat.setInfo2(rs.getString(""));
				cInfSpeDat.setInfo3(rs.getString(""));
				cInfSpeDat.setInfo4(rs.getString(""));
				cInfSpeDat.setInfo5(rs.getString(""));
				cInfSpeDat.setLable1(rs.getString(""));
				cInfSpeDat.setLable2(rs.getString(""));
				cInfSpeDat.setLable3(rs.getString(""));
				cInfSpeDat.setLable4(rs.getString(""));
				cInfSpeDat.setLable5(rs.getString(""));
				cInfSpeDat.setLable6(rs.getString(""));
				cInfSpeDat.setLable7(rs.getString(""));
				cInfSpeDat.setLable8(rs.getString(""));
				cInfSpeDat.setLable9(rs.getString(""));
				cInfSpeDat.setLable10(rs.getString(""));
				cInfSpeDat.setLable11(rs.getString(""));
				cInfSpeDat.setLable12(rs.getString(""));
				cInfSpeDat.setLable13(rs.getString(""));
				cInfSpeDat.setLable14(rs.getString(""));
				cInfSpeDat.setLable15(rs.getString(""));
				cInfSpeDat.setLable16(rs.getString(""));
				cInfSpeDat.setLable17(rs.getString(""));
				cInfSpeDat.setLable18(rs.getString(""));
				cInfSpeDat.setLable19(rs.getString(""));
				cInfSpeDat.setLable20(rs.getString(""));

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

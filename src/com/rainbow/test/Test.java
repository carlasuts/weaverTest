package com.rainbow.test;

import weaver.interfaces.sap.reprocessinTFME.dao.ReprocessInTFMEDao;
import weaver.interfaces.sap.reprocessinTFME.dao.ReprocessInTFMEDaoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Test {

	public static void main(String[] args) {

		String username = "oaprod_new";
		String password = "oaprod";
		ResultSet rs = null;
		Statement stmt = null;
		Connection conn = null;
		String sql = "";
		ReprocessInTFMEDao repDao = new ReprocessInTFMEDaoImpl();
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = (Connection) DriverManager.getConnection("jdbc:oracle:thin:@172.16.20.6:1521:RPTDB", username,
					password);
			sql = "SELECT LOT_ID,MERGEMODE FROM FORMTABLE_MAIN_68 WHERE REQUESTID = '162301'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			String lotId = rs.getString("LOT_ID");
			int mergeMode = rs.getInt("MERGEMODE");// 合并类型 0:不合并 1：按扩散批号合并 2：按组装批号合并 3：按箱号+扩散批号合并
			String[] lotIdList = lotId.split(",");
			String zero = "";
			String yzx = "";
			List<String> zeroList = new ArrayList<String>();
			List<String> yzxList = new ArrayList<String>();
			List<String> waferLotList = new ArrayList<String>();
			for (String l : lotIdList) {
				sql = "SELECT DISTINCT LOT_CODE,WXS,WAFER_LOT,ASSY_LOT FROM FORMTABLE_MAIN_68_DT1 WHERE LOT_CODE = '"
						+ l + "'";
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
					int wxs = Integer.parseInt(rs.getString("WXS"));
					if (wxs == 0) {
						zero = rs.getString("LOT_CODE");
						zeroList.add(zero);
					} else {
						yzx = rs.getString("LOT_CODE");
						yzxList.add(yzx);
					}
					waferLotList.add(rs.getString("WAFER_LOT"));
				}
			}

			for (int i = 0; i < waferLotList.size(); i++) {
				for (int j = waferLotList.size() - 1; j > i; j--) {
					if (waferLotList.get(j).equals(waferLotList.get(i))) {
						waferLotList.remove(j);
					}
				}
			}

			if (zeroList.size() != 0) {
				zero = custom(zeroList);
				// List<Map<String, String>> list = new ArrayList<Map<String, String>>();
				// @SuppressWarnings("unused")
				// List<ReprocessinTFMEDt2> reprocessInFGSSecondDetailAsZero =
				// repDao.getReprocessInTFMEAsZero(zero,
				// mergeMode);
				// for (ReprocessinTFMEDt2 repData : reprocessInFGSSecondDetailAsZero) {
				// Map<String, String> map = new HashMap<String, String>();
				// map.put("LOT_CODE", repData.getLotCode());
				// map.put("PARENT_LOT_CODE", repData.getParentLotCode());
				// map.put("MATERIAL", repData.getMaterial());
				// map.put("BATCH", repData.getBatch());
				// map.put("QTY", repData.getQty());
				// map.put("SUB_PRODUCTION_ORDER", repData.getSubProductionOrder());
				// map.put("PRODUCTION_ORDER", repData.getProductionOrder());
				// map.put("SALES_ORDER", repData.getSalesOrder());
				// map.put("ASSY_LOT", repData.getAssyLot());
				// map.put("WAFER_LOT", repData.getWaferLot());
				// map.put("STORAGE_LOCATION", repData.getStorageLocation());
				// map.put("BOX_NO", repData.getBoxNo());
				// list.add(map);
				// }

			}
			if (yzxList.size() != 0) {
				yzx = custom(yzxList);
				// List<Map<String, String>> list = new ArrayList<Map<String, String>>();
				// @SuppressWarnings("unused")
				// List<ReprocessinTFMEDt2> getReprocessInFGSSecondDetailAsYzx =
				// repDao.getReprocessInTFMEAsYzx(yzx,
				// mergeMode);
				// for (ReprocessinTFMEDt2 repData : getReprocessInFGSSecondDetailAsYzx) {
				// Map<String, String> map = new HashMap<String, String>();
				// map.put("LOT_CODE", repData.getLotCode());
				// map.put("PARENT_LOT_CODE", repData.getParentLotCode());
				// map.put("MATERIAL", repData.getMaterial());
				// map.put("BATCH", repData.getBatch());
				// map.put("QTY", repData.getQty());
				// map.put("SUB_PRODUCTION_ORDER", repData.getSubProductionOrder());
				// map.put("PRODUCTION_ORDER", repData.getProductionOrder());
				// map.put("SALES_ORDER", repData.getSalesOrder());
				// map.put("ASSY_LOT", repData.getAssyLot());
				// map.put("WAFER_LOT", repData.getWaferLot());
				// map.put("STORAGE_LOCATION", repData.getStorageLocation());
				// map.put("BOX_NO", repData.getBoxNo());
				// list.add(map);
				// }
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static String custom(List<String> list) {
		String newList = "";
		for (int i = 0; i < list.size(); i++) {
			if (i == list.size() - 1) {
				newList = newList + "'" + list.get(i) + "'";
			} else if (i < list.size() - 1) {
				newList = newList + "'" + list.get(i) + "'" + ",";
			}
		}
		return newList;
	}

	// private void merge(Integer mergeMode) {
	// String destBatch = "";
	// if (mergeMode == 0) {
	// return;
	// }
	// if (mergeMode == 1) {
	//
	// }
	// if (mergeMode == 2) {
	//
	// }
	// if (mergeMode == 3) {
	//
	// }
	// }
	public void name() {
		
	}
}

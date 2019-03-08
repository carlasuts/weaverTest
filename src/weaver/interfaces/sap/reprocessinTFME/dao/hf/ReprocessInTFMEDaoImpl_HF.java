/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.sap.reprocessinTFME.dao
 * File Name   : ReprocessInTFMEDaoImpl_CC.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年11月24日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.sap.reprocessinTFME.dao.hf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import weaver.conn.RecordSet;
import weaver.conn.RecordSetDataSource;
import weaver.general.BaseBean;
import weaver.interfaces.sap.reprocessinTFME.entity.ReprocessinTFMEDt2;
import weaver.interfaces.sap.reprocessinTFME.entity.ReprocessinTFMEDt3;

/**
 * @author zong.yq
 *
 */
public class ReprocessInTFMEDaoImpl_HF implements ReprocessInTFMEDao_HF {
	String sql = "";
	String sql1 = "";
	BaseBean basebean = new BaseBean();

	@Override
	public List<ReprocessinTFMEDt2> getReprocessInTFMEAsZero(String zero, String id, Integer formId, String customer) {
		basebean.writeLog("getReprocessInTFMEAsZero开始执行");
		RecordSet rs = new RecordSet();
		List<ReprocessinTFMEDt2> repDataList = new ArrayList<ReprocessinTFMEDt2>();
		RecordSetDataSource rsmis = new RecordSetDataSource("HFMESDB");
		try {
			sql = " SELECT PRODUCTION_ORDER,PARENT_LOT_CODE,LOT_CODE,SUB_PRODUCTION_ORDER,MATERIAL,MAT_SHORT_DESC,QTY,WAFER_LOT,WAFER_LOT158,ASSY_LOT,BATCH,TRACE_CODE,WORK_WEEK,STORAGE_LOCATION,SALES_ORDER,SALES_ORDER_ITEM FROM  (SELECT  DISTINCT "
					+ "STS.ORDER_ID AS PRODUCTION_ORDER," + "STS.LOT_ID AS PARENT_LOT_CODE," + "STS.LOT_ID AS LOT_CODE,"
					+ "STS.LOT_ID AS SUB_PRODUCTION_ORDER,"
					+ "DECODE((SELECT PROC_TYPE FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(STS.LOT_ID,1,14)),'AO',"
					+ "(SELECT ASSY_MAT_ID FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(STS.LOT_ID,1,14)), "
					+ "'AT',(SELECT TEST_MAT_ID FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(STS.LOT_ID,1,14)),STS.MAT_ID) AS MATERIAL, "
					+ "(SELECT MAT_SHORT_DESC FROM MWIPMATDEF WHERE MAT_ID = STS.MAT_ID AND FACTORY=STS.FACTORY )   AS MAT_SHORT_DESC,"
					+ "(STS.QTY_3-(select NVL(SUM(QTY_3-OLD_QTY_3),0) FROM mwiplothis HIS "
					+ "where HIS.LOT_ID=STS.LOT_ID and tran_code='MERGE' AND HIST_DEL_FLAG<>'Y' "
					+ "and from_to_flag='T' and oper<>'6000' " + "AND NOT EXISTS( "
					+ "SELECT 1 FROM CTAPOBXINF OBX,CTAPIBXMLI MLI "
					+ "WHERE ((OBX.LOT_ID = HIS.LOT_ID) OR (OBX.LOT_ID LIKE HIS.LOT_ID||'-%')) AND OBX.INBOX_ID=MLI.INBOX_ID "
					+ "AND MLI.MIXED_LOT_ID<>HIS.FROM_TO_LOT_ID AND OBX.FACTORY='FGS' " + ") " + ")) AS QTY , "
					+ "OSO.CUS_SO AS SALES_ORDER, " + "OSO.CUS_SO_ITEM AS SALES_ORDER_ITEM, "
					+ "ELT.CUST_RUN_ID AS WAFER_LOT, " + "ELT.CUST_LOT_ID||'HFT' AS WAFER_LOT158, "
					+ "ELT.ASSY_LOT_CODE AS ASSY_LOT," + "FUN_IERPRLT(STS.LOT_ID,'TRAN_BATCH_ID') AS BATCH,    "
					+ "ELT.TRACE_CODE AS TRACE_CODE," + "ELT.WORK_WEEK AS WORK_WEEK,"
					+ "FUN_IERPRLT(STS.LOT_ID,'PLANT') || '_' || FUN_IERPRLT(STS.LOT_ID,'GR_LOCATION') AS STORAGE_LOCATION, "
					+ "' ' AS BOX_NO " + "FROM MWIPLOTSTS STS  "
					+ "LEFT JOIN MTAPCPOSTS OSO ON STS.ORDER_ID = OSO.PO_NO "
					+ "LEFT JOIN MWIPELTSTS ELT ON STS.LOT_ID = ELT.LOT_ID " + "WHERE STS.LOT_ID in (" + zero + ") "
					+ "UNION ALL " + "SELECT "
					+ "(SELECT ORDER_ID FROM MWIPLOTSTS WHERE LOT_ID=MRG.FROM_TO_LOT_ID) AS PRODUCTION_ORDER, "
					+ "STS.LOT_ID AS PARENT_LOT_CODE, " + "MRG.FROM_TO_LOT_ID AS LOT_CODE, "
					+ "MRG.FROM_TO_LOT_ID AS SUB_PRODUCTION_ORDER, "
					+ "DECODE((SELECT PROC_TYPE FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(MRG.FROM_TO_LOT_ID,1,14)),'AO',"
					+ "(SELECT ASSY_MAT_ID FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(MRG.FROM_TO_LOT_ID,1,14)), "
					+ "'AT',(SELECT TEST_MAT_ID FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(MRG.FROM_TO_LOT_ID,1,14)),STS.MAT_ID) AS MATERIAL, "
					+ "(SELECT MAT.MAT_SHORT_DESC  FROM  MWIPMATDEF MAT,MWIPLOTSTS  STSM WHERE STSM.LOT_ID=MRG.FROM_TO_LOT_ID AND STSM.FACTORY=MAT.FACTORY AND STSM.MAT_ID= MAT.MAT_ID )AS MAT_SHORT_DESC, "
					+ "((select OLD_QTY_3-QTY_3 FROM mwiplothis HIS "
					+ "where HIS.LOT_ID=MRG.FROM_TO_LOT_ID and tran_code='MERGE' AND HIST_DEL_FLAG<>'Y' "
					+ "and from_to_flag='F' and oper<>'6000' " + ")) AS QTY , "
					+ "(SELECT DISTINCT OSO.CUS_SO FROM MTAPCPOSTS OSO,MWIPLOTSTS LOT WHERE LOT.ORDER_ID = OSO.PO_NO AND LOT.LOT_ID=MRG.FROM_TO_LOT_ID) AS SALES_ORDER, "
					+ "(SELECT DISTINCT OSO.CUS_SO_ITEM FROM MTAPCPOSTS OSO,MWIPLOTSTS LOT WHERE LOT.ORDER_ID = OSO.PO_NO AND LOT.LOT_ID=MRG.FROM_TO_LOT_ID) AS SALES_ORDER_ITEM, "
					+ "(SELECT CUST_RUN_ID FROM MWIPELTSTS WHERE LOT_ID=MRG.FROM_TO_LOT_ID) AS WAFER_LOT, "
					+ "(SELECT CUST_LOT_ID||'HFT' FROM MWIPELTSTS WHERE LOT_ID=MRG.FROM_TO_LOT_ID) AS WAFER_LOT158, "
					+ "(SELECT ASSY_LOT_CODE FROM MWIPELTSTS WHERE LOT_ID=MRG.FROM_TO_LOT_ID) AS ASSY_LOT, "
					+ "FUN_IERPRLT(MRG.FROM_TO_LOT_ID,'TRAN_BATCH_ID') AS BATCH,     "
					+ "(SELECT TRACE_CODE FROM MWIPELTSTS WHERE LOT_ID = MRG.FROM_TO_LOT_ID) AS TRACE_CODE,"
					+ "(SELECT WORK_WEEK FROM MWIPELTSTS WHERE LOT_ID = MRG.FROM_TO_LOT_ID) AS WORK_WEEK,"
					+ "FUN_IERPRLT(MRG.FROM_TO_LOT_ID,'PLANT') || '_' || FUN_IERPRLT(MRG.FROM_TO_LOT_ID,'GR_LOCATION') AS GR_LOCATION, "
					+ "' ' AS BOX_NO  " + "FROM MWIPLOTSTS STS "
					+ "INNER JOIN MWIPLOTMRG MRG ON STS.LOT_ID=MRG.LOT_ID AND MRG.FROM_TO_FLAG='T' AND HIST_DEL_FLAG<>'Y' AND MRG.OPER<>'6000' "
					+ "WHERE STS.LOT_ID in (" + zero + ") " + "AND NOT EXISTS( "
					+ "SELECT  1 FROM CTAPOBXINF OBX,CTAPIBXMLI MLI "
					+ "WHERE ((OBX.LOT_ID = STS.LOT_ID) OR (OBX.LOT_ID LIKE STS.LOT_ID||'-%')) AND OBX.INBOX_ID=MLI.INBOX_ID "
					+ "AND MLI.MIXED_LOT_ID<>MRG.FROM_TO_LOT_ID AND OBX.FACTORY='FGS' "
					+ ") ) ORDER BY PARENT_LOT_CODE,LOT_CODE  "; // 查询没有装箱的拆分后的数据
			rsmis.execute(sql);
			ReprocessinTFMEDt2 repData = new ReprocessinTFMEDt2();
			/** 取到的值放进初始化的实体类中 准备存进数据库里 */
			while (rsmis.next()) {
				repData.setMainid(Integer.parseInt(id));
				repData.setLotCode(rsmis.getString("LOT_CODE"));
				repData.setParentLotCode(rsmis.getString("PARENT_LOT_CODE"));
				repData.setMaterial(rsmis.getString("MATERIAL"));
				repData.setBatch(rsmis.getString("BATCH"));
				repData.setQty(Integer.parseInt(rsmis.getString("QTY")));
				repData.setSubProductionOrder(rsmis.getString("SUB_PRODUCTION_ORDER"));
				repData.setProductionOrder(rsmis.getString("PRODUCTION_ORDER"));
				repData.setSalesOrder(rsmis.getString("SALES_ORDER"));
				repData.setAssyLot(rsmis.getString("ASSY_LOT"));
				if (customer.equals("158")) {
					repData.setWaferLot(rsmis.getString("WAFER_LOT158"));
				} else {
					repData.setWaferLot(rsmis.getString("WAFER_LOT"));
				} // 判断客户是否是158，如果是158则把WAFER_LOT158赋给repData中的waferLot字段，否则赋WAFER_LOT
				repData.setStorageLocation(rsmis.getString("STORAGE_LOCATION"));
				repData.setBoxNo(rsmis.getString("BOX_NO"));
				repData.setTraceCode(rsmis.getString("TRACE_CODE"));
				repData.setDescription(rsmis.getString("MAT_SHORT_DESC"));
				repData.setWorkWeek(rsmis.getString("WORK_WEEK"));
				repData.setSalesOrderItem(rsmis.getString("SALES_ORDER_ITEM"));
				/** 向明细表2数据库插入对应的值 */
				sql = "INSERT INTO FORMTABLE_MAIN_" + formId
						+ "_DT2 (MAINID,QTY,LOT_CODE,PARENT_LOT_CODE,MATERIAL,BATCH,SUB_PRODUCTION_ORDER,PRODUCTION_ORDER,SALES_ORDER,ASSY_LOT,WAFER_LOT,STORAGE_LOCATION,BOX_NO,TRACE_CODE,DESCRIPTION,WORK_WEEK,SALES_ORDER_ITEM) VALUES ("
						+ repData.getMainid() + "," + repData.getQty() + ",'" + repData.getLotCode() + "','"
						+ repData.getParentLotCode() + "','" + repData.getMaterial() + "','" + repData.getBatch()
						+ "','" + repData.getSubProductionOrder() + "','" + repData.getProductionOrder() + "','"
						+ repData.getSalesOrder() + "','" + repData.getAssyLot() + "','" + repData.getWaferLot() + "','"
						+ repData.getStorageLocation() + "','" + repData.getBoxNo() + "','" + repData.getTraceCode()
						+ "','" + repData.getDescription() + "','" + repData.getWorkWeek() + "','"
						+ repData.getSalesOrderItem() + "')";
				basebean.writeLog("零箱插入SQL：" + sql);
				rs.execute(sql);
				rs.next();
				repDataList.add(repData);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return repDataList;

	}

	@Override
	public List<ReprocessinTFMEDt2> getReprocessInTFMEAsYzx(String yzx, String id, Integer formId, String customer) {
		basebean.writeLog("getReprocessInTFMEAsYzx开始执行");
		RecordSetDataSource rsmis = new RecordSetDataSource("HFMESDB");
		List<ReprocessinTFMEDt2> repDataList = new ArrayList<ReprocessinTFMEDt2>();
		RecordSet rs = new RecordSet();
		try {
			sql = " SELECT PRODUCTION_ORDER,LOT_CODE,SUB_PRODUCTION_ORDER,PARENT_LOT_CODE,MATERIAL,MAT_SHORT_DESC,WAFER_LOT,WAFER_LOT158,ASSY_LOT,BATCH,TRACE_CODE,WORK_WEEK,STORAGE_LOCATION,SALES_ORDER,SALES_ORDER_ITEM,SUM(MIXED_QTY) AS QTY,BOX_NO FROM  "
					+ "(SELECT  " + "STS.ORDER_ID AS PRODUCTION_ORDER,   " + "MLI.MIXED_LOT_ID AS LOT_CODE,   "
					+ "STS.LOT_ID AS SUB_PRODUCTION_ORDER, " + " OBX.LOT_ID AS PARENT_LOT_CODE, "
					+ "DECODE((SELECT PROC_TYPE FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(MLI.MIXED_LOT_ID,1,14)),'AO', "
					+ "(SELECT ASSY_MAT_ID FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(MLI.MIXED_LOT_ID,1,14)), "
					+ "'AT',(SELECT TEST_MAT_ID FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(MLI.MIXED_LOT_ID,1,14)),STS.MAT_ID) AS MATERIAL, "
					+ "(SELECT MAT_SHORT_DESC FROM MWIPMATDEF WHERE  MAT_ID=STS.MAT_ID AND FACTORY=STS.FACTORY ) AS MAT_SHORT_DESC,"
					+ "MIXED_QTY , " + "ELT.CUST_RUN_ID AS WAFER_LOT, " + "ELT.CUST_LOT_ID||'HFT' AS WAFER_LOT158,"
					+ "ELT.ASSY_LOT_CODE AS ASSY_LOT, " + "FUN_IERPRLT(STS.LOT_ID,'TRAN_BATCH_ID') AS BATCH, "
					+ "ELT.TRACE_CODE AS TRACE_CODE," + "ELT.WORK_WEEK AS WORK_WEEK,"
					+ "FUN_IERPRLT(STS.LOT_ID,'PLANT') || '_' || FUN_IERPRLT(STS.LOT_ID,'GR_LOCATION') AS STORAGE_LOCATION,  "
					+ "(SELECT OSO.CUS_SO FROM MTAPCPOSTS OSO WHERE OSO.PO_NO=STS.ORDER_ID AND CUST_LOT_ID=ELT.CUST_RUN_ID) AS SALES_ORDER,"
					+ "(SELECT OSO.CUS_SO_ITEM FROM MTAPCPOSTS OSO WHERE OSO.PO_NO = STS.ORDER_ID AND CUST_LOT_ID = ELT.CUST_RUN_ID) AS SALES_ORDER_ITEM,"
					+ "OBX.OUTBOX_ID  AS  BOX_NO  "
					+ "FROM CTAPOBXINF OBX,CTAPIBXMLI MLI,MWIPLOTSTS STS,MWIPELTSTS ELT  "
					+ "WHERE OBX.INBOX_ID=MLI.INBOX_ID AND MLI.MIXED_LOT_ID=STS.LOT_ID  "
					+ "AND STS.LOT_ID=ELT.LOT_ID  " + "AND OBX.LOT_ID in (" + yzx + ") ) AA  "
					+ "GROUP BY PRODUCTION_ORDER,LOT_CODE,MATERIAL,MAT_SHORT_DESC,WAFER_LOT,WAFER_LOT158,ASSY_LOT,BATCH,TRACE_CODE,STORAGE_LOCATION,SALES_ORDER,SALES_ORDER_ITEM,BOX_NO,SUB_PRODUCTION_ORDER,PARENT_LOT_CODE,WORK_WEEK ORDER BY PARENT_LOT_CODE,LOT_CODE  ";
			rsmis.execute(sql);
			ReprocessinTFMEDt2 repData = new ReprocessinTFMEDt2();
			while (rsmis.next()) {
				repData.setMainid(Integer.parseInt(id));
				repData.setLotCode(rsmis.getString("LOT_CODE"));
				repData.setParentLotCode(rsmis.getString("PARENT_LOT_CODE"));
				repData.setMaterial(rsmis.getString("MATERIAL"));
				repData.setBatch(rsmis.getString("BATCH"));
				repData.setQty(Integer.parseInt(rsmis.getString("QTY")));
				repData.setSubProductionOrder(rsmis.getString("SUB_PRODUCTION_ORDER"));
				repData.setProductionOrder(rsmis.getString("PRODUCTION_ORDER"));
				repData.setSalesOrder(rsmis.getString("SALES_ORDER"));
				repData.setAssyLot(rsmis.getString("ASSY_LOT"));
				if (customer.equals("158")) {
					repData.setWaferLot(rsmis.getString("WAFER_LOT158"));
				} else {
					repData.setWaferLot(rsmis.getString("WAFER_LOT"));
				} // 判断客户是否是158，如果是158则把WAFER_LOT158赋给repData中的waferLot字段，否则赋WAFER_LOT
				repData.setStorageLocation(rsmis.getString("STORAGE_LOCATION"));
				repData.setBoxNo(rsmis.getString("BOX_NO"));
				repData.setTraceCode(rsmis.getString("TRACE_CODE"));
				repData.setDescription(rsmis.getString("MAT_SHORT_DESC"));
				repData.setWorkWeek(rsmis.getString("WORK_WEEK"));
				repData.setSalesOrderItem(rsmis.getString("SALES_ORDER_ITEM"));
				sql = "INSERT INTO FORMTABLE_MAIN_" + formId
						+ "_DT2 (MAINID,QTY,LOT_CODE,PARENT_LOT_CODE,MATERIAL,BATCH,SUB_PRODUCTION_ORDER,PRODUCTION_ORDER,SALES_ORDER,ASSY_LOT,WAFER_LOT,STORAGE_LOCATION,BOX_NO,TRACE_CODE,DESCRIPTION,WORK_WEEK,SALES_ORDER_ITEM) VALUES ("
						+ repData.getMainid() + "," + repData.getQty() + ",'" + repData.getLotCode() + "','"
						+ repData.getParentLotCode() + "','" + repData.getMaterial() + "','" + repData.getBatch()
						+ "','" + repData.getSubProductionOrder() + "','" + repData.getProductionOrder() + "','"
						+ repData.getSalesOrder() + "','" + repData.getAssyLot() + "','" + repData.getWaferLot() + "','"
						+ repData.getStorageLocation() + "','" + repData.getBoxNo() + "','" + repData.getTraceCode()
						+ "','" + repData.getDescription() + "','" + repData.getWorkWeek() + "','"
						+ repData.getSalesOrderItem() + "')";
				basebean.writeLog("装箱插入SQL：" + sql);
				rs.execute(sql);
				rs.next();
				repDataList.add(repData);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return repDataList;

	}

	@Override
	public List<ReprocessinTFMEDt3> merge(Integer mergeMode, String id, Integer formId) {
		basebean.writeLog("merge开始执行");
		List<ReprocessinTFMEDt3> repDataList = new ArrayList<ReprocessinTFMEDt3>();
		ReprocessinTFMEDt3 repData = new ReprocessinTFMEDt3();
		try {
			if (mergeMode == 0) {// 不合并
				RecordSet rs = new RecordSet();
				sql = "UPDATE FORMTABLE_MAIN_" + formId + "_DT2 SET DEST_BATCH = BATCH WHERE MAINID = '" + id + "'";
				rs.execute(sql);
				sql = "SELECT QTY,DEST_BATCH,WAFER_LOT,BOX_NO,ASSY_LOT,WORK_WEEK,TRACE_CODE FROM FORMTABLE_MAIN_"
						+ formId + "_DT2 WHERE MAINID = '" + id + "'";
				rs.execute(sql);
				while (rs.next()) {
					repData.setMainid(Integer.parseInt(id));
					repData.setFinalBatch(rs.getString("DEST_BATCH"));
					repData.setAssyLot(rs.getString("ASSY_LOT"));
					repData.setQty(rs.getInt("QTY"));
					repData.setWaferLot(rs.getString("WAFER_LOT"));
					repData.setBoxNo(rs.getString("BOX_NO"));
					repData.setWorkWeek(rs.getString("WORK_WEEK"));
					repData.setTraceCode(rs.getString("TRACE_CODE"));
					sql = "INSERT INTO FORMTABLE_MAIN_" + formId
							+ "_DT3 (MAINID,QTY,FINAL_BATCH,ASSY_LOT,BOX_NO,WAFER_LOT,WORK_WEEK,TRACE_CODE) VALUES ("
							+ repData.getMainid() + "," + repData.getQty() + ",'" + repData.getFinalBatch() + "','"
							+ repData.getAssyLot() + "','" + repData.getBoxNo() + "','" + repData.getWaferLot() + "','"
							+ repData.getWorkWeek() + "','" + repData.getTraceCode() + "')";
					rs.execute(sql);
					basebean.writeLog("不合并语句:" + sql);
				}
			}
			if (mergeMode == 1) { // 按扩散批号合并
				RecordSet rs = new RecordSet();
				RecordSet rs1 = new RecordSet();
				sql = "SELECT MIN(BATCH) AS DEST_BATCH,MAX(BATCH) AS MAX_BATCH,WAFER_LOT FROM FORMTABLE_MAIN_" + formId
						+ "_DT2 WHERE MAINID ='" + id + "' GROUP BY WAFER_LOT";
				Map<String, String> map = new HashMap<String, String>();
				rs.execute(sql);
				while (rs.next()) {
					map.put(rs.getString("WAFER_LOT"), rs.getString("DEST_BATCH"));
				}
				for (Entry<String, String> vo : map.entrySet()) {
					String key = vo.getKey();
					String value = vo.getValue();
					basebean.writeLog("key:" + key);
					basebean.writeLog("value:" + value);
					sql = "SELECT WAFER_LOT FROM FORMTABLE_MAIN_" + formId + "_DT2 WHERE MAINID = '" + id + "'";
					rs.execute(sql);
					while (rs.next()) {
						String waferLot = rs.getString("WAFER_LOT");
						if (waferLot.equals(key)) {
							sql = "UPDATE FORMTABLE_MAIN_" + formId + "_DT2 SET DEST_BATCH ='" + value
									+ "' WHERE MAINID = '" + id + "' AND WAFER_LOT = '" + waferLot + "'";
							rs.execute(sql);
						}
					}
				}
				sql = "SELECT DEST_BATCH,WAFER_LOT,SUM(QTY) AS QTY FROM FORMTABLE_MAIN_" + formId
						+ "_DT2 WHERE MAINID = '" + id + "' GROUP BY WAFER_LOT,DEST_BATCH";
				rs.execute(sql);
				while (rs.next()) {
					repData.setMainid(Integer.parseInt(id));
					repData.setFinalBatch(rs.getString("DEST_BATCH"));
					sql1 = "SELECT ASSY_LOT,BOX_NO,WORK_WEEK,TRACE_CODE FROM FORMTABLE_MAIN_" + formId
							+ "_DT2 WHERE MAINID = '" + id + "' AND DEST_BATCH = '" + rs.getString("DEST_BATCH")
							+ "' AND BATCH = DEST_BATCH";
					rs1.execute(sql1);
					rs1.next();
					repData.setAssyLot(rs1.getString("ASSY_LOT"));
					repData.setQty(rs.getInt("QTY"));
					repData.setWaferLot(rs.getString("WAFER_LOT"));
					repData.setBoxNo(rs1.getString("BOX_NO"));
					repData.setWorkWeek(rs1.getString("WORK_WEEK"));
					repData.setTraceCode(rs1.getString("TRACE_CODE"));
					sql = "INSERT INTO FORMTABLE_MAIN_" + formId
							+ "_DT3 (MAINID,QTY,FINAL_BATCH,ASSY_LOT,BOX_NO,WAFER_LOT,WORK_WEEK,TRACE_CODE) VALUES ("
							+ repData.getMainid() + "," + repData.getQty() + ",'" + repData.getFinalBatch() + "','"
							+ repData.getAssyLot() + "','" + repData.getBoxNo() + "','" + repData.getWaferLot() + "','"
							+ repData.getWorkWeek() + "','" + repData.getTraceCode() + "')";
					rs.execute(sql);
					basebean.writeLog("按扩散批号合并插入sql：" + sql);
				}
			}
			if (mergeMode == 2) { // 按组装批号合并
				RecordSet rs = new RecordSet();
				RecordSet rs1 = new RecordSet();
				sql = "SELECT MIN(BATCH) AS DEST_BATCH,ASSY_LOT FROM FORMTABLE_MAIN_" + formId + "_DT2 WHERE MAINID ='"
						+ id + "' GROUP BY ASSY_LOT";
				Map<String, String> map = new HashMap<String, String>();
				rs.execute(sql);
				while (rs.next()) {
					map.put(rs.getString("ASSY_LOT"), rs.getString("DEST_BATCH"));
				}
				for (Entry<String, String> vo : map.entrySet()) {
					String key = vo.getKey();
					String value = vo.getValue();
					basebean.writeLog("key:" + key);
					basebean.writeLog("value:" + value);
					sql = "SELECT ASSY_LOT FROM FORMTABLE_MAIN_" + formId + "_DT2 WHERE MAINID = '" + id + "'";
					basebean.writeLog(sql);
					rs.execute(sql);
					while (rs.next()) {
						String assyLot = rs.getString("ASSY_LOT");
						if (assyLot.equals(key)) {
							sql = "UPDATE FORMTABLE_MAIN_" + formId + "_DT2 SET DEST_BATCH ='" + value
									+ "' WHERE MAINID = '" + id + "' AND ASSY_LOT = '" + assyLot + "'";
							basebean.writeLog(sql);
							rs.execute(sql);
						}
					}
				}
				sql = "SELECT DEST_BATCH,ASSY_LOT,SUM(QTY) AS QTY FROM FORMTABLE_MAIN_" + formId
						+ "_DT2 WHERE MAINID = '" + id + "' GROUP BY ASSY_LOT,DEST_BATCH";
				rs.execute(sql);
				while (rs.next()) {
					repData.setMainid(Integer.parseInt(id));
					repData.setFinalBatch(rs.getString("DEST_BATCH"));
					repData.setAssyLot(rs.getString("ASSY_LOT"));
					repData.setQty(rs.getInt("QTY"));
					sql1 = "SELECT WAFER_LOT,BOX_NO,WORK_WEEK,TRACE_CODE FROM FORMTABLE_MAIN_" + formId
							+ "_DT2 WHERE MAINID = '" + id + "' AND DEST_BATCH = '" + rs.getString("DEST_BATCH")
							+ "' AND BATCH = DEST_BATCH";
					rs1.execute(sql1);
					rs1.next();
					repData.setWaferLot(rs1.getString("WAFER_LOT"));
					repData.setBoxNo(rs1.getString("BOX_NO"));
					repData.setWorkWeek(rs1.getString("WORK_WEEK"));
					repData.setTraceCode(rs1.getString("TRACE_CODE"));
					sql = "INSERT INTO FORMTABLE_MAIN_" + formId
							+ "_DT3 (MAINID,QTY,FINAL_BATCH,ASSY_LOT,BOX_NO,WAFER_LOT,WORK_WEEK,TRACE_CODE) VALUES ("
							+ repData.getMainid() + "," + repData.getQty() + ",'" + repData.getFinalBatch() + "','"
							+ repData.getAssyLot() + "','" + repData.getBoxNo() + "','" + repData.getWaferLot() + "','"
							+ repData.getWorkWeek() + "','" + repData.getTraceCode() + "')";
					rs.execute(sql);
					basebean.writeLog("按组装批号合并插入语句:" + sql);
				}
			}
			if (mergeMode == 3) { // 按扩散批号和组装批号合并
				RecordSet rs = new RecordSet();
				RecordSet rs1 = new RecordSet();
				sql = "SELECT MIN(BATCH) AS DEST_BATCH,WAFER_LOT||BOX_NO AS TARGET FROM FORMTABLE_MAIN_" + formId
						+ "_DT2 WHERE MAINID ='" + id + "' GROUP BY WAFER_LOT,BOX_NO";
				Map<String, String> map = new HashMap<String, String>();
				rs.execute(sql);
				while (rs.next()) {
					map.put(rs.getString("TARGET"), rs.getString("DEST_BATCH"));
				}
				for (Entry<String, String> vo : map.entrySet()) {
					String key = vo.getKey();
					String value = vo.getValue();
					basebean.writeLog("key:" + key);
					basebean.writeLog("value:" + value);
					sql = "SELECT WAFER_LOT||BOX_NO AS OBJECTIVE FROM FORMTABLE_MAIN_" + formId + "_DT2 WHERE MAINID ='"
							+ id + "'";
					rs.execute(sql);
					while (rs.next()) {
						String objective = rs.getString("OBJECTIVE");
						if (objective.equals(key)) {
							sql = "UPDATE FORMTABLE_MAIN_" + formId + "_DT2 SET DEST_BATCH ='" + value
									+ "' WHERE MAINID = '" + id + "' AND WAFER_LOT||BOX_NO = '" + objective + "'";
							basebean.writeLog(sql);
							rs.execute(sql);
						}
					}
				}
				sql = "SELECT DEST_BATCH,WAFER_LOT,BOX_NO,SUM(QTY) AS QTY FROM FORMTABLE_MAIN_" + formId
						+ "_DT2 WHERE MAINID = '" + id + "' GROUP BY WAFER_LOT,DEST_BATCH,BOX_NO";
				rs.execute(sql);
				while (rs.next()) {
					repData.setMainid(Integer.parseInt(id));
					repData.setFinalBatch(rs.getString("DEST_BATCH"));
					sql1 = "SELECT ASSY_LOT,BOX_NO,WORK_WEEK,TRACE_CODE FROM FORMTABLE_MAIN_" + formId
							+ "_DT2 WHERE MAINID = '" + id + "' AND DEST_BATCH = '" + rs.getString("DEST_BATCH")
							+ "' AND BATCH = DEST_BATCH";
					rs1.execute(sql1);
					rs1.next();
					repData.setAssyLot(rs1.getString("ASSY_LOT"));
					repData.setQty(rs.getInt("QTY"));
					repData.setWaferLot(rs.getString("WAFER_LOT"));
					repData.setBoxNo(rs.getString("BOX_NO"));
					repData.setWorkWeek(rs1.getString("WORK_WEEK"));
					repData.setTraceCode(rs1.getString("TRACE_CODE"));
					sql = "INSERT INTO FORMTABLE_MAIN_" + formId
							+ "_DT3 (MAINID,QTY,FINAL_BATCH,ASSY_LOT,BOX_NO,WAFER_LOT,WORK_WEEK,TRACE_CODE) VALUES ("
							+ repData.getMainid() + "," + repData.getQty() + ",'" + repData.getFinalBatch() + "','"
							+ repData.getAssyLot() + "','" + repData.getBoxNo() + "','" + repData.getWaferLot() + "','"
							+ repData.getWorkWeek() + "','" + repData.getTraceCode() + "')";
					rs.execute(sql);
					basebean.writeLog("按扩散批号和箱号合并插入语句:" + sql);
				}
			}
			if (mergeMode == 4) { // 按年周号合并
				RecordSet rs = new RecordSet();
				RecordSet rs1 = new RecordSet();
				sql = "SELECT MIN(BATCH) AS DEST_BATCH,WORK_WEEK FROM FORMTABLE_MAIN_" + formId + "_DT2 WHERE MAINID ='"
						+ id + "' GROUP BY WORK_WEEK";
				Map<String, String> map = new HashMap<String, String>();
				rs.execute(sql);
				while (rs.next()) {
					map.put(rs.getString("WORK_WEEK"), rs.getString("DEST_BATCH"));
				}
				for (Entry<String, String> vo : map.entrySet()) {
					String key = vo.getKey();
					String value = vo.getValue();
					basebean.writeLog("key:" + key);
					basebean.writeLog("value:" + value);
					sql = "SELECT WORK_WEEK FROM FORMTABLE_MAIN_" + formId + "_DT2 WHERE MAINID ='" + id + "'";
					rs.execute(sql);
					while (rs.next()) {
						String objective = rs.getString("WORK_WEEK");
						if (objective.equals(key)) {
							sql = "UPDATE FORMTABLE_MAIN_" + formId + "_DT2 SET DEST_BATCH ='" + value
									+ "' WHERE MAINID = '" + id + "' AND WORK_WEEK = '" + objective + "'";
							basebean.writeLog(sql);
							rs.execute(sql);
						}
					}
				}
				sql = "SELECT DEST_BATCH,WORK_WEEK,SUM(QTY) AS QTY FROM FORMTABLE_MAIN_" + formId
						+ "_DT2 WHERE MAINID = '" + id + "' GROUP BY WORK_WEEK,DEST_BATCH";
				rs.execute(sql);
				while (rs.next()) {
					repData.setMainid(Integer.parseInt(id));
					repData.setFinalBatch(rs.getString("DEST_BATCH"));
					repData.setQty(rs.getInt("QTY"));
					repData.setWorkWeek(rs.getString("WORK_WEEK"));
					sql1 = "SELECT ASSY_LOT,WAFER_LOT, BOX_NO,TRACE_CODE FROM FORMTABLE_MAIN_" + formId
							+ "_DT2 WHERE MAINID = '" + id + "' AND DEST_BATCH = '" + rs.getString("DEST_BATCH")
							+ "' AND BATCH = DEST_BATCH";
					rs1.execute(sql1);
					rs1.next();
					repData.setAssyLot(rs1.getString("ASSY_LOT"));
					repData.setWaferLot(rs1.getString("WAFER_LOT"));
					repData.setBoxNo(rs1.getString("BOX_NO"));
					repData.setTraceCode(rs1.getString("TRACE_CODE"));
					sql = "INSERT INTO FORMTABLE_MAIN_" + formId
							+ "_DT3 (MAINID,QTY,FINAL_BATCH,ASSY_LOT,BOX_NO,WAFER_LOT, WORK_WEEK,TRACE_CODE) VALUES ("
							+ repData.getMainid() + "," + repData.getQty() + ",'" + repData.getFinalBatch() + "','"
							+ repData.getAssyLot() + "','" + repData.getBoxNo() + "','" + repData.getWaferLot() + "','"
							+ repData.getWorkWeek() + "','" + repData.getTraceCode() + "')";
					rs.execute(sql);
					basebean.writeLog("按扩散批号和箱号合并插入语句:" + sql);
				}
			}
			if (mergeMode == 5) { // 按整理编号合并
				RecordSet rs = new RecordSet();
				RecordSet rs1 = new RecordSet();
				sql = "SELECT MIN(BATCH) AS DEST_BATCH,TRACE_CODE FROM FORMTABLE_MAIN_" + formId
						+ "_DT2 WHERE MAINID ='" + id + "' GROUP BY TRACE_CODE";
				Map<String, String> map = new HashMap<String, String>();
				rs.execute(sql);
				while (rs.next()) {
					map.put(rs.getString("TRACE_CODE"), rs.getString("DEST_BATCH"));
				}
				for (Entry<String, String> vo : map.entrySet()) {
					String key = vo.getKey();
					String value = vo.getValue();
					basebean.writeLog("key:" + key);
					basebean.writeLog("value:" + value);
					sql = "SELECT TRACE_CODE FROM FORMTABLE_MAIN_" + formId + "_DT2 WHERE MAINID ='" + id + "'";
					rs.execute(sql);
					while (rs.next()) {
						String objective = rs.getString("TRACE_CODE");
						if (objective.equals(key)) {
							sql = "UPDATE FORMTABLE_MAIN_" + formId + "_DT2 SET DEST_BATCH ='" + value
									+ "' WHERE MAINID = '" + id + "' AND TRACE_CODE = '" + objective + "'";
							basebean.writeLog(sql);
							rs.execute(sql);
						}
					}
				}
				sql = "SELECT DEST_BATCH,TRACE_CODE,SUM(QTY) AS QTY FROM FORMTABLE_MAIN_" + formId
						+ "_DT2 WHERE MAINID = '" + id + "' GROUP BY TRACE_CODE,DEST_BATCH";
				rs.execute(sql);
				while (rs.next()) {
					repData.setMainid(Integer.parseInt(id));
					repData.setFinalBatch(rs.getString("DEST_BATCH"));
					repData.setQty(rs.getInt("QTY"));
					repData.setTraceCode(rs.getString("TRACE_CODE"));
					sql1 = "SELECT ASSY_LOT,WAFER_LOT, BOX_NO, WORK_WEEK FROM FORMTABLE_MAIN_" + formId
							+ "_DT2 WHERE MAINID = '" + id + "' AND DEST_BATCH = '" + rs.getString("DEST_BATCH")
							+ "' AND BATCH = DEST_BATCH";
					rs1.execute(sql1);
					rs1.next();
					repData.setAssyLot(rs1.getString("ASSY_LOT"));
					repData.setWaferLot(rs1.getString("WAFER_LOT"));
					repData.setBoxNo(rs1.getString("BOX_NO"));
					repData.setWorkWeek(rs1.getString("WORK_WEEK"));
					sql = "INSERT INTO FORMTABLE_MAIN_" + formId
							+ "_DT3 (MAINID,QTY,FINAL_BATCH,ASSY_LOT,BOX_NO,WAFER_LOT, WORK_WEEK,TRACE_CODE) VALUES ("
							+ repData.getMainid() + "," + repData.getQty() + ",'" + repData.getFinalBatch() + "','"
							+ repData.getAssyLot() + "','" + repData.getBoxNo() + "','" + repData.getWaferLot() + "','"
							+ repData.getWorkWeek() + "','" + repData.getTraceCode() + "')";
					rs.execute(sql);
					basebean.writeLog("按扩散批号和箱号合并插入语句:" + sql);
				}
			}
			sql = "SELECT QTY,FINAL_BATCH FROM FORMTABLE_MAIN_" + formId + "_DT3 WHERE MAINID = '" + id + "'";
			basebean.writeLog("查询明细表3的sql:" + sql);
			RecordSet rs = new RecordSet();
			rs.execute(sql);
			while (rs.next()) {
				repData.setQty(Integer.parseInt(rs.getString("QTY")));
				repData.setFinalBatch(rs.getString("FINAL_BATCH"));
				repDataList.add(repData);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return repDataList;

	}

	@Override
	public void init(String id, Integer formId) {
		RecordSet rs = new RecordSet();
		sql = "DELETE FROM FORMTABLE_MAIN_" + formId + "_DT2 WHERE MAINID = '" + id + "'";
		rs.execute(sql);
		sql = "DELETE FROM FORMTABLE_MAIN_" + formId + "_DT3 WHERE MAINID = '" + id + "'";
		rs.execute(sql);
	}

}

package weaver.interfaces.schedule;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.RequestService;

import java.text.SimpleDateFormat;
import java.util.Date;

public class FSTMES361SCH extends BaseCronJob {
	public void execute() {
		BaseBean bs = new BaseBean();
		try {
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");// ��ʼ������
			String date = sdf.format(d);
			String ID = "";
			String FXNO = "";
			String CUST_ID = "";
			String MAT_DESC = "";
			String ASSYLOT = "";
			String CUST_RUN_ID = "";
			String CREATE_DATE = "";
			String RES_ID = "";
			String LOT_ID = "";
			String PROGRAM_ID = "";
			String PKLD = "";
			String OPER = "";
			String INPUT_QTY = "";
			String PASS_QTY = "";
			String TOTAL_YIELD = "";
			String USER_ID = "";
			String FLAG = "";
			String sql = "";
			RecordSet rs = new RecordSet();
			RecordSet rs1 = new RecordSet();
			// ������������
			sql = "select ID,FXNO,CUST_ID,MAT_DESC,ASSYLOT,CUST_RUN_ID,CREATE_DATE,RES_ID,LOT_ID,PROGRAM_ID,PKLD,OPER,INPUT_QTY,PASS_QTY,TOTAL_YIELD,USER_ID,FLAG from CPYC_MIDDLE where flag = '0'";
			rs.executeSql(sql);
			while (rs.next()) {
				ID = rs.getString("ID");
				FXNO = rs.getString("FXNO");
				CUST_ID = rs.getString("CUST_ID");
				MAT_DESC = rs.getString("MAT_DESC");
				ASSYLOT = rs.getString("ASSYLOT");
				CUST_RUN_ID = rs.getString("CUST_RUN_ID");
				CREATE_DATE = rs.getString("CREATE_DATE");
				RES_ID = rs.getString("RES_ID");
				LOT_ID = rs.getString("LOT_ID");
				PROGRAM_ID = rs.getString("PROGRAM_ID");
				PKLD = rs.getString("PKLD");
				OPER = rs.getString("OPER");
				INPUT_QTY = rs.getString("INPUT_QTY");
				PASS_QTY = rs.getString("PASS_QTY");
				TOTAL_YIELD = rs.getString("TOTAL_YIELD");
				USER_ID = rs.getString("USER_ID");
				FLAG = rs.getString("FLAG");

				sql = "select id from hrmresource where workcode = '" + USER_ID + "'";
				bs.writeLog("sql:" + sql);
				rs1.executeSql(sql);
				if (rs1.next()) {
					USER_ID = rs1.getString("id");
				} else {
					USER_ID = "1";
				}

				RequestInfo requestInfo = new RequestInfo();
				MainTableInfo mainTableInfo = new MainTableInfo();

				/*
				 * if((TOPBIN1_PROMPT.equals("") || TOPBIN1_PROMPT.equals("0"))
				 * && (TOPBIN2_PROMPT.equals("") || TOPBIN2_PROMPT.equals("0"))
				 * && (TOPBIN3_PROMPT.equals("") || TOPBIN3_PROMPT.equals("0"))
				 * && (TOPBIN1_QTY.equals("") || TOPBIN1_QTY.equals("0")) &&
				 * (TOPBIN2_QTY.equals("") || TOPBIN2_QTY.equals("0")) &&
				 * (TOPBIN3_QTY.equals("") || TOPBIN3_QTY.equals("0")) &&
				 * (TOPBIN1_FAIL_YIELD.equals("") ||
				 * TOPBIN1_FAIL_YIELD.equals("0")) &&
				 * (TOPBIN2_FAIL_YIELD.equals("") ||
				 * TOPBIN2_FAIL_YIELD.equals("0")) &&
				 * (TOPBIN3_FAIL_YIELD.equals("") ||
				 * TOPBIN3_FAIL_YIELD.equals("0")) && TOTAL_YIELD.equals("") ||
				 * TOTAL_YIELD.equals("0")){
				 */
				bs.writeLog("LOT_ID:" + LOT_ID + ":LOT_ID");
				bs.writeLog("TOTAL_YIELD:" + TOTAL_YIELD + ":TOTAL_YIELD");

				bs.writeLog("CP_�����쳣");
				// ���������쳣����
				Property[] propertyArray = new Property[17];
				propertyArray[0] = new Property();
				propertyArray[0].setName("fxNO");
				propertyArray[0].setValue(FXNO);

				propertyArray[1] = new Property();
				propertyArray[1].setName("khm");
				propertyArray[1].setValue(CUST_ID);

				propertyArray[2] = new Property();
				propertyArray[2].setName("xh");
				propertyArray[2].setValue(MAT_DESC);

				propertyArray[3] = new Property();
				propertyArray[3].setName("ASSYLOT");
				propertyArray[3].setValue(ASSYLOT);

				propertyArray[4] = new Property();
				propertyArray[4].setName("WPLOT");
				propertyArray[4].setValue(CUST_RUN_ID);

				propertyArray[5] = new Property();
				propertyArray[5].setName("rq");
				propertyArray[5].setValue(CREATE_DATE);

				propertyArray[6] = new Property();
				propertyArray[6].setName("Tester");
				propertyArray[6].setValue(RES_ID);

				propertyArray[7] = new Property();
				propertyArray[7].setName("EDPNo");
				propertyArray[7].setValue(LOT_ID);

				propertyArray[8] = new Property();
				propertyArray[8].setName("cxm");
				propertyArray[8].setValue(PROGRAM_ID);

				propertyArray[9] = new Property();
				propertyArray[9].setName("PKLD");
				propertyArray[9].setValue(PKLD);

				propertyArray[10] = new Property();
				propertyArray[10].setName("gxh");
				propertyArray[10].setValue(OPER);

				propertyArray[11] = new Property();
				propertyArray[11].setName("zys");
				propertyArray[11].setValue(INPUT_QTY);

				propertyArray[12] = new Property();
				propertyArray[12].setName("lps");
				propertyArray[12].setValue(PASS_QTY);

				propertyArray[13] = new Property();
				propertyArray[13].setName("hgl");
				propertyArray[13].setValue(TOTAL_YIELD);

				propertyArray[14] = new Property();
				propertyArray[14].setName("tiggerid");
				propertyArray[14].setValue(ID);

				RES_ID = RES_ID.split("-")[0];
				// khm xh tester pkid
				sql = "select b.id id,lastname,zrr from tb_cpllyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
				if (!CUST_ID.equals("")) {
					sql += " and khm = '" + CUST_ID + "'";
				}
				if (!MAT_DESC.equals("")) {
					sql += " and xh = '" + MAT_DESC + "'";
				}
				if (!RES_ID.equals("")) {
					sql += " and tester like'" + RES_ID + "%'";
				}
				if (!PKLD.equals("")) {
					sql += " and pkid = '" + PKLD + "'";
				}
				bs.writeLog("tb_cpllyc:" + sql);
				rs1.executeSql(sql);
				String tehrm = "", zrr = "";
				while (rs1.next()) {
					tehrm += rs1.getString("id") + ",";
					if (!rs1.getString("zrr").equals("")) {
						if (!zrr.contains(rs1.getString("zrr")))
							zrr += rs1.getString("zrr") + ",";
					}
				}
				// khm xh tester
				if (tehrm.equals("")) {
					sql = "select b.id id,lastname,zrr from tb_cpllyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if (!CUST_ID.equals("")) {
						sql += " and khm = '" + CUST_ID + "'";
					}
					if (!MAT_DESC.equals("")) {
						sql += " and xh = '" + MAT_DESC + "'";
					}
					if (!RES_ID.equals("")) {
						sql += " and tester like'" + RES_ID + "%'";
					}
					bs.writeLog("tb_cpllyc:" + sql);
					rs1.executeSql(sql);
					while (rs1.next()) {
						if (!tehrm.contains(rs1.getString("id"))) {
							tehrm += rs1.getString("id") + ",";
						}
						if (!rs1.getString("zrr").equals("")) {
							if (!zrr.contains(rs1.getString("zrr")))
								zrr += rs1.getString("zrr") + ",";
						}
					}
				}
				// khm pkid
				if (tehrm.equals("")) {
					sql = "select b.id id,lastname,zrr from tb_cpllyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if (!CUST_ID.equals("")) {
						sql += " and khm = '" + CUST_ID + "'";
					}
					if (!PKLD.equals("")) {
						sql += " and pkid = '" + PKLD + "'";
					}
					bs.writeLog("tb_cpllyc:" + sql);
					rs1.executeSql(sql);
					while (rs1.next()) {
						if (!tehrm.contains(rs1.getString("id"))) {
							tehrm += rs1.getString("id") + ",";
						}
						if (!rs1.getString("zrr").equals("")) {
							if (!zrr.contains(rs1.getString("zrr")))
								zrr += rs1.getString("zrr") + ",";
						}
					}
				}
				// khm tester
				if (tehrm.equals("")) {
					sql = "select b.id id,lastname,zrr from tb_cpllyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if (!CUST_ID.equals("")) {
						sql += " and khm = '" + CUST_ID + "'";
					}
					if (!RES_ID.equals("")) {
						sql += " and tester like'" + RES_ID + "%'";
					}
					bs.writeLog("tb_cpllyc:" + sql);
					rs1.executeSql(sql);
					while (rs1.next()) {
						if (!tehrm.contains(rs1.getString("id"))) {
							tehrm += rs1.getString("id") + ",";
						}
						if (!rs1.getString("zrr").equals("")) {
							if (!zrr.contains(rs1.getString("zrr")))
								zrr += rs1.getString("zrr") + ",";
						}
					}
				}
				// kmm xh
				if (tehrm.equals("")) {
					sql = "select b.id id,lastname,zrr from tb_cpllyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if (!CUST_ID.equals("")) {
						sql += " and khm = '" + CUST_ID + "'";
					}
					if (!MAT_DESC.equals("")) {
						sql += " and xh = '" + MAT_DESC + "'";
					}
					bs.writeLog("tb_cpllyc:" + sql);
					rs1.executeSql(sql);
					while (rs1.next()) {
						if (!tehrm.contains(rs1.getString("id"))) {
							tehrm += rs1.getString("id") + ",";
						}
						if (!rs1.getString("zrr").equals("")) {
							if (!zrr.contains(rs1.getString("zrr")))
								zrr += rs1.getString("zrr") + ",";
						}
					}
				}
				// khm
				if (tehrm.equals("")) {
					sql = "select b.id id,lastname,zrr from tb_cpllyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if (!CUST_ID.equals("")) {
						sql += " and khm = '" + CUST_ID + "'";
						sql += " and xh = 'ALL'";
						sql += " and tester ='ALL'";
						sql += " and pkid = 'ALL'";
					}
					bs.writeLog("tb_cpllyc:" + sql);
					rs1.executeSql(sql);
					while (rs1.next()) {
						if (!tehrm.contains(rs1.getString("id"))) {
							tehrm += rs1.getString("id") + ",";
						}
						if (!rs1.getString("zrr").equals("")) {
							if (!zrr.contains(rs1.getString("zrr")))
								zrr += rs1.getString("zrr") + ",";
						}
					}
				}

				if (!tehrm.equals("")) {
					tehrm = tehrm.substring(0, tehrm.length() - 1);
				}
				if (!zrr.equals("")) {
					zrr = zrr.substring(0, tehrm.length() - 1);
				}

				bs.writeLog("tehrm:" + tehrm);
				bs.writeLog("zrr:" + zrr);
				if (tehrm.equals("")) {
					tehrm = "553";
				}
				bs.writeLog("tehrm:" + tehrm);
				bs.writeLog("zrr:" + zrr);

				propertyArray[15] = new Property();
				propertyArray[15].setName("tehrm");
				propertyArray[15].setValue(tehrm);

				propertyArray[16] = new Property();
				propertyArray[16].setName("zrr");
				propertyArray[16].setValue(zrr);

				mainTableInfo.setProperty(propertyArray);

				requestInfo.setCreatorid(USER_ID);
				requestInfo.setWorkflowid("361");
				requestInfo.setDescription("CP_�����쳣��������-" + date + "(MES�Զ�����)");

				requestInfo.setMainTableInfo(mainTableInfo);
				RequestService service = new RequestService();// �����������ʵ��
				String newRequestid = service.createRequest(requestInfo);
				bs.writeLog("CPYC_MIDDLE:" + newRequestid);

				sql = "select id from formtable_main_6 where requestid = " + newRequestid;
				bs.writeLog("sql:" + sql);
				rs1.executeSql(sql);
				rs1.next();
				String mainid = rs1.getString("id");

				sql = "select * from cpyc_sublot_middle where id = " + ID;
				rs1.executeSql(sql);
				bs.writeLog("sql:" + sql);
				while (rs1.next()) {
					sql = "insert into formtable_main_6_dt2 (mainid,ph,bin1bl,bin1bll,bin2bl,bin2bll,bin3bl,bin3bll) values(";
					sql += mainid + ",";
					sql += "'" + rs1.getString("SUBLOT_ID") + "',";
					sql += "'" + rs1.getString("TOPBIN1_PROMPT") + "',";
					sql += "'" + rs1.getString("TOPBIN1_FAIL_YIELD") + "',";
					sql += "'" + rs1.getString("TOPBIN2_PROMPT") + "',";
					sql += "'" + rs1.getString("TOPBIN2_FAIL_YIELD") + "',";
					sql += "'" + rs1.getString("TOPBIN3_PROMPT") + "',";
					sql += "'" + rs1.getString("TOPBIN3_FAIL_YIELD") + "')";
					bs.writeLog("sql:" + sql);
					rs1.executeSql(sql);
				}

				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");
				String udpatetime = sdf1.format(d);
				sql = "update CPYC_MIDDLE set FLAG = '100',UPDATE_TIME = '" + udpatetime + "' where id = " + ID;
				bs.writeLog("CPYC_MIDDLE update sql:" + sql);
				rs1.executeSql(sql);
			}

		} catch (Exception e) {
			bs.writeLog("FSTMES361:" + e);
		}
	}
}

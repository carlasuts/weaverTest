package weaver.interfaces.schedule;

import java.util.*;
import java.text.*;
import java.math.*;

import weaver.conn.*;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.*;
import weaver.general.BaseBean;

public class FSTMES83SCH11 extends BaseCronJob  {
	public void execute() {
		BaseBean bs = new BaseBean();
		try {
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
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
			String FT_FAIL_QTY = "";
			String VD_FAIL_QTY = "";
			String TOTAL_YIELD = "";
			String TOPBIN1_PROMPT = "";
			String TOPBIN2_PROMPT = "";
			String TOPBIN3_PROMPT = "";
			String TOPBIN1_QTY = "";
			String TOPBIN2_QTY = "";
			String TOPBIN3_QTY = "";
			String TOPBIN1_FAIL_YIELD = "";
			String TOPBIN2_FAIL_YIELD = "";
			String TOPBIN3_FAIL_YIELD = "";
			String USER_ID = "";
			String FLAG = "";
			String sql = "";
			RecordSet rs = new RecordSet();
			RecordSet rs1 = new RecordSet();
			//待触发的流程
			sql = "select ID,FXNO,CUST_ID,MAT_DESC,ASSYLOT,CUST_RUN_ID,CREATE_DATE,RES_ID,LOT_ID,PROGRAM_ID,PKLD,OPER,INPUT_QTY,PASS_QTY,FT_FAIL_QTY,VD_FAIL_QTY,TOTAL_YIELD,TOPBIN1_PROMPT,TOPBIN2_PROMPT,TOPBIN3_PROMPT,TOPBIN1_QTY,TOPBIN2_QTY,TOPBIN3_QTY,TOPBIN1_FAIL_YIELD,TOPBIN2_FAIL_YIELD,TOPBIN3_FAIL_YIELD,USER_ID,FLAG from LLYC_MIDDLE where flag = '0'";
			rs.executeSql(sql);
			while(rs.next()){
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
				FT_FAIL_QTY = rs.getString("FT_FAIL_QTY");
				VD_FAIL_QTY = rs.getString("VD_FAIL_QTY");
				TOTAL_YIELD = rs.getString("TOTAL_YIELD");
				TOPBIN1_PROMPT = rs.getString("TOPBIN1_PROMPT");
				TOPBIN2_PROMPT = rs.getString("TOPBIN2_PROMPT");
				TOPBIN3_PROMPT = rs.getString("TOPBIN3_PROMPT");
				TOPBIN1_QTY = rs.getString("TOPBIN1_QTY");
				TOPBIN2_QTY = rs.getString("TOPBIN2_QTY");
				TOPBIN3_QTY = rs.getString("TOPBIN3_QTY");
				TOPBIN1_FAIL_YIELD = rs.getString("TOPBIN1_FAIL_YIELD");
				TOPBIN2_FAIL_YIELD = rs.getString("TOPBIN2_FAIL_YIELD");
				TOPBIN3_FAIL_YIELD = rs.getString("TOPBIN3_FAIL_YIELD");
				USER_ID = rs.getString("USER_ID");
				FLAG = rs.getString("FLAG");
				
				sql = "select id from hrmresource where workcode = '" + USER_ID + "'";
				rs1.executeSql(sql);
				if(rs1.next())
					USER_ID = rs1.getString("id");
				else
					USER_ID = "1";
				
				RequestInfo requestInfo = new RequestInfo();
				MainTableInfo mainTableInfo = new MainTableInfo();
				
				/*if((TOPBIN1_PROMPT.equals("") || TOPBIN1_PROMPT.equals("0")) && (TOPBIN2_PROMPT.equals("") || TOPBIN2_PROMPT.equals("0")) && (TOPBIN3_PROMPT.equals("") || TOPBIN3_PROMPT.equals("0")) &&
					(TOPBIN1_QTY.equals("") || TOPBIN1_QTY.equals("0")) && (TOPBIN2_QTY.equals("") || TOPBIN2_QTY.equals("0")) && (TOPBIN3_QTY.equals("") || TOPBIN3_QTY.equals("0")) &&
					(TOPBIN1_FAIL_YIELD.equals("") || TOPBIN1_FAIL_YIELD.equals("0")) && (TOPBIN2_FAIL_YIELD.equals("") || TOPBIN2_FAIL_YIELD.equals("0")) && (TOPBIN3_FAIL_YIELD.equals("") || TOPBIN3_FAIL_YIELD.equals("0")) &&
					TOTAL_YIELD.equals("") || TOTAL_YIELD.equals("0")){*/
				bs.writeLog("LOT_ID:" + LOT_ID + ":LOT_ID");
				bs.writeLog("TOTAL_YIELD:" + TOTAL_YIELD + ":TOTAL_YIELD");
				if(TOTAL_YIELD.equals(" ") || TOTAL_YIELD.equals("")){
					bs.writeLog("工序内异常");
					//触发工序内异常流程	
					Property[] propertyArray = new Property[13];
					//型号
					propertyArray[0] = new Property();
					propertyArray[0].setName("xh");
					propertyArray[0].setValue(MAT_DESC);
					//条形码号
					propertyArray[1] = new Property();
					propertyArray[1].setName("txmh");
					propertyArray[1].setValue(LOT_ID);
					//组装批号
					propertyArray[2] = new Property();
					propertyArray[2].setName("zzph");
					propertyArray[2].setValue(ASSYLOT);
					//扩散批号
					propertyArray[3] = new Property();
					propertyArray[3].setName("ksph");
					propertyArray[3].setValue(CUST_RUN_ID);
					//设备号
					propertyArray[4] = new Property();
					propertyArray[4].setName("sbh");
					propertyArray[4].setValue(RES_ID);
					//母体数
					propertyArray[5] = new Property();
					propertyArray[5].setName("mts");
					propertyArray[5].setValue(INPUT_QTY);
					//发生工序 
					propertyArray[6] = new Property();
					propertyArray[6].setName("fsgx");
					propertyArray[6].setValue(OPER);
					//发行者
					propertyArray[7] = new Property();
					propertyArray[7].setName("fxz");
					propertyArray[7].setValue(USER_ID);
					//触发id
					propertyArray[8] = new Property();
					propertyArray[8].setName("tiggerid");
					propertyArray[8].setValue(ID);
					//客户名
					propertyArray[9] = new Property();
					propertyArray[9].setName("khm");
					propertyArray[9].setValue(CUST_ID);
					//PKLD
					propertyArray[10] = new Property();
					propertyArray[10].setName("pkld");
					propertyArray[10].setValue(PKLD);
					
					//khm xh pkid
					sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
					}
					if(!MAT_DESC.equals("")){
						sql += " and xh = '" + MAT_DESC + "'";
					}
					if(!PKLD.equals("")){
						sql += " and pkid = '" + PKLD + "'";
					}
					bs.writeLog("TB_GXNYC:" + sql);
					rs1.executeSql(sql);
					String dchrm = "", zrr = "";
					while(rs1.next()){
						dchrm += rs1.getString("id") + ",";
						if(!rs1.getString("zrr").equals("")){
							if(!zrr.contains(rs1.getString("zrr")))
								zrr += rs1.getString("zrr") + ",";		
						}
					}
					//khm pkid
					if(dchrm.equals("")){
						sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
						if(!CUST_ID.equals("")){
							sql += " and khm = '" + CUST_ID + "'";
						}
						if(!PKLD.equals("")){
							sql += " and pkid = '" + PKLD + "'";
						}
						bs.writeLog("TB_GXNYC:" + sql);
						rs1.executeSql(sql);
						while(rs1.next()){
							if(!dchrm.contains(rs1.getString("id"))){
								dchrm += rs1.getString("id") + ",";	
							}
							if(!rs1.getString("zrr").equals("")){
								if(!zrr.contains(rs1.getString("zrr")))
									zrr += rs1.getString("zrr") + ",";		
							}
						}
					}
					//kmm xh
					if(dchrm.equals("")){
						sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
						if(!CUST_ID.equals("")){
							sql += " and khm = '" + CUST_ID + "'";
						}
						if(!MAT_DESC.equals("")){
							sql += " and xh = '" + MAT_DESC + "'";
						}
						bs.writeLog("TB_GXNYC:" + sql);
						rs1.executeSql(sql);
						while(rs1.next()){
							if(!dchrm.contains(rs1.getString("id"))){
								dchrm += rs1.getString("id") + ",";	
							}
							if(!rs1.getString("zrr").equals("")){
								if(!zrr.contains(rs1.getString("zrr")))
									zrr += rs1.getString("zrr") + ",";		
							}
						}
					}
					//xh pkid
					if(dchrm.equals("")){
						sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
						if(!MAT_DESC.equals("")){
							sql += " and xh = '" + MAT_DESC + "'";
						}
						if(!PKLD.equals("")){
							sql += " and pkid = '" + PKLD + "'";
						}
						bs.writeLog("TB_GXNYC:" + sql);
						rs1.executeSql(sql);
						while(rs1.next()){
							if(!dchrm.contains(rs1.getString("id"))){
								dchrm += rs1.getString("id") + ",";	
							}
							if(!rs1.getString("zrr").equals("")){
								if(!zrr.contains(rs1.getString("zrr")))
									zrr += rs1.getString("zrr") + ",";		
							}
						}
					}
					//khm
					if(dchrm.equals("")){
						sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
						if(!CUST_ID.equals("")){
							sql += " and khm = '" + CUST_ID + "'";
						}
						bs.writeLog("TB_GXNYC:" + sql);
						rs1.executeSql(sql);
						while(rs1.next()){
							if(!dchrm.contains(rs1.getString("id"))){
								dchrm += rs1.getString("id") + ",";	
							}
							if(!rs1.getString("zrr").equals("")){
								if(!zrr.contains(rs1.getString("zrr")))
									zrr += rs1.getString("zrr") + ",";	
							}
						}
					}
					//xh
					if(dchrm.equals("")){
						sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
						if(!MAT_DESC.equals("")){
							sql += " and xh = '" + MAT_DESC + "'";
						}
						bs.writeLog("TB_GXNYC:" + sql);
						rs1.executeSql(sql);
						while(rs1.next()){
							if(!dchrm.contains(rs1.getString("id"))){
								dchrm += rs1.getString("id") + ",";	
							}
							if(!rs1.getString("zrr").equals("")){
								if(!zrr.contains(rs1.getString("zrr")))
									zrr += rs1.getString("zrr") + ",";		
							}
						}
					}
					//pkid
					if(dchrm.equals("")){
						sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
						if(!PKLD.equals("")){
							sql += " and pkid = '" + PKLD + "'";
						}
						bs.writeLog("TB_GXNYC:" + sql);
						rs1.executeSql(sql);
						while(rs1.next()){
							if(!dchrm.contains(rs1.getString("id"))){
								dchrm += rs1.getString("id") + ",";	
							}
							if(!rs1.getString("zrr").equals("")){
								if(!zrr.contains(rs1.getString("zrr")))
									zrr += rs1.getString("zrr") + ",";		
							}
						}
					}
					
					if(!dchrm.equals(""))
						dchrm = dchrm.substring(0, dchrm.length() - 1);
					if(!zrr.equals(""))
						zrr = zrr.substring(0, zrr.length() - 1);
					
					bs.writeLog("dchrm:" + dchrm);
					bs.writeLog("zrr:" + zrr);
					if(dchrm.equals(""))
						dchrm = "553";
					bs.writeLog("dchrm:" + dchrm);
					bs.writeLog("zrr:" + zrr);
					
					//责任人
					propertyArray[11] = new Property();
					propertyArray[11].setName("zrr");
					propertyArray[11].setValue(zrr);
					//调查人
					propertyArray[12] = new Property();
					propertyArray[12].setName("dchrm");
					propertyArray[12].setValue(dchrm);
					
					mainTableInfo.setProperty(propertyArray);
					
					requestInfo.setCreatorid(USER_ID);
					requestInfo.setWorkflowid("66");
					requestInfo.setDescription("工序内异常处理流程-" + date + "(MES自动触发)");
					
					requestInfo.setMainTableInfo(mainTableInfo);
					RequestService service = new RequestService();//创建请求服务实例
					
					String newRequestid = service.createRequest(requestInfo); 
					bs.writeLog("LLYC_MIDDLE_GXN:" + newRequestid);
					
					SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss"); 
					String udpatetime = sdf1.format(d);
					sql = "update LLYC_MIDDLE set FLAG = '100',UPDATE_TIME = '" + udpatetime + "' where id = " + ID;
					bs.writeLog("LLYC_MIDDLE_GXN update sql:" + sql);
					rs1.executeSql(sql);	
				}
				else{
					bs.writeLog("良率异常");
					//触发良率异常流程
					Property[] propertyArray = new Property[28];
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
					propertyArray[13].setName("FIbl");
					propertyArray[13].setValue(FT_FAIL_QTY);
					
					propertyArray[14] = new Property();
					propertyArray[14].setName("wgbl");
					propertyArray[14].setValue(VD_FAIL_QTY);
					
					propertyArray[15] = new Property();
					propertyArray[15].setName("hgl");
					propertyArray[15].setValue(TOTAL_YIELD);
					
					propertyArray[16] = new Property();
					propertyArray[16].setName("gg1");
					propertyArray[16].setValue(TOPBIN1_PROMPT);
					
					propertyArray[17] = new Property();
					propertyArray[17].setName("gg2");
					propertyArray[17].setValue(TOPBIN2_PROMPT);
					
					propertyArray[18] = new Property();
					propertyArray[18].setName("gg3");
					propertyArray[18].setValue(TOPBIN3_PROMPT);
					
					propertyArray[19] = new Property();
					propertyArray[19].setName("bn91bls");
					propertyArray[19].setValue(TOPBIN1_QTY);
					
					propertyArray[20] = new Property();
					propertyArray[20].setName("bn96bls");
					propertyArray[20].setValue(TOPBIN2_QTY);
					
					propertyArray[21] = new Property();
					propertyArray[21].setName("bn97bls");
					propertyArray[21].setValue(TOPBIN3_QTY);
					
					propertyArray[22] = new Property();
					propertyArray[22].setName("bn91bll");
					propertyArray[22].setValue(TOPBIN1_FAIL_YIELD);
					
					propertyArray[23] = new Property();
					propertyArray[23].setName("bn96bll");
					propertyArray[23].setValue(TOPBIN2_FAIL_YIELD);
					
					propertyArray[24] = new Property();
					propertyArray[24].setName("bn97bll");
					propertyArray[24].setValue(TOPBIN3_FAIL_YIELD);
					
					propertyArray[25] = new Property();
					propertyArray[25].setName("tiggerid");
					propertyArray[25].setValue(ID);
					
					RES_ID = RES_ID.split("-")[0];
					//khm xh tester pkid
					sql = "select b.id id,lastname,zrr from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
					}
					if(!MAT_DESC.equals("")){
						sql += " and xh = '" + MAT_DESC + "'";
					}
					if(!RES_ID.equals("")){
						sql += " and tester like'" + RES_ID + "%'";
					}
					if(!PKLD.equals("")){
						sql += " and pkid = '" + PKLD + "'";
					}
					bs.writeLog("TB_LLYC:" + sql);
					rs1.executeSql(sql);
					String tehrm = "", zrr = "";
					while(rs1.next()){
						tehrm += rs1.getString("id") + ",";
						if(!rs1.getString("zrr").equals("")){
							if(!zrr.contains(rs1.getString("zrr")))
								zrr += rs1.getString("zrr") + ",";		
						}
					}
					//khm xh tester
					if(tehrm.equals("")){
						sql = "select b.id id,lastname,zrr from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
						if(!CUST_ID.equals("")){
							sql += " and khm = '" + CUST_ID + "'";
						}
						if(!MAT_DESC.equals("")){
							sql += " and xh = '" + MAT_DESC + "'";
						}
						if(!RES_ID.equals("")){
							sql += " and tester like'" + RES_ID + "%'";
						}
						bs.writeLog("TB_LLYC:" + sql);
						rs1.executeSql(sql);
						while(rs1.next()){
							if(!tehrm.contains(rs1.getString("id"))){
								tehrm += rs1.getString("id") + ",";	
							}
							if(!rs1.getString("zrr").equals("")){
								if(!zrr.contains(rs1.getString("zrr")))
									zrr += rs1.getString("zrr") + ",";		
							}
						}
					}
					//khm pkid
					if(tehrm.equals("")){
						sql = "select b.id id,lastname,zrr from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
						if(!CUST_ID.equals("")){
							sql += " and khm = '" + CUST_ID + "'";
						}
						if(!PKLD.equals("")){
							sql += " and pkid = '" + PKLD + "'";
						}
						bs.writeLog("TB_LLYC:" + sql);
						rs1.executeSql(sql);
						while(rs1.next()){
							if(!tehrm.contains(rs1.getString("id"))){
								tehrm += rs1.getString("id") + ",";	
							}
							if(!rs1.getString("zrr").equals("")){
								if(!zrr.contains(rs1.getString("zrr")))
									zrr += rs1.getString("zrr") + ",";		
							}
						}
					}
					//khm tester
					if(tehrm.equals("")){
						sql = "select b.id id,lastname,zrr from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
						if(!CUST_ID.equals("")){
							sql += " and khm = '" + CUST_ID + "'";
						}
						if(!RES_ID.equals("")){
							sql += " and tester like'" + RES_ID + "%'";
						}
						bs.writeLog("TB_LLYC:" + sql);
						rs1.executeSql(sql);
						while(rs1.next()){
							if(!tehrm.contains(rs1.getString("id"))){
								tehrm += rs1.getString("id") + ",";	
							}
							if(!rs1.getString("zrr").equals("")){
								if(!zrr.contains(rs1.getString("zrr")))
									zrr += rs1.getString("zrr") + ",";		
							}
						}
					}
					//kmm xh
					if(tehrm.equals("")){
						sql = "select b.id id,lastname,zrr from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
						if(!CUST_ID.equals("")){
							sql += " and khm = '" + CUST_ID + "'";
						}
						if(!MAT_DESC.equals("")){
							sql += " and xh = '" + MAT_DESC + "'";
						}
						bs.writeLog("TB_LLYC:" + sql);
						rs1.executeSql(sql);
						while(rs1.next()){
							if(!tehrm.contains(rs1.getString("id"))){
								tehrm += rs1.getString("id") + ",";	
							}
							if(!rs1.getString("zrr").equals("")){
								if(!zrr.contains(rs1.getString("zrr")))
									zrr += rs1.getString("zrr") + ",";		
							}
						}
					}
					//khm
					if(tehrm.equals("")){
						sql = "select b.id id,lastname,zrr from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
						if(!CUST_ID.equals("")){
							sql += " and khm = '" + CUST_ID + "'";
							sql += " and xh = 'ALL'";
							sql += " and tester ='ALL'";
							sql += " and pkid = 'ALL'";
						}
						bs.writeLog("TB_LLYC:" + sql);
						rs1.executeSql(sql);
						
						while(rs1.next()){
							if(!tehrm.contains(rs1.getString("id"))){
								tehrm += rs1.getString("id") + ",";	
							}
							if(!rs1.getString("zrr").equals("")){
								if(!zrr.contains(rs1.getString("zrr")))
									zrr += rs1.getString("zrr") + ",";	
							}
						}
					}

					if(!tehrm.equals(""))
						tehrm = tehrm.substring(0, tehrm.length() - 1);
					if(!zrr.equals(""))
						zrr = zrr.substring(0, zrr.length() - 1);
					
					bs.writeLog("tehrm:" + tehrm);
					bs.writeLog("zrr:" + zrr);
					if(tehrm.equals(""))
						tehrm = "553";
					bs.writeLog("tehrm:" + tehrm);
					bs.writeLog("zrr:" + zrr);
					
					propertyArray[26] = new Property();
					propertyArray[26].setName("tehrm");
					propertyArray[26].setValue(tehrm);
					
					propertyArray[27] = new Property();
					propertyArray[27].setName("zrr");
					propertyArray[27].setValue(zrr);
					
					mainTableInfo.setProperty(propertyArray);
					
					requestInfo.setCreatorid(USER_ID);
					requestInfo.setWorkflowid("83");
					requestInfo.setDescription("良率异常处理流程-" + date + "(MES自动触发)");
					
					requestInfo.setMainTableInfo(mainTableInfo);
					RequestService service = new RequestService();//创建请求服务实例
					
					String newRequestid = service.createRequest(requestInfo); 
					bs.writeLog("LLYC_MIDDLE:" + newRequestid);
					
					SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss"); 
					String udpatetime = sdf1.format(d);
					sql = "update LLYC_MIDDLE set FLAG = '100',UPDATE_TIME = '" + udpatetime + "' where id = " + ID;
					bs.writeLog("LLYC_MIDDLE update sql:" + sql);
					rs1.executeSql(sql);
				}
			}
		}
		catch (Exception e) {
			bs.writeLog("FSTMES83:" + e);
		}	 
    }
}

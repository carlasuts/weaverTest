package weaver.interfaces.schedule;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.json.JSONArray;
import org.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.RequestService;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


public class CCMEMES83SCH extends BaseCronJob  {
	private String logtablename = "LLYC_MIDDLE";
	private static final String url = "http://172.16.60.96:8090/MesWebService/req";
	public  static final String token ="AWK18VSE25SDNKLS3AET@EWL#LDG*!F";
	public void execute() {
		
		BaseBean bs = new BaseBean();
		
		try {
			JSONObject param = new JSONObject();
			param.put("fromSystem","OA");
			param.put("functionName","MES_GETOATESTYIELD");
			param.put("token",token);
			

			String retSrc = readInterfacePost(url,param.toString());
			JSONObject result = new JSONObject(retSrc);
			
			String oaTestYieldList = result.get("oaTestYieldList").toString();
			
			JSONArray content = new JSONArray(oaTestYieldList);
			bs.writeLog("oaTestYieldList"+oaTestYieldList);
			
			for(int i = 0; i < content.length(); i++){
				JSONObject p = (JSONObject)content.get(i);  
				String ID = (String)p.get("id").toString();
				String FXNO = (String)p.get("fxNo");
				String CUST_ID = (String)p.get("custId");
				String MAT_DESC = (String)p.get("matDesc");
				String ASSYLOT = (String)p.get("assyLot");
				String CUST_RUN_ID = (String)p.get("custRunId");
				String CREATE_DATE = (String)p.get("createDate");
				String RES_ID = (String)p.get("resId");
				String LOT_ID = (String)p.get("lotId");
				String PROGRAM_ID = (String)p.get("programId");
				String PKLD = (String)p.get("pkld");
				String OPER = (String)p.get("oper");
				String INPUT_QTY = (String)p.get("inputQty").toString();
				String PASS_QTY = (String)p.get("passQty").toString();
				String FT_FAIL_QTY = (String)p.get("ftFailQty").toString();
				String VD_FAIL_QTY = (String)p.get("vdFailQty").toString();
				String TOTAL_YIELD = (String)p.get("totalYield");
				String TOPBIN1_PROMPT = (String)p.get("topBin1Prompt");
				String TOPBIN2_PROMPT = (String)p.get("topBin2Prompt");
				String TOPBIN3_PROMPT = (String)p.get("topBin3Prompt");
				String TOPBIN1_QTY = (String)p.get("topBin1Qty").toString();
				String TOPBIN2_QTY = (String)p.get("topBin2Qty").toString();
				String TOPBIN3_QTY = (String)p.get("topBin3Qty").toString();
				String TOPBIN1_FAIL_YIELD = (String)p.get("topBin1FailYield");
				String TOPBIN2_FAIL_YIELD = (String)p.get("topBin2FailYield");
				String TOPBIN3_FAIL_YIELD = (String)p.get("topBin3FailYield");
				String USER_ID = (String)p.get("userId");
				String FLAG = (String)p.get("flag");
				String RESVFIELD1 = (String)p.get("resvField1");
				String RESVFIELD2 = (String)p.get("resvField2");
				String RESVFIELD3 = (String)p.get("resvField3");
				String RESVFIELD4 = (String)p.get("resvField4");
				String RESVFIELD5 = (String)p.get("resvField5");
				String RESVFIELD6 = (String)p.get("resvField6");
				String RESVFIELD7 = (String)p.get("resvField7");
				String RESVFIELD8 = (String)p.get("resvField8");
				String RESVFIELD9 = (String)p.get("resvField9");
				String RESVFIELD10 = (String)p.get("resvField10");
				String UPDATETIME = (String)p.get("updateTime");
				RecordSet rs = new RecordSet();
				RecordSet rs1 = new RecordSet();
				String sql1 ="select id,flag from LLYC_MIDDLE where id="+ID;
				rs1.executeSql(sql1);
				if(rs1.next()){
					
				}else{
					String sql="";
//					List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
					Map<String, String> tfme = new HashMap<String, String>();
					tfme.put("ID",ID);
					tfme.put("FXNO",FXNO);
					tfme.put("CUST_ID",CUST_ID);
					tfme.put("MAT_DESC",MAT_DESC);
					tfme.put("ASSYLOT",ASSYLOT);
					tfme.put("CUST_RUN_ID",CUST_RUN_ID);
					tfme.put("CREATE_DATE",CREATE_DATE);
					tfme.put("RES_ID",RES_ID);
					tfme.put("LOT_ID",LOT_ID);
					tfme.put("PROGRAM_ID",PROGRAM_ID);
					tfme.put("PKLD",PKLD);
					tfme.put("OPER",OPER);
					tfme.put("INPUT_QTY",INPUT_QTY);
					tfme.put("PASS_QTY",PASS_QTY);
					tfme.put("FT_FAIL_QTY",FT_FAIL_QTY);
					tfme.put("VD_FAIL_QTY",VD_FAIL_QTY);
					tfme.put("TOTAL_YIELD",TOTAL_YIELD);
					tfme.put("TOPBIN1_PROMPT",TOPBIN1_PROMPT);
					tfme.put("TOPBIN2_PROMPT",TOPBIN2_PROMPT);
					tfme.put("TOPBIN3_PROMPT",TOPBIN3_PROMPT);
					tfme.put("TOPBIN1_QTY",TOPBIN1_QTY);
					tfme.put("TOPBIN2_QTY",TOPBIN2_QTY);
					tfme.put("TOPBIN3_QTY",TOPBIN3_QTY);
					tfme.put("TOPBIN1_FAIL_YIELD",TOPBIN1_FAIL_YIELD);
					tfme.put("TOPBIN2_FAIL_YIELD",TOPBIN2_FAIL_YIELD);
					tfme.put("TOPBIN3_FAIL_YIELD",TOPBIN3_FAIL_YIELD);
					tfme.put("USER_ID",USER_ID);
					tfme.put("FLAG",FLAG);
					tfme.put("RESV_FIELD1",RESVFIELD1);
					tfme.put("RESV_FIELD2",RESVFIELD2);
					tfme.put("RESV_FIELD3",RESVFIELD3);
					tfme.put("RESV_FIELD4",RESVFIELD4);
					tfme.put("RESV_FIELD5",RESVFIELD5);
					tfme.put("RESV_FIELD6",RESVFIELD6);
					tfme.put("RESV_FIELD7",RESVFIELD7);
					tfme.put("RESV_FIELD8",RESVFIELD8);
					tfme.put("RESV_FIELD9",RESVFIELD9);
					tfme.put("RESV_FIELD10",RESVFIELD10);
					tfme.put("UPDATE_TIME",UPDATETIME);
//					insert(tfme);// 插入数据库
//					loglist.add(tfme);
//					writelog(loglist);
					
					Boolean b = OAMESMIDDLE.insert(tfme, logtablename);
					if(b.equals("false")){
						break;
					}
					bs.writeLog("b++++++++++"+b);
					

				Date dd = new Date();
				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddHHmmss"); 
				String udpatetime1 = sdf2.format(dd);
				JSONObject req = new JSONObject();
				req.put("fromSystem", "OA");
				req.put("functionName", "MES_UPDATEOATESTYIELDINFO");
				req.put("token", token);

				JSONObject message = new JSONObject();
				message.put("id", ID);

				JSONObject[] updateInfos = new JSONObject[2];
				updateInfos[0] = new JSONObject();
				updateInfos[0].put("updateField", "FLAG");
				updateInfos[0].put("updateValue", "100");
				updateInfos[1] = new JSONObject();
				updateInfos[1].put("updateField", "UPDATE_TIME");
				updateInfos[1].put("updateValue", udpatetime1);
				message.put("updateInfoList", updateInfos);

				req.put("message", message);

				
				String retSrcs = readInterfacePost(url,req.toString());
				bs.writeLog("retSrcs"  + retSrcs );
				JSONObject results = new JSONObject(retSrcs);
				bs.writeLog("results"  + results );
				String statusValue = results.get("statusValue").toString();
				//JSONArray content =  rjson.getJSONArray("oaTestYieldList");//根据文档填写
				bs.writeLog("-----------------------------" );
				 if(statusValue.equals("0")){
					 bs.writeLog("==============================" );
					Date d = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String date = sdf.format(d);
					sql = "select id from hrmresource where workcode = '" + USER_ID + "'";
					rs1.executeSql(sql);
					if(rs1.next())
						USER_ID = rs1.getString("id");
					else
						USER_ID = "1";
					RequestInfo requestInfo = new RequestInfo();
					MainTableInfo mainTableInfo = new MainTableInfo();
					bs.writeLog("LOT_ID:" + LOT_ID + ":LOT_ID");
					bs.writeLog("TOTAL_YIELD:" + TOTAL_YIELD + ":TOTAL_YIELD");
					if( (RESVFIELD5.equals("VD_LOW_YIELD") && (!"BIN97".equals(TOPBIN1_PROMPT) && !"BIN99".equals(TOPBIN1_PROMPT)&& !"GXN".equals(TOPBIN1_PROMPT)
							&& !"BROKEN".equals(TOPBIN1_PROMPT)&& !"LOST".equals(TOPBIN1_PROMPT)
							&& !"VI DEFECT".equals(TOPBIN1_PROMPT) ))
					|| (RESVFIELD5.equals("VD_LOW_YIELD") &&(!"".equals(TOPBIN2_PROMPT) &&!"BIN97".equals(TOPBIN2_PROMPT)&& !"GXN".equals(TOPBIN2_PROMPT) 
							&& !"BIN99".equals(TOPBIN2_PROMPT) && !" ".equals(TOPBIN2_PROMPT)
							&& !"BROKEN".equals(TOPBIN2_PROMPT)
							&& !"VI DEFECT".equals(TOPBIN2_PROMPT)
							&& !"LOST".equals(TOPBIN2_PROMPT)))
							||( RESVFIELD5.equals("VD_LOW_YIELD") &&(!"".equals(TOPBIN3_PROMPT) && !" ".equals(TOPBIN3_PROMPT)))
							)
							  {
				bs.writeLog("工序内+良率异常");
				Property[] propertyArray = new Property[38];
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
				//条形码号
				propertyArray[26] = new Property();
				propertyArray[26].setName("txmh");
				propertyArray[26].setValue(LOT_ID);
				//组装批号
				propertyArray[27] = new Property();
				propertyArray[27].setName("zzph");
				propertyArray[27].setValue(ASSYLOT);
				//扩散批号
				propertyArray[28] = new Property();
				propertyArray[28].setName("ksph");
				propertyArray[28].setValue(CUST_RUN_ID);
				//设备号
				propertyArray[29] = new Property();
				propertyArray[29].setName("sbh");
				propertyArray[29].setValue(RES_ID);
				//母体数
				propertyArray[30] = new Property();
				propertyArray[30].setName("mts");
				propertyArray[30].setValue(INPUT_QTY);
				//发生工序 
				propertyArray[31] = new Property();
				propertyArray[31].setName("fsgx");
				propertyArray[31].setValue(OPER);
				//发行者
				propertyArray[32] = new Property();
				propertyArray[32].setName("fxz");
				propertyArray[32].setValue(USER_ID);
				
				
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
				bs.writeLog("tb_gxnyc:" + sql);
				rs1.executeSql(sql);
				String dchrm = "", zrr1 = "";
				while(rs1.next()){
					dchrm += rs1.getString("id") + ",";
					if(!rs1.getString("zrr").equals("")){
						if(!zrr1.contains(rs1.getString("zrr")))
							zrr1 += rs1.getString("zrr") + ",";		
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
					bs.writeLog("tb_gxnyc:" + sql);
					rs1.executeSql(sql);
					while(rs1.next()){
						if(!dchrm.contains(rs1.getString("id"))){
							dchrm += rs1.getString("id") + ",";	
						}
						if(!rs1.getString("zrr").equals("")){
							if(!zrr1.contains(rs1.getString("zrr")))
								zrr1 += rs1.getString("zrr") + ",";		
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
					bs.writeLog("tb_gxnyc:" + sql);
					rs1.executeSql(sql);
					while(rs1.next()){
						if(!dchrm.contains(rs1.getString("id"))){
							dchrm += rs1.getString("id") + ",";	
						}
						if(!rs1.getString("zrr").equals("")){
							if(!zrr1.contains(rs1.getString("zrr")))
								zrr1 += rs1.getString("zrr") + ",";		
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
					bs.writeLog("tb_gxnyc:" + sql);
					rs1.executeSql(sql);
					while(rs1.next()){
						if(!dchrm.contains(rs1.getString("id"))){
							dchrm += rs1.getString("id") + ",";	
						}
						if(!rs1.getString("zrr").equals("")){
							if(!zrr1.contains(rs1.getString("zrr")))
								zrr1 += rs1.getString("zrr") + ",";		
						}
					}
				}
				//khm
				if(dchrm.equals("")){
					sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
					}
					bs.writeLog("tb_gxnyc:" + sql);
					rs1.executeSql(sql);
					while(rs1.next()){
						if(!dchrm.contains(rs1.getString("id"))){
							dchrm += rs1.getString("id") + ",";	
						}
						if(!rs1.getString("zrr").equals("")){
							if(!zrr1.contains(rs1.getString("zrr")))
								zrr1 += rs1.getString("zrr") + ",";	
						}
					}
				}
				//xh
				if(dchrm.equals("")){
					sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!MAT_DESC.equals("")){
						sql += " and xh = '" + MAT_DESC + "'";
					}
					bs.writeLog("tb_gxnyc:" + sql);
					rs1.executeSql(sql);
					while(rs1.next()){
						if(!dchrm.contains(rs1.getString("id"))){
							dchrm += rs1.getString("id") + ",";	
						}
						if(!rs1.getString("zrr").equals("")){
							if(!zrr1.contains(rs1.getString("zrr")))
								zrr1 += rs1.getString("zrr") + ",";		
						}
					}
				}
				//pkid
				if(dchrm.equals("")){
					sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!PKLD.equals("")){
						sql += " and pkid = '" + PKLD + "'";
					}
					bs.writeLog("tb_gxnyc:" + sql);
					rs1.executeSql(sql);
					while(rs1.next()){
						if(!dchrm.contains(rs1.getString("id"))){
							dchrm += rs1.getString("id") + ",";	
						}
						if(!rs1.getString("zrr").equals("")){
							if(!zrr1.contains(rs1.getString("zrr")))
								zrr1 += rs1.getString("zrr") + ",";		
						}
					}
				}
				
				if(!dchrm.equals(""))
					dchrm = dchrm.substring(0, dchrm.length() - 1);
				if(!zrr1.equals(""))
					zrr1 = zrr1.substring(0, zrr1.length() - 1);
				
				bs.writeLog("dchrm:" + dchrm);
				bs.writeLog("zrr:" + zrr1);
				if(dchrm.equals(""))
					dchrm = "553";
				bs.writeLog("dchrm:" + dchrm);
				bs.writeLog("zrr:" + zrr1);
				
				//责任人
				propertyArray[33] = new Property();
				propertyArray[33].setName("zrr1");
				propertyArray[33].setValue(zrr1);
				//调查人
				propertyArray[34] = new Property();
				propertyArray[34].setName("dchrm");
				propertyArray[34].setValue(dchrm);
				
				RES_ID = RES_ID.split("-")[0];
				//khm xh tester pkid
				sql = "select b.id id,lastname,zrr from tb_llyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
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
				bs.writeLog("tb_llyc:" + sql);
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
					sql = "select b.id id,lastname,zrr from tb_llyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
					}
					if(!MAT_DESC.equals("")){
						sql += " and xh = '" + MAT_DESC + "'";
					}
					if(!RES_ID.equals("")){
						sql += " and tester like'" + RES_ID + "%'";
					}
					bs.writeLog("tb_llyc:" + sql);
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
					sql = "select b.id id,lastname,zrr from tb_llyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
					}
					if(!PKLD.equals("")){
						sql += " and pkid = '" + PKLD + "'";
					}
					bs.writeLog("tb_llyc:" + sql);
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
					sql = "select b.id id,lastname,zrr from tb_llyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
					}
					if(!RES_ID.equals("")){
						sql += " and tester like'" + RES_ID + "%'";
					}
					bs.writeLog("tb_llyc:" + sql);
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
					sql = "select b.id id,lastname,zrr from tb_llyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
					}
					if(!MAT_DESC.equals("")){
						sql += " and xh = '" + MAT_DESC + "'";
					}
					bs.writeLog("tb_llyc:" + sql);
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
					sql = "select b.id id,lastname,zrr from tb_llyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
						sql += " and xh = 'ALL'";
						sql += " and tester ='ALL'";
						sql += " and pkid = 'ALL'";
					}
					bs.writeLog("tb_llyc:" + sql);
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
				
				propertyArray[35] = new Property();
				propertyArray[35].setName("tehrm");
				propertyArray[35].setValue(tehrm);
				
				propertyArray[36] = new Property();
				propertyArray[36].setName("zrr");
				propertyArray[36].setValue(zrr);
				
				
				propertyArray[37] = new Property();
				propertyArray[37].setName("qtycnr");
				propertyArray[37].setValue(RESVFIELD8);
				
				mainTableInfo.setProperty(propertyArray);
				
				requestInfo.setCreatorid(USER_ID);
				requestInfo.setWorkflowid("401");
				requestInfo.setDescription("工序内+良率异常处理流程-" + date + "(LOT:"+LOT_ID+")");
				
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
			else if(TOTAL_YIELD.equals(" ") || TOTAL_YIELD.equals("")||
					(RESVFIELD5.equals("VD_LOW_YIELD"))){
				// null == TOTAL_YIELD || "".equals(TOTAL_YIELD.trim())
				bs.writeLog("工序内异常");
				//触发工序内异常流程	
				Property[] propertyArray = new Property[14];
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
				bs.writeLog("tb_gxnyc:" + sql);
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
					bs.writeLog("tb_gxnyc:" + sql);
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
					bs.writeLog("tb_gxnyc:" + sql);
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
					bs.writeLog("tb_gxnyc:" + sql);
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
					bs.writeLog("tb_gxnyc:" + sql);
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
					bs.writeLog("tb_gxnyc:" + sql);
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
					bs.writeLog("tb_gxnyc:" + sql);
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
				
				propertyArray[13] = new Property();
				propertyArray[13].setName("qtycnr");
				propertyArray[13].setValue(RESVFIELD8);
				
				mainTableInfo.setProperty(propertyArray);
				
				requestInfo.setCreatorid(USER_ID);
				requestInfo.setWorkflowid("66");
				requestInfo.setDescription("工序内异常处理流程-" + date + "(LOT:"+LOT_ID+")");
				
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
				sql = "select b.id id,lastname,zrr from tb_llyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
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
				bs.writeLog("tb_llyc:" + sql);
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
					sql = "select b.id id,lastname,zrr from tb_llyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
					}
					if(!MAT_DESC.equals("")){
						sql += " and xh = '" + MAT_DESC + "'";
					}
					if(!RES_ID.equals("")){
						sql += " and tester like'" + RES_ID + "%'";
					}
					bs.writeLog("tb_llyc:" + sql);
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
					sql = "select b.id id,lastname,zrr from tb_llyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
					}
					if(!PKLD.equals("")){
						sql += " and pkid = '" + PKLD + "'";
					}
					bs.writeLog("tb_llyc:" + sql);
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
					sql = "select b.id id,lastname,zrr from tb_llyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
					}
					if(!RES_ID.equals("")){
						sql += " and tester like'" + RES_ID + "%'";
					}
					bs.writeLog("tb_llyc:" + sql);
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
					sql = "select b.id id,lastname,zrr from tb_llyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
					}
					if(!MAT_DESC.equals("")){
						sql += " and xh = '" + MAT_DESC + "'";
					}
					bs.writeLog("tb_llyc:" + sql);
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
					sql = "select b.id id,lastname,zrr from tb_llyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
					if(!CUST_ID.equals("")){
						sql += " and khm = '" + CUST_ID + "'";
						sql += " and xh = 'ALL'";
						sql += " and tester ='ALL'";
						sql += " and pkid = 'ALL'";
					}
					bs.writeLog("tb_llyc:" + sql);
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
				requestInfo.setDescription("良率异常处理流程-" + date +"(LOT:"+LOT_ID+")");
				
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
			}
		}
		catch (Exception e) {
			bs.writeLog("CCMEMES83:" + e);
		}	 
    }
//	private void writelog(List<Map<String, String>> loglist) {
//		OAMESMIDDLE.writerlog(loglist, logtablename);
//	}
	private void insert(Map<String, String> map) {
		OAMESMIDDLE.insert(map, logtablename);
	}
	
	
	 public static String readInterfacePost(String detailUrl,String str){
		HttpClient client = new HttpClient();
		
		 final PostMethod post = new PostMethod(detailUrl);
		 try {
		// post.setRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0");
		 final RequestEntity re = new StringRequestEntity(str,
		 "application/json", "utf-8");
		 post.setRequestEntity(re);
		 client.executeMethod(post);
		 System.out.println(str);
		 System.out.println("Access System authenticate, Status: " +
		 post.getStatusCode());
		 System.out.println("Access System authenticate, Response: " +
		 post.getResponseBodyAsString());
		 return post.getResponseBodyAsString();
		 } catch (final Exception e) {
		 e.printStackTrace();
		 // 调用异常, 返回异常报文
		 } finally {
		 post.releaseConnection();
		 }
		return null;
	}
	


}

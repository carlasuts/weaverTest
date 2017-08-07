package weaver.interfaces.workflow.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.text.*;
import java.math.*;
import java.net.URLDecoder;

import weaver.conn.*;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.RequestService;
import weaver.soa.workflow.request.Row;
import weaver.general.BaseBean;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicHeader;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
//import org.json.JSONArray;
//import org.json.JSONObject;

public class FSTHTTPPOST1 implements Action {
	
	
	private static final String url = "http://172.16.60.96:8099/MesWebService/req";
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			HttpPost request1 = new HttpPost(url);
			// 先封装一个 JSON 对象
			JSONObject param = new JSONObject();
			param.put("fromSystem", "OA");
			param.put("functionName", "MES_GETOATESTYIELD");
			param.put("token", "OATESTTOKEN");
			// 绑定到请求 Entry
			StringEntity se = new StringEntity(param.toString());
			request1.setEntity(se);
			System.out.println(request1);
			baseBean.writeLog("request1" + request1);
			System.out.println(param.toString());
			// 发送请求
			baseBean.writeLog("--------------------");
			HttpResponse httpResponse = new DefaultHttpClient().execute(request1);
			baseBean.writeLog("=====================");
			// 得到应答的字符串，这也是一个 JSON 格式保存的数据
			String retSrc = EntityUtils.toString(httpResponse.getEntity());
			baseBean.writeLog("retSrc" + retSrc);
			System.out.println(retSrc);
			
			JSONObject result = JSONObject.fromObject(retSrc);
			System.out.println("--------------------");
			System.out.println(result.toString());
			Object ListTestYieldList = result.get("oaTestYieldList");
			System.out.println(ListTestYieldList);
			System.out.println("--------------------");

			JSONArray temp = JSONArray.fromObject(ListTestYieldList);
			for (Object obj : temp) {
				System.out.println(obj);
				baseBean.writeLog("obj" + obj);
			}
			
			// 先封装一个 JSON 对象
			//PostMethod postMethod = new PostMethod("http://172.16.60.96:8099/MesWebService/req");
			//baseBean.writeLog("aaaaa" + postMethod);
//			NameValuePair[] param = new NameValuePair[3];
//			param[0] = new NameValuePair("fromSystem","OA");
//			param[1] = new NameValuePair("functionName","MES_GETOATESTYIELD");
//			param[2] = new NameValuePair("token","OATESTTOKEN");
//			postMethod.setRequestBody(param);
//			JSONObject param = new JSONObject();
//			param.put("fromSystem","OA");
//			param.put("functionName","MES_GETOATESTYIELD");
//			param.put("token","OATESTTOKEN");
//			String  aa = param.toString() ;
//			baseBean.writeLog("param:" + param);
//			
//			baseBean.writeLog("aa" + aa);
//		    //postMethod.setRequestBody(aa); 
//			HttpPost httppost = new HttpPost("http://172.16.60.96:8099/MesWebService/req");
//		    StringEntity se = new StringEntity(aa);
////		    se.setContentType("text/json");
////		    se.setContentEncoding(new BasicHeader(HTTP.CONTENT_TYPE,"application/json"));
//		    httppost.setEntity(se);
//		    
//			//postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");
//			//HttpClient http = new HttpClient();
//		    DefaultHttpClient http = new DefaultHttpClient();
////			http.getHttpConnectionManager().getParams().setConnectionTimeout(5000);   
////			http.getHttpConnectionManager().getParams().setSoTimeout(5000);
//			HttpResponse httpresponse = http.execute(httppost);
//			//http.executeMethod(postMethod);
//			//String result = postMethod.getResponseBodyAsString();
//			String result = URLDecoder.decode(EntityUtils.toString(httpresponse.getEntity()),"UTF-8") ; 
//			JSONObject rjson = new JSONObject(result);
//			baseBean.writeLog("rjson" + rjson);
//			//JSONArray content =  rjson.getJSONArray("oaTestYieldList");//根据文档填写
//			String oaTestYieldList = rjson.get("oaTestYieldList").toString();
//			JSONArray content = new JSONArray(oaTestYieldList);
//			for(int i = 0; i < content.length(); i++){
//				JSONObject p = (JSONObject)content.get(i);  
//				String ID = (String)p.get("id").toString();
//				String FXNO = (String)p.get("fxNo");
//				String CUST_ID = (String)p.get("custId");
//				String MAT_DESC = (String)p.get("matDesc");
//				String ASSYLOT = (String)p.get("assyLot");
//				String CUST_RUN_ID = (String)p.get("custRunId");
//				String CREATE_DATE = (String)p.get("createDate");
//				String RES_ID = (String)p.get("resId");
//				String LOT_ID = (String)p.get("lotId");
//				String PROGRAM_ID = (String)p.get("programId");
//				String PKLD = (String)p.get("pkld");
//				String OPER = (String)p.get("oper");
//				String INPUT_QTY = (String)p.get("inputQty").toString();
//				String PASS_QTY = (String)p.get("passQty").toString();
//				String FT_FAIL_QTY = (String)p.get("ftFailQty").toString();
//				String VD_FAIL_QTY = (String)p.get("vdFailQty").toString();
//				String TOTAL_YIELD = (String)p.get("totalYield");
//				String TOPBIN1_PROMPT = (String)p.get("topBin1Prompt");
//				String TOPBIN2_PROMPT = (String)p.get("topBin2Prompt");
//				String TOPBIN3_PROMPT = (String)p.get("topBin3Prompt");
//				String TOPBIN1_QTY = (String)p.get("topBin1Qty").toString();
//				String TOPBIN2_QTY = (String)p.get("topBin2Qty").toString();
//				String TOPBIN3_QTY = (String)p.get("topBin3Qty").toString();
//				String TOPBIN1_FAIL_YIELD = (String)p.get("topBin1FailYield");
//				String TOPBIN2_FAIL_YIELD = (String)p.get("topBin2FailYield");
//				String TOPBIN3_FAIL_YIELD = (String)p.get("topBin3FailYield");
//				String USER_ID = (String)p.get("userId");
//				String FLAG = (String)p.get("flag");
//				String RESVFIELD1 = (String)p.get("resvField1");
//				String RESVFIELD2 = (String)p.get("resvField2");
//				String RESVFIELD3 = (String)p.get("resvField3");
//				String RESVFIELD4 = (String)p.get("resvField4");
//				String RESVFIELD5 = (String)p.get("resvField5");
//				String RESVFIELD6 = (String)p.get("resvField6");
//				String RESVFIELD7 = (String)p.get("resvField7");
//				String RESVFIELD8 = (String)p.get("resvField8");
//				String RESVFIELD9 = (String)p.get("resvField9");
//				String RESVFIELD10 = (String)p.get("resvField10");
//				String UPDATETIME = (String)p.get("updateTime");
//				RecordSet rs = new RecordSet();
//				RecordSet rs1 = new RecordSet();
//				String sql1 ="select id from HFYC_MIDDLE where id="+ID;
//				rs1.executeSql(sql1);
//				if(rs1.next()){
//					String sql = "update HFYC_MIDDLE set flag = 200,UPDATE_TIME = '" + UPDATETIME + "' where id = " + ID;
//					rs1.executeSql(sql);
//				}else{
//				String sql = "Insert into HFYC_MIDDLE(ID, FXNO, CUST_ID, MAT_DESC, ASSYLOT, CUST_RUN_ID, CREATE_DATE, RES_ID, LOT_ID, PROGRAM_ID, PKLD, OPER, INPUT_QTY, PASS_QTY, FT_FAIL_QTY, VD_FAIL_QTY, TOTAL_YIELD, TOPBIN1_PROMPT, TOPBIN2_PROMPT, TOPBIN3_PROMPT, TOPBIN1_QTY, TOPBIN2_QTY, TOPBIN3_QTY, TOPBIN1_FAIL_YIELD, TOPBIN2_FAIL_YIELD, TOPBIN3_FAIL_YIELD, USER_ID, FLAG, RESV_FIELD1, RESV_FIELD2, RESV_FIELD3, RESV_FIELD4, RESV_FIELD5, RESV_FIELD6, RESV_FIELD7, RESV_FIELD8, RESV_FIELD9, RESV_FIELD10, UPDATE_TIME)Values (";
//				sql += ID + ",";
//				sql += "'" + FXNO + "',";
//				sql += "'" + CUST_ID + "',";
//				sql += "'" + MAT_DESC + "',";
//				sql += "'" + ASSYLOT + "',";
//				sql += "'" + CUST_RUN_ID + "',";
//				sql += "'" + CREATE_DATE + "',";
//				sql += "'" + RES_ID + "',";
//				sql += "'" + LOT_ID + "',";
//				sql += "'" + PROGRAM_ID + "',";
//				sql += "'" + PKLD + "',";
//				sql += "'" + OPER + "',";
//				sql += INPUT_QTY + ",";
//				sql += PASS_QTY + ",";
//				sql += FT_FAIL_QTY + ",";
//				sql += VD_FAIL_QTY + ",";
//				sql += "'" + TOTAL_YIELD + "',";
//				sql += "'" + TOPBIN1_PROMPT + "',";
//				sql += "'" + TOPBIN2_PROMPT + "',";
//				sql += "'" + TOPBIN3_PROMPT + "',";
//				sql += TOPBIN1_QTY + ",";
//				sql += TOPBIN2_QTY + ",";
//				sql += TOPBIN3_QTY + ",";
//				sql += "'" + TOPBIN1_FAIL_YIELD + "',";
//				sql += "'" + TOPBIN2_FAIL_YIELD + "',";
//				sql += "'" + TOPBIN3_FAIL_YIELD + "',";
//				sql += "'" + USER_ID + "',";
//				sql += "'" + FLAG + "',";
//				sql += "'" + RESVFIELD1 + "',";
//				sql += "'" + RESVFIELD2 + "',";
//				sql += "'" + RESVFIELD3 + "',";
//				sql += "'" + RESVFIELD4 + "',";
//				sql += "'" + RESVFIELD5 + "',";
//				sql += "'" + RESVFIELD6 + "',";
//				sql += "'" + RESVFIELD7 + "',";
//				sql += "'" + RESVFIELD8 + "',";
//				sql += "'" + RESVFIELD9 + "',";
//				sql += "'" + RESVFIELD10 + "',";
//				sql += "'" + UPDATETIME + "')";
//				rs.executeSql(sql);
//
//				JSONObject req = new JSONObject();
//				req.put("fromSystem", "OA");
//				req.put("functionName", "MES_UPDATEOATESTYIELDINFO");
//				req.put("token", "OATESTTOKEN");
//
//				JSONObject message = new JSONObject();
//				message.put("id", ID);
//
//				JSONObject[] updateInfos = new JSONObject[1];
//				updateInfos[0] = new JSONObject();
//				updateInfos[0].put("updateField", "FLAG");
//				updateInfos[0].put("updateValue", "100");
//
//				message.put("updateInfoList", updateInfos);
//
//				req.put("message", message);
//				baseBean.writeLog("message" + message);
//				 baseBean.writeLog("req:" + req);
//				 StringEntity bb = new StringEntity(param.toString());
//				 baseBean.writeLog("bb" + bb);
////				 postMethod.setRequestEntity((RequestEntity) bb); 
//////				 baseBean.writeLog("message" + req); 
////				 postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");
////				 baseBean.writeLog("postMethod:" + postMethod);
////				 HttpClient Client = new HttpClient();
////				 Client.getHttpConnectionManager().getParams().setConnectionTimeout(5000);   
////				 Client.getHttpConnectionManager().getParams().setSoTimeout(5000);
////				 Client.executeMethod(postMethod);
////				 String results = postMethod.getResponseBodyAsString();
//				    StringEntity ss = new StringEntity(aa);
//				    ss.setContentType("text/json");
//				    ss.setContentEncoding(new BasicHeader(HTTP.CONTENT_TYPE,"application/json"));
//				    httppost.setEntity(ss);
//				    HttpResponse httpresponses = http.execute(httppost);
//				    String results = URLDecoder.decode(EntityUtils.toString(httpresponses.getEntity()),"UTF-8") ; 
//				 JSONObject rjsons = new JSONObject(results);	
//				 baseBean.writeLog("rjsons:" + rjsons);
//				 String statusValue = rjsons.get("statusValue").toString();
//				 baseBean.writeLog("statusValue:" + statusValue);
//				 baseBean.writeLog("-----------------------------" );
//				 if(statusValue.equals("1")){
//					 baseBean.writeLog("==============================" );
//					Date d = new Date();
//					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//					String date = sdf.format(d);
//					sql = "select id from hrmresource where workcode = '" + USER_ID + "'";
//					rs1.executeSql(sql);
//					if(rs1.next())
//						USER_ID = rs1.getString("id");
//					else
//						USER_ID = "1";
//					RequestInfo requestInfo = new RequestInfo();
//					MainTableInfo mainTableInfo = new MainTableInfo();
//					baseBean.writeLog("LOT_ID:" + LOT_ID + ":LOT_ID");
//					baseBean.writeLog("TOTAL_YIELD:" + TOTAL_YIELD + ":TOTAL_YIELD");
//					if(TOTAL_YIELD.equals(" ") || TOTAL_YIELD.equals("")){
//						baseBean.writeLog("工序内异常");
//						//触发工序内异常流程	
//						Property[] propertyArray = new Property[13];
//						//型号
//						propertyArray[0] = new Property();
//						propertyArray[0].setName("xh");
//						propertyArray[0].setValue(MAT_DESC);
//						//条形码号
//						propertyArray[1] = new Property();
//						propertyArray[1].setName("txmh");
//						propertyArray[1].setValue(LOT_ID);
//						//组装批号
//						propertyArray[2] = new Property();
//						propertyArray[2].setName("zzph");
//						propertyArray[2].setValue(ASSYLOT);
//						//扩散批号
//						propertyArray[3] = new Property();
//						propertyArray[3].setName("ksph");
//						propertyArray[3].setValue(CUST_RUN_ID);
//						//设备号
//						propertyArray[4] = new Property();
//						propertyArray[4].setName("sbh");
//						propertyArray[4].setValue(RES_ID);
//						//母体数
//						propertyArray[5] = new Property();
//						propertyArray[5].setName("mts");
//						propertyArray[5].setValue(INPUT_QTY);
//						//发生工序 
//						propertyArray[6] = new Property();
//						propertyArray[6].setName("fsgx");
//						propertyArray[6].setValue(OPER);
//						//发行者
//						propertyArray[7] = new Property();
//						propertyArray[7].setName("fxz");
//						propertyArray[7].setValue(USER_ID);
//						//触发id
//						propertyArray[8] = new Property();
//						propertyArray[8].setName("tiggerid");
//						propertyArray[8].setValue(ID);
//						//客户名
//						propertyArray[9] = new Property();
//						propertyArray[9].setName("khm");
//						propertyArray[9].setValue(CUST_ID);
//						//PKLD
//						propertyArray[10] = new Property();
//						propertyArray[10].setName("pkld");
//						propertyArray[10].setValue(PKLD);
//						
//						//khm xh pkid
//						sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//						if(!CUST_ID.equals("")){
//							sql += " and khm = '" + CUST_ID + "'";
//						}
//						if(!MAT_DESC.equals("")){
//							sql += " and xh = '" + MAT_DESC + "'";
//						}
//						if(!PKLD.equals("")){
//							sql += " and pkid = '" + PKLD + "'";
//						}
//						baseBean.writeLog("TB_GXNYC:" + sql);
//						rs1.executeSql(sql);
//						String dchrm = "", zrr = "";
//						while(rs1.next()){
//							dchrm += rs1.getString("id") + ",";
//							if(!rs1.getString("zrr").equals("")){
//								if(!zrr.contains(rs1.getString("zrr")))
//									zrr += rs1.getString("zrr") + ",";		
//							}
//						}
//						//khm pkid
//						if(dchrm.equals("")){
//							sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//							if(!CUST_ID.equals("")){
//								sql += " and khm = '" + CUST_ID + "'";
//							}
//							if(!PKLD.equals("")){
//								sql += " and pkid = '" + PKLD + "'";
//							}
//							baseBean.writeLog("TB_GXNYC:" + sql);
//							rs1.executeSql(sql);
//							while(rs1.next()){
//								if(!dchrm.contains(rs1.getString("id"))){
//									dchrm += rs1.getString("id") + ",";	
//								}
//								if(!rs1.getString("zrr").equals("")){
//									if(!zrr.contains(rs1.getString("zrr")))
//										zrr += rs1.getString("zrr") + ",";		
//								}
//							}
//						}
//						//kmm xh
//						if(dchrm.equals("")){
//							sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//							if(!CUST_ID.equals("")){
//								sql += " and khm = '" + CUST_ID + "'";
//							}
//							if(!MAT_DESC.equals("")){
//								sql += " and xh = '" + MAT_DESC + "'";
//							}
//							baseBean.writeLog("TB_GXNYC:" + sql);
//							rs1.executeSql(sql);
//							while(rs1.next()){
//								if(!dchrm.contains(rs1.getString("id"))){
//									dchrm += rs1.getString("id") + ",";	
//								}
//								if(!rs1.getString("zrr").equals("")){
//									if(!zrr.contains(rs1.getString("zrr")))
//										zrr += rs1.getString("zrr") + ",";		
//								}
//							}
//						}
//						//xh pkid
//						if(dchrm.equals("")){
//							sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//							if(!MAT_DESC.equals("")){
//								sql += " and xh = '" + MAT_DESC + "'";
//							}
//							if(!PKLD.equals("")){
//								sql += " and pkid = '" + PKLD + "'";
//							}
//							baseBean.writeLog("TB_GXNYC:" + sql);
//							rs1.executeSql(sql);
//							while(rs1.next()){
//								if(!dchrm.contains(rs1.getString("id"))){
//									dchrm += rs1.getString("id") + ",";	
//								}
//								if(!rs1.getString("zrr").equals("")){
//									if(!zrr.contains(rs1.getString("zrr")))
//										zrr += rs1.getString("zrr") + ",";		
//								}
//							}
//						}
//						//khm
//						if(dchrm.equals("")){
//							sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//							if(!CUST_ID.equals("")){
//								sql += " and khm = '" + CUST_ID + "'";
//							}
//							baseBean.writeLog("TB_GXNYC:" + sql);
//							rs1.executeSql(sql);
//							while(rs1.next()){
//								if(!dchrm.contains(rs1.getString("id"))){
//									dchrm += rs1.getString("id") + ",";	
//								}
//								if(!rs1.getString("zrr").equals("")){
//									if(!zrr.contains(rs1.getString("zrr")))
//										zrr += rs1.getString("zrr") + ",";	
//								}
//							}
//						}
//						//xh
//						if(dchrm.equals("")){
//							sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//							if(!MAT_DESC.equals("")){
//								sql += " and xh = '" + MAT_DESC + "'";
//							}
//							baseBean.writeLog("TB_GXNYC:" + sql);
//							rs1.executeSql(sql);
//							while(rs1.next()){
//								if(!dchrm.contains(rs1.getString("id"))){
//									dchrm += rs1.getString("id") + ",";	
//								}
//								if(!rs1.getString("zrr").equals("")){
//									if(!zrr.contains(rs1.getString("zrr")))
//										zrr += rs1.getString("zrr") + ",";		
//								}
//							}
//						}
//						//pkid
//						if(dchrm.equals("")){
//							sql = "select b.id id,lastname,zrr from tb_gxnyc a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//							if(!PKLD.equals("")){
//								sql += " and pkid = '" + PKLD + "'";
//							}
//							baseBean.writeLog("TB_GXNYC:" + sql);
//							rs1.executeSql(sql);
//							while(rs1.next()){
//								if(!dchrm.contains(rs1.getString("id"))){
//									dchrm += rs1.getString("id") + ",";	
//								}
//								if(!rs1.getString("zrr").equals("")){
//									if(!zrr.contains(rs1.getString("zrr")))
//										zrr += rs1.getString("zrr") + ",";		
//								}
//							}
//						}
//						
//						if(!dchrm.equals(""))
//							dchrm = dchrm.substring(0, dchrm.length() - 1);
//						if(!zrr.equals(""))
//							zrr = zrr.substring(0, zrr.length() - 1);
//						
//						baseBean.writeLog("dchrm:" + dchrm);
//						baseBean.writeLog("zrr:" + zrr);
//						if(dchrm.equals(""))
//							dchrm = "553";
//						baseBean.writeLog("dchrm:" + dchrm);
//						baseBean.writeLog("zrr:" + zrr);
//						
//						//责任人
//						propertyArray[11] = new Property();
//						propertyArray[11].setName("zrr");
//						propertyArray[11].setValue(zrr);
//						//调查人
//						propertyArray[12] = new Property();
//						propertyArray[12].setName("dchrm");
//						propertyArray[12].setValue(dchrm);
//						
//						mainTableInfo.setProperty(propertyArray);
//						
//						requestInfo.setCreatorid(USER_ID);
//						requestInfo.setWorkflowid("66");
//						requestInfo.setDescription("工序内异常处理流程-" + date + "(MES自动触发)");
//						
//						requestInfo.setMainTableInfo(mainTableInfo);
//						RequestService service = new RequestService();//创建请求服务实例
//						
//						String newRequestid = service.createRequest(requestInfo); 
//						baseBean.writeLog("HFYC_MIDDLE_GXN:" + newRequestid);
//						
//						SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss"); 
//						String udpatetime = sdf1.format(d);
//						sql = "update HFYC_MIDDLE set FLAG = '100',UPDATE_TIME = '" + udpatetime + "' where id = " + ID;
//						baseBean.writeLog("HFYC_MIDDLE_GXN update sql:" + sql);
//						rs1.executeSql(sql);	
//					}
//					else{
//						baseBean.writeLog("良率异常");
//						//触发良率异常流程
//						Property[] propertyArray = new Property[28];
//						propertyArray[0] = new Property();
//						propertyArray[0].setName("fxNO");
//						propertyArray[0].setValue(FXNO);
//						
//						propertyArray[1] = new Property();
//						propertyArray[1].setName("khm");
//						propertyArray[1].setValue(CUST_ID);
//						
//						propertyArray[2] = new Property();
//						propertyArray[2].setName("xh");
//						propertyArray[2].setValue(MAT_DESC);
//						
//						propertyArray[3] = new Property();
//						propertyArray[3].setName("ASSYLOT");
//						propertyArray[3].setValue(ASSYLOT);
//						
//						propertyArray[4] = new Property();
//						propertyArray[4].setName("WPLOT");
//						propertyArray[4].setValue(CUST_RUN_ID);
//						
//						propertyArray[5] = new Property();
//						propertyArray[5].setName("rq");
//						propertyArray[5].setValue(CREATE_DATE);
//						
//						propertyArray[6] = new Property();
//						propertyArray[6].setName("Tester");
//						propertyArray[6].setValue(RES_ID);
//						
//						propertyArray[7] = new Property();
//						propertyArray[7].setName("EDPNo");
//						propertyArray[7].setValue(LOT_ID);
//						
//						propertyArray[8] = new Property();
//						propertyArray[8].setName("cxm");
//						propertyArray[8].setValue(PROGRAM_ID);
//						
//						propertyArray[9] = new Property();
//						propertyArray[9].setName("PKLD");
//						propertyArray[9].setValue(PKLD);
//						
//						propertyArray[10] = new Property();
//						propertyArray[10].setName("gxh");
//						propertyArray[10].setValue(OPER);
//						
//						propertyArray[11] = new Property();
//						propertyArray[11].setName("zys");
//						propertyArray[11].setValue(INPUT_QTY);
//						
//						propertyArray[12] = new Property();
//						propertyArray[12].setName("lps");
//						propertyArray[12].setValue(PASS_QTY);
//						
//						propertyArray[13] = new Property();
//						propertyArray[13].setName("FIbl");
//						propertyArray[13].setValue(FT_FAIL_QTY);
//						
//						propertyArray[14] = new Property();
//						propertyArray[14].setName("wgbl");
//						propertyArray[14].setValue(VD_FAIL_QTY);
//						
//						propertyArray[15] = new Property();
//						propertyArray[15].setName("hgl");
//						propertyArray[15].setValue(TOTAL_YIELD);
//						
//						propertyArray[16] = new Property();
//						propertyArray[16].setName("gg1");
//						propertyArray[16].setValue(TOPBIN1_PROMPT);
//						
//						propertyArray[17] = new Property();
//						propertyArray[17].setName("gg2");
//						propertyArray[17].setValue(TOPBIN2_PROMPT);
//						
//						propertyArray[18] = new Property();
//						propertyArray[18].setName("gg3");
//						propertyArray[18].setValue(TOPBIN3_PROMPT);
//						
//						propertyArray[19] = new Property();
//						propertyArray[19].setName("bn91bls");
//						propertyArray[19].setValue(TOPBIN1_QTY);
//						
//						propertyArray[20] = new Property();
//						propertyArray[20].setName("bn96bls");
//						propertyArray[20].setValue(TOPBIN2_QTY);
//						
//						propertyArray[21] = new Property();
//						propertyArray[21].setName("bn97bls");
//						propertyArray[21].setValue(TOPBIN3_QTY);
//						
//						propertyArray[22] = new Property();
//						propertyArray[22].setName("bn91bll");
//						propertyArray[22].setValue(TOPBIN1_FAIL_YIELD);
//						
//						propertyArray[23] = new Property();
//						propertyArray[23].setName("bn96bll");
//						propertyArray[23].setValue(TOPBIN2_FAIL_YIELD);
//						
//						propertyArray[24] = new Property();
//						propertyArray[24].setName("bn97bll");
//						propertyArray[24].setValue(TOPBIN3_FAIL_YIELD);
//						
//						propertyArray[25] = new Property();
//						propertyArray[25].setName("tiggerid");
//						propertyArray[25].setValue(ID);
//						
//						RES_ID = RES_ID.split("-")[0];
//						//khm xh tester pkid
//						sql = "select b.id id,lastname,zrr from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//						if(!CUST_ID.equals("")){
//							sql += " and khm = '" + CUST_ID + "'";
//						}
//						if(!MAT_DESC.equals("")){
//							sql += " and xh = '" + MAT_DESC + "'";
//						}
//						if(!RES_ID.equals("")){
//							sql += " and tester like'" + RES_ID + "%'";
//						}
//						if(!PKLD.equals("")){
//							sql += " and pkid = '" + PKLD + "'";
//						}
//						baseBean.writeLog("TB_LLYC:" + sql);
//						rs1.executeSql(sql);
//						String tehrm = "", zrr = "";
//						while(rs1.next()){
//							tehrm += rs1.getString("id") + ",";
//							if(!rs1.getString("zrr").equals("")){
//								if(!zrr.contains(rs1.getString("zrr")))
//									zrr += rs1.getString("zrr") + ",";		
//							}
//						}
//						//khm xh tester
//						if(tehrm.equals("")){
//							sql = "select b.id id,lastname,zrr from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//							if(!CUST_ID.equals("")){
//								sql += " and khm = '" + CUST_ID + "'";
//							}
//							if(!MAT_DESC.equals("")){
//								sql += " and xh = '" + MAT_DESC + "'";
//							}
//							if(!RES_ID.equals("")){
//								sql += " and tester like'" + RES_ID + "%'";
//							}
//							baseBean.writeLog("TB_LLYC:" + sql);
//							rs1.executeSql(sql);
//							while(rs1.next()){
//								if(!tehrm.contains(rs1.getString("id"))){
//									tehrm += rs1.getString("id") + ",";	
//								}
//								if(!rs1.getString("zrr").equals("")){
//									if(!zrr.contains(rs1.getString("zrr")))
//										zrr += rs1.getString("zrr") + ",";		
//								}
//							}
//						}
//						//khm pkid
//						if(tehrm.equals("")){
//							sql = "select b.id id,lastname,zrr from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//							if(!CUST_ID.equals("")){
//								sql += " and khm = '" + CUST_ID + "'";
//							}
//							if(!PKLD.equals("")){
//								sql += " and pkid = '" + PKLD + "'";
//							}
//							baseBean.writeLog("TB_LLYC:" + sql);
//							rs1.executeSql(sql);
//							while(rs1.next()){
//								if(!tehrm.contains(rs1.getString("id"))){
//									tehrm += rs1.getString("id") + ",";	
//								}
//								if(!rs1.getString("zrr").equals("")){
//									if(!zrr.contains(rs1.getString("zrr")))
//										zrr += rs1.getString("zrr") + ",";		
//								}
//							}
//						}
//						//khm tester
//						if(tehrm.equals("")){
//							sql = "select b.id id,lastname,zrr from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//							if(!CUST_ID.equals("")){
//								sql += " and khm = '" + CUST_ID + "'";
//							}
//							if(!RES_ID.equals("")){
//								sql += " and tester like'" + RES_ID + "%'";
//							}
//							baseBean.writeLog("TB_LLYC:" + sql);
//							rs1.executeSql(sql);
//							while(rs1.next()){
//								if(!tehrm.contains(rs1.getString("id"))){
//									tehrm += rs1.getString("id") + ",";	
//								}
//								if(!rs1.getString("zrr").equals("")){
//									if(!zrr.contains(rs1.getString("zrr")))
//										zrr += rs1.getString("zrr") + ",";		
//								}
//							}
//						}
//						//kmm xh
//						if(tehrm.equals("")){
//							sql = "select b.id id,lastname,zrr from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//							if(!CUST_ID.equals("")){
//								sql += " and khm = '" + CUST_ID + "'";
//							}
//							if(!MAT_DESC.equals("")){
//								sql += " and xh = '" + MAT_DESC + "'";
//							}
//							baseBean.writeLog("TB_LLYC:" + sql);
//							rs1.executeSql(sql);
//							while(rs1.next()){
//								if(!tehrm.contains(rs1.getString("id"))){
//									tehrm += rs1.getString("id") + ",";	
//								}
//								if(!rs1.getString("zrr").equals("")){
//									if(!zrr.contains(rs1.getString("zrr")))
//										zrr += rs1.getString("zrr") + ",";		
//								}
//							}
//						}
//						//khm
//						if(tehrm.equals("")){
//							sql = "select b.id id,lastname,zrr from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1";
//							if(!CUST_ID.equals("")){
//								sql += " and khm = '" + CUST_ID + "'";
//								sql += " and xh = 'ALL'";
//								sql += " and tester ='ALL'";
//								sql += " and pkid = 'ALL'";
//							}
//							baseBean.writeLog("TB_LLYC:" + sql);
//							rs1.executeSql(sql);
//							
//							while(rs1.next()){
//								if(!tehrm.contains(rs1.getString("id"))){
//									tehrm += rs1.getString("id") + ",";	
//								}
//								if(!rs1.getString("zrr").equals("")){
//									if(!zrr.contains(rs1.getString("zrr")))
//										zrr += rs1.getString("zrr") + ",";	
//								}
//							}
//						}
//
//						if(!tehrm.equals(""))
//							tehrm = tehrm.substring(0, tehrm.length() - 1);
//						if(!zrr.equals(""))
//							zrr = zrr.substring(0, zrr.length() - 1);
//						
//						baseBean.writeLog("tehrm:" + tehrm);
//						baseBean.writeLog("zrr:" + zrr);
//						if(tehrm.equals(""))
//							tehrm = "553";
//						baseBean.writeLog("tehrm:" + tehrm);
//						baseBean.writeLog("zrr:" + zrr);
//						
//						propertyArray[26] = new Property();
//						propertyArray[26].setName("tehrm");
//						propertyArray[26].setValue(tehrm);
//						
//						propertyArray[27] = new Property();
//						propertyArray[27].setName("zrr");
//						propertyArray[27].setValue(zrr);
//						
//						mainTableInfo.setProperty(propertyArray);
//						
//						requestInfo.setCreatorid(USER_ID);
//						requestInfo.setWorkflowid("83");
//						requestInfo.setDescription("良率异常处理流程-" + date + "(MES自动触发)");
//						
//						requestInfo.setMainTableInfo(mainTableInfo);
//						RequestService service = new RequestService();//创建请求服务实例
//						
//						String newRequestid = service.createRequest(requestInfo); 
//						baseBean.writeLog("HFYC_MIDDLE:" + newRequestid);
//						
//						SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss"); 
//						String udpatetime = sdf1.format(d);
//						sql = "update HFYC_MIDDLE set FLAG = '100',UPDATE_TIME = '" + udpatetime + "' where id = " + ID;
//						baseBean.writeLog("HFYC_MIDDLE update sql:" + sql);
//						rs1.executeSql(sql);
//					}
//				 }else{
//					 
//				 }
					 
				
//				}
//				
//
//			}
//		}
//		catch(java.lang.Exception e){
//			BaseBean baseBean = new BaseBean();
//			baseBean.writeLog("start log");
//			baseBean.writeLog("------------------------------------------------------------------------");
//			baseBean.writeLog("FSTHTTPPOST error:" + e.getMessage());
//			baseBean.writeLog("------------------------------------------------------------------------");
		}catch (Exception e){
			e.getStackTrace();
		}
//			baseBean.writeLog("end log");
		return Action.SUCCESS;
	}
}

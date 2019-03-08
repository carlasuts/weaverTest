package weaver.interfaces.workflow.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.text.*;
import java.math.*;

import org.json.JSONObject;

import weaver.conn.*;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.schedule.STMEMES83SCH;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.Row;
import weaver.general.BaseBean;

public class NTMEMES120504 implements Action {
	 private static final String url = "http://172.22.20.118:8090/MesWebService/req";
	 public  static final String token ="AWK18VSE25SDNKLS3AET@EWL#LDG*!F";
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			String id="",cz = "",mescz = "",cz1="";
			String sql = "";
			Property[] properties = request.getMainTableInfo().getProperty();// 获取表单主字段信息
			for (int i = 0; i < properties.length; i++) {// 主表数据
				String name = properties[i].getName().toUpperCase();//字段名
				String value = Util.null2String(properties[i].getValue());//值
				  //ID
			    if(name.equals("TIGGERID")){
				    id = value;
			    }
				//处置
				if(name.equals("TECZPD")){
					cz = value;
				}
				//MES处置
				if(name.equals("MCZ")){
					mescz = value;
				}

			}
			
			sql = "select TIGGERID,cz1,sfqcqr,qtcz from formtable_main_9 where requestid = " + request.getRequestid();
			baseBean.writeLog(sql);
			rs.executeSql(sql);
			rs.next();
//			String id = Util.null2String(rs.getString("TIGGERID"));
			cz1 = Util.null2String(rs.getString("cz1"));
			String qc = Util.null2String(rs.getString("sfqcqr"));
			String qtcz = Util.null2String(rs.getString("qtcz"));
			sql = "select selectname from workflow_selectitem where fieldid = 6742 and selectvalue = " + cz1;
			baseBean.writeLog(sql);
			rs.executeSql(sql);
			rs.next();
			cz1 = rs.getString("selectname");
			if(cz1.length() > 15){
				cz1 = cz1.substring(0, 15);	
			}
			
			
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
			String udpatetime = sdf.format(date);
			String workcode = "";
			//如果是需要TE再处置，插入新表
			
			JSONObject req = new JSONObject();
			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPDATEOATESTYIELDINFO");
			req.put("token", token);
				
		    JSONObject message = new JSONObject();
			message.put("id", id);
			
			
			
			if(cz.equals("3")){
				//TE处置
				sql = "select * from llyc_middle where id = " + id;
				baseBean.writeLog(sql);
				rs.execute(sql);
				rs.next();
				String lot_id = "",oper = "";
				lot_id = rs.getString("lot_id");
				oper = rs.getString("oper");
				
				int maxid = 1;
				sql = "select max(id) id from LLYC_END_MIDDLE";
				rs.execute(sql);
				if(rs.next()){
					maxid = rs.getInt("id");
				}
				
				sql = "insert into LLYC_END_MIDDLE(id,lot_id,oper,flag,update_time) values (" + 
				maxid + "," + 
				"'" + lot_id + "'," + 
				"'" + oper + "'," + 
				"'200'," +
				"'" + udpatetime + "'" +
				")";
				baseBean.writeLog(sql);
				rs.execute(sql);
				
				String hrmid = request.getLastoperator();
				sql = "select workcode from hrmresource where id = " + hrmid;
				baseBean.writeLog(sql);
				rs.execute(sql);
				if(rs.next()){
					workcode = rs.getString("workcode");
				}
				
				sql = "update STYC_MIDDLE set flag = '200'";
				JSONObject[] updateInfos = new JSONObject[5];
				updateInfos[0] = new JSONObject();
				updateInfos[0].put("updateField", "FLAG");
				updateInfos[0].put("updateValue", "200");
				
				if(!workcode.equals("")){
					sql += ",resv_field1='" + workcode + "'";	
					updateInfos[1] = new JSONObject();
					updateInfos[1].put("updateField", "RESV_FIELD1");
					updateInfos[1].put("updateValue", workcode);
		        }else{
		        	updateInfos[1] = new JSONObject();
					updateInfos[1].put("updateField", "RESV_FIELD1");
					updateInfos[1].put("updateValue", " ");
		        }
				if(!mescz.equals("")){
					sql += ",resv_field2 = '" + mescz + "'";
					updateInfos[2] = new JSONObject();
					updateInfos[2].put("updateField", "RESV_FIELD2");
					updateInfos[2].put("updateValue", mescz);
		        }else{
		        	updateInfos[2] = new JSONObject();
					updateInfos[2].put("updateField", "RESV_FIELD2");
					updateInfos[2].put("updateValue", " ");
		        }
				if(!cz1.equals("")){
					sql += ",resv_field4 = '" + cz1 + "'";
					updateInfos[3] = new JSONObject();
					updateInfos[3].put("updateField", "RESV_FIELD4");
					updateInfos[3].put("updateValue", cz1);
				}else{
		        	updateInfos[3] = new JSONObject(); 
					updateInfos[3].put("updateField", "RESV_FIELD4");
					updateInfos[3].put("updateValue", " ");
		        }
				/*
				if(!tecz.equals("")){
					sql += ",resv_field4 = '" + tecz + "'";	
				}*/
				sql += ",UPDATE_TIME = '" + udpatetime + "' where id = " + id;
				updateInfos[4] = new JSONObject();
				updateInfos[4].put("updateField", "UPDATE_TIME");
				updateInfos[4].put("updateValue", udpatetime);
				message.put("updateInfoList", updateInfos);
				req.put("message", message);
				
				String retSrcs = STMEMES83SCH.readInterfacePost(url,req.toString());
				
				JSONObject results = new JSONObject(retSrcs);
				String statusValue = results.get("statusValue").toString();
				if(statusValue.equals("0")){
				baseBean.writeLog(sql);
				rs.execute(sql);
				}
			}
			else if(cz.equals("1")){
				//最终处理
				String hrmid = request.getLastoperator();
				sql = "select workcode from hrmresource where id = " + hrmid;
				baseBean.writeLog(sql);
				rs.execute(sql);
				if(rs.next()){
					workcode = rs.getString("workcode");
				}
				
				sql = "update STYC_MIDDLE set flag = '200'";
				JSONObject[] updateInfos = new JSONObject[5];
				updateInfos[0] = new JSONObject();
				updateInfos[0].put("updateField", "FLAG");
				updateInfos[0].put("updateValue", "200");
				
				if(!workcode.equals("")){
					sql += ",resv_field1='" + workcode + "'";	
					updateInfos[1] = new JSONObject();
					updateInfos[1].put("updateField", "RESV_FIELD1");
					updateInfos[1].put("updateValue", workcode);
		        }else{
		        	updateInfos[1] = new JSONObject();
					updateInfos[1].put("updateField", "RESV_FIELD1");
					updateInfos[1].put("updateValue", " ");
		        }
				if(!mescz.equals("")){
					sql += ",resv_field2 = '" + mescz + "'";
					updateInfos[2] = new JSONObject();
					updateInfos[2].put("updateField", "RESV_FIELD2");
					updateInfos[2].put("updateValue", mescz);
		        }else{
		        	updateInfos[2] = new JSONObject();
					updateInfos[2].put("updateField", "RESV_FIELD2");
					updateInfos[2].put("updateValue", " ");
		        }
				if(!cz1.equals("")){
					sql += ",resv_field4 = '" + cz1 + "'";
					updateInfos[3] = new JSONObject();
					updateInfos[3].put("updateField", "RESV_FIELD4");
					updateInfos[3].put("updateValue", cz1);
				}else{
		        	updateInfos[3] = new JSONObject(); 
					updateInfos[3].put("updateField", "RESV_FIELD4");
					updateInfos[3].put("updateValue", " ");
		        }
				/*
				if(!tecz.equals("")){
					sql += ",resv_field4 = '" + tecz + "'";	
				}*/
				sql += ",UPDATE_TIME = '" + udpatetime + "' where id = " + id;
				updateInfos[4] = new JSONObject();
				updateInfos[4].put("updateField", "UPDATE_TIME");
				updateInfos[4].put("updateValue", udpatetime);
				message.put("updateInfoList", updateInfos);
				req.put("message", message);
				
				String retSrcs = STMEMES83SCH.readInterfacePost(url,req.toString());
				
				JSONObject results = new JSONObject(retSrcs);
				String statusValue = results.get("statusValue").toString();
				
				if(statusValue.equals("0")){
				baseBean.writeLog(sql);
				rs.execute(sql);
				}
			}
		
		}
		catch(java.lang.Exception e){
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("NFMEMES122501 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

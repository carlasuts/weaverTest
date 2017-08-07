package weaver.interfaces.workflow.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.text.*;
import java.math.*;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

import weaver.conn.*;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.Row;
import weaver.general.BaseBean;

public class HFMEMES66 implements Action {
	
	 private static final String url = "http://172.16.60.96:8099/MesWebService/req";
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			
			String sql = "select TIGGERID,cz1,sfqcqr from formtable_main_9 where requestid = " + request.getRequestid();
			baseBean.writeLog(sql);
			rs.executeSql(sql);
			rs.next();
			String id = rs.getString("TIGGERID");
			String cz1 = rs.getString("cz1");
			String qc = rs.getString("sfqcqr");
			
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

			if(qc.equals("0")){
				//如果需要QC确认且有处理意见
				if(!cz1.equals("")){
					HttpPost request1 = new HttpPost(url);
		            JSONObject req = new JSONObject();
					req.put("fromSystem", "OA");
					req.put("functionName", "MES_UPDATEOATESTYIELDINFO");
					req.put("token", "OATESTTOKEN");
					
			        JSONObject message = new JSONObject();
					message.put("id", id);
					
					sql += "update LLYC_MIDDLE set resv_field4 = '" + cz1 + "',UPDATE_TIME = '" + udpatetime + "' where id = " + id;
					JSONObject[] updateInfos = new JSONObject[2];
					updateInfos[0] = new JSONObject();
					updateInfos[0].put("updateField", "RESV_FIELD4");
					updateInfos[0].put("updateValue", cz1);
					updateInfos[1] = new JSONObject();
					updateInfos[1].put("updateField", "UPDATE_TIME");
					updateInfos[1].put("updateValue", udpatetime);
					message.put("updateInfoList", updateInfos);
					req.put("message", message);
					
					StringEntity se = new StringEntity(req.toString());
					request1.setEntity(se);
					HttpResponse httpResponse = new DefaultHttpClient().execute(request1);
					
					String retSrc = EntityUtils.toString(httpResponse.getEntity());
					
					JSONObject results = new JSONObject(retSrc);
					String statusValue = results.get("statusValue").toString();
					if(statusValue.equals("0")){
					baseBean.writeLog(sql);
					rs.execute(sql);
					}
				}
			}
		}
		catch(java.lang.Exception e){
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTMES66 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

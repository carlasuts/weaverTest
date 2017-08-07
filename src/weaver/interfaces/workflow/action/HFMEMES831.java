package weaver.interfaces.workflow.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.text.*;
import java.math.*;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;
import org.junit.Test;

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

public class HFMEMES831 implements Action {
	
	 private static final String url = "http://172.16.60.96:8099/MesWebService/req";
	public String execute(RequestInfo request) {
        try {
            BaseBean baseBean = new BaseBean();


	        String id = ""; String cz = ""; String mescz = ""; String tecz = "";
	        String sql = "";
	        Property[] properties = request.getMainTableInfo().getProperty();
	        for (int i = 0; i < properties.length; i++) {
	            String name = properties[i].getName().toUpperCase();
	            String value = Util.null2String(properties[i].getValue());
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
				//TE处理结论
				if(name.equals("TECZ")){
					tecz = value;
                }
            }
	        baseBean.writeLog("tecz:" + tecz);
	        if (tecz.length() > 15) {
	            tecz = tecz.substring(0, 15);
	        }
	        baseBean.writeLog("tecz:" + tecz);
	        Date date = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	        String udpatetime = sdf.format(date);
	        String workcode = "";

	        RecordSet rs = new RecordSet();
	        String hrmid = request.getLastoperator();
	        sql = "select workcode from hrmresource where id = " + hrmid;
	        baseBean.writeLog(sql);
	        rs.execute(sql);
	       
	        HttpPost request1 = new HttpPost(url);
            JSONObject req = new JSONObject();
			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPDATEOATESTYIELDINFO");
			req.put("token", "OATESTTOKEN");
			
	        JSONObject message = new JSONObject();
			message.put("id", id);
			
			JSONObject[] updateInfos = new JSONObject[5];
			
	        if (rs.next()) {
	            workcode = rs.getString("workcode");
	        }
	        sql = "update HFYC_MIDDLE set flag = '200'";
	        
			updateInfos[0] = new JSONObject();
			updateInfos[0].put("updateField", "FLAG");
			updateInfos[0].put("updateValue", "200");
	        
	        if (!workcode.equals("")) {
	            sql = sql + ",resv_field1='" + workcode + "'";
				updateInfos[1] = new JSONObject();
				updateInfos[1].put("updateField", "RESV_FIELD1");
				updateInfos[1].put("updateValue", workcode);
	        }else{
	        	updateInfos[1] = new JSONObject();
				updateInfos[1].put("updateField", "RESV_FIELD1");
				updateInfos[1].put("updateValue", " ");
	        }
	        if (!mescz.equals("")) {
	            sql = sql + ",resv_field2 = '" + mescz + "'";
	            updateInfos[2] = new JSONObject();
				updateInfos[2].put("updateField", "RESV_FIELD2");
				updateInfos[2].put("updateValue", mescz);
	        }else{
	        	updateInfos[2] = new JSONObject();
				updateInfos[2].put("updateField", "RESV_FIELD2");
				updateInfos[2].put("updateValue", " ");
	        }
	        if (!tecz.equals("")) {
	            sql = sql + ",resv_field4 = '" + tecz + "'";
	            updateInfos[3] = new JSONObject();
				updateInfos[3].put("updateField", "RESV_FIELD4");
				updateInfos[3].put("updateValue", tecz);
	        }else{
	        	updateInfos[3] = new JSONObject();
				updateInfos[3].put("updateField", "RESV_FIELD4");
				updateInfos[3].put("updateValue", " ");
	        }
	        sql = sql + ",UPDATE_TIME = '" + udpatetime + "' where id = " + id;
            updateInfos[4] = new JSONObject();
			updateInfos[4].put("updateField", "UPDATE_TIME");
			updateInfos[4].put("updateValue", udpatetime);
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
        catch (Exception e) {
            BaseBean baseBean = new BaseBean();
	        baseBean.writeLog("start log");
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("FSTMES831 error:" + e.getMessage());
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("end log");
        }
	    return Action.SUCCESS;
    }
}

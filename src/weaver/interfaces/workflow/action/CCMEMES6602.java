package weaver.interfaces.workflow.action;

import org.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.schedule.CCMEMES83SCH;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

public class CCMEMES6602 implements Action {
	 private static final String url = "http://172.16.60.96:8090/MesWebService/req";
	 public  static final String token ="AWK18VSE25SDNKLS3AET@EWL#LDG*!F";
	public String execute(RequestInfo request) {
        try {
            BaseBean baseBean = new BaseBean();
	        String hjbh=""; String ch=""; String id = "";
	        String sql = "";
	        Property[] properties = request.getMainTableInfo().getProperty();
	        for (int i = 0; i < properties.length; i++) {
	            String name = properties[i].getName().toUpperCase();
	            String value = Util.null2String(properties[i].getValue());
	            //ID
	            if(name.equals("TIGGERID")){
				    id = value;
			    }
				if(name.equals("HJBH")){
					hjbh = value;
				}
				if(name.equals("CH")){
					ch = value;
				}
            }

	       
	        RecordSet rs = new RecordSet();
	        JSONObject req = new JSONObject();
			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPDATEOATESTYIELDINFO");
			req.put("token", token);
	        JSONObject message = new JSONObject();
			message.put("id", id);
			
	        sql = "update LLYC_MIDDLE set ";
			JSONObject[] updateInfos = new JSONObject[2];

	        if(!hjbh.equals("")){
				sql += "resv_field6 = '" + hjbh + "'";
				updateInfos[0] = new JSONObject();
				updateInfos[0].put("updateField", "resv_field6");
				updateInfos[0].put("updateValue", hjbh);
			}else{
				updateInfos[0] = new JSONObject();
				updateInfos[0].put("updateField", "resv_field6");
				updateInfos[0].put("updateValue", " ");
			}
			if(!ch.equals("")){
				sql += ",resv_field7 = '" + ch + "'";
				updateInfos[1] = new JSONObject();
				updateInfos[1].put("updateField", "resv_field7");
				updateInfos[1].put("updateValue", ch);
			}else{
				updateInfos[1] = new JSONObject();
				updateInfos[1].put("updateField", "resv_field7");
				updateInfos[1].put("updateValue", " ");
			}
			sql = sql +  " where id = " + id;
			
			message.put("updateInfoList", updateInfos);
			req.put("message", message);
			
			String retSrcs = CCMEMES83SCH.readInterfacePost(url,req.toString());
			
			JSONObject results = new JSONObject(retSrcs);
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
	        baseBean.writeLog("HFMEMES126502 error:" + e.getMessage());
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("end log");
        }
	    return Action.SUCCESS;
    }
}

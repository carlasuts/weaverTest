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
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

import weaver.conn.*;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.sap.HttpClientJson;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.Row;
import weaver.general.BaseBean;

public class TFMEMES1401_1 implements Action {
	
	 private static final String url = "http://172.22.20.109:8080/MesWebService/reqems";
	
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			
			RecordSet rs = new RecordSet();
			
			String YHNR = "",GOLDENCXZZRY = "",RECIPEID = "",EMSSPECNO = "",JTXH="",JTHM="",OPERATION="",WIRECOUNT="";
			
			String PDXH="",PDSM="",CHOPPERCHECK="",RULE_NAME="",RULE_NAMES="",PADLIMIT="",LEADLIMIT="",DOWNLIMIT="";
			
			String sql = "",PADLIMITDW="",LEADLIMITDW="",DOWNLIMITDW="";
			
			Property[] properties = request.getMainTableInfo().getProperty();// 获取表单主字段信息
			for (int i = 0; i < properties.length; i++) {// 主表数据
				String name = properties[i].getName().toUpperCase();//字段名
				String value = Util.null2String(properties[i].getValue());//值
				if(name.equals("YHNR")){
					YHNR = value;
				}
				if(name.equals("GOLDENCXZZRY")){
					GOLDENCXZZRY = value;
				}
				if(name.equals("RECIPEID")){
					RECIPEID = value;
				}
				if(name.equals("EMSSPECNO")){
					EMSSPECNO = value;
				}
				if(name.equals("JTXH")){
					JTXH = value;
				}
				if(name.equals("JTHM")){
					JTHM = value;
				}
				if(name.equals("OPERATION")){
					OPERATION = value;
				}
				if(name.equals("WIRECOUNT")){
					WIRECOUNT = value;
				}
				if(name.equals("PDXH")){
					PDXH = value;
				}
				if(name.equals("PDSM")){
					PDSM = value;
				}
				if(name.equals("CHOPPERCHECK")){
					CHOPPERCHECK = value;
				}
				if(name.equals("RULE_NAME")){
					RULE_NAME = value;
				}
				if(name.equals("RULE_NAMES")){
					RULE_NAMES = value;
				}
				if(name.equals("PADLIMIT")){
					PADLIMIT = value;
				}
				if(name.equals("LEADLIMIT")){
					LEADLIMIT = value;
				}
				if(name.equals("DOWNLIMIT")){
					DOWNLIMIT = value;
				}
				if(name.equals("PADLIMITDW")){
					PADLIMITDW = value;
				}
				if(name.equals("LEADLIMITDW")){
					LEADLIMITDW = value;
				}
				if(name.equals("DOWNLIMITDW")){
					DOWNLIMITDW = value;
				}
			}
			String description= " ",peId= " ",recipeId= " ",specNo= " ",operation= " ",eqType= " ",eqId= " ",chopper= " ";
			String chopperCheck= " ",commonRuleFlag= " ",specialRuleFlag= " ",padUnit= " ",leadUnit= " ",downUnit = " ";
			int wireCount=0,chopperLife=0,commonRuleSeq=0,specialRuleSeq=0;
			double padTolerance=0,leadTolerance=0,downTolerance=0;
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
			String udpatetime = sdf.format(date);
			String workcode = "";
			//如果是需要TE再处置，插入新表
			
			description ="更新程序";
			
			sql ="select workcode  from hrmresource where id= " + GOLDENCXZZRY;
			rs.executeSql(sql);
			while(rs.next()){
				peId= rs.getString("workcode");
			}
			recipeId =RECIPEID;
			specNo=EMSSPECNO;
			operation =OPERATION;
			eqType =JTXH;
			eqId = JTHM;
			wireCount = Integer.parseInt(WIRECOUNT);
			chopper=PDXH;
			chopperLife = Integer.parseInt("PDSM");
			chopperCheck ="N";
			if(!RULE_NAME.equals("")&& !RULE_NAME.equals(" ") ){
				commonRuleSeq =Integer.parseInt(RULE_NAME);
				
				commonRuleFlag ="Y";
				
			}else{
				commonRuleFlag ="Y";
				
				commonRuleSeq = 0;
			}
			
			
			if(!RULE_NAMES.equals("")&& !RULE_NAMES.equals(" ") ){
				specialRuleSeq =Integer.parseInt(RULE_NAMES);
				
				specialRuleFlag ="Y";
				
			}else{
				specialRuleFlag ="Y";
				
				specialRuleSeq = 0;
			}
			padTolerance = Double.parseDouble(PADLIMIT);
			leadTolerance = Double.parseDouble(LEADLIMIT);
			downTolerance = Double.parseDouble(DOWNLIMIT);
			if(PADLIMITDW=="1"){
				padUnit="";
			}else{
				padUnit="";
			}
			if(LEADLIMITDW=="1"){
				leadUnit="";
			}else{
				leadUnit="";
			}
			if(DOWNLIMITDW=="1"){
				downUnit="";
			}else{
				downUnit="";
			}
			
			
			
			
			
            JSONObject req = new JSONObject();
			req.put("fromSystem", "OA");
			req.put("functionName", "EMS_WBRECIPECONFIRM");
			req.put("token", "OATESTTOKEN");
			
	        JSONObject message = new JSONObject();
			message.put("description", description);
			message.put("peId", peId);
			message.put("recipeId", recipeId);
			message.put("specNo", specNo);
			message.put("operation", operation);
			message.put("eqType", eqType);
			message.put("eqId", eqId);
			
			message.put("wireCount", wireCount);
			
			message.put("chopper", chopper);
			
			message.put("chopperLife", chopperLife);
			
			message.put("chopperCheck", chopperCheck);
			
			message.put("commonRuleFlag", commonRuleFlag);
			
			message.put("commonRuleSeq", commonRuleSeq);
			
			message.put("specialRuleFlag", specialRuleFlag);
			
			message.put("specialRuleSeq", specialRuleSeq);
			
			message.put("padTolerance", padTolerance);
			message.put("leadTolerance", leadTolerance);
			message.put("downTolerance", downTolerance);
			
			message.put("padUnit", padUnit);
			message.put("leadUnit", leadUnit);
			message.put("downUnit", downUnit);

			req.put("message", message);
			String retSrcs = HttpClientJson.readInterfacePost(url,req.toString());
				
			JSONObject results = new JSONObject(retSrcs);
			String statusValue = results.get("statusValue").toString();
			String msg =results.get("msg").toString();
			if(!statusValue.equals("0")){
				//针对节点后附加操作，控制流程流转
		        request.getRequestManager().setMessageid("222222");
		        request.getRequestManager().setMessagecontent("EMS调用失败，请联系管理员:" +msg);
		        baseBean.writeLog("EMS调用失败，请联系管理员");
			}else{
				baseBean.writeLog("TFMEMES1401_1 success");
			}
		}
		catch(java.lang.Exception e){
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("TFMEMES1401_1 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

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

public class TFMEMES1401_2 implements Action {
	
	 private static final String url = "http://172.22.20.109:8080/MesWebService/reqems";
	
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			
			RecordSet rs = new RecordSet();
			
			String YHNR = "",GOLDENCXZZRY_GX = "",CXM_GX = "",JTXH_GX = "",OPERATION_GX="",WIRECOUNT="";
			
			String RULE_NAME="",RULE_NAMES="",PAD_LIMIT="",LEAD_LIMIT="",DOWN_LIMIT="";
			
			String sql = "",PADLIMITDW="",LEADLIMITDW="",DOWNLIMITDW="";
			
			Property[] properties = request.getMainTableInfo().getProperty();// ��ȡ�����ֶ���Ϣ
			for (int i = 0; i < properties.length; i++) {// ��������
				String name = properties[i].getName().toUpperCase();//�ֶ���
				String value = Util.null2String(properties[i].getValue());//ֵ
				//�Ż�����
				if(name.equals("YHNR")){
					YHNR = value;
				}
				//Golden����������Ա:(PE)������limit��		
				if(name.equals("GOLDENCXZZRY_GX")){
					GOLDENCXZZRY_GX = value;
				}
				//������/Recipe ID������limit��	
				if(name.equals("CXM_GX")){
					CXM_GX = value;
				}
				//��̨�ͺţ�������limit��	
				if(name.equals("JTXH_GX")){
					JTXH_GX = value;
				}
				//Operation��������limit��	
				if(name.equals("OPERATION_GX")){
					OPERATION_GX = value;
				}
				//ͨ��Rule������limit��	
				if(name.equals("RULE_NAME")){
					RULE_NAME = value;
				}
				//����Rule������limit��	
				if(name.equals("RULE_NAMES")){
					RULE_NAMES = value;
				}
				//pad limit������limit��	
				if(name.equals("PAD_LIMIT")){
					PAD_LIMIT = value;
				}
				//Lead Limit������limit��	
				if(name.equals("LEAD_LIMIT")){
					LEAD_LIMIT = value;
				}
				//Down Limit������limit��	
				if(name.equals("DOWN_LIMIT")){
					DOWN_LIMIT = value;
				}
				//pad limit ��λ
				if(name.equals("PADLIMITDW")){
					PADLIMITDW = value;
				}
				//Lead Limit��λ
				if(name.equals("LEADLIMITDW")){
					LEADLIMITDW = value;
				}
				//Down Limit��λ
				if(name.equals("DOWNLIMITDW")){
					DOWNLIMITDW = value;
				}
			}
			String description= " ",peId= " ",recipeId= " ",operation= " ",eqType= " ";
			String commonRuleFlag= " ",specialRuleFlag= " ",padUnit= " ",leadUnit= " ",downUnit = " ";
			int commonRuleSeq=0,specialRuleSeq=0;
			double padTolerance=0,leadTolerance=0,downTolerance=0;
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
			String udpatetime = sdf.format(date);
			String workcode = "";
			//�������ҪTE�ٴ��ã������±�
			
			description ="���³���";
			
			sql ="select workcode  from hrmresource where id= " + GOLDENCXZZRY_GX;
			rs.executeSql(sql);
			while(rs.next()){
				peId= rs.getString("workcode");
			}
			recipeId =CXM_GX;
			operation =OPERATION_GX;
			eqType =JTXH_GX;

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
			padTolerance = Double.parseDouble(PAD_LIMIT);
			leadTolerance = Double.parseDouble(LEAD_LIMIT);
			downTolerance = Double.parseDouble(DOWN_LIMIT);
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
			req.put("functionName", "EMS_WBRECIPEUPDATE");
			req.put("token", "OATESTTOKEN");
			
	        JSONObject message = new JSONObject();
			message.put("description", description);
			message.put("peId", peId);
			message.put("recipeId", recipeId);
			message.put("operation", operation);
			message.put("eqType", eqType);

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
				//��Խڵ�󸽼Ӳ���������������ת
		        request.getRequestManager().setMessageid("222222");
		        request.getRequestManager().setMessagecontent("EMS����ʧ�ܣ�����ϵ����Ա:" +msg);
		        baseBean.writeLog("EMS����ʧ�ܣ�����ϵ����Ա");
			}else{
				baseBean.writeLog("TFMEMES1401_2 success");
			}
			
			

		}
		catch(java.lang.Exception e){
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("TFMEMES1401_2 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

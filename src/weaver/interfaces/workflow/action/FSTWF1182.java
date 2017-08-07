package weaver.interfaces.workflow.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.xml.namespace.QName;

import java.text.*;
import java.math.*;

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

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

public class FSTWF1182 implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();
			baseBean.writeLog("FSTWF1182 requestid:" + rid);
			//sql = "select ZBSPR_APPROVAL_BSPR_NO,ZBSPR_APPROVAL_CO_CODE,sapid,R from formtable_main_76 where requestid = " + rid;
			sql = "select ZBSPR_APPROVAL_BSPR_NO,ZBSPR_APPROVAL_CO_CODE,sapid,R from formtable_main_81 where requestid = " + rid;
			baseBean.writeLog("FSTWF1182 sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			String BsprNo = rs.getString("ZBSPR_APPROVAL_BSPR_NO");
			String CoCode = rs.getString("ZBSPR_APPROVAL_CO_CODE");
			String R = Util.null2String(rs.getString("R"));
			String Level = "";
			if(request.getRequestManager().getNodeid() == 2651){
				Level = "01";
			}
			else if(request.getRequestManager().getNodeid() == 2652){
				Level = "02";
			}
			else if(request.getRequestManager().getNodeid() == 2653){
				Level = "03";
			}
			else if(request.getRequestManager().getNodeid() == 2654){
				Level = "04";
			}
			else if(request.getRequestManager().getNodeid() == 2655){
				Level = "05";
			}
			else if(request.getRequestManager().getNodeid() == 2656){
				Level = "06";
			}
			String Status = "";
			String Zsentid = rs.getString("sapid");
			
			//����������˻ػ����ύ
	        String src = request.getRequestManager().getSrc();
	        baseBean.writeLog("FSTWF1182 src:" + src);
	        if(src.equals("submit")){//�ύ����
	        	Status = "A";
	        }
	        else if(src.equals("reject")){//�����˻�
	        	if(R.equals("") || R.equals("1")){
	        		Status = "D";//D��ʾ�����ٴ��ύ	
	        	}
	        	else{
	        		Status = "R";//R��ʾ�������ٴ��ύ	
	        	}
	        }
	        
	        baseBean.writeLog("FSTWF1182 BsprNo:" + BsprNo);
	        baseBean.writeLog("FSTWF1182 CoCode:" + CoCode);
	        baseBean.writeLog("FSTWF1182 Level:" + Level);
	        baseBean.writeLog("FSTWF1182 Status:" + Status);
	        baseBean.writeLog("FSTWF1182 Zsentid:" + Zsentid);
			
			String result = "";
			
			Service service = new Service();  
			Call call = (Call) service.createCall();  
			call.setTargetEndpointAddress(new java.net.URL("http://172.16.60.63:8009/financezf21sap.asmx"));  
			call.setUseSOAPAction(true);  
			call.setReturnType(new QName("http://www.w3.org/2001/XMLSchema","string"));
			call.setOperationName(new QName("http://tempuri.org/", "ZF21SAP"));  
			call.setSOAPActionURI("http://tempuri.org/ZF21SAP");  
	        
	        call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "BsprNo"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "CoCode"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Level"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Status"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zsentid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			
			result = (String)call.invoke(new Object[]{BsprNo, CoCode, Level, Status, Zsentid});
			String err = result;
			baseBean.writeLog("FSTWF1182 sapresult:" + result);
			
			if(result.length() > 0)
				result = result.substring(0, 1);
			//sap����ʧ�ܣ���ֹ��ת
			if(!result.toUpperCase().equals("S")){
				//��Խڵ�󸽼Ӳ���������������ת
		        request.getRequestManager().setMessageid("222222");
		        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա:" + err);
		        baseBean.writeLog("FSTWF1182:SAP����ʧ�ܣ�����ϵ����Ա");
			}
			//������˻صĻ�
			if(Status.equals("R") || Status.equals("D")){
				//sql = "update formtable_main_76 set fqbs = 1 where requestid = " + rid;
				sql = "update formtable_main_81 set fqbs = 1 where requestid = " + rid;//test
				baseBean.writeLog("FSTWF1182 sql:" + sql);
				rs.executeSql(sql);
			}
		}
		catch(java.lang.Exception e){
			request.getRequestManager().setMessageid("222222");
	        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա");
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF1182 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

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

public class FSTWF1181 implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			RecordSet rs1 = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();
			baseBean.writeLog("FSTWF1181 requestid:" + rid);
			//sql = "select ZCHECK1BUKRS,ZCHECK1CNTNR,ZCHECK1GJAHR,sapid,ZCCNFAFA,ZCCNFACCTR,ZCCNFAHOD,R,gs from formtable_main_75 where requestid = " + rid;
			sql = "select ZCHECK1BUKRS,ZCHECK1CNTNR,ZCHECK1GJAHR,sapid,ZCCNFAFA,ZCCNFACCTR,ZCCNFAHOD,R,gs from formtable_main_80 where requestid = " + rid;//test
			baseBean.writeLog("FSTWF1181 sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			String R = Util.null2String(rs.getString("R"));
			String gs = Util.null2String(rs.getString("gs"));
			String Bukrs = rs.getString("ZCHECK1BUKRS");
			String Cntnr = rs.getString("ZCHECK1CNTNR");
			String Gjahr = rs.getString("ZCHECK1GJAHR");
			String Auser = "";
			String Flag = "";//���һ���ڵ�������Y
			if(request.getRequestManager().getNodeid() == 2643){
				//���������Ա
				sql = "select workcode from hrmresource where id = " + rs.getString("ZCCNFAFA");
				baseBean.writeLog("FSTWF1181 sql:" + sql);
				rs1.executeSql(sql);
				rs1.next();
				Auser = rs1.getString("workcode");
			}
			else if(request.getRequestManager().getNodeid() == 2644){
				//�������ľ���
				sql = "select workcode from hrmresource where id = " + rs.getString("ZCCNFACCTR");
				baseBean.writeLog("FSTWF1181 sql:" + sql);
				rs1.executeSql(sql);
				rs1.next();
				Auser = rs1.getString("workcode");
			}
			else if(request.getRequestManager().getNodeid() == 2645){
				//HOD
				sql = "select workcode from hrmresource where id = " + rs.getString("ZCCNFAHOD");
				baseBean.writeLog("FSTWF1181 sql:" + sql);
				rs1.executeSql(sql);
				rs1.next();
				Auser = rs1.getString("workcode");
			}
			else if(request.getRequestManager().getNodeid() == 2647){
				//VP
				if(gs.equals("6100")){
					Auser = "468715";
				}
				else{
					Auser = "443619";	
				}
			}
			else if(request.getRequestManager().getNodeid() == 2648){
				//CEO
				Auser = "000002";
			}
			String Astat = "";
			String Rsnrj = "";//�˻�����
			//����������˻ػ����ύ
			String src = request.getRequestManager().getSrc();
			baseBean.writeLog("FSTWF1181 src:" + src);
			if(src.equals("submit")){//�ύ����
				Astat = "A";
	        }
			else if(src.equals("reject")){//�����˻�
				Astat = "R";
				/*
				if(R.equals("") || R.equals("1")){
					Astat = "D";//D��ʾ�����ٴ��ύ	
	        	}
	        	else{
	        		Astat = "R";//R��ʾ�������ٴ��ύ	
	        	}
	        	*/
				String log = request.getRequestManager().getRemark();
	        	//sql = "select remark from workflow_requestlog where requestid = " + rid + " order by logid desc";
	        	//baseBean.writeLog("FSTWF1181 sql:" + sql);
				//rs.executeSql(sql);
				//rs.next();
				//Rsnrj = rs.getString("remark");
				Rsnrj = log;
	        }
			String Zsentid = rs.getString("sapid");

	        baseBean.writeLog("FSTWF1181 Bukrs:" + Bukrs);
	        baseBean.writeLog("FSTWF1181 Cntnr:" + Cntnr);
	        baseBean.writeLog("FSTWF1181 Gjahr:" + Gjahr);
	        baseBean.writeLog("FSTWF1181 Auser:" + Auser);
	        baseBean.writeLog("FSTWF1181 Flag:" + Flag);
	        baseBean.writeLog("FSTWF1181 Astat:" + Astat);
	        baseBean.writeLog("FSTWF1181 Rsnrj:" + Rsnrj);
	        baseBean.writeLog("FSTWF1181 Zsentid:" + Zsentid);
			
			String result = "";
			
			Service service = new Service(); 
			Call call = (Call) service.createCall();  
			call.setTargetEndpointAddress(new java.net.URL("http://172.16.60.63:8009/financezf01sap.asmx"));  
			call.setUseSOAPAction(true);  
			call.setReturnType(new QName("http://www.w3.org/2001/XMLSchema","string"));
			call.setOperationName(new QName("http://tempuri.org/", "ZF01SAP"));  
			call.setSOAPActionURI("http://tempuri.org/ZF01SAP");  
	        
	        call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Bukrs"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Cntnr"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Gjahr"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Auser"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Flag"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Astat"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Rsnrj"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zsentid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			
			result = (String)call.invoke(new Object[]{Bukrs, Cntnr, Gjahr, Auser, Flag, Astat, Rsnrj, Zsentid});
			String err = result;
			baseBean.writeLog("FSTWF1181 sapresult:" + result);
			
			if(result.length() > 0)
				result = result.substring(0, 1);
			//sap����ʧ�ܣ���ֹ��ת
			if(!result.toUpperCase().equals("S")){
				//��Խڵ�󸽼Ӳ���������������ת
		        request.getRequestManager().setMessageid("222222");
		        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա:" + err);
		        baseBean.writeLog("FSTWF1181:SAP����ʧ�ܣ�����ϵ����Ա");
			}
			//������˻صĻ�
			if(Astat.equals("R")){
				//sql = "update formtable_main_75 set fqbs = 1 where requestid = " + rid;
				sql = "update formtable_main_80 set fqbs = 1 where requestid = " + rid;//test
				baseBean.writeLog("FSTWF1181 sql:" + sql);
				rs.executeSql(sql);
			}
		}
		catch(java.lang.Exception e){
			request.getRequestManager().setMessageid("222222");
	        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա");
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF1181 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

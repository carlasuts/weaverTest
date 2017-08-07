package weaver.interfaces.workflow.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Hashtable;
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
import weaver.system.WrokflowOverTimeTimer;
import weaver.general.BaseBean;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

//Ԥ����������
public class FSTWF881A implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();
			baseBean.writeLog("FSTWF881A requestid:" + rid);
			sql = "select ProjectDefinition,wbs,sapid,qzyj,thlx from formtable_main_62 where requestid = " + rid;
			baseBean.writeLog("FSTWF881A sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			String Pspid = rs.getString("ProjectDefinition");//Pspid
			String Posid = rs.getString("wbs");//POSID
			String Zsentid = rs.getString("sapid");//Zsentid
			String ZAppComments = rs.getString("qzyj");//�������
			String thlx = Util.null2String(rs.getString("thlx"));//�˻�����
			String ZAppDate = request.getRequestManager().getCurrentDate().replaceAll("-", "");//��������
			String ZAppTime = request.getRequestManager().getCurrentTime().replaceAll(":", "");//����ʱ��
			String ZAppPerson = "";//������
			String ZFinalIndex = "";//�������
			String ZPosidApproval = "";// Y / R / D  /B
					
			String last = request.getLastoperator();
			sql = "select workcode from hrmresource where id = " + last;
			baseBean.writeLog("FSTWF881A sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			ZAppPerson = rs.getString("workcode");
			
			//����������˻ػ����ύ
	        String src = request.getRequestManager().getSrc();
	        baseBean.writeLog("FSTWF881A src:" + src);
	        if(src.equals("submit")){//�ύ����
	        	ZPosidApproval = "Y";//Y/B(Y:��һ���ύok���ڶ����ύ)
	        }else if(src.equals("reject")){//�����˻�
	        	//ZPosidApproval = "R";//R/D(R:SAP�����ٷ����ˣ�D:SAP�����ٴη���)
	        	if(thlx.equals("") || thlx.equals("0")){
	        		ZPosidApproval = "D";
	        	}
	        	else if(thlx.equals("1")){
	        		ZPosidApproval = "R";
	        	}
	        }
	        
	        baseBean.writeLog("FSTWF881A Pspid:" + Pspid);
	        baseBean.writeLog("FSTWF881A Posid:" + Posid);
	        baseBean.writeLog("FSTWF881A Zsentid:" + Zsentid);
	        baseBean.writeLog("FSTWF881A ZAppComments:" + ZAppComments);
	        baseBean.writeLog("FSTWF881A ZAppDate:" + ZAppDate);
	        baseBean.writeLog("FSTWF881A ZAppTime:" + ZAppTime);
	        baseBean.writeLog("FSTWF881A ZAppPerson:" + ZAppPerson);
	        baseBean.writeLog("FSTWF881A ZFinalIndex:" + ZFinalIndex);
	        baseBean.writeLog("FSTWF881A ZPosidApproval:" + ZPosidApproval);
	        
	        String result = "";
	        Service service = new Service();  
			Call call = (Call) service.createCall();  
			call.setTargetEndpointAddress(new java.net.URL("http://172.16.60.18:8009/financebudgetsap.asmx"));  
			call.setUseSOAPAction(true);  
			call.setReturnType(new QName("http://www.w3.org/2001/XMLSchema","string"));
			//call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
			call.setOperationName(new QName("http://tempuri.org/", "BUDGETSAP"));  
			call.setSOAPActionURI("http://tempuri.org/BUDGETSAP");  
	        
	        call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Posid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Pspid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZAppComments"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZAppDate"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZAppPerson"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZAppTime"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZFinalIndex"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZPosidApproval"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zsentid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			
			
			ZFinalIndex = "X";
			result = (String)call.invoke(new Object[]{Posid, Pspid, ZAppComments, ZAppDate,ZAppPerson,ZAppTime,ZFinalIndex,ZPosidApproval,Zsentid});
			String err = result;
			baseBean.writeLog("FSTWF881A sapresult:" + result);
			if(result.length() > 0)
				result = result.substring(0, 1);
			if(!result.toUpperCase().equals("S")){
				//��Խڵ�󸽼Ӳ���������������ת
		        request.getRequestManager().setMessageid("222222");
		        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա:" + err);
		        baseBean.writeLog("FSTWF881A:SAP����ʧ�ܣ�����ϵ����Ա");
		        
		        sql = "update formtable_main_62 set SAPfh = 1,zzspr = " + last + " where requestid = " + rid;
		        baseBean.writeLog("FSTWF881A sql:" + sql);
				rs.executeSql(sql);
			}
			else {
				sql = "update formtable_main_62 set SAPfh = 0,zzspr = " + last + " where requestid = " + rid;
		        baseBean.writeLog("FSTWF881A sql:" + sql);
				rs.executeSql(sql);
				//��ת����һ�ڵ�
				//WrokflowOverTimeTimer wt = new WrokflowOverTimeTimer();
				//wt.autoFLowNextNode(Integer.parseInt(rid));
				baseBean.writeLog("FSTWF881A OK");
			}
		}
		catch(java.lang.Exception e){
			request.getRequestManager().setMessageid("222222");
	        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա");
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF881A error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

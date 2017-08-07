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

//�̶��ʲ�����
public class FSTWF861A implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();
			baseBean.writeLog("FSTWF861A requestid:" + rid);
			sql = "select EWARNumber,sapid from formtable_main_61 where requestid = " + rid;
			baseBean.writeLog("FSTWF861A sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			String EWARNumber = rs.getString("EWARNumber");//EWARNumber
			String Zsentid = rs.getString("sapid");//
			String status = "";
			String Zzaddapr = "";//���������
			String last = request.getLastoperator();
			sql = "select workcode from hrmresource where id = " + last;
			baseBean.writeLog("FSTWF861A sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			Zzaddapr = rs.getString("workcode");
			
			//����������˻ػ����ύ
	        String src = request.getRequestManager().getSrc();
	        baseBean.writeLog("FSTWF861A src:" + src);
	        if(src.equals("submit")){//�ύ����
	        	status = "S";
	        }else if(src.equals("reject")){//�����˻�
	        	status = "E";
	        }
	        
	        baseBean.writeLog("FSTWF861A EWARNumber:" + EWARNumber);
	        baseBean.writeLog("FSTWF861A Zsentid:" + Zsentid);
	        baseBean.writeLog("FSTWF861A status:" + status);
	        baseBean.writeLog("FSTWF861A Zzaddapr:" + Zzaddapr);
	        
	        String result = "";
	        Service service = new Service();  
			Call call = (Call) service.createCall();  
			call.setTargetEndpointAddress(new java.net.URL("http://172.16.60.18:8009/financeassetsap.asmx"));  
			call.setUseSOAPAction(true);  
			call.setReturnType(new QName("http://www.w3.org/2001/XMLSchema","string"));
			//call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
			call.setOperationName(new QName("http://tempuri.org/", "ASSETSAP"));  
			call.setSOAPActionURI("http://tempuri.org/ASSETSAP");  
	        
	        call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "EawrNumber"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zsentid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Status"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zzaddapr"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			
			result = (String)call.invoke(new Object[]{EWARNumber, Zsentid, status, Zzaddapr});
			String err = result;
			baseBean.writeLog("FSTWF861A sapresult:" + result);
			if(result.length() > 0)
				result = result.substring(0, 1);
			if(!result.toUpperCase().equals("S")){
				//��Խڵ�󸽼Ӳ���������������ת
		        request.getRequestManager().setMessageid("222222");
		        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա:" + err);
		        baseBean.writeLog("FSTWF861A:SAP����ʧ�ܣ�����ϵ����Ա");
		        
		        sql = "update formtable_main_61 set SAPfh = 1,zzspr = " + last + " where requestid = " + rid;
		        baseBean.writeLog("FSTWF861A sql:" + sql);
				rs.executeSql(sql);
			}
			else {
				sql = "update formtable_main_61 set SAPfh = 0 where requestid = " + rid;
		        baseBean.writeLog("FSTWF861A sql:" + sql);
				rs.executeSql(sql);
				baseBean.writeLog("FSTWF861A OK");
			}
		}
		catch(java.lang.Exception e){
			request.getRequestManager().setMessageid("222222");
	        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա");
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF861A error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

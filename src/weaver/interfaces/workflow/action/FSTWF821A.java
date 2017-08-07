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

//ƾ֤��������
public class FSTWF821A implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();
			baseBean.writeLog("FSTWF821A requestid:" + rid);
			sql = "select DocumentNumber,PostingDate,CompanyCode,sapid from formtable_main_59 where requestid = " + rid;
			baseBean.writeLog("FSTWF821A sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			String Belnr = rs.getString("DocumentNumber");//���ݺ�
			String Gjahr = rs.getString("PostingDate").substring(0, 4);//���
			String Bukrs = rs.getString("CompanyCode");//��˾����
			String Zsentid = rs.getString("sapid");//
			String status = "";
			String Zzaddapr = "";//���������
			String last = request.getLastoperator();
			sql = "select workcode from hrmresource where id = " + last;
			baseBean.writeLog("FSTWF821 sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			Zzaddapr = rs.getString("workcode");
			
			//����������˻ػ����ύ
	        String src = request.getRequestManager().getSrc();
	        baseBean.writeLog("FSTWF821 src:" + src);
	        if(src.equals("submit")){//�ύ����
	        	status = "S";
	        }else if(src.equals("reject")){//�����˻�
	        	status = "E";
	        }
	        
	        baseBean.writeLog("FSTWF821A Belnr:" + Belnr);
	        baseBean.writeLog("FSTWF821A Gjahr:" + Gjahr);
	        baseBean.writeLog("FSTWF821A Bukrs:" + Bukrs);
	        baseBean.writeLog("FSTWF821A Zsentid:" + Zsentid);
	        baseBean.writeLog("FSTWF821A status:" + status);
	        baseBean.writeLog("FSTWF821A Zzaddapr:" + Zzaddapr);
	        
	        String result = "";
	        Service service = new Service();  
			Call call = (Call) service.createCall();  
			call.setTargetEndpointAddress(new java.net.URL("http://172.16.60.18:8009/financevouchersap.asmx"));  
			call.setUseSOAPAction(true);  
			call.setReturnType(new QName("http://www.w3.org/2001/XMLSchema","string"));
			//call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
			call.setOperationName(new QName("http://tempuri.org/", "VOUCHERSAP"));  
			call.setSOAPActionURI("http://tempuri.org/VOUCHERSAP");  
	        
	        call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Belnr"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Gjahr"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Bukrs"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zsentid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Status"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zzaddapr"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			
			result = (String)call.invoke(new Object[]{Belnr, Gjahr, Bukrs, Zsentid, status, Zzaddapr});
			String err = result;
			baseBean.writeLog("FSTWF821A sapresult:" + result);
			if(result.length() > 0)
				result = result.substring(0, 1);
			if(!result.toUpperCase().equals("S")){
				//��Խڵ�󸽼Ӳ���������������ת
			    request.getRequestManager().setMessageid("222222");
			    request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա:" + err);
			    baseBean.writeLog("FSTWF821A:SAP����ʧ�ܣ�����ϵ����Ա");
				
			    sql = "update formtable_main_59 set SAPfh = 1,zzspr = " + last + " where requestid = " + rid;
			    baseBean.writeLog("FSTWF821A sql:" + sql);
				rs.executeSql(sql);
			}
			else {
				sql = "update formtable_main_59 set SAPfh = 0 where requestid = " + rid;
		        baseBean.writeLog("FSTWF821A sql:" + sql);
				rs.executeSql(sql);
				baseBean.writeLog("FSTWF821A OK");
			}
		}
		catch(java.lang.Exception e){
			request.getRequestManager().setMessageid("222222");
	        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա");
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF821A error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

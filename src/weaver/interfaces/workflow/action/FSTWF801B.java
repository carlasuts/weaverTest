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

//TF-AMD�ɹ�����(�ڵ��)
public class FSTWF801B implements Action {
	public String execute(RequestInfo request) {
		String result = "";
		BaseBean baseBean = new BaseBean();
		try {
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();
			baseBean.writeLog("FSTWF801B requestid:" + rid);
			sql = "select cgddh,sapid,SAPfh from formtable_main_58 where requestid = " + rid;
			baseBean.writeLog("FSTWF801B sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			String ebeln = rs.getString("cgddh");
			String zposid = rs.getString("sapid");
			String SAPfh = rs.getString("SAPfh");//SAP�ڵ�ǰ���Ӳ����Ƿ�ɹ�
			String status = "";
			//����������˻ػ����ύ
	        String src = request.getRequestManager().getSrc();
	        baseBean.writeLog("FSTWF801B src:" + src);
	        if(src.equals("submit")){//�ύ����
	        	status = "S";
	        }else if(src.equals("reject")){//�����˻�
	        	status = "E";
	        }
	        
	        baseBean.writeLog("FSTWF801B ebeln:" + ebeln);
	        baseBean.writeLog("FSTWF801B zprsid:" + zposid);
	        baseBean.writeLog("FSTWF801B status:" + status);
	        baseBean.writeLog("FSTWF801B SAPfh:" + SAPfh);
	        
	        Service service = new Service();  
			Call call = (Call) service.createCall();  
			call.setTargetEndpointAddress(new java.net.URL("http://172.16.60.18:8009/purchaseposap.asmx"));  
			call.setUseSOAPAction(true);  
			call.setReturnType(new QName("http://www.w3.org/2001/XMLSchema","string"));
			//call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
			call.setOperationName(new QName("http://tempuri.org/", "POSAP"));  
			call.setSOAPActionURI("http://tempuri.org/POSAP");  
	        
	        call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Ebeln"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zposid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Status"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			
			//����ڵ�ǰʧ���ˣ������ٴ��ύ
			if(SAPfh.equals("1")){
				result = (String)call.invoke(new Object[]{ebeln, zposid, status});
				String err = result;
				baseBean.writeLog("FSTWF801B sapresult:" + result);
				
				if(result.length() > 0)
					result = result.substring(0, 1);
				//sap����ʧ�ܣ���ֹ��ת
				if(!result.toUpperCase().equals("S")){
					//��Խڵ�󸽼Ӳ���������������ת
			        request.getRequestManager().setMessageid("222222");
			        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա:" + err);
			        baseBean.writeLog("FSTWF801B:SAP����ʧ�ܣ�����ϵ����Ա");
			        
			        sql = "update formtable_main_58 set SAPfh = 1 where requestid = " + rid;
			        baseBean.writeLog("FSTWF801B sql:" + sql);
					rs.executeSql(sql);
				}
				else{
					sql = "update formtable_main_58 set SAPfh = 0 where requestid = " + rid;
			        baseBean.writeLog("FSTWF801B sql:" + sql);
					rs.executeSql(sql);
				}
			}
		}
		catch(java.lang.Exception e){
			request.getRequestManager().setMessageid("222222");
	        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա");
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF801B error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

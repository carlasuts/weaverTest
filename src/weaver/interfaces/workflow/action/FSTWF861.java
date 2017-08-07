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
import weaver.general.BaseBean;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

//固定资产流程
public class FSTWF861 implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();
			baseBean.writeLog("FSTWF861 requestid:" + rid);
			sql = "select EWARNumber, sapid from formtable_main_61 where requestid = " + rid;
			baseBean.writeLog("FSTWF861 sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			String EWARNumber = rs.getString("EWARNumber");//EWARNumber
			String Zsentid = rs.getString("sapid");//
			String status = "";
			String Zzaddapr = "";//最后审批人
			String last = request.getLastoperator();
			sql = "select workcode from hrmresource where id = " + last;
			baseBean.writeLog("FSTWF861 sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			Zzaddapr = rs.getString("workcode");
			
			//获得流程是退回还是提交
	        String src = request.getRequestManager().getSrc();
	        baseBean.writeLog("FSTWF861 src:" + src);
	        if(src.equals("submit")){//提交流程
	        	status = "S";
	        }else if(src.equals("reject")){//流程退回
	        	status = "E";
	        }
	        //status = "S";
	        baseBean.writeLog("FSTWF861 EWARNumber:" + EWARNumber);
	        baseBean.writeLog("FSTWF861 Zsentid:" + Zsentid);
	        baseBean.writeLog("FSTWF861 status:" + status);
	        baseBean.writeLog("FSTWF861 Zzaddapr:" + Zzaddapr);
			
			//退回
	        String result = "";
			if(status.equals("E")){
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
				baseBean.writeLog("FSTWF861 sapresult:" + result);
				if(result.length() > 0)
					result = result.substring(0, 1);
				//sap调用失败，阻止流转
				if(!result.toUpperCase().equals("S")){
					//针对节点后附加操作，控制流程流转
			        request.getRequestManager().setMessageid("222222");
			        request.getRequestManager().setMessagecontent("SAP调用失败，请联系管理员:" + err);
			        baseBean.writeLog("FSTWF861:SAP调用失败，请联系管理员");
				}
				
				sql = "update formtable_main_61 set fqbs = 1 where requestid = " + rid;
				baseBean.writeLog("FSTWF861 sql:" + sql);
				rs.executeSql(sql);
			}
		}
		catch(java.lang.Exception e){
			request.getRequestManager().setMessageid("222222");
	        request.getRequestManager().setMessagecontent("SAP调用失败，请联系管理员");
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF861 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

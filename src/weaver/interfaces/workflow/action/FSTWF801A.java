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
import weaver.system.WrokflowOverTimeTimer;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

//TF-AMD采购订单(节点前)
public class FSTWF801A implements Action {
	public String execute(RequestInfo request) {
		BaseBean baseBean = new BaseBean();
		try {
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();
			baseBean.writeLog("FSTWF801A requestid:" + rid);
			sql = "select cgddh,sapid from formtable_main_58 where requestid = " + rid;
			baseBean.writeLog("FSTWF801A sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			String ebeln = rs.getString("cgddh");
			String zposid = rs.getString("sapid");
			String status = "";
			//获得流程是退回还是提交
	        String src = request.getRequestManager().getSrc();
	        baseBean.writeLog("FSTWF801A src:" + src);
	        if(src.equals("submit")){//提交流程
	        	status = "S";
	        }else if(src.equals("reject")){//流程退回
	        	status = "E";
	        }
	        
	        baseBean.writeLog("FSTWF801A ebeln:" + ebeln);
	        baseBean.writeLog("FSTWF801A zprsid:" + zposid);
	        baseBean.writeLog("FSTWF801A status:" + status);
			
	        String result = "";
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

			result = (String)call.invoke(new Object[]{ebeln, zposid, status});
			String err = result;
			baseBean.writeLog("FSTWF801A sapresult:" + result);
			
			if(result.length() > 0)
				result = result.substring(0, 1);
			
			if(!result.toUpperCase().equals("S")){
				//针对节点后附加操作，控制流程流转
		        request.getRequestManager().setMessageid("222222");
		        request.getRequestManager().setMessagecontent("SAP调用失败，请联系管理员:" + err);
		        baseBean.writeLog("FSTWF801A:SAP调用失败，请联系管理员");
		        
		        sql = "update formtable_main_58 set SAPfh = 1 where requestid = " + rid;
		        baseBean.writeLog("FSTWF801A sql:" + sql);
				rs.executeSql(sql);
			}
			else{
				sql = "update formtable_main_58 set SAPfh = 0 where requestid = " + rid;
		        baseBean.writeLog("FSTWF801A sql:" + sql);
				rs.executeSql(sql);
				//流转到下一节点
				//WrokflowOverTimeTimer wt = new WrokflowOverTimeTimer();
				//wt.autoFLowNextNode(Integer.parseInt(rid));
				baseBean.writeLog("FSTWF801A OK");
			}
		}
		catch(java.lang.Exception e){
			request.getRequestManager().setMessageid("222222");
	        request.getRequestManager().setMessagecontent("SAP调用失败，请联系管理员");
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF801A error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

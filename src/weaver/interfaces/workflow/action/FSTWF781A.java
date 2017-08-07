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
import weaver.system.WrokflowOverTimeTimer;
import weaver.general.BaseBean;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

//TF-AMD采购申请
public class FSTWF781A implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();
			baseBean.writeLog("FSTWF781A requestid:" + rid);
			sql = "select cgsqdh,sapid from formtable_main_57 where requestid = " + rid;
			baseBean.writeLog("FSTWF781A sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			String banfn = rs.getString("cgsqdh");
			String zprsid = rs.getString("sapid");
			String status = "";
			//获得流程是退回还是提交
	        String src = request.getRequestManager().getSrc();
	        baseBean.writeLog("FSTWF781A src:" + src);
	        if(src.equals("submit")){//提交流程
	        	status = "S";
	        }else if(src.equals("reject")){//流程退回
	        	status = "E";
	        }
	        
	        baseBean.writeLog("FSTWF781A banfn:" + banfn);
	        baseBean.writeLog("FSTWF781A zprsid:" + zprsid);
	        baseBean.writeLog("FSTWF781A status:" + status);
	        
	        String result = "";
	        Service service = new Service();  
			Call call = (Call) service.createCall();  
			call.setTargetEndpointAddress(new java.net.URL("http://172.16.60.18:8009/purchaseprsap.asmx"));  
			call.setUseSOAPAction(true);  
			call.setReturnType(new QName("http://www.w3.org/2001/XMLSchema","string"));
			//call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
			call.setOperationName(new QName("http://tempuri.org/", "PRSAP"));  
			call.setSOAPActionURI("http://tempuri.org/PRSAP");  
	        
	        call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Banfn"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zprsid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Status"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			
			result = (String)call.invoke(new Object[]{banfn, zprsid, status});
			String err = result;
			baseBean.writeLog("FSTWF781A sapresult:" + result);
			
			if(result.length() > 0)
				result = result.substring(0, 1);
			if(!result.toUpperCase().equals("S")){
				//针对节点后附加操作，控制流程流转
			    request.getRequestManager().setMessageid("222222");
			    request.getRequestManager().setMessagecontent("SAP调用失败，请联系管理员:" + err);
			    baseBean.writeLog("FSTWF781A:SAP调用失败，请联系管理员");
			    
			    sql = "update formtable_main_57 set SAPfh = 1 where requestid = " + rid;
		        baseBean.writeLog("FSTWF781A sql:" + sql);
				rs.executeSql(sql);
			}
			else {
				sql = "update formtable_main_57 set SAPfh = 0 where requestid = " + rid;
		        baseBean.writeLog("FSTWF781A sql:" + sql);
				rs.executeSql(sql);
				baseBean.writeLog("FSTWF781A OK");
			}
		}
		catch(java.lang.Exception e){
			request.getRequestManager().setMessageid("222222");
	        request.getRequestManager().setMessagecontent("SAP调用失败，请联系管理员");
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF781A error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

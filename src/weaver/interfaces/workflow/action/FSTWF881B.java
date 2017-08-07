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

//预算审批流程
public class FSTWF881B implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();
			baseBean.writeLog("FSTWF881B requestid:" + rid);
			sql = "select ProjectDefinition,wbs,sapid,qzyj，SAPfh,zzspr,thlx from formtable_main_62 where requestid = " + rid;
			baseBean.writeLog("FSTWF881B sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			String Pspid = rs.getString("ProjectDefinition");//Pspid
			String Posid = rs.getString("wbs");//POSID
			String Zsentid = rs.getString("sapid");//Zsentid
			String ZAppComments = rs.getString("qzyj");//审批意见
			String thlx = Util.null2String(rs.getString("thlx"));//退回类型
			String ZAppDate = request.getRequestManager().getCurrentDate().replaceAll("-", "");//审批日期
			String ZAppTime = request.getRequestManager().getCurrentTime().replaceAll(":", "");//审批时间
			String ZAppPerson = rs.getString("zzspr");//审批人
			String ZFinalIndex = "";//最终意见
			String ZPosidApproval = "";// Y / R / D  /B
			String SAPfh = rs.getString("SAPfh");//SAP节点前附加操作是否成功
			
			//获得流程是退回还是提交
	        String src = request.getRequestManager().getSrc();
	        baseBean.writeLog("FSTWF881 src:" + src);
	        if(src.equals("submit")){//提交流程
	        	ZPosidApproval = "Y";
	        }else if(src.equals("reject")){//流程退回
	        	//ZPosidApproval = "R";
	        	if(thlx.equals("") || thlx.equals("0")){
	        		ZPosidApproval = "D";
	        	}
	        	else if(thlx.equals("1")){
	        		ZPosidApproval = "R";
	        	}
	        }
	        //ZPosidApproval = "Y";
	        baseBean.writeLog("FSTWF881B Pspid:" + Pspid);
	        baseBean.writeLog("FSTWF881B Posid:" + Posid);
	        baseBean.writeLog("FSTWF881B Zsentid:" + Zsentid);
	        baseBean.writeLog("FSTWF881B ZAppComments:" + ZAppComments);
	        baseBean.writeLog("FSTWF881B ZAppDate:" + ZAppDate);
	        baseBean.writeLog("FSTWF881B ZAppTime:" + ZAppTime);
	        baseBean.writeLog("FSTWF881B ZAppPerson:" + ZAppPerson);
	        baseBean.writeLog("FSTWF881B ZFinalIndex:" + ZFinalIndex);
	        baseBean.writeLog("FSTWF881B ZPosidApproval:" + ZPosidApproval);
	        baseBean.writeLog("FSTWF881B SAPfh:" + SAPfh);
	        
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
			
			String result = "";
			//如果节点前失败了，现在再次提交
			if(SAPfh.equals("1")){
				ZFinalIndex = "X";
				result = (String)call.invoke(new Object[]{Posid, Pspid, ZAppComments, ZAppDate,ZAppPerson,ZAppTime,ZFinalIndex,ZPosidApproval,Zsentid});
				String err = result;
				baseBean.writeLog("FSTWF881B sapresult:" + result);
				if(result.length() > 0)
					result = result.substring(0, 1);
				//sap调用失败，阻止流转
				if(!result.toUpperCase().equals("S")){
					//针对节点后附加操作，控制流程流转
			        request.getRequestManager().setMessageid("222222");
			        request.getRequestManager().setMessagecontent("SAP调用失败，请联系管理员:" + err);
			        baseBean.writeLog("FSTWF881B:SAP调用失败，请联系管理员");
			        
			        sql = "update formtable_main_62 set SAPfh = 1 where requestid = " + rid;
			        baseBean.writeLog("FSTWF881B sql:" + sql);
					rs.executeSql(sql);
				}
				else{
					sql = "update formtable_main_62 set SAPfh = 0 where requestid = " + rid;
			        baseBean.writeLog("FSTWF881B sql:" + sql);
					rs.executeSql(sql);
					
					//二次调用分配
					Service service1 = new Service();  
					Call call1 = (Call) service1.createCall();  
					call1.setTargetEndpointAddress(new java.net.URL("http://172.16.60.18:8009/financebudgetsap.asmx"));  
					call1.setUseSOAPAction(true);  
					call1.setReturnType(new QName("http://www.w3.org/2001/XMLSchema","string"));
					call1.setOperationName(new QName("http://tempuri.org/", "BUDGETSAP"));  
					call1.setSOAPActionURI("http://tempuri.org/BUDGETSAP");  
					ZPosidApproval = "B";//二次提交
					baseBean.writeLog("FSTWF881BB ZPosidApproval:" + ZPosidApproval);
					call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Posid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
					call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Pspid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
					call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZAppComments"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
					call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZAppDate"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
					call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZAppPerson"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
					call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZAppTime"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
					call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZFinalIndex"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
					call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZPosidApproval"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
					call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zsentid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
					result = (String)call1.invoke(new Object[]{Posid, Pspid, ZAppComments, ZAppDate,ZAppPerson,ZAppTime,ZFinalIndex,ZPosidApproval,Zsentid});
					err = result;
					baseBean.writeLog("FSTWF881AA sapresult:" + result);
					if(result.length() > 0)
						result = result.substring(0, 1);
					if(!result.toUpperCase().equals("S")){
						//针对节点后附加操作，控制流程流转
				        request.getRequestManager().setMessageid("222222");
				        request.getRequestManager().setMessagecontent("SAP二次调用失败，请联系管理员:" + err);
				        baseBean.writeLog("FSTWF881CC:SAP调用失败，请联系管理员");
					}
					baseBean.writeLog("FSTWF881CC OK");
				}
			}
			else{
				//二次调用分配
				Service service1 = new Service();  
				Call call1 = (Call) service1.createCall();  
				call1.setTargetEndpointAddress(new java.net.URL("http://172.16.60.18:8009/financebudgetsap.asmx"));  
				call1.setUseSOAPAction(true);  
				call1.setReturnType(new QName("http://www.w3.org/2001/XMLSchema","string"));
				call1.setOperationName(new QName("http://tempuri.org/", "BUDGETSAP"));  
				call1.setSOAPActionURI("http://tempuri.org/BUDGETSAP");  
				ZPosidApproval = "B";//二次提交
				baseBean.writeLog("FSTWF881BB ZPosidApproval:" + ZPosidApproval);
				call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Posid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Pspid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZAppComments"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZAppDate"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZAppPerson"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZAppTime"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZFinalIndex"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "ZPosidApproval"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				call1.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zsentid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
				result = (String)call1.invoke(new Object[]{Posid, Pspid, ZAppComments, ZAppDate,ZAppPerson,ZAppTime,ZFinalIndex,ZPosidApproval,Zsentid});
				String err = result;
				baseBean.writeLog("FSTWF881BB sapresult:" + result);
				if(result.length() > 0)
					result = result.substring(0, 1);
				if(!result.toUpperCase().equals("S")){
					//针对节点后附加操作，控制流程流转
			        request.getRequestManager().setMessageid("222222");
			        request.getRequestManager().setMessagecontent("SAP二次调用失败，请联系管理员:" + err);
			        baseBean.writeLog("FSTWF881BB:SAP调用失败，请联系管理员");
				}
				baseBean.writeLog("FSTWF881BB OK");
			}
		}
		catch(java.lang.Exception e){
			request.getRequestManager().setMessageid("222222");
	        request.getRequestManager().setMessagecontent("SAP调用失败，请联系管理员");
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF881B error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

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

//发票审批流程
public class FSTWF882B implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();
			baseBean.writeLog("FSTWF882B requestid:" + rid);
			sql = "select Rbkpbelnr,Rbkpbukrs,Rbkpgjahr,sapid,SAPfh,zzspr from formtable_main_63 where requestid = " + rid;
			baseBean.writeLog("FSTWF882B sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			String Rbkpbelnr = rs.getString("Rbkpbelnr");//发票凭证
			String Rbkpbukrs = rs.getString("Rbkpbukrs");//公司代码
			String Rbkpgjahr = rs.getString("Rbkpgjahr");//会计年度
			String Zsentid = rs.getString("sapid");//
			String status = "";
			String Zzaddapr = "";//最后审批人
			String SAPfh = rs.getString("SAPfh");//SAP节点前附加操作是否成功
			String last = request.getLastoperator();
			last = rs.getString("zzspr");
			sql = "select workcode from hrmresource where id = " + last;
			baseBean.writeLog("FSTWF882B sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			Zzaddapr = rs.getString("workcode");
			
			//获得流程是退回还是提交
	        String src = request.getRequestManager().getSrc();
	        baseBean.writeLog("FSTWF882B src:" + src);
	        if(src.equals("submit")){//提交流程
	        	status = "S";
	        }else if(src.equals("reject")){//流程退回
	        	status = "E";
	        }
	        //status = "S";
	        baseBean.writeLog("FSTWF882B Rbkpbelnr:" + Rbkpbelnr);
	        baseBean.writeLog("FSTWF882B Rbkpbukrs:" + Rbkpbukrs);
	        baseBean.writeLog("FSTWF882B Rbkpgjahr:" + Rbkpgjahr);
	        baseBean.writeLog("FSTWF882B Zsentid:" + Zsentid);
	        baseBean.writeLog("FSTWF882B status:" + status);
	        baseBean.writeLog("FSTWF882B Zzaddapr:" + Zzaddapr);
	        baseBean.writeLog("FSTWF882B SAPfh:" + SAPfh);
	        
	        Service service = new Service();  
			Call call = (Call) service.createCall();  
			call.setTargetEndpointAddress(new java.net.URL("http://172.16.60.18:8009/financeinvoicesap.asmx"));  
			call.setUseSOAPAction(true);  
			call.setReturnType(new QName("http://www.w3.org/2001/XMLSchema","string"));
			//call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
			call.setOperationName(new QName("http://tempuri.org/", "INVOICESAP"));  
			call.setSOAPActionURI("http://tempuri.org/INVOICESAP");  
	        
	        call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Rbkpbelnr"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Rbkpbukrs"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Rbkpgjahr"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zsentid"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Status"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			call.addParameter(new javax.xml.namespace.QName("http://tempuri.org/", "Zzaddapr"),org.apache.axis.encoding.XMLType.XSD_STRING,javax.xml.rpc.ParameterMode.IN);
			
			String result = "";
			//如果节点前失败了，现在再次提交
			if(SAPfh.equals("1")){
				result = (String)call.invoke(new Object[]{Rbkpbelnr, Rbkpbukrs, Rbkpgjahr, Zsentid, status, Zzaddapr});
				String err = result;
				baseBean.writeLog("FSTWF882 sapresult:" + result);
				if(result.length() > 0)
					result = result.substring(0, 1);
				//sap调用失败，阻止流转
				if(!result.toUpperCase().equals("S")){
					//针对节点后附加操作，控制流程流转
			        request.getRequestManager().setMessageid("222222");
			        request.getRequestManager().setMessagecontent("SAP调用失败，请联系管理员:" + err);
			        baseBean.writeLog("FSTWF882B:SAP调用失败，请联系管理员");
			        
			        sql = "update formtable_main_63 set SAPfh = 1 where requestid = " + rid;
			        baseBean.writeLog("FSTWF882B sql:" + sql);
					rs.executeSql(sql);
				}
				else{
					sql = "update formtable_main_63 set SAPfh = 0 where requestid = " + rid;
			        baseBean.writeLog("FSTWF882B sql:" + sql);
					rs.executeSql(sql);
				}
			}
		}
		catch(java.lang.Exception e){
			request.getRequestManager().setMessageid("222222");
	        request.getRequestManager().setMessagecontent("SAP调用失败，请联系管理员");
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF882B error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

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

//��Ʊ��������
public class FSTWF882 implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();
			baseBean.writeLog("FSTWF882 requestid:" + rid);
			sql = "select Rbkpbelnr,Rbkpbukrs,Rbkpgjahr,sapid from formtable_main_63 where requestid = " + rid;
			baseBean.writeLog("FSTWF882 sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			String Rbkpbelnr = rs.getString("Rbkpbelnr");//��Ʊƾ֤
			String Rbkpbukrs = rs.getString("Rbkpbukrs");//��˾����
			String Rbkpgjahr = rs.getString("Rbkpgjahr");//������
			String Zsentid = rs.getString("sapid");//
			String status = "";
			String Zzaddapr = "";//���������
			String last = request.getLastoperator();
			sql = "select workcode from hrmresource where id = " + last;
			baseBean.writeLog("FSTWF882 sql:" + sql);
			rs.executeSql(sql);
			rs.next();
			Zzaddapr = rs.getString("workcode");
			
			//����������˻ػ����ύ
	        String src = request.getRequestManager().getSrc();
	        baseBean.writeLog("FSTWF882 src:" + src);
	        if(src.equals("submit")){//�ύ����
	        	status = "S";
	        }else if(src.equals("reject")){//�����˻�
	        	status = "E";
	        }
	        //status = "S";
	        baseBean.writeLog("FSTWF882 Rbkpbelnr:" + Rbkpbelnr);
	        baseBean.writeLog("FSTWF882 Rbkpbukrs:" + Rbkpbukrs);
	        baseBean.writeLog("FSTWF882 Rbkpgjahr:" + Rbkpgjahr);
	        baseBean.writeLog("FSTWF882 Zsentid:" + Zsentid);
	        baseBean.writeLog("FSTWF882 status:" + status);
	        baseBean.writeLog("FSTWF882 Zzaddapr:" + Zzaddapr);
	        
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
			if(status.equals("E")){
				result = (String)call.invoke(new Object[]{Rbkpbelnr, Rbkpbukrs, Rbkpgjahr, Zsentid, status, Zzaddapr});
				String err = result;
				baseBean.writeLog("FSTWF882 sapresult:" + result);
				if(result.length() > 0)
					result = result.substring(0, 1);
				//sap����ʧ�ܣ���ֹ��ת
				if(!result.toUpperCase().equals("S")){
					//��Խڵ�󸽼Ӳ���������������ת
			        request.getRequestManager().setMessageid("222222");
			        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա:" + err);
			        baseBean.writeLog("FSTWF882:SAP����ʧ�ܣ�����ϵ����Ա");
				}
				
				sql = "update formtable_main_63 set fqbs = 1 where requestid = " + rid;
				baseBean.writeLog("FSTWF882 sql:" + sql);
				rs.executeSql(sql);
			}
		}
		catch(java.lang.Exception e){
			request.getRequestManager().setMessageid("222222");
	        request.getRequestManager().setMessagecontent("SAP����ʧ�ܣ�����ϵ����Ա");
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF882 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

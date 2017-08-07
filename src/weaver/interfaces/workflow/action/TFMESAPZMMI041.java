package weaver.interfaces.workflow.action;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import javax.swing.JOptionPane;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

import com.sap.mw.jco.JCO;
import com.sap.mw.jco.JCO.Table;
import com.sap.mw.jco.JCO.Record;
import com.sap.mw.jco.IFunctionTemplate;
import javax.swing.JOptionPane;

public class TFMESAPZMMI041 implements Action {
	public String execute(RequestInfo request) {
        try {
            BaseBean baseBean = new BaseBean();
            
            JCO.Client client = null;
            String POOL_NAME = "pool";
        	String sapclient = "";
            String userid = "";
            String password = "";
            String hostname = "";
            String systemnumber = "";
            String Language = "";
            baseBean.writeLog("-------------SAP Client Connects Start ----------------");
			sapclient = baseBean.getPropValue("SAPConn", "SAPClient");
			userid = baseBean.getPropValue("SAPConn", "Userid");
			password = baseBean.getPropValue("SAPConn", "Password");
			hostname = baseBean.getPropValue("SAPConn", "HostName");
			systemnumber = baseBean.getPropValue("SAPConn", "SystemNumber");
			Language = baseBean.getPropValue("SAPConn", "Language");
			
			JCO.Pool pool = JCO.getClientPoolManager().getPool(POOL_NAME);
			if (pool == null) {
				JCO.addClientPool(POOL_NAME, // pool name
						100, // maximum number of connections
						sapclient,
						userid,
						password,
						Language,
						hostname,
						systemnumber);
			}
			client = JCO.getClient(POOL_NAME);//获取连接
			baseBean.writeLog("get connection success");
			
			JCO.Repository mRepository;
			JCO.Function jcoFunction = null;
			
			mRepository = new JCO.Repository("sap", client);
			
			baseBean.writeLog("FSTSAPTest start1-------------");
			
			IFunctionTemplate ft = mRepository.getFunctionTemplate("ZMMI041");
			jcoFunction = new JCO.Function(ft);
			
			baseBean.writeLog("FSTSAPTest start2-------------");
            
            JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_MM41");
            baseBean.writeLog("FSTSAPTest start222222-------------");
            mytbl.appendRow();
            mytbl.setValue("MANDT","MANDT");
            mytbl.setValue("Z_WEE_ID","Z_WEE_ID");
            mytbl.setValue("HEADID","HEADID");
            mytbl.setValue("MATNR","MATNR");
            mytbl.setValue("WERKS","WERKS");
            mytbl.setValue("STLAN","STLAN");
            mytbl.setValue("STLAL","STLAL");
            mytbl.setValue("STLNR","STLNR");
            mytbl.setValue("DATUV","DATUV");
            mytbl.setValue("STLST","STLST");
            mytbl.setValue("BMENG","BMENG");
            mytbl.setValue("BMEIN","BMEIN");
            mytbl.setValue("STKTX","STKTX");
            mytbl.setValue("UPDKZ","UPDKZ");
            mytbl.setValue("IT_HEADID","IT_HEADID");
            mytbl.setValue("POSNR","POSNR");
            mytbl.setValue("IDNRK","IDNRK");
            mytbl.setValue("MENGE","MENGE");
            mytbl.setValue("MEINS","MEINS");
            mytbl.setValue("OP_SCRAP","OP_SCRAP");
            mytbl.setValue("COMP_SCRAP","COMP_SCRAP");
            mytbl.setValue("IT_DATUV","IT_DATUV");
            mytbl.setValue("IT_DATUB","IT_DATUB");
            mytbl.setValue("IDENT","IDENT");
            mytbl.setValue("ALPGR","ALPGR");
            mytbl.setValue("ITEM_NODE","ITEM_NODE");
            mytbl.setValue("ITEM_COUNT","ITEM_COUNT");
            mytbl.setValue("AENNR","AENNR");
            mytbl.setValue("AI_PRIO","AI_PRIO");
            mytbl.setValue("AI_STRATEG","AI_STRATEG");
            mytbl.setValue("USAGE_PROB","USAGE_PROB");
            mytbl.setValue("SPPROCTYPE","SPPROCTYPE");
            mytbl.setValue("ISSUE_LOC","ISSUE_LOC");
            mytbl.setValue("REL_COST","REL_COST");
            mytbl.setValue("FLDELETE","FLDELETE");
            mytbl.setValue("ZWEESTAUTS","ZWEESTAUTS");
            
            baseBean.writeLog("FSTSAPTest start233333333333-------------");
            
            //jcoFunction.getImportParameterList().setValue(mytbl, "ZWEE_MM56");
            baseBean.writeLog("FSTSAPTest start24444444444-------------");
            client.execute(jcoFunction);
            
			baseBean.writeLog("FSTSAPTest start3-------------");

			JCO.Table datas = jcoFunction.getTableParameterList().getTable("RETURN");
			baseBean.writeLog("FSTSAPTest start5-------------");
            //String datas = (String) bapi.getExportParameterList().getValue("VBELN_NO").toString();
			for (int i = 0; i < datas.getNumRows(); i++) {
				datas.setRow(i);
				baseBean.writeLog("MANDT:" + datas.getString("MANDT"));
				baseBean.writeLog("Z_WEE_ID:" + datas.getString("Z_WEE_ID"));
				baseBean.writeLog("MATNR:" + datas.getString("MATNR"));
				baseBean.writeLog("WERKS:" + datas.getString("WERKS"));
				baseBean.writeLog("STLNR:" + datas.getString("STLNR"));
				baseBean.writeLog("STLAL:" + datas.getString("STLAL"));
				baseBean.writeLog("IDENT:" + datas.getString("IDENT:"));
				baseBean.writeLog("TYPE:" + datas.getString("TYPE"));
				baseBean.writeLog("ID:" + datas.getString("ID"));
				baseBean.writeLog("NUMBER:" + datas.getString("NUMBER"));
				baseBean.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
	        }
			baseBean.writeLog("FSTSAPTest start6-------------");
        }
        catch (Exception e) {
            BaseBean baseBean = new BaseBean();
	        baseBean.writeLog("start log");
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("FSTSAPTest error:" + e.getMessage());
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("end log");
        }
	    return Action.SUCCESS;
    }
	
}

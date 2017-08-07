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

public class FSTSAPTest implements Action {
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
			
			IFunctionTemplate ft = mRepository.getFunctionTemplate("ZMMI056");
			jcoFunction = new JCO.Function(ft);
			
			baseBean.writeLog("FSTSAPTest start2-------------");
            
            JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_MM56");
            baseBean.writeLog("FSTSAPTest start222222-------------");
            mytbl.appendRow();
            mytbl.setValue("800", "MANDT");
            mytbl.setValue("1111111111", "Z_WEE_ID");
            mytbl.setValue("", "ZWEESTAUTS");
            mytbl.setValue("A108988235499999-1", "MATNR");
            mytbl.setValue("1010", "WERKS");
            mytbl.setValue("", "LGORT");
            mytbl.setValue("5005560735", "CHARG");
            mytbl.setValue("", "AUFNR");
            mytbl.setValue("", "KUNNR");
            mytbl.setValue("", "GSTRP");
            mytbl.setValue("", "Z_PACKAGE");
            mytbl.setValue("", "Z_ALL");
            mytbl.setValue("", "Z_LING");
            mytbl.setValue("", "Z_NOLING");
            mytbl.setValue("", "BUDAT");
            mytbl.setValue("", "MBLNR");
            mytbl.setValue("", "MJAHR");
            mytbl.setValue("", "ZEILE");
            mytbl.setValue("", "MATKL");
            mytbl.setValue("", "UMLGO");
            mytbl.setValue("", "VBELN");
            mytbl.setValue("", "POSNR");
            mytbl.setValue("", "CPUDT_MKPF");
            mytbl.setValue("", "CPUTM_MKPF");
            mytbl.setValue("", "ERSDA_1");
            mytbl.setValue("", "ERSDA");
            mytbl.setValue("", "LWEDT_1");
            mytbl.setValue("", "LWEDT");
            mytbl.setValue("", "LIFNR");
            mytbl.setValue("", "ZZDATE");
            mytbl.setValue("", "KSCHL");
            mytbl.setValue("", "SHKZG");
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
				baseBean.writeLog("LGORT:" + datas.getString("LGORT"));
				baseBean.writeLog("CHARG:" + datas.getString("CHARG"));
				baseBean.writeLog("BUKRS:" + datas.getString("BUKRS"));
				baseBean.writeLog("BWART:" + datas.getString("BWART"));
				baseBean.writeLog("ZUSTD_T156M:" + datas.getString("ZUSTD_T156M"));
				baseBean.writeLog("MBLNR:" + datas.getString("MBLNR"));
				baseBean.writeLog("XAUTO:" + datas.getString("XAUTO"));
				baseBean.writeLog("BUDAT_MKPF:" + datas.getString("BUDAT_MKPF"));
				baseBean.writeLog("USNAM_MKPF:" + datas.getString("USNAM_MKPF"));
				baseBean.writeLog("MENGE:" + datas.getString("MENGE"));
				baseBean.writeLog("ERFME:" + datas.getString("ERFME"));
				baseBean.writeLog("TYPE:" + datas.getString("TYPE"));
				baseBean.writeLog("ID:" + datas.getString("ID"));
				baseBean.writeLog("NUMBER:" + datas.getString("NUMBER"));
				baseBean.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
				baseBean.writeLog("SHKZG:" + datas.getString("SHKZG"));
				baseBean.writeLog("ZEILE:" + datas.getString("ZEILE"));
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

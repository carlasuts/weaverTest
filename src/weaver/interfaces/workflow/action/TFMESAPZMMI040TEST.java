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
import weaver.interfaces.workflow.action.TFMESAPCONN;

public class TFMESAPZMMI040TEST implements Action {
	public String execute(RequestInfo request) {
        try {
            BaseBean baseBean = new BaseBean();
            JCO.Function jcoFunction = null;
            JCO.Client sapconnection = null;
            TFMESAPCONN sapconn =new TFMESAPCONN();
            sapconnection = sapconn.getConnection();
            jcoFunction= sapconn.excuteBapi("ZMMI040");
            JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_MM40");
            baseBean.writeLog("FSTSAPTest start222222-------------");
            mytbl.appendRow();
			mytbl.setValue("800", "MANDT");
			mytbl.setValue("25F912C897186962E053B01410AC08A7", "Z_WEE_ID");
			mytbl.setValue("", "ZWEESTAUTS");
			mytbl.setValue("A119OZ8953XAP5GN-3", "MATNR");
			mytbl.setValue("119-OZ8953XAP5GN-D1-0-GR-e3-DMAP", "MAKTX");
			mytbl.setValue("FERT", "MTART");
			mytbl.setValue("M", "MBRSH");
			mytbl.setValue("ASSY", "EXTWG");
			mytbl.setValue("000001", "AWSLS");
			mytbl.setValue("01", "KTGRM");
			mytbl.setValue("", "MATKL");
			mytbl.setValue("", "MVGR1");
			mytbl.setValue("", "MVGR2");
			mytbl.setValue("", "MVGR3");
			mytbl.setValue("1", "PEINH");
			mytbl.setValue("X", "EKALR");
			mytbl.setValue("X", "HKMAT");
			mytbl.setValue("1", "TAXM1");
			mytbl.setValue("1", "VERSG");
			mytbl.setValue("10", "VTWEG");
			mytbl.setValue("1000", "VKORG");
			mytbl.setValue("1030", "WERKS");
			mytbl.setValue("1030", "DWERK");
			mytbl.setValue("", "GROES");
			mytbl.setValue("110", "DISPO");
			mytbl.setValue("P1", "DISMM");
			mytbl.setValue("3", "FXHOR");
			mytbl.setValue("EX", "DISLS");
			mytbl.setValue("E", "BESKZ");
			mytbl.setValue("5", "DZEIT");
			mytbl.setValue("11C1", "LGPRO");
			mytbl.setValue("", "RGEKZ");
			mytbl.setValue("000", "FHORI");
			mytbl.setValue("60", "STRGR");
			mytbl.setValue("02", "MTVFP");
			mytbl.setValue("30", "VINT1");
			mytbl.setValue("90", "VINT2");
			mytbl.setValue("2", "VRMOD");
			mytbl.setValue("", "SBDKZ");
			mytbl.setValue("0000001001", "PRCTR");
			mytbl.setValue("", "UEETK");
			mytbl.setValue("110", "FEVOR");
			mytbl.setValue("7920", "BKLAS");
			mytbl.setValue("EA", "MEINS");
			mytbl.setValue("1011", "SFCPF");
			mytbl.setValue("0001", "LADGR");
			mytbl.setValue("0", "UMREN");
			mytbl.setValue("0", "UMREZ");
			mytbl.setValue("0.000", "NTGEW");
			mytbl.setValue("", "PRDHA");
			mytbl.setValue("", "BISMT");
			mytbl.setValue("0.000", "LOSGR");
			mytbl.setValue("", "NORMT");
			mytbl.setValue("", "NCOST");
			mytbl.setValue("0.000", "BRGEW");
			mytbl.setValue("", "ALTSL");
			mytbl.setValue("", "HRKFT");
			mytbl.setValue("", "MEINH");
			mytbl.setValue("", "GEWEI");
			mytbl.setValue("", "LGORT");
			mytbl.setValue("", "SPART");
			mytbl.setValue("", "TRAGR");
			mytbl.setValue("0", "MHDRZ");
			mytbl.setValue("0", "MHDHB");
			mytbl.setValue("", "QMATA");
			mytbl.setValue("", "ZQUERY");
            baseBean.writeLog("FSTSAPTest start233333333333-------------");
            
            //jcoFunction.getImportParameterList().setValue(mytbl, "ZWEE_MM56");
            baseBean.writeLog("FSTSAPTest start24444444444-------------");
            sapconnection.execute(jcoFunction);
            
			baseBean.writeLog("FSTSAPTest start3-------------");

			JCO.Table datas = jcoFunction.getTableParameterList().getTable("RETURN");
			baseBean.writeLog("FSTSAPTest start5-------------");
            //String datas = (String) bapi.getExportParameterList().getValue("VBELN_NO").toString();
			for (int i = 0; i < datas.getNumRows(); i++) {
				datas.setRow(i);
				baseBean.writeLog("MANDT:" + datas.getString("MANDT"));
				baseBean.writeLog("Z_WEE_ID:" + datas.getString("Z_WEE_ID"));
				baseBean.writeLog("TYPE:" + datas.getString("TYPE"));
				baseBean.writeLog("ID:" + datas.getString("ID"));
				baseBean.writeLog("NUMBER:" + datas.getString("NUMBER"));
				baseBean.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
				baseBean.writeLog("TEXT:" + datas.getString("TEXT:"));
				baseBean.writeLog("MATNR:" + datas.getString("MATNR"));
				baseBean.writeLog("MAKTX:" + datas.getString("MAKTX"));
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

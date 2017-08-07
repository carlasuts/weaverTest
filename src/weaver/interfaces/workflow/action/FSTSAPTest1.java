package weaver.interfaces.workflow.action;

import weaver.general.BaseBean;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO.Client;
import com.sap.mw.jco.JCO.Function;
import com.sap.mw.jco.JCO.Repository;
import com.sap.mw.jco.JCO.Table;

public class FSTSAPTest1 {

	private static BaseBean bb = new BaseBean();

	public Function DieToSAP40() {
		bb.writeLog("GET INTO Function Bapi!");
		Client sapconnection = FSTSAPConn1.getConnection();
		Repository mRepository;
		Function jcoFunction = null;
		bb.writeLog("SapConnection: " + sapconnection);

		if (sapconnection == null)
			return jcoFunction;
		try {
			mRepository = new Repository("sap", sapconnection);
			bb.writeLog("mRepository:" + mRepository);
			IFunctionTemplate ft = mRepository.getFunctionTemplate("ZMMI040");

			jcoFunction = new Function(ft);
			Table mytbl = jcoFunction.getTableParameterList().getTable(
					"ZWEE_MM40");
			mytbl.appendRow();
			mytbl.setValue("800", "MANDT");
			mytbl.setValue("800", "Z_WEE_ID");
			mytbl.setValue("800", "ZWEESTAUTS");
			mytbl.setValue("800", "MATNR");
			mytbl.setValue("800", "MAKTX");
			mytbl.setValue("800", "MTART");
			mytbl.setValue("800", "MBRSH");
			mytbl.setValue("800", "EXTWG");
			mytbl.setValue("800", "AWSLS");
			mytbl.setValue("800", "KTGRM");
			mytbl.setValue("800", "MATKL");
			mytbl.setValue("800", "MVGR1");
			mytbl.setValue("800", "MVGR2");
			mytbl.setValue("800", "MVGR3");
			mytbl.setValue("800", "PEINH");
			mytbl.setValue("800", "EKALR");
			mytbl.setValue("800", "HKMAT");
			mytbl.setValue("800", "TAXM1");
			mytbl.setValue("800", "VERSG");
			mytbl.setValue("800", "VTWEG");
			mytbl.setValue("800", "VKORG");
			mytbl.setValue("800", "WERKS");
			mytbl.setValue("800", "DWERK");
			mytbl.setValue("800", "GROES");
			mytbl.setValue("800", "DISPO");
			mytbl.setValue("800", "DISMM");
			mytbl.setValue("800", "FXHOR");
			mytbl.setValue("800", "DISLS");
			mytbl.setValue("800", "BESKZ");
			mytbl.setValue("800", "DZEIT");
			mytbl.setValue("800", "LGPRO");
			mytbl.setValue("800", "RGEKZ");
			mytbl.setValue("800", "FHORI");
			mytbl.setValue("800", "STRGR");
			mytbl.setValue("800", "MTVFP");
			mytbl.setValue("800", "VINT1");
			mytbl.setValue("800", "VINT2");
			mytbl.setValue("800", "VRMOD");
			mytbl.setValue("800", "SBDKZ");
			mytbl.setValue("800", "PRCTR");
			mytbl.setValue("800", "UEETK");
			mytbl.setValue("800", "FEVOR");
			mytbl.setValue("800", "BKLAS");
			mytbl.setValue("800", "MEINS");
			mytbl.setValue("800", "SFCPF");
			mytbl.setValue("800", "LADGR");
			mytbl.setValue("800", "UMREN");
			mytbl.setValue("800", "UMREZ");
			mytbl.setValue("800", "NTGEW");
			mytbl.setValue("800", "PRDHA");
			mytbl.setValue("800", "BISMT");
			mytbl.setValue("800", "LOSGR");
			mytbl.setValue("800", "NORMT");
			mytbl.setValue("800", "NCOST");
			mytbl.setValue("800", "BRGEW");
			mytbl.setValue("800", "ALTSL");
			mytbl.setValue("800", "HRKFT");
			mytbl.setValue("800", "MEINH");
			mytbl.setValue("800", "GEWEI");
			mytbl.setValue("800", "LGORT");
			mytbl.setValue("800", "SPART");
			mytbl.setValue("800", "TRAGR");
			mytbl.setValue("800", "MHDRZ");
			mytbl.setValue("800", "MHDHB");
			mytbl.setValue("800", "QMATA");
			mytbl.setValue("800", "ZQUERY");

			sapconnection.execute(jcoFunction);
			bb.writeLog("Excuete Bapi already");

			Table datas = jcoFunction.getTableParameterList()
					.getTable("RETURN");
			for (int i = 0; i < datas.getNumRows(); i++) {
				datas.setRow(i);
				bb.writeLog("MANDT:" + datas.getString("MANDT"));
				bb.writeLog("Z_WEE_ID:" + datas.getString("Z_WEE_ID"));
				bb.writeLog("TYPE:" + datas.getString("TYPE"));
				bb.writeLog("ID:" + datas.getString("ID"));
				bb.writeLog("NUMBER:" + datas.getString("NUMBER"));
				bb.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
				bb.writeLog("TEXT:" + datas.getString("TEXT:"));
				bb.writeLog("MATNR:" + datas.getString("MATNR"));
				bb.writeLog("MAKTX:" + datas.getString("MAKTX"));
			}

			bb.writeLog("Excuete Bapi Success");
			return jcoFunction;
		} catch (Exception e) {
			bb.writeLog(e);
			// JOptionPane.showMessageDialog(null, e.getMessage(), "´íÎóÐÅÏ¢", 0);
			return null;
		} finally {
			FSTSAPConn1.releaseC();
		}
	}
}

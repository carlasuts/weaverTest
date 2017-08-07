package weaver.interfaces.sap;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;

import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.sap.SapLogWriter;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;

public class ZMMI041 {
	private JCO.Function jcoFunction = null;
	private JCO.Client sapconnection = null;
	private BaseBean baseBean = new BaseBean();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
	private String logtablename = "ZMMI04101";

	public ZMMI041() {
		init();
	}

	private void init() {
		JCO.Repository mRepository = null;
		sapconnection = SapConnUtil.getconn();
		mRepository = new JCO.Repository("sap", sapconnection);
		IFunctionTemplate ft = mRepository.getFunctionTemplate("ZMMI041");
		jcoFunction = new JCO.Function(ft);
	}

	// 主数据
	public void zsj(MainTableInfo maintableinfo, String rid) throws Exception {
		String requestid = rid ;
        List<Map<String,String>> loglist = new ArrayList<Map<String,String>>();
		String ProductMaterialCode = "";
		String Plant = "";
		String Usage = "";
		String AlternativeBom = "";
		String Status = "";
		String BaseQty = "";
		String AlternativeText = "";

		Property[] Property = maintableinfo.getProperty();
		String id;
		for (int i = 0; i < Property.length; i++) {
			rid = Property[i].getName().toUpperCase();
			id = Util.null2String(Property[i].getValue());
			if (rid.equals("PRODUCTMATERIALCODE")) {
				ProductMaterialCode = id;
			}
			if (rid.equals("PLANT")) {
				Plant = id;
			}
			if (rid.equals("USAGE")) {
				Usage = id;
			}
			if (rid.equals("ALTERNATIVEBOM")) {
				AlternativeBom = id;
			}
			if (rid.equals("STATUS")) {
				Status = id;
			}
			if (rid.equals("BASEQTY")) {
				BaseQty = id;
			}
			if (rid.equals("ALTERNATIVETEXT")) {
				AlternativeText = id;
			}
		}
		Date d = new Date();
		String nd = sf.format(d);

		Map<String, String> logmap = new HashMap<String, String>();
		JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_MM41");

		mytbl.appendRow();
		UUID uuid = UUID.randomUUID();
		setValue(mytbl, logmap, "800", "MANDT");
		setValue(mytbl, logmap, uuid.toString().substring(0, 32), "Z_WEE_ID");
		setValue(mytbl, logmap, "1", "HEADID");
		setValue(mytbl, logmap, ProductMaterialCode, "MATNR");
		setValue(mytbl, logmap, Plant, "WERKS");// Plant 工厂
		setValue(mytbl, logmap, Usage, "STLAN");
		setValue(mytbl, logmap, AlternativeBom, "STLAL");// 递增
		setValue(mytbl, logmap, "", "STLNR");// 9位系序列
		setValue(mytbl, logmap, nd, "DATUV");// 当天
		setValue(mytbl, logmap, Status, "STLST");
		setValue(mytbl, logmap, BaseQty, "BMENG");
		setValue(mytbl, logmap, "EA", "BMEIN");// 根据期别、工厂、生产方式判断
		setValue(mytbl, logmap, AlternativeText, "STKTX");
		setValue(mytbl, logmap, "", "UPDKZ");
		setValue(mytbl, logmap, "0", "IT_HEADID");
		setValue(mytbl, logmap, "", "POSNR");
		setValue(mytbl, logmap, "", "IDNRK");
		setValue(mytbl, logmap, "0.000", "MENGE");
		setValue(mytbl, logmap, "", "MEINS");
		setValue(mytbl, logmap, "", "OP_SCRAP");
		setValue(mytbl, logmap, "", "COMP_SCRAP");
		setValue(mytbl, logmap, new Date(), "IT_DATUV");
		setValue(mytbl, logmap, new Date(), "IT_DATUB");
		setValue(mytbl, logmap, "", "IDENT");
		setValue(mytbl, logmap, "", "ALPGR");
		setValue(mytbl, logmap, "0", "ITEM_NODE");
		setValue(mytbl, logmap, "0", "ITEM_COUNT");
		setValue(mytbl, logmap, "", "AENNR");
		setValue(mytbl, logmap, "", "AI_PRIO");
		setValue(mytbl, logmap, "", "AI_STRATEG");
		setValue(mytbl, logmap, "", "USAGE_PROB");
		setValue(mytbl, logmap, "", "SPPROCTYPE");
		setValue(mytbl, logmap, "", "ISSUE_LOC");
		setValue(mytbl, logmap, "", "REL_COST");
		setValue(mytbl, logmap, "", "FLDELETE");
		setValue(mytbl, logmap, "", "ZWEESTAUTS");

		logmap.put("REQUESTID",requestid);
		loglist.add(logmap);
		baseBean.writeLog("开始执行-------");
//		sapconnection.execute(jcoFunction);
//		baseBean.writeLog("开始执行-------");
//
//		// 获取返回数据
//		JCO.Table datas = jcoFunction.getTableParameterList().getTable("RETURN");
//		for (int i = 0; i < datas.getNumRows(); i++) {
//			datas.setRow(i);
//			baseBean.writeLog("MANDT:" + datas.getString("MANDT"));
//			baseBean.writeLog("Z_WEE_ID:" + datas.getString("Z_WEE_ID"));
//			baseBean.writeLog("TYPE:" + datas.getString("TYPE"));
//			baseBean.writeLog("ID:" + datas.getString("ID"));
//			baseBean.writeLog("NUMBER:" + datas.getString("NUMBER"));
//			baseBean.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
//			baseBean.writeLog("MATNR:" + datas.getString("MATNR"));
//		}
		
		writelog(loglist);
	}

	private void setValue(JCO.Table mytb, Map<String, String> logmap, Object value, String key) {
		if (value instanceof Date) {
			String datavalue = sf.format((Date) value);
			mytb.setValue((Date) value, key);
			logmap.put(key, datavalue);
			return;
		}
		mytb.setValue(value.toString(), key);
		logmap.put(key, value.toString());
	}

	private void writelog(List<Map<String, String>> loglist) {
		SapLogWriter.writerlog(loglist, logtablename);
	}

}

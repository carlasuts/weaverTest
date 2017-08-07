package weaver.interfaces.sap;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

import java.text.SimpleDateFormat;
import java.util.*;

public class ZMMI042 {
	private SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private JCO.Function jcoFunction = null;
	private JCO.Client sapconnection = null;
	private BaseBean baseBean = new BaseBean();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
	private String logtablename = "ZMMI04201";
	private static List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
	
	String z_wee_id = "";
	String plant_no = "";

	public ZMMI042() {
		init();
	}

	private void init() {
		JCO.Repository mRepository = null;
		sapconnection = SapConnUtil.getconn();
		mRepository = new JCO.Repository("sap", sapconnection);
		IFunctionTemplate ft = mRepository.getFunctionTemplate("ZMMI042");
		jcoFunction = new JCO.Function(ft);
	}

	
	public void gylxMx(DetailTable dt, String rid){
		String requestid = rid;
		//List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
		JCO.Table mytbl = jcoFunction.getTableParameterList().getTable(
				"ZWEE_MM42");
		String itemNo = "";
		String workCenter = "";
		String oper = "";
		String operDesc = "";
		Row[] s = dt.getRow();// 当前明细表的所有数据,按行存储
		for (int j = 0; j < s.length; j++) {
			Row r = s[j];// 指定行
			Cell c[] = r.getCell();// 每行数据再按列存储
			for (int k = 0; k < c.length; k++) {
				Cell c1 = c[k];// 指定列
				String name = c1.getName().toUpperCase();// 明细字段名称
				String value = Util.null2String(c1.getValue());// 明细字段的值
				if (name.equals("ITEMNO")) {
					itemNo = value;
				}
				if (name.equals("WORKCENTER")) {
					workCenter = value;
				}
				if (name.equals("OPERADD")) {
					oper = value;
				}
				if (name.equals("OPERDESC")) {
					operDesc = value;
				}
			}
			Date d = new Date();
			String nd = sf.format(d);

			Map<String, String> logmap = new HashMap<String, String>();
			
			mytbl.appendRow();
			
			setValue(mytbl, logmap, "800", "MANDT");
			setValue(mytbl, logmap, z_wee_id, "Z_WEE_ID");
			setValue(mytbl, logmap, "1", "HEADID");//同表头序列
			setValue(mytbl, logmap, "", "PLNNR");
			setValue(mytbl, logmap, "", "MATNR");
			setValue(mytbl, logmap, "", "WERKS");
			setValue(mytbl, logmap, "", "DATUV");
			setValue(mytbl, logmap, "", "DATUB");
			setValue(mytbl, logmap, "", "PLNME");
			setValue(mytbl, logmap, "", "KTEXT");
			setValue(mytbl, logmap, "1", "IT_HEADID");//同表头序列
			setValue(mytbl, logmap, "", "IT_DATUV");
			setValue(mytbl, logmap, "", "IT_DATUB");
			setValue(mytbl, logmap, itemNo, "VORNR");
			setValue(mytbl, logmap, workCenter, "ARBPL");
			setValue(mytbl, logmap, plant_no, "IT_WERKS");
			setValue(mytbl, logmap, "PP01", "STEUS");
			setValue(mytbl, logmap, oper, "KTSCH");
			setValue(mytbl, logmap, operDesc, "LTXA1");
			setValue(mytbl, logmap, "999999", "BMSCH");
			setValue(mytbl, logmap, "EA", "MEINH");
			setValue(mytbl, logmap, "0.000", "VGW01");
			setValue(mytbl, logmap, "MIN", "VGE01");
			setValue(mytbl, logmap, "60", "VGW02");
			setValue(mytbl, logmap, "MIN", "VGE02");
			setValue(mytbl, logmap, "60", "VGW03");
			setValue(mytbl, logmap, "MIN", "VGE03");
			setValue(mytbl, logmap, "60", "VGW04");
			setValue(mytbl, logmap, "MIN", "VGE04");
			setValue(mytbl, logmap, "60", "VGW05");
			setValue(mytbl, logmap, "MIN", "VGE05");
			setValue(mytbl, logmap, "60", "VGW06");
			setValue(mytbl, logmap, "MIN", "VGE06");
			setValue(mytbl, logmap, "", "INFNR");
			setValue(mytbl, logmap, "", "EKORG");
			setValue(mytbl, logmap, "", "SAKTO");
			setValue(mytbl, logmap, "0.000", "MINWE");
			setValue(mytbl, logmap, "", "SPMUS");
			setValue(mytbl, logmap, "0", "SPLIM");
			setValue(mytbl, logmap, "0", "UMREZ");
			setValue(mytbl, logmap, "", "UEMUS");
			setValue(mytbl, logmap, "1", "CM_HEADID");//同表头序列
			setValue(mytbl, logmap, "", "STLNR");
			setValue(mytbl, logmap, "", "STLAL");
			setValue(mytbl, logmap, "", "STLAN");
			setValue(mytbl, logmap, "", "POSNR");
			setValue(mytbl, logmap, "", "IDNRK");
			setValue(mytbl, logmap, "", "CM_VORNR");
			setValue(mytbl, logmap, "", "CM_FLAG");
			setValue(mytbl, logmap, "", "ZWEESTAUTS");

			logmap.put("REQUESTID", requestid);
			loglist.add(logmap);
		}

			baseBean.writeLog("开始执行-------");

			sapconnection.execute(jcoFunction);
			baseBean.writeLog("返回数据-------");
		// 获取返回数据
		JCO.Table datas = jcoFunction.getTableParameterList()
				.getTable("RETURN");
		for (int i = 0; i < datas.getNumRows(); i++) {
			datas.setRow(i);
			baseBean.writeLog("Z_WEE_ID:" + datas.getString("Z_WEE_ID"));
			baseBean.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
		}
		//writelog(loglist);
	}
	
	public void gylxMxBom(DetailTable dt, String rid){
		String requestid = rid;
		//List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
		JCO.Table mytbl = jcoFunction.getTableParameterList().getTable(
				"ZWEE_MM42");
		String posnr = "";
		String idnrk = "";
		String operitemno = "";
		Row[] s = dt.getRow();// 当前明细表的所有数据,按行存储
		for (int j = 0; j < s.length; j++) {
			Row r = s[j];// 指定行
			Cell c[] = r.getCell();// 每行数据再按列存储
			for (int k = 0; k < c.length; k++) {
				Cell c1 = c[k];// 指定列
				String name = c1.getName().toUpperCase();// 明细字段名称
				String value = Util.null2String(c1.getValue());// 明细字段的值
				if (name.equals("POSNR")) {
					posnr = value;
				}
				if (name.equals("IDNRK")) {
					idnrk = value;
				}
				if (name.equals("OPERITEMNO")) {
					operitemno = value;
				}
			}
			Date d = new Date();
			String nd = sf.format(d);

			Map<String, String> logmap = new HashMap<String, String>();
			
			mytbl.appendRow();
			
			setValue(mytbl, logmap, "800", "MANDT");
			setValue(mytbl, logmap, z_wee_id, "Z_WEE_ID");
			setValue(mytbl, logmap, "1", "HEADID");//同表头序列
			setValue(mytbl, logmap, "", "PLNNR");
			setValue(mytbl, logmap, "", "MATNR");
			setValue(mytbl, logmap, "", "WERKS");
			setValue(mytbl, logmap, "", "DATUV");
			setValue(mytbl, logmap, "", "DATUB");
			setValue(mytbl, logmap, "", "PLNME");
			setValue(mytbl, logmap, "", "KTEXT");
			setValue(mytbl, logmap, "1", "IT_HEADID");//同表头序列
			setValue(mytbl, logmap, "", "IT_DATUV");
			setValue(mytbl, logmap, "", "IT_DATUB");
			setValue(mytbl, logmap, "", "VORNR");
			setValue(mytbl, logmap, "", "ARBPL");
			setValue(mytbl, logmap, "", "IT_WERKS");
			setValue(mytbl, logmap, "", "STEUS");
			setValue(mytbl, logmap, "", "KTSCH");
			setValue(mytbl, logmap, "", "LTXA1");
			setValue(mytbl, logmap, "", "BMSCH");
			setValue(mytbl, logmap, "", "MEINH");
			setValue(mytbl, logmap, "", "VGW01");
			setValue(mytbl, logmap, "", "VGE01");
			setValue(mytbl, logmap, "", "VGW02");
			setValue(mytbl, logmap, "", "VGE02");
			setValue(mytbl, logmap, "", "VGW03");
			setValue(mytbl, logmap, "", "VGE03");
			setValue(mytbl, logmap, "", "VGW04");
			setValue(mytbl, logmap, "", "VGE04");
			setValue(mytbl, logmap, "", "VGW05");
			setValue(mytbl, logmap, "", "VGE05");
			setValue(mytbl, logmap, "", "VGW06");
			setValue(mytbl, logmap, "", "VGE06");
			setValue(mytbl, logmap, "", "INFNR");
			setValue(mytbl, logmap, "", "EKORG");
			setValue(mytbl, logmap, "", "SAKTO");
			setValue(mytbl, logmap, "0.000", "MINWE");
			setValue(mytbl, logmap, "", "SPMUS");
			setValue(mytbl, logmap, "0", "SPLIM");
			setValue(mytbl, logmap, "0", "UMREZ");
			setValue(mytbl, logmap, "", "UEMUS");
			setValue(mytbl, logmap, "1", "CM_HEADID");//同表头序列
			setValue(mytbl, logmap, "", "STLNR");
			setValue(mytbl, logmap, "01", "STLAL");
			setValue(mytbl, logmap, "", "STLAN");
			setValue(mytbl, logmap, posnr, "POSNR");
			setValue(mytbl, logmap, idnrk, "IDNRK");
			setValue(mytbl, logmap, operitemno, "CM_VORNR");
			setValue(mytbl, logmap, "X", "CM_FLAG");
			setValue(mytbl, logmap, "", "ZWEESTAUTS");

			logmap.put("REQUESTID", requestid);
			loglist.add(logmap);
		}

			baseBean.writeLog("开始执行-------");

			sapconnection.execute(jcoFunction);
			baseBean.writeLog("返回数据-------");
		// 获取返回数据
		JCO.Table datas = jcoFunction.getTableParameterList()
				.getTable("RETURN");
		for (int i = 0; i < datas.getNumRows(); i++) {
			datas.setRow(i);
			baseBean.writeLog("Z_WEE_ID:" + datas.getString("Z_WEE_ID"));
			baseBean.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
		}
		//writelog(loglist);
	}
	
	// 工艺路线
	public void gylx(MainTableInfo maintableinfo, String rid) {
		String requestid = rid;
		//List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
		String RouterCode = "";
		String ProductMaterialCode = "";
		String Plant = "";
		String Unit = "";
		String Description = "";
		UUID uuid = UUID.randomUUID();
		z_wee_id = uuid.toString().substring(0, 32);

		Property[] Property = maintableinfo.getProperty();
		String id;
		for (int i = 0; i < Property.length; i++) {
			rid = Property[i].getName().toUpperCase();
			id = Util.null2String(Property[i].getValue());
			if (rid.equals("ROUTERCODE")) {
				RouterCode = id;
			}
			if (rid.equals("PRODUCTMATERIALCODE")) {
				ProductMaterialCode = id;
			}
			if (rid.equals("PLANT1")) {
				Plant = id;
			}
			if (rid.equals("UNIT")) {
				Unit = id;
			}
			if (rid.equals("DESCRIPTION")) {
				Description = id;
			}
		}
		
		plant_no = Plant;
		Date d = new Date();
		String nd = sf.format(d);

		Map<String, String> logmap = new HashMap<String, String>();
		JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_MM42");
		
		mytbl.appendRow();
		
		setValue(mytbl, logmap, "800", "MANDT");
		setValue(mytbl, logmap, z_wee_id, "Z_WEE_ID");
		setValue(mytbl, logmap, "1", "HEADID");
		setValue(mytbl, logmap, RouterCode, "PLNNR");
		setValue(mytbl, logmap, ProductMaterialCode, "MATNR");
		setValue(mytbl, logmap, plant_no, "WERKS");
		setValue(mytbl, logmap, nd, "DATUV");
		setValue(mytbl, logmap, "99991231", "DATUB");
		setValue(mytbl, logmap, Unit, "PLNME");
		setValue(mytbl, logmap, Description, "KTEXT");
		setValue(mytbl, logmap, "1", "IT_HEADID");
		setValue(mytbl, logmap, "", "IT_DATUV");
		setValue(mytbl, logmap, "", "IT_DATUB");
		setValue(mytbl, logmap, "", "VORNR");
		setValue(mytbl, logmap, "", "ARBPL");
		setValue(mytbl, logmap, "", "IT_WERKS");
		setValue(mytbl, logmap, "", "STEUS");
		setValue(mytbl, logmap, "", "KTSCH");
		setValue(mytbl, logmap, "", "LTXA1");
		setValue(mytbl, logmap, "0.000", "BMSCH");
		setValue(mytbl, logmap, "", "MEINH");
		setValue(mytbl, logmap, "0.000", "VGW01");
		setValue(mytbl, logmap, "", "VGE01");
		setValue(mytbl, logmap, "0.000", "VGW02");
		setValue(mytbl, logmap, "", "VGE02");
		setValue(mytbl, logmap, "0.000", "VGW03");
		setValue(mytbl, logmap, "", "VGE03");
		setValue(mytbl, logmap, "0.000", "VGW04");
		setValue(mytbl, logmap, "", "VGE04");
		setValue(mytbl, logmap, "0.000", "VGW05");
		setValue(mytbl, logmap, "", "VGE05");
		setValue(mytbl, logmap, "0.000", "VGW06");
		setValue(mytbl, logmap, "", "VGE06");
		setValue(mytbl, logmap, "", "INFNR");
		setValue(mytbl, logmap, "", "EKORG");
		setValue(mytbl, logmap, "", "SAKTO");
		setValue(mytbl, logmap, "0.000", "MINWE");
		setValue(mytbl, logmap, "", "SPMUS");
		setValue(mytbl, logmap, "0", "SPLIM");
		setValue(mytbl, logmap, "0", "UMREZ");
		setValue(mytbl, logmap, "", "UEMUS");
		setValue(mytbl, logmap, "0", "CM_HEADID");
		setValue(mytbl, logmap, "", "STLNR");
		setValue(mytbl, logmap, "", "STLAL");
		setValue(mytbl, logmap, "", "STLAN");
		setValue(mytbl, logmap, "", "POSNR");
		setValue(mytbl, logmap, "", "IDNRK");
		setValue(mytbl, logmap, "", "CM_VORNR");
		setValue(mytbl, logmap, "", "CM_FLAG");
		setValue(mytbl, logmap, "", "ZWEESTAUTS");

		logmap.put("REQUESTID", requestid);
		loglist.add(logmap);

		baseBean.writeLog("开始执行-------");

		sapconnection.execute(jcoFunction);
		baseBean.writeLog("返回数据-------");
		// 获取返回数据
		JCO.Table datas = jcoFunction.getTableParameterList()
				.getTable("RETURN");
		for (int i = 0; i < datas.getNumRows(); i++) {
			datas.setRow(i);
			baseBean.writeLog("MANDT:" + datas.getString("MANDT"));
			baseBean.writeLog("Z_WEE_ID:" + datas.getString("Z_WEE_ID"));
			baseBean.writeLog("MATNR:" + datas.getString("MATNR"));
			baseBean.writeLog("WERKS:" + datas.getString("WERKS"));
			baseBean.writeLog("PLNNR:" + datas.getString("PLNNR"));
			baseBean.writeLog("TYPE:" + datas.getString("TYPE"));
			baseBean.writeLog("ID:" + datas.getString("ID"));
			baseBean.writeLog("NUMBER:" + datas.getString("NUMBER"));
			baseBean.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
		}
		//writelog(loglist);
	}

	private void setValue(JCO.Table mytb, Map<String, String> logmap,
			Object value, String key) {
		if (value instanceof Date) {
			String datavalue = sd.format((Date) value);
			mytb.setValue((Date) value, key);
			logmap.put(key, datavalue);
			return;
		}
		mytb.setValue(value.toString(), key);
		logmap.put(key, value.toString());
	}

	public void writelog() {
		baseBean.writeLog("loglist-------" + loglist);
		SapLogWriter.writerlog(loglist, logtablename);
	}

}

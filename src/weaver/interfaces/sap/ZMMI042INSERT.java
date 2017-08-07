package weaver.interfaces.sap;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class ZMMI042INSERT {

	private String logtablename = "ZMMI04201";

	public void zmmi042insert(MainTableInfo maintableinfo, String rid) {
		List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
		String PRODUCTMATERIALCODE1 = "";
		String PLANT = "";
		String STANDARDROUTER = "";
		String ROUTERCODE = "";
		String GROUPCOUNT = "";
		String USAGE = "";
		String STATUS = "";
		String UNIT = "";
		String DESCRIPTION = "";
		String SEQUENCE = "";

		PreparedStatement ps = null;
		ResultSet rs = null;
		Property[] Property = maintableinfo.getProperty();
		String id;
		String re;
		for (int ss = 0; ss < Property.length; ++ss) {
			re = Property[ss].getName().toUpperCase();
			id = Util.null2String(Property[ss].getValue());
			if (re.equals("PRODUCTMATERIALCODE1")) {
				PRODUCTMATERIALCODE1 = id;
			}
			if (re.equals("PLANT")) {
				PLANT = id;
			}
			if (re.equals("STANDARDROUTER")) {
				STANDARDROUTER = id;
			}
			if (re.equals("ROUTERCODE")) {
				ROUTERCODE = id;
			}
			if (re.equals("GROUPCOUNT")) {
				GROUPCOUNT = id;
			}
			if (re.equals("USAGE")) {
				USAGE = id;
			}
			if (re.equals("STATUS")) {
				STATUS = id;
			}
			if (re.equals("UNIT")) {
				UNIT = id;
			}
			if (re.equals("DESCRIPTION")) {
				DESCRIPTION = id;
			}
			if (re.equals("SEQUENCE")) {
				SEQUENCE = id;
			}
		}
		java.util.Date date = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				"yyyyMMddHHmmss");
		String udpatetime = sdf.format(date);
		String createtime = sdf.format(date);
		String datuv = udpatetime.substring(0, 8);
		UUID uuid = UUID.randomUUID();
		Map<String, String> logmap = new HashMap<String, String>();

		logmap.put("requestid", rid);
		logmap.put("nodeid", "200");
		logmap.put("mandt", "800");
		logmap.put("z_wee_id", "");
		logmap.put("headid", "1");
		logmap.put("PLNNR", ROUTERCODE);
		logmap.put("MATNR", PRODUCTMATERIALCODE1);
		logmap.put("WERKS", PLANT);
		logmap.put("DATUV", datuv);
		logmap.put("DATUB", "99991231");
		logmap.put("PLNME", UNIT);
		logmap.put("KTEXT", DESCRIPTION);
		logmap.put("IT_HEADID", "0");
		logmap.put("IT_DATUV", "");
		logmap.put("IT_DATUB", "");
		logmap.put("VORNR", "");
		logmap.put("ARBPL", "");
		logmap.put("IT_WERKS", "");
		logmap.put("STEUS", "");
		logmap.put("KTSCH", "");
		logmap.put("LTXA1", "");
		logmap.put("BMSCH", "0.000");
		logmap.put("MEINH", "");
		logmap.put("VGW01", "0.000");
		logmap.put("VGE01", "");
		logmap.put("VGW02", "0.000");
		logmap.put("VGE02", "");
		logmap.put("VGW03", "0.000");
		logmap.put("VGE03", "");
		logmap.put("VGW04", "0.000");
		logmap.put("VGE04", "");
		logmap.put("VGW05", "0.000");
		logmap.put("VGE05", "");
		logmap.put("VGW06", "0.000");
		logmap.put("VGE06", "");
		logmap.put("INFNR", "");
		logmap.put("EKORG", "");
		logmap.put("SAKTO", "");
		logmap.put("MINWE", "0.000");
		logmap.put("SPMUS", "");
		logmap.put("SPLIM", "0");
		logmap.put("UMREZ", "0");
		logmap.put("UEMUS", "");
		logmap.put("CM_HEADID", "0");
		logmap.put("STLNR", "");
		logmap.put("STLAL", "");
		logmap.put("STLAN", USAGE);
		logmap.put("POSNR", "");
		logmap.put("IDNRK", "");
		logmap.put("CM_VORNR", "");
		logmap.put("CM_FLAG", "");
		logmap.put("ZWEESTAUTS", STATUS);

		loglist.add(logmap);
		System.out.println("开始执行-------");

		System.out.println("返回数据-------");
		writelog(loglist);
	}

	private void writelog(List<Map<String, String>> loglist) {
		SapLogWriter.writerlog(loglist, logtablename);
	}
}

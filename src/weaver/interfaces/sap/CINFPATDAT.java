package weaver.interfaces.sap;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

/**
 */
public class CINFPATDAT {

	private String logtablename = "CINFPATDAT";

	// 芯片
	public void insert(DetailTable dt, String rid, MainTableInfo maintableinfo, String creator) {
		List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
		Property[] Property = maintableinfo.getProperty();

		String ProductMaterialCode = "";
		String Plant = "";
		String Usage = "";
		String AlternativeBom = "";

		java.util.Date date = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String CREATE_TIME = sdf.format(date);
		String UPDATE_TIME = sdf.format(date);
		String INF_TIME = sdf.format(date);

		String id;
		String re;
		for (int ss = 0; ss < Property.length; ++ss) {
			re = Property[ss].getName().toUpperCase();
			if (Util.null2String(Property[ss].getValue()).isEmpty()) {
				id = " ";
			} else {
				id = Util.null2String(Property[ss].getValue());
			}
			if (re.equals("PRODUCTMATERIALCODE")) {
				ProductMaterialCode = id;
			}
			if (re.equals("PLANT")) {
				Plant = id;
			}
			if (re.equals("USAGE")) {
				Usage = id;
			}
			if (re.equals("ALTERNATIVEBOM")) {
				AlternativeBom = id;
			}
		}
		String POSNR = "";
		String IDNRK = "";
		String MENGE = "";
		String MEINS = "";
		String AUSCH = "";
		String ALPGR = "";
		String ALPRF = "";
		String ALPST = "";
		String LGORT = "";
		String SANKA = "";
		Row[] s = dt.getRow();// 当前明细表的所有数据,按行存储
		for (int j = 0; j < s.length; j++) {
			Row r = s[j];// 指定行
			Cell c[] = r.getCell();// 每行数据再按列存储
			for (int k = 0; k < c.length; k++) {
				Cell c1 = c[k];// 指定列
				String name = c1.getName().toUpperCase();// 明细字段名称
				String value = Util.null2String(c1.getValue());// 明细字段的值
				if (Util.null2String(c1.getValue()).isEmpty()) {
					value = " ";
				} else {
					value = Util.null2String(c1.getValue());
				}
				if (name.equals("POSNR")) {
					POSNR = value;
				}
				if (name.equals("IDNRK")) {
					IDNRK = value;
				}
				if (name.equals("MENGE")) {
					MENGE = value;
				}
				if (name.equals("MEINS")) {
					MEINS = value;
				}
				if (name.equals("AUSCH")) {
					AUSCH = value;
				}
				if (name.equals("ALPGR")) {
					ALPGR = value;
				}
				if (name.equals("ALPRF")) {
					ALPRF = value;
				}
				if (name.equals("ALPST")) {
					ALPST = value;
				}
				if (name.equals("LGORT")) {
					LGORT = value;
				}
				if (name.equals("SANKA")) {
					SANKA = value;
				}
			}

			Map<String, String> logmap = new HashMap<String, String>();
			UUID uuid = UUID.randomUUID();
			System.out.println(uuid.toString().substring(0, 32));
			logmap.put("REQUESTID", rid);
			logmap.put("NODEID", "200");
			logmap.put("INF_TIME", INF_TIME);
			if (ProductMaterialCode.substring(0, 1).equals("A")) {
				logmap.put("INF_SEQ", String.valueOf(j + 1));
			} else if (ProductMaterialCode.substring(0, 1).equals("T")) {
				logmap.put("INF_SEQ", String.valueOf(j + 1001));
			}
			logmap.put("MATNR", ProductMaterialCode);
			logmap.put("WERKS", Plant);
			logmap.put("STLAN", Usage);
			logmap.put("STLAL", AlternativeBom);
			logmap.put("POSNR", POSNR);
			logmap.put("IDNRK", IDNRK);
			logmap.put("MENGE", MENGE);
			logmap.put("MEINS", MEINS);
			logmap.put("AUSCH", AUSCH);
			logmap.put("ALPGR", ALPGR);
			logmap.put("ALPRF", ALPRF);
			logmap.put("ALPST", ALPST);
			logmap.put("LGORT", LGORT);
			logmap.put("SANKA", SANKA);
			logmap.put("DELETE_FLAG", " ");
			logmap.put("CREATE_TIME", CREATE_TIME);
			logmap.put("CREATE_USER_ID", creator);
			logmap.put("UPDATE_TIME", UPDATE_TIME);
			logmap.put("UPDATE_USER_ID", creator);
			logmap.put("DELETE_TIME", " ");
			logmap.put("DELETE_USER_ID", " ");

			loglist.add(logmap);
			System.out.println("开始执行-------");

			System.out.println("返回数据-------");
			// 获取返回数据

		}
		writelog(loglist);
	}

	private void writelog(List<Map<String, String>> loglist) {
		SapLogWriter.writerlog(loglist, logtablename);

	}

}

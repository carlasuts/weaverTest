package weaver.interfaces.sap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import weaver.conn.RecordSet;
import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class CINFBOMDAT {

	private String logtablename = "CINFBOMDAT";

	// 芯片
	public void setcinfbomdat(DetailTable dt, String rid, MainTableInfo maintableinfo, String creator) {
		List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
		Property[] Property = maintableinfo.getProperty();

		RecordSet rs = new RecordSet();
		String PRODUCTMATERIALCODE = "";
		String PLANT = "";
		String ROUTERCODE = "";
		String GROUPCOUNT = "";
		String SEQUENCE = "";
		String USAGE = "";
		String INF_TIME = "";
		java.util.Date date = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
		String CREATE_TIME = sdf.format(date);
		String UPDATE_TIME = sdf.format(date);

		String sql = "";
		sql = "select * from workflow_requestbase where REQUESTID = '" + rid + "'";
		rs.executeSql(sql);
		rs.next();
		INF_TIME = rs.getString("CREATEDATE") + rs.getString("CREATETIME");
		INF_TIME = INF_TIME.replace("-", "").replace(":", "");
		// String INF_TIME = sdf.format(date);

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
				PRODUCTMATERIALCODE = id;
			}

			if (re.equals("ROUTERCODE")) {
				ROUTERCODE = id;
			}

			if (re.equals("GROUPCOUNT")) {
				GROUPCOUNT = id;
			}
			if (re.equals("PLANT")) {
				PLANT = id;
			}
			if (re.equals("SEQUENCE")) {
				SEQUENCE = id;
			}
			if (re.equals("USAGE")) {
				USAGE = id;
			}
		}
		String IDNRK = "";
		String POSNR = "";
		String OPERITEMNO = "";
		String NODEID = "200";
		String str = "00";
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
				if (name.equals("IDNRK")) {
					IDNRK = value;
				}
				if (name.equals("POSNR")) {
					POSNR = value;
				}
				if (name.equals("OPERITEMNO")) {
					OPERITEMNO = (str + value).substring((str + value).length() - 4);
				}

			}
			System.out.println("IDNRK;" + IDNRK);
			System.out.println("POSNR;" + POSNR);

			Map<String, String> logmap = new HashMap<String, String>();
			UUID uuid = UUID.randomUUID();
			System.out.println(uuid.toString().substring(0, 32));
			logmap.put("REQUESTID", rid);
			logmap.put("NODEID", NODEID);
			logmap.put("INF_TIME", INF_TIME);
			if (PRODUCTMATERIALCODE.substring(0, 1).equals("A")) {
				logmap.put("INF_SEQ", String.valueOf(j + 1));
			} else if (PRODUCTMATERIALCODE.substring(0, 1).equals("T")) {
				logmap.put("INF_SEQ", String.valueOf(j + 1001));
			}
			logmap.put("MATNR", PRODUCTMATERIALCODE);
			logmap.put("WERKS", PLANT);
			logmap.put("PLNNR", ROUTERCODE);
			logmap.put("PLNAL", GROUPCOUNT);
			logmap.put("PLNFL", SEQUENCE);
			logmap.put("VORNR", OPERITEMNO);
			logmap.put("IDNRK", IDNRK);
			logmap.put("POSNR", POSNR);
			logmap.put("STLAN", USAGE);
			logmap.put("STLAL", GROUPCOUNT);
			logmap.put("READ_FLAG", "Y");
			logmap.put("INF_MSG", " ");
			logmap.put("INF_FLAG", "S");
			logmap.put("CMF_1", " ");
			logmap.put("CMF_2", " ");
			logmap.put("CMF_3", " ");
			logmap.put("CMF_4", " ");
			logmap.put("CMF_5", " ");
			logmap.put("CMF_6", " ");
			logmap.put("CMF_7", " ");
			logmap.put("CMF_8", " ");
			logmap.put("CMF_9", " ");
			logmap.put("CMF_10", " ");
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

	// 主数据

	private void writelog(List<Map<String, String>> loglist) {
		SapLogWriter.writerlog(loglist, logtablename);

	}

}

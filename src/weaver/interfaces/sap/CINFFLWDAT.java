package weaver.interfaces.sap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import weaver.conn.RecordSet;
import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class CINFFLWDAT {

	private String logtablename = "CINFFLWDAT";

	public void setcinfflwdat(DetailTable dt, MainTableInfo maintableinfo, String rid, String creator) {
		List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
		Property[] Property = maintableinfo.getProperty();

		// 主表
		String PRODUCTMATERIALCODE1 = "";
		String PLANT = "";
		String ROUTERCODE = "";
		String GROUPCOUNT = "";
		String SEQUENCE = "";
		String USAGE = "";
		String UNIT = "";
		String DESCRIPTION = "";

		String id;
		String re;
		for (int ss = 0; ss < Property.length; ++ss) {
			re = Property[ss].getName().toUpperCase();
			if (Util.null2String(Property[ss].getValue()).isEmpty()) {
				id = " ";
			} else {
				id = Util.null2String(Property[ss].getValue());
			}
			if (re.equals("PRODUCTMATERIALCODE1")) {
				PRODUCTMATERIALCODE1 = id;
			}
			if (re.equals("PLANT")) {
				PLANT = id;
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
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
		String udpatetime = sdf.format(date);
		String createtime = sdf.format(date);

		RecordSet rs = new RecordSet();
		String sql = "";
		sql = "select * from workflow_requestbase where REQUESTID = '" + rid + "'";
		rs.executeSql(sql);
		rs.next();
		String INF_TIME = rs.getString("CREATEDATE") + rs.getString("CREATETIME");
		INF_TIME = INF_TIME.replace("-", "").replace(":", "");

		// 明细
		String ITEMNO = "";
		String OPER = "";
		String OPERDEC = "";
		String WORKCENTER = "";
		String UPH = "";
		String RESGID = "";
		String str = "00";
		Row[] s = dt.getRow();
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
				if (name.equals("ITEMNO")) {
					ITEMNO = (str + value).substring((str + value).length()-4);
				}
				if (name.equals("OPERADD")) {
					OPER = value;
				}
				if (name.equals("OPERDEC")) {
					OPERDEC = value;
				}
				if (name.equals("WORK_CENTER_FK")) {
					WORKCENTER = value;
				}
				if (name.equals("UPH")) {
					UPH = value;
				}
				if (name.equals("RESG_ID")) {
					RESGID = value;
				}

			}

			Map<String, String> logmap = new HashMap<String, String>();
			logmap.put("requestid", rid);
			logmap.put("nodeid", "");
			logmap.put("inf_time", INF_TIME);
			if (PRODUCTMATERIALCODE1.substring(0, 1).equals("A")) {
				logmap.put("inf_seq", String.valueOf(j + 1));
			} else if (PRODUCTMATERIALCODE1.substring(0, 1).equals("T")) {
				logmap.put("inf_seq", String.valueOf(j + 1001));
			}
			logmap.put("matnr", PRODUCTMATERIALCODE1);
			logmap.put("werks", PLANT);
			logmap.put("plnnr", ROUTERCODE);
			logmap.put("plnal", GROUPCOUNT);
			logmap.put("plnfl", SEQUENCE);
			logmap.put("vornr", ITEMNO);
			logmap.put("arbpl", WORKCENTER);
			logmap.put("steus", "PP01");
			logmap.put("ktsch", OPER);
			logmap.put("ltxa1", OPERDEC);
			logmap.put("vgw01", "0");
			logmap.put("vgw02", "60");
			logmap.put("vgw03", "60");
			logmap.put("vgw04", "60");
			logmap.put("vgw05", "60");
			logmap.put("vgw06", "60");
			logmap.put("infnr", " ");
			logmap.put("ekorg", " ");
			logmap.put("sakto", " ");
			logmap.put("bmsch", UPH);
			logmap.put("uemus", " ");
			logmap.put("minwe", " ");
			logmap.put("spmus", " ");
			logmap.put("splim", "0");
			logmap.put("umrez", USAGE);
			logmap.put("meinh", UNIT);
			logmap.put("read_flag", "Y");
			logmap.put("inf_msg", " ");
			logmap.put("inf_flag", "S");
			logmap.put("cmf_1", DESCRIPTION);
			logmap.put("cmf_2", " ");
			logmap.put("cmf_3", " ");
			logmap.put("cmf_4", " ");
			logmap.put("cmf_5", RESGID);
			logmap.put("cmf_6", " ");
			logmap.put("cmf_7", " ");
			logmap.put("cmf_8", " ");
			logmap.put("cmf_9", " ");
			logmap.put("cmf_10", " ");
			logmap.put("delete_flag", " ");
			logmap.put("create_time", createtime);
			logmap.put("create_user_id", creator);
			logmap.put("update_time", udpatetime);
			logmap.put("update_user_id", creator);
			logmap.put("delete_time", " ");
			logmap.put("delete_user_id", " ");

			loglist.add(logmap);
			System.out.println("开始执行-------");

			System.out.println("返回数据-------");
		}
		writelog(loglist);
	}

	private void writelog(List<Map<String, String>> loglist) {
		SapLogWriter.writerlog(loglist, logtablename);
	}
}

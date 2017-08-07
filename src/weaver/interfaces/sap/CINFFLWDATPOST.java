package weaver.interfaces.sap;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONObject;

import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class CINFFLWDATPOST {

	private SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static final String url = "http://172.16.60.96:8099/MesWebService/req";
	private BaseBean bb = new BaseBean();
	private String logtablename = "CINFFLWDAT";

	public void setcinfflwdat(DetailTable dt, String rid,
			MainTableInfo maintableinfo, String creator) {
		try {
			BaseBean baseBean = new BaseBean();
			List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
			Property[] Property = maintableinfo.getProperty();
			HttpPost postMethod = new HttpPost(url);
			// CloseableHttpClient client = HttpClients.createDefault();
			JSONObject req = new JSONObject();

			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPLOADMASTERDATA");
			req.put("token", "OATESTTOKEN");

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

			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyyMMddHHmmss");
			String CREATE_TIME = sdf.format(date);
			String UPDATE_TIME = sdf.format(date);
			String INF_TIME = sdf.format(date);

			for (int ss = 0; ss < Property.length; ++ss) {
				re = Property[ss].getName().toUpperCase();
				id = Util.null2String(Property[ss].getValue());
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

			// 明细
			String ITEMNO = "";
			String OPERADD = "";
			String OPERDEC = "";
			String WORKCENTER = "";
			String UPH = "";

			Row[] s = dt.getRow();
			JSONObject message = new JSONObject();
			for (int j = 0; j < s.length; j++) {
				Row r = s[j];// 指定行
				Cell c[] = r.getCell();// 每行数据再按列存储
				for (int k = 0; k < c.length; k++) {
					Cell c1 = c[k];// 指定列
					String name = c1.getName().toUpperCase();// 明细字段名称
					String value = Util.null2String(c1.getValue());// 明细字段的值
					if (name.equals("ITEMNO")) {
						ITEMNO = value;
					}
					if (name.equals("OPER")) {
						OPERADD = value;
					}
					if (name.equals("OPERDEC")) {
						OPERDEC = value;
					}
					if (name.equals("WORKCENTER")) {
						WORKCENTER = value;
					}
					if (name.equals("UPH")) {
						UPH = value;
					}

				}
				Map<String, String> logmap = new HashMap<String, String>();
				JSONObject[] cInfFlwDatList = new JSONObject[s.length];
				cInfFlwDatList[j] = new JSONObject();
				cInfFlwDatList[j].put("InfTime", INF_TIME);
				if (PRODUCTMATERIALCODE1.substring(0, 1).equals("A")) {
					cInfFlwDatList[j].put("InfSeq", String.valueOf(j + 1));
				} else if (PRODUCTMATERIALCODE1.substring(0, 1).equals("T")) {
					cInfFlwDatList[j].put("InfSeq", String.valueOf(j + 1001));
				}
				cInfFlwDatList[j].put("Matnr", PRODUCTMATERIALCODE1);
				cInfFlwDatList[j].put("Werks", PLANT);
				cInfFlwDatList[j].put("Plnnr", ROUTERCODE);
				cInfFlwDatList[j].put("Plnal", GROUPCOUNT);
				cInfFlwDatList[j].put("Plnfl", SEQUENCE);
				cInfFlwDatList[j].put("Vornr", ITEMNO);
				cInfFlwDatList[j].put("Arbpl", WORKCENTER);
				cInfFlwDatList[j].put("Steus", "PP01");
				cInfFlwDatList[j].put("Ktsch", OPERADD);
				cInfFlwDatList[j].put("Ltxa1", OPERDEC);
				cInfFlwDatList[j].put("Vgw01", "0");
				cInfFlwDatList[j].put("Vgw02", "60");
				cInfFlwDatList[j].put("Vgw03", "60");
				cInfFlwDatList[j].put("Vgw04", "60");
				cInfFlwDatList[j].put("Vgw05", "60");
				cInfFlwDatList[j].put("Vgw06", "60");
				cInfFlwDatList[j].put("Infnr", " ");
				cInfFlwDatList[j].put("Ekorg", " ");
				cInfFlwDatList[j].put("Sakto", " ");
				cInfFlwDatList[j].put("Bmsch", UPH);
				cInfFlwDatList[j].put("Uemus", " ");
				cInfFlwDatList[j].put("Minwe", " ");
				cInfFlwDatList[j].put("Spmus", " ");
				cInfFlwDatList[j].put("Splim", " ");
				cInfFlwDatList[j].put("Umrez", USAGE);
				cInfFlwDatList[j].put("Meinh", UNIT);
				cInfFlwDatList[j].put("ReadFlag", " ");
				cInfFlwDatList[j].put("InfMsg", " ");
				cInfFlwDatList[j].put("InfFlag", " ");
				cInfFlwDatList[j].put("Cmf1", DESCRIPTION);
				cInfFlwDatList[j].put("Cmf2", " ");
				cInfFlwDatList[j].put("Cmf3", " ");
				cInfFlwDatList[j].put("Cmf4", " ");
				cInfFlwDatList[j].put("Cmf5", " ");
				cInfFlwDatList[j].put("Cmf6", " ");
				cInfFlwDatList[j].put("Cmf7", " ");
				cInfFlwDatList[j].put("Cmf8", " ");
				cInfFlwDatList[j].put("Cmf9", " ");
				cInfFlwDatList[j].put("Cmf10", " ");
				cInfFlwDatList[j].put("DeleteFlag", " ");
				cInfFlwDatList[j].put("CreateTime", CREATE_TIME);
				cInfFlwDatList[j].put("CreateUserId", creator);
				cInfFlwDatList[j].put("UpdateTime", UPDATE_TIME);
				cInfFlwDatList[j].put("UpdateUserId", creator);
				cInfFlwDatList[j].put("DeleteTime", " ");
				cInfFlwDatList[j].put("DeleteUserId", " ");

				message.put("cInfFlwDatList", cInfFlwDatList);

			}

			req.put("message", message);
			StringEntity SS = new StringEntity(req.toString());
			postMethod.setEntity(SS);
			HttpResponse resps = new DefaultHttpClient().execute(postMethod);
		} catch (java.lang.Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void writelog(List<Map<String, String>> loglist) {
		SapLogWriter.writerlog(loglist, logtablename);

	}
}

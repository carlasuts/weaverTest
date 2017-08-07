package weaver.interfaces.sap;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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

/**
 * Created by Administrator on 2017/2/8.
 */
public class CINFBOMDATPOST {
	private SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static final String url = "http://172.16.60.96:8099/MesWebService/req";
	private BaseBean bb = new BaseBean();
	private String logtablename = "CINFBOMDAT";

	// 芯片
	public void setcinfbomdat(DetailTable dt, String rid,
			MainTableInfo maintableinfo, String creator) {
		try {
			BaseBean baseBean = new BaseBean();
			List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
			Property[] Property = maintableinfo.getProperty();
			HttpPost postMethod = new HttpPost(url);
			// String respContent = null;
			// CloseableHttpClient client = HttpClients.createDefault();
			JSONObject req = new JSONObject();

			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPLOADMASTERDATA");
			req.put("token", "OATESTTOKEN");

			String PRODUCTMATERIALCODE = "";
			String PLANT = "";
			String ROUTERCODE = "";
			String GROUPCOUNT = "";
			String SEQUENCE = "";
			String USAGE = "";
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyyMMddHHmmss");
			String CREATE_TIME = sdf.format(date);
			String UPDATE_TIME = sdf.format(date);
			String INF_TIME = sdf.format(date);

			String id;
			String re;
			for (int ss = 0; ss < Property.length; ++ss) {
				re = Property[ss].getName().toUpperCase();
				id = Util.null2String(Property[ss].getValue());
				if (re.equals("PRODUCTMATERIALCODE")) {
					PRODUCTMATERIALCODE = id;
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
			Row[] s = dt.getRow();// 当前明细表的所有数据,按行存储
			JSONObject message = new JSONObject();
			for (int j = 0; j < s.length; j++) {
				Row r = s[j];// 指定行
				Cell c[] = r.getCell();// 每行数据再按列存储
				for (int k = 0; k < c.length; k++) {
					Cell c1 = c[k];// 指定列
					String name = c1.getName().toUpperCase();// 明细字段名称
					String value = Util.null2String(c1.getValue());// 明细字段的值
					if (name.equals("IDNRK")) {
						IDNRK = value;
					}
					if (name.equals("POSNR")) {
						POSNR = value;
					}
					if (name.equals("OPERITEMNO")) {
						OPERITEMNO = value;
					}

				}

				UUID uuid = UUID.randomUUID();
				System.out.println(uuid.toString().substring(0, 32));

				JSONObject[] cInfBomDatList = new JSONObject[s.length];
				cInfBomDatList[j] = new JSONObject();
				cInfBomDatList[j].put("InfTime", INF_TIME);
				if (PRODUCTMATERIALCODE.substring(0, 1).equals("A")) {
					cInfBomDatList[j].put("InfSeq", String.valueOf(j + 1));
				} else if (PRODUCTMATERIALCODE.substring(0, 1).equals("T")) {
					cInfBomDatList[j].put("InfSeq", String.valueOf(j + 1001));
				}
				cInfBomDatList[j].put("Matnr", PRODUCTMATERIALCODE);
				baseBean.writeLog("Matnr" + PRODUCTMATERIALCODE);
				cInfBomDatList[j].put("Werks", PLANT);
				cInfBomDatList[j].put("Plnnr", ROUTERCODE);
				baseBean.writeLog("Plnnr" + ROUTERCODE);
				cInfBomDatList[j].put("Plnal", GROUPCOUNT);
				cInfBomDatList[j].put("Plnfl", SEQUENCE);
				cInfBomDatList[j].put("Vornr", IDNRK);
				cInfBomDatList[j].put("Idnrk", POSNR);
				cInfBomDatList[j].put("Posnr", OPERITEMNO);
				baseBean.writeLog("Posnr" + OPERITEMNO);
				cInfBomDatList[j].put("Stlan", USAGE);
				cInfBomDatList[j].put("Stlal", GROUPCOUNT);
				cInfBomDatList[j].put("ReadFlag", " ");
				cInfBomDatList[j].put("InfMsg", " ");
				cInfBomDatList[j].put("InfFlag", " ");
				cInfBomDatList[j].put("Cmf1", " ");
				cInfBomDatList[j].put("Cmf2", " ");
				cInfBomDatList[j].put("Cmf3", " ");
				cInfBomDatList[j].put("Cmf4", " ");
				cInfBomDatList[j].put("Cmf5", " ");
				cInfBomDatList[j].put("Cmf6", " ");
				cInfBomDatList[j].put("Cmf7", " ");
				cInfBomDatList[j].put("Cmf8", " ");
				cInfBomDatList[j].put("Cmf9", " ");
				cInfBomDatList[j].put("Cmf10", " ");
				cInfBomDatList[j].put("DeleteFlag", " ");
				cInfBomDatList[j].put("CreateTime", CREATE_TIME);
				cInfBomDatList[j].put("CreateUserId", creator);
				cInfBomDatList[j].put("UpdateTime", UPDATE_TIME);
				cInfBomDatList[j].put("UpdateUserId", creator);
				cInfBomDatList[j].put("DeleteTime", " ");
				cInfBomDatList[j].put("DeleteUserId", " ");

				message.put("cInfBomDatList", cInfBomDatList);

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

}

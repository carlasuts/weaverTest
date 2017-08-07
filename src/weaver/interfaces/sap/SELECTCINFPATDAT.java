package weaver.interfaces.sap;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

public class SELECTCINFPATDAT {

	private static final String url = "http://172.16.60.96:8099/MesWebService/req";
	private String logtablename = "CINFPATDAT";

	public void selectcinfspedat(String rid) throws Exception {

		final String KEY_FROMSYSTEM = "fromSystem";
		final String KEY_FUNCTIONNAME = "functionName";
		final String KEY_TOKEN = "token";
		final String KEY_MESSAGE = "message";

		final String VALUE_FROMSYSTEM = "OA";
		final String VALUE_FUNCTIONAME = "MES_UPLOADMASTERDATA";
		final String VALUE_TOKEN = "OATESTTOKEN";

		HttpPost request = new HttpPost(url);
		// 先封装一个 JSON 对象
		JSONObject param = new JSONObject();
		param.put(KEY_FROMSYSTEM, VALUE_FROMSYSTEM);
		param.put(KEY_FUNCTIONNAME, VALUE_FUNCTIONAME);
		param.put(KEY_TOKEN, VALUE_TOKEN);

		JSONObject message = new JSONObject();

		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		list = SapLogWriter.selectByRequestId(logtablename, rid);
		System.out.println(list.size());
		System.out.println(list.get(0).get("INF_TIME"));
		for (int j = 0; j < list.size(); j++) {
			JSONObject[] cInfPatDatList = new JSONObject[list.size()];
			cInfPatDatList[j] = new JSONObject();
			Map<String, String> data = list.get(j);
			cInfPatDatList[j].put("infTime", data.get("INF_TIME"));
			cInfPatDatList[j].put("infSeq", data.get("INF_SEQ"));
			cInfPatDatList[j].put("matnr", data.get("MANTR"));
			cInfPatDatList[j].put("werks", data.get("WERKS"));
			cInfPatDatList[j].put("stlan", data.get("STLAN"));
			cInfPatDatList[j].put("stlal", data.get("STLAL"));
			cInfPatDatList[j].put("plnnr", data.get("PLNNR"));
			cInfPatDatList[j].put("posnr", data.get("POSNR"));
			cInfPatDatList[j].put("idnrk", data.get("IDNRK"));
			cInfPatDatList[j].put("menge", data.get("MENGE"));
			cInfPatDatList[j].put("meins", data.get("MEINS"));
			cInfPatDatList[j].put("ausch", data.get("AUSCH"));
			cInfPatDatList[j].put("alpgr", data.get("ALPGR"));
			cInfPatDatList[j].put("alprf", data.get("ALPRF"));
			cInfPatDatList[j].put("alpst", data.get("ALPST"));
			cInfPatDatList[j].put("ewahr", data.get("EWAHR"));
			cInfPatDatList[j].put("itsob", data.get("ITSOB"));
			cInfPatDatList[j].put("lgort", data.get("LGORT"));
			cInfPatDatList[j].put("sanka", data.get("SAMKA"));
			cInfPatDatList[j].put("readFlag", data.get("READ_FLAG"));
			cInfPatDatList[j].put("infMsg", data.get("INF_MSG"));
			cInfPatDatList[j].put("infFlag", data.get("INF_FLAG"));
			cInfPatDatList[j].put("cmf1", data.get("CMF_1"));
			cInfPatDatList[j].put("Cmf2", data.get("CMF_2"));
			cInfPatDatList[j].put("Cmf3", data.get("CMF_3"));
			cInfPatDatList[j].put("Cmf4", data.get("CMF_4"));
			cInfPatDatList[j].put("Cmf5", data.get("CMF_5"));
			cInfPatDatList[j].put("Cmf6", data.get("CMF_6"));
			cInfPatDatList[j].put("Cmf7", data.get("CMF_7"));
			cInfPatDatList[j].put("Cmf8", data.get("CMF_8"));
			cInfPatDatList[j].put("Cmf9", data.get("CMF_9"));
			cInfPatDatList[j].put("Cmf10", data.get("CMF_10"));
			cInfPatDatList[j].put("DeleteFlag", data.get("DELETE_FLAG"));
			cInfPatDatList[j].put("CreateTime", data.get("CREATE_TIME"));
			cInfPatDatList[j].put("CreateUserId", data.get("CREATE_USER_ID"));
			cInfPatDatList[j].put("UpdateTime", data.get("UPDATE_TIME"));
			cInfPatDatList[j].put("UpdateUserId", data.get("UPDATE_USER_ID"));
			cInfPatDatList[j].put("DeleteTime", data.get("DELETE_TIME"));
			cInfPatDatList[j].put("DeleteUserId", data.get("DELETE_USER_ID"));

			message.put("cInfPatDatList", cInfPatDatList);

			param.put("message", message);
			// 绑定到请求 Entry
			StringEntity se = new StringEntity(param.toString());
			request.setEntity(se);
			System.out.println(request);
			System.out.println("-----------------------------");

			System.out.println("param: " + param.toString());
			System.out.println("-----------------------------");
			// 发送请求
			HttpResponse httpResponse = new DefaultHttpClient()
					.execute(request);
			// 得到应答的字符串，这也是一个 JSON 格式保存的数据
			String retSrc = EntityUtils.toString(httpResponse.getEntity());
			System.out.println(retSrc);
		}

	}
}

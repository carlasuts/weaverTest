package weaver.interfaces.sap;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

public class TESTCINFPATDATPOST {

	private static final String url = "http://172.16.60.96:8099/MesWebService/req";

	public static void test() throws Exception {
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

		JSONObject[] cInfPatDatList = new JSONObject[1];
		cInfPatDatList[0] = new JSONObject();
		cInfPatDatList[0].put("infTime", "TESTinfTime_1");
		cInfPatDatList[0].put("infSeq", "1");
		cInfPatDatList[0].put("matnr", "TESTmatnr_1");
		cInfPatDatList[0].put("werks", "TESTwerks_1");
		cInfPatDatList[0].put("stlan", "TESTstlan_1");
		cInfPatDatList[0].put("stlal", "TESTstlal_1");
		cInfPatDatList[0].put("plnnr", "TESTplnnr_1");
		cInfPatDatList[0].put("posnr", "TESTposnr_1");
		cInfPatDatList[0].put("idnrk", "TESTidnrk_1");
		cInfPatDatList[0].put("menge", "TESTmenge_1");
		cInfPatDatList[0].put("meins", "TESTmeins_1");
		cInfPatDatList[0].put("ausch", "TESTausch_1");
		cInfPatDatList[0].put("alpgr", "TESTalpgr_1");
		cInfPatDatList[0].put("alprf", "TESTalprf_1");
		cInfPatDatList[0].put("alpst", "TESTalpst");
		cInfPatDatList[0].put("ewahr", "TESTewahr");
		cInfPatDatList[0].put("itsob", "TESTitsob");
		cInfPatDatList[0].put("lgort", "TESTlgort");
		cInfPatDatList[0].put("sanka", "TESTsanka");
		cInfPatDatList[0].put("readFlag", " ");
		cInfPatDatList[0].put("infMsg", "TESTinfMsg");
		cInfPatDatList[0].put("infFlag", " ");
		cInfPatDatList[0].put("cmf1", "TESTcmf1");
		cInfPatDatList[0].put("Cmf2", "FLAG");
		cInfPatDatList[0].put("Cmf3", "100");
		cInfPatDatList[0].put("Cmf4", "FLAG");
		cInfPatDatList[0].put("Cmf5", "100");
		cInfPatDatList[0].put("Cmf6", "FLAG");
		cInfPatDatList[0].put("Cmf7", "100");
		cInfPatDatList[0].put("Cmf8", "FLAG");
		cInfPatDatList[0].put("Cmf9", "100");
		cInfPatDatList[0].put("Cmf10", "FLAG");
		cInfPatDatList[0].put("DeleteFlag", "100");
		cInfPatDatList[0].put("CreateTime", "FLAG");
		cInfPatDatList[0].put("CreateUserId", "100");
		cInfPatDatList[0].put("UpdateTime", "FLAG");
		cInfPatDatList[0].put("UpdateUserId", "100");
		cInfPatDatList[0].put("DeleteTime", "FLAG");
		cInfPatDatList[0].put("DeleteUserId", "100");

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
		HttpResponse httpResponse = new DefaultHttpClient().execute(request);
		// 得到应答的字符串，这也是一个 JSON 格式保存的数据
		String retSrc = EntityUtils.toString(httpResponse.getEntity());
		System.out.println(retSrc);
	}

	public static void main(String args[]) {
		try {
			test();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

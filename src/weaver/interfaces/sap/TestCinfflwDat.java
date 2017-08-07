package weaver.interfaces.sap;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

public class TestCinfflwDat {
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

		JSONObject[] cInfFlwDatList = new JSONObject[1];
		cInfFlwDatList[0] = new JSONObject();
		cInfFlwDatList[0].put("InfTime", "FLAG");
		cInfFlwDatList[0].put("InfSeq", "100");
		cInfFlwDatList[0].put("Matnr", "FLAG");
		cInfFlwDatList[0].put("Werks", "100");
		cInfFlwDatList[0].put("Plnnr", "FLAG");
		cInfFlwDatList[0].put("Plnal", "100");
		cInfFlwDatList[0].put("Plnfl", "FLAG");
		cInfFlwDatList[0].put("Vornr", "100");
		cInfFlwDatList[0].put("Arbpl", "FLAG");
		cInfFlwDatList[0].put("Steus", "100");
		cInfFlwDatList[0].put("Ktsch", "FLAG");
		cInfFlwDatList[0].put("Ltxa1", "100");
		cInfFlwDatList[0].put("Vgw01", "FLAG");
		cInfFlwDatList[0].put("Vgw02", "100");
		cInfFlwDatList[0].put("Vgw03", "FLAG");
		cInfFlwDatList[0].put("Vgw04", "100");
		cInfFlwDatList[0].put("Vgw05", "FLAG");
		cInfFlwDatList[0].put("Vgw06", "100");
		cInfFlwDatList[0].put("Infnr", "FLAG");
		cInfFlwDatList[0].put("Ekorg", "100");
		cInfFlwDatList[0].put("Sakto", "FLAG");
		cInfFlwDatList[0].put("Bmsch", "100");
		cInfFlwDatList[0].put("Uemus", "FLAG");
		cInfFlwDatList[0].put("Minwe", "100");
		cInfFlwDatList[0].put("Spmus", "FLAG");
		cInfFlwDatList[0].put("Splim", "100");
		cInfFlwDatList[0].put("Umrez", "FLAG");
		cInfFlwDatList[0].put("Meinh", "100");
		cInfFlwDatList[0].put("ReadFlag", "FLAG");
		cInfFlwDatList[0].put("InfMsg", "100");
		cInfFlwDatList[0].put("InfFlag", "FLAG");
		cInfFlwDatList[0].put("Cmf1", "100");
		cInfFlwDatList[0].put("Cmf2", "FLAG");
		cInfFlwDatList[0].put("Cmf3", "100");
		cInfFlwDatList[0].put("Cmf4", "FLAG");
		cInfFlwDatList[0].put("Cmf5", "100");
		cInfFlwDatList[0].put("Cmf6", "FLAG");
		cInfFlwDatList[0].put("Cmf7", "100");
		cInfFlwDatList[0].put("Cmf8", "FLAG");
		cInfFlwDatList[0].put("Cmf9", "100");
		cInfFlwDatList[0].put("Cmf10", "FLAG");
		cInfFlwDatList[0].put("DeleteFlag", "100");
		cInfFlwDatList[0].put("CreateTime", "FLAG");
		cInfFlwDatList[0].put("CreateUserId", "100");
		cInfFlwDatList[0].put("UpdateTime", "FLAG");
		cInfFlwDatList[0].put("UpdateUserId", "100");
		cInfFlwDatList[0].put("DeleteTime", "FLAG");
		cInfFlwDatList[0].put("DeleteUserId", "100");

		message.put("cInfPatDatList", cInfFlwDatList);

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

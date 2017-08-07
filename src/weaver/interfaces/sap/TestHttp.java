package weaver.interfaces.sap;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Scanner;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.junit.Test;

public class TestHttp {

	private static final String url = "http://172.16.60.96:8099/MesWebService/req";



	@Test
	public void t2() throws ParseException, IOException {
		HttpPost request = new HttpPost(url);
		// 先封装一个 JSON 对象
		JSONObject param = new JSONObject();
		param.put("fromSystem", "OA");
		param.put("functionName", "MES_GETOATESTYIELD");
		param.put("token", "OATESTTOKEN");
		// 绑定到请求 Entry
		StringEntity se = new StringEntity(param.toString());
		request.setEntity(se);
		System.out.println(request);
		System.out.println(param.toString());
		// 发送请求
		HttpResponse httpResponse = new DefaultHttpClient().execute(request);
		// 得到应答的字符串，这也是一个 JSON 格式保存的数据
		String retSrc = EntityUtils.toString(httpResponse.getEntity());
		System.out.println(retSrc);
		
		JSONObject result = JSONObject.fromObject(retSrc);
		System.out.println("--------------------");
		System.out.println(result.toString());
		Object ListTestYieldList = result.get("oaTestYieldList");
		System.out.println(ListTestYieldList);
		System.out.println("--------------------");

		JSONArray temp = JSONArray.fromObject(ListTestYieldList);
		for (Object obj : temp) {
			System.out.println(obj);
		}
		// 生成 JSON 对象
		// JSONArray jsonObject = JSONArray.fromObject(retSrc);
		// System.out.println(jsonObject);
		// JSONObject result = new JSONObject(retSrc);
		// String token = result.get("token");
	}

	@Test
	public void t3() throws ClientProtocolException, IOException {
		HttpPost request = new HttpPost(url);
		// 先封装一个 JSON 对象
		JSONObject param = new JSONObject();
		param.put("fromSystem", "OA");
		param.put("functionName", "MES_UPDATEOATESTYIELDINFO");
		param.put("token", "OATESTTOKEN");

		JSONObject message = new JSONObject();
		message.put("id", 376);

		JSONObject[] updateInfos = new JSONObject[3];
		updateInfos[0] = new JSONObject();
		updateInfos[0].put("updateField", "RESV_FIELD10");
		updateInfos[0].put("updateValue", "1");
		updateInfos[1] = new JSONObject();
		updateInfos[1].put("updateField", "FLAG");
		updateInfos[1].put("updateValue", "100");
		updateInfos[2] = new JSONObject();
		updateInfos[2].put("updateField", "RESV_FIELD9");
		updateInfos[2].put("updateValue", "test");

		message.put("updateInfoList", updateInfos);

		param.put("message", message);

		// 绑定到请求 Entry
		StringEntity se = new StringEntity(param.toString());
		request.setEntity(se);
		System.out.println(request);
		System.out.println("-----------------------------");

		System.out.println("param: "  + param.toString());
		System.out.println("-----------------------------");
		// 发送请求
		HttpResponse httpResponse = new DefaultHttpClient().execute(request);
		// 得到应答的字符串，这也是一个 JSON 格式保存的数据
		String retSrc = EntityUtils.toString(httpResponse.getEntity());
		System.out.println(retSrc);
	}
	
	@Test
	public void tMTK() throws ClientProtocolException, IOException {
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

		
		
		JSONObject[] cInfBomDatList = new JSONObject[1];
        cInfBomDatList[0] = new JSONObject();
		cInfBomDatList[0].put("InfTime", "FLAG");
		cInfBomDatList[0].put("InfSeq", "100");
		cInfBomDatList[0].put("Matnr", "FLAG");
		cInfBomDatList[0].put("Werks", "100");
		cInfBomDatList[0].put("Plnnr", "FLAG");
		cInfBomDatList[0].put("Plnal", "100");
		cInfBomDatList[0].put("Plnfl", "FLAG");
		cInfBomDatList[0].put("Vornr", "100");
		cInfBomDatList[0].put("Idnrk", "FLAG");
		cInfBomDatList[0].put("Posnr", "100");
		cInfBomDatList[0].put("Stlan", "FLAG");
		cInfBomDatList[0].put("Stlal", "100");
		cInfBomDatList[0].put("ReadFlag", "FLAG");
		cInfBomDatList[0].put("InfMsg", "100");
		cInfBomDatList[0].put("InfFlag", "FLAG");
		cInfBomDatList[0].put("Cmf1", "100");
		cInfBomDatList[0].put("Cmf2", "FLAG");
		cInfBomDatList[0].put("Cmf3", "100");
		cInfBomDatList[0].put("Cmf4", "FLAG");
		cInfBomDatList[0].put("Cmf5", "100");
		cInfBomDatList[0].put("Cmf6", "FLAG");
		cInfBomDatList[0].put("Cmf7", "100");
		cInfBomDatList[0].put("Cmf8", "FLAG");
		cInfBomDatList[0].put("Cmf9", "100");
		cInfBomDatList[0].put("Cmf10", "FLAG");
		cInfBomDatList[0].put("DeleteFlag", "100");
		cInfBomDatList[0].put("CreateTime", "FLAG");
		cInfBomDatList[0].put("CreateUserId", "100");
		cInfBomDatList[0].put("UpdateTime", "FLAG");
		cInfBomDatList[0].put("UpdateUserId", "100");
		cInfBomDatList[0].put("DeleteTime", "FLAG");
		cInfBomDatList[0].put("DeleteUserId", "100");


		message.put("cInfBomDatList", cInfBomDatList);
		
		

		param.put("message", message);

		// 绑定到请求 Entry
		StringEntity se = new StringEntity(param.toString());
		request.setEntity(se);
		System.out.println(request);
		System.out.println("-----------------------------");

		System.out.println("param: "  + param.toString());
		System.out.println("-----------------------------");
		// 发送请求
		HttpResponse httpResponse = new DefaultHttpClient().execute(request);
		// 得到应答的字符串，这也是一个 JSON 格式保存的数据
		String retSrc = EntityUtils.toString(httpResponse.getEntity());
		System.out.println(retSrc);
	}
}

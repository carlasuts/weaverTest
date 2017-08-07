package weaver.interfaces.workflow.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import weaver.general.BaseBean;
import weaver.soa.workflow.request.RequestInfo;

public class MESPOSTCINFFLWDAT implements Action {

	private static final String url = "http://172.16.60.96:8099/MesWebService/req";

	@Override
	public String execute(RequestInfo request) {
		try {
			List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
			BaseBean baseBean = new BaseBean();
			HttpPost postMethod = new HttpPost(url);

			JSONObject param = new JSONObject();
			param.put("fromSystem", "OA");
			param.put("functionName", "MES_UPLOADMASTERDATA");
			param.put("token", "OATESTTOKEN");
			StringEntity se = new StringEntity(param.toString());
			postMethod.setEntity(se);
			HttpResponse resp = new DefaultHttpClient().execute(postMethod);
			String retSrc = EntityUtils.toString(resp.getEntity());
			JSONObject result = new JSONObject(retSrc);
			String cInfFlwDatList = result.get("cInfFlwDatList").toString();

			JSONArray content = new JSONArray(cInfFlwDatList);
			for (int i = 0; i < content.length(); i++) {
				JSONObject p = (JSONObject) content.get(i);
				String INF_TIME = (String) p.get("InfTime").toString();
				String INF_SEQ = (String) p.get("InfSeq").toString();
				String MATNR = (String) p.get("Matnr").toString();
				String WERKS = (String) p.get("Werks").toString();
				String PLNNR = (String) p.get("Plnnr").toString();
				String PLNAL = (String) p.get("Plnal").toString();
				String PLNFL = (String) p.get("Plnfl").toString();
				String VORNR = (String) p.get("Vornr").toString();
				String ARBPL = (String) p.get("Arbpl").toString();
				String STEUS = (String) p.get("Steus").toString();
				String KTSCH = (String) p.get("Ktsch").toString();
				String LTXAL = (String) p.get("Ltxa1").toString();
				String VGW01 = (String) p.get("Vgw01").toString();
				String VGW02 = (String) p.get("Vgw02").toString();
				String VGW03 = (String) p.get("Vgw03").toString();
				String VGW04 = (String) p.get("Vgw04").toString();
				String VGW05 = (String) p.get("Vgw05").toString();
				String VGW06 = (String) p.get("Vgw06").toString();
				String INFNR = (String) p.get("Infnr").toString();
				String EKORG = (String) p.get("Ekorg").toString();
				String SAKTO = (String) p.get("Sakto").toString();
				String BMSCH = (String) p.get("Bmsch").toString();
				String UEMUS = (String) p.get("Uemus").toString();
				String MINWE = (String) p.get("Minwe").toString();
				String SPMUS = (String) p.get("Spmus").toString();
				String SPLIM = (String) p.get("Splim").toString();
				String UMREZ = (String) p.get("Umrez").toString();
				String MEINH = (String) p.get("Meinh").toString();
				String READFLAG = (String) p.get("ReadFlag").toString();
				String INFMSG = (String) p.get("InfMsg").toString();
				String INFFLAG = (String) p.get("InfFlag").toString();
				String CMF1 = (String) p.get("Cmf1").toString();
				String CMF2 = (String) p.get("Cmf2").toString();
				String CMF3 = (String) p.get("Cmf3").toString();
				String CMF4 = (String) p.get("Cmf4").toString();
				String CMF5 = (String) p.get("Cmf5").toString();
				String CMF6 = (String) p.get("Cmf6").toString();
				String CMF7 = (String) p.get("Cmf7").toString();
				String CMF8 = (String) p.get("Cmf8").toString();
				String CMF9 = (String) p.get("Cmf9").toString();
				String CMF10 = (String) p.get("Cmf10").toString();
				String DELETEFLAG = (String) p.get("DeleteFlag").toString();
				String CREATETIME = (String) p.get("CreateTime").toString();
				String CREATEUSERID = (String) p.get("CreateUserId").toString();
				String UPDATETIME = (String) p.get("UpdateTime").toString();
				String UPDATEUSERID = (String) p.get("UpdateUserId").toString();
				String DELETETIME = (String) p.get("DeleteTime").toString();
				String DELETEUSERID = (String) p.get("DeleteUserId").toString();

				JSONObject req = new JSONObject();
				req.put("fromSystem", "OA");
				req.put("functionName", "MES_MTKRELEASEANDADAPT");
				req.put("token", "OATESTTOKEN");

				JSONObject message = new JSONObject();
				message.put("inf_time", INF_TIME);
				message.put("inf_seq", INF_SEQ);
				message.put("matnr", MATNR);
				message.put("werks", WERKS);
				message.put("plnnr", PLNNR);
				message.put("plnal", PLNAL);
				message.put("plnfl", PLNFL);
				message.put("vornr", VORNR);
				message.put("arbpl", ARBPL);
				message.put("steus", STEUS);
				message.put("ktsch", KTSCH);
				message.put("ltxa1", LTXAL);
				message.put("vgw01", VGW01);
				message.put("vgw02", VGW02);
				message.put("vgw03", VGW03);
				message.put("vgw04", VGW04);
				message.put("vgw05", VGW05);
				message.put("vgw06", VGW06);
				message.put("infnr", INFNR);
				message.put("ekorg", EKORG);
				message.put("sakto", SAKTO);
				message.put("bmsch", BMSCH);
				message.put("uemus", UEMUS);
				message.put("minwe", MINWE);
				message.put("spmus", SPMUS);
				message.put("splim", SPLIM);
				message.put("umrez", UMREZ);
				message.put("meinh", MEINH);
				message.put("read_flag", READFLAG);
				message.put("inf_msg", INFMSG);
				message.put("inf_flag", INFFLAG);
				message.put("cmf_1", CMF1);
				message.put("cmf_2", CMF2);
				message.put("cmf_3", CMF3);
				message.put("cmf_4", CMF4);
				message.put("cmf_5", CMF5);
				message.put("cmf_6", CMF6);
				message.put("cmf_7", CMF7);
				message.put("cmf_8", CMF8);
				message.put("cmf_9", CMF9);
				message.put("cmf_10", CMF10);
				message.put("delete_flag", DELETEFLAG);
				message.put("create_time", CREATETIME);
				message.put("create_user_id", CREATEUSERID);
				message.put("update_time", UPDATETIME);
				message.put("update_user_id", UPDATEUSERID);
				message.put("delete_time", DELETETIME);
				message.put("delete_user_id", DELETEUSERID);
				
				JSONObject[] updateInfos = new JSONObject[1];
				updateInfos[0] = new JSONObject();
				updateInfos[0].put("updateField", "FLAG");
				updateInfos[0].put("updateValue", "100");

				message.put("updateInfoList", updateInfos);

				req.put("message", message);
				
				StringEntity SS = new StringEntity(req.toString());
				postMethod.setEntity(SS);
				HttpResponse resps = new DefaultHttpClient().execute(postMethod);
				
				String retSrcs = EntityUtils.toString(resps.getEntity());
				baseBean.writeLog("retSrcs"  + retSrcs );
				JSONObject results = new JSONObject(retSrcs);
				baseBean.writeLog("results"  + results );
			}
		} catch (java.lang.Exception e) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("MESPOSTCINFFLWDAT error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

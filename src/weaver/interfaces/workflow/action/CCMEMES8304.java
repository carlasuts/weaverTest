package weaver.interfaces.workflow.action;

import org.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.schedule.CCMEMES83SCH;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CCMEMES8304 implements Action {

	private static final String url = "http://172.16.60.96:8090/MesWebService/req";
	public  static final String token ="AWK18VSE25SDNKLS3AET@EWL#LDG*!F";
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();


			String id = ""; String cz = ""; String mescz = ""; String tecz = "";
			String sql = "";
			Property[] properties = request.getMainTableInfo().getProperty();
			for (int i = 0; i < properties.length; i++) {
				String name = properties[i].getName().toUpperCase();
				String value = Util.null2String(properties[i].getValue());
				//ID
				if(name.equals("TIGGERID")){
					id = value;
				}
				//处置
				if(name.equals("TECZPD")){
					cz = value;
				}
				//MES处置
				if(name.equals("MCZ")){
					mescz = value;
				}
				//TE处理结论
				if(name.equals("TECZ")){
					tecz = value;
				}
			}
			baseBean.writeLog("tecz:" + tecz);
			if (tecz.length() > 15) {
				tecz = tecz.substring(0, 15);
			}
			baseBean.writeLog("tecz:" + tecz);
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String udpatetime = sdf.format(date);
			String workcode = "";

			RecordSet rs = new RecordSet();
			String hrmid = request.getLastoperator();
			sql = "select workcode from hrmresource where id = " + hrmid;
			baseBean.writeLog(sql);
			rs.execute(sql);


			JSONObject req = new JSONObject();
			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPDATEOATESTYIELDINFO");
			req.put("token", token);

			JSONObject message = new JSONObject();
			message.put("id", id);

			JSONObject[] updateInfos = new JSONObject[5];

			if (rs.next()) {
				workcode = rs.getString("workcode");
			}
			sql = "update LLYC_MIDDLE set flag = '200'";

			updateInfos[0] = new JSONObject();
			updateInfos[0].put("updateField", "FLAG");
			updateInfos[0].put("updateValue", "200");

			if (!workcode.equals("")) {
				sql = sql + ",resv_field1='" + workcode + "'";
				updateInfos[1] = new JSONObject();
				updateInfos[1].put("updateField", "RESV_FIELD1");
				updateInfos[1].put("updateValue", workcode);
			}else{
				updateInfos[1] = new JSONObject();
				updateInfos[1].put("updateField", "RESV_FIELD1");
				updateInfos[1].put("updateValue", " ");
			}
			if (!mescz.equals("")) {
				sql = sql + ",resv_field2 = '" + mescz + "'";
				updateInfos[2] = new JSONObject();
				updateInfos[2].put("updateField", "RESV_FIELD2");
				updateInfos[2].put("updateValue", mescz);
			}else{
				updateInfos[2] = new JSONObject();
				updateInfos[2].put("updateField", "RESV_FIELD2");
				updateInfos[2].put("updateValue", " ");
			}
			if (!tecz.equals("")) {
				sql = sql + ",resv_field4 = '" + tecz + "'";
				updateInfos[3] = new JSONObject();
				updateInfos[3].put("updateField", "RESV_FIELD4");
				updateInfos[3].put("updateValue", tecz);
			}else{
				updateInfos[3] = new JSONObject();
				updateInfos[3].put("updateField", "RESV_FIELD4");
				updateInfos[3].put("updateValue", " ");
			}
			sql = sql + ",UPDATE_TIME = '" + udpatetime + "' where id = " + id;
			updateInfos[4] = new JSONObject();
			updateInfos[4].put("updateField", "UPDATE_TIME");
			updateInfos[4].put("updateValue", udpatetime);
			message.put("updateInfoList", updateInfos);
			req.put("message", message);

			String retSrcs = CCMEMES83SCH.readInterfacePost(url,req.toString());

			JSONObject results = new JSONObject(retSrcs);
			String statusValue = results.get("statusValue").toString();
			if(statusValue.equals("0")){
				baseBean.writeLog(sql);
				rs.execute(sql);
			}
		}
		catch (Exception e) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("NFMEMES12241 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

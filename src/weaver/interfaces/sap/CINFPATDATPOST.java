package weaver.interfaces.sap;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class CINFPATDATPOST {

	private static final String url = "http://172.16.60.96:8099/MesWebService/req";

	public String setcinfpatdat(DetailTable dt, String rid,
			MainTableInfo maintableinfo, String creator) {
		try {
			BaseBean baseBean = new BaseBean();
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String CREATE_TIME = sdf.format(date);
			String UPDATE_TIME = sdf.format(date);
			String INF_TIME = sdf.format(date);

			/**
			 * 主表
			 */
			Property[] Property = maintableinfo.getProperty();// 获取表单主字段数据
			for (int i = 0; i < Property.length; i++) {// 主表数据
				String name = Property[i].getName().toUpperCase();// 主表字段名
				String value = "";
				if (Util.null2String(Property[i].getValue()).isEmpty()) {
					value = Util.null2String(Property[i].getValue());// 值
				}
				if (name.equals("PRODUCTMATERIALCODE")) {
					String ProductMaterialCode = value;
				}
				if (name.equals("PLANT")) {
					String Plant = value;
				}
				if (name.equals("USAGE")) {
					String Usage = value;
				}
				if (name.equals("ALTERNATIVEBOM")) {
					String AlternativeBom = value;
				}
			}

			/**
			 * 明细
			 */
			String POSNR = "";
			String IDNRK = "";
			String MENGE = "";
			String MEINS = "";
			String SILKQTY = "";
			String ALPGR = "";
			String ALPRF = "";
			String ALPST = "";
			String LGORT = "";
			String SANKA = "";
			String ProductMaterialCode = "";
			String Plant = "";
			String Usage = "";
			String AlternativeBom = "";

			Row[] rows = dt.getRow();
			JSONObject req = new JSONObject();
			JSONArray jsonArray = new JSONArray();
			JSONObject[] cInfPatDatList = new JSONObject[rows.length];

			for (int i = 0; i < rows.length; i++) {
				Row row = rows[i];// 指定行
				Cell cell[] = row.getCell();// 每行数据再按列存储
				for (int j = 0; j < cell.length; j++) {
					Cell cells = cell[j];// 指定列
					String name = cells.getName().toUpperCase();// 明细字段名
					String value = "";
					if (!Util.null2String(cells.getValue()).isEmpty()) {
						value = Util.null2String(cells.getValue());
					}
					if (name.equals("POSNR")) {
						POSNR = value;
					}
					if (name.equals("IDNRK")) {
						IDNRK = value;
					}
					if (name.equals("MENGE")) {
						MENGE = value;
					}
					if (name.equals("MEINS")) {
						MEINS = value;
					}
					if (name.equals("SILKQTY")) {
						SILKQTY = value;
					}
					if (name.equals("ALPGR")) {
						ALPGR = value;
					}
					if (name.equals("ALPRF")) {
						ALPRF = value;
					}
					if (name.equals("ALPST")) {
						ALPST = value;
					}
					if (name.equals("LGORT")) {
						LGORT = value;
					}
					if (name.equals("SANKA")) {
						SANKA = value;
					}
				}
				req.put("fromSystem", "OA");
				req.put("functionName", "MES_UPLOADMASTERDATA");
				req.put("token", "OATESTTOKEN");

				req.put("infTime", INF_TIME);
				jsonArray.put(req);

				JSONObject message = new JSONObject();
				cInfPatDatList[i] = new JSONObject();
				cInfPatDatList[i].put("infTime", INF_TIME);
				cInfPatDatList[i].put("infSeq", String.valueOf(i + 1));
				cInfPatDatList[i].put("matnr", ProductMaterialCode);
				cInfPatDatList[i].put("werks", Plant);
				cInfPatDatList[i].put("stlan", Usage);
				cInfPatDatList[i].put("stlal", AlternativeBom);
				cInfPatDatList[i].put("plnnr", " ");
				cInfPatDatList[i].put("posnr", POSNR);
				cInfPatDatList[i].put("idnrk", IDNRK);
				cInfPatDatList[i].put("menge", MENGE);
				cInfPatDatList[i].put("meins", MEINS);
				cInfPatDatList[i].put("ausch", SILKQTY);
				cInfPatDatList[i].put("alpgr", ALPGR);
				cInfPatDatList[i].put("alprf", ALPRF);
				cInfPatDatList[i].put("alpst", ALPST);
				cInfPatDatList[i].put("ewahr", " ");
				cInfPatDatList[i].put("itsob", " ");
				cInfPatDatList[i].put("lgort", LGORT);
				cInfPatDatList[i].put("sanka", SANKA);
				cInfPatDatList[i].put("readFlag", " ");
				cInfPatDatList[i].put("infMsg", " ");
				cInfPatDatList[i].put("infFlag", " ");
				cInfPatDatList[i].put("cmf1", " ");
				cInfPatDatList[i].put("cmf2", " ");
				cInfPatDatList[i].put("cmf3", " ");
				cInfPatDatList[i].put("cmf4", " ");
				cInfPatDatList[i].put("cmf5", " ");
				cInfPatDatList[i].put("cmf6", " ");
				cInfPatDatList[i].put("cmf7", " ");
				cInfPatDatList[i].put("cmf8", " ");
				cInfPatDatList[i].put("cmf9", " ");
				cInfPatDatList[i].put("cmf10", " ");
				cInfPatDatList[i].put("deleteFlag", " ");
				cInfPatDatList[i].put("createTime", CREATE_TIME);
				cInfPatDatList[i].put("createUserId", creator);
				cInfPatDatList[i].put("updateTime", UPDATE_TIME);
				cInfPatDatList[i].put("updateUserId", creator);
				cInfPatDatList[i].put("deleteTime", " ");
				cInfPatDatList[i].put("deleteUserId", " ");
				message.put("cInfPatDatList", cInfPatDatList);

				req.put("message", message);
				baseBean.writeLog("req" + req);
				String retSrcs = HttpClientJson.readInterfacePost(url,
						req.toString());
				baseBean.writeLog(req.toString());
				JSONObject results = new JSONObject(retSrcs);
				String statusValue = results.get("statusValue").toString();
				String msg = results.get("msg").toString();
				baseBean.writeLog("retSrcs--" + retSrcs);
				baseBean.writeLog("statusValue--" + statusValue);
				baseBean.writeLog("msg--" + msg);
			}
		} catch (JSONException e) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("CINFPATDATTest error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

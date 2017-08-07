package weaver.interfaces.sap;

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

public class CINFPATDATTest {

	private static final String url = "http://172.16.60.96:8099/MesWebService/req";

	public String execute(DetailTable dt, String rid,
			MainTableInfo maintableinfo, String creator) {

		try {
			BaseBean baseBean = new BaseBean();
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyyMMddHHmmss");
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
			String ProductMaterialCode = "", Plant = "", Usage = "", AlternativeBom = "";
			Row[] rows = dt.getRow();
			baseBean.writeLog("rows的长度" + rows.length);
			JSONObject req = new JSONObject();
			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPLOADMASTERDATA");
			req.put("token", "OATESTTOKEN");
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
				JSONObject message = new JSONObject();
				message.put("InfTime", INF_TIME);
				message.put("infSeq", String.valueOf(i + 1));
				message.put("matnr", ProductMaterialCode);
				message.put("werks", Plant);
				message.put("stlan", Usage);
				message.put("stlal", AlternativeBom);
				message.put("plnnr", " ");
				message.put("posnr", POSNR);
				message.put("idnrk", IDNRK);
				message.put("menge", MENGE);
				message.put("meins", MEINS);
				message.put("ausch", SILKQTY);
				message.put("alpgr", ALPGR);
				message.put("alprf", ALPRF);
				message.put("alpst", ALPST);
				message.put("ewahr", " ");
				message.put("itsob", " ");
				message.put("lgort", LGORT);
				message.put("sanka", SANKA);
				message.put("readFlag", " ");
				message.put("infMsg", " ");
				message.put("infFlag", " ");
				message.put("cmf1", " ");
				message.put("Cmf2", " ");
				message.put("Cmf3", " ");
				message.put("Cmf4", " ");
				message.put("Cmf5", " ");
				message.put("Cmf6", " ");
				message.put("Cmf7", " ");
				message.put("Cmf8", " ");
				message.put("Cmf9", " ");
				message.put("Cmf10", " ");
				message.put("DeleteFlag", " ");
				message.put("CreateTime", CREATE_TIME);
				message.put("CreateUserId", creator);
				message.put("UpdateTime", UPDATE_TIME);
				message.put("UpdateUserId", creator);
				message.put("DeleteTime", " ");
				message.put("DeleteUserId", " ");

				req.put("message", message);
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

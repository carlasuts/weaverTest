package weaver.interfaces.sap;

import java.text.SimpleDateFormat;
import java.util.Date;

import net.sf.json.JSONArray;

import org.json.JSONException;
import org.json.JSONObject;

import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class Test2 {

	private static final String url = "http://172.16.60.96:8099/MesWebService/req";
	private BaseBean baseBean = new BaseBean();
	private String value = "";
	private String name = "";

	public void setcinfpatdat(DetailTable detailTable, String rid,
			MainTableInfo maintableinfo, String creator) {
		baseBean.writeLog("*****setcinfpatdat开始执行*****");
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String CREATE_TIME = sdf.format(date);// 创建时间
		String UPDATE_TIME = sdf.format(date);// 更新时间
		String INF_TIME = sdf.format(date);// 我也不懂这是什么时间
		String ProductMaterialCode = "";
		String Plant = "";
		String Usage = "";
		String AlternativeBom = "";

		/**
		 * 主表
		 */
		Property[] properties = maintableinfo.getProperty();// 获取表单主字段数据
		for (int i = 0; i < properties.length; i++) {// 主表数据
			name = properties[i].getName().toUpperCase();// 主表字段名
			if (!Util.null2String(properties[i].getValue()).isEmpty()) {// 如果该字段不为空
				value = Util.null2String(properties[i].getValue());// 值
			}
			if (name.equals("PRODUCTMATERIALCODE")) {
				ProductMaterialCode = value;
			}
			if (name.equals("PLANT")) {
				Plant = value;
			}
			if (name.equals("USAGE")) {
				Usage = value;
			}
			if (name.equals("ALTERNATIVEBOM")) {
				AlternativeBom = value;
			}
			// 以上是主表字段

			/**
			 * 明细
			 */
			String AlternativeText = "";// 可选BOM文本
			String POSNR = "";// 组件项目
			String IDNRK = "";// 组件
			String OPERITEMNO = "";// 工序项目号
			String OPERDESC = "";// 工序描述
			String INVNAME = "";// 材料名称
			String MENGE = "";// 组件数量
			String SILKQTY = "";// 丝数
			String MEINS = "";// 组件计量单位
			String ALPGR = "";// 替代组
			String ALPRF = "";// 替代组优先级
			String ALPST = "";// 替代组策略
			String ALPM = "";// 替代组使用可能
			String LGORT = "";// 生产仓存地点
			String SANKA = "";// 成本核算相关
			String BumpQTY = "";// Bump球数
			// 以上是明细表字段

			Row[] rows = detailTable.getRow();
			JSONObject req = new JSONObject();
			JSONObject message = new JSONObject();
			JSONObject shell = new JSONObject();
			JSONArray cInfPatDatList = new JSONArray();
			for (int j = 0; j < rows.length; j++) {
				Row row = rows[j];// 指定行
				Cell[] cells = row.getCell();// 每行数据再按列存储
				for (int k = 0; k < cells.length; k++) {
					Cell cell = cells[k];// 指定列
					name = cell.getName().toUpperCase();// 明细字段名
					if (!Util.null2String(cell.getValue()).isEmpty()) {
						value = Util.null2String(cell.getValue());
					}
					if (name.equals("ALTERNATIVETEXT")) {
						AlternativeText = value;
					}
					if (name.equals("POSNR")) {
						POSNR = value;
					}
					if (name.equals("IDNRK")) {
						IDNRK = value;
					}
					if (name.equals("OPERITEMNO")) {
						OPERITEMNO = value;
					}
					if (name.equals("OPERDESC")) {
						OPERDESC = value;
					}
					if (name.equals("INVNAME")) {
						INVNAME = value;
					}
					if (name.equals("MENGE")) {
						MENGE = value;
					}
					if (name.equals("SILKQTY")) {
						SILKQTY = value;
					}
					if (name.equals("MEINS")) {
						MEINS = value;
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
					if (name.equals("ALPM")) {
						ALPM = value;
					}
					if (name.equals("LGORT")) {
						LGORT = value;
					}
					if (name.equals("SANKA")) {
						SANKA = value;
					}
					if (name.equals("BumpQTY")) {
						BumpQTY = value;
					}
				}
				try {
					req.put("fromSystem", "OA");
					req.put("functionName", "MES_UPLOADMASTERDATA");
					req.put("token", "OATESTTOKEN");
					shell.put("infTime", INF_TIME);
					shell.put("infSeq", String.valueOf(i + 1));
					shell.put("matnr", ProductMaterialCode);
					shell.put("werks", Plant);
					shell.put("stlan", Usage);
					shell.put("stlal", AlternativeBom);
					shell.put("plnnr", " ");
					shell.put("posnr", POSNR);
					shell.put("idnrk", IDNRK);
					shell.put("menge", MENGE);
					shell.put("meins", MEINS);
					shell.put("ausch", SILKQTY);
					shell.put("alpgr", ALPGR);
					shell.put("alprf", ALPRF);
					shell.put("alpst", ALPST);
					shell.put("ewahr", " ");
					shell.put("itsob", " ");
					shell.put("lgort", LGORT);
					shell.put("sanka", SANKA);
					shell.put("readFlag", " ");
					shell.put("infMsg", " ");
					shell.put("infFlag", " ");
					shell.put("cmf1", " ");
					shell.put("cmf2", " ");
					shell.put("cmf3", " ");
					shell.put("cmf4", " ");
					shell.put("cmf5", " ");
					shell.put("cmf6", " ");
					shell.put("cmf7", " ");
					shell.put("cmf8", " ");
					shell.put("cmf9", " ");
					shell.put("cmf10", " ");
					shell.put("deleteFlag", " ");
					shell.put("createTime", CREATE_TIME);
					shell.put("createUserId", creator);
					shell.put("updateTime", UPDATE_TIME);
					shell.put("updateUserId", creator);
					shell.put("deleteTime", " ");
					shell.put("deleteUserId", " ");
					cInfPatDatList.add(shell);
					baseBean.writeLog(cInfPatDatList);
					message.put("cInfPatDatList", cInfPatDatList);
					baseBean.writeLog("message" + message);
					req.put("message", message);
					baseBean.writeLog("req" + req);
					String retSrcs = HttpClientJson.readInterfacePost(url,
							req.toString());
					JSONObject results = new JSONObject(retSrcs);
					String statusValue = results.get("statusValue").toString();
					String msg = results.get("msg").toString();
					baseBean.writeLog("retSrcs--" + retSrcs);
					baseBean.writeLog("statusValue--" + statusValue);
					baseBean.writeLog("msg--" + msg);
				} catch (JSONException e) {
					BaseBean baseBean = new BaseBean();
					baseBean.writeLog("start log");
					baseBean.writeLog("------------------------------------------------------------------------");
					baseBean.writeLog("CINFPATDATTest error:" + e.getMessage());
					baseBean.writeLog("------------------------------------------------------------------------");
					baseBean.writeLog("end log");
				}
			}
		}
	}
	
	
}

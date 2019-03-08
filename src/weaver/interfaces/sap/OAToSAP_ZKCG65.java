package weaver.interfaces.sap;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;
import weaver.general.BaseBean;
import weaver.soa.workflow.request.RequestInfo;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by Administrator on 2017/2/8.
 * @author zong.yq
 */
public class OAToSAP_ZKCG65 {
	private JCO.Function jcoFunction = null;
	private JCO.Client sapconnection = null;
	private BaseBean bb = new BaseBean();
	private Map<String, String> maintable = null;

	public OAToSAP_ZKCG65(String tablename, String rid, Map<String, String> maintable) {
		bb.writeLog("OAToSAP_ZKCG65开始执行");
		this.maintable = maintable;
		JCO.Repository mRepository = null;
		sapconnection = SapConnUtil.getconn();
		mRepository = new JCO.Repository("sap", sapconnection);
		IFunctionTemplate ft = mRepository.getFunctionTemplate("ZMMI065");
		jcoFunction = new JCO.Function(ft);
	}

	public void ZWEE_MM65(List<Map<String, String>> dt, RequestInfo request, String[] status) {
		String customer = "";
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy");
		String time = sdf.format(date);
		String year = sdf1.format(date);
		JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_MM65");
		int j = 10;
		for (Map<String, String> dtmap : dt) {
			mytbl.appendRow();
			UUID uuid = UUID.randomUUID();
			// 集团
			setValue(mytbl, "800", "MANDT");
            // WEE_ID
			setValue(mytbl, uuid.toString().substring(0, 32), "Z_WEE_ID");
            // 头部ID
			setValue(mytbl, String.valueOf(j), "HEADID");
            // 凭证中的凭证日期
			setValue(mytbl, time, "BLDAT");
            // 凭证中的过账日期
			setValue(mytbl, time, "BUDAT");
			String salesOrder = (dtmap.get("SALES_ORDER".toLowerCase()).length() == 8)
					? "00" + dtmap.get("SALES_ORDER".toLowerCase())
					: dtmap.get("SALES_ORDER".toLowerCase());
            // 销售订单号
			setValue(mytbl, salesOrder, "KDAUF");
            // 销售订单行项
			setValue(mytbl, dtmap.get("SALES_ORDER_ITEM".toLowerCase()), "KDPOS");
            // 行项所属头部ID
			setValue(mytbl, String.valueOf(j), "IT_HEADID");
            // 物料号
			setValue(mytbl, dtmap.get("MATERIAL".toLowerCase()), "MATNR");
            // 芯片料号
			setValue(mytbl, maintable.get("WAFER_MATERIAL".toLowerCase()), "MATNR_2");
            // 批号
			setValue(mytbl, dtmap.get("BATCH".toLowerCase()), "CHARG");
            // 工厂
			setValue(mytbl, dtmap.get("STORAGE_LOCATION".toLowerCase()).split("_")[0], "WERKS");
            // 库存地点
			setValue(mytbl, dtmap.get("STORAGE_LOCATION".toLowerCase()).split("_")[1], "LGORT");
            // 库存地点
			setValue(mytbl, "11TF", "LGORT_2");
            // 数量
			setValue(mytbl, dtmap.get("QTY".toLowerCase()), "MENGE");
            // 基本计量单位
			setValue(mytbl, "EA", "MEINS");
            // 用户名
			setValue(mytbl, "OA", "USNAM_MKPF");
            // 物料凭证编号
			setValue(mytbl, "", "MBLNR");
            // 物料凭证年度
			setValue(mytbl, year, "MJAHR");
            // 状态
			setValue(mytbl, "", "ZWEESTAUTS");
			if (Integer.parseInt(maintable.get("TRADE_WAY".toLowerCase())) == 0) {
				customer = "C" + maintable.get("CUSTOMER".toLowerCase());
				bb.writeLog(customer);
			} else {
				customer = "B" + maintable.get("CUSTOMER".toLowerCase());
				bb.writeLog(customer);
			}
            // 客户号
			setValue(mytbl, customer, "KUNNR");
			setValue(mytbl, dtmap.get("WAFER_LOT".toLowerCase()), "Z_WAFER_LOT");
			j++;
		}
		bb.writeLog("开始执行-------");
		sapconnection.execute(jcoFunction);
		bb.writeLog("返回数据-------");
		// 获取返回数据
		JCO.Table datas = jcoFunction.getTableParameterList().getTable("RETURN");
		bb.writeLog("datas.getNumRows:" + datas.getNumRows());
		for (int i = 0; i < datas.getNumRows(); i++) {
			datas.setRow(i);
			bb.writeLog("SAP65 物料号:" + datas.getString("MATNR"));
			bb.writeLog("SAP65 批号:" + datas.getString("CHARG"));
			bb.writeLog("SAP65 工厂" + datas.getString("WERKS"));
			bb.writeLog("SAP65 物料凭证编号" + datas.getString("MBLNR"));
			bb.writeLog("SAP65 物料凭证年度" + datas.getString("MJAHR"));
			bb.writeLog("SAP65 批输入信息类型" + datas.getString("TYPE"));
			bb.writeLog("SAP65 批输入信息ID" + datas.getString("ID"));
			bb.writeLog("SAP65 WEE消息编号" + datas.getString("NUMBER"));
			bb.writeLog("SAP65 MESSAGE:" + datas.getString("MESSAGE"));
			status[0] = datas.getString("TYPE");
            // 控制流程流转 在页面上输出错误信息 卡流程
			if (!"S".equals(datas.getString("TYPE"))) {
				request.getRequestManager().setMessageid("Exception");
				request.getRequestManager().setMessagecontent("转库存失败，请联系管理员:" + datas.getString("MESSAGE"));
				bb.writeLog("转库存失败，请联系管理员:" + datas.getString("MESSAGE"));
				break;
			}
			
		}
	}

	private void setValue(JCO.Table mytb, Object value, String key) {
		if (value instanceof Date) {
			mytb.setValue((Date) value, key);
			return;
		}
		mytb.setValue(value.toString(), key);
	}
}

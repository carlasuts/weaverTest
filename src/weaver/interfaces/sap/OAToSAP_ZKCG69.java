package weaver.interfaces.sap;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;

import weaver.general.BaseBean;
import weaver.soa.workflow.request.RequestInfo;

/**
 * Created by Administrator on 2017/2/8.
 */
public class OAToSAP_ZKCG69 {
	private JCO.Function jcoFunction = null;
	private JCO.Client sapconnection = null;
	private BaseBean bb = new BaseBean();
	private Map<String, String> maintable = null;

	public OAToSAP_ZKCG69(String tablename, String rid, Map<String, String> maintable) {
		this.maintable = maintable;
		JCO.Repository mRepository = null;
		sapconnection = SapConnUtil.getconn();
		mRepository = new JCO.Repository("sap", sapconnection);
		IFunctionTemplate ft = mRepository.getFunctionTemplate("ZMMI069");
		jcoFunction = new JCO.Function(ft);
	}

	public void ZWEE_MM69(List<Map<String, String>> dt, RequestInfo request) {
		JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_MM69");

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String time = sdf.format(date);
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy");
		String year = sdf1.format(date);
		int j = 10;

		for (Map<String, String> dtmap : dt) {
			if (!dtmap.get("DEST_BATCH".toLowerCase()).equals(dtmap.get("BATCH".toLowerCase()))) {
				mytbl.appendRow();
				UUID uuid = UUID.randomUUID();
				setValue(mytbl, "800", "MANDT");// 集团
				setValue(mytbl, uuid.toString().substring(0, 32), "Z_WEE_ID");// WEE_ID
				setValue(mytbl, String.valueOf(j), "HEADID");// 头部ID
				setValue(mytbl, time, "BLDAT");// 凭证中的凭证日期
				setValue(mytbl, time, "BUDAT");// 凭证中的过账日期
				setValue(mytbl, maintable.get("WAFER_MATERIAL".toLowerCase()), "MATNR");// 物料号
				setValue(mytbl, dtmap.get("DEST_BATCH".toLowerCase()), "CHARG");// 批号
				setValue(mytbl, dtmap.get("STORAGE_LOCATION".toLowerCase()).split("_")[0], "WERKS");// 工厂
				setValue(mytbl, "11TF", "LGORT");// 库存地点
				setValue(mytbl, String.valueOf(j), "IT_HEADID");// 行项所属头部ID
				setValue(mytbl, dtmap.get("BATCH".toLowerCase()), "CHARG_2");// 批号
				setValue(mytbl, "", "P_CNL");// 回冲批次
				setValue(mytbl, "OA", "USNAM_MKPF");// 用户名
				setValue(mytbl, "", "MBLNR");// 物料凭证号
				setValue(mytbl, year, "MJAHR");// 物料凭证年度
				setValue(mytbl, "", "ZWEESTAUTS");// WEE状态
				j++;
			}
		}
		String mergeMode = maintable.get("MERGEMODE".toLowerCase());
		bb.writeLog("69接口获取主表的合并方式" + mergeMode);
		if (!mergeMode.equals("0") && mytbl.getRow() != 0) {
			bb.writeLog("ZWEE_MM69 开始执行-------");
			sapconnection.execute(jcoFunction);
			bb.writeLog("ZWEE_MM69 返回数据-------");
			// 获取返回数据
			JCO.Table datas = jcoFunction.getTableParameterList().getTable("RETURN");
			bb.writeLog("datas.getNumRows:" + datas.getNumRows());
			for (int i = 0; i < datas.getNumRows(); i++) {
				datas.setRow(i);
				bb.writeLog("SAP69 物料号:" + datas.getString("MATNR"));
				bb.writeLog("SAP69 批号:" + datas.getString("CHARG"));
				bb.writeLog("SAP69 工厂:" + datas.getString("WERKS"));
				bb.writeLog("SAP69 库存地点:" + datas.getString("LGORT"));
				bb.writeLog("SAP69 物料凭证编号:" + datas.getString("MBLNR"));
				bb.writeLog("SAP69 物料凭证年度:" + datas.getString("MJAHR"));
				bb.writeLog("SAP69 批输入信息类型:" + datas.getString("TYPE"));
				bb.writeLog("SAP69 批输入信息ID:" + datas.getString("ID"));
				bb.writeLog("SAP69 WEE消息编号:" + datas.getString("NUMBER"));
				bb.writeLog("SAP69 MESSAGE:" + datas.getString("MESSAGE"));
				if (!datas.getString("TYPE").equals("S")) {// 控制流程流转 在页面上输出错误信息
															// 卡流程
					request.getRequestManager().setMessageid("Exception");
					request.getRequestManager().setMessagecontent("合并失败，请联系管理员:" + datas.getString("MESSAGE"));
					bb.writeLog("合并失败，请联系管理员:" + datas.getString("MESSAGE"));
					break;
				}
			}
		} else {
			bb.writeLog("当前合并方式为不合并！");
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

package weaver.interfaces.sap.reprocessinTFME.hf;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;

import weaver.general.BaseBean;
import weaver.interfaces.sap.SapConnUtil;
import weaver.soa.workflow.request.RequestInfo;

/**
 * Created by Administrator on 2017/2/8.
 */
public class OAToSAP_ZKCG30 {
	private JCO.Function jcoFunction = null;
	private JCO.Client sapconnection = null;
	private BaseBean bb = new BaseBean();
	private String requestid;
	private Map<String, String> maintable = null;

	public OAToSAP_ZKCG30(String tablename, String rid, Map<String, String> maintable) {
		bb.writeLog("OAToSAP_ZKCG30开始执行");
		requestid = rid;
		this.maintable = maintable;
		JCO.Repository mRepository = null;
		sapconnection = SapConnUtil.getconn();
		mRepository = new JCO.Repository("sap", sapconnection);
		IFunctionTemplate ft = mRepository.getFunctionTemplate("ZSDI030");
		jcoFunction = new JCO.Function(ft);
	}

	public void ZWEE_SD30(List<Map<String, String>> dt, RequestInfo request) {
		String customer = "";
		JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_SD30");
		int j = 10;

		for (Map<String, String> dtmap : dt) {
			mytbl.appendRow();
			Map<String, String> logmap = new HashMap<String, String>();
			UUID uuid = UUID.randomUUID();
			System.out.println(uuid.toString().substring(0, 32));
			setValue(mytbl, "800", "MANDT");// 集团
			setValue(mytbl, uuid.toString().substring(0, 32), "Z_WEE_ID");// WEE_ID
			setValue(mytbl, String.valueOf(j), "HEADID");// 头部ID
			if (Integer.parseInt(maintable.get("IFFREE".toLowerCase())) == 0) {
				setValue(mytbl, "Z005", "AUART");// 免费销售凭证类型
			} else {
				setValue(mytbl, "Z008", "AUART");// 收费销售凭证类型
			}
			setValue(mytbl, "", "VBELN");// 销售凭证 最前面补两个0的销售订单号
			if (Integer.parseInt(maintable.get("TRADE_WAY".toLowerCase())) == 0) {
				customer = "C" + maintable.get("CUSTOMER".toLowerCase());
				bb.writeLog(customer);
			} else {
				customer = "B" + maintable.get("CUSTOMER".toLowerCase());
				bb.writeLog(customer);
			}
			setValue(mytbl, customer, "KUNNR");// 销售方
			setValue(mytbl, "5000", "VKORG");// 销售组织
			setValue(mytbl, "10", "VTWEG");// 分销渠道
			setValue(mytbl, "01", "SPART");// 产品组
			setValue(mytbl, "", "VKBUR");// 销售部门
			setValue(mytbl, "", "BZIRK");// 销售地区
			setValue(mytbl, "", "INCO1");// 国际贸易条款（部分1）
			setValue(mytbl, "", "INCO2");// 国际贸易条款（部分2）
			setValue(mytbl, "", "BSTKD");// 客户采购订单编号
			setValue(mytbl, "", "BSTDK");// 客户采购订单日期
			setValue(mytbl, String.valueOf(j), "IT_HEADID");// 行项所属头部ID 与头部ID相同
			setValue(mytbl, "10", "POSNR");// 销售凭证项目
			setValue(mytbl, maintable.get("MATERIAL".toLowerCase()), "MATNR");// 物料号
			setValue(mytbl, dtmap.get("QTY".toLowerCase()), "KWMENG");// 以销售单位表示的累计订单数量
			setValue(mytbl, maintable.get("WAFER_MATERIAL".toLowerCase()), "ZZZXPWL");// 主芯片物料号
			setValue(mytbl, dtmap.get("WAFER_LOT".toLowerCase()), "ZZZXPWLWF");// 主芯片wafer_lot
			setValue(mytbl, dtmap.get("FINAL_BATCH".toLowerCase()), "ZZCHARG");// 批号
			setValue(mytbl, "", "ZZLYDI");// 来源地
			setValue(mytbl, "", "ZZZLBH");// 整理编号
			setValue(mytbl, "", "ZZRQDM");// 日期代码
			setValue(mytbl, "", "ZZYPH2");// 圆片号2
			setValue(mytbl, "", "ZZYXJI");// 优先级
			setValue(mytbl, "", "ZZFHDI");// 发货地
			setValue(mytbl, "", "ZZMOHAO");// MO号
			setValue(mytbl, "", "ZZMOMS1");// MO描述1
			setValue(mytbl, "", "ZZMOMS2");// MO描述2
			setValue(mytbl, "", "ZZMOMS3");// MO描述3
			setValue(mytbl, "", "ZZCSCSBB");// 测试程序版本号
			setValue(mytbl, "1", "ZZJPSHU");// 芯片数
			setValue(mytbl, "", "ZZYZ01");// 印字1
			setValue(mytbl, "", "ZZYZ02");// 印字2
			setValue(mytbl, "", "ZZYZ03");// 印字3
			setValue(mytbl, "", "ZZYZ04");// 印字4
			setValue(mytbl, "", "ZZYZ05");// 印字5
			setValue(mytbl, "", "ZZWDY01");// 未定义1
			setValue(mytbl, "", "ZZWDY02");// 未定义2
			setValue(mytbl, "", "ZZWDY03");// 未定义3
			setValue(mytbl, "", "ZZWDY04");// 未定义4
			setValue(mytbl, "", "ZZWDY05");// 未定义5
			setValue(mytbl, "", "ZZWDY06");// 未定义6
			setValue(mytbl, "", "ZZWDY07");// 未定义7
			setValue(mytbl, "", "ZZWDY08");// 未定义8
			setValue(mytbl, "", "ZZWDY09");// 未定义9
			setValue(mytbl, "", "ZZWDY10");// 未定义10
			setValue(mytbl, "", "ZZWDY11");// 未定义11
			setValue(mytbl, "", "ZZWDY12");// 未定义12
			setValue(mytbl, "", "ZZWDY13");// 未定义13
			setValue(mytbl, "", "ZZWDY14");// 未定义14
			setValue(mytbl, "", "ZZWDY15");// 未定义15
			setValue(mytbl, "1", "ZZYPSHU1");// 圆片数
			setValue(mytbl, "INK", "ZMAPKEY");// MAP关键字
			setValue(mytbl, "", "ZZPJPS");// 装片芯片数
			setValue(mytbl, "", "ZZPYPH");// 装片圆片号（以英文分号分割）
			setValue(mytbl, "", "ZWEESTAUTS");// WEE状态
			j++;
			logmap.put("REQUESTID", requestid);
		}
		bb.writeLog("开始执行-------");
		sapconnection.execute(jcoFunction);
		bb.writeLog("返回数据-------");
		// 获取返回数据
		JCO.Table datas = jcoFunction.getTableParameterList().getTable("RETURN");
		bb.writeLog("datas.getNumRows:" + datas.getNumRows());
		for (int i = 0; i < datas.getNumRows(); i++) {
			datas.setRow(i);
			bb.writeLog("SAP30 销售凭证:" + datas.getString("VBELN"));
			bb.writeLog("SAP30 销售凭证项目:" + datas.getString("POSNR"));
			bb.writeLog("SAP30 批输入信息类型:" + datas.getString("TYPE"));
			bb.writeLog("SAP30 批输入信息ID:" + datas.getString("ID"));
			bb.writeLog("SAP30 WEE消息编号:" + datas.getString("NUMBER"));
			bb.writeLog("SAP30 MESSAGE:" + datas.getString("MESSAGE"));
			if (!(datas.getString("TYPE")).equals("S")) {
				request.getRequestManager().setMessageid("Exception");
				request.getRequestManager().setMessagecontent("制单失败，请联系管理员:" + datas.getString("MESSAGE"));
				bb.writeLog("制单失败，请联系管理员:" + datas.getString("MESSAGE"));
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

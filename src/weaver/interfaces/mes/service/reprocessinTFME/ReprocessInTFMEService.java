/**
 * ****************************************************************************
 * System      : weaver
 * Module      : weaver.interfaces.mes.service.reprocessinFGS
 * File Name   : ReprocessInFGSService.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年8月22日     peng.xu     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.mes.service.reprocessinTFME;

import java.util.List;

import net.sf.json.JSONObject;
import weaver.general.BaseBean;
import weaver.interfaces.mes.dao.reprocessinTFME.ReprocessInTFMEDao;
import weaver.interfaces.mes.dao.reprocessinTFME.ReprocessInTFMEDaoImpl;
import weaver.interfaces.mes.entity.reprocessinTFME.ReprocessInTFMEData;
import weaver.interfaces.sap.HttpClientJson;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author peng.xu
 *
 */
public class ReprocessInTFMEService {	
	private BaseBean baseBean = new BaseBean();
	JSONObject req = new JSONObject();
	JSONObject json = new JSONObject();

	public void oaToMes(RequestInfo request, String url) {
		ReprocessInTFMEDao repDao = new ReprocessInTFMEDaoImpl();
		List<ReprocessInTFMEData> reprocessInFGS = repDao.getReprocessInFGS(request);
		try {
			for (ReprocessInTFMEData repData : reprocessInFGS) {
				json.put("userId", "OA");// 用户id 固定写死为OA
				json.put("factory", "FGS");// 工厂 固定写死为FGS
				json.put("lotId", repData.getLotCode());// 明细表1生产批号
				json.put("matId", repData.getMaterial());// 明细表1料号
				json.put("matVer", "1");
				json.put("delCode", "NOSENDSAP");
				req.put("message", json);
				req.put("fromSystem", "TEST");
				req.put("functionName", "MES_TERMINATELOT");
				req.put("token", "TESTTOKEN");
				String retSrcs = HttpClientJson.readInterfacePost(url, req.toString());// 向MES传输json对象
				baseBean.writeLog(retSrcs);// 抓取返回值
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}	
}

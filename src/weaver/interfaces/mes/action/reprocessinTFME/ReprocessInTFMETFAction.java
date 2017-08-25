/**
 * ****************************************************************************
 * System      : weaver
 * Module      : weaver.interfaces.mes.action.reprocessinFGS
 * File Name   : ReprocessInFGSAction.java
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
package weaver.interfaces.mes.action.reprocessinTFME;

import java.io.InputStream;
import java.util.Properties;

import weaver.general.BaseBean;
import weaver.interfaces.mes.service.reprocessinTFME.ReprocessInTFMEService;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author peng.xu
 *
 */
public class ReprocessInTFMETFAction implements Action {

	@Override
	public String execute(RequestInfo request) {
		BaseBean basebean = new BaseBean();
		try {
			basebean.writeLog("***TFMEPOST开始执行***");
			ReprocessInTFMEService repService = new ReprocessInTFMEService();
			basebean.writeLog("开始执行OaToMes_MainData内的oaToMes方法");
			repService.oaToMes(request, getUrl());
		} catch (Exception e) {
			basebean.writeLog("start log");
			basebean.writeLog("------------------------------------------------------------------------");
			basebean.writeLog("TFMEPOST error" + e.getMessage());
			basebean.writeLog("------------------------------------------------------------------------");
			basebean.writeLog("end log");
		}
		return Action.SUCCESS;
	}

	private String getUrl() {
		String url = "";
		try {
			Properties properties = new Properties();
			InputStream ins = this.getClass().getResourceAsStream("/src/url.properties");
			properties.load(ins);
			url = properties.getProperty("cc_url").trim();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}

}

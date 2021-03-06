/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.mes.action
 * File Name   : OaToMes_ZKCG_Post.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年10月10日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.mes.cc;

import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 *
 */
public class OaToMes_ZKCG_Post_CC implements Action {

	@Override
	public String execute(RequestInfo request) {
		BaseBean basebean = new BaseBean();
		try {
			basebean.writeLog("***OaToMes_ZKCG_Post开始执行***");
			OaToMes_ZKCG_Action_CC oaToMes_ZKCG_Action = new OaToMes_ZKCG_Action_CC();
			basebean.writeLog("开始执行OaToMes_ZKCG_Post内的oaToMes方法");
			oaToMes_ZKCG_Action.oaToMes(request);
		} catch (Exception e) {
			basebean.writeLog("start log");
			basebean.writeLog("------------------------------------------------------------------------");
			basebean.writeLog("TFMEPOST error" + e.getMessage());
			basebean.writeLog("------------------------------------------------------------------------");
			basebean.writeLog("end log");
		}
		return Action.SUCCESS;
	}

}

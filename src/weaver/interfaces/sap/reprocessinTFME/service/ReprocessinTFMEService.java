/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.sap.reprocessinTFME.service
 * File Name   : ReprocessinTFMEService.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年9月8日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.sap.reprocessinTFME.service;

import java.text.SimpleDateFormat;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;

import weaver.general.BaseBean;
import weaver.interfaces.sap.SapConnUtil;

/**
 * @author zong.yq
 *
 */
public class ReprocessinTFMEService {

	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private JCO.Function jcoFunction = null;
	private JCO.Client sapconnection = null;
	private BaseBean bb = new BaseBean();
	private String requestid;

	public ReprocessinTFMEService(String id) {
		requestid = id;
		init();
	}

	private void init() {
		JCO.Repository mRepository = null;
		sapconnection = SapConnUtil.getconn();
		mRepository = new JCO.Repository("sap", sapconnection);
		IFunctionTemplate ft = mRepository.getFunctionTemplate("ZMMI065");
		jcoFunction = new JCO.Function(ft);
	}
	
	public void ReprocessinTFMEService() {
		
	}

}

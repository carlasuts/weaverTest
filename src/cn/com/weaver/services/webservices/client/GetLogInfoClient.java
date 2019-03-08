/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : cn.com.weaver.services.webservices.client
 * File Name   : GetLogInfoClient.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年2月12日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */ 
package cn.com.weaver.services.webservices.client;

import cn.com.weaver.services.webservices.LoginLogService;

/**
 * @author zong.yq
 *
 */
public class GetLogInfoClient {
	
	public static void main(String[] args) {
		LoginLogService loginLogService = new LoginLogService();
		
		String loginLog = loginLogService.getLoginLogServiceHttpPort().getLoginInfo("宗宇乾");
		
		System.out.println(loginLog);
	}
	
	
	

}

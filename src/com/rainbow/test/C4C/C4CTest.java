/**
 * ****************************************************************************
 * System      : OARMIService
 * Module      : com.tfme.oa.service
 * File Name   : C4CTest.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年12月7日     peng.xu     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package com.rainbow.test.C4C;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.net.util.Base64;

import java.nio.charset.Charset;

/**
 * @author peng.xu
 *
 */
public class C4CTest {

    /**
     * @param args
     */
    public static void main(String[] args) {
	HttpClient client = new HttpClient();	
	// 添加http头信息	
	String url = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/SalesQuoteCollection?$filter=ID%20eq%20'31'&$format=json";
	GetMethod get = new GetMethod(url);
	get.addRequestHeader("Authorization", getAuthor()); // 认证token
	get.addRequestHeader("Content-Type", "application/json");
	get.addRequestHeader("x-csrf-token", "fetch");
	try {
	    int code = client.executeMethod(get);
	    System.out.println(code);
	    String str = get.getResponseBodyAsString();
	    System.out.println(str);
	    JSONObject ObjectList = JSONObject.fromObject(str);
	    String results = ObjectList.get("d").toString();
	    System.out.println(results);
	    JSONObject reslultList = JSONObject.fromObject(results);
	    JSONArray array = reslultList.getJSONArray("results"); 
	    System.out.println(array.get(0));
	    JSONObject list = JSONObject.fromObject(array.get(0).toString());
	    System.out.println(list.get("ObjectID").toString());
	    Header[] responseHeaders = get.getResponseHeaders("x-csrf-token");
	    System.out.println(responseHeaders[0].getValue());	    
	} catch (final Exception e) {
	    e.printStackTrace();
	} finally {
	    get.releaseConnection();
	}

    }

    private static String getAuthor() {
	String auth = "OAUser" + ":" + "OAUser";
	byte[] encodedAuth = Base64.encodeBase64(auth.getBytes(Charset.forName("US-ASCII")));
	String authHeader = "Basic " + new String(encodedAuth);
	return authHeader;
    }

}

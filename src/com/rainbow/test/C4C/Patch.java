package com.rainbow.test.C4C;

import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONException;
import org.json.JSONObject;

import static weaver.interfaces.workflow.action.quotation.DataToC4C.doGet;
import static weaver.interfaces.workflow.action.quotation.DataToC4C.doPatch;

public class Patch {
    private static final String prefix = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/";// 前缀
    private static final String username = "OAUser";
    private static final String password = "OAUser";
    private static final String postfix = "?$format=json";// 后缀 更新前get需要加后缀 更新时patch不用加后缀
    private static DefaultHttpClient defaultHttpClient = new DefaultHttpClient();

    public static void main (String args[]) {
        String url = "";
        String objectId = "SalesQuoteCollection('00163E7329611EE8BEBC6CB075D1500F')";
        JSONObject req = new JSONObject();
        try {
            req.put("Name", "Update Test");
            req.put("OADocID", "666999");
        } catch (JSONException e) {
            e.printStackTrace();
        }

        url = prefix + objectId + postfix;
        System.out.println("更新前get的url: " + url);
        String token = doGet(url, username, password);
        System.out.println("当前获取到的token: " + token);
        url = "";
        url = prefix + objectId;
        int code = doPatch(token, req, url, username, password);
        System.out.println("更新动作返回值: " + code);
    }

}

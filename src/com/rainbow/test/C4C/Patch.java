package com.rainbow.test.C4C;

import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONException;
import org.json.JSONObject;

import static weaver.interfaces.workflow.action.quotation.DataToC4C.doGet;
import static weaver.interfaces.workflow.action.quotation.DataToC4C.doPatch;

public class Patch {
    private static final String prefix = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/";// ǰ׺
    private static final String username = "OAUser";
    private static final String password = "OAUser";
    private static final String postfix = "?$format=json";// ��׺ ����ǰget��Ҫ�Ӻ�׺ ����ʱpatch���üӺ�׺
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
        System.out.println("����ǰget��url: " + url);
        String token = doGet(url, username, password);
        System.out.println("��ǰ��ȡ����token: " + token);
        url = "";
        url = prefix + objectId;
        int code = doPatch(token, req, url, username, password);
        System.out.println("���¶�������ֵ: " + code);
    }

}

/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.workflow.action.quotation
 * File Name   : DataToC4C.java
 * Description : 用于处理OA发送不同的请求到CRM中
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年12月10日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.action.quotation;

import org.apache.commons.net.util.Base64;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPatch;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;

import javax.xml.parsers.DocumentBuilder;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.Iterator;
import java.util.List;

/**
 * @author zong.yq
 */
public class DataToC4C {
    private static DefaultHttpClient defaultHttpClient = new DefaultHttpClient();
    private static BaseBean baseBean = new BaseBean();
    private static final int CREATE_SUCCESS_CODE = 201;
    private static final int GET_BP_SUCCESS_CODE = 200;

    /**
     * 获取执行情报单执行POST和PATCH操作的token
     * @param url CRM中的网址
     * @param username 用户名
     * @param password 密码
     * @return 返回toekn
     */
    public static String doGet(String url, String username, String password) {
        String token = "";
        int code = 0;
        // 添加http头信息
        HttpGet httpGet = new HttpGet(url);
        // 设置用户验证
        httpGet.setHeader("Authorization",getAuthor(username, password));
        httpGet.setHeader("Content-Type","application/json");
        // 获取token
        httpGet.setHeader("x-csrf-token","fetch");

        try {
            org.apache.http.Header[] headers = httpGet.getAllHeaders();
            HttpResponse response = defaultHttpClient.execute(httpGet);
            String[] status = response.getStatusLine().toString().split(" ");
            for (int i = 0; i < status.length; i ++) {
                code = Integer.valueOf(status[1]);
            }
            System.out.println("code: " + code);
            HttpEntity httpEntity = response.getEntity();
            headers = response.getAllHeaders();
            for (Header header : headers) {
                if ("x-csrf-token".equals(header.getName())) {
                    token = header.getValue();
                }
            }
        } catch (final Exception e) {
            e.printStackTrace();
        } finally {
            httpGet.releaseConnection();
        }
        return token;
    }

    /**
     * 在CRM中创建报价申请单
     * @param token doGet()方法中获取的token
     * @param json OA字段通过Json格式传输
     * @param url CRM中创建报价申请单的地址
     * @param username 用户名
     * @param password 密码
     * @return 返回OA系统的标志位tagValue 比如：SalesQuoteCollection('00163E7329D91ED8BF9E55C25ED2AF01')
     */
    public static String doPost(String token, JSONObject json, String url, String username, String password) {
        String tagValue = "";
        StringEntity stringEntity = null;
        HttpResponse response = null;
        BufferedReader reader = null;
        String line = null;
        String emsReturn = "";
        Document doc = null;
        int code = 0;
        HttpPost httpPost = new HttpPost(url);
        // 设置用户验证
        httpPost.addHeader("Authorization", getAuthor(username, password));
        // 设置token
        httpPost.addHeader("x-csrf-token", token);
        // 设置传输数据格式 json
        httpPost.addHeader("Content-Type", "application/json; charset=utf-8");
        try {
            stringEntity = new StringEntity(json.toString(), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            baseBean.writeLog("生成stringEntity时候出错");
        }
        // 设置参数给post
        httpPost.setEntity(stringEntity);
        try {
            response = defaultHttpClient.execute(httpPost);
        } catch (ClientProtocolException e) {
            baseBean.writeLog("客户端协议出错");
            e.printStackTrace();
        } catch (IOException e) {
            baseBean.writeLog("接口出错");
            e.printStackTrace();
        }
        HttpEntity httpEntity = response.getEntity();
        try {
            reader = new BufferedReader(new InputStreamReader(httpEntity.getContent(), "UTF-8"));
            while ((line = reader.readLine()) != null) {
                emsReturn = emsReturn + line;
            }
        } catch (IOException e) {
            baseBean.writeLog("读取返回值出错");
            e.printStackTrace();
        }
        String[] status = response.getStatusLine().toString().split(" ");
        // 输出CRM返回给OA的状态 201即为创建成功
        baseBean.writeLog("Status: " +  response.getStatusLine());
        for (int i = 0; i < status.length; i ++) {
            code = Integer.valueOf(status[1]);
        }
        if (code == CREATE_SUCCESS_CODE) {
            // 成功创建CRM中的报价申请单
            try {
                doc = DocumentHelper.parseText(emsReturn);
            } catch (DocumentException e) {
                e.printStackTrace();
                baseBean.writeLog("转化成xml文件时出错");
            }
            // 获取根节点
            Element rootElement = doc.getRootElement();
            baseBean.writeLog("根节点: " + rootElement.getName());
            for (Iterator iter = rootElement.elementIterator(); iter.hasNext();) {
                Element elementOption = (Element) iter.next();
                if ("title".equals(elementOption.getName())) {
                    // SalesQuoteCollection('00163E7329D91ED8BF9E55C25ED2AF01')
                    tagValue = elementOption.getTextTrim();
                    break;
                }
            }
        }
        baseBean.writeLog("tagValue: " + tagValue);

        return tagValue;
    }

    /**
     * 更新操作
     * @param token doGet()方法中获取的token
     * @param json 传给CRM的数据
     * @param url 需要更新的申请单的地址
     * @param username 用户名
     * @param password 密码
     * @return code 状态码 204即为成功
     */
    public static Integer doPatch (String token, JSONObject json, String url, String username, String password) {
        int code = 0;
        StringEntity stringEntity = null;
        HttpResponse response = null;
        HttpPatch httpPatch = new HttpPatch(url);
        // 设置用户验证
        httpPatch.addHeader("Authorization", getAuthor(username, password));
        // 设置token
        httpPatch.addHeader("x-csrf-token", token);
        // 设置传输数据格式 json
        httpPatch.addHeader("Content-Type", "application/json; charset=utf-8");
        try {
            stringEntity = new StringEntity(json.toString(), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            baseBean.writeLog("生成stringEntity时候出错");
        }
        httpPatch.setEntity(stringEntity);
        try {
            response = defaultHttpClient.execute(httpPatch);
        } catch (ClientProtocolException e) {
            e.printStackTrace();
            baseBean.writeLog("客户端协议出错");
        } catch (IOException e) {
            baseBean.writeLog("接口出错");
            e.printStackTrace();
        }
        // 输出CRM返回给OA的状态 204即为更新成功
        baseBean.writeLog("Status: " +  response.getStatusLine());
        String[] status = response.getStatusLine().toString().split(" ");
        for (int i = 0; i < status.length; i ++) {
            code = Integer.valueOf(status[1]);
        }
        return code;
    }

    /**
     * 删除操作
     * @param token doGet()方法中获取的token
     * @param url 申请单地址
     * @param username 用户名
     * @param password 密码
     * @return code 状态码 204即为成功
     */
    public static Integer doDelete (String token, String url, String username, String password) {
        int code = 0;
        HttpResponse response = null;
        HttpDelete httpDelete = new HttpDelete(url);
        // 设置用户验证
        httpDelete.addHeader("Authorization", getAuthor(username, password));
        // 设置token
        httpDelete.addHeader("x-csrf-token", token);
        try {
            response = defaultHttpClient.execute(httpDelete);
        } catch (ClientProtocolException e) {
            baseBean.writeLog("协议出错");
            e.printStackTrace();
        } catch (IOException e) {
            baseBean.writeLog("IO接口出错");
            e.printStackTrace();
        }
        // 输出CRM返回给OA的状态 204即为删除
        baseBean.writeLog("Status: " +  response.getStatusLine());
        String[] status = response.getStatusLine().toString().split(" ");
        for (int i = 0; i < status.length; i ++) {
            code = Integer.valueOf(status[1]);
        }
        return code;
    }

    /**
     * 通过OA中的workCode获取CRM中员工的BP编号
     * @param url CRM中获取员工信息的地址
     * @param username 用户名
     * @param password 密码
     * @param employeeId OA系统的中员工工号
     * @return 返回CRM系统的中的员工编号
     */
    public static String doGetBP(String url, String username, String password, String employeeId) {
        // 输出OA中的workCode
        baseBean.writeLog("employeeId : " + employeeId);
        RecordSet rs = new RecordSet();
        int code = 0;
        DocumentBuilder builder = null;
        BufferedReader reader = null;
        String emsReturn = "";
        String line = null;
        String businessPartnerID = "";
        HttpGet httpGet = new HttpGet(url);
        // 验证用户名和密码
        httpGet.setHeader("Authorization",getAuthor(username, password));
        try {
            // 发送请求
            HttpResponse response = defaultHttpClient.execute(httpGet);
            // 获取返回状态  HTTP/1.1 200 OK
            String[] status = response.getStatusLine().toString().split(" ");
            baseBean.writeLog("Status: " +  response.getStatusLine());
            for (int i = 0; i < status.length; i ++) {
                // 获得HTTP/1.1 200 OK中间的状态码 200
                code = Integer.valueOf(status[1]);
            }
            baseBean.writeLog("doGetBP返回状态: " + code);
            /**
             * 成功获取用户
             * 如果为200 即为成功
             */
            if (code == GET_BP_SUCCESS_CODE) {
                HttpEntity entity = response.getEntity();
                if (null != entity) {
                    try {
                        reader = new BufferedReader(new InputStreamReader(entity.getContent(), "UTF-8"));
                        while ((line = reader.readLine()) != null) {
                            emsReturn = emsReturn + line;
                        }
                        Document document = DocumentHelper.parseText(emsReturn);
                        Element rootElement = document.getRootElement();
                        Element propertiesElem = rootElement.element("entry").element("content").element("properties");
                        List<Element> propertiesList = propertiesElem.elements();
                        for (Element e : propertiesList) {
                            if ("BusinessPartnerID".equals(e.getName())) {
                                businessPartnerID = e.getTextTrim();
                                baseBean.writeLog("当前用户的BP编号为: " + businessPartnerID);
                                break;
                            }
                        }
                    } catch (IOException e) {
                        baseBean.writeLog("读取返回值出错");
                        e.printStackTrace();
                    } catch (DocumentException e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return businessPartnerID;
    }

    private static String getAuthor(String username, String password) {
        String auth = username + ":" + password;
        byte[] encodedAuth = Base64.encodeBase64(auth.getBytes(Charset.forName("US-ASCII")));
        String authHeader = "Basic " + new String(encodedAuth);
        return authHeader;
    }
}

package com.rainbow.test.C4C;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.net.util.Base64;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.dom4j.*;
import org.json.JSONObject;

import javax.xml.parsers.DocumentBuilder;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.Iterator;
import java.util.List;

public class Get {
    private static final String url = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/EmployeeCollection?$filter=EmployeeID%20eq%20'171503'";
    private static final String username = "OAUser";
    private static final String password = "OAUser";
    private static HttpClient client = new HttpClient();
    private static DefaultHttpClient defaultHttpClient = new DefaultHttpClient();

    public static void main(String[] args) {
        JSONObject req = new JSONObject();
        try {
            req.put("OADocID", "999999");
            req.put("Name", "103 - 报价申请单");
            req.put("EmployeeResponsiblePartyID", "8000000050");
            req.put("ProductRecipientPartyID", "103");
            String BusinessPartnerID = doGetBP(url);
            System.out.println(BusinessPartnerID);
            String token = doGet(url);
            System.out.println("返回的token值为: " + token);
            int code = doPost(token, req);
            System.out.println("返回的code值为: " + code);
//            if (!tagValue.equals("")) {
//                System.out.println("订单创建成功");
//            } else {
//                System.out.println("订单创建失败");
//            }
//            System.out.println(tagValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String doGetBP(String url) {
        int code = 0;
        HttpGet httpGet = new HttpGet(url);
        DocumentBuilder builder = null;
        BufferedReader reader = null;
        String emsReturn = "";
        String line = null;
        String BusinessPartnerID = "";
        httpGet.setHeader("Authorization",getAuthor()); // 验证用户名和密码
        try {
            HttpResponse response = defaultHttpClient.execute(httpGet);
            String[] status = response.getStatusLine().toString().split(" ");
            System.out.println("Status: " +  response.getStatusLine());
            for (int i = 0; i < status.length; i ++) {
                code = Integer.valueOf(status[1]);
            }
            // 成功获取用户
            if (code == 200) {
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
                            if (e.getName().equals("BusinessPartnerID")) {
                                BusinessPartnerID = e.getTextTrim();
                                break;
                            }
                        }
                    } catch (IOException e) {
                        System.out.println("读取返回值出错");
                        e.printStackTrace();
                    } catch (DocumentException e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return BusinessPartnerID;
    }

    private static String getChildNodes (Element elem) {
        Iterator<Node> it = elem.nodeIterator();
        while (it.hasNext()) {
            Node node = it.next();
            if (node instanceof Element) {
                Element el = (Element) node;
                getChildNodes(el);
            }
        }
        return elem.getName();
    }

    public static String doGet(String url) {
        String token = "";
        int code = 0;
        // 添加http头信息
        HttpGet httpGet = new HttpGet(url);
        httpGet.setHeader("Authorization",getAuthor()); // 认证token
        httpGet.setHeader("Content-Type","application/json");
        httpGet.setHeader("x-csrf-token","fetch");

        try {
            Header[] headers = httpGet.getAllHeaders();
            HttpResponse response = defaultHttpClient.execute(httpGet);
            String[] status = response.getStatusLine().toString().split(" ");
            for (int i = 0; i < status.length; i ++) {
                code = Integer.valueOf(status[1]);
            }
            System.out.println("code: " + code);
            HttpEntity httpEntity = response.getEntity();
            headers = response.getAllHeaders();
            for (Header header : headers) {
                if (header.getName().equals("x-csrf-token")) {
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

    public static Integer doPost(String token, JSONObject json) {
        String tagValue = "";
        StringEntity stringEntity = null;
        HttpResponse response = null;
        BufferedReader reader = null;
        String line = null;
        String emsReturn = "";
        Document doc = null;
        int code = 0;
        HttpPost httpPost = new HttpPost(url);
        httpPost.addHeader("Authorization", getAuthor());
        httpPost.addHeader("x-csrf-token", token);
        httpPost.addHeader("Content-Type", "application/json; charset=utf-8");
        try {
            stringEntity = new StringEntity(json.toString(), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        httpPost.setEntity(stringEntity);// 设置参数给post
        try {
            response = defaultHttpClient.execute(httpPost);
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        HttpEntity httpEntity = response.getEntity();
        try {
            reader = new BufferedReader(new InputStreamReader(httpEntity.getContent(), "UTF-8"));
            while ((line = reader.readLine()) != null) {
                emsReturn = emsReturn + line;
                System.out.println(emsReturn);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        String[] status = response.getStatusLine().toString().split(" ");
        System.out.println("Status: " +  response.getStatusLine());
        for (int i = 0; i < status.length; i ++) {
            code = Integer.valueOf(status[1]);
        }
        System.out.println("code: " + code);

        try {
            doc = DocumentHelper.parseText(emsReturn);
        } catch (DocumentException e) {
            e.printStackTrace();
            System.out.println("转化成xml文件时出错");
        }
        Element rootElement = doc.getRootElement();// 获取根节点
        System.out.println("根节点: " + rootElement.getName());
        for (Iterator iter = rootElement.elementIterator(); iter.hasNext();) {
            Element elementOption = (Element) iter.next();
            if (elementOption.getName().equals("title")) {
                tagValue = elementOption.getTextTrim();// SalesQuoteCollection('00163E7329D91ED8BF9E55C25ED2AF01')
                System.out.println("tagValue: " + tagValue);
                break;
            }
        }
//        try {
//            code = client.executeMethod(post);
//            System.out.println("doPost方法获取的返回状态值: " + code);
//            if (code == 201) {
//                String emsReturn = post.getResponseBodyAsString();
//                Document doc = DocumentHelper.parseText(emsReturn);
//                Element rootElement = doc.getRootElement();// 获取根节点
//                System.out.println("根节点: " + rootElement.getName());// 输出根节点名称
//                for (Iterator iter = rootElement.elementIterator(); iter.hasNext();) {
//                    Element elementOption = (Element) iter.next();
//                    if (elementOption.getName().equals("title")) {
//                        tagValue = elementOption.getTextTrim();// SalesQuoteCollection('00163E7329D91ED8BF9E55C25ED2AF01')
//                        break;
//                    }
//                }
//            }

//            String[] tagVlues = tagValue.split("'");
        // https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/SalesQuoteCollection('00163E7329D91ED8BF9E55C25ED2AF01')?$format=json
//            String objectId = tagVlues[1];// 需要向OA数据库中存这个值 便于后面做更新操作
//            System.out.println("objectId: " + objectId);
//            System.out.println(code);
//            System.out.println("tagValue: " + tagValue);
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            post.releaseConnection();
//        }
        return code;
    }

    private static String getAuthor() {
        String auth = username + ":" + password;
        byte[] encodedAuth = Base64.encodeBase64(auth.getBytes(Charset.forName("US-ASCII")));
        String authHeader = "Basic " + new String(encodedAuth);
        return authHeader;
    }


}

/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.workflow.action.quotation
 * File Name   : QuotationC4CUpdateAction.java
 * Description : 用于报价申请单OA向CRM发送更新请求
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年12月13日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.action.quotation;

import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONException;
import org.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

import static weaver.interfaces.workflow.action.quotation.DataToC4C.doGet;
import static weaver.interfaces.workflow.action.quotation.DataToC4C.doPatch;

/**
 * @author zong.yq
 * TODO: 更新CRM中已经创建的报价单
 */
public class QuotationC4CUpdateAction implements Action {
    /**
     * 前缀
     */
    private static final String PREFIX = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/";
    private static final String USERNAME = "OAUser";
    private static final String PASSWORD = "OAUser";
    /**
     * 后缀 更新前get需要加后缀 更新时patch不用加后缀
     */
    private static final String POSTFIX = "?$format=json";
    private static BaseBean baseBean = new BaseBean();
    private static DefaultHttpClient defaultHttpClient = new DefaultHttpClient();

    @Override
    public String execute(RequestInfo request) {
        RecordSet rs = new RecordSet();
        baseBean.writeLog("QuotationC4CUpdateAction Start Running");
        String url = "";
        String sql = "";
        String objectId = "";
        // 总成交价
        String totalPrice = "";
        // 整体毛利率
        String overallGross = "";
        // 整体成本
        String overallCost = "";
        JSONObject req = new JSONObject();
        String requestId = request.getRequestid();
        int formId = Math.abs(request.getRequestManager().getFormid());
        sql = "SELECT * FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            objectId = rs.getString("TAG_VALUE");
            totalPrice = rs.getString("TOTAL_PRICE");
            overallGross = rs.getString("OVERALL_GROSS");
            overallCost = rs.getString("OVERALL_COST");
        }
        try {
            // 实际报价
            req.put("Zrealpricecontent", totalPrice);
            // 成本
            req.put("Zcostcontent", overallCost);
            // 毛利
            req.put("Zgrossprofitcontent", overallGross);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        url = PREFIX + objectId + POSTFIX;
        baseBean.writeLog("更新前get的url: " + url);
        String token = doGet(url, USERNAME, PASSWORD);
        baseBean.writeLog("当前获取到的token: " + token);
        url = "";
        url = PREFIX + objectId;
        // 更新报价申请单
        int code = doPatch(token, req, url, USERNAME, PASSWORD);
        baseBean.writeLog("更新CRM动作返回值为: " + code);
        if (code == 204) {
            baseBean.writeLog("更新成功！");
        } else {
            baseBean.writeLog("更新失败");
            request.getRequestManager().setMessageid("Exception");
            request.getRequestManager().setMessagecontent("更新失败，请联系管理员");
        }

        return Action.SUCCESS;
    }
}

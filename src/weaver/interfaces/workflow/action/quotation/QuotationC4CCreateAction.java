/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.workflow.action.quotation
 * File Name   : QuotationC4CCreateAction.java
 * Description : 用于报价申请单OA向CRM发送创建请求
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

import org.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

import java.util.HashMap;
import java.util.Map;

import static weaver.interfaces.workflow.action.quotation.DataToC4C.*;

/**
 * @author zong.yq
 */
public class QuotationC4CCreateAction implements Action {
    private static final String URL = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/SalesQuoteCollection";
    /**
     * 前缀
     */
    private static final String PREFIX = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/EmployeeCollection?$filter=EmployeeID%20eq%20'";
    /**
     * 后缀
     */
    private static final String POSTFIX = "'";
    private static final String PREFIX1 = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/";
    private static final String POSTFIX1 = "?$format=json";
    private static final String USERNAME = "OAUser";
    private static final String PASSWORD = "OAUser";
    private static BaseBean baseBean = new BaseBean();

    @Override
    public String execute(RequestInfo request) {
        RecordSet rs = new RecordSet();
        baseBean.writeLog("QuotationC4CCreateAction开始执行");
        String sql = "";
        // 报价原因
        String offerReasons = "";
        // 贸易方式
        String tradeWay = "";
        // 币种
        String currency = "";
        // 报价方式
        String quotationWay = "";
        // 工厂
        String factory = "";
        // 生产类型
        String productType = "";
        // 客户号
        String custidOffer = "";
        // 键合丝种类
        String typesOfBondingWire = "";
        // 创建人
        String createPersonnel = "";
        // OA的流程编号
        String processNumber = "";
        // CRM中获取人员信息地址
        String employeeUrl = "";
        // CRM返回给OA系统的报价单申请号
        String tagValue = "";
        // 报价备注
        String quotationNote = "";
        // 外形
        String shape = "";
        // 月需求量
        String onDemand = "";
        // 圆片尺寸
        String waferSize = "";
        // 键合丝数
        String wireBonding = "";
        // 芯片数
        String chipNumber = "";

        String objectId = "";
        String url = "";


        Map<String, String> map = new HashMap<String, String>();
        for (int i = 0;i <= 9; i++) {
            map.put(String.valueOf(i), "1" + String.valueOf(i) + "1");
        }
        Map<String, String> factoryMap = new HashMap<String, String>();
        factoryMap.put("一期厂", "101");
        factoryMap.put("二期厂", "111");
        factoryMap.put("三期厂", "121");
        factoryMap.put("合肥厂", "131");
        factoryMap.put("圆片厂", "141");
        factoryMap.put("苏通厂", "151");
        factoryMap.put("厦门厂", "161");

        String requestId = request.getRequestid();
        int formId = Math.abs(request.getRequestManager().getFormid());
        sql = "SELECT * FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.execute(sql);
        if (rs.next()) {
            offerReasons = rs.getString("OFFERREASONS");
            // 贸易方式
            tradeWay = rs.getString("TRADEWAY");
            // 币种 0：CNY 1：USD
            currency = rs.getString("CURRENCY");
            // 报价方式
            quotationWay = rs.getString("QUOTATION_WAY");
            // 工厂
            factory = rs.getString("FACTORY");
            // 生产类型
            productType = rs.getString("PRODUCT_TYPE");
            // 键合丝种类
            typesOfBondingWire = rs.getString("TYPES_OF_BONDING_WIRE");
            // 客户号
            custidOffer = rs.getString("CUSTID_OFFER");
            // 创建人员
            createPersonnel = rs.getString("CREATEPERSONNEL");
            // 流程编号
            processNumber = rs.getString("PROCESS_NUMBER");
            // CRM返回给OA系统的报价单申请号
            tagValue = rs.getString("TAG_VALUE");
            // 报价备注
            quotationNote = rs.getString("QUOTATION_NOTE");
            // 外形
            shape = rs.getString("SHAPE");
            // 月需求量
            onDemand = ("".equals(rs.getString("ON_DEMAND"))) ? "0" : rs.getString("ON_DEMAND");
            // 圆片尺寸
            waferSize = ("".equals(rs.getString("WAFER_SIZE"))) ? "0" : rs.getString("WAFER_SIZE");
            // 键合丝数
            wireBonding = ("".equals(rs.getString("WIRE_BONDING"))) ? "0" : rs.getString("WIRE_BONDING");
            // 芯片数
            chipNumber = ("".equals(rs.getString("CHIP_NUMBER"))) ? "0" : rs.getString("CHIP_NUMBER");
        }
        // 键合丝种类ID转换成名字
        sql = "SELECT NAME FROM MD_SD_WIRE WHERE ID = '" + typesOfBondingWire + "'";
        rs.executeSql(sql);
        rs.next();
        typesOfBondingWire = rs.getString("NAME");
        baseBean.writeLog("typesOfBondingWire: " + typesOfBondingWire);

        if ("0".equals(currency)) {
            currency = "CNY";
        } else {
            currency = "USD";
        }
        sql = "SELECT WORKCODE FROM HRMRESOURCE WHERE ID = '" + createPersonnel + "'";
        rs.executeSql(sql);
        rs.next();
        String employeeID = rs.getString("WORKCODE");
        /**
         * 通过OA中的workCode获取CRM中的BP编号的URL
         * 例如： https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/EmployeeCollection?$filter=EmployeeID%20eq%20'171503'
         */
        employeeUrl = PREFIX + employeeID + POSTFIX;
        baseBean.writeLog("employeeUrl: " + employeeUrl);
        JSONObject req = new JSONObject();
        // 获取BP编号
        String businessPartnerID = doGetBP(employeeUrl, USERNAME, PASSWORD, employeeID);
        baseBean.writeLog("businessPartnerID : " + businessPartnerID);
        try {
            req.put("OADocID", processNumber);
            req.put("QuoteReason", map.get(offerReasons));
            req.put("TradeType", map.get(tradeWay));
            req.put("CurrencyCode", currency);
            req.put("QuoteType",map.get(quotationWay));
            req.put("Factory", factoryMap.get(factory));
            req.put("ProductType", map.get(productType));
            req.put("Name", custidOffer + " - 报价申请单");
            req.put("BuyerPartyID", custidOffer);
            req.put("EmployeeResponsiblePartyID", businessPartnerID);
            req.put("WireTypeText", typesOfBondingWire);
            req.put("QuoteCondition", quotationNote);
            req.put("Zshape",shape);
            req.put("Zyuexuqiuliang", onDemand);
            req.put("Zyuanpianchicun", waferSize);
            req.put("Zjianhesishu", wireBonding);
            req.put("Zxinpianshu", chipNumber);

            baseBean.writeLog("当前传过去的值为：" + req.toString());

            String token = doGet(URL, USERNAME, PASSWORD);
            baseBean.writeLog("当前获取的token为: " + token);
            // 首先判断一下此流程是否为退回流程，通过tagValue是否为空值来判断流程是否为退回字段，如果不为空，则该流程为退回，则只需要更新CRM中对应的报价申请单即可
            if (!"".equals(tagValue)) {
                baseBean.writeLog("当前流程已经在CRM中创建过报价申请单");
                objectId = tagValue;
                baseBean.writeLog("objectId: " + objectId);
                url = PREFIX1 + objectId + POSTFIX1;
                baseBean.writeLog("更新前get的url: " + url);
                String token1 = doGet(url, USERNAME, PASSWORD);
                baseBean.writeLog("当前获取的token为: " + token1);
                url = PREFIX1 + objectId;
                baseBean.writeLog("更新CRM的报价申请单url为: " + url);
                // 执行更新报价单的操作
                int code = doPatch(token, req, url, USERNAME, PASSWORD);
                baseBean.writeLog("更新CRM动作返回值为: " + code);
                if (code == 204) {
                    baseBean.writeLog("更新成功！");
                } else {
                    baseBean.writeLog("更新失败");
                    request.getRequestManager().setMessageid("Exception");
                    request.getRequestManager().setMessagecontent("更新失败，请联系管理员");
                }
            } else {
                // 如果tagValue是空的话，则直接在CRM中新建报价单即可
                baseBean.writeLog("当前流程没有在CRM中创建过报价申请单");
                tagValue = doPost(token, req, URL, USERNAME, PASSWORD);
                baseBean.writeLog("当前返回tagValue的值为: " + tagValue);
                tagValue = tagValue.replace("'", "''");
                if (!"".equals(tagValue)) {
                    baseBean.writeLog("成功创建流程，返回信息: " + tagValue);
                    sql = "UPDATE FORMTABLE_MAIN_" + formId + " SET TAG_VALUE = '" + tagValue + "' WHERE REQUESTID = '" + requestId + "'";
                    baseBean.writeLog("执行更新语句: " + sql);
                    rs.execute(sql);
                } else {
                    baseBean.writeLog("没有成功在CRM中创建报价申请单");
                    request.getRequestManager().setMessageid("Exception");
                    request.getRequestManager().setMessagecontent("创建失败，请联系管理员");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Action.SUCCESS;
    }
}

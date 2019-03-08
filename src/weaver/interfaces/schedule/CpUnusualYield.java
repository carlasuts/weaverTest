package weaver.interfaces.schedule;

import org.json.JSONArray;
import org.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.sap.HttpClientJson;
import weaver.soa.workflow.request.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 计划任务 通过WebService拉取MES Flag=0的数据 在成功拉取到数据之后 将FLAG更新成100 防止再次被拉取到 然后触发流程
 */
public class CpUnusualYield extends BaseCronJob {
    private static final String logtableName = "CPYC_MIDDLE";
    private static final String url = "http://172.16.60.96:8090/MesWebService/req";
    private static final String token = "AWK18VSE25SDNKLS3AET@EWL#LDG*!F";
    private static final String fromSystem = "OA";
    private static final String getFunctionName = "MES_GETCPYCYIELDLIST";
    private static final String updateFunctionName = "MES_UPDATECPYCYIELDINFO";
    String sql = "";
    private BaseBean baseBean = new BaseBean();
    private RecordSet rs = new RecordSet();

    public void execute() {
        try {
            baseBean.writeLog("CpUnusualYield开始触发");
            JSONObject req = new JSONObject();
            req.put("fromSystem", fromSystem);
            req.put("functionName", getFunctionName);
            req.put("token", token);
            // 获取MES数据
            String retSrcs = HttpClientJson.readInterfacePost(url, req.toString());
            JSONObject results = new JSONObject(retSrcs);
            JSONArray cpycList = results.getJSONArray("cpyc_LIST");

            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String time = sdf.format(date);

            if (cpycList.length() > 0) {
                for (int i = 0; i < cpycList.length(); i++) {
                    baseBean.writeLog("cpycList length: " + cpycList.length());

                    // 主表和CPYC_MIDDLE中的字段
                    Map<String, String> maintable = new HashMap<String, String>();
                    MainTableInfo mainTableInfo = new MainTableInfo();

                    RequestInfo requestInfo = new RequestInfo();
                    JSONObject jsonObject = (JSONObject) cpycList.get(i);
                    String ID = (jsonObject.getString("id").equals("null")) ? " " : jsonObject.getString("id");
                    maintable.put("ID", ID);
                    String FXNO = (jsonObject.getString("fxno").equals("null")) ? " " : jsonObject.getString("fxno");
                    maintable.put("FXNO", FXNO);
                    String CUST_ID = (jsonObject.getString("cust_ID").equals("null")) ? " " : jsonObject.getString("cust_ID");
                    maintable.put("CUST_ID", CUST_ID);
                    String MAT_DESC = (jsonObject.getString("mat_DESC").equals("null")) ? " " : jsonObject.getString("mat_DESC");
                    maintable.put("MAT_DESC", MAT_DESC);
                    String ASSYLOT = (jsonObject.getString("assylot").equals("null")) ? " " : jsonObject.getString("assylot");
                    maintable.put("ASSYLOT", ASSYLOT);
                    String CUST_RUN_ID = (jsonObject.getString("cust_RUN_ID").equals("null")) ? " " : jsonObject.getString("cust_RUN_ID");
                    maintable.put("CUST_RUN_ID", CUST_RUN_ID);
                    String CREATE_DATE = (jsonObject.getString("create_DATE").equals("null")) ? " " : jsonObject.getString("create_DATE");
                    maintable.put("CREATE_DATE", CREATE_DATE);
                    String RES_ID = (jsonObject.getString("res_ID").equals("null")) ? " " : jsonObject.getString("res_ID");
                    maintable.put("RES_ID", RES_ID);
                    String LOT_ID = (jsonObject.getString("lot_ID").equals("null")) ? " " : jsonObject.getString("lot_ID");
                    maintable.put("LOT_ID", LOT_ID);
                    String PROGRAM_ID = (jsonObject.getString("program_ID").equals("null")) ? " " : jsonObject.getString("program_ID");
                    maintable.put("PROGRAM_ID", PROGRAM_ID);
                    String PKLD = (jsonObject.getString("pkld").equals("null")) ? " " : jsonObject.getString("pkld");
                    maintable.put("PKLD", PKLD);
                    String OPER = (jsonObject.getString("oper").equals("null")) ? " " : jsonObject.getString("oper");
                    maintable.put("OPER", OPER);
                    String INPUT_QTY = (jsonObject.getString("input_QTY").equals("null")) ? " " : jsonObject.getString("input_QTY");
                    maintable.put("INPUT_QTY", INPUT_QTY);
                    String PASS_QTY = (jsonObject.getString("pass_QTY").equals("null")) ? " " : jsonObject.getString("pass_QTY");
                    maintable.put("PASS_QTY", PASS_QTY);
                    String TOTAL_YIELD = (jsonObject.getString("total_YIELD").equals("null")) ? " " : jsonObject.getString("total_YIELD");
                    maintable.put("TOTAL_YIELD", TOTAL_YIELD);
                    String USER_ID = (jsonObject.getString("user_ID").equals("null")) ? " " : jsonObject.getString("user_ID");
                    maintable.put("USER_ID", USER_ID);
                    String FLAG = (jsonObject.getString("flag").equals("null")) ? " " : jsonObject.getString("flag");
                    maintable.put("FLAG", FLAG);
                    String RESV_FIELD1 = (jsonObject.getString("resv_FIELD1").equals("null")) ? " " : jsonObject.getString("resv_FIELD1");
                    maintable.put("RESV_FIELD1", RESV_FIELD1);
                    String RESV_FIELD2 = (jsonObject.getString("resv_FIELD2").equals("null")) ? " " : jsonObject.getString("resv_FIELD2");
                    maintable.put("RESV_FIELD2", RESV_FIELD2);
                    String RESV_FIELD3 = (jsonObject.getString("resv_FIELD3").equals("null")) ? " " : jsonObject.getString("resv_FIELD3");
                    maintable.put("RESV_FIELD3", RESV_FIELD3);
                    String RESV_FIELD4 = (jsonObject.getString("resv_FIELD4").equals("null")) ? " " : jsonObject.getString("resv_FIELD4");
                    maintable.put("RESV_FIELD4", RESV_FIELD4);
                    String RESV_FIELD5 = (jsonObject.getString("resv_FIELD5").equals("null")) ? " " : jsonObject.getString("resv_FIELD5");
                    maintable.put("RESV_FIELD5", RESV_FIELD5);
                    String RESV_FIELD6 = (jsonObject.getString("resv_FIELD6").equals("null")) ? " " : jsonObject.getString("resv_FIELD6");
                    maintable.put("RESV_FIELD6", RESV_FIELD6);
                    String RESV_FIELD7 = (jsonObject.getString("resv_FIELD7").equals("null")) ? " " : jsonObject.getString("resv_FIELD7");
                    maintable.put("RESV_FIELD7", RESV_FIELD7);
                    String RESV_FIELD8 = (jsonObject.getString("resv_FIELD8").equals("null")) ? " " : jsonObject.getString("resv_FIELD8");
                    maintable.put("RESV_FIELD8", RESV_FIELD8);
                    String RESV_FIELD9 = (jsonObject.getString("resv_FIELD9").equals("null")) ? " " : jsonObject.getString("resv_FIELD9");
                    maintable.put("RESV_FIELD9", RESV_FIELD9);
                    String RESV_FIELD10 = (jsonObject.getString("resv_FIELD10").equals("null")) ? " " : jsonObject.getString("resv_FIELD10");
                    maintable.put("RESV_FIELD10", RESV_FIELD10);
                    String RESV_FIELD11 = (jsonObject.getString("resv_FIELD11").equals("null")) ? " " : jsonObject.getString("resv_FIELD11");
                    maintable.put("RESV_FIELD11", RESV_FIELD11);
                    String RESV_FIELD12 = (jsonObject.getString("resv_FIELD12").equals("null")) ? " " : jsonObject.getString("resv_FIELD12");
                    maintable.put("RESV_FIELD12", RESV_FIELD12);
                    String RESV_FIELD13 = (jsonObject.getString("resv_FIELD13").equals("null")) ? " " : jsonObject.getString("resv_FIELD13");
                    maintable.put("RESV_FIELD13", RESV_FIELD13);
                    String RESV_FIELD14 = (jsonObject.getString("resv_FIELD14").equals("null")) ? " " : jsonObject.getString("resv_FIELD14");
                    maintable.put("RESV_FIELD14", RESV_FIELD14);
                    String RESV_FIELD15 = (jsonObject.getString("resv_FIELD15").equals("null")) ? " " : jsonObject.getString("resv_FIELD15");
                    maintable.put("RESV_FIELD15", RESV_FIELD15);
                    String RESV_FIELD16 = (jsonObject.getString("resv_FIELD16").equals("null")) ? " " : jsonObject.getString("resv_FIELD16");
                    maintable.put("RESV_FIELD16", RESV_FIELD16);
                    String RESV_FIELD17 = (jsonObject.getString("resv_FIELD17").equals("null")) ? " " : jsonObject.getString("resv_FIELD17");
                    maintable.put("RESV_FIELD17", RESV_FIELD17);
                    String RESV_FIELD18 = (jsonObject.getString("resv_FIELD18").equals("null")) ? " " : jsonObject.getString("resv_FIELD18");
                    maintable.put("RESV_FIELD18", RESV_FIELD18);
                    String RESV_FIELD19 = (jsonObject.getString("resv_FIELD19").equals("null")) ? " " : jsonObject.getString("resv_FIELD19");
                    maintable.put("RESV_FIELD19", RESV_FIELD19);
                    String RESV_FIELD20 = (jsonObject.getString("resv_FIELD20").equals("null")) ? " " : jsonObject.getString("resv_FIELD20");
                    maintable.put("RESV_FIELD20", RESV_FIELD20);
                    String UPDATE_TIME = (jsonObject.getString("update_TIME").equals("null")) ? " " : jsonObject.getString("update_TIME");
                    maintable.put("UPDATE_TIME", UPDATE_TIME);

                    Boolean b = OAMESMIDDLE.insert1(maintable, logtableName, ID);
                    if (b.equals("false")) {
                        break;
                    }
                    baseBean.writeLog("b: " + b);

                    sql = "SELECT KHM, CP.WORKCODE WORKCODE, HRM.ID ID, LASTNAME FROM TB_CPLLYC CP " +
                            "LEFT JOIN HRMRESOURCE HRM ON CP.WORKCODE = HRM.WORKCODE " +
                            "WHERE 1 = 1 AND KHM = '" + CUST_ID + "'";
                    baseBean.writeLog("查找TE处置人sql: " + sql);
                    rs.execute(sql);
                    String tehrm  = "";
                    String zrr = "";
                    while (rs.next()) {
                        tehrm = tehrm + rs.getString("ID") + ",";
                        zrr = zrr + rs.getString("LASTNAME") + ",";
                    }
                    tehrm = tehrm.substring(0, tehrm.length() - 1);
                    zrr = zrr.substring(0, zrr.length() - 1);
                    baseBean.writeLog("tehrm: " + tehrm);
                    baseBean.writeLog("zrr: " + zrr);

                    // 添加主表数据
                    Property[] propertyArray = new Property[18];
                    propertyArray[0] = new Property();
                    propertyArray[0].setName("fxNO");
                    propertyArray[0].setValue(FXNO);

                    propertyArray[1] = new Property();
                    propertyArray[1].setName("khm");
                    propertyArray[1].setValue(CUST_ID);

                    propertyArray[2] = new Property();
                    propertyArray[2].setName("xh");
                    propertyArray[2].setValue(MAT_DESC);

                    propertyArray[3] = new Property();
                    propertyArray[3].setName("ASSYLOT");
                    propertyArray[3].setValue(ASSYLOT);

                    propertyArray[4] = new Property();
                    propertyArray[4].setName("WPLOT");
                    propertyArray[4].setValue(CUST_RUN_ID);

                    propertyArray[5] = new Property();
                    propertyArray[5].setName("rq");
                    propertyArray[5].setValue(CREATE_DATE);

                    propertyArray[6] = new Property();
                    propertyArray[6].setName("Tester");
                    propertyArray[6].setValue(RES_ID);

                    propertyArray[7] = new Property();
                    propertyArray[7].setName("EDPNo");
                    propertyArray[7].setValue(LOT_ID);

                    propertyArray[8] = new Property();
                    propertyArray[8].setName("cxm");
                    propertyArray[8].setValue(PROGRAM_ID);

                    propertyArray[9] = new Property();
                    propertyArray[9].setName("PKLD");
                    propertyArray[9].setValue(PKLD);

                    propertyArray[10] = new Property();
                    propertyArray[10].setName("gxh");
                    propertyArray[10].setValue(OPER);

                    propertyArray[11] = new Property();
                    propertyArray[11].setName("zys");
                    propertyArray[11].setValue(INPUT_QTY);

                    propertyArray[12] = new Property();
                    propertyArray[12].setName("lps");
                    propertyArray[12].setValue(PASS_QTY);

                    propertyArray[13] = new Property();
                    propertyArray[13].setName("hgl");
                    propertyArray[13].setValue(TOTAL_YIELD);

                    propertyArray[14] = new Property();
                    propertyArray[14].setName("tdrq");
                    propertyArray[14].setValue(time);

                    propertyArray[15] = new Property();
                    propertyArray[15].setName("TIGGERID");
                    propertyArray[15].setValue(ID);

                    propertyArray[16] = new Property();
                    propertyArray[16].setName("tehrm");
                    propertyArray[16].setValue(tehrm);

                    propertyArray[17] = new Property();
                    propertyArray[17].setName("zrr");
                    propertyArray[17].setValue(zrr);

                    mainTableInfo.setProperty(propertyArray);
                    baseBean.writeLog("主表字段添加成功！");

                    // 明细表内容
                    DetailTableInfo detailTableInfo = new DetailTableInfo();
                    DetailTable detailTable = new DetailTable();
                    detailTable.setId("2");
                    JSONArray cpycSublotList = jsonObject.getJSONArray("cpyc_SUBLOT_LIST");
                    int detailsRows = cpycSublotList.length();// 明细表行数
                    detailTable.setRow(new Row[detailsRows]);
                    detailTableInfo.setDetailTable(new DetailTable[1]);
                    baseBean.writeLog("");
                    for (int j = 0; j < cpycSublotList.length(); j++) {
                        JSONObject jsonObject1 = (JSONObject) cpycSublotList.get(j);
//                        String id_1 = (jsonObject1.getString("id").equals("null")) ? "" : jsonObject1.getString("id");
//                        String topbin1Prompt = (jsonObject1.getString("topbin1_PROMPT").equals("null")) ? "" : jsonObject1.getString("topbin1_PROMPT");
//                        String topbin2Prompt = (jsonObject1.getString("topbin2_PROMPT").equals("null")) ? "" : jsonObject1.getString("topbin2_PROMPT");
//                        String topbin3Prompt = (jsonObject1.getString("topbin3_PROMPT").equals("null")) ? "" : jsonObject1.getString("topbin3_PROMPT");
//                        String resvField1_1 = (jsonObject1.getString("resv_FIELD1").equals("null")) ? "" : jsonObject1.getString("resv_FIELD1");
//                        String resvField2_1 = (jsonObject1.getString("resv_FIELD2").equals("null")) ? "" : jsonObject1.getString("resv_FIELD2");
//                        String resvField3_1 = (jsonObject1.getString("resv_FIELD3").equals("null")) ? "" : jsonObject1.getString("resv_FIELD3");
//                        String resvField4_1 = (jsonObject1.getString("resv_FIELD4").equals("null")) ? "" : jsonObject1.getString("resv_FIELD4");
//                        String resvField5_1 = (jsonObject1.getString("resv_FIELD5").equals("null")) ? "" : jsonObject1.getString("resv_FIELD5");
//                        String resvField6_1 = (jsonObject1.getString("resv_FIELD6").equals("null")) ? "" : jsonObject1.getString("resv_FIELD6");
//                        String resvField7_1 = (jsonObject1.getString("resv_FIELD7").equals("null")) ? "" : jsonObject1.getString("resv_FIELD7");
//                        String resvField8_1 = (jsonObject1.getString("resv_FIELD8").equals("null")) ? "" : jsonObject1.getString("resv_FIELD8");
//                        String resvField9_1 = (jsonObject1.getString("resv_FIELD9").equals("null")) ? "" : jsonObject1.getString("resv_FIELD9");
//                        String resvField10_1 = (jsonObject1.getString("resv_FIELD10").equals("null")) ? "" : jsonObject1.getString("resv_FIELD10");
                        String sublotId = (jsonObject1.getString("sublot_ID").equals("null")) ? "" : jsonObject1.getString("sublot_ID");
                        String topbin1Qty = (jsonObject1.getString("topbin1_QTY").equals("null")) ? "" : jsonObject1.getString("topbin1_QTY");
                        String topbin1FailYield = (jsonObject1.getString("topbin1_FAIL_YIELD").equals("null")) ? "" : jsonObject1.getString("topbin1_FAIL_YIELD");
                        String topbin2Qty = (jsonObject1.getString("topbin2_QTY").equals("null")) ? "" : jsonObject1.getString("topbin2_QTY");
                        String topbin2FailYield = (jsonObject1.getString("topbin2_FAIL_YIELD").equals("null")) ? "" : jsonObject1.getString("topbin2_FAIL_YIELD");
                        String topbin3Qty = (jsonObject1.getString("topbin3_QTY").equals("null")) ? "" : jsonObject1.getString("topbin3_QTY");
                        String topbin3FailYield = (jsonObject1.getString("topbin3_FAIL_YIELD").equals("null")) ? "" : jsonObject1.getString("topbin3_FAIL_YIELD");
                        //每行明细对应的字段
                        Row row = new Row();// 明细表创建一行
                        row.setId(String.valueOf(j + 1));
                        row.setCell(new Cell[7]);
                        Cell cell_ph = new Cell();
                        cell_ph.setCol1("1");
                        cell_ph.setName("ph");
                        cell_ph.setValue(sublotId);
                        row.setCell(0, cell_ph);

                        Cell cell_bin1bl = new Cell();
                        cell_bin1bl.setCol1("1");
                        cell_bin1bl.setName("bin1bl");
                        cell_bin1bl.setValue(topbin1Qty);
                        row.setCell(1, cell_bin1bl);

                        Cell cell_bin1bll = new Cell();
                        cell_bin1bll.setCol1("1");
                        cell_bin1bll.setName("bin1bll");
                        cell_bin1bll.setValue(topbin1FailYield);
                        row.setCell(2, cell_bin1bll);

                        Cell cell_bin2bl = new Cell();
                        cell_bin2bl.setCol1("1");
                        cell_bin2bl.setName("bin2bl");
                        cell_bin2bl.setValue(topbin2Qty);
                        row.setCell(3, cell_bin2bl);

                        Cell cell_bin2bll = new Cell();
                        cell_bin2bll.setCol1("1");
                        cell_bin2bll.setName("bin2bll");
                        cell_bin2bll.setValue(topbin2FailYield);
                        row.setCell(4, cell_bin2bll);

                        Cell cell_bin3bl = new Cell();
                        cell_bin3bl.setCol1("1");
                        cell_bin3bl.setName("bin3bl");
                        cell_bin3bl.setValue(topbin3Qty);
                        row.setCell(5, cell_bin3bl);

                        Cell cell_bin3bll = new Cell();
                        cell_bin3bll.setCol1("1");
                        cell_bin3bll.setName("bin3bll");
                        cell_bin3bll.setValue(topbin3FailYield);
                        row.setCell(6, cell_bin3bll);

                        detailTable.setRow(j, row);
                    }
                    detailTableInfo.setDetailTable(0, detailTable);
                    requestInfo.setDetailTableInfo(detailTableInfo);
                    baseBean.writeLog("明细表字段添加成功！");

                    // 添加工作流ID
                    requestInfo.setCreatorid("1");
                    requestInfo.setWorkflowid("361");
                    requestInfo.setDescription("CP_良率异常处理流程-" + time + "(MES自动触发)");
                    baseBean.writeLog("标题设置成功");
                    requestInfo.setMainTableInfo(mainTableInfo);
                    baseBean.writeLog("主表set成功");
                    RequestService service = new RequestService();
                    baseBean.writeLog("创建实例成功");
                    String requestId = service.createRequest(requestInfo);
                    baseBean.writeLog("requestId: " + requestId);

                    if (Integer.valueOf(requestId) > 0) {// 流程触发成功则Flag更新成100
                        // 以下发送json数据到MES中， 更新对应的FLAG和UPDATE_TIME
                        Date date1 = new Date();
                        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");
                        String updateTime = sdf1.format(date1);// 更新时间
                        JSONObject updateReq = new JSONObject();
                        updateReq.put("fromSystem", fromSystem);
                        updateReq.put("functionName", updateFunctionName);
                        updateReq.put("token", token);

                        JSONObject message = new JSONObject();
                        message.put("id", ID);

                        JSONObject[] updateInfos = new JSONObject[2];
                        updateInfos[0] = new JSONObject();
                        updateInfos[0].put("updateField", "FLAG");
                        updateInfos[0].put("updateValue", "100");
                        updateInfos[1] = new JSONObject();
                        updateInfos[1].put("updateField", "UPDATE_TIME");
                        updateInfos[1].put("updateValue", updateTime);
                        message.put("updateInfoList", updateInfos);
                        updateReq.put("message", message);
                        baseBean.writeLog("updateReq: " + updateReq.toString());
                        retSrcs = HttpClientJson.readInterfacePost(url, updateReq.toString());
                        baseBean.writeLog("retSrcs: " + retSrcs);
                        JSONObject updateResult = new JSONObject(retSrcs);
                        String statusValue = updateResult.getString("statusValue");
                        baseBean.writeLog("更新MES表返回的状态" + statusValue);

                        if (Integer.valueOf(statusValue) == 0) {// 如果更新mes表中的FLAG为100成功的话，则同样更新OA中的CPYC_MIDDLE表中的FLAG为100 否则保持为0
                            // 更新中间表对应数据中的FLAG为100
                            String sql = "UPDATE CPYC_MIDDLE SET FLAG = '100' WHERE ID = " + ID;
                            baseBean.writeLog("更新OA中间表语句: " + sql);
                            rs.execute(sql);
                        }
                    }
                }
            } else {
                baseBean.writeLog("当前无可触发流程的数据");
            }
        } catch (Exception e) {
            System.out.println("这边报错了：" + e.getMessage());
            baseBean.writeLog("start log");
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("CpUnusualYield error:" + e.getMessage());
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("end log");
        }
    }
}
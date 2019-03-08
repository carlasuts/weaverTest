package weaver.interfaces.workflow.action.CpUnusualYield;

import org.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.sap.HttpClientJson;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CpUnusualYiledAction implements Action {
    private static final String url = "http://172.16.60.96:8090/MesWebService/req";
    private static final String token = "AWK18VSE25SDNKLS3AET@EWL#LDG*!F";
    private static final String fromSystem = "OA";
    private static final String functionName = "MES_UPDATECPYCYIELDINFO";
    String id = "";
    String cz = "";
    String mescz = "";
    String tecz = "";
    String sql = "";

    @Override
    public String execute(RequestInfo request) {
        BaseBean baseBean = new BaseBean();
        RecordSet rs = new RecordSet();
        try {
            baseBean.writeLog("CP良率异常归档前节点Action开始运行");
            Property[] properties = request.getMainTableInfo().getProperty();
            for (int i = 0; i < properties.length; i++) {
                String name = properties[i].getName().toUpperCase();
                String value = Util.null2String(properties[i].getValue());
                if (name.equals("TIGGERID")) {
                    id = value;
                }
                if (name.equals("TECZPD")) {
                    cz = value;
                }
                if (name.equals("MCZ")) {
                    mescz = value.equals("") ? "RESV_FIELD2" : value;
                }
                if (name.equals("TECZ")) {
                    tecz = value.equals("") ? "RESV_FIELD4" : value;
                }
            }
            baseBean.writeLog("id: " + id);
            baseBean.writeLog("cz: " + cz);
            baseBean.writeLog("mescz: " + mescz);
            baseBean.writeLog("tecz: " + tecz);
            if (tecz.length() > 15) {
                tecz = tecz.substring(0, 15);
            }
            baseBean.writeLog("tecz: " + tecz);
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            String updateTime = sdf.format(date);// 更新时间
            String workCode = "";// 工号

            String lastOperator = request.getLastoperator();
            sql = "SELECT WORKCODE FROM HRMRESOURCE WHERE ID = " + lastOperator;
            baseBean.writeLog("查询工号SQL: " + sql);
            rs.execute(sql);
            rs.next();
            workCode = rs.getString("WORKCODE");

            JSONObject updateReq = new JSONObject();
            updateReq.put("fromSystem", fromSystem);
            updateReq.put("functionName", functionName);
            updateReq.put("token", token);

            JSONObject message = new JSONObject();
            message.put("id", id);

            JSONObject[] updateInfo = new JSONObject[5];
            updateInfo[0] = new JSONObject();
            updateInfo[0].put("updateField", "FLAG");
            updateInfo[0].put("updateValue", "200");

            updateInfo[1] = new JSONObject();
            updateInfo[1].put("updateField", "RESV_FIELD1");
            if (!workCode.equals("")) {
                updateInfo[1].put("updateValue", workCode);
            } else {
                updateInfo[1].put("updateValue", " ");
            }

            updateInfo[2] = new JSONObject();
            updateInfo[2].put("updateField", "RESV_FIELD2");
            if (!mescz.equals("")) {
                updateInfo[2].put("updateValue", mescz);
            } else {
                updateInfo[2].put("updateValue", " ");
            }

            updateInfo[3] = new JSONObject();
            updateInfo[3].put("updateField", "RESV_FIELD4");
            if (!tecz.equals("")) {
                updateInfo[3].put("updateValue", tecz);
            } else {
                updateInfo[3].put("updateValue", " ");
            }

            updateInfo[4] = new JSONObject();
            updateInfo[4].put("updateField", "UPDATE_TIME");
            updateInfo[4].put("updateValue", updateTime);

            message.put("updateInfoList", updateInfo);
            updateReq.put("message", message);
            baseBean.writeLog("updateReq: " + updateReq.toString());
            String retSrcs = HttpClientJson.readInterfacePost(url, updateReq.toString());
            baseBean.writeLog("retSrcs: " + retSrcs);
            JSONObject results = new JSONObject(retSrcs);
            String statusValue = results.getString("statusValue");
            if (Integer.valueOf(statusValue) == 0) {// 如果更新mes表flag为200成功，则同样更新OA中间表(CPYC_MIDDLE)
                sql = "UPDATE CPYC_MIDDLE SET FLAG = '200' WHERE ID = " + id;
                baseBean.writeLog("更新OA中间表语句: " + sql);
                rs.execute(sql);
            }
        } catch (Exception e) {
            baseBean.writeLog("start log");
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("CpUnusualYiledAction error:" + e.getMessage());
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("end log");
        }
        return Action.SUCCESS;
    }
}

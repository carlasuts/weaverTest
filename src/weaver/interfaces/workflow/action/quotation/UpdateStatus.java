package weaver.interfaces.workflow.action.quotation;

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
 * TODO: 每个节点后用来更新OA审核状态
 */
public class UpdateStatus implements Action {
    /**
     * 需要更新报价单的前缀
     */
    private static final String PREFIX = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/";
    private static final String USERNAME = "OAUser";
    private static final String PASSWORD = "OAUser";
    /**
     * 后缀 更新前get需要加后缀 更新时patch不用加后缀
     */
    private static final String POSTFIX = "?$format=json";
    private static final int SUCCESS_FLAG = 204;

    @Override
    public String execute(RequestInfo request) {
        BaseBean baseBean = new BaseBean();
        baseBean.writeLog("UpdateStatus Start Running");
        RecordSet rs = new RecordSet();
        JSONObject req = new JSONObject();
        String requestId = request.getRequestid();
        int formId = Math.abs(request.getRequestManager().getFormid());
        // 下个节点的名称
        String nodeName = "";
        String url = "";
        String objectId = "";
        String sql = "";
        int nextNodeId = request.getRequestManager().getNextNodeid();

        sql = "SELECT * FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            objectId = rs.getString("TAG_VALUE");
        }

        sql = "SELECT * FROM WORKFLOW_NODEBASE WHERE ID = " + nextNodeId;
        baseBean.writeLog(sql);
        rs.executeSql(sql);
        if (rs.next()) {
            nodeName = rs.getString("NODENAME");
        }
        try {
            // OA审批状态
            req.put("OAStatus", nodeName);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        url = PREFIX + objectId + POSTFIX;
        baseBean.writeLog("更新前get的url: " + url);
        String token = doGet(url, USERNAME, PASSWORD);
        baseBean.writeLog("当前获取到的token: " + token);
        url = PREFIX + objectId;
        // 更新报价申请单
        int code = doPatch(token, req, url, USERNAME, PASSWORD);
        if (code == SUCCESS_FLAG) {
            baseBean.writeLog("更新成功！");
        } else {
            baseBean.writeLog("更新失败");
            request.getRequestManager().setMessageid("Exception");
            request.getRequestManager().setMessagecontent("更新失败，请联系管理员");
        }
        return Action.SUCCESS;
    }
}

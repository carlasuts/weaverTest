package weaver.interfaces.workflow.action.technicalprotocol;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 * TODO: 生成签核完成的流程编号，用户Link PO申请单
 */
public class UpdateSerialNumberAction implements Action {
    private static BaseBean baseBean = new BaseBean();
    private static RecordSet rs = new RecordSet();
    private String sql = "";

    @Override
    public String execute(RequestInfo request) {
        baseBean.writeLog("UpdateSerialNumberAction Start Running!");

        String serialNumber = "";
        String serialNumberDone = "";
        int formId = Math.abs(request.getRequestManager().getFormid());
        String requestId = request.getRequestid();
        sql = "SELECT SERIAL_NUMBER FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            serialNumber = rs.getString("SERIAL_NUMBER");
        }
        baseBean.writeLog("serialNumber: " + serialNumber);
        if ("".equals(serialNumber) || serialNumber != null) {
            serialNumberDone = serialNumber + "R";
            sql = "UPDATE FORMTABLE_MAIN_" + formId + " SET SERIAL_NUMBER_DONE = '" + serialNumberDone + "' WHERE REQUESTID = '" + requestId + "'";
            baseBean.writeLog("更新签核后流程编号SQL: " + sql);
            rs.executeSql(sql);
        }

        return Action.SUCCESS;
    }
}

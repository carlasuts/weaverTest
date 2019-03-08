package weaver.interfaces.workflow.action.externalDocument;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class DeleteDetailAction implements Action {
    private static BaseBean baseBean = new BaseBean();
    private static RecordSet rs = new RecordSet();
    private String sql = "";

    @Override
    public String execute(RequestInfo request) {
        baseBean.writeLog("DeleteDetailAction Start Running!");
        String mainRequest = "";
        String mainId = "";
        String requestId = request.getRequestid();
        int formId = Math.abs(request.getRequestManager().getFormid());
        sql = "SELECT MAIN_REQUEST FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            mainRequest = rs.getString("MAIN_REQUEST");
        }

        sql = "SELECT ID FROM FORMTABLE_MAIN_286 WHERE REQUESTID = '" + mainRequest + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            mainId = rs.getString("ID");
        }

        sql = "SELECT COUNT(*) TEMP FROM FORMTABLE_MAIN_286_DT1 WHERE MAINID = '" + mainId + "' AND PTC = '0'";
        rs.executeSql(sql);
        if (rs.next()) {
            String temp = rs.getString("TEMP");
            if (!"0".equals(temp)) {
                sql = "DELETE FROM FORMTABLE_MAIN_286_DT1 WHERE MAINID = '" + mainId + "' AND PTC = '0'";
                rs.executeSql(sql);
            } else {
                baseBean.writeLog("主流程明细表中的数据已经被删除");
            }
            baseBean.writeLog("temp: " + temp);
        }

        return Action.SUCCESS;
    }
}

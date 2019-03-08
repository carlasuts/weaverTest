package weaver.interfaces.workflow.action.systemChage.waferDepart;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class WaferSystemChangeAction implements Action {

    @Override
    public String execute(RequestInfo request) {
        BaseBean baseBean = new BaseBean();
        baseBean.writeLog("WaferSystemChangeAction��ʼ����");
        try {
            String requestId = request.getRequestid();
            int formId = -request.getRequestManager().getFormid();
            String sql = "";
            String receivedpersonids = "";
            String rolesmark = "ԲƬ��ϵͳ�����Ա";
            String resourceId = request.getLastoperator();

            RecordSet rs = new RecordSet();
            sql = "SELECT RESOURCEID FROM HRMROLEMEMBERS WHERE ROLEID = (" +
                    "SELECT DISTINCT A.ID FROM HRMROLES A, HRMROLEMEMBERS B " +
                    "WHERE B.ROLEID = A.ID AND A.ROLESMARK = '" + rolesmark +
                    "' AND B.RESOURCEID = '" + resourceId + "')";
            baseBean.writeLog("��ѯRESOURCEID: " + sql);
            rs.execute(sql);
            while (rs.next()) {
                if (!rs.getString("RESOURCEID").equals(resourceId)) {
                    receivedpersonids = receivedpersonids + rs.getString("RESOURCEID") + ",";
                }
            }
            baseBean.writeLog("receivedpersonids: " + receivedpersonids);
            sql = "UPDATE FORMTABLE_MAIN_" + formId + " SET MULTIROLE = '" + receivedpersonids + "' WHERE REQUESTID = '" + requestId + "'";
            baseBean.writeLog("����sql: " + sql);
            rs.execute(sql);
        } catch (Exception e) {
            baseBean.writeLog("start log");
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("WaferSystemChangeAction error:" + e.getMessage());
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("end log");
        }
        return Action.SUCCESS;
    }
}

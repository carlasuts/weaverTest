package weaver.interfaces.workflow.action.inspect;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 * TODO: 根据申请单中的期别来筛选人员信息表中的PD人员，并更新到主表的PD人员中
 */
public class InspectAction implements Action {
    private static BaseBean baseBean = new BaseBean();
    private static RecordSet rs = new RecordSet();
    private String sql = "";

    @Override
    public String execute(RequestInfo request) {
        baseBean.writeLog("InspectAction Start Running!");
        // 期别
        String stage = "";
        // condition OBASINSPECTDOP表中的期别
        String condtion = "";
        // 对应PD人员
        String pd = "";
        String requestId = request.getRequestid();
        int formId = Math.abs(request.getRequestManager().getFormid());
        sql = "SELECT * FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            // 期别判断PD
            stage = rs.getString("STAGE");
            if ("0".equals(stage)) {
                condtion = "一期";
            } else if ("1".equals(stage)) {
                condtion = "二期";
            } else {
                condtion = "三期";
            }
        }
        baseBean.writeLog("condtion: " + condtion);
        // 取的人员维护信息表中的PD人员并拼接起来
        sql = "SELECT WM_CONCAT(PD) PD FROM OBASINSPECTDOP WHERE CONDITION = '" + condtion + "'";
        baseBean.writeLog("sql: " + sql);
        rs.executeSql(sql);
        if (rs.next()) {
            pd = rs.getString("PD");
        }
        baseBean.writeLog("pd: " + pd);
        sql = "UPDATE FORMTABLE_MAIN_" + formId + " SET PD_PERSON = '" + pd + "' WHERE REQUESTID = '" + requestId + "'";
        baseBean.writeLog("更新PD人员SQL：" + sql);
        rs.executeSql(sql);

        return Action.SUCCESS;
    }
}

package weaver.interfaces.workflow.action.technicalprotocol;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 */
public class TechnicalProtocolAction implements Action {
    private static BaseBean baseBean = new BaseBean();
    private static RecordSet rs = new RecordSet();
    private String sql = "";
    @Override
    public String execute(RequestInfo request) {
        String fileNo = "";
        String attachment = "";
        baseBean.writeLog("TechnicalProtocolAction Starting Running!");
        int formId = Math.abs(request.getRequestManager().getFormid());
        String requestId =request.getRequestid();

        sql = "SELECT * FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            fileNo = rs.getString("FILENO");
        }
        baseBean.writeLog("fileNo: " + fileNo);

        if (!"".equals(fileNo)){
            baseBean.writeLog("创建人有选择文档编号");
            sql = "SELECT DISTINCT ATTACHMENT FROM FORMTABLE_MAIN_" + formId + " WHERE FILENO = '" + fileNo + "' AND ATTACHMENT IS NOT NULL";
            baseBean.writeLog("sql: " + sql);
            rs.executeSql(sql);
            if (rs.next()) {
                attachment = rs.getString("ATTACHMENT");
            }
            if (attachment != null || !"".equals(attachment)) {
                // 如果能找到当前选择的附件
                baseBean.writeLog("attachment: " + attachment);
                sql = "UPDATE FORMTABLE_MAIN_" + formId + " SET ATTACHMENT = '" +  attachment + "' WHERE REQUESTID = '" + requestId + "'";
                baseBean.writeLog("更新当前流程的附件SQL: " + sql);
                rs.executeSql(sql);
            } else {
                // 如果找不到附件，则卡控流程
                request.getRequestManager().setMessageid("Error");
                request.getRequestManager().setMessagecontent("找不到当前附件，请检查。");
            }
        } else {
            baseBean.writeLog("创建人没有选择文档编号");
        }

        return Action.SUCCESS;
    }
}

package weaver.interfaces.workflow.action.technicalprotocol;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 * @TODO 更新文档编号和更新附件字段的值（与新附件的值相同）
 */
public class UpdateFileNoAction implements Action {
    private static BaseBean baseBean = new BaseBean();
    private static RecordSet rs = new RecordSet();
    private String sql = "";

    @Override
    public String execute(RequestInfo request) {
        baseBean.writeLog("UpdateFileNoAction Starting Running!");
        int formId = Math.abs(request.getRequestManager().getFormid());
        String requestId =request.getRequestid();
        String name = "";
        String manufacturers ="";
        String type = "";
        String attachmentNew = "";
        String fileNo = "";
        sql = "SELECT NAME, MANUFACTURERS, TYPE, ATTACHMENT_NEW FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            // 设备名称
            name = rs.getString("NAME");
            // 设备厂家
            manufacturers = rs.getString("MANUFACTURERS");
            // 设备类型
            type = rs.getString("TYPE");
            // 新附件字段值
            attachmentNew = rs.getString("ATTACHMENT_NEW");
        }
        // 文档编号生成规则：设备名称-设备厂家-设备型号-文档ID
        fileNo = name + "-" + manufacturers + "-" + type + "-" + attachmentNew;
        baseBean.writeLog("fileNo: " + fileNo);
        sql = "UPDATE FORMTABLE_MAIN_" + formId + " SET ATTACHMENT = '" + attachmentNew + "', FILENO = '" + fileNo + "' WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);

        return Action.SUCCESS;
    }
}

package weaver.interfaces.workflow.action.technicalprotocol;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 * @TODO 创建新技术协议文件编号
 */
public class CreateFileNoAction implements Action {
    private static BaseBean baseBean = new BaseBean();
    private static RecordSet rs = new RecordSet();
    private String sql = "";

    @Override
    public String execute(RequestInfo request) {
        baseBean.writeLog("CreateFileNoAction Starting running!");
        int formId = Math.abs(request.getRequestManager().getFormid());
        String requestId = request.getRequestid();
        String name = "";
        String fileNo = "";
        sql = "SELECT NAME FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            // 设备名称
            name = rs.getString("NAME");
        }
        fileNo = name;
        sql = "UPDATE FORMTABLE_MAIN_" + formId + " SET FILENO = '" + fileNo + "' WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);

        return Action.SUCCESS;
    }
}

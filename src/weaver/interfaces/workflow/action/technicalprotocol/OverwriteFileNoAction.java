package weaver.interfaces.workflow.action.technicalprotocol;


import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 */
public class OverwriteFileNoAction implements Action {
    private static BaseBean baseBean = new BaseBean();
    private static RecordSet rs = new RecordSet();
    private String sql = "";
    private String name = "";
    private String attachment = "";
    private String fileNo = "";
    @Override
    public String execute(RequestInfo request) {
        baseBean.writeLog("OverwriteFileNoAction开始运行");
        int formid = Math.abs(request.getRequestManager().getFormid());
        String requestId = request.getRequestid();
        sql = "SELECT NAME,ATTACHMENT FROM FORMTABLE_MAIN_" + formid + " WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            name = rs.getString("NAME");
            attachment = rs.getString("ATTACHMENT");
        }
        fileNo = name + attachment;
        sql = "";

        return Action.SUCCESS;
    }
}

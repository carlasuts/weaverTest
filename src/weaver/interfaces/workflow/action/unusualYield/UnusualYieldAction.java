package weaver.interfaces.workflow.action.unusualYield;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class UnusualYieldAction implements Action {
    @Override
    public String execute(RequestInfo request) {
        BaseBean baseBean = new BaseBean();
        baseBean.writeLog("UnusualYieldAction开始执行！");
        RecordSet rs = new RecordSet();
        String sql = "";
        String requestId = request.getRequestid();
        int formId = Math.abs(request.getRequestManager().getFormid());
        sql = "SELECT IFCUS FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.execute(sql);
        rs.next();
        String ifcus = rs.getString("IFCUS");
        if (!ifcus.equals("") && (Integer.valueOf(ifcus)) == 0) {
            baseBean.writeLog("此流程经过客户处置节点");
            sql = "SELECT SCFJ FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
            rs.execute(sql);
            rs.next();
            if (rs.getString("SCFJ").equals("")) {
                baseBean.writeLog("附件为空，请检查附件。");
                request.getRequestManager().setMessageid("Exception");
                request.getRequestManager().setMessagecontent("请上传附件!");
            } else {
                baseBean.writeLog("存在附件，通过。");
            }
        } else {
            baseBean.writeLog("此流程还未经过客户处置节点。");
        }
        return Action.SUCCESS;
    }
}
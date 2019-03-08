package weaver.interfaces.workflow.action.travelling;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 * TODO:测试读Excel附件内容
 */
public class Test implements Action {
    private static BaseBean baseBean = new BaseBean();
    private static RecordSet rs = new RecordSet();

    @Override
    public String execute(RequestInfo request) {
        baseBean.writeLog("Test Start Running!");
//        FileUploadToPath fu = new FileUploadToPath();

        return Action.SUCCESS;
    }
}

package weaver.interfaces.workflow.action.technicalprotocol;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

import java.util.HashMap;
import java.util.Map;

/**
 * @author zong.yq
 * TODO: 按照产品线分类归档上传的技术协议
 */
public class TechnicalProtocolSortAction implements Action {
    private static BaseBean baseBean = new BaseBean();
    private static RecordSet rs = new RecordSet();
    private String sql = "";

    @Override
    public String execute(RequestInfo request) {
        baseBean.writeLog("TechnicalProtocolSortAction Start Running!");
        String attachmentNew = "", attachmentStamp = "", line = "";
        String requestId = request.getRequestid();
        int formId = Math.abs(request.getRequestManager().getFormid());
        sql = "SELECT ATTACHMENT_NEW, ATTACHMENT_STAMP, LINE FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            attachmentNew = rs.getString("ATTACHMENT_NEW");
            attachmentStamp = rs.getString("ATTACHMENT_STAMP");
            line = rs.getString("LINE");
        }
        // 设置一个map，后面直接遍历这个map对象，防止写重复的SQL，map对象中的value即为DOCDETAIL中的ID
        Map<String, String> map = new HashMap<String, String>(2);
        map.put("attachmentNew", attachmentNew);
        map.put("attachmentStamp", attachmentStamp);

        // 根据产品线查找DOCSECCATEGORY中对应的ID，即为DOCDETAIL中需要更新的SECCATEGORY
        String secCategory = "";
        sql = "SELECT ID FROM DOCSECCATEGORY WHERE CATEGORYNAME = '" + line + "'";
        rs.executeSql(sql);
        // 根据工序选择查找对应的文档路径ID，如果未找到，则卡控流程
        if (rs.next()) {
            secCategory = rs.getString("ID");
            baseBean.writeLog("secCategory: " + secCategory);

            for (String key: map.keySet()) {
                String value = map.get(key).toString();
                sql = "UPDATE DOCDETAIL SET SECCATEGORY = '" + secCategory + "' WHERE ID = '" + value + "'";
                baseBean.writeLog("sql: " + sql);
                rs.executeSql(sql);
            }

        } else {
            baseBean.writeLog("不存在此文档路径");
            request.getRequestManager().setMessageid("Exception");
            request.getRequestManager().setMessagecontent("请联系管理员创建文档路径");
        }
        return Action.SUCCESS;
    }
}

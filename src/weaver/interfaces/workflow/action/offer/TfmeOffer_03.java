package weaver.interfaces.workflow.action.offer;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.MainTableInfo;

public class TfmeOffer_03 {
	// �ɱ��ϼ�

	public void getcostofcombined(String rid, MainTableInfo maintableinfo, String workflowid) {

		int formid = BillUtil.getFormId(Integer.parseInt(workflowid));

		BaseBean baseBean = new BaseBean();
		RecordSet rs = new RecordSet();
		baseBean.writeLog("����ӿ�TfmeOffer03");

		// ��װ�ɱ�
		// оƬ�ɱ�
		String sql = "";
		String mainid = "";// ��ϸ��� mainid
		sql = "select ID from formtable_main_" + formid + "  where requestid =" + rid;
		baseBean.writeLog("11111111111111");
		rs.executeSql(sql);
		while (rs.next()) {
			mainid = rs.getString("ID");
		}

		sql = "DELETE FROM FORMTABLE_MAIN_" + formid + " DT2 WHERE MAINID = '" + mainid + "'";
		rs = new RecordSet();
		rs.execute(sql);

		sql = "insert into formtable_main_" + formid + "_dt2 (MAINID,NOTE,SUGGEST,PRINT_STATUS) values (" + "'" + mainid
				+ "'," + "'��۲���100$'," + "'0'," + "'0'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);
		sql = "insert into formtable_main_" + formid + "_dt2 (MAINID,NOTE,SUGGEST,PRINT_STATUS) values (" + "'" + mainid
				+ "'," + "'��һ��оƬ'," + "'0'," + "'0'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);
		sql = "insert into formtable_main_" + formid + "_dt2 (MAINID,NOTE,SUGGEST,PRINT_STATUS) values (" + "'" + mainid
				+ "'," + "'ͭ�۲���100$'," + "'0'," + "'0'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);
		sql = "insert into formtable_main_" + formid + "_dt2 (MAINID,NOTE,SUGGEST,PRINT_STATUS) values (" + "'" + mainid
				+ "'," + "'��һ������˿'," + "'0'," + "'0'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);

	}
}

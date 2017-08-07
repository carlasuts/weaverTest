package weaver.interfaces.workflow.util;

import java.util.HashMap;
import java.util.Map;

import weaver.conn.RecordSet;

public class BillUtil {

	/**
	 * 根据表单的ID以及明细表序号，获得FieldId和Name的对应MAP
	 * 
	 * @param formid
	 * @param num
	 * @return
	 */
	public static Map<String, String> getFieldIdNameMap(int formid, int num) {
		formid = Math.abs(formid);
		String sql = null;
		if (num == 0) {
			sql = "SELECT WBF.ID, WBF.FIELDNAME FROM WORKFLOW_BILLFIELD WBF WHERE WBF.DETAILTABLE IS NULL AND WBF.BILLID = -"
					+ formid;
		} else {
			sql = "SELECT WBF.ID, WBF.FIELDNAME FROM WORKFLOW_BILLFIELD WBF WHERE WBF.DETAILTABLE = 'formtable_main_"
					+ formid + "_dt" + num + "' AND WBF.BILLID = -" + formid;
		}

		RecordSet rs = new RecordSet();
		rs.execute(sql);
		Map<String, String> fieldMap = new HashMap<String, String>();
		while (rs.next()) {
			fieldMap.put(rs.getString("FIELDNAME").toUpperCase(),
					rs.getString("ID"));
		}
		return fieldMap;
	}

	/**
	 * 根据表单的ID、明细表序号以及数据表中的名字，获得FieldId
	 * 
	 * @param formid
	 * @param num
	 * @param fieldName
	 * @return
	 */
	public static String getLabelId(int formid, int num, String fieldName) {
		formid = Math.abs(formid);
		String sql = null;
		if (num == 0) {
			sql = "SELECT WBF.ID, WBF.FIELDNAME FROM WORKFLOW_BILLFIELD WBF WHERE WBF.DETAILTABLE IS NULL AND WBF.BILLID = -" + formid + " AND UPPER(WBF.FIELDNAME) = UPPER('"
					+ fieldName + "')";
		} else {
			sql = "SELECT WBF.ID, WBF.FIELDNAME FROM WORKFLOW_BILLFIELD WBF WHERE WBF.DETAILTABLE = 'formtable_main_"
					+ formid
					+ "_dt"
					+ num
					+ "' AND WBF.BILLID = -"
					+ formid
					+ " AND UPPER(WBF.FIELDNAME) = UPPER('" + fieldName + "')";
		}
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		if (rs.next()) {
			return rs.getString("ID");
		} else {
			return null;
		}
	}

	/**
	 * 根据流程的ID以及节点的名字，获得NodeId
	 * 
	 * @param workflowid
	 * @param nodeName
	 * @return
	 */
	public static int getNodeId(int workflowid, String nodeName) {
		String sql = "SELECT WFN.NODEID FROM WORKFLOW_NODEBASE WNB INNER JOIN WORKFLOW_FLOWNODE WFN ON WNB.ID = WFN.NODEID WHERE WFN.WORKFLOWID = "
				+ workflowid + " AND WNB.NODENAME = '" + nodeName + "'";
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		if (rs.next()) {
			return Integer.parseInt(rs.getString("NODEID"));
		} else {
			return 0;
		}
	}
}

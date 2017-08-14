package weaver.interfaces.workflow.util;

import java.util.HashMap;
import java.util.Map;

import weaver.conn.RecordSet;

/**
 * 自制的一些工具方法
 * 
 * @author xu.sy
 *
 */
public class BillUtil {

	/**
	 * 根据表单的ID以及明细表序号，获得栏位ID及其名称的键值对
	 * 
	 * @param formid
	 *            表的ID
	 * @param num
	 *            第几个明细（主表为0）
	 * @return 栏位ID及其名称的键值对
	 */
	public static Map<Integer, String> getFieldIdNameMap(int formid, int num) {
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
		Map<Integer, String> fieldMap = new HashMap<Integer, String>();
		while (rs.next()) {
			fieldMap.put(rs.getInt("ID"), rs.getString("FIELDNAME")
					.toUpperCase());
		}
		return fieldMap;
	}

	/**
	 * 根据表单的ID、明细表序号以及数据表中的名字，获得FieldId
	 * 
	 * @param formid
	 *            表的ID
	 * @param num
	 *            第几个明细（主表为0）
	 * @param fieldName
	 *            栏位名字
	 * @return 栏位ID
	 */
	public static String getLabelId(int formid, int num, String fieldName) {
		formid = Math.abs(formid);
		String sql = null;
		if (num == 0) {
			sql = "SELECT WBF.ID, WBF.FIELDNAME FROM WORKFLOW_BILLFIELD WBF WHERE WBF.DETAILTABLE IS NULL AND WBF.BILLID = -"
					+ formid
					+ " AND UPPER(WBF.FIELDNAME) = UPPER('"
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
	 *            流程的ID
	 * @param nodeName
	 *            节点的名字（在后台中配置）
	 * @return 节点的ID
	 */
	public static int getNodeId(int workflowid, String nodeName) {
		String sql = "SELECT WFN.NODEID FROM WORKFLOW_NODEBASE WNB INNER JOIN WORKFLOW_FLOWNODE WFN ON WNB.ID = WFN.NODEID WHERE WFN.WORKFLOWID = "
				+ workflowid + " AND WNB.NODENAME = '" + nodeName + "'";
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		if (rs.next()) {
			return Integer.parseInt(rs.getString("NODEID"));
		} else {
			return -999;
		}
	}

	/**
	 * 通过workFlowId获得formId
	 * 
	 * @param workFlowId
	 *            流程的ID
	 * @return 表的ID
	 */
	public static int getFormId(int workFlowId) {
		String sql = "SELECT WB.FORMID FROM WORKFLOW_BASE WB WHERE WB.ID = "
				+ workFlowId;
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		if (rs.next()) {
			return Math.abs(Integer.parseInt(rs.getString("FORMID")));
		} else {
			return -999;
		}
	}

	/**
	 * 根据表单的ID、明细表序号以及栏位的名字，获得选择项及其对应值的键值对
	 * 
	 * @param formid
	 *            表的ID
	 * @param num
	 *            第几个明细（主表为0）
	 * @param fieldName
	 *            栏位名字
	 * @return 选项名及其对应值的键值对
	 */
	public static Map<Integer, String> getSelectNameValueMap(int formid,
			int num, String fieldName) {
		formid = Math.abs(formid);
		String sql = null;
		if (num == 0) {
			sql = "SELECT WS.SELECTNAME, WS.SELECTVALUE FROM WORKFLOW_SELECTITEM WS INNER JOIN WORKFLOW_BILLFIELD WBF ON WS.FIELDID = WBF.ID WHERE WBF.DETAILTABLE IS NULL AND WBF.BILLID = -"
					+ formid
					+ " AND UPPER(WBF.FIELDNAME) = UPPER('"
					+ fieldName + "')";
		} else {
			sql = "SELECT WS.SELECTNAME, WS.SELECTVALUE FROM WORKFLOW_SELECTITEM WS INNER JOIN WORKFLOW_BILLFIELD WBF ON WS.FIELDID = WBF.ID WHERE WBF.DETAILTABLE = 'formtable_main_"
					+ formid
					+ "_dt"
					+ num
					+ "' AND WBF.BILLID = -"
					+ formid
					+ " AND UPPER(WBF.FIELDNAME) = UPPER('" + fieldName + "')";
		}
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		Map<Integer, String> selectMap = new HashMap<Integer, String>();
		while (rs.next()) {
			selectMap.put(rs.getInt("SELECTVALUE"), rs.getString("SELECTNAME")
					.toUpperCase());
		}
		return selectMap;
	}

	/**
	 * 根据表单的ID、明细表序号、栏位名以及该栏位中的选择项的名字，获得选择项的实际对应值
	 * 
	 * @param formid
	 *            表的ID
	 * @param num
	 *            第几个明细（主表为0）
	 * @param fieldName
	 *            栏位名字
	 * @param selectName
	 *            选择项的名字
	 * @return 选择项的实际对应值
	 */
	public static int getSelectValue(int formid, int num, String fieldName,
			String selectName) {
		formid = Math.abs(formid);
		String sql = null;
		if (num == 0) {
			sql = "SELECT WS.SELECTVALUE FROM WORKFLOW_SELECTITEM WS INNER JOIN WORKFLOW_BILLFIELD WBF ON WS.FIELDID = WBF.ID WHERE WBF.DETAILTABLE IS NULL AND WBF.BILLID = -"
					+ formid
					+ " AND UPPER(WBF.FIELDNAME) = UPPER('"
					+ fieldName
					+ "') AND UPPER(WS.SELECTNAME) = UPPER('"
					+ selectName + "')";
		} else {
			sql = "SELECT WS.SELECTVALUE FROM WORKFLOW_SELECTITEM WS INNER JOIN WORKFLOW_BILLFIELD WBF ON WS.FIELDID = WBF.ID WHERE WBF.DETAILTABLE = 'formtable_main_"
					+ formid
					+ "_dt"
					+ num
					+ "' AND WBF.BILLID = -"
					+ formid
					+ " AND UPPER(WBF.FIELDNAME) = UPPER('"
					+ fieldName
					+ "')"
					+ " AND UPPER(WS.SELECTNAME) = UPPER('" + selectName + "')";
		}
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		if (rs.next()) {
			return Integer.parseInt(rs.getString("SELECTVALUE"));
		}
		return -1;
	}
}

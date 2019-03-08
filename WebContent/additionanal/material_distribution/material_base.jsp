<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util,net.sf.json.JSONObject,weaver.general.BaseBean" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.soa.workflow.request.Property" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<%
    Map<String,String> map = new HashMap<String,String>();	
	
	//当前基本信息	
    int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
	int formid = Util.getIntValue(request.getParameter("formid"));//表单id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
	
	String delivery = BillUtil.getLabelId(formid,0,"delivery_qty");//配送次数
	String inv_id4 = BillUtil.getLabelId(formid,4,"inv_id");//明细表4物料号
	String inv_id5 = BillUtil.getLabelId(formid,5,"inv_id");//明细表5物料号	
	String inv_id6 = BillUtil.getLabelId(formid,6,"inv_id");//明细表6物料号
	int nodeidApply = BillUtil.getNodeId(workflowid, "申请");
	
	map.put("delivery", delivery);
	map.put("inv_id4", inv_id4);
	map.put("inv_id5", inv_id5);
	map.put("inv_id6", inv_id6);
	map.put("nodeidApply", String.valueOf(nodeidApply));
	JSONObject jsonObject = JSONObject.fromObject(map);
	out.print(jsonObject.toString());
%>

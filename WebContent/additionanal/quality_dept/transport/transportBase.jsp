<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util,net.sf.json.JSONObject,weaver.general.BaseBean" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.soa.workflow.request.Property" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<%@ page import="weaver.hrm.*"%>
<%
    Map<String,String> map = new HashMap<String,String>();
	
	BaseBean bb = new BaseBean();
	
	//当前基本信息	
    int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
	int formid = Util.getIntValue(request.getParameter("formid"));//表单id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
	
	String iftemporary = BillUtil.getLabelId(formid,0,"iftemporary");//临时、长期送货
	String longtime = BillUtil.getLabelId(formid,0,"longtime");//长期提货时间
	String trans_company = BillUtil.getLabelId(formid,0,"trans_company");// 货运公司名称
	String date1 = BillUtil.getLabelId(formid,0,"date1");// 接收日期
	String stage = BillUtil.getLabelId(formid,0,"stage");// 期别
	String entrepot_type = BillUtil.getLabelId(formid,0,"entrepot_type");// 提、送货地点
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String currentDate = sdf.format(new Date());
	
	//获取节点ID
	int nodeidApply = BillUtil.getNodeId(workflowid, "货代提交进厂申请");
	int nodeidSecurity = BillUtil.getNodeId(workflowid, "安保审核信息");
	
	bb.writeLog("啦啦啦");
	bb.writeLog(nodeid);
	bb.writeLog(formid);
	bb.writeLog(workflowid);
	bb.writeLog(iftemporary);
	bb.writeLog(trans_company);
	bb.writeLog(date1);
	bb.writeLog(stage);
	bb.writeLog(entrepot_type);
	bb.writeLog(currentDate);
	
	map.put("iftemporary", iftemporary);
	map.put("longtime", longtime);
	map.put("trans_company", trans_company);
	map.put("date1", date1);
	map.put("stage", stage);
	map.put("entrepot_type", entrepot_type);
	map.put("nodeidApply", String.valueOf(nodeidApply));
	map.put("nodeidSecurity", String.valueOf(nodeidSecurity));
	map.put("currentDate", currentDate);
	JSONObject jsonObject = JSONObject.fromObject(map);
	out.print(jsonObject.toString());
%>

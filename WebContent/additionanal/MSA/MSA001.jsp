<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<%
User user = HrmUserVarify.getUser (request , response) ;
if(user == null)  return ;
int requestid = Util.getIntValue(request.getParameter("requestid"));//请求id
int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
int formid = Util.getIntValue(request.getParameter("formid"));//表单id
int isbill = Util.getIntValue(request.getParameter("isbill"));//表单类型，1单据，0表单
int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
String type = Util.null2String(request.getParameter("type"));

int resourceId = user.getUID();
int nodeidApply = BillUtil.getNodeId(workflowid, "申请");
int nodeidPl_CC = BillUtil.getNodeId(workflowid, "MSA责任人CC");
int nodeidPl_ST = BillUtil.getNodeId(workflowid, "MSA责任人ST");
int nodeidPl_HF =  BillUtil.getNodeId(workflowid, "MSA责任人HF");
int nodeidAuditor_CC = BillUtil.getNodeId(workflowid, "审核人CC");
int nodeidAuditor_ST = BillUtil.getNodeId(workflowid, "审核人ST");
int nodeidAuditor_HF = BillUtil.getNodeId(workflowid, "审核人HF");
int nodeidFile = BillUtil.getNodeId(workflowid, "归档");

String managestate = BillUtil.getLabelId(formid,0,"managestate");
String tbdate = BillUtil.getLabelId(formid,0,"tbdate");
String tbr = BillUtil.getLabelId(formid,0,"tbr");
String tbtel = BillUtil.getLabelId(formid,0,"tbtel");
String tbmail = BillUtil.getLabelId(formid,0,"tbmail");
String MSAdate = BillUtil.getLabelId(formid,0,"MSAdate");
String MSAinterval = BillUtil.getLabelId(formid,0,"MSAinterval");
String MSAeffectivedate = BillUtil.getLabelId(formid,0,"MSAeffectivedate");
%>
<script type="text/javascript">

jQuery(function(){
	
	
	<%if(nodeid == nodeidPl_CC || nodeid == nodeidPl_HF || nodeid == nodeidPl_ST){%>		
		var managestate = <%=managestate%>
		setCover(managestate);
	<%}%>
	
	//设置成不可编辑
		function setCover(field) {
			var temp = field;
			var htmlShadow = '<div id="shadow_' + temp + '"></div>';
			jQuery("#field" + temp).before(htmlShadow);
			jQuery("#shadow_" + temp).css("z-index",100);
			jQuery("#shadow_" + temp).css("height",jQuery("#field" + temp).parent().parent().css("height"));
			jQuery("#shadow_" + temp).css("width",jQuery("#field" + temp).parent().parent().css("width"));
			jQuery("#shadow_" + temp).css("top",jQuery("#field" + temp).parent().parent().offset().top);
			jQuery("#shadow_" + temp).css("left",jQuery("#field" + temp).parent().parent().offset().left);
			jQuery("#shadow_" + temp).css("position","absolute");
			jQuery("#shadow_" + temp).css("opacity",0.5);
			jQuery("#shadow_" + temp).css("background","#FFFFFF");
		}
})
</script>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<%
    int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
	int formid = Util.getIntValue(request.getParameter("formid"));//表单id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
	
	//主表
	String fieldEeramt = BillUtil.getLabelId(formid, 0, "eeramt");// 报销金额
	String fieldDays = BillUtil.getLabelId(formid, 0, "days");// 报销相隔天数
	 
%>
<script type="text/javascript">
	var fieldDays = <%=fieldDays%>
     		
	 //控制报销金额小于1W不可以提交
	<%if(nodeid == 5241){%>
	
	checkCustomize = function() {
		var flag= true;
		var days_val = '';
		days_val = $("#field" + fieldDays).val();
		if(days_val>=61)
			{
			flag = false;
			if (flag == false)
			{
			alert("招待期间不得超过2个月");
			}
			}
		return flag;
	}
	<%}%>

</script> 
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<%
    RecordSet rs = new RecordSet();
    String sql = "";
    
    int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
	int formid = Util.getIntValue(request.getParameter("formid"));//表单id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
	
	//主表
	String fieldReqDop = BillUtil.getLabelId(formid, 0, "sqr");// 申请人
	String fieldReqManager = BillUtil.getLabelId(formid, 0, "ReqManager");// 部门长
	
	 
%>
<script type="text/javascript">
	var fieldReqDop = <%=fieldReqDop%>
	var fieldReqManager = <%=fieldReqManager%>
     		
	 
	<%if(nodeid == 2503){%>
	 
	checkCustomize = function() {
		var flag= true;
		var ReqDop = '';
		var ReqManager = '';
		ReqDop = $("#field" + fieldReqDop).val();
		ReqManager = $("#field" + fieldReqManager).val();
		
		jQuery.ajax({
			url: "/interface/additional/service_support/demandflow/LeaderNoReqOfDemandFlowAjax.jsp",
			data: {type: 1 ,ReqDop: ReqDop},
			cache: true,
			type: "post",
			dataType: "text",
			async: false,
			success: function (result) {
				result = jQuery.trim(result);
				if(result == "0")
				{
					flag = false;		
				}

				if (flag == false)
				{
					alert("申请人不是关键用户，请让部门关键用户提交需求申请单!");
				}else
				{
					if(ReqManager==ReqDop)
					{
						flag = false;
						if (flag == false)
						{
							alert("需求部门领导不可以与申请人为同一个人，请正确填写需求部门领导!");
						}
					}else
					{
						jQuery.ajax({
							url: "/interface/additional/service_support/demandflow/LeaderNoReqOfDemandFlowAjax.jsp",
							data: {type: 2 ,ReqManager: ReqManager},
							cache: true,
							type: "post",
							dataType: "text",
							async: false,  
							success: function (result) {
								result = jQuery.trim(result);
								if(parseInt(result)<40)
								flag = false;
								if (flag == false)
								{
									alert("你选择的需求部门领导级别必须为课级及课级以上，请重新选择!");
								} 	
							}
						});  
					}
				}
			}
		});
		return flag;
	}
	<%}%>

</script> 
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page
	import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init.jsp"%>

<jsp:useBean id="mysmt" class="weaver.conn.RecordSet" />
<jsp:useBean id="bs" class="weaver.general.BaseBean"></jsp:useBean>
<%
	int requestid = Util.getIntValue(request.getParameter("requestid"),0);//请求id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"), 0);//流程id
	int formid = Util.getIntValue(request.getParameter("formid"), 0);//表单id
	int isbill = Util.getIntValue(request.getParameter("isbill"), 0);//表单类型，1单据，0表单
	int nodeid = Util.getIntValue(request.getParameter("nodeid"), 0);//流程的节点id
	int userId = user.getUID();
%>
<script>
    jQuery(function () {
        //第一个节点
		<%if(nodeid == 250){%>
			jQuery("#field6762").parent().find(".Browser").hide();
			checkCustomize = function () {
				jQuery.ajax({
		            url: "/interface/ff/cskfajax.jsp",
		            data: { fzxx: jQuery("#field6442").val(), khdm: jQuery("#field6441").val() },
		            cache: false,
		            async: false,
		            type: "post",
		            dataType: "text",
		            success: function (result) {
		            	result = jQuery.trim(result);
		                jQuery("#field6762").val(result);//分配开发课长
		            }
		        });
	            return true;
	        }
		<%}%>
	});
</script>
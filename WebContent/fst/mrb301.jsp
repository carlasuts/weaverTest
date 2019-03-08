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
%>
<script>
    jQuery(function () {
        //第一个节点
		<%if(nodeid == 301){%>
	        checkCustomize = function () {
	        	var f1 = jQuery("#field6411").val();
	        	var f2 = jQuery("#field6412").val();
	        	if(f1 == "" && f2 == ""){
	        		alert("产品处置和材料处置必须填写一个");
	        		return false;
	        	}
	        	else{
	        		return true;
	        	}
	        }
		<%}%>
	});
</script>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="mysmt" class="weaver.conn.RecordSet"/>
<jsp:useBean id="bs" class="weaver.general.BaseBean"></jsp:useBean>
<%
    int requestid = Util.getIntValue(request.getParameter("requestid"),0);//请求id
    int workflowid = Util.getIntValue(request.getParameter("workflowid"),0);//流程id
    int formid = Util.getIntValue(request.getParameter("formid"),0);//表单id
    int isbill = Util.getIntValue(request.getParameter("isbill"),0);//表单类型，1单据，0表单
    int nodeid = Util.getIntValue(request.getParameter("nodeid"),0);//流程的节点id
%>
<script>
    jQuery(function () {
        f_getreport();
        jQuery("#field6138").bind("propertychange", function () { f_setkw() });
    });
    function f_getreport() {
        jQuery("#ifr").attr("src", "/interface/ff/fst361report.jsp?edpno=" + jQuery("#field5988").val());
    }
    function f_setkw(){
    	var tezx = jQuery("#field6138").val();
    	if(tezx == 0 || tezx == 2){
    		jQuery("#fieldxxxx").val(0);
    	}
    	else{
    		jQuery("#fieldxxxx").val(1);
    	}
    }
</script>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
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
        <%if(nodeid == 258){%>
	        jQuery("#field5981").blur(function() {f_get();});
	        jQuery("#field5982").blur(function() {f_get();});
	        jQuery("#field5986").blur(function() {f_get();});
	        jQuery("#field5990").blur(function() {f_get();});
        <%}%>
    });
    function f_getreport() {
        jQuery("#ifr").attr("src", "/interface/ff/fst83report.jsp?lotid=" + jQuery("#field5983").val());
    }
    function f_get(){
    	var khm = jQuery("#field5981").val();
        var xh = jQuery("#field5982").val();
        var tester = jQuery("#field5986").val();
        var pkid = jQuery("#field5990").val();
        if(khm != "" && xh != "" && tester != "" && pkid != ""){
        	jQuery.ajax({
                url: "/interface/ff/llycajax.jsp",
                data: { khm: khm, xh: xh, tester : tester, pkid :pkid },
                cache: false,
                async: false,
                type: "post",
                dataType: "text",
                success: function (result) {
                	result = jQuery.trim(result);
                	var tmp = result.split("|");
                    jQuery("#field6748").val(tmp[0]);//
                    jQuery("#field6748span").text(tmp[1]);//
                }
            });	
        }
    }
</script>
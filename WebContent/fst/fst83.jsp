<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="mysmt" class="weaver.conn.RecordSet"/>
<jsp:useBean id="bs" class="weaver.general.BaseBean"></jsp:useBean>
<%
    int requestid = Util.getIntValue(request.getParameter("requestid"),0);//����id
    int workflowid = Util.getIntValue(request.getParameter("workflowid"),0);//����id
    int formid = Util.getIntValue(request.getParameter("formid"),0);//��id
    int isbill = Util.getIntValue(request.getParameter("isbill"),0);//�����ͣ�1���ݣ�0��
    int nodeid = Util.getIntValue(request.getParameter("nodeid"),0);//���̵Ľڵ�id
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
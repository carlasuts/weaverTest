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
        <%if(nodeid == 217){%>
	        checkCustomize = function () {
				f_get();
	            return true;
            }
        <%}%>
    });
    function f_get(){
    	var khm = jQuery("#field7241").val();
    	var pkid = jQuery("#field7242").val();
        var xh = jQuery("#field5961").val();
       	jQuery.ajax({
               url: "/interface/ff/gxnajax.jsp",
               data: { khm: khm, xh: xh, pkid :pkid },
               cache: false,
               async: false,
               type: "post",
               dataType: "text",
               success: function (result) {
               	result = jQuery.trim(result);
               	var tmp = result.split("|");
                   jQuery("#field7245").val(tmp[0]);//
                   jQuery("#field7245span").text(tmp[1]);//
               }
           });	
    }
</script>
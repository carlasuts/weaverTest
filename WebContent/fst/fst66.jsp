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
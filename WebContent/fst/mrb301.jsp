<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page
	import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init.jsp"%>

<jsp:useBean id="mysmt" class="weaver.conn.RecordSet" />
<jsp:useBean id="bs" class="weaver.general.BaseBean"></jsp:useBean>
<%
	int requestid = Util.getIntValue(request.getParameter("requestid"),0);//����id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"), 0);//����id
	int formid = Util.getIntValue(request.getParameter("formid"), 0);//��id
	int isbill = Util.getIntValue(request.getParameter("isbill"), 0);//�����ͣ�1���ݣ�0��
	int nodeid = Util.getIntValue(request.getParameter("nodeid"), 0);//���̵Ľڵ�id
%>
<script>
    jQuery(function () {
        //��һ���ڵ�
		<%if(nodeid == 301){%>
	        checkCustomize = function () {
	        	var f1 = jQuery("#field6411").val();
	        	var f2 = jQuery("#field6412").val();
	        	if(f1 == "" && f2 == ""){
	        		alert("��Ʒ���úͲ��ϴ��ñ�����дһ��");
	        		return false;
	        	}
	        	else{
	        		return true;
	        	}
	        }
		<%}%>
	});
</script>
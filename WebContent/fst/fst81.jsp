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
	int userId = user.getUID();
%>
<script>
    jQuery(function () {
		checkCustomize = function () {
			var hrmids = "";
			var x = "";
			var tmp = jQuery("#field6444").val().split(",");
			for(i = 0; i < tmp.length; i++){
				if(tmp[i] != 126 && tmp[i] != 49){
					jQuery.ajax({
			            url: "/interface/ff/fst81ajax.jsp",
			            data: { deptid: tmp[i] },
			            cache: false,
			            async: false,
			            type: "post",
			            dataType: "text",
			            success: function (result) {
			            	result = jQuery.trim(result);
			            	if(result != ""){
			            		if(x == "1") hrmids += ",";
				            	hrmids += result;
				            	x = "1";
			            	}
			            }
			        });	
				}
			}
			jQuery("#field6686").val(hrmids);
            return true;
        }
		//��һ���ڵ�
		<%if(nodeid == 242){%>
		<%}%>
	});
</script>
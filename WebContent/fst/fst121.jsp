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
        //�ڰ˸��ڵ�
		<%if(nodeid == 411){%>
		    checkCustomize = function () {
				var hrmid = "";
				jQuery("input[id*='field6647']").each(function (index) {
					var tmp = this.id.split("_");
					hrmid += jQuery("#field6647_" +  + tmp[1]).val() + ",";
				});
				hrmid = hrmid.substring(0,hrmid.length - 1);
		        jQuery("#field6681").val(hrmid);
	                return true;
            }
		<%}else if(nodeid == 414){%>
			//�������ڵ�
			var uid = <%=userId%>;
			jQuery("input[id*='field6647']").each(function (index){
				var id = this.id.split("_")[1];
				var hrmid = jQuery(this).val();
				if(hrmid != uid){
					jQuery("#field6656_" + id).attr("disabled", true);//---------------------------------
					jQuery("#field6665_" + id).attr("readOnly",true);
				}
			});
		    checkCustomize = function () {
		    	var bok = true;
		    	var uid = <%=userId%>;
				jQuery("input[id*='field6647']").each(function (index){
					var id = this.id.split("_")[1];
					var hrmid = jQuery(this).val();
					if(hrmid == uid){
						if(jQuery("#field6656_" + id).val() == ""){
							alert("��֤�������Ϊ��");
							bok = false;
						}
						if(jQuery("#field6665_" + id).val() == ""){
							alert("��������ݲ���Ϊ��");
							bok = false;
						}
						if(!bok){
							return false;
						}
					}
				});
				return bok;
	        }
		<%}%>
	});
</script>
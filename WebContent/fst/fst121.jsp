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
        //第八个节点
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
			//第三个节点
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
							alert("验证结果不能为空");
							bok = false;
						}
						if(jQuery("#field6665_" + id).val() == ""){
							alert("报告或数据不能为空");
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
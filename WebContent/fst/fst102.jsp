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
        //�ڶ����ڵ�
		<%if(nodeid == 312){%>
		    checkCustomize = function () {
				var hrmid = "";
				jQuery("input[id*='field6189']").each(function (index) {
					var tmp = this.id.split("_");
					hrmid += jQuery("#field6189_" +  + tmp[1]).val() + ",";
				});
				hrmid = hrmid.substring(0,hrmid.length - 1);
		        jQuery("#field6476").val(hrmid);
	                return true;
            }
		<%}else if(nodeid == 313){%>
			//�������ڵ�
			var uid = <%=userId%>;
			jQuery("input[id*='field6189']").each(function (index){
				var id = this.id.split("_")[1];
				var hrmid = jQuery(this).val();
				if(hrmid != uid){
					jQuery("#field6471_" + id).attr("readOnly",true);
					jQuery("#field6472_" + id).attr("readOnly",true);
					jQuery("#field6192_" + id).parent().find(".Browser").hide();
				}
			});
		    checkCustomize = function () {
		    	var bok = true;
		    	var uid = <%=userId%>;
				jQuery("input[id*='field6189']").each(function (index){
					var id = this.id.split("_")[1];
					var hrmid = jQuery(this).val();
					if(hrmid == uid){
						if(jQuery("#field6471_" + id).val() == ""){
							alert("����ԭ����Ϊ��");
							bok = false;
						}
						if(jQuery("#field6472_" + id).val() == ""){
							alert("������ʩ�ƻ�����Ϊ��");
							bok = false;
						}
						if(jQuery("#field6192_" + id).val() == ""){
							alert("�ƻ�����ղ���Ϊ��");
							bok = false;
						}
						if(!bok){
							return false;
						}
					}
				});
				
				if(bok){
					var res = "";
					var hrmid = jQuery("#field6476").val();
					var tmp = hrmid.split(',');
					for(i = 0; i < tmp.length; i++){
						jQuery.ajax({
				            url: "/interface/ff/fst102ajax.jsp",
				            data: { id : tmp[i] },
				            cache: false,
				            async: false,
				            type: "post",
				            dataType: "text",
				            success: function (result) {
								if(jQuery.trim(result) != ""){
					            	res += jQuery.trim(result) + ",";
								}
				            }
				        });
					}
					res = res.substring(0,res.length - 1);
					jQuery("#field6477").val(res);
				}
				return bok;
	        }
		<%}%>
	});
</script>
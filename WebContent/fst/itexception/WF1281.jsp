<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
User user = HrmUserVarify.getUser (request , response) ;
if(user == null)  return ;
int requestid = Util.getIntValue(request.getParameter("requestid"));//请求id
int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
int formid = Util.getIntValue(request.getParameter("formid"));//表单id
int isbill = Util.getIntValue(request.getParameter("isbill"));//表单类型，1单据，0表单
int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
String type = Util.null2String(request.getParameter("type"));//
int resourceId = user.getUID();
%>
<script type="text/javascript">
jQuery(function () {
	
	//创建节点根据 问题分类 问题描述 带出IT经办人
	<%if(nodeid == 2622){%>
		 $("#field13121").bindPropertyChange(function(e){
			 var wtfl = e.value;
			 $("#field13122").bindPropertyChange(function(e){
				 var wtms = e.value;
				 var jbr = '';
				 jQuery.ajax({
						url: "/interface/itexception/WF12811ajaxaction.jsp",
						data: {type: 1, wtfl: wtfl, wtms: wtms},
						cache: false,
						type: "post",
						dataType: "json",
						success: function (result) {
							for(var i=0;i<result.length;i++){
								jbr = jbr + result[i].LASTNAME+ ",";
								/*
								$("#field13083").val(result[i].LASTNAME);
								$("#field13083span").html('<span class="e8_showNameClass"><a>' + result[i].LASTNAME + '</a>&nbsp;<span class="e8_delClass" id="'+result[i].LASTNAME+'">&nbsp;&nbsp;</span></span>');
								*/
							}
							$("#field13083").val(jbr);
							if(wtms == "2"){
								$("#field13082").val(result[0].custid);
								$("#field13082span").html('<span class="e8_showNameClass"><a>' + result[0].custid + '</a>&nbsp;<span class="e8_delClass" id="'+result[0].custid+'">&nbsp;&nbsp;</span></span>');
							}
							if(wtms == "1"){
								$("#field13082").val("");
								 var span = document.getElementById("field13082span");
							     span.removeChild(span.firstChild);
							}
						}
					});
			 });
		 }); 
	<%}%>
});
</script> 
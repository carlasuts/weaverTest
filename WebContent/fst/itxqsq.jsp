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
<%if(nodeid == 2521){%>
checkCustomize = function() {
			var flag ;
			
				if($("#field11653").val()=="" && $("#field11654").val()=="" && $("#field11655").val()==""
				&& $("#field11656").val()=="" && $("#field11657").val()=="" && $("#field11677").val()==""
				&& $("#field11678").val()=="" && $("#field11679").val()=="" && $("#field11680").val()==""
				&& $("#field11681").val()=="" && $("#field11682").val()=="" && $("#field11658").val()==""){
					flag = false;
				}else{
					flag = true;
				}
				if (flag == false){
				alert("请填写实现后情况");
				}
			// var message = "请填写实现后情况";
			return flag;
			
/*	$("button[class=e8_btn_top_first]").click(function(){
				if(flag==false){
					alert("请填写实现后情况");
				}
			}
			*/
		}
<%}%>
</script>
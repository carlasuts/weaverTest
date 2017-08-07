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

	<%if(nodeid == 1767){%>
	//非计划类物资采购申请单总价 
	$("button[name=addbutton0]").click(function(){
		$("input[id^=field12865_]").bindPropertyChange(function(e){
			dozj();
		});
		$("input[id^=field9515_]").bindPropertyChange(function(e){
			dozj();
		});
	});
	
	$("input[id^=field12865_]").bindPropertyChange(function(e){
		dozj();
	});
	$("input[id^=field9515_]").bindPropertyChange(function(e){
		dozj();
	});
	
	$("button[name=delbutton0]").click(function(){
		dozj();
	});
	<%}%>
	
});

//总价
function zj(){
	this.sl = '';//数量
	this.ygje = '';//预估金额
	this.zj = '';//总价
}

function dozj(){
	var sum = 0 ;
	var trarray = new Array();
	$("input[id^=field9515_]").each(function(index) {
		var indexrow = new zj();
		var mxid = this.id.split("_")[1];
		if($("#field12865_"+mxid).val() != ''){
			indexrow.sl = parseInt($("#field9515_"+mxid).val());
			indexrow.ygje = parseFloat($("#field12865_"+mxid).val());
			indexrow.zj = indexrow.sl * indexrow.ygje;
			trarray[index] = indexrow ;
		}
	});
	for(var i=0;i<trarray.length;i++){
		sum = sum + trarray[i].zj;
	}
	sum = Math.round( sum * 100 ) / 100.0;
	$("#field12921").val(sum);
	document.getElementById("field12921").readOnly=true;
}

</script> 
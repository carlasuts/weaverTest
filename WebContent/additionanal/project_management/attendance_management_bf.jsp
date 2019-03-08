<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<%
    int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
	int formid = Util.getIntValue(request.getParameter("formid"));//表单id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
	
	//主表
	String lb = BillUtil.getLabelId(formid, 0, "lb");//类别
	String xst = BillUtil.getLabelId(formid, 0, "xst");//天数
	String ksrq = BillUtil.getLabelId(formid, 0, "ksrq");//开始日期
	String kssj = BillUtil.getLabelId(formid, 0, "kssj");//开始时间
	String jsrq = BillUtil.getLabelId(formid, 0, "jsrq");//结束日期
	String jssj = BillUtil.getLabelId(formid, 0, "jssj");//结束时间
%>
<script type="text/javascript">
	var lb = <%=lb%>
	var xst = <%=xst%>
	var ksrq = <%=ksrq%>
	var kssj = <%=kssj%>
	var jsrq = <%=jsrq%>
	var jssj = <%=jssj%>
jQuery(function () {
		$("#field"+lb).bindPropertyChange(function(){
			var options1 = $("#field"+lb+ " option:selected");
			var sqlx = options1.val();
			var stime = $("#field" + kssj).val().replace(":","");
			if(sqlx == "2"){
				if(0830>stime>= 0000||2400>stime>1700){
					var startTime = $("#field" + ksrq).val() + " " + $("#field" + kssj).val() ;
					var endTime = $("#field" + jsrq).val() + " " + $("#field" + jssj).val() ;
					docountTime(startTime,endTime);
				}
			}
		});

		$("#field"+ksrq).bindPropertyChange(function(){
			var options1 = $("#field"+lb+ " option:selected");
			var sqlx = options1.val();
			var stime = $("#field" + kssj).val().replace(":","");
			if(sqlx == "2"&&stime>=0000&&stime<0830&&stime>1700&&stime<2400){
				var startTime = $("#field" + ksrq).val() + " " + $("#field" + kssj).val() ;
				var endTime = $("#field" + jsrq).val() + " " + $("#field" + jssj).val() ;
				docountTime(startTime,endTime);
			}
		});

		$("#field"+kssj).bindPropertyChange(function(){
			var options1 = $("#field"+lb+ " option:selected");
			var sqlx = options1.val();
			var stime = $("#field" + kssj).val().replace(":","");
			if(sqlx == "2"&&stime>=0000&&stime<0830&&stime>1700&&stime<2400){
				var startTime = $("#field" + ksrq).val() + " " + $("#field" + kssj).val() ;
				var endTime = $("#field" + jsrq).val() + " " + $("#field" + jssj).val() ;
				docountTime(startTime,endTime);
			}
		});

		$("#field"+jsrq).bindPropertyChange(function(){
			var options1 = $("#field"+lb+ " option:selected");
			var sqlx = options1.val();
			var stime = $("#field" + kssj).val().replace(":","");
			if(sqlx == "2"&&stime>=0000&&stime<0830&&stime>1700&&stime<2400){
				var startTime = $("#field" + ksrq).val() + " " + $("#field" + kssj).val() ;
				var endTime = $("#field" + jsrq).val() + " " + $("#field" + jssj).val() ;
				docountTime(startTime,endTime);
			}
		});

		$("#field"+jssj).bindPropertyChange(function(){
			var options1 = $("#field"+lb+ " option:selected");
			var sqlx = options1.val();
			var stime = $("#field" + kssj).val().replace(":","");
			if(sqlx == "2"&&stime>=0000&&stime<0830&&stime>1700&&stime<2400){
				var startTime = $("#field" + ksrq).val() + " " + $("#field" + kssj).val() ;
				var endTime = $("#field" + jsrq).val() + " " + $("#field" + jssj).val() ;
				docountTime(startTime,endTime);
			}
		});

});

	//加班 
	function docountTime(begin,end){
		var begin_date = new Date(begin);
		var end_date = new Date(end)
		var date3 = end_date.getTime()-begin_date.getTime();//时间差的毫秒数
		var days = Math.round(parseFloat(date3/(8*3600*1000))*100)/100;
		//getFieldDateAjax17501(){}
		$("#field" + xst).val(days);
		document.getElementById("field"+ xst).readOnly=true;
	}
	//工作日
	function getWeekday(first, last){
		first = first.getTime();
		last = last.getTime();

		var count = 0;
		while(first <= last){
			var d = new Date(first);
			console.log(d);
			if(d.getDay() >= 1 && d.getDay() <= 5){
				count++;
			}

			first += 8*3600*1000;
		}
		return count;
	}
</script> 
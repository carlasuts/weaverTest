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
	String xs = BillUtil.getLabelId(formid, 0, "xs");//结束时间
	String ksrq = BillUtil.getLabelId(formid, 0, "ksrq");//开始日期
	String kssj = BillUtil.getLabelId(formid, 0, "kssj");//开始时间
	String jsrq = BillUtil.getLabelId(formid, 0, "jsrq");//结束日期
	String jssj = BillUtil.getLabelId(formid, 0, "jssj");//结束时间
%>
<script type="text/javascript">
	var lb = <%=lb%>
	var xst = <%=xst%>
	var xs = <%=xs%>
	var ksrq = <%=ksrq%>
	var kssj = <%=kssj%>
	var jsrq = <%=jsrq%>
	var jssj = <%=jssj%>
jQuery(function () {
	$("#field"+lb).bindPropertyChange(function(){
		var options1 = $("#field"+lb+ " option:selected");
		var sqlx = options1.val();
		if(sqlx == "2"){   //$("#field" + xst).val() == "0.0"
			var str = "-1";
			doFieldDate17501(str,sqlx);
		}else{
			$("#field" + xs).val('');
			doFieldDate17501(-1,0);
		}
	});

	$("#field"+ksrq).bindPropertyChange(function(){
		var options1 = $("#field"+lb+ " option:selected");
		var sqlx = options1.val();
		if(sqlx == "2"){
			var str = "-1";
			doFieldDate17501(str,sqlx);
		}else{
			$("#field" + xs).val('');
			doFieldDate17501(-1,0);
		}
	});
	$("#field"+kssj).bindPropertyChange(function(){
		var options1 = $("#field"+lb+ " option:selected");
		var sqlx = options1.val();
		if(sqlx == "2"){
			var str = "-1";
			doFieldDate17501(str,sqlx);
		}else{
			$("#field" + xs).val('');
			doFieldDate17501(-1,0);
		}
	});
	$("#field"+jsrq).bindPropertyChange(function(){
		var options1 = $("#field"+lb+ " option:selected");
		var sqlx = options1.val();
		if(sqlx == "2"){
			var str = "-1";
			doFieldDate17501(str,sqlx);
		}else{
			$("#field" + xs).val('');
			doFieldDate17501(-1,0);
		}
	});
	$("#field"+jssj).bindPropertyChange(function(){
		var options1 = $("#field"+lb+ " option:selected");
		var sqlx = options1.val();
		if(sqlx == "2"){
			var str = "-1";
			doFieldDate17501(str,sqlx);
		}else{
			$("#field" + xs).val('');
			doFieldDate17501(-1,0);
		}
	});

});

	function docountTime(begin,end){
		//初始化
		$("#field" + xs).val('');
		$("#field" + xst).val('');

		var hm = 0
		var days = 0
		var worktime = 0 
		if(Number($("#field" + kssj).val().replace(":",""))<=1230&&Number($("#field" + jssj).val().replace(":",""))>=1300){
			hm = 30*60*1000 ;//12:00-12:30
		}
		var begin_date = new Date(begin);
		var end_date = new Date(end);

		//不隔天
		var date3 = end_date.getTime()-begin_date.getTime() - hm ;//时间差的毫秒数
		//结束时间-00:00
		var nextdate = end_date.getTime()-(new Date($("#field" + jsrq).val() + " 00:00").getTime());
		//非工作日17:00之后加班
		var nowdate = end_date.getTime()-(new Date($("#field" + jsrq).val() + " 17:00").getTime()) ;
		//8:30-17:00毫秒数
		var t1 = new Date($("#field" + jsrq).val() + " 17:00").getTime() - new Date($("#field" + jsrq).val() + " 08:30").getTime()
		//end_date在8:30之前
		var t2 = end_date.getTime()-(new Date($("#field" + jsrq).val() + " 08:00").getTime());
		//2小时毫秒数
		var twoHour = 120*60*1000;

		//开始日期结束日期都为工作日且为同一天
		if(begin_date.getDay()%6 !=0 && end_date.getDay()%6 !=0 && Number($("#field" + ksrq).val().replace("-","").replace("-","")) == Number($("#field" + jsrq).val().replace("-","").replace("-",""))){
			//17:00-24:00且时差大于2h
			if(Number($("#field" + kssj).val().replace(":",""))>=1700 && Number($("#field" + jssj).val().replace(":",""))<2400 && Number(date3)>=Number(twoHour)){
				days = Math.round(parseFloat(date3/(3600*1000))*100)/100;
				$("#field" + xs).val(days);
			}
		}
		//开始日期结束日期都为工作日跨天
		if(begin_date.getDay()%6 !=0 && end_date.getDay()%6 !=0 && Number($("#field" + jsrq).val().replace("-","").replace("-","")) > Number($("#field" + ksrq).val().replace("-","").replace("-",""))){
			//加班至第二天且未满8h
			if(Number($("#field" + jssj).val().replace(":",""))< 0800){
				$("#field" + xs).val(Math.round(parseFloat(nextdate/(3600*1000)+ 7)*100)/100);
			}
			//加班至第二天且超8h
			if(Number($("#field" + jssj).val().replace(":",""))>= 0800){
				//结束日期在第二天8:00-8:30之间
				if(Number($("#field" + jssj).val().replace(":",""))<= 0830){
					$("#field" + xs).val(Math.round(parseFloat(t2/(3600*1000)+ 15)*100)/100);	//-----------------
				}
				//结束日期在8:30-17:00之间
				if(0830<=Number($("#field" + jssj).val().replace(":",""))){		
					$("#field" + xs).val('15.50');	
				}
				//结束日期在17:00之后
				if(Number($("#field" + jssj).val().replace(":",""))>= 1700){
					$("#field" + xs).val(Math.round(parseFloat((nextdate-t1)/(3600*1000)+ 7)*100)/100);
				}
			}
		}
		//开始日期为工作日结束日期为非工作日 
		if(begin_date.getDay()%6 !=0 && end_date.getDay()%6 ==0){
			$("#field" + xs).val('7');	
			$("#field" + xst).val(Math.round(parseFloat(nextdate/(8*3600*1000))*100)/100);
		}
		//开始日期结束日期都为非工作日且为同一天
		if(begin_date.getDay()%6 ==0 && end_date.getDay()%6 ==0){
			//8:30-19:00之间
			if(Number($("#field" + kssj).val().replace(":",""))>=0830 && Number($("#field" + jssj).val().replace(":",""))<1900  && Number($("#field" + ksrq).val().replace("-","").replace("-","")) == Number($("#field" + jsrq).val().replace("-","").replace("-","")) ){
				if(Number($("#field" + jssj).val().replace(":",""))<=1700){
					days = Math.round(parseFloat(date3/(8*3600*1000))*100)/100;
					$("#field" + xst).val(days);
				}else{
					$("#field" + xst).val('1');
				}
			}
			//19:00-24:00之间
			if(Number($("#field" + jssj).val().replace(":",""))>=1900 && Number($("#field" + jssj).val().replace(":",""))<2400  && Number($("#field" + ksrq).val().replace("-","").replace("-","")) == Number($("#field" + jsrq).val().replace("-","").replace("-","")) ){
				days = Math.round(parseFloat(nowdate/(8*3600*1000) + 1)*100)/100;
				$("#field" + xst).val(days);
			}
		}
		//开始日期结束日期都为非工作日且跨天
		if(begin_date.getDay()%6 ==0 && end_date.getDay()%6 ==0 && Number($("#field" + jsrq).val().replace("-","").replace("-","")) > Number($("#field" + ksrq).val().replace("-","").replace("-",""))){
				days = Math.round(parseFloat(nextdate/(8*3600*1000) + 0.87)*100)/100;
				$("#field" + xst).val(days);
		}
		//开始日期为非工作日结束日期为工作日
		if(begin_date.getDay()%6 ==0 && end_date.getDay()%6 !=0 && Number($("#field" + jsrq).val().replace("-","").replace("-","")) > Number($("#field" + ksrq).val().replace("-","").replace("-",""))){
			$("#field" + xst).val('1.87');
			//加班至第二天且未满8h
			if(Number($("#field" + jssj).val().replace(":",""))< 800){
				$("#field" + xs).val(Math.round(parseFloat(nextdate/(3600*1000))*100)/100);
			}
			//加班至第二天且超8h
			if(Number($("#field" + jssj).val().replace(":",""))>= 800){
				//结束日期在第二天8:00-8:30之间
				if(Number($("#field" + jssj).val().replace(":",""))<= 830){
					$("#field" + xs).val(Math.round(parseFloat(t2/(3600*1000) + 8)*100)/100);	
				}
				//结束日期在8:30-17:00之间 
				if(830<=Number($("#field" + jssj).val().replace(":",""))){
					$("#field" + xs).val('8.50');	
				}
				//结束日期在17:00之后
				if(Number($("#field" + jssj).val().replace(":",""))>= 1700){
					$("#field" + xs).val(Math.round(parseFloat((nextdate-t1)/(3600*1000))*100)/100);
				}
			}
		} 

		//$("#field" + xs).val("");
		//document.getElementById("field"+ xst).readOnly=true;
	}


	//重写页面方法
	function doFieldDate17501(detailrow_t,sqlx){
		if(sqlx == "2"){
			var startTime = $("#field" + ksrq).val() + " " + $("#field" + kssj).val() ;
			var endTime = $("#field" + jsrq).val() + " " + $("#field" + jssj).val() ;
			docountTime(startTime,endTime);
		}
		if(sqlx == "0"){
			var isdetail_t = "";
			var para = "othertype=1&datecontent=";
			var datecontent_t = "$date$"+document.getElementById("field6835"+isdetail_t).value+"$date$"  +"$datetime$"+  "$time$"+document.getElementById("field7361"+isdetail_t).value+"$time$" + "-" + "$date$"+document.getElementById("field6834"+isdetail_t).value+"$date$"  +"$datetime$"+  "$time$"+document.getElementById("field7382"+isdetail_t).value+"$time$";
			datecontent_t = datecontent_t.replace(/\+/g, "%2B");
			datecontent_t = datecontent_t.replace(new RegExp("%","gm"), "%25");
			para = para + escape(datecontent_t);
			fieldAttrOperate.doFieldDateAjax(para, "17501", isdetail_t);
		}
	}

</script> 
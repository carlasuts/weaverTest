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
	var mxid=0;
	var requestid = <%=requestid%>
 jQuery(function () {
 //根据标准工艺路线带出明细信息
	 $("#field11781").bindPropertyChange(function(){
		 delRowmx(0);
		 var gx = '';
		 jQuery.ajax({
			 url: "/interface/fst/WF1186ajaxaction.jsp",
			 data: {type: 1, gylxdm: $("#field11781").val()},
			 cache: false,
			 type: "post",
			 dataType: "json",
			 success: function (result) {
				 var checkboxs = jQuery("input[name='check_node_1']");
				 jQuery("input[id*='field11487_']").each(function(index) {
					 var tmp3 = this.id.split("_");
					 mxid = tmp3[1];
					 checkboxs.eq(index).attr("checked",true);
				 });
				 if(checkboxs.length!=0){
					 mxid++;
				 }

				 if(checkboxs.length!=0){
					 delRowmx(1);
				 }

				for(var i=0;i<result.length;i++){
				 	addRow1(1);
					
					if(result[i].oper_fk == "0010"){
						result[i].oper_desc = "领芯片";
					}
					
					$("#field11487_"+mxid).val(result[i].item_no);
					$("#field11822_"+mxid).val(result[i].oper_fk);
					$("#field11822_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + result[i].oper_fk + '</a>&nbsp;<span class="e8_delClass" id="'+result[i].oper_fk+'">&nbsp;&nbsp;</span></span>');
					$("#field11489_"+mxid).val(result[i].oper_desc);
					
					//带出信息不可编辑
					document.getElementById("field11487_"+mxid).readOnly=true;
					document.getElementById("field11822_"+mxid).readOnly=true;
					document.getElementById("field11822_"+mxid+"_browserbtn").disabled=true;
					document.getElementById("field11489_"+mxid).readOnly=true;

					//根据工序封装外形带出设备组
					//主流程带出设备组 A1 2353
					<%if(nodeid == 2353){%>
						var fzwx = $("#field11521").val();
						var khh =  $("#field11394").val();
						gx = result[i].oper_fk;
						jQuery.ajax({
							 url: "/interface/fst/WF118607ajaxaction.jsp",
							 data: {type: 1, fzwx: fzwx,gx: gx,khh: khh},
							 cache: false,
							 type: "post",
							 dataType: "json",
							 async: false,
							 success: function (result) {
								 if(result[0].resg_id != ''){
									 $("#field12481_"+mxid).val(result[0].resg_id);
									 $("#field12481_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + result[0].resg_id + '</a>&nbsp;<span class="e8_delClass" id="'+result[0].resg_id+'">&nbsp;&nbsp;</span></span>');
									 document.getElementById("field12481_"+mxid).readOnly=true;
									 document.getElementById("field12481_"+mxid+"_browserbtn").disabled=true;	
								 }
							 }
						});
					<%}%> 
					//T1 带出工作中心 
					<%if(nodeid == 2453){%>
						var fzwx = $("#field11521").val();
						gx = result[i].oper_fk;
						gxms = gx;
						//带出工作中心 T1
						jQuery.ajax({
							url: "/interface/fst/WF118605ajaxaction.jsp",
							data: {type: 1, fzwx: fzwx,gxms: gxms},
							cache: false,
							type: "post",
							dataType: "json",
							async: false,
							success: function (result) {
								if(result[0].WORK_CENTER_FK != ""){
									$("#field12422_"+mxid).val(result[0].WORK_CENTER_FK);
									$("#field12422_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + result[0].WORK_CENTER_FK + '</a>&nbsp;<span class="e8_delClass" id="'+result[0].WORK_CENTER_FK+'">&nbsp;&nbsp;</span></span>');
									document.getElementById("field12422_"+mxid).readOnly=true;
									document.getElementById("field12422_"+mxid+"_browserbtn").disabled=true;	
								}
							}
						});
					<%}%>
					mxid++;
				}
			 }
		 });
	 });

 
//新增工艺路线明细
var checkid = 0;//选中行
var xzxmh = 0;//新增项目号
$("button[name=addbutton1]").click(function(){
	
	//在勾选位置新增
	$("[name='check_node_1']").each(function(index) {
		if($(this).attr("checked"))
		{	
			checkid = $(this).val();
			xzxmh = $("#field11487_"+checkid).val();
			$("input[id^=field11487_]").each(function(index) {
				if($(this).val()==''){
					$(this).val(xzxmh);
					dopx();
					jQuery("[name='check_node_1']").removeAttr("checked");
				}
			});
		}
	});
	
	//新增工序 
	$("input[id^=field11822_]").bindPropertyChange(function(e){
	var lineNumber = e.id.slice(11);
	var gx = jQuery("#field11822_" + lineNumber + "span > span > a").html();
		if(gx != ""){
			jQuery.ajax({
				url: "/interface/fst/WF118603ajaxaction.jsp",
				data: {type: 1, gylxdm: e.value},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					if(gx == "0010"){
						$("#field11489_"+lineNumber).val("领芯片");
						document.getElementById("field11489_"+lineNumber).readOnly=true;
						dopx();
					}else{
						$("#field11489_"+lineNumber).val(result[0].oper_desc);
						document.getElementById("field11489_"+lineNumber).readOnly=true;
					}
					
					//根据封装信息和工序带出设备组
					//主流程带出设备组
					<%if(nodeid == 2353){%>
						var fzwx = $("#field11521").val();
						var khh =  $("#field11394").val();
						jQuery.ajax({
							 url: "/interface/fst/WF118607ajaxaction.jsp",
							 data: {type: 1, fzwx: fzwx,gx: gx,khh: khh},
							 cache: false,
							 type: "post",
							 dataType: "json",
							 async: false,
							 success: function (result) {
								 if(result[0].resg_id != ''){
									 $("#field12481_"+lineNumber).val(result[0].resg_id);
									 $("#field12481_"+lineNumber+"span").html('<span class="e8_showNameClass"><a>' + result[0].resg_id + '</a>&nbsp;<span class="e8_delClass" id="'+result[0].resg_id+'">&nbsp;&nbsp;</span></span>');
									 document.getElementById("field12481_"+lineNumber).readOnly=true;
									 document.getElementById("field12481_"+lineNumber+"_browserbtn").disabled=true;	
								 }
							 }
						});
					<%}%>
					//T1 带出工作中心
					<%if(nodeid == 2453){%>
					var fzwx = $("#field11521").val();
					gxms = gx;
					//带出工作中心
					jQuery.ajax({
						url: "/interface/fst/WF118605ajaxaction.jsp",
						data: {type: 1, fzwx: fzwx,gxms: gxms},
						cache: false,
						type: "post",
						dataType: "json",
						async: false,
						success: function (result) {
							if(result[0].WORK_CENTER_FK != ""){
								$("#field12422_"+lineNumber).val(result[0].WORK_CENTER_FK);
								$("#field12422_"+lineNumber+"span").html('<span class="e8_showNameClass"><a>' + result[0].WORK_CENTER_FK + '</a>&nbsp;<span class="e8_delClass" id="'+result[0].WORK_CENTER_FK+'">&nbsp;&nbsp;</span></span>');
								document.getElementById("field12422_"+lineNumber).readOnly=true;
								document.getElementById("field12422_"+lineNumber+"_browserbtn").disabled=true;	
							}
						}
					});
					<%}%>
				}
			});
			dopx();
		}
	});
	 //项目号变化
	 $("input[id^=field11487_]").blur(function(e){
	 	dopx();
	 });
});
	

//删除 工艺路线明细后排序
$("button[name=delbutton1]").click(function(){
	dopx();
});

//芯片信息  根据芯片料号带出相关信息
//主数据申请A 2341  主数据申请T1 2453 
<%if(nodeid == 2341 ||nodeid == 2453){%>
$("input[id^=field11316_]").bindPropertyChange(function(e){
	jQuery.ajax({
		url: "/interface/fst/WF118602ajaxaction.jsp",
		data: {type: 1, gylxdm: e.value},
		cache: false,
		type: "post",
		dataType: "json",
		success: function (result) {
			var lineNumber = e.id.slice(11);
		 	$("#field11317_"+lineNumber).val(result[0].die_material_description);
		 	$("#field11318_"+lineNumber).val(result[0].chip_sizeX);
		 	$("#field11319_"+lineNumber).val(result[0].chip_sizeY);
		 	
		 	//去除带出信息必填标记
		 	var span = document.getElementById("field11318_"+lineNumber+"span");
			span.removeChild(span.firstChild);
			var span1 = document.getElementById("field11319_"+lineNumber+"span");
			span1.removeChild(span1.firstChild);
			var span2 = document.getElementById("field11317_"+lineNumber+"span");
			span2.removeChild(span2.firstChild);
		}
	});
});

var xpxxchecked = 1;//芯片信息是否主芯片
$("button[name=addbutton0]").click(function(){
	$("input[id^=field11316_]").bindPropertyChange(function(e){
		jQuery.ajax({
			url: "/interface/fst/WF118602ajaxaction.jsp",
			data: {type: 1, gylxdm: e.value},
			cache: false,
			type: "post",
			dataType: "json",
			success: function (result) {
				var lineNumber = e.id.slice(11);
			 	$("#field11317_"+lineNumber).val(result[0].die_material_description);
			 	$("#field11318_"+lineNumber).val(result[0].chip_sizeX);
			 	$("#field11319_"+lineNumber).val(result[0].chip_sizeY);
			 	
				//去除带出信息必填标记
			 	var span = document.getElementById("field11318_"+lineNumber+"span");
				span.removeChild(span.firstChild);
				var span1 = document.getElementById("field11319_"+lineNumber+"span");
				span1.removeChild(span1.firstChild);
				var span2 = document.getElementById("field11317_"+lineNumber+"span");
				span2.removeChild(span2.firstChild);
			}
		});
	});
	
	//新增芯片信息明细默认不是主芯片
	jQuery("#field11331_" + xpxxchecked ).removeAttr("checked");
	xpxxchecked++;
});
<%}%>

//工序项目号带出组件和材料名称
//A6合并工序项目号  field11561_
//A3-2  工序项目号 field13002_
//A3-1  工序项目号 field13001_
//A3-4  工序项目号 field13003_
$("input[id^=field11561_]").bindPropertyChange(function(e){
	jQuery.ajax({
		 url: "/interface/fst/WF118601ajaxaction.jsp",
		 data: {type: 1, gylxdm: e.value},
		 cache: false,
		 type: "post",
		 dataType: "json",
		 success: function (result) {
			 var lineNumber = e.id.slice(11);
			 $("#field11502_"+lineNumber).val(result[0].mat_id);
			 $("#field11505_"+lineNumber).val(result[0].mat_desc);
			 $("#field11506_"+lineNumber).val(result[0].qty_1);
			 $("#field11513_"+lineNumber).val(result[0].storage_location);
		 }
	});
});

$("input[id^=field13001_]").bindPropertyChange(function(e){
	jQuery.ajax({
		 url: "/interface/fst/WF118601ajaxaction.jsp",
		 data: {type: 1, gylxdm: e.value},
		 cache: false,
		 type: "post",
		 dataType: "json",
		 success: function (result) {
			 var lineNumber = e.id.slice(11);
			 $("#field11502_"+lineNumber).val(result[0].mat_id);
			 $("#field11505_"+lineNumber).val(result[0].mat_desc);
			 $("#field11506_"+lineNumber).val(result[0].qty_1);
			 $("#field11513_"+lineNumber).val(result[0].storage_location);
		 }
	});
});
$("input[id^=field13002_]").bindPropertyChange(function(e){
	jQuery.ajax({
		 url: "/interface/fst/WF118601ajaxaction.jsp",
		 data: {type: 1, gylxdm: e.value},
		 cache: false,
		 type: "post",
		 dataType: "json",
		 success: function (result) {
			 var lineNumber = e.id.slice(11);
			 $("#field11502_"+lineNumber).val(result[0].mat_id);
			 $("#field11505_"+lineNumber).val(result[0].mat_desc);
			 $("#field11506_"+lineNumber).val(result[0].qty_1);
			 $("#field11513_"+lineNumber).val(result[0].storage_location);
		 }
	});
});
$("input[id^=field13003_]").bindPropertyChange(function(e){
	jQuery.ajax({
		 url: "/interface/fst/WF118601ajaxaction.jsp",
		 data: {type: 1, gylxdm: e.value},
		 cache: false,
		 type: "post",
		 dataType: "json",
		 success: function (result) {
			 var lineNumber = e.id.slice(11);
			 $("#field11502_"+lineNumber).val(result[0].mat_id);
			 $("#field11505_"+lineNumber).val(result[0].mat_desc);
			 $("#field11506_"+lineNumber).val(result[0].qty_1);
			 $("#field11513_"+lineNumber).val(result[0].storage_location);
		 }
	});
});

//新增物料清单明细
var a = 0;
var array = [];
var array1 = [];
var array2 = [];
var array3 = [];
$("button[name=addbutton2]").click(function(){

	$("input[id^=field11561_]").bindPropertyChange(function(e){
		var xmh = e.value;
		var tmp = e.id.split("_")[1];
		var xmh1 = jQuery("#field11561_" + tmp + "span > span > a").html();
		var oper = '';
		//新增工序项目号
	    $("input[id^=field11487_]").each(function(index) {
			var mxid = this.id.split("_")[1];
			if($("#field11487_"+mxid).val() == xmh1){
				$("input[id^=field11504_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field11489_"+mxid).val());
					}
				});
				$("input[id^=field12821_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field11822_"+mxid).val());
					}
				});
			} 
		}); 
		
	    oper = $("#field12821_"+tmp).val();
		jQuery.ajax({
			 url: "/interface/fst/WF118601ajaxaction.jsp",
			 data: {type: 1, gylxdm: xmh},
			 cache: false,
			 type: "post",
			 dataType: "json",
			 success: function (result) {
				 var lineNumber = e.id.slice(11);
				 result[0].mat_desc = result[0].mat_desc.replace("%22", "\"");
				 $("#field11502_"+lineNumber).val(result[0].mat_id);
				 $("#field11505_"+lineNumber).val(result[0].mat_desc);
				 $("#field11506_"+lineNumber).val(result[0].qty_1);
				 $("#field11513_"+lineNumber).val(result[0].storage_location);
				 //相同物料类型替代组打Y
				 var matType = result[0].mat_type;
				 array.push(matType,oper);
				 for(var i = 0 ; i<array.length-2;i++){
					 if(matType == array[i] && oper == array[i+1]){
						 $("#field11509_"+lineNumber).val("Y");
					 }
				 }
				 //必须维护工序卡控
				 var count = 0;
				 jQuery.ajax({
					 url: "/interface/fst/WF118610ajaxaction.jsp",
					 data: {type: 1,gylxdm: $("#field11781").val()},
					 cache: false,
					 type: "post",
					 dataType: "json",
					 async: false,
					 success: function (result) {
						 count = result.length;
						 for(var i=0;i<result.length;i++){
							 if(oper == result[i].oper){
								 a++;
							 }
						 }
					 }
				 });
				 checkCustomize = function()
				 {
					 var flag = true;
					 if(a < count)
					 {
						 flag = false;
					 }
					 if (flag == false)
					 {
						 alert("请确认申请单信息填写完整");
					 }
					 return flag;
				 }
			 }
		});
		
		//将隐藏input的id改为页面显示值
		e.value = xmh1; 
	});	
	
	
	$("input[id^=field13001_]").bindPropertyChange(function(e){
		var xmh = e.value;
		var tmp = e.id.split("_")[1];
		var xmh1 = jQuery("#field13001_" + tmp + "span > span > a").html();
		var oper = '';
		
		//新增工序项目号
	    $("input[id^=field11487_]").each(function(index) {
			var mxid = this.id.split("_")[1];
			if($("#field11487_"+mxid).val() == xmh1){
				$("input[id^=field11504_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field11489_"+mxid).val());
					}
				});
				$("input[id^=field12821_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field11822_"+mxid).val());
					}
				});
			} 
		});
		
		oper = $("#field12821_"+tmp).val();
		jQuery.ajax({
			 url: "/interface/fst/WF118601ajaxaction.jsp",
			 data: {type: 1, gylxdm: xmh},
			 cache: false,
			 type: "post",
			 dataType: "json",
			 async: false,
			 success: function (result) {
				 var lineNumber = e.id.slice(11);
				 result[0].mat_desc = result[0].mat_desc.replace("%22", "\"");
				 $("#field11502_"+lineNumber).val(result[0].mat_id);
				 $("#field11505_"+lineNumber).val(result[0].mat_desc);
				 $("#field11506_"+lineNumber).val(result[0].qty_1);
				 $("#field11513_"+lineNumber).val(result[0].storage_location);
				 
				 //相同物料类型并且相同工序替代组打Y
				 var matType = result[0].mat_type;
				 array1.push(matType,oper);
				 for(var i = 0 ; i<array1.length-2;i++){
					 if(matType == array1[i] && oper == array1[i+1]){
						 $("#field11509_"+lineNumber).val("Y");
					 }
				 }
				 //必须维护工序卡控
				 var count = 0 ;
				 jQuery.ajax({
					 url: "/interface/fst/WF118609ajaxaction.jsp",
					 data: {type: 1, requestid: requestid},
					 cache: false,
					 type: "post",
					 dataType: "json",
					 async: false,
					 success: function (result) {
						 count = result.length;
						 for(var i=0;i<result.length;i++){
							 if(oper == result[i].oper){
								 a++;
							 }
						 }
					 }
				 });
				 checkCustomize = function()
				 {
					 var flag = true;
					 if(a < count)
					 {
						 flag = false;
					 }
					 if (flag == false)
					 {
						 alert("请确认申请单信息填写完整");
					 }
					 return flag;
				 }
		   }
		});

		//将隐藏input的id改为页面显示值
		e.value = xmh1; 
	});	
	
	
	$("input[id^=field13002_]").bindPropertyChange(function(e){
		var xmh = e.value;
		var tmp = e.id.split("_")[1];
		var xmh1 = jQuery("#field13002_" + tmp + "span > span > a").html();
		var oper = '';
		
		//新增工序项目号
	    $("input[id^=field11487_]").each(function(index) {
			var mxid = this.id.split("_")[1];
			if($("#field11487_"+mxid).val() == xmh1){
				$("input[id^=field11504_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field11489_"+mxid).val());
					}
				});
				$("input[id^=field12821_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field11822_"+mxid).val());
					}
				});
			} 
		}); 
		
	    oper = $("#field12821_"+tmp).val();
		jQuery.ajax({
			 url: "/interface/fst/WF118601ajaxaction.jsp",
			 data: {type: 1, gylxdm: xmh},
			 cache: false,
			 type: "post",
			 dataType: "json",
			 async: false,
			 success: function (result) {
				 var lineNumber = e.id.slice(11);
				 result[0].mat_desc = result[0].mat_desc.replace("%22", "\"");
				 $("#field11502_"+lineNumber).val(result[0].mat_id);
				 $("#field11505_"+lineNumber).val(result[0].mat_desc);
				 $("#field11506_"+lineNumber).val(result[0].qty_1);
				 $("#field11513_"+lineNumber).val(result[0].storage_location);
				 //相同物料类型替代组打Y
				 var matType = result[0].mat_type;
				 array2.push(matType,oper);
				 for(var i = 0 ; i<array2.length-2;i++){
					 if(matType == array2[i] && oper == array2[i+1]){
						 $("#field11509_"+lineNumber).val("Y");
					 }
				 }
				 //必须维护工序卡控
				 var count = 0;
				 jQuery.ajax({
					 url: "/interface/fst/WF118609ajaxaction.jsp",
					 data: {type: 1, requestid: requestid},
					 cache: false,
					 type: "post",
					 dataType: "json",
					 async: false,
					 success: function (result) {
						 count = result.length;
						 for(var i=0;i<result.length;i++){
							 if(oper == result[i].oper){
								 a++;
							 }
						 }
					 }
				 });
				 checkCustomize = function()
				 {
					 var flag = true;
					 if(a < count)
					 {
						 flag = false;
					 }
					 if (flag == false)
					 {
						 alert("请确认申请单信息填写完整");
					 }
					 return flag;
				 }
			 }
		});
		
		//将隐藏input的id改为页面显示值
		e.value = xmh1; 
	});	
	
	
	$("input[id^=field13003_]").bindPropertyChange(function(e){
		var xmh = e.value;
		var tmp = e.id.split("_")[1];
		var xmh1 = jQuery("#field13003_" + tmp + "span > span > a").html();
		var oper = '';
		
		//新增工序项目号
	    $("input[id^=field11487_]").each(function(index) {
			var mxid = this.id.split("_")[1];
			if($("#field11487_"+mxid).val() == xmh1){
				$("input[id^=field11504_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field11489_"+mxid).val());
					}
				});
				$("input[id^=field12821_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field11822_"+mxid).val());
					}
				});
			} 
		}); 
		
	    oper = $("#field12821_"+tmp).val();
		jQuery.ajax({
			 url: "/interface/fst/WF118601ajaxaction.jsp",
			 data: {type: 1, gylxdm: xmh},
			 cache: false,
			 type: "post",
			 dataType: "json",
			 success: function (result) {
				 var lineNumber = e.id.slice(11);
				 result[0].mat_desc = result[0].mat_desc.replace("%22", "\"");
				 $("#field11502_"+lineNumber).val(result[0].mat_id);
				 $("#field11505_"+lineNumber).val(result[0].mat_desc);
				 $("#field11506_"+lineNumber).val(result[0].qty_1);
				 $("#field11513_"+lineNumber).val(result[0].storage_location);
				 //相同物料类型替代组打Y
				 var matType = result[0].mat_type;
				 
				 array3.push(matType,oper);
				 for(var i = 0 ; i<array3.length-2;i++){
					 if(matType == array3[i] && oper == array3[i+1]){
						 $("#field11509_"+lineNumber).val("Y");
					 }
				 }
				 //必须维护工序卡控
				 var count = 0;
				 jQuery.ajax({
					 url: "/interface/fst/WF118609ajaxaction.jsp",
					 data: {type: 1, requestid: requestid},
					 cache: false,
					 type: "post",
					 dataType: "json",
					 async: false,
					 success: function (result) {
						 count = result.length;
						 for(var i=0;i<result.length;i++){
							 if(oper == result[i].oper){
								 a++;
							 }
						 }
					 }
				 });
				 checkCustomize = function()
				 {
					 var flag = true;
					 if(a < count)
					 {
						 flag = false;
					 }
					 if (flag == false)
					 {
						 alert("请确认申请单信息填写完整");
					 }
					 return flag;
			     }
			 }
		});

		//将隐藏input的id改为页面显示值
		e.value = xmh1; 
	});	
});
//A3-1 2342 A3-2 2343 A3-4 2345  必须维护工序卡控
<%if( nodeid == 2342 || nodeid == 2343 ||nodeid == 2345  ){%>
	checkCustomize = function() {
		var flag = true;
			jQuery("input[id^='field12821_']").each(function(index) {
			
				var tmp = this.id.split("_")[1];
				if($("#field12821_"+tmp).val()==""){
					flag = false;
				}
				
				var mxid = this.id.split("_")[1];
				oper = $("#field12821_"+mxid).val();
				var count = 0;
				jQuery.ajax({
					url: "/interface/fst/WF118609ajaxaction.jsp",
					data: {type: 1,requestid: requestid},
					cache: false,
					type: "post",
					dataType: "json",
					async: false,
					success: function (result) {
						count = result.length;
						for(var i=0;i<result.length;i++){
							if(oper == result[i].oper){
								a++;
							}
						}
					 }
				 });
				if(a < count)
				{
					flag = false;
				}
				
			});
			if (flag == false)
			{
				alert("请确认申请单信息填写完整");
			}
		return flag;
	}
<%}%>
//A3-1 2342 A3-2 2343 A3-4 2345  必须维护工序卡控
<%if( nodeid == 2342 || nodeid == 2343 ||nodeid == 2345  ){%>
/*
checkCustomize = function()
{
	$("input[id^=field12821_]").each(function(index) {
		var mxid = this.id.split("_")[1];
		oper = $("#field12821_"+mxid).val();
		var count = 0;
		jQuery.ajax({
			url: "/interface/fst/WF118609ajaxaction.jsp",
			data: {type: 1,gylxdm: $("#field11781").val()},
			cache: false,
			type: "post",
			dataType: "json",
			async: false,
			success: function (result) {
				count = result.length;
				for(var i=0;i<result.length;i++){
					if(oper == result[i].oper){
						a++;
					}
				}
			 }
		 });
		var flag = true;
		if(a < count)
		{
			flag = false;
		}
		if (flag == false)
		{
			alert("请确认申请单信息填写完整");
		}
		return flag;
	});
}
*/
<%}%>

//芯片信息带出物料清单信息
<%if(nodeid == 2345){%>
//A3-4 带出主芯片
	$("input[id^=field11316_]").each(function(index){
		var mxid = this.id.split("_")[1];
		var a = document.getElementById("field11331_"+mxid).value;
		var dw = document.getElementById("field11333_"+mxid).value;
		$("#div2button > button").length
		if(a == 1 && $("#div2button > button").length == 2){
			addRow2(2);
			var len = index;
			$("input[id^=field13003_]").each(function(index){
				var xzid = this.id.split("_")[1];
				if($("#field12821_" + xzid).val() == ""){
					var indexrow = new wlqdrow();
					indexrow.xplh = $("#field11316_" + mxid).val();
					indexrow.xppm = $("#field11317_" + mxid).val();
					indexrow.xpsl = $("#field11332_" + mxid).val();
					indexrow.dw = $("#field11333_" + mxid).val();
					
					$("#field11502_" + xzid).val(indexrow.xplh);
					$("#field11505_" + xzid).val(indexrow.xppm);
					$("#field11506_" + xzid).val(indexrow.xpsl*1000);
					$("#field13003_"+ xzid).val((len+1)*10);
					$("#field13003_"+ xzid + "span").html('<span class="e8_showNameClass"><a>' + (len+1)*10 + '</a>&nbsp;<span class="e8_delClass" id="'+ (len+1)*10 +'" onclick="del(event,this,1,false,{});" style="opacity: 1; visibility: hidden;">&nbsp;x&nbsp;</span></span>');
					$("#field11504_" + xzid).val($("#field11489_" + mxid).val()); 
					$("#field12821_" + xzid).val($("#field11822_" + mxid).val());
					if(dw == 0){
						$("#field11508_"+ xzid).val("EA");
					}else{
						$("#field11508_"+ xzid).val("WEA");
					}
				}
			});
		}
	});
	//A3-4 带出批数量
	var fzwx = $("#field11521").val();
	var khh =  $("#field11394").val();
	jQuery.ajax({
		 url: "/interface/fst/WF118608ajaxaction.jsp",
		 data: {type: 1, fzwx: fzwx,khh: khh},
		 cache: false,
		 type: "post",
		 dataType: "json",
		 async: false,
		 success: function (result) {
			 if(result[0].QTY != ""){
				 $("#field11357").val(result[0].QTY);
				 document.getElementById("field11357").readOnly=true;
				//去除带出信息必填标记
				 var span = document.getElementById("field11357span");
			     span.removeChild(span.firstChild);
			 }
		 }
	});
	
<%}%>

<%if(nodeid == 2343){%>
//A3-2 带出辅芯片
	$("input[id^=field11316_]").each(function(index){
		var mxid = this.id.split("_")[1];
		var a = document.getElementById("field11331_"+mxid).value;
		var dw = document.getElementById("field11333_"+mxid).value;
		if(a == 0 && $("#div2button > button").length == 2){
			addRow2(2);
			var len = index;
			$("input[id^=field13002_]").each(function(index){
				var xzid = this.id.split("_")[1];
				if($("#field12821_" + xzid).val() == ""){
					var indexrow = new wlqdrow();
					indexrow.xplh = $("#field11316_" + mxid).val();
					indexrow.xppm = $("#field11317_" + mxid).val();
					indexrow.xpsl = $("#field11332_" + mxid).val();
					indexrow.dw = $("#field11333_" + mxid).val();
					
					$("#field11502_" + xzid).val(indexrow.xplh);
					$("#field11505_" + xzid).val(indexrow.xppm);
					$("#field11506_" + xzid).val(indexrow.xpsl*1000);
					$("#field13002_"+ xzid).val((len+1)*10);
					$("#field13002_"+ xzid + "span").html('<span class="e8_showNameClass"><a>' + (len+1)*10 + '</a>&nbsp;<span class="e8_delClass" id="'+ (len+1)*10 +'" onclick="del(event,this,1,false,{});" style="opacity: 1; visibility: hidden;">&nbsp;x&nbsp;</span></span>');
					$("#field11504_" + xzid).val($("#field11489_" + mxid).val()); 
					$("#field12821_" + xzid).val($("#field11822_" + mxid).val());
					if(dw == 0){
						$("#field11508_"+ xzid).val("EA");
					}else{
						$("#field11508_"+ xzid).val("WEA");
					}
				}
			});
		}
	});

<%}%>

//根据工序封装外形带出工作中心
//主数据申请T 创建节点 2453 
<%if(nodeid == 2346 ||nodeid == 2453){%>
	$("input[id^=field11489_]").each(function(index){
		var tmp = this.id.split("_")[1];
		var fzwx = $("#field11521").val();
		var gxms = $("#field11822_"+ tmp).val();
		jQuery.ajax({
			 url: "/interface/fst/WF118605ajaxaction.jsp",
			 data: {type: 1, fzwx: fzwx,gxms: gxms},
			 cache: false,
			 type: "post",
			 dataType: "json",
			 success: function (result) {
				 if(result[0].WORK_CENTER_FK != ""){
				 	$("#field12422_"+tmp).val(result[0].WORK_CENTER_FK);
					$("#field12422_"+tmp+"span").html('<span class="e8_showNameClass"><a>' + result[0].WORK_CENTER_FK + '</a>&nbsp;<span class="e8_delClass" id="'+result[0].WORK_CENTER_FK+'">&nbsp;&nbsp;</span></span>');
				 }
			}
		});
	});
<%}%>

//A3-1 品名描述工厂自动带出
<%if(nodeid == 2342 || nodeid == 2453){%>
	$("#field11486").val($("#field11285").val());
	document.getElementById("field11486").readOnly=true;
	if( $("#field11601").val().substring(0,1) == "T"){
		$("#field11623").val("TEST");
		document.getElementById("field11623").readOnly=true;
	}
	else if($("#field11601").val().substring(0,1) == "A"){
		$("#field11623").val("ASSY");
		document.getElementById("field11623").readOnly=true;
	}
	document.getElementById("field11601").readOnly=true;
<%}%>

//解决物料清单明细工序项目号保存页面不显示
//A3-1 2342 A3-2 2343 A3-4 2345 A4-1 2355 A4-2 2347 A4-4 2349 A6 2352 归档 2351
//主数据申请T 分支合并 2458 
<%if(nodeid == 2342 ||nodeid == 2343 ||nodeid == 2345 ||nodeid == 2355 ||nodeid == 2347 ||nodeid == 2349 ||nodeid == 2352 ||nodeid == 2351||nodeid == 2458){%>
	$("input[id^=field11561_]").each(function(index){
			var tmp = this.id.split("_")[1];
			if(jQuery("#field11561_" + tmp + "span").text() == ""){
				jQuery("#field11561_" + tmp + "span").text(jQuery(this).val());
			}
	});
	$("input[id^=field13001_]").each(function(index){
		var tmp = this.id.split("_")[1];
		if(jQuery("#field13001_" + tmp + "span").text() == ""){
			jQuery("#field13001_" + tmp + "span").text(jQuery(this).val());
		}
	});
	$("input[id^=field13002_]").each(function(index){
		var tmp = this.id.split("_")[1];
		if(jQuery("#field13002_" + tmp + "span").text() == ""){
			jQuery("#field13002_" + tmp + "span").text(jQuery(this).val());
		}
	});
	$("input[id^=field13003_]").each(function(index){
		var tmp = this.id.split("_")[1];
		if(jQuery("#field13003_" + tmp + "span").text() == ""){
			jQuery("#field13003_" + tmp + "span").text(jQuery(this).val());
		}
	});
<%}%>
//A3-1 2342 A4-1 2355  非当前角色维护工序页面隐藏
<%if(nodeid == 2342 || nodeid == 2355){%>
	$("input[id^=field13001_]").each(function(index){
		var tmp = this.id.split("_")[1];
		if($("#field13001_" + tmp).val() == "" && $("#field12821_" + tmp).val() != ""){
			$("#field13001_" + tmp).parent().parent().attr('style','display:none');
		}
	});
<%}%>
//A3-2 2343 A4-2 2347 非当前角色维护工序页面隐藏
<%if(nodeid == 2343 || nodeid == 2347){%>
	$("input[id^=field13002_]").each(function(index){
		var tmp = this.id.split("_")[1];
		if($("#field13002_" + tmp).val() == "" && $("#field12821_" + tmp).val() != ""){
			$("#field13002_" + tmp).parent().parent().attr('style','display:none');
		}
	});
<%}%>
//A3-4 2345  A4-4 2349 非当前角色维护工序页面隐藏
<%if(nodeid == 2345 || nodeid == 2349){%>
	$("input[id^=field13003_]").each(function(index){
		var tmp = this.id.split("_")[1];
		if($("#field13003_" + tmp).val() == "" && $("#field12821_" + tmp).val() != ""){
			$("#field13003_" + tmp).parent().parent().attr('style','display:none');
		}
	});
<%}%>

//标准工艺路线带出描述
//主数据申请T T1 2453 
<%if(nodeid == 2353  ||nodeid == 2453){%>
	$("#field11781").bindPropertyChange(function(e){
		jQuery.ajax({
			url: "/interface/fst/WF118606ajaxaction.jsp",
			data: {type: 1, gylxdm: e.value},
			cache: false,
			type: "post",
			dataType: "json",
			success: function (result) {
				$("#field11446").val(result[0].desc);
				
				//带出信息隐藏必填标记
				var span = document.getElementById("field11446span");
				span.removeChild(span.firstChild);
			}
		});
	});
<%}%>

//解决工艺路线明细工序保存页面不显示
	$("input[id^=field11822_]").each(function(index){
			var tmp = this.id.split("_")[1];
			if(jQuery("#field11822_" + tmp + "span").text() == ""){
				jQuery("#field11822_" + tmp + "span").text(jQuery(this).val());
			}
	});
//解决工艺路线明细工作中心保存页面不显示
	$("input[id^=field12422_]").each(function(index){
			var tmp = this.id.split("_")[1];
			if(jQuery("#field12422_" + tmp + "span").text() == ""){
				jQuery("#field12422_" + tmp + "span").text(jQuery(this).val());
			}
	});
//解决工艺路线明细设备组保存页面不显示
	$("input[id^=field12481_]").each(function(index){
			var tmp = this.id.split("_")[1];
			if(jQuery("#field12481_" + tmp + "span").text() == ""){
				jQuery("#field12481_" + tmp + "span").text(jQuery(this).val());
			}
	});
//封装信息判断品名描述
	$("#field11285").blur(function(e){
		var pmms = $("#field11285").val();
		jQuery.ajax({
			url: "/interface/fst/WF118604ajaxaction.jsp",
			data: {type: 1, gylxdm: pmms},
			cache: false,
			type: "post",
			dataType: "json",
			success: function (result) {
				if(result[0].no != 0 ){
					alert("请重新输入品名描述");
					$("#field11285").val("");
				}
			}
		});
	});
//A3-1 MES主数据封装外形根据封装信息的带出
	$("#field11349").val($("#field11521").val());
	$("#field11349span").html('<span class="e8_showNameClass"><a>' + $("#field11521").val() + '</a>&nbsp;<span class="e8_delClass" id="'+$("#field11521").val()+'">&nbsp;&nbsp;</span></span>');
});

//A5 带出UPH 不是数据的则根据公式计算 
  <%if(nodeid == 2350){%>
	  $("input[id^=field11822_]").each(function(index){
		  var tmp = this.id.split("_")[1];
		  var fzwx = $("#field11521").val();
		  //遗留问题 :ChipSizeX  ChipSizeY WaferSize  目前默认取主芯片的数据   WireQty 待确认
		  var ChipSizeX = parseFloat($("#field11318_0").val());
		  var ChipSizeY = parseFloat($("#field11319_0").val());
		  var options=$("#disfield11323_0 option:selected");
		  var WaferSize = parseInt(options.text());
		  var WireQty = 0 ;
		  jQuery.ajax({
				url: "/interface/fst/WF118611ajaxaction.jsp",
				data: {type: 1, fzwx: fzwx, gx: $("#field11822_" + tmp).val()},
				cache: false,
				type: "post",
				dataType: "json",
				success: function (result) {
					var str = result[0].uph_formula;
					var SingleAttachTime = parseFloat(result[0].Single_Attach_Time);
					var AttachChangeWaferTime = parseFloat(result[0].Attach_Change_Wafer_Time);
					var SingleWireBondTime = parseFloat(result[0].Single_Wire_Bond_Time);
					var SingleNoWireTime = parseFloat(result[0].Single_No_Wire_Time);
					var SingleGrindTime = parseFloat(result[0].Single_Grind_Time);
					var ScribeMeters = parseFloat(result[0].Scribe_Meters);
					var res = isNaN(str);
					if(res == false){
						$("#field11492_" + tmp ).val(str);
					}
					else{
						$("#field11492_" + tmp ).val(eval(str));
						$("#field11492_" + tmp ).val($("#field11492_" + tmp ).val().substring(0,10));
					}
				}
			});
	  });
  <%}%>
  
  //T2获取部分数据 T3-1 获取 WireQty T3-1
  <%if(nodeid == 2454 || nodeid == 2455){%>
	  $("input[id^=field11822_]").each(function(index){
		  var tmp = this.id.split("_")[1];
		  var fzwx = $("#field11521").val();
		  //遗留问题 :ChipSizeX  ChipSizeY WaferSize  目前默认取主芯片的数据   WireQty 待确认
		  var ChipSizeX = parseFloat($("#field11318_0").val());
		  var ChipSizeY = parseFloat($("#field11319_0").val());
		  var options=$("#disfield11323_0 option:selected");
		  var WaferSize = parseInt(options.text());
		  var TestTime = $("#field11340").val();
		  var SiteQty = $("#field11341").val();
		  var IndexTime = $("#field11342").val();
		  var WireQty = 0;
		  jQuery.ajax({
				url: "/interface/fst/WF118611ajaxaction.jsp",
				data: {type: 1, fzwx: fzwx, gx: $("#field11822_" + tmp).val()},
				cache: false,
				type: "post",
				dataType: "json",
				success: function (result) {
					var str = result[0].uph_formula;
					var SingleAttachTime = parseFloat(result[0].Single_Attach_Time);
					var AttachChangeWaferTime = parseFloat(result[0].Attach_Change_Wafer_Time);
					var SingleWireBondTime = parseFloat(result[0].Single_Wire_Bond_Time);
					var SingleNoWireTime = parseFloat(result[0].Single_No_Wire_Time);
					var SingleGrindTime = parseFloat(result[0].Single_Grind_Time);
					var ScribeMeters = parseFloat(result[0].Scribe_Meters);
					var res = isNaN(str);
					if(res == false){
						$("#field11492_" + tmp ).val(str);
					}
					else{
						$("#field11492_" + tmp ).val(eval(str));
						$("#field11492_" + tmp ).val($("#field11492_" + tmp ).val().substring(0,10));
					}
				}
			});
	  });
  <%}%>
 
  //T1  新增明细如果为空不可提交
 <%if(nodeid == 2453){%>
 checkCustomize = function() {
 			var flag = true;
 				jQuery("input[id^='field11822_']").each(function(index) {
 					var tmp = this.id.split("_")[1];
 					if($("#field11822_"+tmp).val()==""){
 						flag = false;
 					}
 				});
 				jQuery("input[id^='field11489_']").each(function(index) {
 					if(jQuery(this).val()==""){
 						flag = false;
 					}
 				});
 				jQuery("input[id^='field12422_']").each(function(index) {
 					var tmp = this.id.split("_")[1];
 					if($("#field12422_"+tmp).val()==""){
 						flag = false;
 					}
 				});
 				if (flag == false){
 				alert("请确认申请单信息填写完整");
 				}
 			return flag;
 		}
 <%}%> 
//主数据申请创建节点 2341 需求系统编号OA201705004 
<%if(nodeid == 2341){%>
	checkCustomize = function() {
		var options=$("#field11280 option:selected");
		var sclx = options.text();
		var khh =  $("#field11394").val();
		if($("#field11521").val() == "DFN8NT3Q-075-CU" && sclx == "AT" && khh == "243"){
			var pmms = $("#field11285").val();
			var flag = true;
			if(pmms.indexOf("TL")<0)
			{
				flag = false;
			}
			if (flag == false)
			{
				alert("请确认品名描述是否填写正确");
			}
			return flag;
		}
		else{
			return true;
		}
	}
<%}%>

 //物料清单取芯片信息
 function wlqdrow(){
	this.xplh = '';//芯片料号
	this.xppm = '';//芯片品名
	this.xpsl = '';//芯片数量
	this.dw = '';//单位
	//其他字段可在这儿继续添加
 }
//工艺路线明细排序
 function mxrow(){
	this.xmh = '';//项目号
	this.gxh = '';//工序
	this.gxms = '';//工序描述 
	this.bz = '';//备注 
	this.sbz = '';//设备组
	this.xmhwb = '';//项目号文本
	this.gxwb = '';//工序文本
	this.gxllan = '';//工序浏览按钮
	this.sbzwb = '';//设备组文本框
	this.sbzllan = '';//设备组浏览按钮
	this.gxmswb = '';//工序描述文本
	//其他字段可在这儿继续添加
 }
 //工艺路线明细排序
 function dopx(){
		var trarray = new Array();
		//存入数组
		$("input[id^=field11487_]").each(function(index) {
			var indexrow = new mxrow();
			var mxid = this.id.split("_")[1];
			indexrow.xmh = parseInt($("#field11487_"+mxid).val());//这行的明细项目号
			indexrow.gxh = $("#field11822_"+mxid).val();
			indexrow.gxms = $("#field11489_"+mxid).val();
			indexrow.bz = $("#field11490_"+mxid).val();
			//A1 设备组
			<%if(nodeid == 2353){%>
				indexrow.sbz = $("#field12481_"+mxid).val();
			<%}%>
			//T1 工作中心
			<%if(nodeid == 2453){%>
			indexrow.gzzx = $("#field12422_"+mxid).val();
			<%}%>
			indexrow.xmhwb = document.getElementById("field11487_"+mxid).readOnly;
			indexrow.gxwb = document.getElementById("field11822_"+mxid).readOnly;
			indexrow.gxllan = document.getElementById("field11822_"+mxid+"_browserbtn").disabled;
			//A1 设备组
			<%if(nodeid == 2353){%>
				indexrow.sbzwb = document.getElementById("field12481_"+mxid).readOnly;
				indexrow.sbzllan = document.getElementById("field12481_"+mxid+"_browserbtn").disabled;
			<%}%>
			//T1 工作中心
			<%if(nodeid == 2453){%>
				indexrow.gzzxwb = document.getElementById("field12422_"+mxid).readOnly;
				indexrow.gzzxllan = document.getElementById("field12422_"+mxid+"_browserbtn").disabled;
			<%}%>
			indexrow.gxmswb = document.getElementById("field11489_"+mxid).readOnly;
			
			trarray[index] = indexrow ;
		});
		//排序数组
		for(var i=0;i<trarray.length;i++){
			for(var j = 0;j < trarray.length - i - 1;j++){
				if(trarray[j].xmh > trarray[j+1].xmh){
					var temp = trarray[j];
					trarray[j] = trarray[j + 1];
					trarray[j + 1] = temp;
				}
			}
		}  
		for(var i=0;i<trarray.length-1;i++){
				if(trarray[i].xmh == trarray[i+1].xmh){
					var list = trarray[i];
					trarray[i] = trarray[i + 1];
					trarray[i + 1] = list;
				}
		}
		
		for(var i=0;i<trarray.length;i++){
			trarray[i].xmh = (i+1) * 10;
		}
      //重新插入数据 替换原来的
		$("input[id^=field11487_]").each(function(index) {
			var indexrow = trarray[index];
			var mxid = this.id.split("_")[1];
			$("#field11487_"+mxid).val(indexrow.xmh);//这行的明细项目号
			$("#field11822_"+mxid).val(indexrow.gxh);
			$("#field11822_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + indexrow.gxh + '</a>&nbsp;<span class="e8_delClass" id="'+indexrow.gxh+'">&nbsp;&nbsp;</span></span>');
			$("#field11489_"+mxid).val(indexrow.gxms);
			$("#field11490_"+mxid).val(indexrow.bz);
			//A1 设备组
			<%if( nodeid == 2353){%>
				$("#field12481_"+mxid).val(indexrow.sbz);
				$("#field12481_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + indexrow.sbz + '</a>&nbsp;<span class="e8_delClass" id="'+indexrow.sbz+'" >&nbsp;&nbsp;</span></span>');
			<%}%>
			//T1 工作中心
			<%if( nodeid == 2453){%>
				$("#field12422_"+mxid).val(indexrow.gzzx);
				$("#field12422_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + indexrow.gzzx + '</a>&nbsp;<span class="e8_delClass" id="'+indexrow.gzzx+'">&nbsp;&nbsp;</span></span>');
			<%}%>
			document.getElementById("field11487_"+mxid).readOnly = indexrow.xmhwb;
			document.getElementById("field11822_"+mxid).readOnly = indexrow.gxwb;
			document.getElementById("field11822_"+mxid+"_browserbtn").disabled = indexrow.gxllan;
		    document.getElementById("field11489_"+mxid).readOnly = indexrow.gxmswb;
		  //A1 设备组
		    <%if(nodeid == 2353){%>
		    	document.getElementById("field12481_"+mxid).readOnly = indexrow.sbzwb;
				document.getElementById("field12481_"+mxid+"_browserbtn").disabled = indexrow.sbzllan;
		    <%}%>
		  //T1 工作中心
			<%if( nodeid == 2453){%>
				document.getElementById("field12422_"+mxid).readOnly = indexrow.gzzxwb;
				document.getElementById("field12422_"+mxid+"_browserbtn").disabled = indexrow.gzzxllan;
			<%}%>
		})
	}



 //删除行方法
 function delRowmx(groupid, isfromsap){
	 var oTable = jQuery("table#oTable"+groupid);
	 var checkObj = oTable.find("input[name='check_node_"+groupid+"']:checked");
	 if(isfromsap || checkObj.size()>0){
		 var curindex = parseInt($G("nodesnum"+groupid).value);
		 var submitdtlStr = $G("submitdtlid"+groupid).value;
		 var deldtlStr = $G("deldtlid"+groupid).value;
		 checkObj.each(function(){
			 var rowIndex = jQuery(this).val();
			 var belRow = oTable.find("tr[_target='datarow'][_rowindex='"+rowIndex+"']");
			 var keyid = belRow.find("input[name='dtl_id_"+groupid+"_"+rowIndex+"']").val();
			 //提交序号串删除对应行号
			 var submitdtlArr = submitdtlStr.split(',');
			 submitdtlStr = "";
			 for(var i=0; i<submitdtlArr.length; i++){
				 if(submitdtlArr[i] != rowIndex)
					 submitdtlStr += ","+submitdtlArr[i];
			 }
			 if(submitdtlStr.length > 0 && submitdtlStr.substring(0,1) === ",")
				 submitdtlStr = submitdtlStr.substring(1);
			 //已有明细主键存隐藏域
			 if(keyid != "")
				 deldtlStr += ","+keyid;
			 //IE下需先销毁附件上传的object对象，才能remove行
			 try{
				 belRow.find("td[_fieldid][_fieldtype='6_1'],td[_fieldid][_fieldtype='6_2']").each(function(){
					 var swfObj = eval("oUpload"+jQuery(this).attr("_fieldid"));
					 swfObj.destroy();
				 });
			 }catch(e){}
			 belRow.remove();
			 curindex--;
		 });
		 $G("submitdtlid"+groupid).value = submitdtlStr;
		 if(deldtlStr.length >0 && deldtlStr.substring(0,1) === ",")
			 deldtlStr = deldtlStr.substring(1);
		 $G("deldtlid"+groupid).value = deldtlStr;
		 $G("nodesnum"+groupid).value = curindex;
		 //序号重排
		 oTable.find("input[name='check_node_"+groupid+"']").each(function(index){
			 var belRow = oTable.find("tr[_target='datarow'][_rowindex='"+jQuery(this).val()+"']");
			 belRow.find("span[name='detailIndexSpan"+groupid+"']").text(index+1);
		 });
		 oTable.find("input[name='check_all_record']").attr("checked", false);
		 //表单设计器，删除行触发公式计算
		 triFormula_delRow(groupid);
		 try{
			 calSum(groupid);
		 }catch(e){}
		 try{		//自定义函数接口,必须在最后，必须try-catch
			 eval("_customDelFun"+groupid+"()");
		 }catch(e){}

	 }else{
		 var language = readCookie("languageidweaver");
		// top.Dialog.alert(SystemEnv.getHtmlNoteName(3529, language));
		 return;
	 }
 }
</script> 
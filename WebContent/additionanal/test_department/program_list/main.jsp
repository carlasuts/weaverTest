<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
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

String shrid = BillUtil.getLabelId(formid,0,"shr");//审核人
String sqlxid = BillUtil.getLabelId(formid,0,"sqlx");//申请类型
String custidid = BillUtil.getLabelId(formid,0,"custid");//15209  客户号
String xzsqidhid = BillUtil.getLabelId(formid,0,"xzsqidh");//13946  新增申请ID号
String xzbbhid = BillUtil.getLabelId(formid,0,"xzbbh");//13947  新增版本号
String xzdypmlistid = BillUtil.getLabelId(formid,0,"xzdypmlist");//13948  新增对应品名list
String sbidhid = BillUtil.getLabelId(formid,0,"sbidh");//13952  升版ID号
String sbidbbhid = BillUtil.getLabelId(formid,0,"sbidbbh");//13953  升版ID版本号
String sbdypmlistid = BillUtil.getLabelId(formid,0,"sbdypmlist");//13954  升版对应品名list
String zfidhid = BillUtil.getLabelId(formid,0,"zfidh");//作废ID号
String zfidbbhid = BillUtil.getLabelId(formid,0,"zfidbbh");//作废ID版本号
String zfdypmlistid = BillUtil.getLabelId(formid,0,"zfdypmlist");//作废对应品名list
String bzxxid = BillUtil.getLabelId(formid,0,"bzxx");//14324  备注信息
String scwj = BillUtil.getLabelId(formid,0,"scwj");//上传文件
String cq = BillUtil.getLabelId(formid,0,"cq");//厂区
String sqr = BillUtil.getLabelId(formid,0,"sqr");//申请人


int node01 = BillUtil.getNodeId(workflowid, "01新建申请");//3361
int node0201 = BillUtil.getNodeId(workflowid, "0201升版主管审批");//3364
int node0202 = BillUtil.getNodeId(workflowid, "0202升版分管审批");//3365
int nodeG1 = BillUtil.getNodeId(workflowid, "归档1");//3362

int node0301 = BillUtil.getNodeId(workflowid, "0301申请主管审批");//3364
int node0302 = BillUtil.getNodeId(workflowid, "0302申请分管审批");//3365

int node0401 = BillUtil.getNodeId(workflowid, "0401作废品名主管审批");//3364
int node0402 = BillUtil.getNodeId(workflowid, "0402作废品名分管审批");//3365
int nodeG3 = BillUtil.getNodeId(workflowid, "归档3");//3362

%>
<script type="text/javascript">

	var shrid = <%=shrid%>
	var sqlxid = <%=sqlxid%>
	var custidid = <%=custidid%>
	var xzsqidhid = <%=xzsqidhid%>
	var xzbbhid = <%=xzbbhid%>
	var xzdypmlistid = <%=xzdypmlistid%>
	var sbidhid = <%=sbidhid%>
	var sbidbbhid = <%=sbidbbhid%>
	var sbdypmlistid = <%=sbdypmlistid%>
	var zfidhid = <%=zfidhid%>
	var zfidbbhid = <%=zfidbbhid%>
	var zfdypmlistid = <%=zfdypmlistid%>
	var bzxxid = <%=bzxxid%>
	var scwj = <%=scwj%>
	var sqr = <%=sqr%>
	var cq = <%=cq%>
	
	var requestid = <%=requestid%>
	
	jQuery(function () {
		var pmxl = '';
		var sbidh = '';
		<%if(nodeid ==node0401 || nodeid == node0402 || nodeid ==nodeG3){%>
		//作废带出历史附件
		jQuery.ajax({
			url: "/interface/additional/test_department/program_list/TF158101ajaxaction.jsp",
			data: {type: 4, idh: $("#field"+zfidhid).val(),bbhid: $("#field"+zfidbbhid).val()},
			cache: false,
			type: "post",
			dataType: "json",
			async: false,
			success: function (result) {
				$("span:contains('历史附件')").parent().parent().next().children("div").empty();
				$("span:contains('历史附件')").parent().parent().next().children("div").append('<div><a style="cursor: pointer; color: rgb(139, 139, 139) !important; text-decoration: none !important;" onmouseover="changefileaon(this)" onmouseout="changefileaout(this)" onclick="addDocReadTag('+result[0].docid+');openDocExt('+result[0].docid+','+result[0].versionid+','+result[0].imagefileid+',0)" title="'+result[0].imagefilename+'">'+result[0].imagefilename+'</a>&nbsp;&nbsp;&nbsp;<a style="display:inline-block;cursor:pointer;vertical-align:middle;width:20px;height:20px;background-image:url('+"/images/ecology8/workflow/fileupload/upload_wev8.png"+');" onclick="addDocReadTag('+result[0].docid+');downloads('+result[0].imagefileid+')" title="下载"></a></div>');
			}
		});
	 	<%}%>
		<%if(nodeid ==node0201 || nodeid == node0202 || nodeid ==nodeG1){%>
			//升版带出历史附件
			jQuery.ajax({
				url: "/interface/additional/test_department/program_list/TF158101ajaxaction.jsp",
				data: {type: 3, idh: $("#field"+sbidhid).val(),bbhid: $("#field"+sbidbbhid).val()},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					$("span:contains('历史附件')").parent().parent().next().children("div").empty();
					$("span:contains('历史附件')").parent().parent().next().children("div").append('<div><a style="cursor: pointer; color: rgb(139, 139, 139) !important; text-decoration: none !important;" onmouseover="changefileaon(this)" onmouseout="changefileaout(this)" onclick="addDocReadTag('+result[0].docid+');openDocExt('+result[0].docid+','+result[0].versionid+','+result[0].imagefileid+',0)" title="'+result[0].imagefilename+'">'+result[0].imagefilename+'</a>&nbsp;&nbsp;&nbsp;<a style="display:inline-block;cursor:pointer;vertical-align:middle;width:20px;height:20px;background-image:url('+"/images/ecology8/workflow/fileupload/upload_wev8.png"+');" onclick="addDocReadTag('+result[0].docid+');downloads('+result[0].imagefileid+')" title="下载"></a></div>');
				}
			});
		<%}%>
 		
		<%if(nodeid == node01){%>
		//根据申请人带出厂区
		jQuery.ajax({
			url: "/interface/additional/test_department/program_list/TF158104ajaxaction.jsp",
			data: {type: 2, roleid: $("#field" + sqr).val()},
			cache: true,
			type: "post",
			dataType: "text",
			success: function (result) {
				result = jQuery.trim(result);
				if(result == "1")
				{//崇川
					$("#field" + cq ).attr("value","0");
				}
				if(result == "142")
				{//苏通
					$("#field" + cq ).attr("value","1");
				}
				if(result == "101")
				{//合肥
					$("#field" + cq ).attr("value","2");
				}	
				setCover(cq);		
			}
		});

		//判断是否退回,如果退回申请类型不可改变
		jQuery.ajax({
			url: "/interface/additional/test_department/program_list/TF158101ajaxaction.jsp",
			data: {type: 5, requestid: requestid},
			cache: false,
			type: "post",
			dataType: "json",
			async: false,
			success: function (result) {
				if(result[0].thbz == "1"){
					$("#field" + sqlxid).attr("value",result[0].sqlx);
					setCover(sqlxid);
				}
			}
		});
		
		//客户号变化
		$("#field"+custidid).bindPropertyChange(function(){//14022
			init();
			doadd();
		});
		//申请类型
		$("#field"+sqlxid).bindPropertyChange(function(){
			init();
			doadd();
		});
	
		//卡控 防止同时申请
		checkCustomize = function() {
			var flag = true;
	 		pmxl = $("#field"+custidid).val();//14022
			var xzidh = $("#field"+xzsqidhid).val();//13946
	 		var xzbbh = $("#field"+xzbbhid).val();//13947
			var xzlist = $("#field"+xzdypmlistid).val();//13948
			var ary1  = new Array();
			ary1 = xzlist.split("\n");
			//删除输入新建品名list前后的空行
 			for(var i = 0 ; i<ary1.length ; i++){
				while(ary1[i] == ""){
					ary1.splice(i, 1);
				}
			}

			var sbidh = $("#field"+sbidhid).val();//13952
	 		var sbbbh = $("#field"+sbidbbhid).val();//13953
	 		var sblist = $("#field"+sbdypmlistid).val();//13954
			var ary2  = new Array();
			ary2 = sblist.split("\n");
			//删除输入升版品名list前后的空行
			for(var i = 0 ; i<ary2.length ; i++){
				while(ary2[i] == ""){
					ary2.splice(i, 1);
				}
			}
			
			//新建卡控
			if(xzlist != ""){
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158102ajaxaction.jsp",
	 				data: {type: 1, xzidh: xzidh , xzbbh :xzbbh},
	 				cache: false,
	 				type: "post",
	 				dataType: "json",
	 				async: false,
					success: function (result) {
						if(result[0].no != "0"){
							jQuery.ajax({
								url: "/interface/additional/test_department/program_list/TF158102ajaxaction.jsp",
				 				data: {type: 2, xzidh: xzidh , xzbbh :xzbbh},
				 				cache: false,
				 				type: "post",
				 				dataType: "json",
				 				async: false,
								success: function (result) {
									if(result[0].sqr != $("#field"+sqr).val()){
				 						flag = false;
				 					}
				 				}
				 			});
	 					}
	 				}
	 			});
				
				//新建判断输入品名是否存在于其它品名系列里 取归档后数据
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158103ajaxaction.jsp",
	 				data: {type: 1, xzidh: xzidh , factory : $("#field"+cq).val()},
	 				cache: false,
	 				type: "post",
	 				dataType: "text",
	 				async: false,
					success: function (sb) {
						sb = jQuery.trim(sb);
						var ary3  = new Array();
						ary3 = sb.split(" ");
						if(sb != "" ){
							for(var i = 0 ; i<ary3.length ; i++){
								for(var j = 0 ; j<ary1.length ; j++){
									if(ary3[i] == ary1[j]){
										flag = false;
									}
								}
							}
						}
	 				}
	 			});
				
				//新建判断输入品名是否存在于其它品名系列里 取未归档新建数据
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158103ajaxaction.jsp",
	 				data: {type: 2, xzidh: xzidh , factory : $("#field"+cq).val()},
	 				cache: false,
	 				type: "post",
	 				dataType: "text",
	 				async: false,
					success: function (sb) {
						sb = jQuery.trim(sb);
						var ary4  = new Array();
						ary4 = sb.split(" ");
						if(sb != "" ){
							for(var i = 0 ; i<ary4.length ; i++){
								for(var j = 0 ; j<ary1.length ; j++){
									if(ary4[i] == ary1[j]){
										flag = false;
									}
								}
							}
						}
	 				}
	 			});
				
				//新建判断输入品名是否存在于其它品名系列里 取未归档升版数据
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158103ajaxaction.jsp",
	 				data: {type: 3, xzidh: xzidh , factory : $("#field"+cq).val()},
	 				cache: false,
	 				type: "post",
	 				dataType: "text",
	 				async: false,
					success: function (sb) {
						sb = jQuery.trim(sb);
						var ary5  = new Array();
						ary5 = sb.split(" ");
						if(sb != "" ){
							for(var i = 0 ; i<ary5.length ; i++){
								for(var j = 0 ; j<ary1.length ; j++){
									if(ary5[i] == ary1[j]){
										flag = false;
										}
									}
								}
						}	
					}
	 			});
			}
		
	 		//升版卡控
	 		if(sblist != ""){
	 			jQuery.ajax({
	 				url: "/interface/additional/test_department/program_list/TF158102ajaxaction.jsp",
	 				data: {type: 3,  sbidh: sbidh , sbbbh :sbbbh },
	 				cache: false,
	 				type: "post",
	 				dataType: "json",
	 				async: false,
	 				success: function (result) {
						if(result[0].no != "0"){
							jQuery.ajax({
								url: "/interface/additional/test_department/program_list/TF158102ajaxaction.jsp",
				 				data: {type: 4, sbidh: sbidh , sbbbh :sbbbh},
				 				cache: false,
				 				type: "post",
				 				dataType: "json",
				 				async: false,
								success: function (result) {
									if(result[0].sqr != $("#field"+sqr).val()){
				 						flag = false;
				 					}
				 				}
				 			});
	 					}
	 				}
	 			});
	 			
	 			//升版判断品名是否存在于其它品名系列里 取归档后数据
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158103ajaxaction.jsp",
	 				data: {type: 1, xzidh: sbidh ,  factory : $("#field"+cq).val()},
	 				cache: false,
	 				type: "post",
	 				dataType: "text",
	 				async: false,
					success: function (sb) {
						sb = jQuery.trim(sb);
						var ary6  = new Array();
						ary6 = sb.split(" ");
						if(sb != "" ){
							for(var i = 0 ; i<ary6.length ; i++){
								for(var j = 0 ; j<ary2.length ; j++){
									if(ary6[i] == ary2[j]){
										flag = false;
									}
								}
							}
						}
	 				}
	 			});
	 			
	 			
				//升版判断输入品名是否存在于其它品名系列里 取未归档升版数据
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158103ajaxaction.jsp",
	 				data: {type: 3, xzidh: sbidh ,  factory : $("#field"+cq).val()},
	 				cache: false,
	 				type: "post",
	 				dataType: "text",
	 				async: false,
					success: function (sb) {
						sb = jQuery.trim(sb);
						var ary7  = new Array();
						ary7 = sb.split(" ");
						if(sb != "" ){
							for(var i = 0 ; i<ary7.length ; i++){
								for(var j = 0 ; j<ary2.length ; j++){
									if(ary7[i] == ary2[j]){
										flag = false;
									}
								}
							}
						}
	 				}
	 			});
				
				//升版判断输入品名是否存在于其它品名系列里 取未归档新建数据
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158103ajaxaction.jsp",
	 				data: {type: 2, xzidh: sbidh , factory : $("#field"+cq).val()},
	 				cache: false,
	 				type: "post",
	 				dataType: "text",
	 				async: false,
					success: function (sb) {
						sb = jQuery.trim(sb);
						var ary8  = new Array();
						ary8 = sb.split(" ");
						if(sb != "" ){
							for(var i = 0 ; i<ary8.length ; i++){
								for(var j = 0 ; j<ary2.length ; j++){
									if(ary8[i] == ary2[j]){
										flag = false;
									}
								}
							}
						}	
					}
	 			});
	 		}
	 			
	 		if (flag == false)
	 		{
	 			alert("请确认该品名系列申请单是否已存在");
	 		}
	 		return flag;
 		}
		
		<%}%>
	});

	function doadd(){	
		var options1 = $("#field"+sqlxid+ " option:selected");
		var sqlx = options1.val();
		var cust_id = $("#field"+custidid).val();//14022
		var str = "";
		var str1 = "0000";
		var plantopt = "";
		var factoryname = "";
		
		if(sqlx == "0"){//新建
			if($("#field" + cq ).val() == "0"){
				plantopt = "1000";
				factoryname = "T"
			}
			if($("#field" + cq ).val() == "1"){
				plantopt = "4000";
				factoryname = "S"
			}
			if($("#field" + cq ).val() == "2"){
				plantopt = "5000";
				factoryname = "H"
			}
			jQuery.ajax({
				url: "/interface/additional/test_department/program_list/TF158101ajaxaction.jsp",
				data: {type: 1, custidid: cust_id , plantopt: plantopt},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					str = str1 + (parseInt(result[0].no)+1);
					$("#field"+xzsqidhid).val(factoryname + cust_id + str.substr(str.length-4));//13946
					$("#field"+xzbbhid).val(1);//13947
				}
			});
			document.getElementById("field"+xzsqidhid).readOnly=true;
			document.getElementById("field"+xzbbhid).readOnly=true;
		}
		if(sqlx == "2"){
			//作废ID号
			$("#field"+zfidhid).blur(function(){
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158101ajaxaction.jsp",
					data: {type: 2, zjpmsrid: $("#field"+zfidhid).val()},
					cache: false,
					type: "post",
					dataType: "json",
					async: false,
					success: function (result) {
						$("#field"+zfidbbhid).val(result[0].dqidbbh);//自动生成升版ID版本号 13953
						document.getElementById("field"+zfidbbhid).readOnly=true;//13953
					}
				});
				//作废带出历史附件
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158101ajaxaction.jsp",
					data: {type: 4, idh: $("#field"+zfidhid).val(),bbhid: $("#field"+zfidbbhid).val()},
					cache: false,
					type: "post",
					dataType: "json",
					async: false,
					success: function (result) {
						$("span:contains('历史附件')").parent().parent().next().children("div").empty();
						$("span:contains('历史附件')").parent().parent().next().children("div").append('<div><a style="cursor: pointer; color: rgb(139, 139, 139) !important; text-decoration: none !important;" onmouseover="changefileaon(this)" onmouseout="changefileaout(this)" onclick="addDocReadTag('+result[0].docid+');openDocExt('+result[0].docid+','+result[0].versionid+','+result[0].imagefileid+',0)" title="'+result[0].imagefilename+'">'+result[0].imagefilename+'</a>&nbsp;&nbsp;&nbsp;<a style="display:inline-block;cursor:pointer;vertical-align:middle;width:20px;height:20px;background-image:url('+"/images/ecology8/workflow/fileupload/upload_wev8.png"+');" onclick="addDocReadTag('+result[0].docid+');downloads('+result[0].imagefileid+')" title="下载"></a></div>');
					}
				});
				//作废带出对应品名list
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158104ajaxaction.jsp",
					data: {type: 1, zjpmsrid: $("#field"+zfidhid).val()},
					cache: false,
					type: "post",
					dataType: "text",
					async: false,
					success: function (result) {
						result = jQuery.trim(result);
						$("#field"+zfdypmlistid).val(result);
					}
				});
			});
		}
		if(sqlx == "1"){//升版
			//升版ID号
			$("#field"+sbidhid).blur(function(){
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158101ajaxaction.jsp",
					data: {type: 2, zjpmsrid: $("#field"+sbidhid).val().trim()},
					cache: false,
					type: "post",
					dataType: "json",
					async: false,
					success: function (result) {
						var sbidbbh =  parseInt(result[0].dqidbbh)+1;
						$("#field"+sbidbbhid).val(sbidbbh);//自动生成升版ID版本号 13953
						document.getElementById("field"+sbidbbhid).readOnly=true;//13953
					}
				});
				
				//升版带出历史附件
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158101ajaxaction.jsp",
					data: {type: 3, idh: $("#field"+sbidhid).val().trim(),bbhid: $("#field"+sbidbbhid).val()},
					cache: false,
					type: "post",
					dataType: "json",
					async: false,
					success: function (result) {
						$("span:contains('历史附件')").parent().parent().next().children("div").empty();
						$("span:contains('历史附件')").parent().parent().next().children("div").append('<div><a style="cursor: pointer; color: rgb(139, 139, 139) !important; text-decoration: none !important;" onmouseover="changefileaon(this)" onmouseout="changefileaout(this)" onclick="addDocReadTag('+result[0].docid+');openDocExt('+result[0].docid+','+result[0].versionid+','+result[0].imagefileid+',0)" title="'+result[0].imagefilename+'">'+result[0].imagefilename+'</a>&nbsp;&nbsp;&nbsp;<a style="display:inline-block;cursor:pointer;vertical-align:middle;width:20px;height:20px;background-image:url('+"/images/ecology8/workflow/fileupload/upload_wev8.png"+');" onclick="addDocReadTag('+result[0].docid+');downloads('+result[0].imagefileid+')" title="下载"></a></div>');
					}
				});
				//升版带出对应品名list
				jQuery.ajax({
					url: "/interface/additional/test_department/program_list/TF158104ajaxaction.jsp",
					data: {type: 1, zjpmsrid: $("#field"+sbidhid).val().trim()},
					cache: false,
					type: "post",
					dataType: "text",
					async: false,
					success: function (result) {
						result = jQuery.trim(result);
						$("#field"+sbdypmlistid).val(result);
					}
				});
			});
		}
	}

	//用于创建初始化
	function init(){
		$("#field"+xzsqidhid).val("");
		document.getElementById("field"+xzsqidhid).readOnly=false;
		$("#field"+xzbbhid).val("");
		document.getElementById("field"+xzbbhid).readOnly=false;
		$("#field"+xzdypmlistid).val("");
		document.getElementById("field"+xzdypmlistid).readOnly=false;
		$("#field"+sbidhid).val("");
		document.getElementById("field"+sbidhid).readOnly=false;
		$("#field"+sbidbbhid).val("");
		document.getElementById("field"+sbidbbhid).readOnly=false;
		$("#field"+sbdypmlistid).val("");
		document.getElementById("field"+sbdypmlistid).readOnly=false;
		$("#field"+zfidhid).val("");
		document.getElementById("field"+zfidhid).readOnly=false;
		$("#field"+zfidbbhid).val("");
		document.getElementById("field"+zfidbbhid).readOnly=false;
		$("#field"+zfdypmlistid).val("");
		document.getElementById("field"+zfdypmlistid).readOnly=false;
		$("span:contains('历史附件')").parent().parent().next().children("div").empty();
		$("#field"+bzxxid).val("");
	}
	
	//该function用于退回设置申请类型只读
	function setCover(field) {
		var temp = field;
		var htmlShadow = '<div id="shadow_' + temp + '"></div>';
		jQuery("#field" + temp).before(htmlShadow);
		jQuery("#shadow_" + temp).css("z-index",100);
		jQuery("#shadow_" + temp).css("height",jQuery("#field" + temp).parent().parent().css("height"));
		jQuery("#shadow_" + temp).css("width",jQuery("#field" + temp).parent().parent().css("width"));
		jQuery("#shadow_" + temp).css("top",jQuery("#field" + temp).parent().parent().offset().top);
		jQuery("#shadow_" + temp).css("left",jQuery("#field" + temp).parent().parent().offset().left);
		jQuery("#shadow_" + temp).css("position","absolute");
		jQuery("#shadow_" + temp).css("opacity",0.5);
		jQuery("#shadow_" + temp).css("background","#FFFFFF");
	}

</script> 
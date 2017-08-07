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

String custidid = BillUtil.getLabelId(formid,0,"custid");//15209  客户号
String sfxjid = BillUtil.getLabelId(formid,0,"sfxj");//13942  是否新建
String sfzjpmid = BillUtil.getLabelId(formid,0,"sfzjpm");//13943  是否增加品名
String sfsbid = BillUtil.getLabelId(formid,0,"sfsb");//14281  是否升版
String sfpmzhid = BillUtil.getLabelId(formid,0,"sfpmzh");//14321  是否品名转换
String xzsqidhid = BillUtil.getLabelId(formid,0,"xzsqidh");//13946  新增申请ID号
String xzbbhid = BillUtil.getLabelId(formid,0,"xzbbh");//13947  新增版本号
String xzdypmlistid = BillUtil.getLabelId(formid,0,"xzdypmlist");//13948  新增对应品名list
String zjpmsridid = BillUtil.getLabelId(formid,0,"zjpmsrid");//13949  增加品名输入ID
String zjpmbbhid = BillUtil.getLabelId(formid,0,"zjpmbbh");//13950  增加品名版本号
String zjpmdylistid = BillUtil.getLabelId(formid,0,"zjpmdylist");//13951  增加品名对应品名list
String sbidhid = BillUtil.getLabelId(formid,0,"sbidh");//13952  升版ID号
String sbidbbhid = BillUtil.getLabelId(formid,0,"sbidbbh");//13953  升版ID版本号
String sbdypmlistid = BillUtil.getLabelId(formid,0,"sbdypmlist");//13954  升版对应品名list
String zhidhid = BillUtil.getLabelId(formid,0,"zhidh");//14322  转换ID号
String zhidbbhid = BillUtil.getLabelId(formid,0,"zhidbbh");//14323  转换ID版本号
String zhpmdypmlistid = BillUtil.getLabelId(formid,0,"zhpmdypmlist");//14324  转换品名对应品名list
String bzxxid = BillUtil.getLabelId(formid,0,"bzxx");//14324  转换品名对应品名list


int node01 = BillUtil.getNodeId(workflowid, "01新建申请");//3361
int node0201 = BillUtil.getNodeId(workflowid, "0201升版主管审批");//3364
int node0202 = BillUtil.getNodeId(workflowid, "0202升版分管审批");//3365
int nodeG1 = BillUtil.getNodeId(workflowid, "归档1");//3362

int node0401 = BillUtil.getNodeId(workflowid, "0401增加品名主管审批");//3364
int node0402 = BillUtil.getNodeId(workflowid, "0402增加品名分管审批");//3365
int nodeG3 = BillUtil.getNodeId(workflowid, "归档3");//3362

int node0501 = BillUtil.getNodeId(workflowid, "0501品名转换主管审批");//3364
int node0502 = BillUtil.getNodeId(workflowid, "0502增加品名分管审批");//3365
int nodeG4 = BillUtil.getNodeId(workflowid, "归档4");//3362
%>
<script type="text/javascript">
	var custidid = <%=custidid%>
	var sfxjid = <%=sfxjid%>
	var sfzjpmid = <%=sfzjpmid%>
	var sfsbid = <%=sfsbid%>
	var sfpmzhid = <%=sfpmzhid%>
	var xzsqidhid = <%=xzsqidhid%>
	var xzbbhid = <%=xzbbhid%>
	var xzdypmlistid = <%=xzdypmlistid%>
	var zjpmsridid = <%=zjpmsridid%>
	var zjpmbbhid = <%=zjpmbbhid%>
	var zjpmdylistid = <%=zjpmdylistid%>
	var sbidhid = <%=sbidhid%>
	var sbidbbhid = <%=sbidbbhid%>
	var sbdypmlistid = <%=sbdypmlistid%>
	var zhidhid = <%=zhidhid%>
	var zhidbbhid = <%=zhidbbhid%>
	var zhpmdypmlistid = <%=zhpmdypmlistid%>
	var bzxxid = <%=bzxxid%>
	
	jQuery(function () {
		var pmxl = '';
		var zjpmsrid = '';
		var sbidh = '';
		<%if(nodeid ==node0401 || nodeid == node0402){%>
		//增加品名带出历史附件
		jQuery.ajax({
			url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
			data: {type: 3, zjpmsrid: $("#field"+zjpmsridid).val()},
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
	 	<%if(nodeid ==nodeG3){%>
	 	//归档节点显示历史附件
		jQuery.ajax({
			url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
			data: {type: 4, zjpmsrid: $("#field"+zjpmsridid).val(),dqidbbh:  $("#field"+zjpmbbhid).val()},
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
		<%if(nodeid ==node0201 || nodeid == node0202){%>
			//升版带出历史附件
			jQuery.ajax({
				url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
				data: {type: 3, zjpmsrid: $("#field"+sbidhid).val()},
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
		<%if(nodeid ==nodeG1){%>
	 	//归档节点显示历史附件
		jQuery.ajax({
			url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
			data: {type: 4, zjpmsrid: $("#field"+sbidhid).val(), dqidbbh:  $("#field"+sbidbbhid).val()},
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
		
		<%if(nodeid ==node0501 || nodeid == node0502){%>
		//品名转换带出历史附件
		jQuery.ajax({
			url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
			data: {type: 3, zjpmsrid: $("#field"+zhidhid).val()},
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
		<%if(nodeid ==nodeG4){%>
	 	//归档节点显示历史附件
		jQuery.ajax({
			url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
			data: {type: 4, zjpmsrid: $("#field"+zhidhid).val(), dqidbbh:  $("#field"+zhidbbhid).val()},
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
		
		//客户号变化
		$("#field"+custidid).bindPropertyChange(function(){//14022
			init();
			doadd();
		});
		//是否新建
		$("#field"+sfxjid).bindPropertyChange(function(){//13942
			init();
			doadd();
		});
		//是否增加品名
		$("#field"+sfzjpmid).bindPropertyChange(function(){//13943
			init();
			doadd();
		});
		//是否升版
		$("#field"+sfsbid).bindPropertyChange(function(){//14281
			init();
			doadd();
		});
		//是否转换品名
		$("#field"+sfpmzhid).bindPropertyChange(function(){//14321
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
			
	 		var zjidh = $("#field"+zjpmsridid).val();//13949
	 		var zjbbh = $("#field"+zjpmbbhid).val();//13950
	 		var zjlist = $("#field"+zjpmdylistid).val();//13951
	 		
			var ary2  = new Array();
			ary2 = zjlist.split("\n");
			
	 			
			var sbidh = $("#field"+sbidhid).val();//13952
	 		var sbbbh = $("#field"+sbidbbhid).val();//13953
	 		var sblist = $("#field"+sbdypmlistid).val();//13954
	 		
	 		var zhidh = $("#field"+zhidhid).val();//14322
	 		var zhidbbh = $("#field"+zhidbbhid).val();//14323
	 		var zhlist = $("#field"+zhpmdypmlistid).val();//14324
			//新建卡控
			if(xzlist != ""){
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158102ajaxaction.jsp",
	 				data: {type: 1, xzidh: xzidh , xzbbh :xzbbh},
	 				cache: false,
	 				type: "post",
	 				dataType: "json",
	 				async: false,
					success: function (result) {
						if(result[0].no != "0"){
	 						flag = false;
	 					}
	 				}
	 			});
				
				//新建判断输入品名是否存在于其它品名系列里 取归档后数据
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158103ajaxaction.jsp",
	 				data: {type: 1, xzidh: xzidh},
	 				cache: false,
	 				type: "post",
	 				dataType: "text",
	 				async: false,
					success: function (result) {
						result = jQuery.trim(result);
						var ary3  = new Array();
						ary3 = result.split("<br>");
						for(var i = 0 ; i<ary3.length ; i++){
							for(var j = 0 ; j<ary1.length ; j++){
								if(ary3[i] == ary1[j]){
									flag = false;
								}
							}
						}
	 				}
	 			});
				
				//新建判断输入品名是否存在于其它品名系列里 取未归档新建数据
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158103ajaxaction.jsp",
	 				data: {type: 2, xzidh: xzidh},
	 				cache: false,
	 				type: "post",
	 				dataType: "text",
	 				async: false,
					success: function (result) {
						result = jQuery.trim(result);
						var ary4  = new Array();
						ary4 = result.split("<br>");
						for(var i = 0 ; i<ary4.length ; i++){
							for(var j = 0 ; j<ary1.length ; j++){
								if(ary4[i] == ary1[j]){
									flag = false;
								}
							}
						}
	 				}
	 			});
				
				//新建判断输入品名是否存在于其它品名系列里 取未归档增加品名数据
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158103ajaxaction.jsp",
	 				data: {type: 3, xzidh: xzidh},
	 				cache: false,
	 				type: "post",
	 				dataType: "text",
	 				async: false,
					success: function (result) {
						result = jQuery.trim(result);
						var ary5  = new Array();
						ary5 = result.split("<br>");
						for(var i = 0 ; i<ary5.length ; i++){
							for(var j = 0 ; j<ary1.length ; j++){
								if(ary5[i] == ary1[j]){
									flag = false;
								}
							}
						}
	 				}
	 			});
				
			}
			//新增品名卡控
			if(zjlist != ""){
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158102ajaxaction.jsp",
	 				data: {type: 2,  zjidh: zjidh , zjbbh :zjbbh },
	 				cache: false,
	 				type: "post",
	 				dataType: "json",
	 				async: false,
	 				success: function (result) {
	 					if(result[0].no != "0"){
	 						flag = false;
	 					}
	 				}
	 			});

				//增加品名判断输入品名是否存在于其它品名系列里 取归档后数据
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158103ajaxaction.jsp",
	 				data: {type: 1, xzidh: zjidh},
	 				cache: false,
	 				type: "post",
	 				dataType: "text",
	 				async: false,
					success: function (result) {
						result = jQuery.trim(result);
						var ary6  = new Array();
						ary6 = result.split("<br>");
						for(var i = 0 ; i<ary6.length ; i++){
							for(var j = 0 ; j<ary2.length ; j++){
								if(ary6[i] == ary2[j]){
									flag = false;
								}
							}
						}
	 				}
	 			});
				
				//增加品名判断输入品名是否存在于其它品名系列里 取未归档新建数据
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158103ajaxaction.jsp",
	 				data: {type: 2, xzidh: zjidh},
	 				cache: false,
	 				type: "post",
	 				dataType: "text",
	 				async: false,
					success: function (result) {
						result = jQuery.trim(result);
						var ary7  = new Array();
						ary7 = result.split("<br>");
						for(var i = 0 ; i<ary7.length ; i++){
							for(var j = 0 ; j<ary2.length ; j++){
								if(ary7[i] == ary2[j]){
									flag = false;
								}
							}
						}
	 				}
	 			});
				
				//增加品名判断输入品名是否存在于其它品名系列里 取未归档增加品名数据
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158103ajaxaction.jsp",
	 				data: {type: 3, xzidh: zjidh},
	 				cache: false,
	 				type: "post",
	 				dataType: "text",
	 				async: false,
					success: function (result) {
						result = jQuery.trim(result);
						var ary8  = new Array();
						ary8 = result.split("<br>");
						for(var i = 0 ; i<ary8.length ; i++){
							for(var j = 0 ; j<ary2.length ; j++){
								if(ary8[i] == ary2[j]){
									flag = false;
								}
							}
						}
	 				}
	 			});
				
	 		}
	 		//升版卡控
	 		if(sblist != ""){
	 			jQuery.ajax({
	 				url: "/interface/cxylbsqb/TF158102ajaxaction.jsp",
	 				data: {type: 3,  sbidh: sbidh , sbbbh :sbbbh },
	 				cache: false,
	 				type: "post",
	 				dataType: "json",
	 				async: false,
	 				success: function (result) {
	 					if(result[0].no != "0"){
	 						flag = false;
	 					}
	 				}
	 			});
	 		}
	 		//品名转换
	 		if(sblist != ""){
	 			jQuery.ajax({
	 				url: "/interface/cxylbsqb/TF158102ajaxaction.jsp",
	 				data: {type: 4,  zhidh: zhidh , zhidbbh :zhidbbh },
	 				cache: false,
	 				type: "post",
	 				dataType: "json",
	 				async: false,
	 				success: function (result) {
	 					if(result[0].no != "0"){
	 						flag = false;
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
		var options1=$("#field"+sfxjid+ " option:selected");//13942
		var sfxj = options1.val();//是否新建   0是  1否
		var cust_id = $("#field"+custidid).val();//14022
		var options2 = $("#field"+sfzjpmid+ " option:selected");//13943
		var sfzjpm = options2.val();//是否增加品名  0是   1否
		var options3 = $("#field"+sfsbid+ " option:selected");//14281
		var sfsb = options3.val();//是否升版  0是   1否
		var options4 = $("#field"+sfpmzhid+ " option:selected");//14321
		var sfzh = options4.val();//是否转换  0是   1否
		var str = "";
		var str1 = "0000";
		
		if(sfxj == "0"){//新建
			jQuery.ajax({
				url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
				data: {type: 1, custidid: cust_id},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					str = str1 + (parseInt(result[0].no)+1);
					$("#field"+xzsqidhid).val(cust_id+str.substr(str.length-4));//13946
					$("#field"+xzbbhid).val(1);//13947
				}
			});
			document.getElementById("field"+xzsqidhid).readOnly=true;
			document.getElementById("field"+xzbbhid).readOnly=true;
		}
		if(sfzjpm == "0"){//增加品名
			//增加品名输入ID
			$("#field"+zjpmsridid).blur(function(){
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
					data: {type: 2, zjpmsrid: $("#field"+zjpmsridid).val()},
					cache: false,
					type: "post",
					dataType: "json",
					async: false,
					success: function (result) {
						var zjpmbbh =  parseInt(result[0].dqidbbh)+1;
						$("#field"+zjpmbbhid).val(zjpmbbh);//自动生成增加品名版本号 13950
					
						document.getElementById("field"+zjpmbbhid).readOnly=true;//13950
					}
				});
			//增加品名带出历史附件
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
					data: {type: 3, zjpmsrid: $("#field"+zjpmsridid).val()},
					cache: false,
					type: "post",
					dataType: "json",
					async: false,
					success: function (result) {
						$("span:contains('历史附件')").parent().parent().next().children("div").empty();
						$("span:contains('历史附件')").parent().parent().next().children("div").append('<div><a style="cursor: pointer; color: rgb(139, 139, 139) !important; text-decoration: none !important;" onmouseover="changefileaon(this)" onmouseout="changefileaout(this)" onclick="addDocReadTag('+result[0].docid+');openDocExt('+result[0].docid+','+result[0].versionid+','+result[0].imagefileid+',0)" title="'+result[0].imagefilename+'">'+result[0].imagefilename+'</a>&nbsp;&nbsp;&nbsp;<a style="display:inline-block;cursor:pointer;vertical-align:middle;width:20px;height:20px;background-image:url('+"/images/ecology8/workflow/fileupload/upload_wev8.png"+');" onclick="addDocReadTag('+result[0].docid+');downloads('+result[0].imagefileid+')" title="下载"></a></div>');
					}
				});
			});
		}
		if(sfsb == "0"){//升版
			//升版ID号
			$("#field"+sbidhid).blur(function(){
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
					data: {type: 2, zjpmsrid: $("#field"+sbidhid).val()},
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
					url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
					data: {type: 3, zjpmsrid: $("#field"+sbidhid).val()},
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
					url: "/interface/cxylbsqb/TF158104ajaxaction.jsp",
					data: {type: 1, zjpmsrid: $("#field"+sbidhid).val()},
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
		if(sfzh == "0"){//转换品名
			$("#field"+zhidhid).blur(function(){
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
					data: {type: 2, zjpmsrid: $("#field"+zhidhid).val()},
					cache: false,
					type: "post",
					dataType: "json",
					async: false,
					success: function (result) {
						var zhidbbh =  parseInt(result[0].dqidbbh)+1;
						$("#field"+zhidbbhid).val(zhidbbh);//自动生成转换后ID版本号 14323

						document.getElementById("field"+zhidbbhid).readOnly=true;//14323
					}
				});
				//转换品名带出历史附件
				jQuery.ajax({
					url: "/interface/cxylbsqb/TF158101ajaxaction.jsp",
					data: {type: 3, zjpmsrid: $("#field"+zhidhid).val()},
					cache: false,
					type: "post",
					dataType: "json",
					async: false,
					success: function (result) {
						$("span:contains('历史附件')").parent().parent().next().children("div").empty();
						$("span:contains('历史附件')").parent().parent().next().children("div").append('<div><a style="cursor: pointer; color: rgb(139, 139, 139) !important; text-decoration: none !important;" onmouseover="changefileaon(this)" onmouseout="changefileaout(this)" onclick="addDocReadTag('+result[0].docid+');openDocExt('+result[0].docid+','+result[0].versionid+','+result[0].imagefileid+',0)" title="'+result[0].imagefilename+'">'+result[0].imagefilename+'</a>&nbsp;&nbsp;&nbsp;<a style="display:inline-block;cursor:pointer;vertical-align:middle;width:20px;height:20px;background-image:url('+"/images/ecology8/workflow/fileupload/upload_wev8.png"+');" onclick="addDocReadTag('+result[0].docid+');downloads('+result[0].imagefileid+')" title="下载"></a></div>');
					}
				});
			});
		}
	}

	function init(){
		$("#field"+xzsqidhid).val("");
		document.getElementById("field"+xzsqidhid).readOnly=false;
		$("#field"+xzbbhid).val("");
		document.getElementById("field"+xzbbhid).readOnly=false;
		$("#field"+xzdypmlistid).val("");
		document.getElementById("field"+xzdypmlistid).readOnly=false;
		$("#field"+zjpmsridid).val("");
		document.getElementById("field"+zjpmsridid).readOnly=false;
		$("#field"+zjpmbbhid).val("");
		document.getElementById("field"+zjpmbbhid).readOnly=false;
		$("#field"+zjpmdylistid).val("");
		document.getElementById("field"+zjpmdylistid).readOnly=false;
		$("#field"+sbidhid).val("");
		document.getElementById("field"+sbidhid).readOnly=false;
		$("#field"+sbidbbhid).val("");
		document.getElementById("field"+sbidbbhid).readOnly=false;
		$("#field"+sbdypmlistid).val("");
		document.getElementById("field"+sbdypmlistid).readOnly=false;
		$("#field"+zhidhid).val("");
		document.getElementById("field"+zhidhid).readOnly=false;
		$("#field"+zhidbbhid).val("");
		document.getElementById("field"+zhidbbhid).readOnly=false;
		$("#field"+zhpmdypmlistid).val("");
		document.getElementById("field"+zhpmdypmlistid).readOnly=false;
		$("span:contains('历史附件')").parent().parent().next().children("div").empty();
		$("#field"+bzxxid).val("");
		$(".progressWrapper").remove();
		
	}

</script> 
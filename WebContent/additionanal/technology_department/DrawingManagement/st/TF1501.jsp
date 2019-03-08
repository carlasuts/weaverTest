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

String ytzbhid = BillUtil.getLabelId(formid,0,"ytzbh");//14022  品名系列
//新制升版
String xzsbid = BillUtil.getLabelId(formid,0,"xzsb");
//图纸类型
String tzlxid = BillUtil.getLabelId(formid,0,"tzlx");
//图纸编号
String tzbhid = BillUtil.getLabelId(formid,0,"tzbh");
//生产类型
String proctypeid = BillUtil.getLabelId(formid,0,"proctype");
//客户号
String custid_id = BillUtil.getLabelId(formid,0,"CUSTID");
//图纸版本
String tzbbid = BillUtil.getLabelId(formid,0,"tzbb");
//封装外形大类
String pkgid = BillUtil.getLabelId(formid,0,"pkg");
//供应商代号
String gysdhid = BillUtil.getLabelId(formid,0,"gysdh");

int node031 = BillUtil.getNodeId(workflowid, "03.1 升版，上传图纸");//3361
int node01 = BillUtil.getNodeId(workflowid, "01 申请");//3141
%>
<script type="text/javascript">
	var xzsbid = <%=xzsbid%>
	var tzlxid = <%=tzlxid%>
	var tzbhid = <%=tzbhid%>
	var proctypeid = <%=proctypeid%>
	var custid_id = <%=custid_id%>
	var tzbbid = <%=tzbbid%>
	var pkgid = <%=pkgid%>
	var gysdhid = <%=gysdhid%>
	var requestid = <%=requestid%>
jQuery(function () {
	var ytzbh = '';
	<%if(nodeid == node01){%>
		var htmlAssetsButton ='<input id="assetsbtn" type="button" value="生成编号"/>'
		jQuery("#field" + xzsbid).parent().append(htmlAssetsButton);
		jQuery("#assetsbtn").click(function(){
			if($("#field"+ xzsbid +" option:selected").val() == "0"){
				doadd();
			}
		});
		/*//新制/升版
		$("#field" + xzsbid).bindPropertyChange(function(){
			doadd();
		});
		//图纸类型   
		$("#field" + tzlxid).bindPropertyChange(function(e){
			if(e.value != "0" || e.value !="1"){
				$("#field" + tzbhid).val("");
				document.getElementById("field" + tzbhid).readOnly=false;
			}
			doadd();
		});
		//生产类型  
		$("#field" + proctypeid).bindPropertyChange(function(){
			doadd();
		});
		//客户号
		$("#field" + custid_id).bindPropertyChange(function(){
			doadd();
		});*/
		//创建节点提交卡控 判断该图纸类型以及其对于编号是否已经存在
		/* checkCustomize = function() {
 			var flag = true;
 			var options2=$("#field"+tzlxid+" option:selected");
 			var tzlx1 = options2.val();//图纸类型    0配线图   1打印图    2框架图   3产品图   4包装材料图纸  5制造图  6基板图
 			var tzbh = $("#field" + tzbhid).val();
 			var tzbb = $("#field" + tzbbid).val();
 			
 			jQuery.ajax({
 				url: "/interface/additional/technology_department/DrawingManagement/st/TF150101ajaxaction.jsp",
				data: {type: 2, tzlx1: tzlx1 , tzbh :tzbh , tzbb: tzbb , requestid: requestid},
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
 			
 			if (flag == false)
 			{
 				alert("该图纸编号版本已存在");
 			}
 			return flag;
		} */
	<%}%>
	var ytzbhid = <%=ytzbhid%>
	<%if(nodeid == node031){%>//升版上传图纸03.1 带出历史附件
	  	ytzbh = $("#field" + ytzbhid).val();
		jQuery.ajax({
			url: "/interface/additional/technology_department/DrawingManagement/st/TF150101ajaxaction.jsp",
			data: {type: 3, ytzbh: ytzbh},
			cache: false,
			type: "post",
			dataType: "json",
			async: false,
			success: function (result) {
				$("span:contains('原CAD格式图纸')").parent().parent().next().children("div").append('<div><a style="cursor: pointer; color: rgb(139, 139, 139) !important; text-decoration: none !important;" onmouseover="changefileaon(this)" onmouseout="changefileaout(this)" onclick="addDocReadTag('+result[0].docid+');openDocExt('+result[0].docid+','+result[0].versionid+','+result[0].imagefileid+',0)" title="'+result[0].imagefilename+'">'+result[0].imagefilename+'</a>&nbsp;&nbsp;&nbsp;<a style="display:inline-block;cursor:pointer;vertical-align:middle;width:20px;height:20px;background-image:url('+"/images/ecology8/workflow/fileupload/upload_wev8.png"+');" onclick="addDocReadTag('+result[0].docid+');downloads('+result[0].imagefileid+')" title="下载"></a></div>');
			}
		});
		jQuery.ajax({
			url: "/interface/additional/technology_department/DrawingManagement/st/TF150101ajaxaction.jsp",
			data: {type: 4, ytzbh: ytzbh},
			cache: false,
			type: "post",
			dataType: "json",
			async: false,
			success: function (result) {
				$("span:contains('原图纸资料')").parent().parent().next().children("div").append('<div><a style="cursor: pointer; color: rgb(139, 139, 139) !important; text-decoration: none !important;" onmouseover="changefileaon(this)" onmouseout="changefileaout(this)" onclick="addDocReadTag('+result[0].docid+');openDocExt('+result[0].docid+','+result[0].versionid+','+result[0].imagefileid+',0)" title="'+result[0].imagefilename+'">'+result[0].imagefilename+'</a>&nbsp;&nbsp;&nbsp;<a style="display:inline-block;cursor:pointer;vertical-align:middle;width:20px;height:20px;background-image:url('+"/images/ecology8/workflow/fileupload/upload_wev8.png"+');" onclick="addDocReadTag('+result[0].docid+');downloads('+result[0].imagefileid+')" title="下载"></a></div>');
			}
		});
	<%}%>
	
});

//图纸类型为打印图、配线图,新制/升版为新制时, 根据  生产类型  客户号 自动生成图纸编号
function doadd(){
	var options4=$("#field"+xzsbid+" option:selected");
	var xzsb1 = options4.val();//新制/升版  0新制  1升版
	if(xzsb1 == "0")
	{	
		var options2=$("#field"+tzlxid+" option:selected");
		var tzlx1 = options2.val();//图纸类型    0配线图   1打印图    2框架图   3产品图   4包装材料图纸  5制造图  6基板图
		
		var options3=$("#field"+ proctypeid +" option:selected");
		var sclx1 = options3.val();//生产类型    0试流   1考核  2量产
		
		var options4=$("#field"+xzsbid+" option:selected");
		var xzsb1 = options4.val();//新制/升版  0新制  1升版
		
		var khh =  $("#field" + custid_id).val();//客户号
		var fzwx = $("#field"+ pkgid).val();//封装外形大类
		var gysdh = $("#field" + gysdhid).val();//供应商代号
		var str = "";
		var str2 = "5000";//合肥苏通
		var str4 = "8000";//合肥  158客户  配线打印
		if(tzlx1 =="0" ||tzlx1 == "1"){
			jQuery.ajax({
				url: "/interface/additional/technology_department/DrawingManagement/st/TF150101ajaxaction.jsp",
				data: {type: 1,tzlx1: tzlx1,sclx1: sclx1,xzsb1: xzsb1,khh:khh},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					if(khh == "158"){
						str = "";
						str = parseInt(str4)+ (parseInt(result[0].no)+1)+"";
					}else{
						str = "";
						str = parseInt(str2)+ (parseInt(result[0].no)+1)+"";
					}
					//配线图
					if(tzlx1 == "0"){
						if(sclx1 =="0" || sclx1 =="1"){//试流,考核
							$("#field" + tzbhid).val("BA-NF-S"+khh+str.substr(str.length-4));
							document.getElementById("field" + tzbhid).readOnly=true;
							/* if(cq1 == "0")
							{
								if(khh !="158"){
									$("#field13322").val("BA-NF-S"+khh+str.substr(str.length-3));
									document.getElementById("field13322").readOnly=true;
								}else{
									$("#field13322").val("BA-NF-S"+khh+str.substr(str.length-4));
									document.getElementById("field13322").readOnly=true;
								}

							}
							if(cq1 == "1" || cq1 == "2")
							{
								$("#field13322").val("BA-NF-S"+khh+str.substr(str.length-4));
								document.getElementById("field13322").readOnly=true;
							} */
						}else if(sclx1 =="2"){//量产
							$("#field" + tzbhid).val("BA-NF-"+khh+str.substr(str.length-4));
							document.getElementById("field" + tzbhid).readOnly=true;
							/* if(cq1 == "0")
							{
								if(khh != "158"){
									$("#field13322").val("BA-NF-"+khh+str.substr(str.length-3));
									document.getElementById("field13322").readOnly=true;
								}else{//158客户 取四位
									$("#field13322").val("BA-NF-"+khh+str.substr(str.length-4));
									document.getElementById("field13322").readOnly=true;
								} 

							}
							if(cq1 == "1" || cq1 == "2")
							{
								$("#field13322").val("BA-NF-"+khh+str.substr(str.length-4));
								document.getElementById("field13322").readOnly=true;
							} */
						}
					}
					
					//打印图
					if(tzlx1 == "1"){
						if(sclx1 =="0" || sclx1 =="1"){//试流,考核
							$("#field" + tzbhid).val("BB-KK-S"+khh+str.substr(str.length-4));
							document.getElementById("field" + tzbhid).readOnly=true;
							/* if(cq1 == "0")
							{
								 if(khh !="158"){
									$("#field13322").val("BB-KK-S"+khh+str.substr(str.length-3));
									document.getElementById("field13322").readOnly=true;
								}else{
									$("#field13322").val("BB-KK-S"+khh+str.substr(str.length-4));
									document.getElementById("field13322").readOnly=true;
								} 

							}
							if(cq1 == "1" || cq1 == "2")
							{
								$("#field13322").val("BB-KK-S"+khh+str.substr(str.length-4));
								document.getElementById("field13322").readOnly=true;
							} */
						}else if(sclx1 =="2"){//量产
							$("#field" + tzbhid).val("BB-KK-"+khh+str.substr(str.length-4));
							document.getElementById("field" + tzbhid).readOnly=true;
							/* if(cq1 == "0")
							{
								if(khh != "158"){
									$("#field13322").val("BB-KK-"+khh+str.substr(str.length-3));
									document.getElementById("field13322").readOnly=true;
								}else{
									$("#field13322").val("BB-KK-"+khh+str.substr(str.length-4));
									document.getElementById("field13322").readOnly=true;
								}

							}
							if(cq1 == "1" || cq1 == "2")
							{
								$("#field13322").val("BB-KK-"+khh+str.substr(str.length-4));
								document.getElementById("field13322").readOnly=true;
							} */
						}
					}
					
				}
			});
		}
		/*
		//框架图
		if(tzlx1 == "2"){
			jQuery.ajax({
				url: "/interface/jstzglsp/TF150102ajaxaction.jsp",
				data: {type: 1,fzwx :fzwx,gysdh :gysdh},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					str = str1 + (parseInt(result[0].no)+1);
					$("#field13322").val(fzwx+"-LFM-"+gysdh+str.substr(str.length-3));
				}
			});
		}
		
		//产品图
		if(tzlx1 == "3"){
			jQuery.ajax({
				url: "/interface/jstzglsp/TF150103ajaxaction.jsp",
				data: {type: 1,fzwx :fzwx,tzlx1: tzlx1},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					str = str1 + (parseInt(result[0].no)+1);
					$("#field13322").val("NTG."+str.substr(str.length-3)+"."+fzwx+"-P");
				}
			});
		}
		//制造图
		if(tzlx1 == "5"){
			jQuery.ajax({
				url: "/interface/jstzglsp/TF150103ajaxaction.jsp",
				data: {type: 1,fzwx :fzwx,tzlx1: tzlx1},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					str = str1 + (parseInt(result[0].no)+1);
					$("#field13322").val("NTG."+str.substr(str.length-3)+"."+fzwx+"-M");
				}
			});
		}
		//包装材料图纸
		if(tzlx1 == "4"){
			jQuery.ajax({
				url: "/interface/jstzglsp/TF150104ajaxaction.jsp",
				data: {type: 1},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					str = str3 + (parseInt(result[0].no)+1);
					$("#field13322").val("NFME-"+str.substr(str.length-4));
				}
			});
		}
		//基板图
		if(tzlx1 == "6"){
			jQuery.ajax({
				url: "/interface/jstzglsp/TF150105ajaxaction.jsp",
				data: {type: 1,fzwx :fzwx,gysdh :gysdh},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					str = str1 + (parseInt(result[0].no)+1);
					$("#field13322").val(fzwx+"-SUB-"+gysdh+str.substr(str.length-3));
				}
			});
		}
		*/
	}
	else if(xzsb1 == "1"){
		$("#field"+ tzbhid).val("");
		document.getElementById("field" + tzbhid).readOnly=false;
	}
}

</script> 
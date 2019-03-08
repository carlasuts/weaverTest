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


String period = BillUtil.getLabelId(formid,0,"period");//期别
String cq = BillUtil.getLabelId(formid,0,"factory");//厂区
String sqr = BillUtil.getLabelId(formid,0,"applicant");//申请人
String shrid = BillUtil.getLabelId(formid,0,"reviewer");//审核人
String sqlxid = BillUtil.getLabelId(formid,0,"application_type");//申请类型
String custidid = BillUtil.getLabelId(formid,0,"cust_id");//客户号

String xzsqidhid = BillUtil.getLabelId(formid,0,"new_id");//新增申请ID号
String xzbbhid = BillUtil.getLabelId(formid,0,"new_id_v");//新增版本号

String sbidhid = BillUtil.getLabelId(formid,0,"lversion_id");//升版ID号
String sbidbbhid = BillUtil.getLabelId(formid,0,"lversion_id_v");//升版ID版本号

String zfidhid = BillUtil.getLabelId(formid,0,"invalid_id");//作废ID号
String zfidbbhid = BillUtil.getLabelId(formid,0,"invalid_id_v");//作废ID版本号

String bzxxid = BillUtil.getLabelId(formid,0,"mark");//  备注信息
String scwj = BillUtil.getLabelId(formid,0,"load_files");//上传文件
String load_time = BillUtil.getLabelId(formid,0,"load_time");//上传时间

String code = BillUtil.getLabelId(formid,0,"code");//code
String id_code = BillUtil.getLabelId(formid,0,"id_code");//id_code


//节点
int node01 = BillUtil.getNodeId(workflowid, "申请");//27341

int node0201 = BillUtil.getNodeId(workflowid, "新增主管审批");//27342
int node0202 = BillUtil.getNodeId(workflowid, "新增课长审批");//27343
int nodeG1 = BillUtil.getNodeId(workflowid, "新增归档");//27845

int node0301 = BillUtil.getNodeId(workflowid, "升版主管审批");//27841
int node0302 = BillUtil.getNodeId(workflowid, "升版课长审批");//27842
int nodeG2 = BillUtil.getNodeId(workflowid, "升版归档");//27846


int node0401 = BillUtil.getNodeId(workflowid, "作废主管审批");//27843
int node0402 = BillUtil.getNodeId(workflowid, "作废课长审批");//27844
int nodeG3 = BillUtil.getNodeId(workflowid, "作废归档");//27847



%>
<script type="text/javascript">
	
	var cq = <%=cq%>
	var sqr = <%=sqr%>
	var shrid = <%=shrid%>
	var sqlxid = <%=sqlxid%>
	var custidid = <%=custidid%>
	var xzsqidhid = <%=xzsqidhid%>
	var xzbbhid = <%=xzbbhid%>

	var sbidhid = <%=sbidhid%>
	var sbidbbhid = <%=sbidbbhid%>

	var zfidhid = <%=zfidhid%>
	var zfidbbhid = <%=zfidbbhid%>
	var bzxxid = <%=bzxxid%>
	var scwj = <%=scwj%>
	
	var code = <%=code%>
	var id_code = <%=id_code%>
	var period = <%=period%>



	jQuery(function () {
	
	
		<%if(nodeid ==node0401 || nodeid == node0402 || nodeid ==nodeG3){%>
		//作废带出附件
		var sbidbbh =  parseInt($("#field"+zfidbbhid).val());
			jQuery.ajax({
				
				url: "/interface/additional/packaging_management/packaging_management_03.jsp",
				data: {type: 3, idh: $("#field"+zfidhid).val().trim(),idhbb: now_bbhid},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					$("span:contains('历史附件')").parent().parent().next().children("div").empty();
					$("span:contains('历史附件')").parent().parent().next().children("div").append('<div><a style="cursor: pointer; color: rgb(139, 139, 139) !important; text-decoration: none !important;" onmouseover="changefileaon(this)" onmouseout="changefileaout(this)" onclick="addDocReadTag('+result[0].DOCID+');openDocExt('+result[0].DOCID+','+result[0].VERSIONID+','+result[0].IMAGEFILEID+',0)" title="'+result[0].IMAGEFILENAME+'">'+result[0].IMAGEFILENAME+'</a>&nbsp;&nbsp;&nbsp;<a style="display:inline-block;cursor:pointer;vertical-align:middle;width:20px;height:20px;background-image:url('+"/images/ecology8/workflow/fileupload/upload_wev8.png"+');" onclick="addDocReadTag('+result[0].DOCID+');downloads('+result[0].IMAGEFILEID+')" title="下载"></a></div>');
				}
			});
	 	<%}%>
		<%if(nodeid ==node0201 || nodeid == node0202 || nodeid ==nodeG1){%>
			//带出附件
			
			var now_bbhid =  parseInt($("#field"+xzbbhid).val())-1;
			$.ajax({
				
				url: "/interface/additional/packaging_management/packaging_management_02.jsp",
				data: {type: 3, idh: $("#field"+xzsqidhid).val().trim(),idhbb: now_bbhid},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					alert("cg");
					$("span:contains('历史附件')").parent().parent().next().children("div").empty();
					$("span:contains('历史附件')").parent().parent().next().children("div").append('<div><a style="cursor: pointer; color: rgb(139, 139, 139) !important; text-decoration: none !important;" onmouseover="changefileaon(this)" onmouseout="changefileaout(this)" onclick="addDocReadTag('+result[0].DOCID+');openDocExt('+result[0].DOCID+','+result[0].VERSIONID+','+result[0].IMAGEFILEID+',0)" title="'+result[0].IMAGEFILENAME+'">'+result[0].IMAGEFILENAME+'</a>&nbsp;&nbsp;&nbsp;<a style="display:inline-block;cursor:pointer;vertical-align:middle;width:20px;height:20px;background-image:url('+"/images/ecology8/workflow/fileupload/upload_wev8.png"+');" onclick="addDocReadTag('+result[0].DOCID+');downloads('+result[0].IMAGEFILEID+')" title="下载"></a></div>');
				}
			});
		<%}%>
	
	
	<%if(nodeid == node01){%>
	//根据申请人带出厂区
		jQuery.ajax({
			url: "/interface/additional/packaging_management/packaging_management_04.jsp",
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
		
		//客户号变化
		$("#field"+custidid).bindPropertyChange(function(){//14022
			doadd();

					
		});
		//申请类型变化
		$("#field"+sqlxid).bindPropertyChange(function(){//14022
			doadd();

					
		});
		//期别变化
		$("#field"+period).bindPropertyChange(function(){//14022
			doadd();
					
		});
		
		//升版id号焦点失去事件
		$("#field"+sbidhid).blur(function () {
			var now_bbhid ="";
			//带出版本
			jQuery.ajax({
				url: "/interface/additional/packaging_management/packaging_management_02.jsp",
				data: {type: 1, idh:$("#field"+sbidhid).val()  },
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					now_bbhid =result[0].CURRENTID_V;
					var sbidbbh =  parseInt(result[0].CURRENTID_V)+1;
					//$("#field"+sbidhid).val(result[0].CURRENTID);//升版ID号
					$("#field"+sbidbbhid).val(sbidbbh);//升版ID版本号
					$("#field"+id_code).val(result[0].ID_CODE);//ID编号
					$("#field"+code).val(result[0].CODE);//ID编号
				}
			});
			//带出附件
			jQuery.ajax({
				url: "/interface/additional/packaging_management/packaging_management_02.jsp",
				data: {type: 3, idh: $("#field"+sbidhid).val().trim(),idhbb: now_bbhid},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					$("span:contains('历史附件')").parent().parent().next().children("div").empty();
					$("span:contains('历史附件')").parent().parent().next().children("div").append('<div><a style="cursor: pointer; color: rgb(139, 139, 139) !important; text-decoration: none !important;" onmouseover="changefileaon(this)" onmouseout="changefileaout(this)" onclick="addDocReadTag('+result[0].DOCID+');openDocExt('+result[0].DOCID+','+result[0].VERSIONID+','+result[0].IMAGEFILEID+',0)" title="'+result[0].IMAGEFILENAME+'">'+result[0].IMAGEFILENAME+'</a>&nbsp;&nbsp;&nbsp;<a style="display:inline-block;cursor:pointer;vertical-align:middle;width:20px;height:20px;background-image:url('+"/images/ecology8/workflow/fileupload/upload_wev8.png"+');" onclick="addDocReadTag('+result[0].DOCID+');downloads('+result[0].IMAGEFILEID+')" title="下载"></a></div>');
				}
			});
			
			
		});
		
		
		//作废id号焦点失去事件
		$("#field"+zfidhid).blur(function () {
			//带出版本
			jQuery.ajax({
				url: "/interface/additional/packaging_management/packaging_management_03.jsp",
				data: {type: 1, idh:$("#field"+zfidhid).val()  },
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					//$("#field"+zfidhid).val(result[0].CURRENTID);//作废ID号
					$("#field"+zfidbbhid).val(result[0].CURRENTID_V);//作废ID号
					$("#field"+id_code).val(result[0].ID_CODE);//ID编号
					$("#field"+code).val(result[0].CODE);//ID编号
				}
			});
			//带出附件
			jQuery.ajax({
				url: "/interface/additional/packaging_management/packaging_management_03.jsp",
				data: {type: 3, idh: $("#field"+zfidhid).val().trim(),idhbb: $("#field"+zfidbbhid).val()},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					$("span:contains('历史附件')").parent().parent().next().children("div").empty();
					$("span:contains('历史附件')").parent().parent().next().children("div").append('<div><a style="cursor: pointer; color: rgb(139, 139, 139) !important; text-decoration: none !important;" onmouseover="changefileaon(this)" onmouseout="changefileaout(this)" onclick="addDocReadTag('+result[0].DOCID+');openDocExt('+result[0].DOCID+','+result[0].VERSIONID+','+result[0].IMAGEFILEID+',0)" title="'+result[0].IMAGEFILENAME+'">'+result[0].IMAGEFILENAME+'</a>&nbsp;&nbsp;&nbsp;<a style="display:inline-block;cursor:pointer;vertical-align:middle;width:20px;height:20px;background-image:url('+"/images/ecology8/workflow/fileupload/upload_wev8.png"+');" onclick="addDocReadTag('+result[0].DOCID+');downloads('+result[0].IMAGEFILEID+')" title="下载"></a></div>');
				}
			});
			
		});
		

		

		
		
		
	<%}%>
	});
	
	
	
	function doadd(){	
		var options1 = $("#field"+sqlxid+ " option:selected");
		var sqlx = options1.val();
		var cust_id = $("#field"+custidid).val();//14022
		var str = "";
		var str1 = "0000";
		var factory="";	
		var division ="";
		var code_desc =""; 
		
		if($("#field" + cq ).val() == "0"){
				factory = "CC";
				if($("#field" + period ).val() == "0"){
					division="T1";
				}else if($("#field" + period ).val() == "1"){
					division="T2";
				}else if($("#field" + period ).val() == "2"){
					division="TB";
				}else if($("#field" + period ).val() == "3"){
					division="T3";
				}
			}
				
			if($("#field" + cq ).val() == "1"){
				factory = "ST";
				division="ST";
			}
			if($("#field" + cq ).val() == "2"){
				factory = "HF";
				division = "HF"
			}
		code_desc =factory+cust_id+division;
		$("#field" + code ).val(code_desc);	
		
		if(sqlx == "0"){//新建
			jQuery.ajax({
				url: "/interface/additional/packaging_management/packaging_management_01.jsp",
				data: {type: 1, code_desc:code_desc },
				cache: false,
				type: "post",
				dataType: "text",
				async: false,
				success: function (sb) {
					$("#field"+xzsqidhid).val((code_desc+sb).trim());//新增申请ID号
					$("#field"+xzbbhid).val(1);//新增版本号
					$("#field"+id_code).val(sb);//ID编号
				}
			});	
		}
		
		//升版
		if(sqlx == "1"){
			$("#field"+sbidhid).val((code_desc).trim());//新增申请ID号
		}
		
		//作废
		if(sqlx == "2"){
			$("#field"+zfidhid).val((code_desc).trim());//新增申请ID号
		}

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
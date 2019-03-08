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

//获取节点ID
int nodeidA1 = BillUtil.getNodeId(workflowid, "AssyRouterHandler");
int nodeidRouterCopy = BillUtil.getNodeId(workflowid, "AssyRouterCopy");
int nodeidRouterAudit = BillUtil.getNodeId(workflowid, "AssyRouterAudit");
int nodeidDraft = BillUtil.getNodeId(workflowid, "Draft");
int nodeidA31 = BillUtil.getNodeId(workflowid, "AssyPackHandler");
int nodeidA32 = BillUtil.getNodeId(workflowid, "AssyWireBondHandler");
int nodeidA42 = BillUtil.getNodeId(workflowid, "AssyWireBondAudit");
int nodeidA34 = BillUtil.getNodeId(workflowid, "AssyTechHandler");
int nodeidA41 = BillUtil.getNodeId(workflowid, "AssyPackAudit");
int nodeidA6 = BillUtil.getNodeId(workflowid, "AssyPrencheck");
int nodeidAgd = BillUtil.getNodeId(workflowid, "归档");
int nodeidA35 = BillUtil.getNodeId(workflowid, "AssyWorkCenterHandler");
int nodeidA5 = BillUtil.getNodeId(workflowid, "AssyUPHHandler");

int nodeidT1 = BillUtil.getNodeId(workflowid, "T1-TestRouterHandler");
int TestRouterCopy = BillUtil.getNodeId(workflowid, "TestRouterCopy");
int nodeidT4 = BillUtil.getNodeId(workflowid, "T4-TestAudit");
int nodeidT2 = BillUtil.getNodeId(workflowid, "T2-TestRouterAudit");
int nodeidT31 = BillUtil.getNodeId(workflowid, "T3-1-TestUPHHandler");
int nodeidT32 = BillUtil.getNodeId(workflowid, "T3-2-TestBomHandler");


//主表

//标准工艺路线
String bzgylx = BillUtil.getLabelId(formid,0,"StandardRouter");
//封装外形
String fzwx1 = BillUtil.getLabelId(formid,0,"PackageOutline");
//客户号
String Customer = BillUtil.getLabelId(formid,0,"Customer");
//品名描述1
String pmms1 = BillUtil.getLabelId(formid,0,"CustomerMtrlDescription");
//工艺路线表头描述
String ms_description = BillUtil.getLabelId(formid,0,"DESCRIPTION");
//批数量
String psl_lotsize = BillUtil.getLabelId(formid,0,"LotSize");
//品名描述2 
String pmms2 = BillUtil.getLabelId(formid,0,"CustomerMtrlDescription1");
//产品物料号1
String cpwlh1 = BillUtil.getLabelId(formid,0,"ProductMaterialCode");
//工厂1
String gc1 = BillUtil.getLabelId(formid,0,"Plant");
//生产类型
String sclx1 = BillUtil.getLabelId(formid,0,"ProduceType");
//TestTime
String cssj1 = BillUtil.getLabelId(formid,0,"TestTime");
//SiteQty
String sq_siteqty = BillUtil.getLabelId(formid,0,"SiteQty");
//IndexTime
String kssj1 = BillUtil.getLabelId(formid,0,"IndexTime");
//客户品名
String khpm1 = BillUtil.getLabelId(formid,0,"AssyCustomerMtrlCode");
//打印内容要求
String dynryq1 = BillUtil.getLabelId(formid,0,"MarkRemark");
//测试机
String Tester = BillUtil.getLabelId(formid,0,"Tester");
//测试流程
String TestFlow = BillUtil.getLabelId(formid,0,"TestFlow");
//包装方式
String PackageType = BillUtil.getLabelId(formid,0,"PackageType");
//是否拷贝其他品名
String ifcopy = BillUtil.getLabelId(formid,0,"ifcopy");

//明细1

//芯片料号
String xp_xplh = BillUtil.getLabelId(formid,1,"DIEMATERIALCODE");
//芯片品名
String xp_xppm = BillUtil.getLabelId(formid,1,"DIEMATERIALDESCRIPTION");
//X
String xp_chipsizex = BillUtil.getLabelId(formid,1,"CHIPSIZEX");
//Y
String xp_chipsizey = BillUtil.getLabelId(formid,1,"CHIPSIZEY");
//是否主芯片
String xp_mainchip = BillUtil.getLabelId(formid,1,"MAINCHIP");
//芯片数量
String xp_chipqty = BillUtil.getLabelId(formid,1,"CHIPQTY");
//芯片单位
String xp_dw = BillUtil.getLabelId(formid,1,"UNIT");
//圆片尺寸
String xp_ypcc = BillUtil.getLabelId(formid,1,"WaferSize");
//物料组
String xp_wlz = BillUtil.getLabelId(formid,1,"MATERIALGROUP");

//明细2

//项目号
String gylx_xmh = BillUtil.getLabelId(formid,2,"ITEMNO");
//工序
String gylx_oper = BillUtil.getLabelId(formid,2,"operadd");
//工序描述
String gylx_operdesc = BillUtil.getLabelId(formid,2,"operdec");
//设备组
String gylx_sbz = BillUtil.getLabelId(formid,2,"RESG_ID");
//工作中心
String gylx_WORK_CENTER_FK = BillUtil.getLabelId(formid,2,"WORK_CENTER_FK");
//UPH
String gylx_uph = BillUtil.getLabelId(formid,2,"UPH");
//备注
String gylx_bz = BillUtil.getLabelId(formid,2,"Comment1");

//明细3

//A6 工序项目号
String wlqd_gxxmh_a6 = BillUtil.getLabelId(formid,3,"OPERITEMNO");
//A31 工序项目号
String wlqd_gxxmh_a31 = BillUtil.getLabelId(formid,3,"OPERITEMNO_PACK");
//A32 工序项目号
String wlqd_gxxmh_a32 = BillUtil.getLabelId(formid,3,"OPERITEMNO_WIRE");
//A34 工序项目号
String wlqd_gxxmh_a34 = BillUtil.getLabelId(formid,3,"OPERITEMNO_TECH");
//组件
String wlqd_dinrk = BillUtil.getLabelId(formid,3,"IDNRK");
//材料名称
String wlqd_invname = BillUtil.getLabelId(formid,3,"INVNAME");
//组件数量
String wlqd_zjsl = BillUtil.getLabelId(formid,3,"MENGE1");
//工序描述
String wlqd_operdesc = BillUtil.getLabelId(formid,3,"OPERDESC");
//工序
String wlqd_oper = BillUtil.getLabelId(formid,3,"OPER");
//仓储地点
String wlqd_ccdd = BillUtil.getLabelId(formid,3,"LGORT");
//组件计量单位
String wlqd_dw = BillUtil.getLabelId(formid,3,"MEINS");
//替代组
String wlqd_tdz = BillUtil.getLabelId(formid,3,"ALPGR");


%>
<script type="text/javascript">
	var mxid=0;
	var requestid = <%=requestid%>
	//节点ID
	var nodeidA1 = <%=nodeidA1%>
	var nodeidRouterCopy = <%=nodeidRouterCopy%>
	var nodeidRouterAudit = <%=nodeidRouterAudit%>
	var nodeidDraft = <%=nodeidDraft%>
	var nodeidA31 = <%=nodeidA31%>
	var nodeidA32 = <%=nodeidA32%>
	var nodeidA42 = <%=nodeidA42%>
	var nodeidA34 = <%=nodeidA34%>
	var nodeidA41 = <%=nodeidA41%>
	var nodeidA6 = <%=nodeidA6%>
	var nodeidAgd = <%=nodeidAgd%>
	var nodeidA35 = <%=nodeidA35%>
	var nodeidA5 = <%=nodeidA5%>
	
	var nodeidT1 = <%=nodeidT1%>
	var TestRouterCopy = <%=TestRouterCopy%>
	var nodeidT4 = <%=nodeidT4%>
	var nodeidT2 = <%=nodeidT2%>
	var nodeidT31 = <%=nodeidT31%>
	var nodeidT32 = <%=nodeidT32%>
	
	//主表
	var bzgylx = <%=bzgylx%>
	var fzwx1 = <%=fzwx1%>
	var Customer = <%=Customer%>
	var pmms1 = <%=pmms1%>
	var ms_description = <%=ms_description%>
	var psl_lotsize = <%=psl_lotsize%>
	var pmms2 = <%=pmms2%>
	var cpwlh1 = <%=cpwlh1%>
	var gc1 = <%=gc1%>
	var sclx1 = <%=sclx1%>
	var cssj1 = <%=cssj1%>
	var sq_siteqty = <%=sq_siteqty%>
	var kssj1 = <%=kssj1%>
	var khpm1 = <%=khpm1%>
	var dynryq1 = <%=dynryq1%>
	var Tester = <%=Tester%>
	var TestFlow = <%=TestFlow%>
	var PackageType = <%=PackageType%>
	var ifcopy = <%=ifcopy%>
	
	//明细1
	var xp_xplh = <%=xp_xplh%>
	var xp_xppm = <%=xp_xppm%>
	var xp_chipsizex = <%=xp_chipsizex%>
	var xp_chipsizey = <%=xp_chipsizey%>
	var xp_mainchip = <%=xp_mainchip%>
	var xp_chipqty = <%=xp_chipqty%>
	var xp_dw = <%=xp_dw%>
	var xp_ypcc = <%=xp_ypcc%>
	var xp_wlz = <%=xp_wlz%>
	
	//明细2
	var gylx_xmh = <%=gylx_xmh%>
	var gylx_oper = <%=gylx_oper%>
	var gylx_operdesc = <%=gylx_operdesc%>
	var gylx_sbz = <%=gylx_sbz%>
	var gylx_WORK_CENTER_FK = <%=gylx_WORK_CENTER_FK%>
	var gylx_uph = <%=gylx_uph%>
	var gylx_bz = <%=gylx_bz%>
	
	//明细3
	var wlqd_gxxmh_a6 = <%=wlqd_gxxmh_a6%>
	var wlqd_gxxmh_a31 = <%=wlqd_gxxmh_a31%>
	var wlqd_gxxmh_a32 = <%=wlqd_gxxmh_a32%>
	var wlqd_gxxmh_a34 = <%=wlqd_gxxmh_a34%>
	var wlqd_dinrk = <%=wlqd_dinrk%>
	var wlqd_invname = <%=wlqd_invname%>
	var wlqd_zjsl = <%=wlqd_zjsl%>
	var wlqd_operdesc = <%=wlqd_operdesc%>
	var wlqd_oper = <%=wlqd_oper%>
	var wlqd_ccdd = <%=wlqd_ccdd%>
	var wlqd_dw = <%=wlqd_dw%>
	var wlqd_tdz = <%=wlqd_tdz%>
	
 jQuery(function () { 
 	<%if(nodeid == nodeidRouterAudit) {%>
		dobackground();
	<%}%>
//下拉框取值
<%if( nodeid == nodeidA31 || nodeid == nodeidA32 ||nodeid == nodeidA34 ){%>
setCover(PackageType);
setCover(sclx1);
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
<%}%>

 //根据标准工艺路线带出明细信息
	 $("#field"+bzgylx).bindPropertyChange(function(){
		 delRowmx(0);
		 var gx = '';
		 jQuery.ajax({
			 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF1186ajaxaction.jsp",
			 data: {type: 1, gylxdm: $("#field"+ bzgylx).val()},
			 cache: false,
			 type: "post",
			 dataType: "json",
			 success: function (result) {
				 var checkboxs = jQuery("input[name='check_node_1']");
				 jQuery("input[id*='field"+ gylx_xmh +"_']").each(function(index) {
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
					
					$("#field"+ gylx_xmh +"_"+mxid).val(result[i].item_no);
					$("#field"+ gylx_oper +"_"+mxid).val(result[i].oper_fk);
					$("#field"+ gylx_oper +"_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + result[i].oper_fk + '</a>&nbsp;<span class="e8_delClass" id="'+result[i].oper_fk+'">&nbsp;&nbsp;</span></span>');
					$("#field"+ gylx_operdesc +"_"+mxid).val(result[i].oper_desc);
					
					//带出信息不可编辑
					document.getElementById("field"+ gylx_xmh + "_"+mxid).readOnly=true;
					document.getElementById("field"+ gylx_oper +"_"+mxid).readOnly=true;
					document.getElementById("field"+ gylx_oper +"_"+mxid+"_browserbtn").disabled=true;
					document.getElementById("field"+ gylx_operdesc +"_"+mxid).readOnly=true;

					//根据工序封装外形带出设备组
					//主流程带出设备组 A1 2353
					<%if(nodeid == nodeidA1 || nodeid == nodeidRouterCopy ){%>
						var fzwx = $("#field"+ fzwx1).val();
						var khh =  $("#field"+ Customer).val();
						gx = result[i].oper_fk;
						jQuery.ajax({
							 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118607ajaxaction.jsp",
							 data: {type: 1, fzwx: fzwx,gx: gx,khh: khh},
							 cache: false,
							 type: "post",
							 dataType: "json",
							 async: false,
							 success: function (result) {
								 if(result[0].resg_id != ''){
									 $("#field"+ gylx_sbz +"_"+mxid).val(result[0].resg_id);
									 $("#field"+ gylx_sbz +"_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + result[0].resg_id + '</a>&nbsp;<span class="e8_delClass" id="'+result[0].resg_id+'">&nbsp;&nbsp;</span></span>');
									 document.getElementById("field"+ gylx_sbz +"_"+mxid).readOnly=true;
									 document.getElementById("field"+ gylx_sbz +"_"+mxid+"_browserbtn").disabled=true;	
								 }
							 }
						});
					<%}%> 
					//T1 带出工作中心 
					<%if(nodeid == nodeidT1 || nodeid == TestRouterCopy){%>
						var fzwx = $("#field"+ fzwx1).val();
						gx = result[i].oper_fk;
						gxms = gx;
						//带出工作中心 T1
						jQuery.ajax({
							url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118605ajaxaction.jsp",
							data: {type: 1, fzwx: fzwx,gxms: gxms},
							cache: false,
							type: "post",
							dataType: "json",
							async: false,
							success: function (result) {
								if(result[0].WORK_CENTER_FK != ""){
									$("#field"+ gylx_WORK_CENTER_FK +"_"+mxid).val(result[0].WORK_CENTER_FK);
									$("#field"+ gylx_WORK_CENTER_FK +"_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + result[0].WORK_CENTER_FK + '</a>&nbsp;<span class="e8_delClass" id="'+result[0].WORK_CENTER_FK+'">&nbsp;&nbsp;</span></span>');
									document.getElementById("field"+ gylx_WORK_CENTER_FK +"_"+mxid).readOnly=true;
									document.getElementById("field"+ gylx_WORK_CENTER_FK +"_"+mxid+"_browserbtn").disabled=true;	
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
			xzxmh = $("#field"+ gylx_xmh +"_"+checkid).val();
			$("input[id^=field"+ gylx_xmh +"_]").each(function(index) {
				if($(this).val()==''){
					$(this).val(xzxmh);
					dopx();
					jQuery("[name='check_node_1']").removeAttr("checked");
				}
			});
		}
	});
	
	//新增工序 
	$("input[id^=field"+ gylx_oper +"_]").bindPropertyChange(function(e){
	var lineNumber = e.id.slice(11);
	var gx = jQuery("#field"+ gylx_oper +"_" + lineNumber + "span > span > a").html();
		if(gx != ""){
			jQuery.ajax({
				url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118603ajaxaction.jsp",
				data: {type: 1, gylxdm: e.value},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					if(gx == "0010"){
						$("#field"+ gylx_operdesc +"_"+lineNumber).val("领芯片");
						document.getElementById("field"+ gylx_operdesc +"_"+lineNumber).readOnly=true;
						dopx();
					}else{
						$("#field"+ gylx_operdesc +"_"+lineNumber).val(result[0].oper_desc);
						document.getElementById("field"+ gylx_operdesc +"_"+lineNumber).readOnly=true;
					}
					
					//根据封装信息和工序带出设备组
					//主流程带出设备组
					<%if(nodeid == nodeidA1 || nodeid == nodeidRouterCopy){%>
						var fzwx = $("#field"+ fzwx1).val();
						var khh =  $("#field"+ Customer).val();
						jQuery.ajax({
							 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118607ajaxaction.jsp",
							 data: {type: 1, fzwx: fzwx,gx: gx,khh: khh},
							 cache: false,
							 type: "post",
							 dataType: "json",
							 async: false,
							 success: function (result) {
								 if(result[0].resg_id != ''){
									 $("#field"+ gylx_sbz +"_"+lineNumber).val(result[0].resg_id);
									 $("#field"+ gylx_sbz +"_"+lineNumber+"span").html('<span class="e8_showNameClass"><a>' + result[0].resg_id + '</a>&nbsp;<span class="e8_delClass" id="'+result[0].resg_id+'">&nbsp;&nbsp;</span></span>');
									 document.getElementById("field"+ gylx_sbz +"_"+lineNumber).readOnly=true;
									 document.getElementById("field"+ gylx_sbz +"_"+lineNumber+"_browserbtn").disabled=true;	
								 }
							 }
						});
					<%}%>
					//T1 带出工作中心
					<%if(nodeid == nodeidT1 || nodeid == TestRouterCopy){%>
					var fzwx = $("#field"+ fzwx1).val();
					gxms = gx;
					//带出工作中心
					jQuery.ajax({
						url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118605ajaxaction.jsp",
						data: {type: 1, fzwx: fzwx,gxms: gxms},
						cache: false,
						type: "post",
						dataType: "json",
						async: false,
						success: function (result) {
							if(result[0].WORK_CENTER_FK != ""){
								$("#field"+ gylx_WORK_CENTER_FK +"_"+lineNumber).val(result[0].WORK_CENTER_FK);
								$("#field"+ gylx_WORK_CENTER_FK +"_"+lineNumber+"span").html('<span class="e8_showNameClass"><a>' + result[0].WORK_CENTER_FK + '</a>&nbsp;<span class="e8_delClass" id="'+result[0].WORK_CENTER_FK+'">&nbsp;&nbsp;</span></span>');
								document.getElementById("field"+ gylx_WORK_CENTER_FK +"_"+lineNumber).readOnly=true;
								document.getElementById("field"+ gylx_WORK_CENTER_FK +"_"+lineNumber+"_browserbtn").disabled=true;	
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
	 $("input[id^=field"+ gylx_xmh +"_]").blur(function(e){
	 	dopx();
	 });
});
	

//删除 工艺路线明细后排序
$("button[name=delbutton1]").click(function(){
	dopx();
});

//芯片信息  根据芯片料号带出相关信息
//主数据申请A 2341  主数据申请T1 2453 
<%if(nodeid == nodeidDraft){%>
$("input[id^=field"+ xp_xplh +"_]").bindPropertyChange(function(e){
	jQuery.ajax({
		url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118602ajaxaction.jsp",
		data: {type: 1, gylxdm: e.value},
		cache: false,
		type: "post",
		dataType: "json",
		success: function (result) {
			var lineNumber = e.id.slice(11);
		 	$("#field"+ xp_xppm +"_"+lineNumber).val("");
		 	$("#field"+ xp_chipsizex +"_"+lineNumber).val("");
		 	$("#field"+ xp_chipsizey +"_"+lineNumber).val("");
			$("#field"+ xp_wlz +"_"+lineNumber).val(e.value.substring(0,4));
			if(result.length > 0 ){
			 	$("#field"+ xp_xppm +"_"+lineNumber).val(result[0].die_material_description);
			 	$("#field"+ xp_chipsizex +"_"+lineNumber).val(result[0].chip_sizeX);
			 	$("#field"+ xp_chipsizey +"_"+lineNumber).val(result[0].chip_sizeY);
			 	//去除带出信息必填标记
			 	$("#field"+ xp_xppm +"_"+lineNumber+"span").empty();
			 	$("#field"+ xp_wlz +"_"+lineNumber+"span").empty();
			}
			
		}
	});
});

var xpxxchecked = 1;//芯片信息是否主芯片
$("button[name=addbutton0]").click(function(){
	$("input[id^=field"+ xp_xplh +"_]").bindPropertyChange(function(e){
		jQuery.ajax({
			url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118602ajaxaction.jsp",
			data: {type: 1, gylxdm: e.value},
			cache: false,
			type: "post",
			dataType: "json",
			success: function (result) {
				var lineNumber = e.id.slice(11);
			 	$("#field"+ xp_xppm +"_"+lineNumber).val("");
			 	$("#field"+ xp_chipsizex +"_"+lineNumber).val("");
			 	$("#field"+ xp_chipsizey +"_"+lineNumber).val("");
				$("#field"+ xp_wlz +"_"+lineNumber).val(e.value.substring(0,4));
			 	$("#field"+ xp_xppm +"_"+lineNumber).val(result[0].die_material_description);
			 	$("#field"+ xp_chipsizex +"_"+lineNumber).val(result[0].chip_sizeX);
			 	$("#field"+ xp_chipsizey +"_"+lineNumber).val(result[0].chip_sizeY);
			 	
				//去除带出信息必填标记
			 	var span = document.getElementById("field"+ xp_chipsizex +"_"+lineNumber+"span");
				span.removeChild(span.firstChild);
				var span1 = document.getElementById("field"+ xp_chipsizey +"_"+lineNumber+"span");
				span1.removeChild(span1.firstChild);
				var span2 = document.getElementById("field"+ xp_xppm +"_"+lineNumber+"span");
				span2.removeChild(span2.firstChild);
			}
		});
	});
	
	//新增芯片信息明细默认不是主芯片
	jQuery("#field"+ xp_mainchip +"_" + xpxxchecked ).removeAttr("checked");
	xpxxchecked++;
});
<%}%>

//工序项目号带出组件和材料名称
//A6合并工序项目号  field11561_
//A3-2  工序项目号 field13002_
//A3-1  工序项目号 field13001_
//A3-4  工序项目号 field13003_
$("input[id^=field"+ wlqd_gxxmh_a6 +"_]").bindPropertyChange(function(e){
		var tmp = e.id.split("_")[1];
		var xmh1 = jQuery("#field"+ wlqd_gxxmh_a6 +"_" + tmp + "span > span > a").html();
		//新增工序项目号
	    $("input[id^=field"+ gylx_xmh +"_]").each(function(index) {
			var mxid = this.id.split("_")[1];
			if($("#field"+ gylx_xmh +"_"+mxid).val() == xmh1){
				$("#field"+ wlqd_operdesc +"_"+tmp).val($("#field"+ gylx_operdesc +"_"+mxid).val());
				$("#field"+ wlqd_oper +"_"+tmp).val($("#field"+ gylx_oper +"_"+mxid).val());
				$("#field"+ wlqd_operdesc +"_"+tmp).attr("readOnly","true");
				$("#field"+ wlqd_oper +"_"+tmp).attr("readOnly","true");
			} 
		}); 
	jQuery.ajax({
		 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118601ajaxaction.jsp",
		 data: {type: 1, gylxdm: e.value},
		 cache: false,
		 type: "post",
		 dataType: "json",
		 success: function (result) {
			 var lineNumber = e.id.slice(11);
			 $("#field"+ wlqd_dinrk +"_"+lineNumber).val(result[0].mat_id);
			 $("#field"+ wlqd_invname +"_"+lineNumber).val(result[0].mat_desc);
			 $("#field"+ wlqd_zjsl +"_"+lineNumber).val(result[0].qty_1);
			 if(result[0].storage_location.indexOf("_")>=0){
				 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location.split("_")[1]);
			 }else{
				 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location);
			 }
			 $("#field"+ wlqd_dw +"_"+lineNumber).val(result[0].MEASURE_UNIT_FK);
		 }
	});
	//将隐藏input的id改为页面显示值
	e.value = xmh1; 
});

$("input[id^=field"+ wlqd_gxxmh_a31 +"_]").bindPropertyChange(function(e){
		var tmp = e.id.split("_")[1];
		var xmh1 = jQuery("#field"+ wlqd_gxxmh_a31 +"_" + tmp + "span > span > a").html();
		//新增工序项目号
	    $("input[id^=field"+ gylx_xmh +"_]").each(function(index) {
			var mxid = this.id.split("_")[1];
			if($("#field"+ gylx_xmh +"_"+mxid).val() == xmh1){
				$("#field"+ wlqd_operdesc +"_"+tmp).val($("#field"+ gylx_operdesc +"_"+mxid).val());
				$("#field"+ wlqd_oper +"_"+tmp).val($("#field"+ gylx_oper +"_"+mxid).val());
				$("#field"+ wlqd_operdesc +"_"+tmp).attr("readOnly","true");
				$("#field"+ wlqd_oper +"_"+tmp).attr("readOnly","true");
			} 
		}); 
	jQuery.ajax({
		 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118601ajaxaction.jsp",
		 data: {type: 1, gylxdm: e.value},
		 cache: false,
		 type: "post",
		 dataType: "json",
		 success: function (result) {
			 var lineNumber = e.id.slice(11);
			 $("#field"+ wlqd_dinrk +"_"+lineNumber).val(result[0].mat_id);
			 $("#field"+ wlqd_invname +"_"+lineNumber).val(result[0].mat_desc);
			 $("#field"+ wlqd_zjsl +"_"+lineNumber).val(result[0].qty_1);
			 if(result[0].storage_location.indexOf("_")>=0){
				 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location.split("_")[1]);
			 }else{
				 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location);
			 }
			 $("#field"+ wlqd_dw +"_"+lineNumber).val(result[0].MEASURE_UNIT_FK);
		 }
	});
	//将隐藏input的id改为页面显示值
	e.value = xmh1; 
});
$("input[id^=field"+ wlqd_gxxmh_a32 +"_]").bindPropertyChange(function(e){
		var tmp = e.id.split("_")[1];
		var xmh1 = jQuery("#field"+ wlqd_gxxmh_a32 +"_" + tmp + "span > span > a").html();
		//新增工序项目号
	    $("input[id^=field"+ gylx_xmh +"_]").each(function(index) {
			var mxid = this.id.split("_")[1];
			if($("#field"+ gylx_xmh +"_"+mxid).val() == xmh1){
				$("#field"+ wlqd_operdesc +"_"+tmp).val($("#field"+ gylx_operdesc +"_"+mxid).val());
				$("#field"+ wlqd_oper +"_"+tmp).val($("#field"+ gylx_oper +"_"+mxid).val());
				$("#field"+ wlqd_operdesc +"_"+tmp).attr("readOnly","true");
				$("#field"+ wlqd_oper +"_"+tmp).attr("readOnly","true");
			} 
		}); 

	jQuery.ajax({
		 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118601ajaxaction.jsp",
		 data: {type: 1, gylxdm: e.value},
		 cache: false,
		 type: "post",
		 dataType: "json",
		 success: function (result) {
			 var lineNumber = e.id.slice(11);
			 $("#field"+ wlqd_dinrk +"_"+lineNumber).val(result[0].mat_id);
			 $("#field"+ wlqd_invname +"_"+lineNumber).val(result[0].mat_desc);
			 $("#field"+ wlqd_zjsl +"_"+lineNumber).val(result[0].qty_1);
			 if(result[0].storage_location.indexOf("_")>=0){
				 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location.split("_")[1]);
			 }else{
				 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location);
			 }
			 $("#field"+ wlqd_dw +"_"+lineNumber).val(result[0].MEASURE_UNIT_FK);
		 }
	});
	//将隐藏input的id改为页面显示值
	e.value = xmh1; 
});
$("input[id^=field"+ wlqd_gxxmh_a34 +"_]").bindPropertyChange(function(e){
		var tmp = e.id.split("_")[1];
		var xmh1 = jQuery("#field"+ wlqd_gxxmh_a34 +"_" + tmp + "span > span > a").html();
		//新增工序项目号
	    $("input[id^=field"+ gylx_xmh +"_]").each(function(index) {
			var mxid = this.id.split("_")[1];
			if($("#field"+ gylx_xmh +"_"+mxid).val() == xmh1){
				$("#field"+ wlqd_operdesc +"_"+tmp).val($("#field"+ gylx_operdesc +"_"+mxid).val());
				$("#field"+ wlqd_oper +"_"+tmp).val($("#field"+ gylx_oper +"_"+mxid).val());
				$("#field"+ wlqd_operdesc +"_"+tmp).attr("readOnly","true");
				$("#field"+ wlqd_oper +"_"+tmp).attr("readOnly","true");
			} 
		}); 
	jQuery.ajax({
		 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118601ajaxaction.jsp",
		 data: {type: 1, gylxdm: e.value},
		 cache: false,
		 type: "post",
		 dataType: "json",
		 success: function (result) {
			 var lineNumber = e.id.slice(11);
			 $("#field"+ wlqd_dinrk +"_"+lineNumber).val(result[0].mat_id);
			 $("#field"+ wlqd_invname +"_"+lineNumber).val(result[0].mat_desc);
			 $("#field"+ wlqd_zjsl +"_"+lineNumber).val(result[0].qty_1);
			 if(result[0].storage_location.indexOf("_")>=0){
				 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location.split("_")[1]);
			 }else{
				 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location);
			 }
			 $("#field"+ wlqd_dw +"_"+lineNumber).val(result[0].MEASURE_UNIT_FK);
		 }
	});
	//将隐藏input的id改为页面显示值
	e.value = xmh1; 
});

//新增物料清单明细
var array = [];
var array1 = [];
var array2 = [];
var array3 = [];
$("button[name=addbutton2]").click(function(){
	$("input[id^=field"+ wlqd_gxxmh_a6 +"_]").bindPropertyChange(function(e){
		var xmh = e.value;
		var tmp = e.id.split("_")[1];
		var xmh1 = jQuery("#field"+ wlqd_gxxmh_a6 +"_" + tmp + "span > span > a").html();
		var oper = '';
		var lastoper = '';
		var count = 0;
		var a = 0;

		//新增工序项目号
	    $("input[id^=field"+ gylx_xmh +"_]").each(function(index) {
			var mxid = this.id.split("_")[1];
			if($("#field"+ gylx_xmh +"_"+mxid).val() == xmh1){
				$("#field"+ wlqd_operdesc +"_"+tmp).val($("#field"+ gylx_operdesc +"_"+mxid).val());
				$("#field"+ wlqd_oper +"_"+tmp).val($("#field"+ gylx_oper +"_"+mxid).val());
				$("#field"+ wlqd_operdesc +"_"+tmp).attr("readOnly","true");
				$("#field"+ wlqd_oper +"_"+tmp).attr("readOnly","true");
/*				$("input[id^=field"+ wlqd_operdesc +"_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field"+ gylx_operdesc +"_"+mxid).val());
						$(this).attr("readOnly","true");
					}
				});
				$("input[id^=field"+ wlqd_oper +"_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field"+ gylx_oper +"_"+mxid).val());
						$(this).attr("readOnly","true");
					}
				});*/
			} 
		}); 
		
	    oper = $("#field"+ wlqd_oper +"_"+tmp).val();
		jQuery.ajax({
			 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118601ajaxaction.jsp",
			 data: {type: 1, gylxdm: xmh},
			 cache: false,
			 type: "post",
			 dataType: "json",
			 success: function (result) {
				 var lineNumber = e.id.slice(11);
				 result[0].mat_desc = result[0].mat_desc.replace("%22", "\"");
				 $("#field"+ wlqd_dinrk +"_"+lineNumber).val(result[0].mat_id);
				 $("#field"+ wlqd_invname +"_"+lineNumber).val(result[0].mat_desc);
				 $("#field"+ wlqd_zjsl +"_"+lineNumber).val(result[0].qty_1);
				 if(result[0].storage_location.indexOf("_")>=0){
					 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location.split("_")[1]);
				 }else{
					 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location);
				 }
				 $("#field"+ wlqd_dw +"_"+lineNumber).val(result[0].MEASURE_UNIT_FK);
				 //必须维护工序卡控
				 if(lastoper != oper){
					 jQuery.ajax({
						 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118610ajaxaction.jsp",
						// data: {type: 1,gylxdm: $("#field"+ bzgylx).val()},
						 data: {type: 1, requestid: requestid , formid: <%=formid%>},
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
					 lastoper = oper;
				 }

				 checkCustomize = function()
				 {
					 var flag = true;
					 if(a < count)
					 {
						 flag = false;
					 }else{
					 	 flag = true;
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
	
	
	$("input[id^=field"+ wlqd_gxxmh_a31 +"_]").bindPropertyChange(function(e){
		var xmh = e.value;
		var tmp = e.id.split("_")[1];
		var xmh1 = jQuery("#field"+ wlqd_gxxmh_a31 +"_" + tmp + "span > span > a").html();
		var oper = '';
		var lastoper = '';
		var count = 0 ;
		var a = 0;
		//新增工序项目号
	    $("input[id^=field"+ gylx_xmh +"_]").each(function(index) {
			var mxid = this.id.split("_")[1];
			if($("#field"+ gylx_xmh +"_"+mxid).val() == xmh1){
				$("#field"+ wlqd_operdesc +"_"+tmp).val($("#field"+ gylx_operdesc +"_"+mxid).val());
				$("#field"+ wlqd_oper +"_"+tmp).val($("#field"+ gylx_oper +"_"+mxid).val());
				$("#field"+ wlqd_operdesc +"_"+tmp).attr("readOnly","true");
				$("#field"+ wlqd_oper +"_"+tmp).attr("readOnly","true");
/*				$("input[id^=field"+ wlqd_operdesc +"_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field"+ gylx_operdesc +"_"+mxid).val());
						$(this).attr("readOnly","true");
					}
				});
				$("input[id^=field"+ wlqd_oper +"_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field"+ gylx_oper +"_"+mxid).val());
						$(this).attr("readOnly","true");
					}
				});*/
			} 
		});
		
		oper = $("#field"+ wlqd_oper +"_"+tmp).val();
		jQuery.ajax({
			 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118601ajaxaction.jsp",
			 data: {type: 1, gylxdm: xmh},
			 cache: false,
			 type: "post",
			 dataType: "json",
			 async: false,
			 success: function (result) {
				 var lineNumber = e.id.slice(11);
				 result[0].mat_desc = result[0].mat_desc.replace("%22", "\"");
				 $("#field"+ wlqd_dinrk +"_"+lineNumber).val(result[0].mat_id);
				 $("#field"+ wlqd_invname +"_"+lineNumber).val(result[0].mat_desc);
				 $("#field"+ wlqd_zjsl +"_"+lineNumber).val(result[0].qty_1);
				 if(result[0].storage_location.indexOf("_")>=0){
					 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location.split("_")[1]);
				 }else{
					 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location);
				 }
				 $("#field"+ wlqd_dw +"_"+lineNumber).val(result[0].MEASURE_UNIT_FK);
			 
				 //必须维护工序卡控
				 if(lastoper != oper){
					 jQuery.ajax({
						 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118609ajaxaction.jsp",
						 data: {type: 1, requestid: requestid , formid: <%=formid%>},
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
					 lastoper = oper;
				 }

				 checkCustomize = function()
				 {
				 	var options=$("#field"+ sclx1 +" option:selected");
					var sclx = options.text();//AO
					var options1=$("#field"+ PackageType +" option:selected");
					var PackageType = options1.text();//AO
					var flag = true;
					if(sclx == "AO" && PackageType == "散装-BULK"){
						flag = true;
					}else{
						 if(a < count)
						 {
							 flag = false;
						 }else{
						 	 flag = true;
						 }
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
	
	
	$("input[id^=field"+ wlqd_gxxmh_a32 +"_]").bindPropertyChange(function(e){
		var xmh = e.value;
		var tmp = e.id.split("_")[1];
		var xmh1 = jQuery("#field"+ wlqd_gxxmh_a32 +"_" + tmp + "span > span > a").html();
		var oper = '';
		var lastoper = '';
		var count = 0;
		var a = 0;
		//新增工序项目号
	    $("input[id^=field"+ gylx_xmh +"_]").each(function(index) {
			var mxid = this.id.split("_")[1];
			if($("#field"+ gylx_xmh +"_"+mxid).val() == xmh1){
				$("#field"+ wlqd_operdesc +"_"+tmp).val($("#field"+ gylx_operdesc +"_"+mxid).val());
				$("#field"+ wlqd_oper +"_"+tmp).val($("#field"+ gylx_oper +"_"+mxid).val());
				$("#field"+ wlqd_operdesc +"_"+tmp).attr("readOnly","true");
				$("#field"+ wlqd_oper +"_"+tmp).attr("readOnly","true");
/*				$("input[id^=field"+ wlqd_operdesc +"_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field"+ gylx_operdesc +"_"+mxid).val());
						$(this).attr("readOnly","true");
					}
				});
				$("input[id^=field"+ wlqd_oper +"_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field"+ gylx_oper +"_"+mxid).val());
						$(this).attr("readOnly","true");
					}
				});*/
			} 
		}); 
		
	    oper = $("#field"+ wlqd_oper +"_"+tmp).val();
		jQuery.ajax({
			 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118601ajaxaction.jsp",
			 data: {type: 1, gylxdm: xmh},
			 cache: false,
			 type: "post",
			 dataType: "json",
			 async: false,
			 success: function (result) {
				 var lineNumber = e.id.slice(11);
				 result[0].mat_desc = result[0].mat_desc.replace("%22", "\"");
				 $("#field"+ wlqd_dinrk +"_"+lineNumber).val(result[0].mat_id);
				 $("#field"+ wlqd_invname +"_"+lineNumber).val(result[0].mat_desc);
				 $("#field"+ wlqd_zjsl +"_"+lineNumber).val(result[0].qty_1);
				 if(result[0].storage_location.indexOf("_")>=0){
					 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location.split("_")[1]);
				 }else{
					 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location);
				 }
				 $("#field"+ wlqd_dw +"_"+lineNumber).val(result[0].MEASURE_UNIT_FK);
				 //必须维护工序卡控
				 if(lastoper != oper){
					 jQuery.ajax({
						 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118609ajaxaction.jsp",
						 data: {type: 1, requestid: requestid , formid: <%=formid%>},
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
					 lastoper = oper;
				 }

				 checkCustomize = function()
				 {
					 var flag = true;
					 if(a < count)
					 {
						 flag = false;
					 }else{
					 	 flag = true;
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
	
	
	$("input[id^=field"+ wlqd_gxxmh_a34 +"_]").bindPropertyChange(function(e){
		var xmh = e.value;
		var tmp = e.id.split("_")[1];
		var xmh1 = jQuery("#field"+ wlqd_gxxmh_a34 +"_" + tmp + "span > span > a").html();
		var oper = '';
		var lastoper = '';
		var count = 0;
		var a = 0;
		
		//新增工序项目号
	    $("input[id^=field"+ gylx_xmh +"_]").each(function(index) {
			var mxid = this.id.split("_")[1];
			if($("#field"+ gylx_xmh +"_"+mxid).val() == xmh1){
				$("#field"+ wlqd_operdesc +"_"+tmp).val($("#field"+ gylx_operdesc +"_"+mxid).val());
				$("#field"+ wlqd_oper +"_"+tmp).val($("#field"+ gylx_oper +"_"+mxid).val());
				$("#field"+ wlqd_operdesc +"_"+tmp).attr("readOnly","true");
				$("#field"+ wlqd_oper +"_"+tmp).attr("readOnly","true");
/*				$("input[id^=field"+ wlqd_operdesc +"_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field"+ gylx_operdesc +"_"+mxid).val());
						$(this).attr("readOnly","true");
					}
				});
				$("input[id^=field"+ wlqd_oper +"_]").each(function(index) {
					if($(this).val()==''){
						$(this).val($("#field"+ gylx_oper +"_"+mxid).val());
						$(this).attr("readOnly","true");
					}
				});*/
			} 
		}); 
		
	    oper = $("#field"+ wlqd_oper +"_"+tmp).val();
		jQuery.ajax({
			 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118601ajaxaction.jsp",
			 data: {type: 1, gylxdm: xmh},
			 cache: false,
			 type: "post",
			 dataType: "json",
			 success: function (result) {
				 var lineNumber = e.id.slice(11);
				 result[0].mat_desc = result[0].mat_desc.replace("%22", "\"");
				 $("#field"+ wlqd_dinrk +"_"+lineNumber).val(result[0].mat_id);
				 $("#field"+ wlqd_invname +"_"+lineNumber).val(result[0].mat_desc);
				 $("#field"+ wlqd_zjsl +"_"+lineNumber).val(result[0].qty_1);
				 if(result[0].storage_location.indexOf("_")>=0){
					 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location.split("_")[1]);
				 }else{
					 $("#field"+ wlqd_ccdd +"_"+lineNumber).val(result[0].storage_location);
				 }
				 $("#field"+ wlqd_dw +"_"+lineNumber).val(result[0].MEASURE_UNIT_FK);
				 //必须维护工序卡控
				 if(lastoper != oper){
					 jQuery.ajax({
						 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118609ajaxaction.jsp",
						 data: {type: 1, requestid: requestid , formid: <%=formid%>},
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
					 lastoper = oper;
				 }

				 checkCustomize = function()
				 {
					 var flag = true;
					 if(a < count)
					 {
						 flag = false;
					 }else{
					 	 flag = true;
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

//A3-1 AT单特例
<%if( nodeid == nodeidA31){%>
	checkCustomize = function() {
		var flag = true;
		var oper = '';
		var lastoper = '';
		var count = 0;
		var a = 0;
		jQuery("input[id^='field"+ wlqd_oper +"_']").each(function(index) {
			
				var tmp = this.id.split("_")[1];
				if($("#field"+ wlqd_oper +"_"+tmp).val()==""){
					flag = false;
				}
				
				var mxid = this.id.split("_")[1];
				oper = $("#field"+ wlqd_oper +"_"+mxid).val();
				if(lastoper != oper){
					jQuery.ajax({
						url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118609ajaxaction.jsp",
						data: {type: 1,requestid: requestid , formid: <%=formid%>},
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
					 lastoper = oper ;				
				}

				var options=$("#field"+ sclx1 +" option:selected");
				var sclx = options.text();//AO
				var options1=$("#field"+ PackageType +" option:selected");
				var PackageType = options1.text();//AO
				var flag = true;
				if(sclx == "AO" && PackageType == "散装-BULK"){
					flag = true;
				}else{
					if(a < count)
					{
						flag = false;
					}else{
						flag = true;
					}
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
<%if( nodeid == nodeidA32 ||nodeid == nodeidA34  ){%>
	checkCustomize = function() {
		var flag = true;
		var oper = '';
		var lastoper = '';
		var count = 0;
		var a = 0 ;
			jQuery("input[id^='field"+ wlqd_oper +"_']").each(function(index) {
			
				var tmp = this.id.split("_")[1];
				if($("#field"+ wlqd_oper +"_"+tmp).val()==""){
					flag = false;
				}
				
				var mxid = this.id.split("_")[1];
				oper = $("#field"+ wlqd_oper +"_"+mxid).val();
				if(lastoper != oper){
					jQuery.ajax({
						url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118609ajaxaction.jsp",
						data: {type: 1,requestid: requestid , formid: <%=formid%>},
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
					lastoper = oper;
				}

				if(a < count)
				{
				 	flag = false;
				}else{
					flag = true;
				}
			});
			if (flag == false)
			{
				alert("请确认申请单信息填写完整");
			}
		return flag;
	}
<%}%>

//芯片信息带出物料清单信息
<%if(nodeid == nodeidA34){%>
//A3-4 带出主芯片
	var operstr = '';
	$("input[id^=field"+ xp_xplh +"_]").each(function(index){
		var mxid = this.id.split("_")[1];
		var a = document.getElementById("field"+ xp_mainchip +"_"+mxid).value;
		var dw = document.getElementById("field"+ xp_dw +"_"+mxid).value;
		$("#div2button > button").length
		if(a == 1 && $("#div2button > button").length == 2){
			
			//保存时检查是否已经存在0010工序，存在则不新增
			$("input[id^=field"+ wlqd_gxxmh_a34 +"_]").each(function(index){
				var oldid = this.id.split("_")[1];
				operstr = operstr +  $("#field"+ wlqd_oper +"_" + oldid).val() + ' ';
			});
			if(operstr.indexOf("0010")<0){
				addRow2(2);
			}
			var len = index;
			$("input[id^=field"+ wlqd_gxxmh_a34 +"_]").each(function(index){
				var xzid = this.id.split("_")[1];
				if($("#field"+ wlqd_oper +"_" + xzid).val() == ""){
					var indexrow = new wlqdrow();
					indexrow.xplh = $("#field"+ xp_xplh +"_" + mxid).val();
					indexrow.xppm = $("#field"+ xp_xppm +"_" + mxid).val();
					indexrow.xpsl = $("#field"+ xp_chipqty +"_" + mxid).val();
					indexrow.dw = $("#field"+ xp_dw +"_" + mxid).val();
					
					$("#field"+ wlqd_dinrk +"_" + xzid).val(indexrow.xplh);
					$("#field"+ wlqd_invname +"_" + xzid).val(indexrow.xppm);
					$("#field"+ wlqd_zjsl +"_" + xzid).val(indexrow.xpsl*1000);
/*					$("#field"+ wlqd_gxxmh_a34 +"_"+ xzid).val((len+1)*10);
					$("#field"+ wlqd_gxxmh_a34 +"_"+ xzid + "span").html('<span class="e8_showNameClass"><a>' + (len+1)*10 + '</a>&nbsp;<span class="e8_delClass" id="'+ (len+1)*10 +'" onclick="del(event,this,1,false,{});" style="opacity: 1; visibility: hidden;">&nbsp;x&nbsp;</span></span>');
					$("#field"+ wlqd_operdesc +"_" + xzid).val($("#field"+ gylx_operdesc +"_" + mxid).val()); 
					$("#field"+ wlqd_oper +"_" + xzid).val($("#field"+ gylx_oper +"_" + mxid).val());*/
					$("#field"+ wlqd_gxxmh_a34 +"_"+ xzid).val("10");
					$("#field"+ wlqd_gxxmh_a34 +"_"+ xzid + "span").html('<span class="e8_showNameClass"><a>' + 10 + '</a>&nbsp;<span class="e8_delClass" id="'+ 10 +'" onclick="del(event,this,1,false,{});" style="opacity: 1; visibility: hidden;">&nbsp;x&nbsp;</span></span>');
					$("#field"+ wlqd_operdesc +"_" + xzid).val("领芯片"); 
					$("#field"+ wlqd_oper +"_" + xzid).val("0010");
					if(dw == 0){
						$("#field"+ wlqd_dw +"_"+ xzid).val("EA");
					}else{
						$("#field"+ wlqd_dw +"_"+ xzid).val("WEA");
					}
				}
			});
		}
	});
	//A3-4 带出批数量
	var fzwx = $("#field"+ fzwx1).val();
	var khh =  $("#field"+ Customer).val();
	jQuery.ajax({
		 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118608ajaxaction.jsp",
		 data: {type: 1, fzwx: fzwx,khh: khh},
		 cache: false,
		 type: "post",
		 dataType: "json",
		 async: false,
		 success: function (result) {
			 if(result[0].QTY != ""){
				 $("#field"+ psl_lotsize).val(result[0].QTY);
				 document.getElementById("field"+ psl_lotsize).readOnly=true;
				//去除带出信息必填标记
				 var span = document.getElementById("field"+ psl_lotsize +"span");
			     span.removeChild(span.firstChild);
			 }
		 }
	});
	
<%}%>

<%if(nodeid == nodeidA32){%>
//A3-2 带出辅芯片
 	//带出辅芯片调用
	var gylx_str = '';
	var gylx_str1 = 1;
	var matid = '';
	//var operstr1 = '';
	//var oper_str1 = 1;
	$("input[id^=field"+ xp_xplh +"_]").each(function(index){
		var mxid = this.id.split("_")[1];
		var a = document.getElementById("field"+ xp_mainchip +"_"+mxid).value;
		var dw = document.getElementById("field"+ xp_dw +"_"+mxid).value;
		if(a == 0 && $("#div2button > button").length == 2){

			//保存时检查是否已经存在Y开头工序，存在则不新增
			$("input[id^=field"+ wlqd_gxxmh_a32 +"_]").each(function(index){
				var oldid1 = this.id.split("_")[1];
				//operstr1 = operstr1 +  $("#field"+ wlqd_oper +"_" + oldid1).val() + ' ';
				matid = matid + $("#field"+ wlqd_dinrk +"_" + oldid1).val() + ' ';
			});
			if(matid.indexOf($("#field"+ xp_xplh +"_" + mxid).val()) < 0){
				addRow2(2);
			}
/*			if(operstr1.indexOf("Y" + oper_str1)<0){
				addRow2(2);
			}*/
			
			//var len = index;
			$("input[id^=field"+ wlqd_gxxmh_a32 +"_]").each(function(index){
				var xzid = this.id.split("_")[1];
				if($("#field"+ wlqd_oper +"_" + xzid).val() == ""){
					//取辅芯片数据
					var indexrow = new wlqdrow();
					indexrow.xplh = $("#field"+ xp_xplh +"_" + mxid).val();
					indexrow.xppm = $("#field"+ xp_xppm +"_" + mxid).val();
					indexrow.xpsl = $("#field"+ xp_chipqty +"_" + mxid).val();
					indexrow.dw = $("#field"+ xp_dw +"_" + mxid).val();
					
					//在工艺路线中找对应Y开头工序
					$("input[id^=field"+ gylx_oper +"_]").each(function(index) {
						var mxid = this.id.split("_")[1];
						gylx_str = $("#field"+ gylx_oper + "_" + mxid).val().substring(0,2);
						if(gylx_str == "Y"+gylx_str1){
							$("#field"+ wlqd_gxxmh_a32 +"_"+ xzid).val($("#field"+ gylx_xmh +"_"+ mxid).val());//工序项目号
							$("#field"+ wlqd_gxxmh_a32 +"_"+ xzid + "span").html('<span class="e8_showNameClass"><a>' + $("#field"+ gylx_xmh +"_"+ mxid).val() + '</a>&nbsp;<span class="e8_delClass" id="'+ $("#field"+ gylx_xmh +"_"+ mxid).val() +'" onclick="del(event,this,1,false,{});" style="opacity: 1; visibility: hidden;">&nbsp;x&nbsp;</span></span>');
							$("#field"+ wlqd_operdesc +"_" + xzid).val($("#field"+ gylx_operdesc +"_" + mxid).val());//工序描述
							$("#field"+ wlqd_oper +"_" + xzid).val($("#field"+ gylx_oper +"_" + mxid).val());//工序
						}
					});
					
					$("#field"+ wlqd_dinrk +"_" + xzid).val(indexrow.xplh);
					$("#field"+ wlqd_invname +"_" + xzid).val(indexrow.xppm);
					$("#field"+ wlqd_zjsl +"_" + xzid).val(indexrow.xpsl*1000);
					if(dw == 0){
						$("#field"+ wlqd_dw +"_"+ xzid).val("EA");
					}else{
						$("#field"+ wlqd_dw +"_"+ xzid).val("WEA");
					}
				}
			});
			gylx_str1++;
			//oper_str1++;
		}
	});

<%}%>

//根据工序封装外形带出工作中心
//主数据申请T 创建节点 2453 
<%if(nodeid == nodeidA35 ||nodeid == nodeidT1 || nodeid == TestRouterCopy){%>
	$("input[id^=field"+ gylx_operdesc +"_]").each(function(index){
		var tmp = this.id.split("_")[1];
		var fzwx = $("#field"+ fzwx1).val();
		var gxms = $("#field"+ gylx_oper +"_"+ tmp).val();
		jQuery.ajax({
			 url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118605ajaxaction.jsp",
			 data: {type: 1, fzwx: fzwx,gxms: gxms},
			 cache: false,
			 type: "post",
			 dataType: "json",
			 success: function (result) {
				 if(result[0].WORK_CENTER_FK != ""){
				 	$("#field"+ gylx_WORK_CENTER_FK +"_"+tmp).val(result[0].WORK_CENTER_FK);
					$("#field"+ gylx_WORK_CENTER_FK +"_"+tmp+"span").html('<span class="e8_showNameClass"><a>' + result[0].WORK_CENTER_FK + '</a>&nbsp;<span class="e8_delClass" id="'+result[0].WORK_CENTER_FK+'">&nbsp;&nbsp;</span></span>');
				 }
			}
		});
	});
<%}%>

//A3-1 品名描述工厂自动带出
<%if(nodeid == nodeidA31 || nodeid == nodeidT1){%>
	$("#field"+ pmms2).val($("#field"+ pmms1).val());
	document.getElementById("field"+ pmms2).readOnly=true;
	if( $("#field"+ cpwlh1).val().substring(0,1) == "T"){
		$("#field"+ gc1).val("TEST");
		document.getElementById("field"+ gc1).readOnly=true;
	}
	else if($("#field"+ cpwlh1).val().substring(0,1) == "A"){
		$("#field"+ gc1).val("ASSY");
		document.getElementById("field"+ gc1).readOnly=true;
	}
	document.getElementById("field"+ cpwlh1).readOnly=true;
<%}%>

//解决物料清单明细工序项目号保存页面不显示
//A3-1 2342 A3-2 2343 A3-4 2345 A4-1 2355 A4-2 2347 A4-4 2349 A6 2352 归档 2351
//主数据申请T 分支合并 2458 
<%if(nodeid == nodeidA31 ||nodeid == nodeidA32 ||nodeid == nodeidA34 ||nodeid == nodeidA41 ||nodeid == nodeidA42 ||nodeid == nodeidRouterAudit ||nodeid == nodeidA6 ||nodeid == nodeidAgd||nodeid == nodeidT4 ||nodeid == nodeidT32){%>
	$("input[id^=field"+ wlqd_gxxmh_a6 +"_]").each(function(index){
		var tmp = this.id.split("_")[1];
		$("#field"+ wlqd_operdesc +"_"+tmp).attr("readOnly","true");
		$("#field"+ wlqd_oper +"_"+tmp).attr("readOnly","true");
		if(jQuery("#field"+ wlqd_gxxmh_a6 +"_" + tmp + "span").text() == ""){
			jQuery("#field"+ wlqd_gxxmh_a6 +"_" + tmp + "span").text(jQuery(this).val());
		}
	});
	$("input[id^=field"+ wlqd_gxxmh_a31 +"_]").each(function(index){
		var tmp = this.id.split("_")[1];
		$("#field"+ wlqd_operdesc +"_"+tmp).attr("readOnly","true");
		$("#field"+ wlqd_oper +"_"+tmp).attr("readOnly","true");
		if(jQuery("#field"+ wlqd_gxxmh_a31 +"_" + tmp + "span").text() == ""){
			jQuery("#field"+ wlqd_gxxmh_a31 +"_" + tmp + "span").text(jQuery(this).val());
		}
	});
	$("input[id^=field"+ wlqd_gxxmh_a32 +"_]").each(function(index){
		var tmp = this.id.split("_")[1];
		$("#field"+ wlqd_operdesc +"_"+tmp).attr("readOnly","true");
		$("#field"+ wlqd_oper +"_"+tmp).attr("readOnly","true");
		if(jQuery("#field"+ wlqd_gxxmh_a32 +"_" + tmp + "span").text() == ""){
			jQuery("#field"+ wlqd_gxxmh_a32 +"_" + tmp + "span").text(jQuery(this).val());
		}
	});
	$("input[id^=field"+ wlqd_gxxmh_a34 +"_]").each(function(index){
		var tmp = this.id.split("_")[1];
		$("#field"+ wlqd_operdesc +"_"+tmp).attr("readOnly","true");
		$("#field"+ wlqd_oper +"_"+tmp).attr("readOnly","true");
		if(jQuery("#field"+ wlqd_gxxmh_a34 +"_" + tmp + "span").text() == ""){
			jQuery("#field"+ wlqd_gxxmh_a34 +"_" + tmp + "span").text(jQuery(this).val());
		}
	});
<%}%>
//A3-1 2342 A4-1 2355  非当前角色维护工序页面隐藏
<%if(nodeid == nodeidA31 || nodeid == nodeidA41){%>
	$("input[id^=field"+ wlqd_gxxmh_a31 +"_]").each(function(index){
		var tmp = this.id.split("_")[1];
		if($("#field"+ wlqd_gxxmh_a31 +"_" + tmp).val() == "" && $("#field"+ wlqd_oper +"_" + tmp).val() != ""){
			$("#field"+ wlqd_gxxmh_a31 +"_" + tmp).parent().parent().attr('style','display:none');
		}
	});
<%}%>
//A3-2 2343 A4-2 2347 非当前角色维护工序页面隐藏
<%if(nodeid == nodeidA32 || nodeid == nodeidA42){%>
	$("input[id^=field"+ wlqd_gxxmh_a32 +"_]").each(function(index){
		var tmp = this.id.split("_")[1];
		if($("#field"+ wlqd_gxxmh_a32 +"_" + tmp).val() == "" && $("#field"+ wlqd_oper +"_" + tmp).val() != ""){
			$("#field"+ wlqd_gxxmh_a32 +"_" + tmp).parent().parent().attr('style','display:none');
		}
	});
<%}%>
//A3-4 2345  A4-4 2349 非当前角色维护工序页面隐藏
<%if(nodeid == nodeidA34 || nodeid == nodeidRouterAudit){%>
	$("input[id^=field"+ wlqd_gxxmh_a34 +"_]").each(function(index){
		var tmp = this.id.split("_")[1];
		if($("#field"+ wlqd_gxxmh_a34 +"_" + tmp).val() == "" && $("#field"+ wlqd_oper +"_" + tmp).val() != ""){
			$("#field"+ wlqd_gxxmh_a34 +"_" + tmp).parent().parent().attr('style','display:none');
		}
	});
<%}%>

//标准工艺路线带出描述
//主数据申请T T1 2453 
<%if(nodeid == nodeidA1  ||nodeid == nodeidT1){%>
	$("#field" + bzgylx).bindPropertyChange(function(e){
		jQuery.ajax({
			url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118606ajaxaction.jsp",
			data: {type: 1, gylxdm: e.value},
			cache: false,
			type: "post",
			dataType: "json",
			success: function (result) {
				$("#field"+ ms_description).val(result[0].desc);
				
				//带出信息隐藏必填标记
				var span = document.getElementById("field"+ ms_description +"span");
				span.removeChild(span.firstChild);
			}
		});
	});
<%}%>

//解决工艺路线明细工序保存页面不显示
	$("input[id^=field"+ gylx_oper +"_]").each(function(index){
			var tmp = this.id.split("_")[1];
			if(jQuery("#field"+ gylx_oper +"_" + tmp + "span").text() == ""){
				jQuery("#field"+ gylx_oper +"_" + tmp + "span").text(jQuery(this).val());
			}
	});
//解决工艺路线明细工作中心保存页面不显示
	$("input[id^=field"+ gylx_WORK_CENTER_FK +"_]").each(function(index){
			var tmp = this.id.split("_")[1];
			if(jQuery("#field"+ gylx_WORK_CENTER_FK +"_" + tmp + "span").text() == ""){
				jQuery("#field"+ gylx_WORK_CENTER_FK +"_" + tmp + "span").text(jQuery(this).val());
			}
	});
//解决工艺路线明细设备组保存页面不显示
	$("input[id^=field"+ gylx_sbz +"_]").each(function(index){
			var tmp = this.id.split("_")[1];
			if(jQuery("#field"+ gylx_sbz +"_" + tmp + "span").text() == ""){
				jQuery("#field"+ gylx_sbz +"_" + tmp + "span").text(jQuery(this).val());
			}
	});
//封装信息判断品名描述
	$("#field"+ pmms1).blur(function(e){
		var pmms = $("#field"+ pmms1).val();
		jQuery.ajax({
			url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118604ajaxaction.jsp",
			data: {type: 1, gylxdm: pmms},
			cache: false,
			type: "post",
			dataType: "json",
			success: function (result) {
				if(result[0].no != 0 ){
					alert("请重新输入品名描述");
					$("#field"+ pmms1).val("");
				}
			}
		});
	});
});

  //T1根据品名描述带出 TestTime IndexTime SiteQty 
   <%if(nodeid == nodeidT1){%>
   var T_pmms = $("#field"+ pmms1).val();
	   jQuery.ajax({
	 		url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118611ajaxaction.jsp",
	 		data: {type: 2, T_pmms: T_pmms},
	 		cache: false,
	 		type: "post",
	 		//dataType: "json",
			dataType: "text",
			success: function (result) {
				result = jQuery.trim(result);
				var ary  = new Array();
				ary = result.split(",");
					$("#field"+ sq_siteqty ).val(ary[0]);
					$("#field"+ kssj1 ).val(ary[1]);
					$("#field"+ cssj1 ).val(ary[2]);
					$("#field"+ Tester ).val(ary[3]);
					$("#field"+ TestFlow ).val(ary[4]);
/*				if(result.length > 0){
					$("#field"+ sq_siteqty ).val(result[0].SITE_QTY);
					$("#field"+ kssj1 ).val(result[0].INDEX_TIME);
					$("#field"+ cssj1 ).val(result[0].TEST_TIME);
					$("#field"+ Tester ).val(result[0].CSJ);
					$("#field"+ TestFlow ).val(result[0].CSLC);
				}*/
			}
	 	});
   <%}%>
   
  // T3-1 取TestTime IndexTime SiteQty 计算UPH
  <%if(nodeid == nodeidT2 || nodeid == nodeidT31){%>
	  $("input[id^=field"+ gylx_oper +"_]").each(function(index){
		  var str = '';
		  var tmp = this.id.split("_")[1];
		  var fzwx = $("#field"+ fzwx1).val();
		  var TestTime = parseFloat($("#field"+ cssj1).val());
		  var SiteQty = parseFloat($("#field"+ sq_siteqty).val());
		  var IndexTime = parseFloat($("#field"+ kssj1).val());
		  
		  jQuery.ajax({
		  		url: "/interface/additional/aoatcreate/aoatcreate_cc/WF118611ajaxaction.jsp",
		  		data: {type: 1, fzwx: fzwx, gx: $("#field"+ gylx_oper +"_" + tmp).val()},
		  		cache: false,
		  		type: "post",
		  		dataType: "json",
				success: function (result) {
					str = result[0].uph_formula ;
					var res = isNaN(str);
					if(res == false){
						$("#field"+ gylx_uph +"_" + tmp ).val(str);
					}
					else{
						$("#field"+ gylx_uph +"_" + tmp ).val(eval(str));
						$("#field"+ gylx_uph +"_" + tmp ).val($("#field"+ gylx_uph +"_" + tmp ).val().split(".")[0]);
					}
				}
		  });
	  });
  <%}%>
 
  //T1  新增明细如果为空不可提交
 <%if(nodeid == nodeidT1){%>
 	checkCustomize = function() {
 			var flag = true;
 			var flag1 = "1"
 			var options_ifcopy=$("#field"+ ifcopy +" option:selected");
			var ifcopy = options_ifcopy.text();//
			if(ifcopy == "否"){
				jQuery("input[id^='field"+ gylx_oper +"_']").each(function(index) {
 					var tmp = this.id.split("_")[1];
 					if($("#field"+ gylx_oper +"_"+tmp).val()==""){
 						flag1 = "2";
 						flag = false;
 					}
 				});
 				jQuery("input[id^='field"+ gylx_operdesc +"_']").each(function(index) {
 					if(jQuery(this).val()==""){
 						flag1 = "2";
 						flag = false;
 					}
 				});
 				jQuery("input[id^='field"+ gylx_WORK_CENTER_FK +"_']").each(function(index) {
 					var tmp = this.id.split("_")[1];
 					if($("#field"+ gylx_WORK_CENTER_FK +"_"+tmp).val()==""){
 						flag1 = "2";
 						flag = false;
 					}
 				});

 				//需求系统编号OA201711008 增加FLOW根据包装方式工序卡控
 				jQuery("input[id^='field"+ gylx_oper +"_']").each(function(index) {
 					var tmp = this.id.split("_")[1];
 					jQuery.ajax({
						url: "/interface/additional/aoatcreate/aoatcreate_cc/WF1186ajaxaction.jsp",
						data: {type: 3, oper1:  $("#field"+ gylx_oper +"_"+tmp).val() , requestid1: requestid },
						cache: false,
						type: "post",
						async:false,
						dataType: "text",
						success: function (result) {
							result = jQuery.trim(result);
							if(result != "0"){
								flag1 = "3";
								flag = false;
							}
						}
					});
 				});


 				if (flag == false && flag1 == "3"){
 					alert("请确认工艺路线维护工序是否正确");
 				}	
 				if (flag == false && flag1 == "2"){
 					alert("请确认申请单信息填写完整");
 				}
			}
 			return flag;
 	}
 <%}%> 
//主数据申请创建节点 2341 
<%if(nodeid == nodeidDraft){%>
	//需求系统编号OA201706015
	$("#field" + Customer).bindPropertyChange(function(e){
		$("#field"+ dynryq1).val("");
		if(e.value == "656"){
			$("#field" + khpm1).blur(function(){
				jQuery.ajax({
					url: "/interface/additional/aoatcreate/aoatcreate_cc/WF1186ajaxaction.jsp",
					data: {type: 2, khpm1:  $("#field"+ khpm1).val().trim()},
					cache: false,
					type: "post",
					dataType: "text",
					success: function (result) {
						result = jQuery.trim(result);
						$("#field"+ dynryq1).val(result);
					}
				});
			});
		}
	});
	$("#field" + khpm1).bindPropertyChange(function(e){
		$("#field"+ dynryq1).val("");
		$("#field" + Customer).bindPropertyChange(function(e){
			if(e.value == "656"){
				jQuery.ajax({
					url: "/interface/additional/aoatcreate/aoatcreate_cc/WF1186ajaxaction.jsp",
					data: {type: 2, khpm1:  $("#field"+ khpm1).val().trim()},
					cache: false,
					type: "post",
					dataType: "text",
					success: function (result) {
						result = jQuery.trim(result);
						$("#field"+ dynryq1).val(result);
					}
				});
			}
		});
	});
	
	//需求系统编号OA201705004 
	checkCustomize = function() {
		var options=$("#field"+ sclx1 +" option:selected");
		var sclx = options.text();
		var khh =  $("#field"+ Customer).val();
		if($("#field"+ fzwx1).val() == "DFN8NT3Q-075-CU" && sclx == "AT" && khh == "243"){
			var pmms = $("#field"+ pmms1).val();
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


//工艺路线明细鼠标当前行增加CSS样式
function dobackground (){
	$("#oTable1").children().children().mouseenter(function(){ 
     $(this).css("background","#DEF0FF");
 	}) 
 	$("#oTable1").children().children().mouseleave(function(){ 
     $(this).css("background","");
 	}) 
}

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
		$("input[id^=field"+ gylx_xmh +"_]").each(function(index) {
			var indexrow = new mxrow();
			var mxid = this.id.split("_")[1];
			indexrow.xmh = parseInt($("#field"+ gylx_xmh +"_"+mxid).val());//这行的明细项目号
			indexrow.gxh = $("#field"+ gylx_oper +"_"+mxid).val();
			indexrow.gxms = $("#field"+ gylx_operdesc +"_"+mxid).val();
			indexrow.bz = $("#field"+ gylx_bz +"_"+mxid).val();
			//A1 设备组
			<%if(nodeid == nodeidA1 || nodeid == nodeidRouterCopy){%>
				indexrow.sbz = $("#field"+ gylx_sbz +"_"+mxid).val();
			<%}%>
			//T1 工作中心
			<%if(nodeid == nodeidT1 || nodeid == TestRouterCopy){%>
			indexrow.gzzx = $("#field"+ gylx_WORK_CENTER_FK +"_"+mxid).val();
			<%}%>
			indexrow.xmhwb = document.getElementById("field"+ gylx_xmh +"_"+mxid).readOnly;
			indexrow.gxwb = document.getElementById("field"+ gylx_oper +"_"+mxid).readOnly;
			indexrow.gxllan = document.getElementById("field"+ gylx_oper +"_"+mxid+"_browserbtn").disabled;
			//A1 设备组
			<%if(nodeid == nodeidA1 || nodeid == nodeidRouterCopy){%>
				indexrow.sbzwb = document.getElementById("field"+ gylx_sbz +"_"+mxid).readOnly;
				indexrow.sbzllan = document.getElementById("field"+ gylx_sbz +"_"+mxid+"_browserbtn").disabled;
			<%}%>
			//T1 工作中心
			<%if(nodeid == nodeidT1 || nodeid == TestRouterCopy){%>
				indexrow.gzzxwb = document.getElementById("field"+ gylx_WORK_CENTER_FK +"_"+mxid).readOnly;
				indexrow.gzzxllan = document.getElementById("field"+ gylx_WORK_CENTER_FK +"_"+mxid+"_browserbtn").disabled;
			<%}%>
			indexrow.gxmswb = document.getElementById("field"+ gylx_operdesc +"_"+mxid).readOnly;
			
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
		$("input[id^=field"+ gylx_xmh +"_]").each(function(index) {
			var indexrow = trarray[index];
			var mxid = this.id.split("_")[1];
			$("#field"+ gylx_xmh +"_"+mxid).val(indexrow.xmh);//这行的明细项目号
			$("#field"+ gylx_oper +"_"+mxid).val(indexrow.gxh);
			$("#field"+ gylx_oper +"_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + indexrow.gxh + '</a>&nbsp;<span class="e8_delClass" id="'+indexrow.gxh+'">&nbsp;&nbsp;</span></span>');
			$("#field"+ gylx_operdesc +"_"+mxid).val(indexrow.gxms);
			$("#field"+ gylx_bz +"_"+mxid).val(indexrow.bz);
			//A1 设备组
			<%if( nodeid == nodeidA1 || nodeid == nodeidRouterCopy){%>
				$("#field"+ gylx_sbz +"_"+mxid).val(indexrow.sbz);
				$("#field"+ gylx_sbz +"_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + indexrow.sbz + '</a>&nbsp;<span class="e8_delClass" id="'+indexrow.sbz+'" >&nbsp;&nbsp;</span></span>');
			<%}%>
			//T1 工作中心
			<%if( nodeid == nodeidT1 || nodeid == TestRouterCopy){%>
				$("#field"+ gylx_WORK_CENTER_FK +"_"+mxid).val(indexrow.gzzx);
				$("#field"+ gylx_WORK_CENTER_FK +"_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + indexrow.gzzx + '</a>&nbsp;<span class="e8_delClass" id="'+indexrow.gzzx+'">&nbsp;&nbsp;</span></span>');
			<%}%>
			document.getElementById("field"+ gylx_xmh +"_"+mxid).readOnly = indexrow.xmhwb;
			document.getElementById("field"+ gylx_oper +"_"+mxid).readOnly = indexrow.gxwb;
			document.getElementById("field"+ gylx_oper +"_"+mxid+"_browserbtn").disabled = indexrow.gxllan;
		    document.getElementById("field"+ gylx_operdesc +"_"+mxid).readOnly = indexrow.gxmswb;
		  //A1 设备组
		    <%if(nodeid == nodeidA1 || nodeid == nodeidRouterCopy){%>
		    	document.getElementById("field"+ gylx_sbz +"_"+mxid).readOnly = indexrow.sbzwb;
				document.getElementById("field"+ gylx_sbz +"_"+mxid+"_browserbtn").disabled = indexrow.sbzllan;
		    <%}%>
		  //T1 工作中心
			<%if( nodeid == nodeidT1 || nodeid == TestRouterCopy){%>
				document.getElementById("field"+ gylx_WORK_CENTER_FK +"_"+mxid).readOnly = indexrow.gzzxwb;
				document.getElementById("field"+ gylx_WORK_CENTER_FK +"_"+mxid+"_browserbtn").disabled = indexrow.gzzxllan;
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
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.soa.workflow.request.Property"%>
<%@ page import="weaver.soa.workflow.request.RequestInfo"%>
<%@ page import="weaver.interfaces.workflow.util.BillUtil"%>
<%


	//当前基本信息
    int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
	int formid = Util.getIntValue(request.getParameter("formid"));//表单id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
	
	
	//节点信息
	int nodeStart = BillUtil.getNodeId(workflowid, "01 申请");
	
	//main
	String applicant = BillUtil.getLabelId(formid,0,"CREATER");//创建人
	
	String fieldMAdminroles = BillUtil.getLabelId(formid, 0, "ADMINROLES");
	String fieldMIfMes = BillUtil.getLabelId(formid, 0, "IFMES");//
	String fieldMFactory =BillUtil.getLabelId(formid, 0, "FACTORY");
	//dt1
	String fieldDt1Category = BillUtil.getLabelId(formid, 1, "CATEGORY");
	String fieldDt1System = BillUtil.getLabelId(formid, 1, "SYSTEM");
	String fieldDt1Remark = BillUtil.getLabelId(formid, 1, "REMARK");
	String fieldDt1Admin = BillUtil.getLabelId(formid, 1, "ADMIN");
	//dt2
	String fieldDt2EmpNo = BillUtil.getLabelId(formid, 2, "EMP_NO");
	String fieldDt2EmpRemark = BillUtil.getLabelId(formid, 2, "EMP_REMARK");
	String fieldDt2DateExpireFlag = BillUtil.getLabelId(formid, 2, "DATE_EXPIRE_FLAG");
	String fieldDt2DateExpire = BillUtil.getLabelId(formid, 2, "DATE_EXPIRE");
	//select
	//MAIN
	int optionMainFactoryCC = BillUtil.getSelectValue(formid, 1, "FACTORY", "崇川");
	int optionMainFactoryST = BillUtil.getSelectValue(formid, 1, "FACTORY", "苏通");
	int optionMainFactoryHF = BillUtil.getSelectValue(formid, 1, "FACTORY", "合肥");
	//dt1
	int optionDt1SystemSAP = BillUtil.getSelectValue(formid, 1, "SYSTEM", "SAP");
	int optionDt1SystemWEE = BillUtil.getSelectValue(formid, 1, "SYSTEM", "WEE");
	int optionDt1SystemOA = BillUtil.getSelectValue(formid, 1, "SYSTEM", "OA");
	int optionDt1SystemMES = BillUtil.getSelectValue(formid, 1, "SYSTEM", "MES");
	int optionDt1SystemEMS = BillUtil.getSelectValue(formid, 1, "SYSTEM", "EMS");
	int optionDt1SystemFMB = BillUtil.getSelectValue(formid, 1, "SYSTEM", "FMB");
	int optionDt1SystemNopaper = BillUtil.getSelectValue(formid, 1, "SYSTEM", "无纸化");
	int optionDt1SystemGotonet = BillUtil.getSelectValue(formid, 1, "SYSTEM", "上网");
	int optionDt1SystemEmail = BillUtil.getSelectValue(formid, 1, "SYSTEM", "个人邮箱");
	int optionDt1SystemSKYPE = BillUtil.getSelectValue(formid, 1, "SYSTEM", "SKYPE");
	int optionDt1SystemFTPSFTP = BillUtil.getSelectValue(formid, 1, "SYSTEM", "FTP/SFTP");
	int optionDt1SystemSSLVPN = BillUtil.getSelectValue(formid, 1, "SYSTEM", "SSLVPN");
	int optionDt1SystemEmailGroup = BillUtil.getSelectValue(formid, 1, "SYSTEM", "邮件组");
	int optionDt1SystemReport = BillUtil.getSelectValue(formid, 1, "SYSTEM", "REPORT");
	int optionDt1SystemUsb = BillUtil.getSelectValue(formid, 1, "SYSTEM", "USB接口");
	int optionDt1SystemRemote = BillUtil.getSelectValue(formid, 1, "SYSTEM", "外部远程协助");
	int optionDt1SystemBackup = BillUtil.getSelectValue(formid, 1, "SYSTEM", "服务器数据备份");
	int optionDt1SystemMachine = BillUtil.getSelectValue(formid, 1, "SYSTEM", "堡垒机");
	//客户主机托管
	int optionDt1SystemWebHosting = BillUtil.getSelectValue(formid, 1, "SYSTEM", "客户主机托管");
    //门禁系统
	int optionDt1SystemEntranceGuard= BillUtil.getSelectValue(formid, 1, "SYSTEM", "门禁系统");
    //文件共享
	int optionDt1SystemFileShare= BillUtil.getSelectValue(formid, 1, "SYSTEM", "文件共享");
	
	
	
%>
<script>
	//基本信息
	var nodeid = <%=nodeid %>;
	var formid = <%=formid %>;
	var workflowid = <%=workflowid %>;
	var applicant = <%=applicant%>
	//main value

	
	//main
	var fieldMAdminroles = <%=fieldMAdminroles%>;
	var fieldMIfMes = <%=fieldMIfMes%>;
	var fieldMFactory = <%=fieldMFactory%>;
	
	//dt1
	var fieldDt1Category = <%=fieldDt1Category%>;
	var fieldDt1System = <%=fieldDt1System%>;
	var fieldDt1Remark = <%=fieldDt1Remark%>;
	var fieldDt1Admin = <%=fieldDt1Admin%>;
	//dt2
	var fieldDt2EmpNo = <%=fieldDt2EmpNo%>;
	var fieldDt2EmpRemark = <%=fieldDt2EmpRemark%>;
	var fieldDt2DateExpireFlag = <%=fieldDt2DateExpireFlag%>;
	var fieldDt2DateExpire = <%=fieldDt2DateExpire%>;
	//select
	//main
	var optionMainFactoryCC = '<%=optionMainFactoryCC%>';
	var optionMainFactoryST = "<%=optionMainFactoryST%>";
	var optionMainFactoryHF = "<%=optionMainFactoryHF%>";
	//dt1
	var optionDt1SystemSAP = '<%=optionDt1SystemSAP%>';
	var optionDt1SystemWEE = "<%=optionDt1SystemWEE%>";
	var optionDt1SystemOA = "<%=optionDt1SystemOA%>";
	var optionDt1SystemMES = "<%=optionDt1SystemMES%>";
	var optionDt1SystemEMS = "<%=optionDt1SystemEMS%>";
	var optionDt1SystemFMB = "<%=optionDt1SystemFMB%>";
	var optionDt1SystemNopaper = "<%=optionDt1SystemNopaper%>";
	var optionDt1SystemGotonet = "<%=optionDt1SystemGotonet%>";
	var optionDt1SystemEmail = "<%=optionDt1SystemEmail%>";
	var optionDt1SystemSKYPE = "<%=optionDt1SystemSKYPE%>";
	var optionDt1SystemFTPSFTP = "<%=optionDt1SystemFTPSFTP%>";
	var optionDt1SystemSSLVPN = "<%=optionDt1SystemSSLVPN%>";
	var optionDt1SystemEmailGroup = "<%=optionDt1SystemEmailGroup%>";
	var optionDt1SystemReport = "<%=optionDt1SystemReport%>";
	var optionDt1SystemUsb = "<%=optionDt1SystemUsb%>";
	var optionDt1SystemRemote = "<%=optionDt1SystemRemote%>";
	var optionDt1SystemBackup = "<%=optionDt1SystemBackup%>";
	var optionDt1SystemMachine = "<%=optionDt1SystemMachine%>";
	var optionDt1SystemEntranceGuard="<%=optionDt1SystemEntranceGuard%>";
	var optionDt1SystemWebHosting="<%=optionDt1SystemWebHosting%>";
	var optionDt1SystemFileShare="<%=optionDt1SystemFileShare%>";
	
	//Table相关的行
	var dt1AddNSubtract = jQuery("#oTable0 tbody tr:eq(1)");
	var dt2AddNSubtract = jQuery("#oTable1 tbody tr:eq(1)");
	var dt1SelectAllCheckBox = jQuery("#oTable0 tbody tr:eq(2) td input");
	var dt2SelectAllCheckBox = jQuery("#oTable1 tbody tr:eq(2) td input");
	
	var authorityList = new Array();
	var authorityListBack = new Array();
	
	//主要部分
    jQuery(function () {
		
		
		//MAIN
		var FactoryID = jQuery("#field" + fieldMFactory).val();
		//隐藏整个角色项
		jQuery("#field" + fieldMAdminroles).parent().parent().parent().attr("style", "display:none");
		<%if(nodeid == nodeStart){%>
		//把所有X全部删除，只可以通过按钮修改人
		jQuery("span.e8_delClass").remove();
		//对当前是否MES设置初始状态——隐藏DT1或2的加减号
		if(jQuery("#field" + fieldMIfMes).find("option:selected").text() == "否") {
			jQuery(dt2AddNSubtract).attr("style", "display:none");
			jQuery(dt1AddNSubtract).removeAttr("style");
			
		} else if (jQuery("#field" + fieldMIfMes).find("option:selected").text() == "是"){
			//addRow1(1);
			jQuery(dt1AddNSubtract).attr("style", "display:none");
		    jQuery(dt2AddNSubtract).removeAttr("style");
			var idx = jQuery("select[id^='field" + fieldDt1System + "_']").last().attr("id").split("_")[1];
			setCover_d(fieldDt1System, idx);
			setCover_d(fieldDt1Category, idx);
			//为有效期checkBox设置事件-影响有效期时间显示
			//setDateExpire(idx);
			//在该行添加个隐藏BLOCK
			//setAuthBlock(idx);
			//增加hidden框以存储
			//setHiddenWorkCode(idx);
			//增加hidden框以存储
			//setHiddenAuth(idx);
			//为EmpNo框设置blur事件
			//jQuery("#field" + fieldDt2EmpNo + "_" + idx).blur(function() {
			//	dt2EmpNoBlur(idx);
			//});
			//设置移入移出事件，并且修改权限框内容
			//setHover(idx);
		}
		
		
		
		
		
		//设置是否MES的效果
		jQuery("#field" + fieldMIfMes).change(function(){
			if(jQuery("#field" + fieldMIfMes).find("option:selected").text() != ""){
				//清空DT1、2
				var dt1rows = jQuery("#oTable0 tbody tr:gt(2)");
				var dt2rows = jQuery("#oTable1 tbody tr:gt(2)");
				//把confirm提示框给禁了
				var originConfirm = window.confirm;
				window.confirm = function () {
					return true;
				};
				//如果dt1rows存在内容，就删除
				if(jQuery(dt1rows).length > 0) {
					//把全选的那个勾打上
					jQuery(dt1SelectAllCheckBox).attr("checked", true);
					//运行方法，实现全选
					detailOperate.checkAllFun(0);
					//运行方法，将选中的条目删除
					deleteRow0(0);
					//把全选的勾去掉
					jQuery(dt1SelectAllCheckBox).attr("checked", false);
				}
				//如果dt2rows存在内容，就删除
				if(jQuery(dt2rows).length > 0) {
					jQuery(dt2SelectAllCheckBox).attr("checked", true);
					detailOperate.checkAllFun(1);
					deleteRow1(1);
					jQuery(dt2SelectAllCheckBox).attr("checked", false);
				}
				//再恢复confirm功能
				window.confirm = originConfirm;
				//先把加减栏隐藏
				jQuery(dt1AddNSubtract).attr("style", "display:none");
				jQuery(dt2AddNSubtract).attr("style", "display:none");
				if(jQuery("#field" + fieldMIfMes).find("option:selected").text() == "是") {
					jQuery(dt2AddNSubtract).removeAttr("style");
					//选中后，设置最新一项为MES的，且不能编辑（防止选别的），还要将加号隐藏
					addRow0(0);
					var idx1 = jQuery("select[id^='field" + fieldDt1System + "_']").last().attr("id").split("_")[1];
					//删除负责人栏位的显示和按钮
					jQuery("#field" + fieldDt1Admin + "_" + idx1 + "span").empty();
					jQuery("#field" + fieldDt1Admin + "_" + idx1 + "_browserbtn").remove();
					jQuery("#field" + fieldDt1Category + "_" + idx1).val("2");
					jQuery("#field" + fieldDt1Category + "_" + idx1).change();
					//selectMes(idx1);
					setTimeout(function(){
						jQuery("#field" + fieldDt1System + "_" + idx1).attr("value","3");
                                                       jQuery("#field" + fieldDt1System + "_" + idx1).change();
					},500);
					var FactoryID = jQuery("#field" + fieldMFactory).val();
					setSysadmin(idx1, optionDt1SystemMES,FactoryID);
					setRemark(idx1, optionDt1SystemMES);
					setCover_d(fieldDt1System, idx1);
					setCover_d(fieldDt1Category, idx1);
				} else if (jQuery("#field" + fieldMIfMes).find("option:selected").text() == "否"){
					jQuery("#field" + fieldDt2EmpNo + "_" + idx2).change(function(){
						dt2CategoryBlur(idx2);
					});
					//取消后，将DT1的加号显示，还要将MES项手动删除
					jQuery(dt1AddNSubtract).removeAttr("style");
					addRow1(1);
					//为有效期checkBox设置事件-影响有效期时间显示
					var idx2 = jQuery("input[id^='field" + fieldDt2EmpRemark + "_']").last().attr("id").split("_")[1];
					//为有效期checkBox设置事件-影响有效期时间显示
					setDateExpire(idx2);
					//在该行添加个隐藏BLOCK
					setAuthBlock(idx2);
					//增加hidden框以存储
					setHiddenWorkCode(idx2);
					//增加hidden框以存储
					setHiddenAuth(idx2);
					//为EmpNo框设置blur事件
					jQuery("#field" + fieldDt2EmpNo + "_" + idx).blur(function() {
						dt2EmpNoBlur(idx2);
					});
					//设置移入移出事件，并且修改权限框内容
					setHover(idx2);
				}
			}
		});
		
		//dt1
		//新增按钮的点击事件
		var dt1AddButton = jQuery("button[name=addbutton0]");
		jQuery(dt1AddButton).click(function(){
			var idx = jQuery("select[id^='field" + fieldDt1System + "_']").last().attr("id").split("_")[1];
			//每新增一行的预处理
			//删除负责人栏位的显示和按钮
			jQuery("#field" + fieldDt1Admin + "_" + idx + "span").empty();
			jQuery("#field" + fieldDt1Admin + "_" + idx + "_browserbtn").remove();
			//为系统下拉框绑定事件
			jQuery("#field" + fieldDt1System + "_" + idx).change(function() {
				//获取该行的system值
				var FactoryID = jQuery("#field" + fieldMFactory).val();
				var systemValue = jQuery("#field" + fieldDt1System + "_" + idx).val();
				//为权限明细表的备注增加提示信息
				setRemark(idx, systemValue);
				//修改系统负责人
				setSysadmin(idx, systemValue,FactoryID);
			});
		});
		//对已有的项的附加点击事件（退回时）
		jQuery("select[id^='field" + fieldDt1System + "_']").each(function () {
			var idx = this.id.split("_")[1];
			//对已有行的预处理
			//删除负责人栏位的显示和按钮
			jQuery("#field" + fieldDt1Admin + "_" + idx + "_browserbtn").remove();
			//获取该行的system值
			var systemValue = jQuery("#field" + fieldDt1System + "_" + idx).val();
			//为权限明细表的备注增加提示信息
			setRemark(idx, systemValue);
			//为系统下拉框绑定事件
			jQuery("#field" + fieldDt1System + "_" + idx).change(function() {
				//获取该行的system值
				var systemValue = jQuery("#field" + fieldDt1System + "_" + idx).val();
				var FactoryID = jQuery("#field" + fieldMFactory).val();
				//为权限明细表的备注增加提示信息
				setRemark(idx, systemValue);
				//修改系统负责人
				setSysadmin(idx, systemValue,FactoryID);
			});
		});
		
		//DT2
		//加个备注提示框
		var htmlPersonalRemark = '<div id="personalRemarkBlock" style="position:absolute;display:none;border:1px solid black;background:#e7f3fc;"><ul id="personalRemarkUl"></ul></div>';
		jQuery("#oTable1 tbody tr:eq(2) td:last").append(htmlPersonalRemark);
		jQuery("#personalRemark").hover(
			showDt2Remark, hideDt2Remark
		);
		
		//DT2新增按钮的点击事件
		var dt2AddButton = jQuery("button[name=addbutton1]");
		jQuery(dt2AddButton).click(function(){
			var idx = jQuery("input[id^='field" + fieldDt2EmpRemark + "_']").last().attr("id").split("_")[1];
			//为有效期checkBox设置事件-影响有效期时间显示
			setDateExpire(idx);
			//在该行添加个隐藏BLOCK
			setAuthBlock(idx);
			//增加hidden框以存储
			setHiddenWorkCode(idx);
			//增加hidden框以存储
			setHiddenAuth(idx);
			//为EmpNo框设置blur事件
			jQuery("#field" + fieldDt2EmpNo + "_" + idx).blur(function() {
				dt2EmpNoBlur(idx);
			});
			//设置移入移出事件，并且修改权限框内容
			setHover(idx);
		});
		//对DT2已有的项的附加点击事件（退回时）
		jQuery("input[id^='field" + fieldDt2EmpRemark + "_']").each(function () {
			var idx = this.id.split("_")[1];
			//为有效期checkBox设置事件-影响有效期时间显示
			setDateExpire(idx);
			//在该行添加个隐藏BLOCK
			setAuthBlock(idx);
			//增加hidden框以存储
			setHiddenWorkCode(idx);
			//增加hidden框以存储
			setHiddenAuth(idx);
			//为EmpNo框设置blur事件
			jQuery("#field" + fieldDt2EmpNo + "_" + idx).blur(function() {
				dt2EmpNoBlur(idx);
			});
			//设置移入移出事件，并且修改权限框内容
			setHover(idx);
		});		
		
		//提交时的预判定
		checkCustomize = function() {
			var systemValues = new Array();
			var FactoryID = jQuery("#field" + fieldMFactory).val();
			jQuery("select[id^='field" + fieldDt1System + "_']").each(function () {
				systemValues.push(jQuery(this).val());
			});
			var flag = setAdminRoles(systemValues,FactoryID);
			return flag;
		}
				jQuery.ajax({
				url: "/interface/additional/service_support/it_authority_centralized_application/get_role_id.jsp",
				data: {roleid: $("#field" + applicant).val()},
				cache: true,
				type: "post",
				dataType: "text",
				async: false,
				success: function (result) {
					result = jQuery.trim(result);
					if(result == "1")
					{//崇川
						$("#field" + fieldMFactory ).attr("value","0");
						$("#field" + fieldMFactory ).change();
						setCover(fieldMFactory);
					}
					if(result == "142")
					{//苏通121 teste   142 prod
						$("#field" + fieldMFactory ).attr("value","1");
						$("#field" + fieldMFactory ).change();
						setCover(fieldMFactory);
					}
					if(result == "101")
					{//合肥
						$("#field" + fieldMFactory ).attr("value","2");
						$("#field" + fieldMFactory ).change();
						setCover(fieldMFactory);
					}			
				}
			});
  		function setCover(field) {
				var temp = field;
				var htmlShadow = '<div id="shadow_' + temp + '"></div>';
				jQuery("#field" + temp).before(htmlShadow);
				jQuery("#shadow_" + temp).css("z-index",100);
				jQuery("#shadow_" + temp).css("height",30);
				jQuery("#shadow_" + temp).css("width",55);
				jQuery("#shadow_" + temp).css("top",jQuery("#field" + temp).parent().parent().offset().top);
				jQuery("#shadow_" + temp).css("left",jQuery("#field" + temp).parent().parent().offset().left);
				jQuery("#shadow_" + temp).css("position","absolute");
				jQuery("#shadow_" + temp).css("opacity",0.5);
				jQuery("#shadow_" + temp).css("background","#FFFFFF");
		}	 
		 

		<%}%>
		
		
    });
	
	function setRemark(idx, systemValue) {
		var remark = "";
		switch (systemValue)
		{
			//SAP
			case optionDt1SystemSAP:
				//remark = "需要标注所属厂以及具体权限";
				remark = "请注明需要哪些T-CODE";
				break;
			//WEE
			case optionDt1SystemWEE:
				remark = "请注明需要操作的模块";
				break;
			//OA
			case optionDt1SystemOA:
				remark = "请注明需要哪些流程的权限";
				break;
			//MES
			case optionDt1SystemMES:
				remark = "请注明需要查看的工厂/区域和功能";
				break;
			//EMS
			case optionDt1SystemEMS:
				remark = "请注明需要查看的工厂/区域和功能";
				break;
			//FMB
			case optionDt1SystemFMB:
				remark = "请注明需要查看的工厂/区域和功能";
				break;
			//无纸化
			case optionDt1SystemNopaper:
				//remark = "请注明具体需要查看的页面";
				remark = "请注明需要查看的功能";
				break;
			//电脑
			//case "7":
			//	remark = "COMPUTER";
			//	break;
			//上网
			case optionDt1SystemGotonet:
				//remark = "权限类别：普通（内部）、可用QQ或VIP";
				remark = "请注明需要访问哪些网页";
				break;
			//个人邮箱
			case optionDt1SystemEmail:
				remark = "请注明是否需要外发";
				break;
			//SKYPE
			case optionDt1SystemSKYPE:
				remark = "";
				break;
			//FTP共享文件夹
			case optionDt1SystemFTPSFTP:
				//remark = "申请大小和账号名"
				remark = "请注明需要的存储空间，以及文件多长时间清理一次"
				break;
			//SSLVPN
			case optionDt1SystemSSLVPN:
				remark = "请注明系统和地址"
				break;
			//邮件组
			case optionDt1SystemEmailGroup:
				//remark = "邮件组名称、管理人的工号和姓名"
				remark = "请注明组名称，以及包括哪些人"
				break;
			//PEPORT
			case optionDt1SystemReport:
				remark = "请注明需要查看的报表"
				break;
			//USB
			case optionDt1SystemUsb:
				remark = "请注明USB是只读/读写权限"
				break;
			//外部远程协助
			case optionDt1SystemRemote:
				remark = "请注明访问的IP地址,公司,申请起止时间"
				break;
			//服务器数据备份
			case optionDt1SystemBackup:
				remark = "请注明备份服务器的IP地址、服务器的操作系统、需要备份的文件/文件夹的详细路径"
				break;
			//堡垒机
			case optionDt1SystemMachine:
				remark = "请填写系统和IP"
				break;
		    //门禁系统
			case optionDt1SystemEntranceGuard:
				remark="请提供门禁地址";
				break;
			//客户主机托管
			case optionDt1SystemWebHosting:
				remark="请提供客户主机托管信息";
				break;
			//文件共享
			case optionDt1SystemFileShare:
				remark="请提供文件共享信息";
				break;
			default:
				alert("Which system did you choose?");
		}
		jQuery("#field" + fieldDt1Remark + "_" + idx).attr("placeholder", remark);
	}
	
	function setSysadmin(idx, systemValue,FactoryID) {
		var adminspan = jQuery("#field" + fieldDt1Admin + "_" + idx + "span");
		var FactoryID = jQuery("#field" + fieldMFactory).val();
		jQuery(adminspan).empty();
		jQuery.ajax({
			url: "/interface/additional/service_support/it_authority_centralized_application/get_admin_by_systemvalue.jsp",
			data: {"SystemValue": systemValue,"Factoryid":FactoryID},		
			cache: false,
			type: "post",
			dataType: "text",
			success: function (result) {
				result = jQuery.trim(result);
				if(result != '') {
					if(result != 'null') {
						var temp = result.split(";");
						var htmlSystemAdmin = '';
						htmlSystemAdmin = '<span class="e8_showNameClass">';
						htmlSystemAdmin += '<a href="javaScript:openhrm(' + temp[2] + ');" onclick="pointerXY(event);">' + temp[1] + '</a>';
						htmlSystemAdmin += '</span>';
						jQuery(adminspan).append(htmlSystemAdmin);
						jQuery("#field" + fieldDt1Admin + "_" + idx).val(temp[2]);
					}
				}
			}
		});
	}
	
	function setAdminRoles(systemValues,FactoryID) {
		systemValues = jQuery.unique(systemValues);
		var FactoryID = jQuery("#field" + fieldMFactory).val();
		var flag = false;
		jQuery.ajax({
			url: "/interface/additional/service_support/it_authority_centralized_application/get_role_by_systemvalues.jsp",
			data: {"SystemValues": systemValues.toString(),"Factoryid":FactoryID},
			cache: false,
			async: false,
			type: "post",
			dataType: "text",
			success: function (result) {
				result = jQuery.trim(result);
				if(result != '') {
					if(result == 'null') {
						result = "";
					}
					jQuery("#field" + fieldMAdminroles).val(result);
					flag = true;
				}
			}
		});
		return flag;
	}
	
	function setDateExpire(idx) {
		if(!jQuery("#field" + fieldDt2DateExpireFlag + "_" + idx).is(':checked')) {
			jQuery("#field" + fieldDt2DateExpire + "_" + idx).removeAttr("value");
			jQuery("#field" + fieldDt2DateExpire + "_" + idx + "span").text("");
			jQuery("#field" + fieldDt2DateExpire + "_" + idx + "browser").attr("style", "display:none");
		}
		jQuery("#field" + fieldDt2DateExpireFlag + "_" + idx).change(function() { 
			jQuery("#field" + fieldDt2DateExpire + "_" + idx).removeAttr("value");
			jQuery("#field" + fieldDt2DateExpire + "_" + idx + "span").text("");
			if(!jQuery("#field" + fieldDt2DateExpireFlag + "_" + idx).is(':checked')) {
				jQuery("#field" + fieldDt2DateExpire + "_" + idx + "browser").attr("style","display:none");
			} else {
				jQuery("#field" + fieldDt2DateExpire + "_" + idx + "browser").removeAttr("style");
			}
		});
	}
	
	function setCover_d(field, idx) {
		var temp = field + '_' + idx;
		var htmlShadow = '<div id="shadow_' + temp + '"></div>';
		jQuery("#field" + temp).before(htmlShadow);
		jQuery("#shadow_" + temp).css("z-index",100);
		jQuery("#shadow_" + temp).css("height",jQuery("#field" + temp).parent().css("height"));
		jQuery("#shadow_" + temp).css("width",jQuery("#field" + temp).parent().css("width"));
		jQuery("#shadow_" + temp).css("top",jQuery("#field" + temp).parent().offset().top + 1);
		jQuery("#shadow_" + temp).css("left",jQuery("#field" + temp).parent().offset().left + 1);
		jQuery("#shadow_" + temp).css("position","absolute");
		jQuery("#shadow_" + temp).css("opacity",0.5);
		jQuery("#shadow_" + temp).css("background","#FFFFFF");
	}
	
	function buildAuthorityBlock(idx) {
		//建立本次的新BLOCK
		var htmlExistAuthority = '<div id="existAuthorityBlock_' + idx + '" style="position:absolute;display:none;border:1px solid black;background:#e7f3fc;"></div>';
	}
	
	function showDt2Remark(){
		jQuery("#personalRemarkUl").empty();
		jQuery("select[id^='field" + fieldDt1System + "_']").each(function () {
			var systemValue = jQuery(this).val();
			var remark = "";
			switch (systemValue)
			{
				//SAP
				case optionDt1SystemSAP:
					remark = "SAP：需要标注所属厂以及具体权限";
					break;
				//WEE
				case optionDt1SystemWEE:
					remark = "WEE：需要标注所属部门";
					break;
				//OA
				case optionDt1SystemOA:
					remark = "OA：需要标注所属部门";
					break;
				//MES
				case optionDt1SystemMES:
					remark = "MES：需要标注所属部门";
					break;
				//EMS
				case optionDt1SystemEMS:
					remark = "EMS";
					break;
				//FMB
				case optionDt1SystemFMB:
					remark = "FMB：需要标注IP和MAC地址";
					break;
				//无纸化
				case optionDt1SystemNopaper:
					remark = "WUZHIHUA";
					break;
			}
			if(remark != "") {
				jQuery("#personalRemarkUl").append("<li>" + remark + "</li>");
			}
		});
		jQuery("#personalRemarkBlock").css("display","block");
		jQuery("#personalRemarkBlock").css("left", event.clientX);
		jQuery("#personalRemarkBlock").css("top", event.clientY + 10);
	}
	
	function hideDt2Remark(){
		jQuery("#personalRemarkBlock").css("display", "none");
	}
	
	function setAuthBlock(idx) {
		var htmlExistAuthority = '<div id="existAuthorityBlock_' + idx + '" style="position:absolute;display:none;border:1px solid black;background:#e7f3fc;"><ul id="authorityUl_' + idx + '"></ul></div>';
		jQuery("#field" + fieldDt2EmpNo + "_" + idx).after(htmlExistAuthority);
	}
	
	function setHiddenWorkCode(idx) {
		var htmlHiddenWorkCode = '<input id="hiddenWorkCode' + fieldDt2EmpNo + '_' + idx + '" type="hidden" value="">';
		jQuery("#field" + fieldDt2EmpNo + "_" + idx).after(htmlHiddenWorkCode);
	}
	
	function setHiddenAuth(idx) {
		var htmlHiddenAuth = '<input id="hiddenAuth' + fieldDt2EmpNo + '_' + idx + '" type="hidden" value="">';
		jQuery("#field" + fieldDt2EmpNo + "_" + idx).after(htmlHiddenAuth);
	}
	
	function setHover(idx) {
		jQuery("#field" + fieldDt2EmpNo + "_" + idx).hover(
			function(){
				//隐藏BLOCK的内容清空
				jQuery("#authorityUl_" + idx).empty();
				//当前工号的所有权限
				var auths = jQuery("#hiddenAuth" + fieldDt2EmpNo + "_" + idx).val().split(";");
				//当前DT1的所有权限
				var dt1Auths = new Array();
				jQuery("select[id^='field" + fieldDt1System + "_']").each(function(){
					dt1Auths.push(jQuery(this).find("option:selected").text());
				});
				for(var i=0;i<auths.length;i++) {
					for(var j=0;j<dt1Auths.length;j++) {
						if(auths[i].split(":")[0] == dt1Auths[j] && auths[i].replace(/(^s*)|(s*$)/g, "").length !=0) {
							jQuery("#authorityUl_" + idx).append('<li>' + auths[i] + '<li>');
						}
					}
				}
				jQuery("#existAuthorityBlock_" + idx).css("display","block");
				jQuery("#existAuthorityBlock_" + idx).css("left", event.clientX);
				jQuery("#existAuthorityBlock_" + idx).css("top", event.clientY + 10);
			},
			function(){
				jQuery("#existAuthorityBlock_" + idx).css("display", "none");
			}
		);
	}
	
	function dt2EmpNoBlur(idx) {
		var newWorkCode = jQuery("#field" + fieldDt2EmpNo + "_" + idx).val();
		//alert("surprise?");
		if (jQuery("#hiddenWorkCode" + fieldDt2EmpNo + "_" + idx).val() != newWorkCode) {
			jQuery("#hiddenWorkCode" + fieldDt2EmpNo + "_" + idx).val(newWorkCode);
			var allAuth = getAllAuth(newWorkCode);
			jQuery("#hiddenAuth" + fieldDt2EmpNo + "_" + idx).val(allAuth);
		}
	}
	
	function getAllAuth(workCode) {
		//alert("surprise!");
		var info = "";
		jQuery.ajax({
			url: "/interface/additional/service_support/it_authority_centralized_application/get_allauthority.jsp",
			data: {"WorkCode": workCode},
			cache: false,
			async: false,
			type: "post",
			dataType: "text",
			success: function (result) {
				result = jQuery.trim(result);
				if(result != '') {
					if(result == 'null') {
						result = "";
					} else {
						info = result;
					}
					
				}
			}
		});
		return info;
	}
	
	// function deleteMes(idx) {
		// setTimeout(function(){
			// jQuery("#field" + fieldDt1System + "_" + idx + " option[text='MES']").remove();
		// },3000);
	// }
	
	// function selectMes(idx) {
		
		// setTimeout(function(){
			// var mesval = "";
		// },3000);
		// mesval = jQuery("#field" + fieldDt1System + "_" + idx + " option[text='MES']").val();
		// jQuery("#field" + fieldDt1System + "_" + idx).attr("value", mesval);
	// }
	
	// function toggleModule(module) {
		// jQuery("div[name='" + module + "']").toggle(500);
	// }
	// $( document ).ajaxSend(function( event, request, settings ) {
		// $( "#employee" ).append( "<li>Starting request at " + settings.url + "</li>" );
	// });
</script>
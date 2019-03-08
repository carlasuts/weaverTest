<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<%
    int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
	int formid = Util.getIntValue(request.getParameter("formid"));//表单id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
	//dt1
	String fieldDt1DateExpireFlag = BillUtil.getLabelId(formid, 1, "DATE_EXPIRE_FLAG");//14146
	String fieldDt1DateExpire = BillUtil.getLabelId(formid, 1, "DATE_EXPIRE");//14134
	String fieldDt1InternetAccess = BillUtil.getLabelId(formid, 1, "INTERNET_ACCESS");//14134
	String fieldDt1OutgoingMail = BillUtil.getLabelId(formid, 1, "OUTGOING_MAIL");//14134
	String fieldDt1System = BillUtil.getLabelId(formid, 1, "SYSTEM");//14132
	String fieldDt1Remark = BillUtil.getLabelId(formid, 1, "REMARK");//14133
	//dt2
	String fieldDt2EmpRemark = BillUtil.getLabelId(formid, 2, "EMP_REMARK");	
%>
<script>
	//dt1
	var fieldDt1DateExpireFlag = <%=fieldDt1DateExpireFlag%>;
	var fieldDt1DateExpire = <%=fieldDt1DateExpire%>;
	var fieldDt1InternetAccess = <%=fieldDt1InternetAccess%>;
	var fieldDt1OutgoingMail = <%=fieldDt1OutgoingMail%>;
	var fieldDt1System = <%=fieldDt1System%>;//14132;
	var fieldDt1Remark = <%=fieldDt1Remark%>;//14133;
	//dt2
	var fieldDt2EmpRemark = <%=fieldDt2EmpRemark%>;

    jQuery(function () {
		//dt1
		jQuery("button[name=addbutton0]").click(function(){
			var id = jQuery("select[id^='field" + fieldDt1System + "_']").last().attr("id");
			//为获取序号，截个字符串
			var tmp = id.split("_");
			//为权限明细表的备注增加提示信息
			jQuery("#field" + fieldDt1System + "_" + tmp[1]).change(function() {
				var systemValue = jQuery("#field" + fieldDt1System + "_" + tmp[1]).val();
				var remark = "";
				switch (systemValue)
				{
					//SAP
					case "0":
						remark = "需要标注所属厂以及具体权限";
						break;
					//WEE
					case "1":
						remark = "WEE";
						break;
					//OA
					case "2":
						remark = "OA";
						break;
					//MES
					case "3":
						remark = "具体需要查看的工厂和模块";
						break;
					//EMS
					case "4":
						remark = "EMS";
						break;
					//FMB
					case "5":
						remark = "FMB";
						break;
					//无纸化
					case "6":
						remark = "具体需要查看的页面";
						break;
					//电脑
					//case "7":
					//	remark = "COMPUTER";
					//	break;
					//上网
					case "8":
						remark = "权限类别：普通（内部）、可用QQ或VIP";
						break;
					//个人邮箱
					case "9":
						remark = "是否需要外发";
						break;
					//SKYPE
					case "10":
						remark = "SKYPE";
						break;
					//FTP共享文件夹
					case "11":
						remark = "申请大小和账号名"
						break;
					//SSLVPN
					case "12":
						remark = "申请访问的资源（IP地址）"
						break;
					//邮件组
					case "13":
						remark = "邮件组名称、管理人的工号和姓名"
						break;
					default:
						alert("none");
				}
				jQuery("#field" + fieldDt1Remark + "_" + tmp[1]).attr("placeholder", remark);
			});
			//为有效期checkBox设置事件-影响有效期时间显示
			jQuery("#field" + fieldDt1DateExpire + "_" + tmp[1] + "browser").attr("style", "display:none");
			jQuery("#field" + fieldDt1DateExpire + "_" + tmp[1] + "span").attr("style", "display:none");
			jQuery("#field" + fieldDt1DateExpireFlag + "_" + tmp[1]).change(function() { 
				jQuery("#field" + fieldDt1DateExpire + "_" + tmp[1] + "browser").removeAttr("style");
				jQuery("#field" + fieldDt1DateExpire + "_" + tmp[1] + "span").removeAttr("style");
				if(!jQuery("#field" + fieldDt1DateExpireFlag + "_" + tmp[1]).is(':checked')) {
					jQuery("#field" + fieldDt1DateExpire + "_" + tmp[1] + "browser").attr("style","display:none");
					jQuery("#field" + fieldDt1DateExpire + "_" + tmp[1] + "span").attr("style","display:none");
				}
			}); 
		});
		
		var htmlPersonalRemark = '<div id="personalRemarkBlock" style="position:absolute;display:none;border:1px solid silver;background:silver;"><ul id="personalRemarkUl"></ul></div>';
		//jQuery("#personalRemark").after(htmlPersonalRemark);
		jQuery("#oTable1 tbody tr:eq(1) td:last").append(htmlPersonalRemark);
		jQuery("#personalRemark").hover(
			function(){
				//var empRemark = "";
				jQuery("#personalRemarkUl").empty();
				jQuery("select[id^='field" + fieldDt1System + "_']").each(function (index) {
					//alert(jQuery(this).val());
					var systemValue = jQuery(this).val();
					var remark = "";
					switch (systemValue)
					{
						//SAP
						case "0":
							remark = "SAP：需要标注所属厂以及具体权限";
							break;
						//WEE
						case "1":
							remark = "WEE：需要标注所属部门";
							break;
						//OA
						case "2":
							remark = "OA：需要标注所属部门";
							break;
						//MES
						case "3":
							remark = "MES：需要标注所属部门";
							break;
						//EMS
						case "4":
							remark = "EMS";
							break;
						//FMB
						case "5":
							remark = "FMB：需要标注IP和MAC地址";
							break;
						//无纸化
						case "6":
							remark = "WUZHIHUA";
							break;
						//电脑
						//case "7":
						//	remark = "COMPUTER";
						//	break;
						//上网
						//case "8":
						//	remark = "NET";
						//	break;
						//个人邮箱
						//case "9":
						//	remark = "MAIL";
						//	break;
						//SKYPE
						//case "10":
						//	remark = "SKYPE";
						//	break;
						//FTP共享文件夹
						//case "11":
						//	remark = "请输入申请大小和关联需求号"
						//	break;
						//SSLVPN
						//case "12":
						//	remark = "申请访问的资源（IP地址）"
						//	break;
						//邮件组
						//case "13":
						//	remark = "请输入邮件组管理人的工号和姓名"
						//	break;
						//default:
						//	alert("none");
						
					}
					//alert("<li>" + remark + "</li>");
					if(remark != "") {
						jQuery("#personalRemarkUl").append("<li>" + remark + "</li>");
					}
					//empRemark += jQuery(this).val() + "<br>";
				});
				//var lis = jQuery("#personalRemarkUl").children("li");
				//jQuery.unique(lis);
				//jQuery("#personalRemarkUl").empty();
				//jQuery("#personalRemarkUl").append(lis);
				//jQuery.each(lis, function(index,val) {
				//	jQuery("#personalRemarkUl").append("<li>" + val + "</li>");
				//});
				//jQuery("#personalRemarkBlock").text(empRemark);
				jQuery("#personalRemarkBlock").css("display","block");
				jQuery("#personalRemarkBlock").css("left", event.clientX);
				jQuery("#personalRemarkBlock").css("top", event.clientY + 10);
			},
			function(){
				jQuery("#personalRemarkBlock").css("display", "none");
			}
		);
    });
	
	function toggleModule(module) {
		jQuery("div[name='" + module + "']").toggle(500);
	}
</script>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.hrm.*"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
int requestid = Util.getIntValue(request.getParameter("requestid"));//请求id
int formid = Util.getIntValue(request.getParameter("formid"));
int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id

//获取节点ID
int nodeidApply = BillUtil.getNodeId(workflowid, "货代提交进厂申请");
int nodeidSecurity = BillUtil.getNodeId(workflowid, "安保审核信息");
int nodeidFianl = BillUtil.getNodeId(workflowid, "归档");

String iftemporary = BillUtil.getLabelId(formid,0,"iftemporary");//临时、长期送货
String longtime = BillUtil.getLabelId(formid,0,"longtime");//长期提货时间
String trans_company = BillUtil.getLabelId(formid,0,"trans_company");// 货运公司名称
String date1 = BillUtil.getLabelId(formid,0,"date1");// 接收日期
String stage = BillUtil.getLabelId(formid,0,"stage");// 期别
String entrepot_type = BillUtil.getLabelId(formid,0,"entrepot_type");// 提、送货地点
%>

<script src="/interface/ES6support/browser.min.js"  ></script>

<script type="text/javascript">
	var requestid = <%=requestid%>
	var formid = <%=formid%>
	var iftemporary = <%=iftemporary%>
	var longtime = <%=longtime%>
	var nodeid = <%=nodeid%>
	var trans_company = <%=trans_company%>
	var date1 = <%=date1%>
	var stage = <%=stage%>
	var entrepot_type = <%=entrepot_type%>
	var mainrequestid = "";
	var transCompany = $("#field" + trans_company).val();
	var day = "";
	var indexdesctwo = 0;
	var currentDate = "";
	
	jQuery.ajax({
		url: "/interface/additional/quality_dept/transport/transportAjax.jsp",
		data: {requestid:requestid},
		cache: false,
		async: false,
		type: "get",
		dataType: "json",
		success: function (result) {
			mainrequestid = result.mainrequestid;
			currentDate = result.currentDate;
			if (mainrequestid != "") {
				setCover(iftemporary);
				setCover(longtime);
			}
		}
	});
	
	jQuery.ajax({
		url: "/interface/additional/quality_dept/transport/transportApplyAjax.jsp",
		data: {transCompany:transCompany},
		cache: false,
		async: false,
		type: "get",
		dataType: "json",
		success: function (result) {
			day = result.day;
			indexdesctwo = result.indexdesctwo;

		}
	});

	
	function setCover(field) {
		var temp = field;
		var htmlShadow = '<div id="shadow_' + temp + '"></div>';
		jQuery("#field" + temp).before(htmlShadow);
		jQuery("#shadow_" + temp).css("z-index",100);
		jQuery("#shadow_" + temp).css("height",jQuery("#field" + temp).parent().parent().parent().css("height"));
		jQuery("#shadow_" + temp).css("width",jQuery("#field" + temp).parent().parent().css("width"));
		jQuery("#shadow_" + temp).css("top",jQuery("#field" + temp).parent().parent().offset().top);
		jQuery("#shadow_" + temp).css("left",jQuery("#field" + temp).parent().parent().offset().left);
		jQuery("#shadow_" + temp).css("position","absolute");
		jQuery("#shadow_" + temp).css("opacity",0.5);
		jQuery("#shadow_" + temp).css("background","#FFFFFF");
	}
	
	
	<%if(nodeid == nodeidApply){%>
		checkCustomize = function() {// 申请节点卡控
			var flag = false;
			var if_temporary  = $("#field" + iftemporary).val();
			var currentid = "";
			
			if (if_temporary == 0) {
				flag = true;
			} else {
				if (mainrequestid != "") {
					flag = true;
				} else {// 新建的流程
					if (indexdesctwo == 0) {// 长期三个月
						if (day < 3 * 60) {
							alert("此货运公司存在长期授权流程，不允许提交新的长期流程");
						} else {
							flag = true;
						}
					} else {// 长期六个月
						if (day < 6 * 60) {
							alert("此货运公司存在长期授权流程，不允许提交新的长期流程");
						} else {
							flag = true;
						}
					}
				}
			}
			return flag;
		}
	<%}%>
	
	<%if(nodeid == nodeidSecurity){%>
		checkCustomize = function() {// 安保节点卡控 61341
			var flag = false;
			var date = $("#field" + date1).val();
			var stageValue = $("#field" + stage).val();
			var entrepotType = $("#field" + entrepot_type).val();
			var wfqty = "";
			jQuery.ajax({
				url: "/interface/additional/quality_dept/transport/transportSecurityAjax.jsp",
				data: {date:date,stageValue:stageValue,entrepotType:entrepotType},
				cache: false,
				async: false,
				type: "post",
				dataType: "json",
				success: function (result) {
					wfqty = result.WFQTY;
				}
			});
			if (wfqty >= 5) {
				alert("当前同一仓库停车位已满，请稍后再放闸");
			} else {
				flag = true;
			}
			return flag;
		}
		
	<%}%>
</script>
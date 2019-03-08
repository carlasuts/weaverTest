<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<%
    int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
	int formid = Util.getIntValue(request.getParameter("formid"));//表单id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id

	int nodeStart = BillUtil.getNodeId(workflowid, "01 CPStart");
	int nodeA = BillUtil.getNodeId(workflowid, "02-A ChooseMatShortDescA");
	int nodeB = BillUtil.getNodeId(workflowid, "02-B ChooseMatShortDescB");
	int nodeCheckA = BillUtil.getNodeId(workflowid, "03 CPSubmit");
	
	String fieldNumCustLotIdInRecord = BillUtil.getLabelId(formid, 1, "CUST_LOT_ID");//11562
	String fieldNumMatGrp5InRecord = BillUtil.getLabelId(formid, 1, "MAT_GRP_5");//11563;
	
	String fieldNumCustLotId = BillUtil.getLabelId(formid, 2, "CUST_LOT_ID");//10463;
	String fieldNumMatGrp5 = BillUtil.getLabelId(formid, 2, "MAT_GRP_5");//10468;
	String fieldNumMatShortDescA = BillUtil.getLabelId(formid, 2, "MAT_SHORT_DESC_A");//11591;
	String fieldNumMatShortDescB = BillUtil.getLabelId(formid, 2, "MAT_SHORT_DESC_B");//11592;
	String fieldNumMatIdA = BillUtil.getLabelId(formid, 2, "MAT_ID_NEW_A");//11581;
	String fieldNumMatIdB = BillUtil.getLabelId(formid, 2, "MAT_ID_NEW_B");//11582;
	String fieldNumFlowA = BillUtil.getLabelId(formid, 2, "FLOW_NEW_A");//11583;
	String fieldNumFlowB = BillUtil.getLabelId(formid, 2, "FLOW_NEW_B");//11584;
	String fieldNumOperA = BillUtil.getLabelId(formid, 2, "OPER_NEW_A");//11585;
	String fieldNumOperB = BillUtil.getLabelId(formid, 2, "OPER_NEW_B");//11586;
	String fieldNumCustData1 = BillUtil.getLabelId(formid, 2, "CUST_DATA_1");//11721;
	String fieldNumCustData2 = BillUtil.getLabelId(formid, 2, "CUST_DATA_2");//11722;
	String fieldNumCompare = BillUtil.getLabelId(formid, 2, "COMPARE");//11516;
%>
<script>
	var fieldNumCustLotIdInRecord = <%=fieldNumCustLotIdInRecord%>;//11562
	var fieldNumMatGrp5InRecord = <%=fieldNumMatGrp5InRecord%>;//11563;
	
	var fieldNumCustLotId = <%=fieldNumCustLotId%>;//10463;
	var fieldNumMatGrp5 = <%=fieldNumMatGrp5%>;//10468;
	var fieldNumMatShortDescA = <%=fieldNumMatShortDescA%>;//11591;
	var fieldNumMatShortDescB = <%=fieldNumMatShortDescB%>;//11592;
	var fieldNumMatIdA = <%=fieldNumMatIdA%>;//11581;
	var fieldNumMatIdB = <%=fieldNumMatIdB%>;//11582;
	var fieldNumFlowA = <%=fieldNumFlowA%>;//11583;
	var fieldNumFlowB = <%=fieldNumFlowB%>;//11584;
	var fieldNumOperA = <%=fieldNumOperA%>;//11585;
	var fieldNumOperB = <%=fieldNumOperB%>;//11586;
	var fieldNumCustData1 = <%=fieldNumCustData1%>;//11721;
	var fieldNumCustData2 = <%=fieldNumCustData2%>;//11722;
	var fieldNumCompare = <%=fieldNumCompare%>;//11516;
	
	<%if(nodeid == nodeA){%>
		var node = "A";
		var fieldNumMatShortDesc = fieldNumMatShortDescA;
		var fieldNumMatId = fieldNumMatIdA;
		var fieldNumFlow = fieldNumFlowA;
		var fieldNumOper = fieldNumOperA;
	<%} else if(nodeid == nodeB){%>
		var node = "B";
		var fieldNumMatShortDesc = fieldNumMatShortDescB;
		var fieldNumMatId = fieldNumMatIdB;
		var fieldNumFlow = fieldNumFlowB;
		var fieldNumOper = fieldNumOperB;
	<%}%>

    jQuery(function () {
		//把DT1的增加行按钮给隐藏起来
		jQuery("button[id*='addbutton0']").attr("style","display:none");
		//在开始的时候，提供数据查询
		<%if(nodeid == nodeStart){%>
			//htmlMatGrp5Span = '<span>请输入客户品名</span>';
			htmlMatGrp5Input = '<input id="matGrp5Input" type="text" style="width:95%;"/>';
			htmlQueryButton = '<input id="getDt1Button" type="button" onclick="getDt1ByMatGrp5();" value="查询"/>';
			//jQuery("#matGrp5Div").append(htmlMatGrp5Span);
			jQuery("#matGrp5Div").append(htmlMatGrp5Input);
			jQuery("#matGrp5ButtonDiv").append(htmlQueryButton);
		<%}%>
		//如果节点是这俩才可操作
        <%if(nodeid == nodeA || nodeid == nodeB){%>
		jQuery("input[id^='field" + fieldNumMatGrp5 + "_']").each(function (index) {
			//为获取序号，截个字符串
			var tmp = this.id.split("_");
			//客户品名就是这个值
			var matGrp5 = jQuery("#field" + fieldNumMatGrp5 + "_" + tmp[1]).val();
			//
			jQuery("#field" + fieldNumMatShortDesc + "_" + tmp[1]).attr("style","display:none");
			jQuery("#field" + fieldNumMatId + "_" + tmp[1]).attr("style","display:none");
			jQuery("#field" + fieldNumFlow + "_" + tmp[1]).attr("style","display:none");
			jQuery("#field" + fieldNumOper + "_" + tmp[1]).attr("style","display:none");
			//
			jQuery("#field" + fieldNumMatShortDesc + "_" + tmp[1] + "span").attr("style","display:none");
			
			//jQuery("#field11581_" + tmp[1] + "span").attr("style","display:none");
			//jQuery("#field11582_" + tmp[1] + "span").attr("style","display:none");
			jQuery("#field" + fieldNumFlow + "span").attr("style","display:none");
			jQuery("#field" + fieldNumOper + "span").attr("style","display:none");
			//向jsp发送客户品名数据，获取MAT_SHORT_DESC
			jQuery.ajax({
				url: "/interface/xsy/Tfme_74_GetDt2MatShortDescByMatGrp5.jsp",
				data: {"MatGrp5" : jQuery("#field" + fieldNumMatGrp5 + "_" + tmp[1]).val()},
				cache: false,
				type: "post",
				async: false,
				dataType: "text",
				success: function (result) {
					if(result!='') {
						result = jQuery.trim(result);
						//将收到的结果转成数组
						var matShortDescs = result.split(",");
						
						//准备带插入的select框
						var html_select_matshordesc ="";
						html_select_matshordesc +='<select id="select_matshordesc_' + node + '_' + tmp[1] + '" onchange="setMatShortDesc(' + fieldNumMatShortDesc + ',' + tmp[1] + ',this.value);">';
						html_select_matshordesc +='<option value =""></option>';
						for(var i=0;i<matShortDescs.length;i++){
							html_select_matshordesc +=' <option value ="'+matShortDescs[i]+'">'+matShortDescs[i]+'</option>';
						}
						html_select_matshordesc +='</select>';
						//将input改写
						jQuery("#select_matshordesc_" + node + "_" + tmp[1]).remove();
						jQuery("#field" + fieldNumMatShortDesc + "_" + tmp[1] + "span").before(html_select_matshordesc);
						
					}
				}
			});
		});
	<%}%>
	<%if(nodeid == nodeCheckA){%>
		jQuery("input[id^='field" + fieldNumCustLotId + "_']").each(function (index) {
			var temp = this.id.split("_");
			var rowid = temp[1];
			var matShortDescA = jQuery("#field" + fieldNumMatShortDescA + "_" + temp[1] + "span").text();
			var matShortDescB = jQuery("#field" + fieldNumMatShortDescB + "_" + temp[1] + "span").text();
			var matIdA = jQuery("#field" + fieldNumMatIdA + "_" + temp[1] + "span").text();
			var matIdB = jQuery("#field" + fieldNumMatIdB + "_" + temp[1] + "span").text();
			var flowA = jQuery("#field" + fieldNumFlowA + "_" + temp[1] + "span").text();
			var flowB = jQuery("#field" + fieldNumFlowB + "_" + temp[1] + "span").text();
			var operA = jQuery("#field" + fieldNumOperA + "_" + temp[1] + "span").text();
			var operB = jQuery("#field" + fieldNumOperB + "_" + temp[1] + "span").text();
			if(matShortDescA == matShortDescB && matIdA == matIdB && flowA == flowB && operA == operB && matShortDescA != "" && matShortDescB !="") {
				jQuery("#field" + fieldNumCompare + "_" + temp[1] + "span").text("S");
				jQuery("#field" + fieldNumCompare + "_" + temp[1] + "span").attr("style","color:green;");
				jQuery("#field" + fieldNumCompare + "_" + temp[1] ).val("S");
			} else if (matShortDescA == "" && matShortDescB =="") {
				jQuery("#field" + fieldNumCompare + "_" + temp[1] + "span").text("N");
				jQuery("#field" + fieldNumCompare + "_" + temp[1] ).val("N");
				jQuery("#field" + fieldNumCompare + "_" + temp[1] ).parent().parent().attr("style","display:none");
			} else {
				//mat_short_desc
				if(matShortDescA != matShortDescA) {
					jQuery("#field" + fieldNumMatShortDescA + "_" + temp[1] + "span").attr("style","color:red;");
					jQuery("#field" + fieldNumMatShortDescB + "_" + temp[1] + "span").attr("style","color:red;");
				}
				//mat 1 2 span
				if(matIdA != matIdB) {
					jQuery("#field" + fieldNumMatIdA + "_" + temp[1] + "span").attr("style","color:red;");
					jQuery("#field" + fieldNumMatIdB + "_" + temp[1] + "span").attr("style","color:red;");
				}
				//flow
				if(flowA != flowB) {
					jQuery("#field" + fieldNumFlowA + "_" + temp[1] + "span").attr("style","color:red;");
					jQuery("#field" + fieldNumFlowB + "_" + temp[1] + "span").attr("style","color:red;");
				}
				//oper
				if(operA != operB) {
					jQuery("#field" + fieldNumOperA + "_" + temp[1] + "span").attr("style","color:red;");
					jQuery("#field" + fieldNumOperB + "_" + temp[1] + "span").attr("style","color:red;");
				}
				//compare
				jQuery("#field" + fieldNumCompare + "_" + temp[1] + "span").text("E");
				jQuery("#field" + fieldNumCompare + "_" + temp[1] + "span").attr("style","color:red;");
				jQuery("#field" + fieldNumCompare + "_" + temp[1] ).val("E")
			}
			jQuery("#field" + fieldNumCompare + "_" + temp[1] ).attr("style","display:none");
		});
		
		checkCustomize = function() {
			var flag = true;
			jQuery("span[id^='field" + fieldNumCompare + "_']").each(function(index) {
				if(jQuery(this).text()!="S"){
					flag = false;
				}
			});
			return flag;
		}
	 <%}%>
    });
	function getDt1ByMatGrp5() {
		//向GetDt1ByMatGrp5的jsp发送请求，获取填写内容，并填写至DT1的页面表格
		jQuery.ajax({
			url: "/interface/xsy/Tfme_74_GetDt1ByMatGrp5.jsp",
			data: {"MatGrp5": jQuery("#matGrp5Input").val()},
			cache: false,
			type: "post",
			dataType: "text",
			async: false,
			success: function (result) {
				result = jQuery.trim(result);
				if(result!='') {
					var rows = result.split(";");
					for(var i=0; i < rows.length; i++){
						var content = rows[i].split(",");
						var custLotIdInRecord = content[0];
						var matGrp5InRecord = content[1];
						addRow0(0);
						var num = jQuery("#oTable0 tbody tr:last td:first input").val();
						//CUST_LOT_ID 
						jQuery("#field" + fieldNumCustLotIdInRecord + "_" + num).val(custLotIdInRecord);
						jQuery("#field" + fieldNumCustLotIdInRecord + "_" + num).attr("style","display:none");
						jQuery("#field" + fieldNumCustLotIdInRecord + "_" + num + "span").text(custLotIdInRecord);
						//MAT_GRP_5 
						jQuery("#field" + fieldNumMatGrp5InRecord + "_" + num).val(matGrp5InRecord);
						jQuery("#field" + fieldNumMatGrp5InRecord + "_" + num).attr("style","display:none");
						jQuery("#field" + fieldNumMatGrp5InRecord + "_" + num + "span").text(matGrp5InRecord);
					}
				}
			}
		});
	}
	function setMatShortDesc(field, num, matShortDesc) {
		jQuery("#field" + field + "_" + num).val(matShortDesc);
		jQuery("#field" + field + "_" + num).attr("style","display:none");
		jQuery("#field" + field + "_" + num + "span").text(matShortDesc);
		jQuery("#field" + field + "_" + num + "span").attr("style","display:none");
		setMatId(fieldNumMatId, num, matShortDesc);

	}
	function setMatId(field, num, matShortDesc){
		jQuery.ajax({
			url: "/interface/xsy/Tfme_74_GetDt2MatIdByMatShortDesc.jsp",
			data: {"MatShortDesc": matShortDesc},
			cache: false,
			type: "post",
			dataType: "text",
			success: function (result) {
				jQuery("#field" + field + "_" + num).val("");
				jQuery("#field" + field + "_" + num + "span").text("");
				result = jQuery.trim(result);
				if(result!='') {
					//如果返回了null，就把FLOW和OPER项全设置成空字符串，否则就设置MAT_ID
					if(result=='null') {
						jQuery("#field" + field + "_" + num).val("");
						jQuery("#field" + field + "_" + num).attr("style","display:none");
						jQuery("#field" + field + "_" + num + "span").text("");
						jQuery("#select_flow_" + node + "_" + num).remove();
						jQuery("#field" + fieldNumFlow + "_" + num).val("");
						jQuery("#field" + fieldNumFlow + "_" + num).attr("style","display:none");
						jQuery("#field" + fieldNumFlow + "_" + num + "span").text("");
						jQuery("#field" + fieldNumFlow + "_" + num + "span").attr("style","display:none");
						jQuery("#select_oper_" + node + "_" + num).remove();
						jQuery("#field" + fieldNumOper + "_" + num).val("");
						jQuery("#field" + fieldNumOper + "_" + num).attr("style","display:none");
						jQuery("#field" + fieldNumOper + "_" + num + "span").text("");
						jQuery("#field" + fieldNumOper + "_" + num + "span").attr("style","display:none");
					} else {
						var matId = result
						//先给自己赋值
						jQuery("#field" + field + "_" + num).val(matId);
						jQuery("#field" + field + "_" + num).attr("style","display:none");
						jQuery("#field" + field + "_" + num + "span").text(matId);
						//再生成对应MAT_ID的下拉框
						getFlows(num, matId);
					}
				}
			}
		});
	}
	//获取当前matId对应的所有Flow，并生成SELECT框
	function getFlows(num, matId){	
		jQuery.ajax({
			url: "/interface/xsy/Tfme_74_GetDt2FlowByMatId.jsp",
			data: {"MatId": matId},
			cache: false,
			type: "post",
			async: false,
			success: function (result) {

				jQuery("#select_flow_" + node + "_" + num).remove();

				if(result!='') {
					result = jQuery.trim(result);
					var flows = result.split(",");
					var htmlSelectFlow = '<select id="select_flow_' + node + '_' + num + '" onchange="setNewFlow(' + fieldNumFlow + ', ' + num + ', this.value)">';
					htmlSelectFlow += '<option value =""></option>';
					for(var i = 0; i < flows.length; i++) {
						htmlSelectFlow += '<option value ="' + flows[i] + '">'+flows[i]+'</option>';
					}
					htmlSelectFlow += '</select">';
					jQuery("#select_flow_" + node + "_" + num).remove();
					jQuery("#field" + fieldNumFlow + "_" + num).before(htmlSelectFlow);
					jQuery("#field" + fieldNumFlow + "_" + num).attr("style","display:none");
					jQuery("#field" + fieldNumFlow + "_" + num + "span").attr("style","display:none");
				}
			}
		});
	}
	function setNewFlow(field, num, flow){
		jQuery("#field" + field + "_" + num).val(flow);
		jQuery("#field" + field + "_" + num).attr("style","display:none");
		jQuery("#field" + field + "_" + num + "span").text(flow);
		jQuery("#field" + field + "_" + num + "span").attr("style","display:none");
		getOpers(num, flow);
	}
	function getOpers(num, flow){
		jQuery.ajax({
			url: "/interface/xsy/Tfme_74_GetDt2OperByFlow.jsp",
			data: {"Flow": flow},
			cache: false,
			type: "post",
			//async: false,
			success: function (result) {

					jQuery("#select_oper_" + node + "_" + num).remove();

				result = jQuery.trim(result);
				if(result!='') {
					var opers = result.split(",");
					
					var htmlSelectOper = '<select id="select_oper_' + node +'_' + num + '" onchange="setOper(' + fieldNumOper + ', ' + num + ',this.value);">';
					htmlSelectOper += '<option value =""></option>';
					for(var i = 0; i < opers.length; i++) {
						htmlSelectOper += '<option value ="' + opers[i] + '">'+opers[i]+'</option>';
					}
					htmlSelectOper += '</select">';
					jQuery("#field" + fieldNumOper + "_" + num).before(htmlSelectOper);
					jQuery("#field" + fieldNumOper + "_" + num).attr("style","display:none");
					jQuery("#field" + fieldNumOper + "_" + num + "span").attr("style","display:none");
				}
			}
		});
	}
	function setOper(field, num, oper){
		jQuery("#field" + field + "_" + num).val(oper);
		jQuery("#field" + field + "_" + num).attr("style","display:none");
		jQuery("#field" + field + "_" + num + "span").text(oper);
		jQuery("#field" + field + "_" + num + "span").attr("style","display:none");
	}
</script>
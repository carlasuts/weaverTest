<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
    int requestid = Util.getIntValue(request.getParameter("requestid"));//请求id
    int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
    int formid = Util.getIntValue(request.getParameter("formid"));//表单id
    int isbill = Util.getIntValue(request.getParameter("isbill"));//表单类型，1单据，0表单
    int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
	String delivery = BillUtil.getLabelId(formid,0,"delivery_qty");//配送次数
	String inv_id4 = BillUtil.getLabelId(formid,4,"inv_id");//明细表4物料号
	String inv_id5 = BillUtil.getLabelId(formid,5,"inv_id");//明细表5物料号
	String inv_id6 = BillUtil.getLabelId(formid,6,"inv_id");//明细表6物料号
	
	//获取节点ID
	int nodeidApply = BillUtil.getNodeId(workflowid, "申请");
	
%>
<!--<script type="text/javascript" src="/interface/js/dirtycheck.js"></script>-->
<script  type="text/javascript">
	var delivery = <%=delivery%>;
	
	var inv_id4 = <%=inv_id4%>;
	var inv_id5 = <%=inv_id5%>;
	var inv_id6 = <%=inv_id6%>;
	var nodeidApply = <%=nodeidApply%>;
	var selectedValue = "";
	jQuery(function(){		
		bottondisable(true, true, true);
		$("#field"+delivery).bindPropertyChange(function(e){					
			if(selectedValue != "" && (e.value == "" || parseInt(selectedValue) > parseInt(e.value))){
				var showValue = "";
				if(e.value == ""){
					showValue = "空";
				} else {
					showValue = $("#field"+delivery+" option:selected").text();
				}
				//确认是否更改变更次数
				if (confirm("确定将配送次数改为" + showValue + "?")) {
					removeRow(e.value);
				}
			}
			//控制添加行按钮
			if(e.value == "0"){
				bottondisable(false, true, true);
			} else if (e.value == "1") {
				bottondisable(false, false, true);
			} else if(e.value == "2") {
				bottondisable(false, false, false);
			} else {
				bottondisable(true, true, true);
			}
			selectedValue = e.value;
		});
	});	
	
	function bottondisable(botton1,botton2,botton3){
		document.getElementById("$addbutton3$").disabled=botton1;
		document.getElementById("$addbutton4$").disabled=botton2; 
		document.getElementById("$addbutton5$").disabled=botton3;
	}
	
	function removeRow(e) {
		if(e == "0") {
			removeallmx(4);
			removeallmx(5);
		} else if(e == "1") {
			removeallmx(5);
		} else if(e == "2") {			
		} else {
			removeallmx(3);
			removeallmx(4);
			removeallmx(5);
		}
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
			// top.Dialog.top.Dialog.alert(SystemEnv.getHtmlNoteName(3529, language));
			return;
		}
	}
	//删除所有明细
	function removeallmx(mxnum){
		var checkboxs = jQuery("input[name='check_node_"+mxnum+"']");
		jQuery("input[name='check_node_"+mxnum+"']").each(function(index) {
			checkboxs.eq(index).attr("checked",true);
		});
		if(checkboxs.length!=0){
			delRowmx(mxnum);
		}
	}
	
	<%if(nodeid == nodeidApply){%>
		checkCustomize = function() {
			var flag = true;						
						
			var selectedValue = document.getElementById("field"+delivery).options[document.getElementById("field"+delivery).selectedIndex].value;			
			var detail4 = false;
			var detail5 = false;
			var detail6 = false;
			var warningValue = "";
			var indexValue = "";		
			
			jQuery("input[id^='field"+ inv_id4 +"_']").each(function(index) {
				detail4 = true;
			});
			
			jQuery("input[id^='field"+ inv_id5 +"_']").each(function(index) {
				detail5 = true;
			});
			
			jQuery("input[id^='field"+ inv_id6 +"_']").each(function(index) {
				detail6 = true;
			});			
			
			if(selectedValue == "0") {
				if(detail4 == false) {
					warningValue = "配送次数为1，无第一次配送数据！";
				}
			} else if(selectedValue == "1") {
				if(detail4 == false) {
					indexValue = "一、";
				} 
				if(detail5 == false) {
					indexValue += "二、";
				}
				if(indexValue != ""){
					warningValue = "配送次数为2，无第" + indexValue.substr(0,indexValue.length - 1) + "次配送数据！";
				}
			} else if(selectedValue == "2") {
				if(detail4 == false) {
					indexValue = "一、";
				} 
				if(detail5 == false) {
					indexValue += "二、";
				}
				if(detail6 == false) {
					indexValue += "三、";
				}
				if(indexValue != ""){
					warningValue = "配送次数为3，无第" + indexValue.substr(0,indexValue.length-1) + "次配送数据！";
				}
			}
			
			if(warningValue != "") {
				flag = false;
				alert(warningValue);
			}
			return flag;
		}
	<%}%>
	
</script>
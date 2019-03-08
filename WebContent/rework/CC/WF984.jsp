<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="java.util.Map" %>
<%@ page import="weaver.interfaces.workflowUtil.BillFieldUtil" %>
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
	Map MainTable = BillFieldUtil.getFieldId(formid, "0");

	Map DetailTable1 = BillFieldUtil.getFieldId(formid, "1");//明细表1
	Map DetailTable2 = BillFieldUtil.getFieldId(formid, "2");//明细表2
	Map DetailTable3 = BillFieldUtil.getFieldId(formid, "3");//明细表2
%>


<script type="text/javascript">
	//text/babel
	var workflowpage = {};
 jQuery(function () {
	 jQuery(".mainTd_11_5").css({"cursor":"pointer","-webkit-border-radius": "15px","border-radius": "15px","background-color": "#2B91D5"});
	 jQuery(".mainTd_11_5").click(function(){
		      dosearch();
	 });
});

 function dosearch(){
	 var CUSTOMER = jQuery("#field<%=MainTable.get("customer")%>").val();
	 var LOT_ID = jQuery("#field<%=MainTable.get("lot_id")%>").val();
	 var ASSY_LOT_CODE = jQuery("#field<%=MainTable.get("assy_lot_code")%>").val();
	 var CUST_RUN_ID = jQuery("#field<%=MainTable.get("cust_run_id")%>").val();
	 var MAT_ID = jQuery("#field<%=MainTable.get("mat_id")%>").val();

	 jQuery.ajax({
		 url: "/interface/rework/CC/WF984ajaxaction.jsp",
		 data: {type: 1,CUSTOMER:CUSTOMER,LOT_ID:LOT_ID,ASSY_LOT_CODE:ASSY_LOT_CODE,CUST_RUN_ID:CUST_RUN_ID,MAT_ID:MAT_ID},
		 cache: false,
		 async: false,
		 type: "post",
		 dataType: "json",
		 success: function (result) {

			 var checkboxs = jQuery("input[name='check_node_0']");
			 jQuery("input[name='check_node_0']").each(function(index) {
				 checkboxs.eq(index).attr("checked",true);
			 });
			 if(checkboxs.length!=0){
				 delRowmx(0);
			 }
			 var mxid = Number(jQuery("#indexnum0").val());
			 for(var i=0;i<result.length;i++){
				 addRow0(0);
				 jQuery("#field<%=DetailTable1.get("lot_code")%>_"+mxid).val(result[i].LOT_CODE);
				 document.getElementById("field"+ <%=DetailTable1.get("lot_code")%> +"_"+mxid).readOnly=true;
				 jQuery("#field<%=DetailTable1.get("material")%>_"+mxid).val(result[i].MATERIAL);
				 document.getElementById("field"+ <%=DetailTable1.get("material")%> +"_"+mxid).readOnly=true;
				 jQuery("#field<%=DetailTable1.get("qty")%>_"+mxid).val(result[i].QTY);
				 document.getElementById("field"+ <%=DetailTable1.get("qty")%> +"_"+mxid).readOnly=true;
				 jQuery("#field<%=DetailTable1.get("sub_production_order")%>_"+mxid).val(result[i].SUB_PRODUCTION_ORDER);
				 document.getElementById("field"+ <%=DetailTable1.get("sub_production_order")%> +"_"+mxid).readOnly=true;
				 jQuery("#field<%=DetailTable1.get("assy_lot")%>_"+mxid).val(result[i].ASSY_LOT);
				 document.getElementById("field"+ <%=DetailTable1.get("assy_lot")%> +"_"+mxid).readOnly=true;
				 jQuery("#field<%=DetailTable1.get("batch")%>_"+mxid).val(result[i].BATCH);
				 document.getElementById("field"+ <%=DetailTable1.get("batch")%> +"_"+mxid).readOnly=true;
				 jQuery("#field<%=DetailTable1.get("production_order")%>_"+mxid).val(result[i].PRODUCTION_ORDER);
				 document.getElementById("field"+ <%=DetailTable1.get("production_order")%> +"_"+mxid).readOnly=true;
				 jQuery("#field<%=DetailTable1.get("sales_order")%>_"+mxid).val(result[i].SALES_ORDER);
				 document.getElementById("field"+ <%=DetailTable1.get("sales_order")%> +"_"+mxid).readOnly=true;
				 jQuery("#field<%=DetailTable1.get("description")%>_"+mxid).val(result[i].DESCRIPTION);
				 document.getElementById("field"+ <%=DetailTable1.get("description")%> +"_"+mxid).readOnly=true;
				 jQuery("#field<%=DetailTable1.get("wafer_lot")%>_"+mxid).val(result[i].WAFER_LOT);
				 document.getElementById("field"+ <%=DetailTable1.get("wafer_lot")%> +"_"+mxid).readOnly=true;
				 jQuery("#field<%=DetailTable1.get("trace_code")%>_"+mxid).val(result[i].TRACE_CODE);
				 document.getElementById("field"+ <%=DetailTable1.get("trace_code")%> +"_"+mxid).readOnly=true;
				 jQuery("#field<%=DetailTable1.get("storage_location")%>_"+mxid).val(result[i].STORAGE_LOCATION);
				 document.getElementById("field"+ <%=DetailTable1.get("storage_location")%> +"_"+mxid).readOnly=true;
				 jQuery("#field<%=DetailTable1.get("wxs")%>_"+mxid).val(result[i].WXS);
				 document.getElementById("field"+ <%=DetailTable1.get("wxs")%> +"_"+mxid).readOnly=true;
				 mxid++;
			 }

		 }
	 });
	 return 1;
 }
</script>
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
<script src="/interface/ES6support/browser.min.js"  ></script>

<script type="text/babel">
	var workflowpage = {};
 jQuery(function () {
	 jQuery(".mainTd_9_5").css({"cursor":"pointer",	"-webkit-border-radius": "15px","border-radius": "15px","background-color": "#2B91D5"});
	 jQuery(".mainTd_9_5").click(function(){
		      dosearch();
		      workflowpage.dosearch2();
		 var mergeinfo = new mergeInfo();
			 mergeinfo.init();
			 mergeinfo.merge();
			 mergeinfo.aftermerge();
//		 let promise = new Promise(function (resolve) {
//		 var b =	 dosearch();
//			 if(b){
//				 resolve('hello');
//			 }else{
//				 reject('fail');
//			 }
//
//		 });
//		 promise.then(function(value) {
//		 var b = workflowpage.dosearch2();
//			 if(b){
//				 resolve('hello');
//			 }else{
//				 reject('fail');
//			 }
//		 }, function(error) {
//			 // failure
//		 });
//		 promise.then(function(value) {
//			var mergeinfo = new mergeInfo();
//			 mergeinfo.init();
//			 mergeinfo.merge();
//			 mergeinfo.aftermerge();
//		 }, function(error) {
//			 // failure
//		 });
	 });
	 jQuery("#field<%=MainTable.get("mergemode")%>").bindPropertyChange(function(){
		 if(jQuery("#nodesnum1").val()!='0'){
			 var mergeinfo = new mergeInfo();
			 mergeinfo.init();
			 mergeinfo.merge();
			 mergeinfo.aftermerge();
		 }
	 })
});
 function dosearch(){
	 var CUSTOMER = jQuery("#field<%=MainTable.get("customer")%>").val();
	 var LOT_ID = jQuery("#field<%=MainTable.get("lot_id")%>").val();
	 var ASSY_LOT_CODE = jQuery("#field<%=MainTable.get("assy_lot_code")%>").val();
	 var CUST_RUN_ID = jQuery("#field<%=MainTable.get("cust_run_id")%>").val();
	 var MAT_ID = jQuery("#field<%=MainTable.get("mat_id")%>").val();

	 jQuery.ajax({
		 url: "/interface/fst/WF984ajaxaction.jsp",
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
				 jQuery("#field<%=DetailTable1.get("material")%>_"+mxid).val(result[i].MATERIAL);
				 jQuery("#field<%=DetailTable1.get("qty")%>_"+mxid).val(result[i].QTY);
				 jQuery("#field<%=DetailTable1.get("assy_lot")%>_"+mxid).val(result[i].ASSY_LOT);
				 jQuery("#field<%=DetailTable1.get("batch")%>_"+mxid).val(result[i].BATCH);
				 jQuery("#field<%=DetailTable1.get("production_order")%>_"+mxid).val(result[i].PRODUCTION_ORDER);
				 jQuery("#field<%=DetailTable1.get("description")%>_"+mxid).val(result[i].DESCRIPTION);
				 jQuery("#field<%=DetailTable1.get("wafer_lot")%>_"+mxid).val(result[i].WAFER_LOT);
				 jQuery("#field<%=DetailTable1.get("storage_location")%>_"+mxid).val(result[i].STORAGE_LOCATION);
				 jQuery("#field<%=DetailTable1.get("wxs")%>_"+mxid).val(result[i].WXS);

				 mxid++;
			 }

		 }
	 });
	 return 1;
 }

	workflowpage.dosearch2 = function () {
		var yzx = new Array();
		var zero = new Array();
		jQuery("input[id *='field<%=DetailTable1.get("wxs")%>']").each(function(index){
			var tmp3 = this.id.split("_");
			var thislotcode = jQuery("#field<%=DetailTable1.get("lot_code")%>_"+tmp3[1]).val();
			if(jQuery(this).val()=='0'){
				zero.push("'"+thislotcode+"'");
			}else{
				yzx.push("'"+thislotcode+"'");
			}
		})
		jQuery.ajax({
			url: "/interface/fst/WF984ajaxaction.jsp",
			data: {type: 2,zero:zero.join(","),yzx:yzx.join(",")},
			cache: false,
			async: false,
			type: "post",
			dataType: "json",
			success: function (result) {
				var checkboxs = jQuery("input[name='check_node_1']");
				jQuery("input[name='check_node_1']").each(function(index) {
					checkboxs.eq(index).attr("checked",true);
				});
				if(checkboxs.length!=0){
					delRowmx(1);
				}
				var mxid = Number(jQuery("#indexnum1").val());
				for(var i=0;i<result.length;i++){
					addRow1(1);
					jQuery("#field<%=DetailTable2.get("lot_code")%>_"+mxid).val(result[i].LOT_CODE);
					jQuery("#field<%=DetailTable2.get("material")%>_"+mxid).val(result[i].MATERIAL);
					jQuery("#field<%=DetailTable2.get("qty")%>_"+mxid).val(result[i].QTY);
					jQuery("#field<%=DetailTable2.get("assy_lot")%>_"+mxid).val(result[i].ASSY_LOT);
					jQuery("#field<%=DetailTable2.get("batch")%>_"+mxid).val(result[i].BATCH);
					jQuery("#field<%=DetailTable2.get("production_order")%>_"+mxid).val(result[i].PRODUCTION_ORDER);
					jQuery("#field<%=DetailTable2.get("wafer_lot")%>_"+mxid).val(result[i].WAFER_LOT);
					jQuery("#field<%=DetailTable2.get("storage_location")%>_"+mxid).val(result[i].STORAGE_LOCATION);
					jQuery("#field<%=DetailTable2.get("sub_production_order")%>_"+mxid).val(result[i].SUB_PRODUCTION_ORDER);
					jQuery("#field<%=DetailTable2.get("parent_lot_code")%>_"+mxid).val(result[i].PARENT_LOT_CODE);
					jQuery("#field<%=DetailTable2.get("box_no")%>_"+mxid).val(result[i].BOX_NO);
					mxid++;
				}

			}
		});
           return 1;
	}

	//在库重工合并算法类
	function  mergeInfo(){
		var array = new Array();
		var map = new Array();
        this.init = function(){
			console.log("-------------开始初始化--------");
			jQuery("input[id *='field<%=DetailTable2.get("lot_code")%>']").each(function(index){
				var dt2 = {};
				var tmp3 = this.id.split("_");
				dt2.id = tmp3[1];
				dt2.qty = jQuery("#field<%=DetailTable2.get("qty")%>_"+tmp3[1]).val();
				dt2.batch = jQuery("#field<%=DetailTable2.get("batch")%>_"+tmp3[1]).val();
				dt2.targetbatch = jQuery("#field<%=DetailTable2.get("batch")%>_"+tmp3[1]).val();
				dt2.assy_lot = jQuery("#field<%=DetailTable2.get("assy_lot")%>_"+tmp3[1]).val();   //组装批号
				dt2.wafer_lot = jQuery("#field<%=DetailTable2.get("wafer_lot")%>_"+tmp3[1]).val(); //扩散批号
				dt2.box_no = jQuery("#field<%=DetailTable2.get("box_no")%>_"+tmp3[1]).val();
				array.push(dt2);
			})
		}

		this.merge = function(){
			var conition_previous = '';
			var conition_this = '';
			var hbfs = jQuery("#field<%=MainTable.get("mergemode")%>").val();
			if(hbfs=='0'||hbfs==''){
				return;
			}

			for(var i=1,size = array.length;i<size;i++){
				var thisdt2 = array[i];

				if(i>0){
				var previous = array[i-1];
				if(hbfs=='1'){
					conition_this = thisdt2.wafer_lot;
					conition_previous = previous.wafer_lot;
				}
				if(hbfs=='2'){
					conition_this = thisdt2.assy_lot;
					conition_previous = previous.assy_lot;
				}
				if(hbfs=='3'){
					conition_this = thisdt2.wafer_lot+thisdt2.box_no;
					conition_previous = previous.wafer_lot+previous.box_no;
				}
				if(conition_this == conition_previous)	{
					thisdt2.targetbatch = previous.targetbatch;
				}

				}
			}
			//回写页面
			for(var i=0,size = array.length;i<size;i++){
				var dt2 = array[i];
				jQuery("#field<%=DetailTable2.get("dest_batch")%>_"+dt2.id).val(dt2.targetbatch);
			}
		}

		var has = function(name){
			for(var i=0,size = map.length;i<size;i++){
				var dt3 = map[i];
				if(dt3.targetbatch == name){
					return true;
				}
			}
			return false;
		}

		var get = function (name) {
			for(var i=0,size = map.length;i<size;i++){
				var dt3 = map[i];
				if(dt3.targetbatch == name){
					return dt3;
				}
			}
			return null;
		}

		this.aftermerge = function (){
			for(var i=0,size = array.length;i<size;i++){
				var dt3 = {};
				var dt2 = array[i];
		       if(has(dt2.targetbatch)){
				   dt3 = get(dt2.targetbatch);
				   dt3.qty = Number(dt3.qty) + Number(dt2.qty);
			   }else{
				   dt3.targetbatch = dt2.targetbatch;
				   dt3.wafer_lot = dt2.wafer_lot;
				   dt3.assy_lot = dt2.assy_lot;
				   dt3.box_no = dt2.box_no;
				   dt3.qty = dt2.qty;
				   map.push(dt3);
			   }
			}
			var checkboxs = jQuery("input[name='check_node_2']");
			jQuery("input[name='check_node_2']").each(function(index) {
				checkboxs.eq(index).attr("checked",true);
			});
			if(checkboxs.length!=0){
				delRowmx(2);
			}
			var mxid = Number(jQuery("#indexnum2").val());
			for(var i=0,size = map.length;i<size;i++){
				var dt3 = map[i];
				addRow2(2);
				jQuery("#field<%=DetailTable3.get("final_batch")%>_"+mxid).val(dt3.targetbatch);
				jQuery("#field<%=DetailTable3.get("qty")%>_"+mxid).val(dt3.qty);
				jQuery("#field<%=DetailTable3.get("wafer_lot")%>_"+mxid).val(dt3.wafer_lot);
				jQuery("#field<%=DetailTable3.get("assy_lot")%>_"+mxid).val(dt3.assy_lot);
				jQuery("#field<%=DetailTable3.get("box_no")%>_"+mxid).val(dt3.box_no);
				mxid++;
			}
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
		 // top.Dialog.alert(SystemEnv.getHtmlNoteName(3529, language));
		 return;
	 }
 }
</script> 
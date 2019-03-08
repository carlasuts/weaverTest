<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<jsp:useBean id="mysmt" class="weaver.conn.RecordSet"/>
<jsp:useBean id="bs" class="weaver.general.BaseBean"></jsp:useBean>
<%
    int requestid = Util.getIntValue(request.getParameter("requestid"),0);//请求id
    int workflowid = Util.getIntValue(request.getParameter("workflowid"),0);//流程id
    int formid = Util.getIntValue(request.getParameter("formid"),0);//表单id
    int isbill = Util.getIntValue(request.getParameter("isbill"),0);//表单类型，1单据，0表单
    int nodeid = Util.getIntValue(request.getParameter("nodeid"),0);//流程的节点id
	String applicant = BillUtil.getLabelId(formid,0,"applicant");//填单人员
	
	String  subsection= BillUtil.getLabelId(formid,0,"factory");//厂区
	String  holder= BillUtil.getLabelId(formid,0,"holder");//持有人
	
//明细2

String tool_card = BillUtil.getLabelId(formid,2,"tool_card");//工具卡
String note_desc = BillUtil.getLabelId(formid,2,"note_desc");//备注
String numbers = BillUtil.getLabelId(formid,2,"numbers");//数量
String unit = BillUtil.getLabelId(formid,2,"unit");//单位
String price = BillUtil.getLabelId(formid,2,"price");//价格
String describe = BillUtil.getLabelId(formid,2,"describe");//供应商

%>
<script  type="text/javascript">
	var holder = <%=holder%>
	var tool_card = <%=tool_card%>
	var note_desc = <%=note_desc%>
	var numbers = <%=numbers%>
	var unit = <%=unit%>
	var price = <%=price%>
	var describe = <%=describe%>

	var applicant = <%=applicant%>
	var subsection = <%=subsection%>


$(function(){
	<%if(nodeid == 19353){%>
	jQuery.ajax({
				url: "/interface/additional/tool_card/get_role_id.jsp",
				data: {roleid: $("#field" +applicant).val()},
				cache: true,
				type: "post",
				dataType: "text",
				async: false,
				success: function (result) {
					result = jQuery.trim(result);
					if(result == "1")
					{//崇川
						$("#field" + subsection ).attr("value","0");
						$("#field" + subsection ).change();
						setCover(subsection);
					}
					if(result == "142")
					{//苏通121 teste   142 prod
						$("#field" + subsection ).attr("value","1");
						$("#field" + subsection ).change();
						setCover(subsection);
					}
					if(result == "101")
					{//合肥
						$("#field" + subsection ).attr("value","2");
						$("#field" + subsection ).change();
						setCover(subsection);
					}			
				}
			});
	<%}%>
    
	<%if(nodeid==19395||nodeid==19354){%>
	var mxid = 0 ;
	$("#field"+ holder).bindPropertyChange(function(e){
			jQuery.ajax({
				url: "/interface/additional/tool_card/tool_cardajaxaction.jsp",
				data: {user : $("#field"+ holder).val()},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					var checkboxs = jQuery("input[name='check_node_1']");
					jQuery("input[id*='field"+ tool_card +"_']").each(function(index) {
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

						$("#field"+ tool_card +"_"+mxid).val(result[i].TOOL_CARD_ID);
						$("#field"+ tool_card +"_"+mxid+"span").html('<span class="e8_showNameClass"><a>' + result[i].TOOL_CARD_VALUE + '</a>&nbsp;<span class="e8_delClass" id="'+result[i].TOOL_CARD_VALUE+'">&nbsp;&nbsp;</span></span>');
						$("#field"+ numbers +"_"+mxid).val(result[i].NUMBERS);
						$("#field"+ unit +"_"+mxid).val(result[i].UNIT);
						$("#field"+ price +"_"+mxid).val(result[i].PRICE);
						$("#field"+ describe +"_"+mxid).val(result[i].SUPPLIER_TO_DESCRIBE);
						
						document.getElementById("field"+ tool_card +"_"+mxid).readOnly=true;
						document.getElementById("field"+ tool_card +"_"+mxid+"_browserbtn").disabled=true;
						document.getElementById("field"+ numbers +"_"+mxid).readOnly=true;
						document.getElementById("field"+ unit +"_"+mxid).readOnly=true;
						document.getElementById("field"+ price +"_"+mxid).readOnly=true;
						document.getElementById("field"+ describe +"_"+mxid).readOnly=true;
						
						mxid++;
					}
					
				}
			});                                             	

	  //控制主表的是否全部Close为否不可提交
	});
	<%}%>
	
  })
	
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
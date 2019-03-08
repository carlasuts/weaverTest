<%@page import="java.util.UUID"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.hrm.User"%>
<%@page import="weaver.systeminfo.SystemEnv"%>
<%@page import="weaver.conn.RecordSet"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.workflow.field.BrowserComInfo"%>
<%@page import="weaver.fna.maintenance.FnaCostCenter"%>
<%@page import="java.util.*"%>
<%@page import="weaver.fna.maintenance.FnaBudgetControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<%

int formid1 = Util.getIntValue(request.getParameter("formid"));//表单id
//主表  
//关联事前申请 
String sqworkflowid = BillUtil.getLabelId(formid1,0,"sqworkflowid");
String zb_eeramt = BillUtil.getLabelId(formid1,0,"eeramt");
String currtype = BillUtil.getLabelId(formid1,0,"currtype");

//差旅费用报销
//明细1 交通费信息
String begindate1 = BillUtil.getLabelId(formid1,1,"begindate");
String enddate1 = BillUtil.getLabelId(formid1,1,"enddate");
String fromcityid = BillUtil.getLabelId(formid1,1,"fromcityid");
String tocityid = BillUtil.getLabelId(formid1,1,"tocityid");
String vehicle = BillUtil.getLabelId(formid1,1,"vehicle");
String expenseamt = BillUtil.getLabelId(formid1,1,"expenseamt");
String CURCATEGORY1 = BillUtil.getLabelId(formid1,1,"CURCATEGORY");
String RATE1 = BillUtil.getLabelId(formid1,1,"RATE");
//明细2 住宿信息
String begindate2 = BillUtil.getLabelId(formid1,2,"begindate");
String enddate2 = BillUtil.getLabelId(formid1,2,"enddate");
String cityid = BillUtil.getLabelId(formid1,2,"cityid");
String eeramt = BillUtil.getLabelId(formid1,2,"eeramt");
String hotelstaydays = BillUtil.getLabelId(formid1,2,"hotelstaydays");
String CURCATEGORY2 = BillUtil.getLabelId(formid1,2,"CURCATEGORY");
String RATE2 = BillUtil.getLabelId(formid1,2,"RATE");
//明细3 餐补信息
String begindate3 = BillUtil.getLabelId(formid1,3,"begindate");
String enddate3 = BillUtil.getLabelId(formid1,3,"enddate");
String cityid1 = BillUtil.getLabelId(formid1,3,"cityid");
String mealdays = BillUtil.getLabelId(formid1,3,"mealdays");
String eeramt1 = BillUtil.getLabelId(formid1,3,"eeramt");
String CURCATEGORY3 = BillUtil.getLabelId(formid1,3,"CURCATEGORY");
String RATE3 = BillUtil.getLabelId(formid1,3,"RATE");
//明细4 其他
String begindate4 = BillUtil.getLabelId(formid1,4,"begindate");
String enddate4 = BillUtil.getLabelId(formid1,4,"enddate");
String content = BillUtil.getLabelId(formid1,4,"content");
String eeramt2 = BillUtil.getLabelId(formid1,4,"eeramt");
String CURCATEGORY4 = BillUtil.getLabelId(formid1,4,"CURCATEGORY");

%>
<script language="javascript" src="/fna/js/e8Common_wev8.js?r=12"></script>
<script type="text/javascript">
var sqworkflowid = <%=sqworkflowid%>;
var zb_eeramt = <%=zb_eeramt%>;
var currtype = <%=currtype%>

var begindate1 = <%=begindate1%>
var enddate1 = <%=enddate1%>

var begindate2 = <%=begindate2%>
var enddate2 = <%=enddate2%>

var begindate3 = <%=begindate3%>
var enddate3 = <%=enddate3%>

var begindate4 = <%=begindate4%>
var enddate4 = <%=enddate4%>



var eeramt = <%=eeramt%> 

var fromcityid = <%=fromcityid%>;
var tocityid = <%=tocityid%> 
var vehicle = <%=vehicle%>;
var expenseamt = <%=expenseamt%> 

var cityid = <%=cityid%> 
var hotelstaydays = <%=hotelstaydays%> 
var RATE1 = <%=RATE1%>
var CURCATEGORY1 = <%=CURCATEGORY1%>
var RATE2 = <%=RATE2%>
var CURCATEGORY2 = <%=CURCATEGORY2%>
var CURCATEGORY4 = <%=CURCATEGORY4%>
var RATE3 = <%=RATE3%>
var CURCATEGORY3 = <%=CURCATEGORY3%>

var cityid1 = <%=cityid1%> 
var mealdays = <%=mealdays%>;
var eeramt1 = <%=eeramt1%> 

var content = <%=content%>;
var eeramt2 = <%=eeramt2%> 

//Table相关行
var dt1SelectAllCheckBox = jQuery("#oTable0 tbody tr:eq(2) td input");
var dt2SelectAllCheckBox = jQuery("#oTable1 tbody tr:eq(2) td input");
var dt3SelectAllCheckBox = jQuery("#oTable2 tbody tr:eq(2) td input");
var dt4SelectAllCheckBox = jQuery("#oTable3 tbody tr:eq(2) td input");

jQuery(function () {
	$("#field"+sqworkflowid).bindPropertyChange(function(e){
		//主表报销金额,结算币别初始化
		$("#field"+ zb_eeramt ).val('');
		$("#field"+ zb_eeramt + "span" ).text('');
		
		//交通费信息
		var dt1rows = jQuery("#oTable0 tbody tr:gt(2)");
		//住宿费信息
		var dt2rows = jQuery("#oTable1 tbody tr:gt(2)");
		//餐补费信息
		var dt3rows = jQuery("#oTable2 tbody tr:gt(2)");
		//其他费用信息
		var dt4rows = jQuery("#oTable3 tbody tr:gt(2)");
		
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
		if(jQuery(dt2rows).length > 0) {
			jQuery(dt2SelectAllCheckBox).attr("checked", true);
			detailOperate.checkAllFun(1);
			deleteRow1(1);
			jQuery(dt2SelectAllCheckBox).attr("checked", false);
		}
		if(jQuery(dt3rows).length > 0) {
			jQuery(dt3SelectAllCheckBox).attr("checked", true);
			detailOperate.checkAllFun(2);
			deleteRow2(2);
			jQuery(dt3SelectAllCheckBox).attr("checked", false);
		}
		if(jQuery(dt4rows).length > 0) {
			jQuery(dt4SelectAllCheckBox).attr("checked", true);
			detailOperate.checkAllFun(3);
			deleteRow3(3);
			jQuery(dt4SelectAllCheckBox).attr("checked", false);
		}
		//再恢复confirm功能
		window.confirm = originConfirm;		
		
		//主表费用信息  报销金额
		jQuery.ajax({
			//报销金额
			url: "/fna/template/FnaSubmitRequestJsajaxaction.jsp",
			data: {type: 1, req1: e.value},
			cache: false,
			type: "post",
			dataType: "json",
			async: false,
			success: function (result) {
				$("#field" + zb_eeramt ).val(result[0].EERAMT);
				document.getElementById("field"+ zb_eeramt).readOnly=true;
				$("#field" + currtype).attr("value",result[0].CURRTYPE);
			}
		});	
		
		
		jQuery.ajax({
			//交通费信息
			url: "/fna/template/FnaSubmitRequestJsajaxaction.jsp",
			data: {type: 2, req: e.value},
			cache: false,
			type: "post",
			dataType: "json",
			async: false,
			success: function (result) {
				for(var i=0;i<result.length;i++){
					//模拟点击标签页
					var oDiv = document.getElementById('tab_1');  
					oDiv.click();
					
					addRow0(0);
					//新增行绑定事件
					var id_1 = jQuery("input[id^='field" + expenseamt + "_']").last().attr("id");
					var idx_1 = id_1.split("_")[1];
					$("#field"+ begindate1 + "_" + idx_1 + "span").text(result[i].BEGINDATE);
					$("#field"+ begindate1 + "_" + idx_1).val(result[i].BEGINDATE);
					document.getElementById("field"+ begindate1 + "_" + idx_1 + "span").readOnly=true;
					document.getElementById("field"+ begindate1 +"_"+idx_1 + "browser").disabled=true;

					$("#field"+ CURCATEGORY1 +"_" + idx_1 ).val(result[i].CURCATEGORY);
					document.getElementById("field"+ CURCATEGORY1 + "_" + idx_1 ).onchange();
					setCover(CURCATEGORY1,idx_1);
					
					$("#field"+ fromcityid +"_" + idx_1 ).val(result[i].fromcityid);
					setCover(fromcityid,idx_1);
					
					$("#field"+ tocityid +"_" + idx_1 ).val(result[i].tocityid);
					setCover(tocityid,idx_1);
					
					$("#field"+ vehicle +"_" + idx_1).val(result[i].vehicle);
					setCover(vehicle,idx_1);
					
					$("#field"+ expenseamt +"_" + idx_1).val(result[i].eeramt);
					document.getElementById("field"+ expenseamt + "_" + idx_1 ).readOnly=true;
					
					//出发地 
					jQuery.ajax({
						url: "/fna/template/FnaSubmitRequestJsajaxaction.jsp",
						data: {type: 6, fromcityid: result[i].fromcityid},
						cache: false,
						type: "post",
						dataType: "json",
						async: false,
						success: function (result1) {
							$("#field"+ fromcityid +"_" + idx_1 +"span" ).html('<a href="#1" onclick="return false;" title="'+ result1[0].CITYNAME +'" style="max-width:34px!important;overflow:hidden!important;text-overflow:ellipsis!important;white-space:nowrap!important;display: inline-block!important;">'+ result1[0].CITYNAME +'</a>');
						}
					});
					//目的地
					jQuery.ajax({
						url: "/fna/template/FnaSubmitRequestJsajaxaction.jsp",
						data: {type: 7, tocityid: result[i].tocityid},
						cache: false,
						type: "post",
						dataType: "json",
						async: false,
						success: function (result2) {
							$("#field"+ tocityid +"_" + idx_1 +"span" ).html('<a href="#1" onclick="return false;" title="'+ result2[0].CITYNAME +'" style="max-width:34px!important;overflow:hidden!important;text-overflow:ellipsis!important;white-space:nowrap!important;display: inline-block!important;">'+ result2[0].CITYNAME +'</a>');
						}
					});
				}
			}
		});
		jQuery.ajax({
			//住宿费信息
			url: "/fna/template/FnaSubmitRequestJsajaxaction.jsp",
			data: {type: 3, req: e.value},
			cache: false,
			type: "post",
			dataType: "json",
			async: false,
			success: function (result) {
				for(var i=0;i<result.length;i++){
					
					var oDiv = document.getElementById('tab_2');  
					oDiv.click();

					addRow1(1);
					//新增行绑定事件
					var id_2 = jQuery("input[id^='field" + eeramt + "_']").last().attr("id");
					var idx_2 = id_2.split("_")[1];
					$("#field"+ begindate2 + "_" + idx_2 + "span").text(result[i].BEGINDATE);
					$("#field"+ begindate2 + "_" + idx_2).val(result[i].BEGINDATE);
					document.getElementById("field"+ begindate2 + "_" + idx_2 + "span").readOnly=true;
					document.getElementById("field"+ begindate2 +"_"+idx_2 + "browser").disabled=true;
					
					$("#field"+ enddate2 + "_" + idx_2 + "span").text(result[i].ENDDATE);
					$("#field"+ enddate2 + "_" + idx_2).val(result[i].ENDDATE);
					document.getElementById("field"+ enddate2 + "_" + idx_2 + "span").readOnly=true;
					document.getElementById("field"+ enddate2 +"_"+idx_2 + "browser").disabled=true;
					
					$("#field"+ CURCATEGORY2 +"_" + idx_2 ).val(result[i].CURCATEGORY);
					document.getElementById("field"+ CURCATEGORY2 + "_" + idx_2 ).onchange();
					setCover(CURCATEGORY2,idx_2);
					
					$("#field"+ cityid +"_" + idx_2 ).val(result[i].cityid);
					setCover(cityid,idx_2);
					
					$("#field"+ eeramt +"_" + idx_2 ).val(result[i].eeramt);
					document.getElementById("field"+ eeramt + "_" + idx_2).readOnly=true;
					$("#field"+ hotelstaydays +"_" + idx_2).val(result[i].hotelstaydays);
					document.getElementById("field"+ hotelstaydays + "_" + idx_2).readOnly=true;
					//住宿地点
					jQuery.ajax({
						url: "/fna/template/FnaSubmitRequestJsajaxaction.jsp",
						data: {type: 8, cityid: result[i].cityid},
						cache: false,
						type: "post",
						dataType: "json",
						async: false,
						success: function (result3) {
							$("#field"+ cityid +"_" + idx_2 +"span" ).html('<a href="#1" onclick="return false;" title="'+ result3[0].CITYNAME +'" style="max-width:34px!important;overflow:hidden!important;text-overflow:ellipsis!important;white-space:nowrap!important;display: inline-block!important;">'+ result3[0].CITYNAME +'</a>');
						}
					});	
				}
			}
		});
		jQuery.ajax({
			//餐补费信息
			url: "/fna/template/FnaSubmitRequestJsajaxaction.jsp",
			data: {type: 4, req: e.value},
			cache: false,
			type: "post",
			dataType: "json",
			async: false,
			success: function (result) {
				for(var i=0;i<result.length;i++){
					
					var oDiv = document.getElementById('tab_3');  
					oDiv.click();
					
					addRow2(2);
					//新增行绑定事件
					var id_3 = jQuery("input[id^='field" + eeramt1 + "_']").last().attr("id");
					var idx_3 = id_3.split("_")[1];
					$("#field"+ begindate3 + "_" + idx_3 + "span").text(result[i].BEGINDATE);
					$("#field"+ begindate3 + "_" + idx_3).val(result[i].BEGINDATE);
					document.getElementById("field"+ begindate3 + "_" + idx_3 + "span").readOnly=true;
					document.getElementById("field"+ begindate3 +"_"+idx_3 + "browser").disabled=true;
					
					$("#field"+ enddate3 + "_" + idx_3 + "span").text(result[i].ENDDATE);
					$("#field"+ enddate3 + "_" + idx_3).val(result[i].ENDDATE);
					document.getElementById("field"+ enddate3 + "_" + idx_3 + "span").readOnly=true;
					document.getElementById("field"+ enddate3 +"_"+idx_3 + "browser").disabled=true;
					
					$("#field"+ CURCATEGORY3 +"_" + idx_3 ).val(result[i].CURCATEGORY);
					document.getElementById("field"+ CURCATEGORY3 + "_" + idx_3 ).onchange();
					setCover(CURCATEGORY3,idx_3);
					
					$("#field"+ cityid1 +"_" + idx_3 ).val(result[i].cityid);
					setCover(cityid1,idx_3);
					
					$("#field"+ eeramt1 +"_" + idx_3 ).val(result[i].eeramt);
					document.getElementById("field"+ eeramt1 + "_" + idx_3 ).readOnly=true;
					$("#field"+ mealdays +"_" + idx_3).val(result[i].mealdays);
					document.getElementById("field"+ mealdays + "_" + idx_3 ).readOnly=true;
					//出差地
					jQuery.ajax({
						url: "/fna/template/FnaSubmitRequestJsajaxaction.jsp",
						data: {type: 9, cityid1: result[i].cityid},
						cache: false,
						type: "post",
						dataType: "json",
						async: false,
						success: function (result4) {
							$("#field"+ cityid1 +"_" + idx_3 +"span" ).html('<a href="#1" onclick="return false;" title="'+ result4[0].CITYNAME +'" style="max-width:34px!important;overflow:hidden!important;text-overflow:ellipsis!important;white-space:nowrap!important;display: inline-block!important;">'+ result4[0].CITYNAME +'</a>');
						}
					});						
				}
			}
		});
		jQuery.ajax({
			//其他费用信息
			url: "/fna/template/FnaSubmitRequestJsajaxaction.jsp",
			data: {type: 5, req: e.value},
			cache: false,
			type: "post",
			dataType: "json",
			async: false,
			success: function (result) {
				for(var i=0;i<result.length;i++){
					var oDiv = document.getElementById('tab_4');  
					oDiv.click();					
					addRow3(3);
					//新增行绑定事件
					var id_4 = jQuery("input[id^='field" + content + "_']").last().attr("id");
					var idx_4 = id_4.split("_")[1];	
					$("#field"+ begindate4 + "_" + idx_4 + "span").text(result[i].BEGINDATE);
					$("#field"+ begindate4 + "_" + idx_4).val(result[i].BEGINDATE);
					document.getElementById("field"+ begindate4 + "_" + idx_4 + "span").readOnly=true;
					document.getElementById("field"+ begindate4 +"_"+idx_4 + "browser").disabled=true;
					
					$("#field"+ enddate4 + "_" + idx_4 + "span").text(result[i].ENDDATE);
					$("#field"+ enddate4 + "_" + idx_4).val(result[i].ENDDATE);
					document.getElementById("field"+ enddate4 + "_" + idx_4 + "span").readOnly=true;
					document.getElementById("field"+ enddate4 +"_"+idx_4 + "browser").disabled=true;
					
					$("#field"+ CURCATEGORY4 +"_" + idx_4 ).val(result[i].CURCATEGORY);
					document.getElementById("field"+ CURCATEGORY4 + "_" + idx_4 ).onchange();
					setCover(CURCATEGORY4,idx_4);
					
					$("#field"+ content +"_" + idx_4 ).val(result[i].content);
					document.getElementById("field"+ content + "_" + idx_4 ).readOnly=true;
					$("#field"+ eeramt2 +"_" + idx_4 ).val(result[i].eeramt);
					document.getElementById("field"+ eeramt2 + "_" + idx_4 ).readOnly=true;
				}
			}
		});
		var oDiv = document.getElementById('tab_1');  
		oDiv.click();
	});
});


	function setCover(field, idx) {
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
</script> 
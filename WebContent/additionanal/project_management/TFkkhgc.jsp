<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.interfaces.workflow.util.BillUtil"%>
<%
    int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
	int formid = Util.getIntValue(request.getParameter("formid"));//表单id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id	
	int requestid = Util.getIntValue(request.getParameter("requestid"));//请求id
	//主表
	String fieldifALLclosed = BillUtil.getLabelId(formid, 0, "ifALLclose");//是否全部close
	
	//dt1
	String fieldifclose = BillUtil.getLabelId(formid, 1, "ifclose");//是否Close 
 
%>
<script type="text/javascript">
	//主表
	var fieldifALLclosed = <%=fieldifALLclosed%>;
	//dt1
	var fieldifclose = <%=fieldifclose%>;
	var requestid = <%=requestid%>

		
jQuery(function () {
	jQuery("button[name=addbutton0]").click(function(){
		$("#field" + fieldifALLclosed).attr("value","1");
		//$("#field" + fieldifALLclosed).blur();
		setCover(fieldifALLclosed);
		var id = jQuery("select[id^='field" + fieldifclose + "_']").last().attr("id");
		var tmp = id.split("_");
		var idx = tmp[1];
		dochange(idx);
	  //控制主表的是否全部Close为否不可提交
	});
	
	$("select[id^='field" + fieldifclose + "_']").bindPropertyChange(function(){
		var a = 0;
		function mx_1(){
			this.allclosed_mx1 = '';//所有是否close的值
		}
		//获取明细表是否Close的所有值
		var trarray = new Array();	   
		jQuery("select[id^='field" + fieldifclose + "_']").each(function(index) {
			var indexrow = new mx_1();
			var mx1_mxid = this.id.split("_")[1];
			indexrow.allclosed_mx1 = jQuery("#field" + fieldifclose + "_" + mx1_mxid).val();
			trarray[index] = indexrow;
		});

		for(var i=0;i<trarray.length;i++){
			if(trarray[i].allclosed_mx1 == "0"){
				a++;
		    }
			if(trarray[i].allclosed_mx1 == "1"){
				$("#field" + fieldifALLclosed).attr("value","1");
		    }
			if(a == trarray.length){
				$("#field" + fieldifALLclosed).attr("value","0");
			}
		}
	});
});

	<%if(nodeid == 3784){%>
		//02进度更新 是否Close 为是的行隐藏
		jQuery("select[id^='field" + fieldifclose + "_']").each(function(index) {
			var tmp = this.id.split("_")[1];
			if(jQuery("#field" + fieldifclose + "_" + tmp).val() == "0"){
				$("#field" + fieldifclose + "_" + tmp).parent().parent().attr('style','display:none');
			}
		});
		
		checkCustomize = function() {
		   var flag = true;
	 	   var Allcolsed_val =  $("#field" + fieldifALLclosed).val();
	 	   if( Allcolsed_val == 1 )
	 	   {
	 		   flag = false;
	 	   }
	 	   if (flag == false)
	  	   {
	 		   alert("请点击保存,继续更新考核批进度");								
		   }
	 	   
	 	   return flag;														
		}
	<%}%>
	
	function dochange(idx) {
		jQuery("#field" + fieldifclose + "_" + idx).change(function() {
			var a = 0;
			function mx_1() {
				this.allclosed_mx1 = '';//所有是否close的值
			}

			//获取明细表是否Close的所有值
			var trarray = new Array();
			jQuery("select[id^='field" + fieldifclose + "_']").each(function(index) {
				var indexrow = new mx_1();
				var mx1_mxid = this.id.split("_")[1];
			    indexrow.allclosed_mx1 = jQuery("#field" + fieldifclose + "_"+ mx1_mxid).val();
				trarray[index] = indexrow;
			});

			for (var i = 0; i < trarray.length; i++) {
				if (trarray[i].allclosed_mx1 == "0") {
					a++;
				}
				if (trarray[i].allclosed_mx1 == "1") {
					$("#field" + fieldifALLclosed).attr("value", "1");
				}
				if (a == trarray.length) {
					$("#field" + fieldifALLclosed).attr("value", "0");
				}
			}
		});
	}
	
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
</script>

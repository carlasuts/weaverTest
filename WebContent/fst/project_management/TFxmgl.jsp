<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<%
    int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
	int formid = Util.getIntValue(request.getParameter("formid"));//表单id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
	
	//dt1
	String fieldyear1 = BillUtil.getLabelId(formid, 1, "nd");//年度
	String fielPreYsaleroom = BillUtil.getLabelId(formid, 1, "yjndxse");//预计年度销售额
	//dt2
	String fieldyear2 = BillUtil.getLabelId(formid, 2, "nd");//年度	
    String fielyearPre = BillUtil.getLabelId(formid, 2, "ndxxzs");//年度信心指数% 
    String fielyearPreSale = BillUtil.getLabelId(formid, 2, "ndxse");//年度信心销售额 
    
    String fielxmjd = BillUtil.getLabelId(formid, 2, "xmjd");//项目阶段
    String fieljdzt = BillUtil.getLabelId(formid, 2, "jdzt");//阶段状态
    String fieljdwt = BillUtil.getLabelId(formid, 2, "jdwt");//阶段问题
    String fielWW = BillUtil.getLabelId(formid, 2, "WW");//WW
    String fielWWjz = BillUtil.getLabelId(formid, 2, "WWjz");//WW进展
    String fielWWywc = BillUtil.getLabelId(formid, 2, "WWywc");//下周要完成 
%>
<script type="text/javascript">
	//dt1
	var fieldyear1 = <%=fieldyear1%>;
	var fielPreYsaleroom = <%=fielPreYsaleroom%>;
	//dt2
	var fieldyear2 = <%=fieldyear2%>;
	var fielyearPre = <%=fielyearPre%>;
	var fielyearPreSale = <%=fielyearPreSale%>;
	
	var fielxmjd = <%=fielxmjd%>;
	var fieljdzt = <%=fieljdzt%>;
	var fieljdwt = <%=fieljdwt%>;
	var fielWW = <%=fielWW%>;
	var fielWWjz = <%=fielWWjz%>;
	var fielWWywc = <%=fielWWywc%>;
	
		
jQuery(function () {
	var check_id = '';
		jQuery("button[name=addbutton1]").click(function(){
			//取值id
			var id = jQuery("input[id^='field" + fieldyear2 + "_']").last().attr("id");
			var tmp = id.split("_");
			var idx = tmp[1];
			//绑定change事件id
			var id_1 = jQuery("input[id^='field" + fieldyear2 + "_']").first().attr("id");
			var tmp_1 = id_1.split("_");
			var idx_1 = tmp_1[1];
			jQuery("#field" + fielyearPre + "_"  + idx_1 ).change(function() {
				var yearPre = jQuery("#field" + fielyearPre + "_"  + idx_1).val();//获取年度信心指数%，做判断
				var year2 = jQuery("#field" + fieldyear2 + "_" + idx_1 ).val();//明细2年度
				getYearPreSale(idx_1, yearPre,year2);//获取年信心销售额	
			});
/* 			jQuery("#field" + fielyearPre + "_"  + idx ).change(function() {
				var yearPre = jQuery("#field" + fielyearPre + "_"  + idx).val();//获取年度信心指数%，做判断
				var year2 = jQuery("#field" + fieldyear2 + "_" + idx ).val();//明细2年度
				getYearPreSale(idx, yearPre,year2);//获取年信心销售额	
			}); */
			
			//明细2新增默认在第一行 
			//获取新增那一行
			var mx2_year = jQuery("#field" + fieldyear2 + "_" + idx).val();
			var mx2_xmjd = jQuery("#field" + fielxmjd + "_" + idx).val();
			//var mx2_ndxxzs = jQuery("#field" + fielyearPre + "_" + idx).val();
			var ndxxzs_html = jQuery("#field" + fielyearPre + "_" + idx).html();
			var mx2_ndxxxse = jQuery("#field" + fielyearPreSale + "_" + idx).val();
			var mx2_jdzt = jQuery("#field" + fieljdzt + "_" + idx).val();
			var mx2_jdwt = jQuery("#field" + fieljdwt + "_" + idx).val();
			var mx2_ww = jQuery("#field" + fielWW + "_" + idx).val();
			var mx2_wwjz = jQuery("#field" + fielWWjz + "_" + idx).val();
			var mx2_xzwc = jQuery("#field" + fielWWywc + "_" + idx).val(); 

			//获取整个明细2数据
			var trarray = new Array();
			jQuery("input[id^='field" + fieldyear2 + "_']").each(function(index) {
				var indexrow = new mx_2();
				var mx2_mxid = this.id.split("_")[1];
				indexrow.mx2_year = jQuery("#field" + fieldyear2 + "_" + mx2_mxid).val();
				indexrow.mx2_xmjd = jQuery("#field" + fielxmjd + "_" + mx2_mxid).val();
				//indexrow.mx2_ndxxzs = jQuery("#field" + fielyearPre + "_" + mx2_mxid).val();
				indexrow.ndxxzs_html = jQuery("#field" + fielyearPre + "_" + mx2_mxid).html();
				indexrow.mx2_ndxxxse = jQuery("#field" + fielyearPreSale + "_" + mx2_mxid).val();
				indexrow.mx2_jdzt = jQuery("#field" + fieljdzt + "_" + mx2_mxid).val();
				indexrow.mx2_jdwt = jQuery("#field" + fieljdwt + "_" + mx2_mxid).val();
				indexrow.mx2_ww = jQuery("#field" + fielWW + "_" + mx2_mxid).val();
				indexrow.mx2_wwjz = jQuery("#field" + fielWWjz + "_" + mx2_mxid).val();
				indexrow.mx2_xzwc = jQuery("#field" + fielWWywc + "_" + mx2_mxid).val();
				trarray[index] = indexrow;
			});
			if(trarray.length>=2){
				for(var i=trarray.length-2;i>=0;--i){
					trarray[i+1].mx2_year = trarray[i].mx2_year;
					trarray[i+1].mx2_xmjd = trarray[i].mx2_xmjd;
					//trarray[i+1].mx2_ndxxzs = trarray[i].mx2_ndxxzs;
					trarray[i+1].ndxxzs_html = trarray[i].ndxxzs_html;
					trarray[i+1].mx2_ndxxxse = trarray[i].mx2_ndxxxse;
					trarray[i+1].mx2_jdzt = trarray[i].mx2_jdzt;
					trarray[i+1].mx2_jdwt = trarray[i].mx2_jdwt;
					trarray[i+1].mx2_ww = trarray[i].mx2_ww;
					trarray[i+1].mx2_wwjz = trarray[i].mx2_wwjz;
					trarray[i+1].mx2_xzwc = trarray[i].mx2_xzwc;
				}
			}
			
			trarray[0].mx2_year =mx2_year;
			trarray[0].mx2_xmjd =mx2_xmjd;
			//trarray[0].mx2_ndxxzs =mx2_ndxxzs;
			trarray[0].ndxxzs_html = ndxxzs_html;
			trarray[0].mx2_ndxxxse =mx2_ndxxxse;
			trarray[0].mx2_jdzt =mx2_jdzt;
			trarray[0].mx2_jdwt =mx2_jdwt;
			trarray[0].mx2_ww =mx2_ww;
			trarray[0].mx2_wwjz =mx2_wwjz;
			trarray[0].mx2_xzwc =mx2_xzwc;
			
			//替换
			jQuery("input[id^='field" + fieldyear2 + "_']").each(function(index) {
				if(index == 0){
					check_id = this.id.split("_")[1];
				}
				var indexrow = trarray[index];
				var mx2_mxid = this.id.split("_")[1];
				jQuery("#field" + fieldyear2 + "_" + mx2_mxid).val(indexrow.mx2_year);
				jQuery("#field" + fielxmjd + "_" + mx2_mxid).val(indexrow.mx2_xmjd);
				//jQuery("#field" + fielyearPre + "_" + mx2_mxid).val(indexrow.mx2_ndxxzs);
				jQuery("#field" + fielyearPre + "_" + mx2_mxid).html(indexrow.ndxxzs_html);
				jQuery("#field" + fielyearPreSale + "_" + mx2_mxid).val(indexrow.mx2_ndxxxse);
				jQuery("#field" + fieljdzt + "_" + mx2_mxid).val(indexrow.mx2_jdzt);
				jQuery("#field" + fieljdwt + "_" + mx2_mxid).val(indexrow.mx2_jdwt);
				jQuery("#field" + fielWW + "_" + mx2_mxid).val(indexrow.mx2_ww);
				jQuery("#field" + fielWWjz + "_" + mx2_mxid).val(indexrow.mx2_wwjz);
				jQuery("#field" + fielWWywc + "_" + mx2_mxid).val(indexrow.mx2_xzwc);
				
				//根据项目阶段选项 给年度信心指数赋值
				$("#field" + fielyearPre + "_" + mx2_mxid).attr("value",document.getElementById("field" + fielxmjd + "_" + mx2_mxid).value);
				
				//控制最后新增明细2为  报价询价  工程考核  不可提交
				<%if(nodeid == 3702){%>
					checkCustomize = function() {
						var flag = true;
						var xmjd_val = document.getElementById("field" + fielxmjd + "_" + check_id).value;
						if(xmjd_val == 0 || xmjd_val == 1 ){
							flag = false;
						}
						if (flag == false)
						{
							alert("请点击保存,继续更新项目进度");
						}
						return flag;
					}
				<%}%>
			});
		});

});

	//明细2 year
	function mx_2(){
		this.mx2_id = '';//明细id
		this.mx2_year = '';
		this.mx2_xmjd = '';
		this.mx2_ndxxzs = '';
		this.mx2_ndxxxse = '';
		this.mx2_jdzt = '';
		this.mx2_jdwt = '';
		this.mx2_ww = '';
		this.mx2_wwjz = '';
		this.mx2_xzwc = '';
		this.ndxxzs_html = '';
	}
	
	//控制最后新增明细2为  报价询价  工程考核  不可提交
	<%if(nodeid == 3702){%>
		jQuery("input[id^='field" + fieldyear2 + "_']").each(function(index) {
			if(index == 0 ){
				check_id = this.id.split("_")[1];
			}
		});
		checkCustomize = function() {
			var flag = true;
		    var xmjd_val = document.getElementById("field" + fielxmjd + "_" + check_id).value;
		    if(xmjd_val == 0 || xmjd_val == 1 ){
		    	flag = false;
		    }
		    if (flag == false)
		    {
		    	alert("请点击保存,继续更新项目进度");
			}
		    return flag;
		}
	<%}%>
	
	function getYearPreSale(idx_1,yearPre,year2) {
		var  YearPreSale="";
        var PreYsaleroom = "";
        switch (yearPre)
		{
			case "0" :  //年度信心指数为25%
				jQuery("input[id^='field" + fieldyear1 + "_']").each(function(index) {
					var mxid = this.id.split("_")[1];
				    var year1 = jQuery("#field" + fieldyear1 + "_" + mxid).val();
				    if(year1 == year2)
				        {
							PreYsaleroom = parseFloat(jQuery("#field"+ fielPreYsaleroom + "_" + mxid).val());
						    YearPreSale = 0.25 * PreYsaleroom;
						}
		    	});
	
		    YearPreSale = Math.round( YearPreSale * 100 ) / 100.0;
		    jQuery("#field" + fielyearPreSale + "_" + idx_1).val(YearPreSale);
		    document.getElementById("#field" + fielyearPreSale + "_" + idx_1).readOnly=true;
		    break;
		    case "1" :  //年度信心指数为50%
				jQuery("input[id^='field" + fieldyear1 + "_']").each(function(index) {
					var mxid = this.id.split("_")[1];
				    var year1 = jQuery("#field" + fieldyear1 + "_" + mxid).val();
				    if(year1 == year2)
				        {
							PreYsaleroom = parseFloat(jQuery("#field"+ fielPreYsaleroom + "_" + mxid).val());
						    YearPreSale = 0.5 * PreYsaleroom;
						}
		    	});
	
		    YearPreSale = Math.round( YearPreSale * 100 ) / 100.0;
		    jQuery("#field" + fielyearPreSale + "_" + idx_1).val(YearPreSale);
		    document.getElementById("#field" + fielyearPreSale + "_" + idx_1).readOnly=true;
		    break;
		    case "2" :  //年度信心指数为80%
				jQuery("input[id^='field" + fieldyear1 + "_']").each(function(index) {
					var mxid = this.id.split("_")[1];
				    var year1 = jQuery("#field" + fieldyear1 + "_" + mxid).val();
				    if(year1 == year2)
				        {
							PreYsaleroom = parseFloat(jQuery("#field"+ fielPreYsaleroom + "_" + mxid).val());
						    YearPreSale = 0.8 * PreYsaleroom;
						}
		    	});
	
		    YearPreSale = Math.round( YearPreSale * 100 ) / 100.0;
		    jQuery("#field" + fielyearPreSale + "_" + idx_1).val(YearPreSale);
		    document.getElementById("#field" + fielyearPreSale + "_" + idx_1).readOnly=true;
		    break;
		    case "3" :  //年度信心指数为100%
				jQuery("input[id^='field" + fieldyear1 + "_']").each(function(index) {
					var mxid = this.id.split("_")[1];
				    var year1 = jQuery("#field" + fieldyear1 + "_" + mxid).val();
				    if(year1 == year2)
				        {
							PreYsaleroom = parseFloat(jQuery("#field"+ fielPreYsaleroom + "_" + mxid).val());
						    YearPreSale = PreYsaleroom;
						}
		    	});
	
		    YearPreSale = Math.round( YearPreSale * 100 ) / 100.0;
		    jQuery("#field" + fielyearPreSale + "_" + idx_1).val(YearPreSale);
		    document.getElementById("#field" + fielyearPreSale + "_" + idx_1).readOnly=true;
		    break;
		    case "4" :  //年度信心指数为0%
		    jQuery("#field" + fielyearPreSale + "_" + idx_1).val(0);
		    document.getElementById("#field" + fielyearPreSale + "_" + idx_1).readOnly=true;
		    break;
		}
	}
		

</script> 
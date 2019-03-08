<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.conn.RecordSet" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="xssUtil" class="weaver.filter.XssUtil" scope="page" />
<HTML><HEAD>
<script type="text/javascript">
var parentWin = null;
var dialog = null;
try{
	parentWin = parent.parent.getParentWindow(parent);
	dialog = parent.parent.getDialog(parent);
}catch(e){}
</script>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css></HEAD>
<%
String requestid,Quotation_way;
%>

<BODY style="align:center">

<FORM STYLE="margin-bottom:0;padding:0px;width:100%;align:center" >
	<div style="width:100%;margin-left:30px;margin-top:10px">
		<table style="width:100%">
			<tr>			
				<td style="width:70%;align:left"><input id="shape" style="background:transparent;border:0;text-align:left" readonly="readonly"></input></td>
				<td style="width:30%;align:right"><input style="background:transparent;border:0;text-align:right" readonly="readonly" value="当前汇率:"><input id="rate" style="background:transparent;border:0;text-align:left" readonly="readonly"></input></td>			
			</tr>
		</table>	
	</div>
	<div style="width:100%;margin-left:10px;margin-top:20px">		
		<tr>
			<td>以下成本均为人民币不含税价格</td>
		</tr>
	</div>
	<div style="width:500px;margin-left:20px;margin-top:20px">
		<tr><td>主材</td></tr>
		<center>
			<table style="width:100%;border:solid 1px">
				<thead style="align:center;border:solid 1px">
					<tr>
						<td style="background:#CDCDCD">项目</td>
						<td style="background:#CDCDCD">型号</td>
						<td style="background:#CDCDCD">金额</td>
					</tr>
				</thead>
				<tbody id="mtbody" style="align:center;border:solid 1px"></tbody>
			</table>
		</center>
	</div>
	<div style="width:100%;margin-left:10px;align:center">
		<div style="width:100%;margin-left:10px;align:center">
			<tr><td>组装</td></tr>		
			<table style="width:100%;border:solid 1px">
				<thead style="align:left;border:solid 1px">
					<tr>
						<td style="width:11%">主材(￥)</td>
						<td style="width:11%">其他材料(￥)</td>
						<td style="width:11%">材料合计(￥)</td>
						<td style="width:11%">人工(￥)</td>
						<td style="width:11%">动力(￥)</td>
						<td style="width:11%">折旧(￥)</td>
						<td style="width:11%">维修(￥)</td>
						<td style="width:11%">其他(￥)</td>
						<td style="width:11%">组装千只总成本(￥)</td>
					</tr>
				</thead>
				<tbody style="align:left;border:solid 1px">
					<tr>
						<td style="width:11%"><input id="advmatassy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="othmatassy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="matcomassy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="artifiassy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="powerassy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="deprectassy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="maintainassy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="otherassy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="thoutalcostassy" value="" readonly="readonly" style="background:transparent;border:0"></td>
					</tr>					
				</tbody>
			</table>
		</div>
		<div style="width:100%;margin-left:10px;align:center">
			<tr><td>测试(小时)</td></tr>		
			<table style="width:100%;border:solid 1px">
				<thead style="align:left;border:solid 1px">
					<tr>
						<td style="width:11%">测试机</td>
						<td style="width:11%">机械手</td>
						<td style="width:11%">材料(￥)</td>
						<td style="width:11%">人工(￥)</td>
						<td style="width:11%">动力(￥)</td>
						<td style="width:11%">折旧(￥)</td>
						<td style="width:11%">维修(￥)</td>
						<td style="width:11%">其他(￥)</td>
						<td style="width:11%">测试小时总成本(￥)</td>
					</tr>
				</thead>
				<tbody style="align:left;border:solid 1px">
					<tr>
						<td style="width:11%"><input id="testertime" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="handertime" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="mattime" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="artifitime" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="powertime" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="deprecttime" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="maintaintime" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="othertime" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="testtalcosttime" value="" readonly="readonly" style="background:transparent;border:0"></td>
					</tr>					
				</tbody>
			</table>		
		</div>
		<div style="width:100%;margin-left:10px;align:center">
			<tr><td>测试(千只)</td></tr>		
			<table style="width:100%;border:solid 1px">
				<thead style="align:left;border:solid 1px">
					<tr>
						<td style="width:11%">测试机</td>
						<td style="width:11%">机械手</td>
						<td style="width:11%">材料(￥)</td>
						<td style="width:11%">人工(￥)</td>
						<td style="width:11%">动力(￥)</td>
						<td style="width:11%">折旧(￥)</td>
						<td style="width:11%">维修(￥)</td>
						<td style="width:11%">其他(￥)</td>
						<td style="width:11%">测试千只总成本(￥)</td>
					</tr>
				</thead>
				<tbody style="align:left;border:solid 1px">
					<tr>
						<td style="width:11%"><input id="testerthou" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="handerthou" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="matthou" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="artifithou" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="powerthou" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="deprectthou" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="maintainthou" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="otherthou" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="testtalcostthou" value="" readonly="readonly" style="background:transparent;border:0"></td>
					</tr>					
				</tbody>
			</table>		
		</div>
		<div style="width:100%;margin-left:10px;align:center">
			<tr><td>包装</td></tr>		
			<table style="width:100%;border:solid 1px">
				<thead style="align:left;border:solid 1px">
					<tr>
						<td style="width:11%">形式</td>
						<td style="width:11%">档次</td>
						<td style="width:11%">材料(￥)</td>
						<td style="width:11%">人工(￥)</td>
						<td style="width:11%">动力(￥)</td>
						<td style="width:11%">折旧(￥)</td>
						<td style="width:11%">维修(￥)</td>
						<td style="width:11%">其他(￥)</td>
						<td style="width:11%">包装千只总成本(￥)</td>
					</tr>
				</thead>
				<tbody style="align:left;border:solid 1px">
					<tr>
						<td style="width:11%"><input id="formpack" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="gradepack" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="matpack" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="artifipack" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="powerpack" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="deprectpack" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="maintainpack" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="otherpack" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:11%"><input id="packtalcostpack" value="" readonly="readonly" style="background:transparent;border:0"></td>
					</tr>					
				</tbody>
			</table>		
		</div>
		<div style="width:100%;margin-left:10px;align:center">
			<tr><td>合计</td></tr>		
			<table style="width:100%;border:solid 1px">
				<thead style="align:center;border:solid 1px">
					<tr>						
						<td style="width:14%">材料合计(￥)</td>
						<td style="width:14%">人工合计(￥)</td>
						<td style="width:14%">动力合计(￥)</td>
						<td style="width:14%">折旧合计(￥)</td>
						<td style="width:14%">维修合计(￥)</td>
						<td style="width:14%">其他合计(￥)</td>
						<td style="width:14%">千只总成本合计(￥)</td>
					</tr>
				</thead>
				<tbody style="align:center;border:solid 1px">
					<tr>
						<td style="width:14%"><input id="mattotl" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:14%"><input id="artiftotl" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:14%"><input id="powertotl" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:14%"><input id="deprectotl" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:14%"><input id="mainttotl" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:14%"><input id="othertotl" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:14%"><input id="totalcosttotl" value="" readonly="readonly" style="background:transparent;border:0"></td>
					</tr>					
				</tbody>
			</table>		
		</div>
	</div>
</FORM>

</BODY></HTML>


<script language="javascript">	

	jQuery(document).ready(function(){
		requestid = window.opener.document.getElementById("requestid").value;
		var Quotation_way = window.opener.document.getElementById('field48576').value;
		doshow(requestid,Quotation_way);
	});
	
	function insertTd(project, type, price) {
		row = document.createElement("tr"); //创建行
		td1 = document.createElement("td"); //创建单元格1
		td1.setAttribute("width", "120px"); // 设置单元格1样式
		input1 = document.createElement("input"); // 创建文本框1
		td2 = document.createElement("td");
		td2.setAttribute("width", "100px");
		input2 = document.createElement("input");
		td3 = document.createElement("td");
		td3.setAttribute("width", "280px");
		input3 = document.createElement("input");
		input1.setAttribute("value", project); // 设置文本框1内值
		input1.setAttribute("readonly", "readonly");// 设置文本框1只读
		input2.setAttribute("value", type);
		input2.setAttribute("readonly", "readonly");
		input3.setAttribute("value", price);
		input3.setAttribute("readonly", "readonly");
		td1.appendChild(input1); // 将文本框1添加到单元格1的下级目录中
		td2.appendChild(input2);
		td3.appendChild(input3);
		row.appendChild(td1); // 将单元格1添加到行的下级目录中
		row.appendChild(td2);
		row.appendChild(td3);
		document.getElementById("mtbody").append(row); // 将新增行插入到id为mtbody的表格中
	}
	
	function doshow(requestid,Quotation_way){
		var rate = 1;
		if (Quotation_way == 1) {
			
			jQuery.ajax({
				url: "costList02.jsp",			
				data: {requestid:requestid,Quotation_way:Quotation_way},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					var list1 = result[0];
					var str = "";
					for (var i = 0; i < list1.length; i++) {
						insertTd(list1[i].PROJECT, list1[i].MODEL, list1[i].AMOUNT);
					}
					rate = result[1].CURRENCY;
					var advmatassy = result[1].ADV_MAT_ASSY;
					var othmatassy = result[1].OTH_MAT_ASSY;
					var matcomassy = result[1].MAT_COM_ASSY;
					var artifiassy = result[1].ARTIFI_ASSY;
					var powerassy = result[1].POWER_ASSY;
					var deprectassy = result[1].DEPRECT_ASSY;
					var maintainassy = result[1].MAINTAIN_ASSY;
					var otherassy = result[1].OTHER_ASSY;
					var thoutalcostassy = result[1].THOU_TAL_COST_ASSY;
					var testertime = result[1].TESTER_TIME;
					var handertime = result[1].HANDER_TIME;
					var mattime = result[1].MAT_TIME;
					var artifitime = result[1].ARTIFI_TIME;
					var powertime = result[1].POWER_TIME;
					var deprecttime = result[1].DEPRECT_TIME;
					var maintaintime = result[1].MAINTAIN_TIME;
					var othertime = result[1].OTHER_TIME;
					var testtalcosttime = result[1].TEST_TAL_COST_TIME;
					var testerthou = result[1].TESTER_THOU;
					var handerthou = result[1].HANDER_THOU;
					var matthou = result[1].MAT_THOU;
					var artifithou = result[1].ARTIFI_THOU;
					var powerthou = result[1].POWER_THOU;
					var deprectthou = result[1].DEPRECT_THOU;
					var maintainthou = result[1].MAINTAIN_THOU;
					var otherthou = result[1].OTHER_THOU;
					var testtalcostthou = result[1].TEST_TAL_COST_THOU;
					var formpack = result[1].FORM_PACK;
					var gradepack = result[1].GRADE_PACK;
					var matpack = result[1].MAT_PACK;
					var artifipack = result[1].ARTIFI_PACK;
					var powerpack = result[1].POWER_PACK;
					var deprectpack = result[1].DEPRECT_PACK;
					var maintainpack = result[1].MAINTAIN_PACK;
					var otherpack = result[1].OTHER_PACK;
					var packtalcostpack = result[1].PACK_TAL_COST_PACK;
					var mattotl = result[1].MAT_TOTL;
					var artiftotl = result[1].ARTIF_TOTL;
					var powertotl = result[1].POWER_TOTL;
					var deprectotl = result[1].DEPREC_TOTL;
					var mainttotl = result[1].MAINT_TOTL;
					var othertotl = result[1].OTHER_TOTL;
					var totalcosttotl = result[1].TOTAL_COST_TOTL;
					
					if (result[1].CURRENCY == "0") {
						rate = 1;
					}
					if (result[1].THOU_TAL_COST_ASSY != "0") {
						$("#advmatassy").val((Math.round(parseFloat(advmatassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(advmatassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#othmatassy").val((Math.round(parseFloat(othmatassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(othmatassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#matcomassy").val((Math.round(parseFloat(matcomassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(matcomassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#artifiassy").val((Math.round(parseFloat(artifiassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(artifiassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#powerassy").val((Math.round(parseFloat(powerassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(powerassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#deprectassy").val((Math.round(parseFloat(deprectassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(deprectassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#maintainassy").val((Math.round(parseFloat(maintainassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(maintainassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#otherassy").val((Math.round(parseFloat(otherassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(otherassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#thoutalcostassy").val((Math.round(parseFloat(thoutalcostassy) * 100) /100).toFixed(2));
					} else {
						$("#advmatassy").val((Math.round(parseFloat(advmatassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#othmatassy").val((Math.round(parseFloat(othmatassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#matcomassy").val((Math.round(parseFloat(matcomassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#artifiassy").val((Math.round(parseFloat(artifiassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#powerassy").val((Math.round(parseFloat(powerassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#deprectassy").val((Math.round(parseFloat(deprectassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#maintainassy").val((Math.round(parseFloat(maintainassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#otherassy").val((Math.round(parseFloat(otherassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#thoutalcostassy").val((Math.round(parseFloat(thoutalcostassy) * 100) /100).toFixed(2));
					}
					
					if (result[1].TEST_QUOTATION_WAY_FAST == "1"){
						$("#testertime").val(testertime);
						$("#handertime").val(handertime);
						if (testtalcosttime != "0") {
							$("#mattime").val((Math.round(parseFloat(mattime) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(mattime) / parseFloat(testtalcosttime) * 10000) / 100).toFixed(2) + "%)");
							$("#artifitime").val((Math.round(parseFloat(artifitime) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(artifitime) / parseFloat(testtalcosttime) * 10000) / 100).toFixed(2) + "%)");
							$("#powertime").val((Math.round(parseFloat(powertime) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(powertime) / parseFloat(testtalcosttime) * 10000) / 100).toFixed(2) + "%)");
							$("#deprecttime").val((Math.round(parseFloat(deprecttime) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(deprecttime) / parseFloat(testtalcosttime) * 10000) / 100).toFixed(2) + "%)");
							$("#maintaintime").val((Math.round(parseFloat(maintaintime) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(maintaintime) / parseFloat(testtalcosttime) * 10000) / 100).toFixed(2) + "%)");
							$("#othertime").val((Math.round(parseFloat(othertime) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(othertime) / parseFloat(testtalcosttime) * 10000) / 100).toFixed(2) + "%)");
							$("#testtalcosttime").val((Math.round(parseFloat(testtalcosttime) * 100) /100).toFixed(2));
						} else {
							$("#mattime").val((Math.round(parseFloat(mattime) * 100) /100).toFixed(2) + "(0.00%)");
							$("#artifitime").val((Math.round(parseFloat(artifitime) * 100) /100).toFixed(2) + "(0.00%)");
							$("#powertime").val((Math.round(parseFloat(powertime) * 100) /100).toFixed(2) + "(0.00%)");
							$("#deprecttime").val((Math.round(parseFloat(deprecttime) * 100) /100).toFixed(2) + "(0.00%)");
							$("#maintaintime").val((Math.round(parseFloat(maintaintime) * 100) /100).toFixed(2) + "(0.00%)");
							$("#othertime").val((Math.round(parseFloat(othertime) * 100) /100).toFixed(2) + "(0.00%)");
							$("#testtalcosttime").val((Math.round(parseFloat(testtalcosttime) * 100) /100).toFixed(2));
						}
					}
					
					if (result[1].TEST_QUOTATION_WAY_FAST == "0"){
						$("#testerthou").val(testerthou);
						$("#handerthou").val(handerthou);
						if (testtalcostthou != "0") {
							$("#matthou").val((Math.round(parseFloat(matthou) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(matthou) / parseFloat(testtalcostthou) * 10000) / 100).toFixed(2) + "%)");
							$("#artifithou").val((Math.round(parseFloat(artifithou) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(artifithou) / parseFloat(testtalcostthou) * 10000) / 100).toFixed(2) + "%)");
							$("#powerthou").val((Math.round(parseFloat(powerthou) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(powerthou) / parseFloat(testtalcostthou) * 10000) / 100).toFixed(2) + "%)");
							$("#deprectthou").val((Math.round(parseFloat(deprectthou) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(deprectthou) / parseFloat(testtalcostthou) * 10000) / 100).toFixed(2) + "%)");
							$("#maintainthou").val((Math.round(parseFloat(maintainthou) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(maintainthou) / parseFloat(testtalcostthou) * 10000) / 100).toFixed(2) + "%)");
							$("#otherthou").val((Math.round(parseFloat(otherthou) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(otherthou) / parseFloat(testtalcostthou) * 10000) / 100).toFixed(2) + "%)");
							$("#testtalcostthou").val((Math.round(parseFloat(testtalcostthou) * 100) /100).toFixed(2));
						} else {
							$("#matthou").val((Math.round(parseFloat(matthou) * 100) /100).toFixed(2) + "(0.00%)");
							$("#artifithou").val((Math.round(parseFloat(artifithou) * 100) /100).toFixed(2) + "(0.00%)");
							$("#powerthou").val((Math.round(parseFloat(powerthou) * 100) /100).toFixed(2) + "(0.00%)");
							$("#deprectthou").val((Math.round(parseFloat(deprectthou) * 100) /100).toFixed(2) + "(0.00%)");
							$("#maintainthou").val((Math.round(parseFloat(maintainthou) * 100) /100).toFixed(2) + "(0.00%)");
							$("#otherthou").val((Math.round(parseFloat(otherthou) * 100) /100).toFixed(2) + "(0.00%)");
							$("#testtalcostthou").val((Math.round(parseFloat(testtalcostthou) * 100) /100).toFixed(2));
						}
						
					}
					
					$("#formpack").val(formpack);
					$("#gradepack").val(gradepack);
					if (packtalcostpack != "0") {
						$("#matpack").val((Math.round(parseFloat(matpack) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(matpack) / parseFloat(packtalcostpack) * 10000) / 100).toFixed(2) + "%)");
						$("#artifipack").val((Math.round(parseFloat(artifipack) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(artifipack) / parseFloat(packtalcostpack) * 10000) / 100).toFixed(2) + "%)");
						$("#powerpack").val((Math.round(parseFloat(powerpack) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(powerpack) / parseFloat(packtalcostpack) * 10000) / 100).toFixed(2) + "%)");
						$("#deprectpack").val((Math.round(parseFloat(deprectpack) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(deprectpack) / parseFloat(packtalcostpack) * 10000) / 100).toFixed(2) + "%)");
						$("#maintainpack").val((Math.round(parseFloat(maintainpack) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(maintainpack) / parseFloat(packtalcostpack) * 10000) / 100).toFixed(2) + "%)");
						$("#otherpack").val((Math.round(parseFloat(otherpack) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(otherpack) / parseFloat(packtalcostpack) * 10000) / 100).toFixed(2) + "%)");
						$("#packtalcostpack").val((Math.round(parseFloat(packtalcostpack) * 100) /100).toFixed(2));
					} else {
						$("#matpack").val((Math.round(parseFloat(matpack) * 100) /100).toFixed(2) + "(0.00%)");
						$("#artifipack").val((Math.round(parseFloat(artifipack) * 100) /100).toFixed(2) + "(0.00%)");
						$("#powerpack").val((Math.round(parseFloat(powerpack) * 100) /100).toFixed(2) + "(0.00%)");
						$("#deprectpack").val((Math.round(parseFloat(deprectpack) * 100) /100).toFixed(2) + "(0.00%)");
						$("#maintainpack").val((Math.round(parseFloat(maintainpack) * 100) /100).toFixed(2) + "(0.00%)");
						$("#otherpack").val((Math.round(parseFloat(otherpack) * 100) /100).toFixed(2) + "(0.00%)");
						$("#packtalcostpack").val((Math.round(parseFloat(packtalcostpack) * 100) /100).toFixed(2));
					}
						
					if (totalcosttotl != "0") {
						$("#mattotl").val((Math.round(parseFloat(mattotl) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(mattotl) / parseFloat(totalcosttotl) * 10000) / 100).toFixed(2) + "%)");
						$("#artiftotl").val((Math.round(parseFloat(artiftotl) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(artiftotl) / parseFloat(totalcosttotl) * 10000) / 100).toFixed(2) + "%)");
						$("#powertotl").val((Math.round(parseFloat(powertotl) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(powertotl) / parseFloat(totalcosttotl) * 10000) / 100).toFixed(2) + "%)");
						$("#deprectotl").val((Math.round(parseFloat(deprectotl) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(deprectotl) / parseFloat(totalcosttotl) * 10000) / 100).toFixed(2) + "%)");
						$("#mainttotl").val((Math.round(parseFloat(mainttotl) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(mainttotl) / parseFloat(totalcosttotl) * 10000) / 100).toFixed(2) + "%)");
						$("#othertotl").val((Math.round(parseFloat(othertotl) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(othertotl) / parseFloat(totalcosttotl) * 10000) / 100).toFixed(2) + "%)");
						$("#totalcosttotl").val((Math.round(parseFloat(totalcosttotl) * 100) /100).toFixed(2));
					} else {
						$("#mattotl").val((Math.round(parseFloat(mattotl) * 100) /100).toFixed(2) + "(0.00%)");
						$("#artiftotl").val((Math.round(parseFloat(artiftotl) * 100) /100).toFixed(2) + "(0.00%)");
						$("#powertotl").val((Math.round(parseFloat(powertotl) * 100) /100).toFixed(2) + "(0.00%)");
						$("#deprectotl").val((Math.round(parseFloat(deprectotl) * 100) /100).toFixed(2) + "(0.00%)");
						$("#mainttotl").val((Math.round(parseFloat(mainttotl) * 100) /100).toFixed(2) + "(0.00%)");
						$("#othertotl").val((Math.round(parseFloat(othertotl) * 100) /100).toFixed(2) + "(0.00%)");
						$("#totalcosttotl").val((Math.round(parseFloat(totalcosttotl) * 100) /100).toFixed(2));
					}	
				}
			});
		} else {
			jQuery.ajax({
				url: "costList01.jsp",					
				data: {requestid: requestid,Quotation_way:Quotation_way},
				cache: false,
				type: "post",
				dataType: "json",
				async: false,
				success: function (result) {
					var advmatassy = result.ADV_MAT_ASSY;
					var othmatassy = result.OTH_MAT_ASSY;
					var matcomassy = result.MAT_COM_ASSY;
					var artifiassy = result.ARTIFI_ASSY;
					var powerassy = result.POWER_ASSY;
					var deprectassy = result.DEPRECT_ASSY;
					var maintainassy = result.MAINTAIN_ASSY;
					var otherassy = result.OTHER_ASSY;
					var thoutalcostassy = result.THOU_TAL_COST_ASSY;
					var testertime = result.TESTER_TIME;
					var handertime = result.HANDER_TIME;
					var mattime = result.MAT_TIME;
					var artifitime = result.ARTIFI_TIME;
					var powertime = result.POWER_TIME;
					var deprecttime = result.DEPRECT_TIME;
					var maintaintime = result.MAINTAIN_TIME;
					var othertime = result.OTHER_TIME;
					var testtalcosttime = result.TEST_TAL_COST_TIME;
					var testerthou = result.TESTER_THOU;
					var handerthou = result.HANDER_THOU;
					var matthou = result.MAT_THOU;
					var artifithou = result.ARTIFI_THOU;
					var powerthou = result.POWER_THOU;
					var deprectthou = result.DEPRECT_THOU;
					var maintainthou = result.MAINTAIN_THOU;
					var otherthou = result.OTHER_THOU;
					var testtalcostthou = result.TEST_TAL_COST_THOU;
					var formpack = result.FORM_PACK;
					var gradepack = result.GRADE_PACK;
					var matpack = result.MAT_PACK;
					var artifipack = result.ARTIFI_PACK;
					var powerpack = result.POWER_PACK;
					var deprectpack = result.DEPRECT_PACK;
					var maintainpack = result.MAINTAIN_PACK;
					var otherpack = result.OTHER_PACK;
					var packtalcostpack = result.PACK_TAL_COST_PACK;
					var mattotl = result.MAT_TOTL;
					var artiftotl = result.ARTIF_TOTL;
					var powertotl = result.POWER_TOTL;
					var deprectotl = result.DEPREC_TOTL;
					var mainttotl = result.MAINT_TOTL;
					var othertotl = result.OTHER_TOTL;
					var totalcosttotl = result.TOTAL_COST_TOTL;
					var shape = result.SHAPE;
					var rate = result.EXCHANGE_RATE;
					var wirebondtype = result.WIRE_BOND_FAST;
					var wirebondprice = result.WIRE_BOND_PRICE;
					var frame = result.FRAMEWORK_TECH_FAST;
					var frameprice = result.FRAME_PRICE;
					var molding = result.ENCAPSULA_MAT_FAST;
					var moldingprice = result.MOLDING_PRICE;
					var slice = result.MAT_FAST;
					var sliceprice = result.SLICE_PRICE;
					
					$("#shape").val(shape);
					$("#rate").val(rate);
					
					insertTd("键合", wirebondtype, wirebondprice);
					insertTd("框架工艺", frame, frameprice);
					insertTd("塑封料", molding, moldingprice);
					insertTd("装片胶", slice, sliceprice);
					
					if (result.THOU_TAL_COST_ASSY != "0") {
						$("#advmatassy").val((Math.round(parseFloat(advmatassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(advmatassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#othmatassy").val((Math.round(parseFloat(othmatassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(othmatassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#matcomassy").val((Math.round(parseFloat(matcomassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(matcomassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#artifiassy").val((Math.round(parseFloat(artifiassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(artifiassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#powerassy").val((Math.round(parseFloat(powerassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(powerassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#deprectassy").val((Math.round(parseFloat(deprectassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(deprectassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#maintainassy").val((Math.round(parseFloat(maintainassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(maintainassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#otherassy").val((Math.round(parseFloat(otherassy) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(otherassy) / parseFloat(thoutalcostassy) * 10000) / 100).toFixed(2) + "%)");
						$("#thoutalcostassy").val((Math.round(parseFloat(thoutalcostassy) * 100) /100).toFixed(2));
					} else {
						$("#advmatassy").val((Math.round(parseFloat(advmatassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#othmatassy").val((Math.round(parseFloat(othmatassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#matcomassy").val((Math.round(parseFloat(matcomassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#artifiassy").val((Math.round(parseFloat(artifiassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#powerassy").val((Math.round(parseFloat(powerassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#deprectassy").val((Math.round(parseFloat(deprectassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#maintainassy").val((Math.round(parseFloat(maintainassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#otherassy").val((Math.round(parseFloat(otherassy) * 100) /100).toFixed(2) + "(0.00%)");
						$("#thoutalcostassy").val((Math.round(parseFloat(thoutalcostassy) * 100) /100).toFixed(2));
					}
					
					if (result.TEST_QUOTATION_WAY_FAST == "1"){
						$("#testertime").val(testertime);
						$("#handertime").val(handertime);
						if (testtalcosttime != "0") {
							$("#mattime").val((Math.round(parseFloat(mattime) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(mattime) / parseFloat(testtalcosttime) * 10000) / 100).toFixed(2) + "%)");
							$("#artifitime").val((Math.round(parseFloat(artifitime) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(artifitime) / parseFloat(testtalcosttime) * 10000) / 100).toFixed(2) + "%)");
							$("#powertime").val((Math.round(parseFloat(powertime) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(powertime) / parseFloat(testtalcosttime) * 10000) / 100).toFixed(2) + "%)");
							$("#deprecttime").val((Math.round(parseFloat(deprecttime) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(deprecttime) / parseFloat(testtalcosttime) * 10000) / 100).toFixed(2) + "%)");
							$("#maintaintime").val((Math.round(parseFloat(maintaintime) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(maintaintime) / parseFloat(testtalcosttime) * 10000) / 100).toFixed(2) + "%)");
							$("#othertime").val((Math.round(parseFloat(othertime) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(othertime) / parseFloat(testtalcosttime) * 10000) / 100).toFixed(2) + "%)");
							$("#testtalcosttime").val((Math.round(parseFloat(testtalcosttime) * 100) /100).toFixed(2));
						} else {
							$("#mattime").val((Math.round(parseFloat(mattime) * 100) /100).toFixed(2) + "(0.00%)");
							$("#artifitime").val((Math.round(parseFloat(artifitime) * 100) /100).toFixed(2) + "(0.00%)");
							$("#powertime").val((Math.round(parseFloat(powertime) * 100) /100).toFixed(2) + "(0.00%)");
							$("#deprecttime").val((Math.round(parseFloat(deprecttime) * 100) /100).toFixed(2) + "(0.00%)");
							$("#maintaintime").val((Math.round(parseFloat(maintaintime) * 100) /100).toFixed(2) + "(0.00%)");
							$("#othertime").val((Math.round(parseFloat(othertime) * 100) /100).toFixed(2) + "(0.00%)");
							$("#testtalcosttime").val((Math.round(parseFloat(testtalcosttime) * 100) /100).toFixed(2));
						}
					}
					
					if (result.TEST_QUOTATION_WAY_FAST == "0"){
						$("#testerthou").val(testerthou);
						$("#handerthou").val(handerthou);
						if (testtalcostthou != "0") {
							$("#matthou").val((Math.round(parseFloat(matthou) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(matthou) / parseFloat(testtalcostthou) * 10000) / 100).toFixed(2) + "%)");
							$("#artifithou").val((Math.round(parseFloat(artifithou) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(artifithou) / parseFloat(testtalcostthou) * 10000) / 100).toFixed(2) + "%)");
							$("#powerthou").val((Math.round(parseFloat(powerthou) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(powerthou) / parseFloat(testtalcostthou) * 10000) / 100).toFixed(2) + "%)");
							$("#deprectthou").val((Math.round(parseFloat(deprectthou) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(deprectthou) / parseFloat(testtalcostthou) * 10000) / 100).toFixed(2) + "%)");
							$("#maintainthou").val((Math.round(parseFloat(maintainthou) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(maintainthou) / parseFloat(testtalcostthou) * 10000) / 100).toFixed(2) + "%)");
							$("#otherthou").val((Math.round(parseFloat(otherthou) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(otherthou) / parseFloat(testtalcostthou) * 10000) / 100).toFixed(2) + "%)");
							$("#testtalcostthou").val((Math.round(parseFloat(testtalcostthou) * 100) /100).toFixed(2));
						} else {
							$("#matthou").val((Math.round(parseFloat(matthou) * 100) /100).toFixed(2) + "(0.00%)");
							$("#artifithou").val((Math.round(parseFloat(artifithou) * 100) /100).toFixed(2) + "(0.00%)");
							$("#powerthou").val((Math.round(parseFloat(powerthou) * 100) /100).toFixed(2) + "(0.00%)");
							$("#deprectthou").val((Math.round(parseFloat(deprectthou) * 100) /100).toFixed(2) + "(0.00%)");
							$("#maintainthou").val((Math.round(parseFloat(maintainthou) * 100) /100).toFixed(2) + "(0.00%)");
							$("#otherthou").val((Math.round(parseFloat(otherthou) * 100) /100).toFixed(2) + "(0.00%)");
							$("#testtalcostthou").val((Math.round(parseFloat(testtalcostthou) * 100) /100).toFixed(2));
						}
						
					}
					
					$("#formpack").val(formpack);
					$("#gradepack").val(gradepack);
					if (packtalcostpack != "0") {
						$("#matpack").val((Math.round(parseFloat(matpack) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(matpack) / parseFloat(packtalcostpack) * 10000) / 100).toFixed(2) + "%)");
						$("#artifipack").val((Math.round(parseFloat(artifipack) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(artifipack) / parseFloat(packtalcostpack) * 10000) / 100).toFixed(2) + "%)");
						$("#powerpack").val((Math.round(parseFloat(powerpack) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(powerpack) / parseFloat(packtalcostpack) * 10000) / 100).toFixed(2) + "%)");
						$("#deprectpack").val((Math.round(parseFloat(deprectpack) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(deprectpack) / parseFloat(packtalcostpack) * 10000) / 100).toFixed(2) + "%)");
						$("#maintainpack").val((Math.round(parseFloat(maintainpack) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(maintainpack) / parseFloat(packtalcostpack) * 10000) / 100).toFixed(2) + "%)");
						$("#otherpack").val((Math.round(parseFloat(otherpack) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(otherpack) / parseFloat(packtalcostpack) * 10000) / 100).toFixed(2) + "%)");
						$("#packtalcostpack").val((Math.round(parseFloat(packtalcostpack) * 100) /100).toFixed(2));
					} else {
						$("#matpack").val((Math.round(parseFloat(matpack) * 100) /100).toFixed(2) + "(0.00%)");
						$("#artifipack").val((Math.round(parseFloat(artifipack) * 100) /100).toFixed(2) + "(0.00%)");
						$("#powerpack").val((Math.round(parseFloat(powerpack) * 100) /100).toFixed(2) + "(0.00%)");
						$("#deprectpack").val((Math.round(parseFloat(deprectpack) * 100) /100).toFixed(2) + "(0.00%)");
						$("#maintainpack").val((Math.round(parseFloat(maintainpack) * 100) /100).toFixed(2) + "(0.00%)");
						$("#otherpack").val((Math.round(parseFloat(otherpack) * 100) /100).toFixed(2) + "(0.00%)");
						$("#packtalcostpack").val((Math.round(parseFloat(packtalcostpack) * 100) /100).toFixed(2));
					}
						
					if (totalcosttotl != "0") {
						$("#mattotl").val((Math.round(parseFloat(mattotl) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(mattotl) / parseFloat(totalcosttotl) * 10000) / 100).toFixed(2) + "%)");
						$("#artiftotl").val((Math.round(parseFloat(artiftotl) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(artiftotl) / parseFloat(totalcosttotl) * 10000) / 100).toFixed(2) + "%)");
						$("#powertotl").val((Math.round(parseFloat(powertotl) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(powertotl) / parseFloat(totalcosttotl) * 10000) / 100).toFixed(2) + "%)");
						$("#deprectotl").val((Math.round(parseFloat(deprectotl) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(deprectotl) / parseFloat(totalcosttotl) * 10000) / 100).toFixed(2) + "%)");
						$("#mainttotl").val((Math.round(parseFloat(mainttotl) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(mainttotl) / parseFloat(totalcosttotl) * 10000) / 100).toFixed(2) + "%)");
						$("#othertotl").val((Math.round(parseFloat(othertotl) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(othertotl) / parseFloat(totalcosttotl) * 10000) / 100).toFixed(2) + "%)");
						$("#totalcosttotl").val((Math.round(parseFloat(totalcosttotl) * 100) /100).toFixed(2));
					} else {
						$("#mattotl").val((Math.round(parseFloat(mattotl) * 100) /100).toFixed(2) + "(0.00%)");
						$("#artiftotl").val((Math.round(parseFloat(artiftotl) * 100) /100).toFixed(2) + "(0.00%)");
						$("#powertotl").val((Math.round(parseFloat(powertotl) * 100) /100).toFixed(2) + "(0.00%)");
						$("#deprectotl").val((Math.round(parseFloat(deprectotl) * 100) /100).toFixed(2) + "(0.00%)");
						$("#mainttotl").val((Math.round(parseFloat(mainttotl) * 100) /100).toFixed(2) + "(0.00%)");
						$("#othertotl").val((Math.round(parseFloat(othertotl) * 100) /100).toFixed(2) + "(0.00%)");
						$("#totalcosttotl").val((Math.round(parseFloat(totalcosttotl) * 100) /100).toFixed(2));
					}
				}
			});
		}
	}
</script>

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
				<tbody style="align:center;border:solid 1px">
					<tr>
						<td style="width:120px"><input id="wirebondname" value="键合" readonly="readonly"></input></td>
						<td style="width:100px"><input id="wirebondtype" value="" readonly="readonly"></input></td>
						<td style="width:280px"><input id="wirebondprice" value="" readonly="readonly"></input></td>
					</tr>
					<tr>
						<td style="width:120px"><input id="framename" value="框架工艺" readonly="readonly"></input></td>
						<td style="width:100px"><input id="frame" value="" readonly="readonly"></input></td>
						<td style="width:280px"><input id="frameprice" value="" readonly="readonly"></input></td>
					</tr>
					<tr>
						<td style="width:120px"><input id="moldingname" value="塑封料" readonly="readonly"></input></td>
						<td style="width:100px"><input id="molding" value="" readonly="readonly"></input></td>
						<td style="width:280px"><input id="moldingprice" value="" readonly="readonly"></input></td>
					</tr>
					<tr>
						<td style="width:120px"><input id="slicename" value="装片胶" readonly="readonly"></input></td>
						<td style="width:100px"><input id="slice" value="" readonly="readonly"></input></td>
						<td style="width:280px"><input id="sliceprice" value="" readonly="readonly"></input></td>
					</tr>
				</tbody>
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
		//Quotation_way = window.opener.document.getElementById("field"+ Quotation_way).value;	
		//$("#_xTable").find("table.ListStyle").live('click',BrowseTable_onclick);
		var Quotation_way = window.opener.document.getElementById('field19684').value;
		doshow(requestid,Quotation_way);
	});

	function doshow(requestid,Quotation_way){
		var rate = 1;		
		jQuery.ajax({
				url: "/interface/ff/Quotation/costList01.jsp",						
				data: {requestid: requestid,Quotation_way:Quotation_way},
				cache: false,
				type: "post",
				dataType: "text",
				async: false,
				success: function (sb) {
					sb = jQuery.trim(sb);
					var ary1  = new Array();
					ary1 = sb.split(" ");
					if(sb != "" ){						
						$("#shape").val(ary1[53]);
						$("#rate").val(ary1[54]);
						rate = parseFloat(ary1[54]);
						$("#wirebondtype").val(ary1[43]);
						$("#wirebondprice").val(parseFloat(ary1[47]).toFixed(2));
						$("#frame").val(ary1[44]);
						$("#frameprice").val(parseFloat(ary1[48]).toFixed(2));
						$("#molding").val(ary1[45]);
						$("#moldingprice").val(parseFloat(ary1[49]).toFixed(2));
						$("#slice").val(ary1[46]);
						$("#sliceprice").val(parseFloat(ary1[50]).toFixed(2));						
						if (ary1[51] == "0"){
							rate = 1;
						}
						if (ary1[8] != "0"){
							$("#advmatassy").val((Math.round(rate * parseFloat(ary1[0]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[0]) / parseFloat(ary1[8]) * 10000) / 100).toFixed(2) + "%)");
							$("#othmatassy").val((Math.round(rate * parseFloat(ary1[1]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[1]) / parseFloat(ary1[8]) * 10000) / 100).toFixed(2) + "%)");
							$("#matcomassy").val((Math.round(rate * parseFloat(ary1[2]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[2]) / parseFloat(ary1[8]) * 10000) / 100).toFixed(2) + "%)");
							$("#artifiassy").val((Math.round(rate * parseFloat(ary1[3]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[3]) / parseFloat(ary1[8]) * 10000) / 100).toFixed(2) + "%)");
							$("#powerassy").val((Math.round(rate * parseFloat(ary1[4]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[4]) / parseFloat(ary1[8]) * 10000) / 100).toFixed(2) + "%)");
							$("#deprectassy").val((Math.round(rate * parseFloat(ary1[5]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[5]) / parseFloat(ary1[8]) * 10000) / 100).toFixed(2) + "%)");
							$("#maintainassy").val((Math.round(rate * parseFloat(ary1[6]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[6]) / parseFloat(ary1[8]) * 10000) / 100).toFixed(2) + "%)");
							$("#otherassy").val((Math.round(rate * parseFloat(ary1[7]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[7]) / parseFloat(ary1[8]) * 10000) / 100).toFixed(2) + "%)");
							$("#thoutalcostassy").val((Math.round(rate * parseFloat(ary1[8]) * 100) /100).toFixed(2));
						} else {
							$("#advmatassy").val((Math.round(rate * parseFloat(ary1[0]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#othmatassy").val((Math.round(rate * parseFloat(ary1[1]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#matcomassy").val((Math.round(rate * parseFloat(ary1[2]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#artifiassy").val((Math.round(rate * parseFloat(ary1[3]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#powerassy").val((Math.round(rate * parseFloat(ary1[4]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#deprectassy").val((Math.round(rate * parseFloat(ary1[5]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#maintainassy").val((Math.round(rate * parseFloat(ary1[6]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#otherassy").val((Math.round(rate * parseFloat(ary1[7]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#thoutalcostassy").val((Math.round(rate * parseFloat(ary1[8]) * 100) /100).toFixed(2));
						}
						
						
						if (ary1[52] == "1"){
							$("#testertime").val(ary1[9]);
							$("#handertime").val(ary1[10]);
							if (ary1[17] != "0") {
								$("#mattime").val((Math.round(rate * parseFloat(ary1[11]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[11]) / parseFloat(ary1[17]) * 10000) / 100).toFixed(2) + "%)");
								$("#artifitime").val((Math.round(rate * parseFloat(ary1[12]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[12]) / parseFloat(ary1[17]) * 10000) / 100).toFixed(2) + "%)");
								$("#powertime").val((Math.round(rate * parseFloat(ary1[13]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[13]) / parseFloat(ary1[17]) * 10000) / 100).toFixed(2) + "%)");
								$("#deprecttime").val((Math.round(rate * parseFloat(ary1[14]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[14]) / parseFloat(ary1[17]) * 10000) / 100).toFixed(2) + "%)");
								$("#maintaintime").val((Math.round(rate * parseFloat(ary1[15]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[15]) / parseFloat(ary1[17]) * 10000) / 100).toFixed(2) + "%)");
								$("#othertime").val((Math.round(rate * parseFloat(ary1[16]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[16]) / parseFloat(ary1[17]) * 10000) / 100).toFixed(2) + "%)");
								$("#testtalcosttime").val((Math.round(rate * parseFloat(ary1[17]) * 100) /100).toFixed(2));
							} else {
								$("#mattime").val((Math.round(rate * parseFloat(ary1[11]) * 100) /100).toFixed(2) + "(0.00%)");
								$("#artifitime").val((Math.round(rate * parseFloat(ary1[12]) * 100) /100).toFixed(2) + "(0.00%)");
								$("#powertime").val((Math.round(rate * parseFloat(ary1[13]) * 100) /100).toFixed(2) + "(0.00%)");
								$("#deprecttime").val((Math.round(rate * parseFloat(ary1[14]) * 100) /100).toFixed(2) + "(0.00%)");
								$("#maintaintime").val((Math.round(rate * parseFloat(ary1[15]) * 100) /100).toFixed(2) + "(0.00%)");
								$("#othertime").val((Math.round(rate * parseFloat(ary1[16]) * 100) /100).toFixed(2) + "(0.00%)");
								$("#testtalcosttime").val((Math.round(rate * parseFloat(ary1[17]) * 100) /100).toFixed(2));
							}
						}  
												        
						if (ary1[52] == "0"){
							$("#testerthou").val(ary1[18]);
							$("#handerthou").val(ary1[19]);
							if (ary1[26] != "0") {
								$("#matthou").val((Math.round(rate * parseFloat(ary1[20]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[20]) / parseFloat(ary1[26]) * 10000) / 100).toFixed(2) + "%)");
								$("#artifithou").val((Math.round(rate * parseFloat(ary1[21]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[21]) / parseFloat(ary1[26]) * 10000) / 100).toFixed(2) + "%)");
								$("#powerthou").val((Math.round(rate * parseFloat(ary1[22]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[22]) / parseFloat(ary1[26]) * 10000) / 100).toFixed(2) + "%)");
								$("#deprectthou").val((Math.round(rate * parseFloat(ary1[23]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[23]) / parseFloat(ary1[26]) * 10000) / 100).toFixed(2) + "%)");
								$("#maintainthou").val((Math.round(rate * parseFloat(ary1[24]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[24]) / parseFloat(ary1[26]) * 10000) / 100).toFixed(2) + "%)");
								$("#otherthou").val((Math.round(rate * parseFloat(ary1[25]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[25]) / parseFloat(ary1[26]) * 10000) / 100).toFixed(2) + "%)");
								$("#testtalcostthou").val((Math.round(rate * parseFloat(ary1[26]) * 100) /100).toFixed(2));
							} else {
								$("#matthou").val((Math.round(rate * parseFloat(ary1[20]) * 100) /100).toFixed(2) + "(0.00%)");
								$("#artifithou").val((Math.round(rate * parseFloat(ary1[21]) * 100) /100).toFixed(2) + "(0.00%)");
								$("#powerthou").val((Math.round(rate * parseFloat(ary1[22]) * 100) /100).toFixed(2) + "(0.00%)");
								$("#deprectthou").val((Math.round(rate * parseFloat(ary1[23]) * 100) /100).toFixed(2) + "(0.00%)");
								$("#maintainthou").val((Math.round(rate * parseFloat(ary1[24]) * 100) /100).toFixed(2) + "(0.00%)");
								$("#otherthou").val((Math.round(rate * parseFloat(ary1[25]) * 100) /100).toFixed(2) + "(0.00%)");
								$("#testtalcostthou").val((Math.round(rate * parseFloat(ary1[26]) * 100) /100).toFixed(2));
							}
							
						}

						$("#formpack").val(ary1[27]);
						$("#gradepack").val(ary1[28]);
						if (ary1[35] != "0") {
							$("#matpack").val((Math.round(rate * parseFloat(ary1[29]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[29]) / parseFloat(ary1[35]) * 10000) / 100).toFixed(2) + "%)");
							$("#artifipack").val((Math.round(rate * parseFloat(ary1[30]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[30]) / parseFloat(ary1[35]) * 10000) / 100).toFixed(2) + "%)");
							$("#powerpack").val((Math.round(rate * parseFloat(ary1[31]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[31]) / parseFloat(ary1[35]) * 10000) / 100).toFixed(2) + "%)");
							$("#deprectpack").val((Math.round(rate * parseFloat(ary1[32]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[32]) / parseFloat(ary1[35]) * 10000) / 100).toFixed(2) + "%)");
							$("#maintainpack").val((Math.round(rate * parseFloat(ary1[33]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[33]) / parseFloat(ary1[35]) * 10000) / 100).toFixed(2) + "%)");
							$("#otherpack").val((Math.round(rate * parseFloat(ary1[34]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[34]) / parseFloat(ary1[35]) * 10000) / 100).toFixed(2) + "%)");
							$("#packtalcostpack").val((Math.round(rate * parseFloat(ary1[35]) * 100) /100).toFixed(2));
						} else {
							$("#matpack").val((Math.round(rate * parseFloat(ary1[29]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#artifipack").val((Math.round(rate * parseFloat(ary1[30]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#powerpack").val((Math.round(rate * parseFloat(ary1[31]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#deprectpack").val((Math.round(rate * parseFloat(ary1[32]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#maintainpack").val((Math.round(rate * parseFloat(ary1[33]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#otherpack").val((Math.round(rate * parseFloat(ary1[34]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#packtalcostpack").val((Math.round(rate * parseFloat(ary1[35]) * 100) /100).toFixed(2));
						}
						
						if (ary1[42] != "0") {
							$("#mattotl").val((Math.round(rate * parseFloat(ary1[36]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[36]) / parseFloat(ary1[42]) * 10000) / 100).toFixed(2) + "%)");
							$("#artiftotl").val((Math.round(rate * parseFloat(ary1[37]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[37]) / parseFloat(ary1[42]) * 10000) / 100).toFixed(2) + "%)");
							$("#powertotl").val((Math.round(rate * parseFloat(ary1[38]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[38]) / parseFloat(ary1[42]) * 10000) / 100).toFixed(2) + "%)");
							$("#deprectotl").val((Math.round(rate * parseFloat(ary1[39]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[39]) / parseFloat(ary1[42]) * 10000) / 100).toFixed(2) + "%)");
							$("#mainttotl").val((Math.round(rate * parseFloat(ary1[40]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[40]) / parseFloat(ary1[42]) * 10000) / 100).toFixed(2) + "%)");
							$("#othertotl").val((Math.round(rate * parseFloat(ary1[41]) * 100) /100).toFixed(2) + "(" + (Math.round(parseFloat(ary1[41]) / parseFloat(ary1[42]) * 10000) / 100).toFixed(2) + "%)");
							$("#totalcosttotl").val((Math.round(rate * parseFloat(ary1[42]) * 100) /100).toFixed(2));
						} else {
							$("#mattotl").val((Math.round(rate * parseFloat(ary1[36]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#artiftotl").val((Math.round(rate * parseFloat(ary1[37]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#powertotl").val((Math.round(rate * parseFloat(ary1[38]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#deprectotl").val((Math.round(rate * parseFloat(ary1[39]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#mainttotl").val((Math.round(rate * parseFloat(ary1[40]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#othertotl").val((Math.round(rate * parseFloat(ary1[41]) * 100) /100).toFixed(2) + "(0.00%)");
							$("#totalcosttotl").val((Math.round(rate * parseFloat(ary1[42]) * 100) /100).toFixed(2));
						}						
					}
				}
			});
	}	
</script>

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
	String requestid = Util.null2String(request.getParameter("requestid"));

	String wirebondtype = "", wirediameter = "", chipnumber = "1", grind = "", mat = "", frame = "", molding = "", other = "", form = "", grade = "", taping = "", tester = "", hander = "", quotationmethod = "", 
	 site = "" ,testtime = "", uphformula = "", uph = "";
	String custid="",shape ="",producttype ="", tradeway ="",silk ="",chipX ="",chipY ="";

	String uuid;
	String fastvalue = "";	
%>

<BODY style="overflow:scroll;align:center">
<style>	h1 {  font-family: Arial, sans-serif; font-size: 24px; color: #369; }</style>

<FORM NAME=SearchForm STYLE="margin-bottom:0;padding:50px;width:1000px;align:center" action="quotationMain.jsp" method=post>
	<table style="width:80%">
		<tr>
			<td style="width:100px;text-align:right">外形:</td>
			<td style="width:300px;text-align:left">
					<p><brow:browser name="field48581" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.shape'
													  isMustInput="1"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=shape%>'
													  browserSpanValue='<%=shape %>'
													/></p></td>	
			<td style="width:100px;text-align:right">生产类型:</td>
			<td style="width:300px;text-align:left">
					<p><brow:browser name="producttype" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.product_type'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=producttype%>'
													  browserSpanValue='<%=producttype %>'
													/></p></td>	
		</tr>
		<tr>
			<td style="width:100px;text-align:right">客户:</td>
			<td style="width:300px;text-align:left">
					<p><brow:browser name="custid" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.CUST_ID'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=custid%>'
													  browserSpanValue='<%=custid %>'
													/></p></td>	
			<td style="width:100px;text-align:right">贸易方式:</td>
			<td style="width:300px;text-align:left">
					<p><brow:browser name="tradeway" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Trade way'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=tradeway%>'
													  browserSpanValue='<%=tradeway %>'
													/></p></td>	
		</tr>	
			
		<table style="width:80%">
			<tr align="center">
				<td><input id="cost_element" type="button" style="align:center" value="成本元素"/></td>				
			</tr>				
		</table>	
	</table>
	<div id ='dv' style="width:100%;margin-left:10px;align:center;display: none" >
		
	<h1><tr><td>价格因子</td></tr></h1>		
	<fieldset style="width:80%" id="fieldsetbonding">
			<legend>键合</legend>
				<table>
					<tr>
					<td style="width:100px;text-align:right">键合丝种类:</td>
					<td style="width:300px;text-align:left">
					<p><brow:browser name="wirebondtype" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.bondingwire_type'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=wirebondtype%>'
													  browserSpanValue='<%=wirebondtype %>'
													/></p></td>					
					<td style="width:100px;text-align:right">线径(um):</td>
					<td style="width:300px;text-align:left">
					<p><brow:browser name="wirediameter" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.wire_diameter'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=wirediameter%>'
													  browserSpanValue='<%=wirediameter %>'
													/></p></td>
					</tr>
					<tr>
						<td style="width:100px;text-align:right">丝数:</td>
						<td style="width:300px;text-align:left"><input id="silk" name="silk" value="<%=silk%>" style="width:170px" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
					</tr>
				</table>
		</fieldset>	
		<fieldset style="width:80%" id="fieldsetchip">
			<legend>芯片</legend>
				<table>
					<tr>
						<td style="width:100px;text-align:right">磨片:</td>
						<td style="width:300px;text-align:left">
							<select id="grind"  value="<%=grind%>" style="width:148px">
							  <option value="0">是</option>     
							  <option value="1">否</option>  
							</select>
						</td>					
						<td style="width:100px;text-align:right">芯片个数:</td>
						<td style="width:300px;text-align:left">
							<input id="chipnumber" name="chipnumber" value="<%=chipnumber%>" style="width:170px" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
						</td>
					</tr>
					<tr>
						<td style="width:100px;text-align:right">芯片X(mm):</td>
						<td style="width:300px;text-align:left"><input id="chipX" name="chipX" value="<%=chipX%>" style="width:170px" onkeyup="this.value=this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'')"></td>
						<td style="width:100px;text-align:right">芯片Y(mm):</td>
						<td style="width:300px;text-align:left"><input id="chipY" name="chipY" value="<%=chipY%>" style="width:170px" onkeyup="this.value=this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d\.]/g,'')"></td>
					</tr>
					<tr>
						<td style="width:100px;text-align:right">装片材料:</td>
						<td style="width:300px;text-align:left">
						<p><brow:browser name="mat" viewType="0" hasBrowser="true" hasAdd="false"
														  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.mat'
														  isMustInput="2"
														  isSingle="false"
														  hasInput="true"
														  completeUrl=""  width="200px"
														  browserValue='<%=mat%>'
														  browserSpanValue='<%=mat%>'
														/></p></td>
					</tr>
				</table>
		</fieldset>
		<fieldset style="width:80%" id="fieldsetassemble">
			<legend>组装其他</legend>
				<table>
					<tr>
					<td style="width:100px;text-align:right">框架工艺:</td>
					<td style="width:300px;text-align:left">
					<p><brow:browser name="frametechnology" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.frame_technology'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=frame%>'
													  browserSpanValue='<%=frame%>'
													/></p></td>					
					<td style="width:100px;text-align:right">塑封料:</td>
					<td style="width:300px;text-align:left">
					<p><brow:browser name="moldingcompound" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.molding_compound'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=molding%>'
													  browserSpanValue='<%=molding%>'
													/></p></td>
					</tr>
					<tr>
						<td style="width:100px;text-align:right">其他:</td>
						<td style="width:300px;text-align:left">
						<p><brow:browser name="other" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.other'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=other%>'
													  browserSpanValue='<%=other%>'
													/></p>
						</td>
					</tr>
				</table>
		</fieldset>
		<fieldset style="width:80%">
			<legend>包装</legend>
				<table>
					<tr>
					<td style="width:100px;text-align:right">包装形式:</td>
					<td style="width:300px;text-align:left">
					<p><brow:browser name="packageform" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.form'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=form%>'
													  browserSpanValue='<%=form%>'
													/></p></td>					
					<td style="width:100px;text-align:right">包装档次:</td>
					<td style="width:300px;text-align:left">
					<p><brow:browser name="packagegrade" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.grade'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=grade%>'
													  browserSpanValue='<%=grade%>'
													/></p></td>
					</tr>
					<tr>
						<td style="width:100px;text-align:right">(单独)TAPING:</td>
						<td style="width:300px;text-align:left">
						<p><brow:browser name="taping" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.taping'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=taping%>'
													  browserSpanValue='<%=taping%>'
													/></p>
						</td>
					</tr>
				</table>
		</fieldset>
		<fieldset style="width:80%" id="fieldsettest">
			<legend>测试</legend>
				<table>
					<tr>
					<td style="width:100px;text-align:right">测试机型号:</td>
					<td style="width:300px;text-align:left">
					<p><brow:browser name="tester" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.tester'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=tester%>'
													  browserSpanValue='<%=tester%>'
													/></p></td>					
					<td style="width:100px;text-align:right">机械手:</td>
					<td style="width:300px;text-align:left">
					<p><brow:browser name="manipulator" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.MD_HANDLER'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=hander%>'
													  browserSpanValue='<%=hander%>'													  
													/></p></td>
					</tr>
					<tr>
						<td style="width:100px;text-align:right">测试报价方式:</td>
						<td style="width:300px;text-align:left">
							<select id="quotationmethod" style="width:148px">
							  <option value="1">小时</option>     
							  <option value="0">千只</option>  
							</select>
						</td>						
						<td style="width:100px;text-align:right"><p id="sitetitle">测试site数:</p></td>
						<td style="width:300px;text-align:left"><input id="site" name="site" value="<%=site%>" style="width:170px" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>												
					</tr>
					<tr>
						<td style="width:100px;text-align:right"><p id="testtimetitle">测试时间(ms):</p></td>
						<td style="width:300px;text-align:left"><input id="testtime" name="testtime" value="<%=testtime%>" style="width:170px" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
						<td style="width:100px;text-align:right"><p id="uphformulatitle">UPH公式:</p></td>
						<td style="width:300px;text-align:left" id = "uphformulatext">
						<p><brow:browser name="uphformula" viewType="0" hasBrowser="true" hasAdd="false"
													  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.UPH'
													  isMustInput="2"
													  isSingle="false"
													  hasInput="true"
													  completeUrl=""  width="200px"
													  browserValue='<%=uphformula%>'
													  browserSpanValue='<%=uphformula%>'
													/></p>
						</td>
					</tr>
					<tr>											
						<td style="width:100px;text-align:right"><p id="uphtitle">UPH:</p></td>
						<td style="width:300px;text-align:left"><input id="uph" name="uph" value="<%=uph%>" style="width:170px" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>												
					</tr>
				</table>
		</fieldset>

		<table style="width:80%">
			<tr align="center">
				<td><input id="fastbtn" type="button" style="align:center" value="快速报价"/></td>				
			</tr>			
		</table>
		</div>
		<div id ="cost_combined" style="width:100%;margin-left:10px;align:center;display: none" >

			<h1 >
				
					<tr>
						<td>成本合计</td>
					</tr>
			</h1>		
			<table style="width:100%;border:solid 1px">
				<thead style="align:left;border:solid 1px">
					<tr>
						<td style="width:9%">成本元素</td>
						<td style="width:9%">报价模式</td>
						<td style="width:9%">材料费用</td>
						<td style="width:9%">维修费用</td>
						<td style="width:9%">人工费用</td>
						<td style="width:9%">动力费用</td>
						<td style="width:9%">折旧费用</td>
						<td style="width:9%">其他费用</td>
						<td style="width:9%">总成本</td>
						<td style="width:9%">建议报价</td>
						<td style="width:10%">意向报价</td>
					</tr>
				</thead>
				<tbody style="align:left;border:solid 1px">
					<tr>
						<td style="width:9%"><input id="cost_element_assy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="quotation_mode_assy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="material_cost_assy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="maintenance_costs_assy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="artificial_cost_assy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="power_cost_assy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="depreciation_expense_assy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="other_fees_assy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="total_cost_assy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="suggested_price_assy" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="actual_price_assy" value="" readonly="readonly" style="background:transparent;border:0"></td>
					</tr>					
				</tbody>
				<tbody style="align:left;border:solid 1px">
					<tr>
						<td style="width:9%"><input id="cost_element_test" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="quotation_mode_test" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="material_cost_test" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="maintenance_costs_test" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="artificial_cost_test" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="power_cost_test" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="depreciation_expense_test" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="other_fees_test" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="total_cost_test" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="suggested_price_test" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="actual_price_test" value="" readonly="readonly" style="background:transparent;border:0"></td>
					</tr>					
				</tbody>
				<tbody style="align:left;border:solid 1px">
					<tr>
						<td style="width:9%"><input id="cost_element_pkg" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="quotation_mode_pkg" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="material_cost_pkg" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="maintenance_costs_pkg" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="artificial_cost_pkg" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="power_cost_pkg" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="depreciation_expense_pkg" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="other_fees_pkg" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="total_cost_pkg" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:9%"><input id="suggested_price_pkg" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="actual_price_pkg" value="" readonly="readonly" style="background:transparent;border:0"></td>
					</tr>					
				</tbody>
			</table>


			<h1 ><tr><td>PriceReminder</td></tr></h1>
			<table style="width:100%;border:solid 1px">
				<thead style="align:left;border:solid 1px">
					<tr>
						<td style="width:100%">内容</td>
						<td style="width:20%">建议打印标识状态</td>
						<td style="width:20%">实际打印状态</td>
						<td style="width:20%">建议报价</td>
						<td style="width:20%">实际报价</td>
					</tr>
				</thead>
				<tbody style="align:left;border:solid 1px">
					<tr>
						<td style="width:60%"><input id="cu_cost_1" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="cu_cost_2" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="cu_cost_3" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="cu_cost_4" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="cu_cost_5" value="" readonly="readonly" style="background:transparent;border:0"></td>
					</tr>					
				</tbody>
				<tbody style="align:left;border:solid 1px">
					<tr>
						<td style="width:60%"><input id="one_wrie_1" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="one_wrie_2" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="one_wrie_3" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="one_wrie_4" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="one_wrie_5" value="" readonly="readonly" style="background:transparent;border:0"></td>
					</tr>					
				</tbody>
				<tbody style="align:left;border:solid 1px">
					<tr>
						<td style="width:60%"><input id="ag_cost_1" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="ag_cost_2" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="ag_cost_3" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="ag_cost_4" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="ag_cost_5" value="" readonly="readonly" style="background:transparent;border:0"></td>
					</tr>					
				</tbody>
				<tbody style="align:left;border:solid 1px">
					<tr>
						<td style="width:60%"><input id="one_chip_1" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="one_chip_2" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="one_chip_3" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="one_chip_4" value="" readonly="readonly" style="background:transparent;border:0"></td>
						<td style="width:10%"><input id="one_chip_5" value="" readonly="readonly" style="background:transparent;border:0"></td>
					</tr>					
				</tbody>
			</table>

		</div>
</FORM>
</BODY></HTML>


<script language="javascript">	
	jQuery(document).ready(function(){			
		dochange();
		doupdate();
		submitData();			
	});

	function dochange(){		
		dohide();
		$("#quotationmethod").bind("change", function(){			
			if($("#quotationmethod option:selected").val() == "1"){
				dohide();			
			}else{
				doshow();
			}
		});		
	}
	
	function dohide(){
		$("#sitetitle").hide();
		$("#site").hide();
		$("#site").val("");
		$("#testtimetitle").hide();
		$("#testtime").hide();
		$("#testtime").val("");
		$("#uphformulatitle").hide();
		$("#uphformulatext").hide();
		$("#uphformulatext").val("");
		$("#uphtitle").hide();
		$("#uph").hide();
		$("#uph").val("");	
		$("#uphformula").val("");
		$("#uphformulaspan").children().empty();		
	}
	
	function doshow(){
		$("#sitetitle").show();
		$("#site").show();
		$("#testtimetitle").show();
		$("#testtime").show();
		$("#uphformulatitle").show();
		$("#uphformulatext").show();
		$("#uphformula").show();
		$("#uphtitle").show();
		$("#uph").show();
	}	
	jQuery("#cost_element").click(function(){
		var producttype = $("#producttype").val();
		if (producttype == "AO"){
			$("#fieldsettest").hide();			
		} else {
			$("#fieldsettest").show();
		}
		if (producttype == "TO"){
			$("#fieldsetbonding").hide();
			$("#fieldsetchip").hide();
			$("#fieldsetassemble").hide();			
		} else {
			$("#fieldsetbonding").show();
			$("#fieldsetchip").show();
			$("#fieldsetassemble").show();
		}		
        jQuery.ajax({
            url: "/interface/offer_pay_test/quotationBrowserToGetSize.jsp",
            data: {shape: $("#field48581").val(), producttype: $("#producttype").val(), custid: $("#custid").val(), tradeway: $("#tradeway").val()},
            cache: false,
            type: "post",
            dataType: "text",
            async: false,
            success: function (sb) {
                sb = jQuery.trim(sb);
                var ary1  = new Array();
                ary1 = sb.split(" ");
                if(sb != "" ){
                    //添加芯片X 和 芯片Y  丝数 等信息
                    $("#chipnumber").val("1");
                    $("#silk").val(ary1[0]);
                    $("#chipX").val(ary1[1]);
                    $("#chipY").val(ary1[2]);
                }
            }
        });
    });

	var oButton = document.getElementById("cost_element");
    var oDiv = document.getElementById("dv");
    oButton.onclick=function() {
        oDiv.style.display = "block";

    }


	var oButton1 = document.getElementById("fastbtn");
    var oDiv1 = document.getElementById("cost_combined");
    oButton1.onclick=function() {
        oDiv1.style.display = "block";

    }

    jQuery("#fastbtn").click(function(){
        jQuery.ajax({
            url: "/interface/offer_pay_test/quotationBrowserToGetPrice.jsp",
            data: {shape: $("#field48581").val(), producttype: $("#producttype").val(), custid: $("#custid").val(), tradeway: $("#tradeway").val(), 
					wirebondtype: $("#wirebondtype").val(), wirediameter: $("#wirediameter").val(), silk: $("#silk").val(), grind: $("#grind option:selected").val(), 
					chipnumber: $("#chipnumber").val(), chipX: $("#chipX").val(), chipY: $("#chipY").val(), mat: $("#mat").val(), frametechnology: $("#frametechnology").val(), 
					moldingcompound: $("#moldingcompound").val(), other: $("#other").val(), packageform: $("#packageform").val(), packagegrade: $("#packagegrade").val(), 
					taping: $("#taping").val(), tester: $("#tester").val(), manipulator: $("#manipulator").val(), quotationmethod: $("#quotationmethod option:selected").val(), 
					site: $("#site").val(), testtime: $("#testtime").val(), uphformula: $("#uphformula").val(), uph: $("#uph").val()},
            cache: false,
            type: "post",
            dataType: "text",
            async: false,
            success: function (sb) {
                sb = jQuery.trim(sb);
                var ary2  = new Array();
                ary2 = sb.split(" ");
                if(sb != "" ){
                    $("#cost_element_assy").val("封装");$("#quotation_mode_assy").val("千只");$("#material_cost_assy").val(ary2[0]);$("#maintenance_costs_assy").val(ary2[1]);$("#artificial_cost_assy").val(ary2[2]);$("#power_cost_assy").val(ary2[3]);
					$("#depreciation_expense_assy").val(ary2[4]);$("#other_fees_assy").val(ary2[5]);$("#total_cost_assy").val(ary2[6]);$("#suggested_price_assy").val(ary2[7]);$("#actual_price_assy").val(ary2[8]);
					
					$("#cost_element_test").val("测试");$("#quotation_mode_test").val(ary2[29]);$("#material_cost_test").val(ary2[9]);$("#maintenance_costs_test").val(ary2[10]);$("#artificial_cost_test").val(ary2[11]);$("#power_cost_test").val(ary2[12]);
					$("#depreciation_expense_test").val(ary2[13]);$("#other_fees_test").val(ary2[14]);$("#total_cost_test").val(ary2[15]);$("#suggested_price_test").val(ary2[16]);$("#actual_price_test").val(ary2[17]);
					
					$("#cost_element_pkg").val("包装");$("#quotation_mode_pkg").val("千只");$("#material_cost_pkg").val(ary2[18]);$("#maintenance_costs_pkg").val(ary2[19]);$("#artificial_cost_pkg").val(ary2[20]);$("#power_cost_pkg").val(ary2[21]);
					$("#depreciation_expense_pkg").val(ary2[22]);$("#other_fees_pkg").val(ary2[23]);$("#total_cost_pkg").val(ary2[24]);$("#suggested_price_pkg").val(ary2[25]);$("#actual_price_pkg").val(ary2[26]);
					
					$("#cu_cost_1").val("铜价波动100$");$("#cu_cost_2").val("true");$("#cu_cost_3").val("true");$("#cu_cost_4").val("0.00");$("#cu_cost_5").val("0.00");
					
					$("#one_wrie_1").val("加一根丝");$("#one_wrie_2").val("true");$("#one_wrie_3").val("true");$("#one_wrie_4").val(ary2[27]);$("#one_wrie_5").val(ary2[27]);
					
					$("#ag_cost_1").val("金价波动100$");$("#ag_cost_2").val("true");$("#ag_cost_3").val("true");$("#ag_cost_4").val("0.00");$("#ag_cost_5").val("0.00");
					
					$("#one_chip_1").val("加一个芯片");$("#one_chip_2").val("true");$("#one_chip_3").val("true");$("#one_chip_4").val(ary2[28]);$("#one_chip_5").val(ary2[28]);
                }
            }
        });
    });


	
</script>

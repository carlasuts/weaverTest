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
	String custid = Util.null2String(request.getParameter("custid"));
	String shape = Util.null2String(request.getParameter("field48581"));
	String producttype = Util.null2String(request.getParameter("producttype"));	
	String wirebondtype = "", wirediameter = "", chipnumber = "1", grind = "", mat = "", frame = "", molding = "", other = "", form = "", grade = "", taping = "", tester = "", hander = "", quotationmethod = "", 
	 site = "" ,testtime = "", uphformula = "", uph = "";
	String tradeway = Util.null2String(request.getParameter("tradeway"));
	String silk = Util.null2String(request.getParameter("silk_fast"));
	String chipX = Util.null2String(request.getParameter("Chip_X_fast"));
	String chipY = Util.null2String(request.getParameter("Chip_Y_fast"));
	String uuid;
	String fastvalue = "";	
%>

<BODY style="overflow:hidden;align:center">

<FORM NAME=SearchForm STYLE="margin-bottom:0;padding:50px;width:1000px;align:center" action="quotationMain.jsp" method=post>
	<table style="width:80%">
		<tr>
			<td style="width:100px;text-align:right">外形:</td>
			<td style="width:300px;text-align:left"><input id="field48581" name="shape" value="<%=shape%>" style="width:200px"></td>
			<td style="width:100px;text-align:right">生产类型:</td>
			<td style="width:300px;text-align:left"><input id="producttype" name="producttype" value="<%=producttype%>" style="width:200px"></td>
		</tr>
		<tr>
			<td style="width:100px;text-align:right">客户:</td>
			<td style="width:300px;text-align:left"><input id="custid" name="custid" value="<%=custid%>" style="width:200px"></td>
			<td style="width:100px;text-align:right">贸易方式:</td>
			<td style="width:300px;text-align:left"><input id="tradeway" name="tradeway" value="<%=tradeway%>" style="width:200px"></td>
		</tr>			
	</table>
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
</FORM>

</BODY></HTML>


<script language="javascript">	
	jQuery(document).ready(function(){		
		var custid = window.opener.document.getElementById("field48704").value;
		jQuery("#custid").val(custid);
		var shape = window.opener.document.getElementById("field48581").value;
		jQuery("#field48581").val(shape);
		var producttype = window.opener.document.getElementById("field48573").options[window.opener.document.getElementById("field48573").selectedIndex].text;
		jQuery("#producttype").val(producttype);
		var tradeway = window.opener.document.getElementById("field48566").options[window.opener.document.getElementById("field48566").selectedIndex].text;
		jQuery("#tradeway").val(tradeway);
		uuid = window.opener.document.getElementById("field48667").value;		
		var silk = window.opener.document.getElementById("field48674").value;
		jQuery("#silk").val(silk);
		var chipX = window.opener.document.getElementById("field48677").value;
		jQuery("#chipX").val(chipX);
		var chipY = window.opener.document.getElementById("field48678").value;
		jQuery("#chipY").val(chipY);
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
	
	function doupdate(){
		jQuery("#fastbtn").click(function(){	
			jQuery.ajax({				
					url: "/interface/fst/Quotation/quotationBrowserCalculate08.jsp",						
					data: {uuid: uuid, shape: $("#field48581").val(), producttype: $("#producttype").val(), custid: $("#custid").val(), tradeway: $("#tradeway").val(), 
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
						alert('快速报价成功')
						window.close();
					}
				});
		});
	}
	
</script>

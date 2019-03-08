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
String uuid;
%>

<BODY style="align:center">

<FORM NAME=SearchForm STYLE="margin-bottom:0;padding:0px;width:400px;align:center" action="quotationMain.jsp" method=post>
	<table style="width:90%;align:center">
		<tr>
			<td style="width:35%">名称</td>
			<td style="width:65%">值</td>			
		</tr>
		<tr>
			<td style="width:25%">键合丝类别</td>
			<td style="width:75%"><input type="text" id="wirebond" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">线径</td>
			<td style="width:75%"><input type="text" id="wirediam" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">丝数</td>
			<td style="width:75%"><input type="text" id="silk" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">磨片</td>
			<td style="width:75%"><input type="text" id="grind" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">芯片个数</td>
			<td style="width:75%"><input type="text" id="chipnumber" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">芯片X</td>
			<td style="width:75%"><input type="text" id="chipX" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">芯片Y</td>
			<td style="width:75%"><input type="text" id="chipY" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">装片材料</td>
			<td style="width:75%"><input type="text" id="mat" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">包装形式</td>
			<td style="width:75%"><input type="text" id="form" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">包装档次</td>
			<td style="width:75%"><input type="text" id="grade" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">(单独)TAPING</td>
			<td style="width:75%"><input type="text" id="taping" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">框架工艺</td>
			<td style="width:75%"><input type="text" id="frameworktech" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">塑封料</td>
			<td style="width:75%"><input type="text" id="encapsulamat" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">其他</td>
			<td style="width:75%"><input type="text" id="other" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">测试机型号</td>
			<td style="width:75%"><input type="text" id="testmodels" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">机械手</td>
			<td style="width:75%"><input type="text" id="hander" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">测试报价方式</td>
			<td style="width:75%"><input type="text" id="testquotationway" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">测试site数</td>
			<td style="width:75%"><input type="text" id="testsite" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">测试时间(ms)</td>
			<td style="width:75%"><input type="text" id="testtime" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">UPH公式</td>
			<td style="width:75%"><input type="text" id="uphformula" style="width:300px" readonly="true" value=""></td>	
		</tr>
		<tr>
			<td style="width:25%">UPH</td>
			<td style="width:75%"><input type="text" id="uph" style="width:300px" readonly="true" value=""></td>	
		</tr>
	</table>	
</FORM>

</BODY></HTML>


<script language="javascript">	
	jQuery(document).ready(function(){		
		uuid = window.opener.document.getElementById("field21821").value;
		doshow();
		submitData();			
	});

	function doshow(){
		jQuery.ajax({
				url: "/interface/ff/Quotation/priceBrowserCalculate01.jsp",						
				data: {uuid: uuid},
				cache: false,
				type: "post",
				dataType: "text",
				async: false,
				success: function (sb) {
					sb = jQuery.trim(sb);
					var ary1  = new Array();
					ary1 = sb.split(" ");
					if(sb != "" ){						
						$("#wirebond").val(ary1[0]);
						$("#wirediam").val(ary1[1]);
						$("#silk").val(ary1[2]);
						if (ary1[3] == "0"){
							$("#grind").val("是");
						} else if (ary1[3] == "1"){
							$("#grind").val("否");
						}						
						$("#chipnumber").val(ary1[4]);
						$("#chipX").val(ary1[5]);
						$("#chipY").val(ary1[6]);
						$("#mat").val(ary1[7]);
						$("#form").val(ary1[8]);
						$("#grade").val(ary1[9]);
						$("#taping").val(ary1[10]);
						$("#frameworktech").val(ary1[11]);
						$("#encapsulamat").val(ary1[12]);
						$("#other").val(ary1[13]);
						$("#testmodels").val(ary1[14]);
						$("#hander").val(ary1[15]);
						if (ary1[16] == "0"){
							$("#testquotationway").val("小时");
						} else if (ary1[16] == "1"){
							$("#testquotationway").val("千只");
						}						
						$("#testsite").val(ary1[17]);
						$("#testtime").val(ary1[18]);
						$("#uphformula").val(ary1[19]);
						$("#uph").val(ary1[20]);											
					}
				}
			});
	}	
</script>

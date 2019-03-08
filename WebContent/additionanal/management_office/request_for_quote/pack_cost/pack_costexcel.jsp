<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util,java.util.*,java.math.*" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<SCRIPT language="javascript" src="/js/checkinput_wev8.js"></script>

<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<SCRIPT language="javascript" src="/js/jquery/jquery_wev8_wev8.js"></script>

<!--For Jquery UI-->
<link href="/js/jquery/ui/jquery-ui_wev8.css" type="text/css" rel=stylesheet>
<script type="text/javascript" src="/js/jquery/ui/ui.core_wev8.js"></script>
<!--For Dialog-->
<script type="text/javascript" src="/js/jquery/ui/ui.dialog_wev8.js"></script>
    
<STYLE type=text/css>
#loading{
    position:absolute;
    left:45%;
    background:#ffffff;
    top:40%;
    padding:8px;
    z-index:20001;
    height:auto;
    border:1px solid #ccc;
    display:none;
}
</STYLE>

</head>
<%
	String imagefilename = "/images/hdHRMCard.gif";
	String titlename = SystemEnv.getHtmlLabelName(18596, user.getLanguage());
	String needfav = "1";
	String needhelp = "";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
<td height="10" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">
<FORM id=frmMain name=frmMain method=post target="subframe">
<DIV>
<BUTTON class=btnSave accessKey=S  onClick="dosubmit(this)"><U>S</U>-<%=SystemEnv.getHtmlLabelName(615, user.getLanguage())%></BUTTON>
&nbsp;&nbsp;&nbsp;&nbsp;

</DIV>
<br>
  <table class=Viewform >
    <COLGROUP> <COL width="15%"> <COL width="85%"> <tbody> 
    <tr class=Title> 
      <td><nobr><b>Execl导入</b></td>
      <td align=right></td>
    </tr>
    <tr class=spacing> 
      <td class=Line1 colspan=2></td>
    </tr>
    <tr class=spacing> 
      <td colspan=2 height=8></td>
    </tr>
    <TR><TD class=Line colSpan="2"></TD></TR>
    
    <tr class=spacing> 
      <td><%=SystemEnv.getHtmlLabelName(16699, user.getLanguage())%></td>
      <td class=Field>
        <input class=inputstyle style="width: 360px" type="file" name="excelfile" onchange='checkinput("excelfile","excelfilespan");this.value=trim(this.value)'>
        <SPAN id=excelfilespan><IMG src="/images/BacoError.gif" align=absMiddle></SPAN>
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR>
    <tr><td colspan="2" height="10px"></td></tr>
    
    <tr class=spacing><td colspan="2" height="8px"></td></tr>
    <TR><TD class=Line1 colSpan=2></TD></TR>
    </tbody> 
  </table>  
   <!-- 隐藏提交iframe -->
   <iframe name='subframe' id="subframe" style='display:none'></iframe>
  
</form>
  <br>
  <br>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>

<!-- 导入等待 -->
 <div id="loading">	
		<span  id="loading-msg"><img src="/images/loading2.gif">正在导入包装成本数据，请稍候</span>
 </div>

<!-- 结果展示弹出层 -->
<div id="divInfo" title="正在导入包装成本数据，请稍候">
     <DIV style="BORDER-BOTTOM: #bbbbbb 1px solid; width:100%;height:480px">
	        <DIV id="content" style="OVERFLOW-y: auto;OVERFLOW-x: hidden; WIDTH: 100%px; HEIGHT: 480px">
			      <div id="result">
			      
			      </div>
           </DIV>
	 </DIV>
      <div style="padding-top: 5px" align="center">
			<input id="closeBtn"  disabled="disabled" type="button" value="[<%=SystemEnv.getHtmlLabelName(309, user.getLanguage())%>]" style="cursor: hand;" onclick="closeDiv();">
		    <span id="downLogFile" style="padding-left: 20px"></span>
	  </div>  
</div>
<script language=javascript>
var index=0; //控制从resultList中读取数据的位置   
var timeId;  //定时器

/*jQuery dialog 初始化*/
$("#divInfo").dialog({   
	autoOpen: false,
      	modal: true, 
      	height: 500,
      	width:  650,
      	draggable: false,
      	resizable: false
    });
	     
	     
/*提交请求，通过隐藏iframe提交*/
function dosubmit(obj) {
    if(check_form(document.frmMain,'excelfile')) {
    	$("#loading").css("display", "block");
    	document.frmMain.action = "/interface/additional/management_office/request_for_quote/pack_cost/pack_costexcelprocess.jsp";
		document.frmMain.encoding = "multipart/form-data";
		document.frmMain.submit();
     }
}
</script>
</BODY>
</HTML>
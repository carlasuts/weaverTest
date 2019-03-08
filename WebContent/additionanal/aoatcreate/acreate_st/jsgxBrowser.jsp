<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>

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
BaseBean e1 = new BaseBean();
int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
String requestid = Util.null2String(request.getParameter("requestid"));
String isfirst = Util.null2String(request.getParameter("isfirst"));
String oper_fk = Util.null2String(request.getParameter("oper_fk"));
String sqlwhere = " 1=1 and  b.roleid = c.id and c.rolesmark = a.oper_role_fk and b.resourceid = "+ user.getUID() +" and a.oper_fk in (select operadd from formtable_main_151 a,formtable_main_151_dt2 b where b.mainid = a.id and b.operadd != '0010' and a.requestid =  '"+ requestid +"') ";
	int ishead = 0;
if(!sqlwhere.equals("")) ishead = 1;
if(!oper_fk.equals("")){
			sqlwhere += "  and oper_fk like '%" + oper_fk + "%'";
	}
int pagenum=Util.getIntValue(request.getParameter("pagenum"),1);
if(pagenum <= 0){
	pagenum = 1;
}
%>
<BODY style="overflow:hidden;">

<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>

<%
RCMenuHeight += RCMenuHeightStep ; //取消右键按钮 看不到按钮，只能查看3个！

RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:submitData(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:submitClear(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:dialog.close(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;

%>

<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right;">
			<input type="button" value="<%=SystemEnv.getHtmlLabelNames("197",user.getLanguage())%>" class="e8_btn_top"  onclick="submitData()"/>
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>

<FORM NAME=SearchForm STYLE="margin-bottom:0" action="jsgxBrowser.jsp" method=post>
	<input type="hidden" id="requestid" name="requestid" value="<%=requestid%>">
	<input type="hidden" id="isfirst" name="isfirst" value="<%=isfirst%>">
  	<input type="hidden" id="pagenum" name="pagenum" value="<%=pagenum%>">
<div style="max-height:155px;overflow:hidden;" id="e8QuerySearchArea">
<wea:layout type="2col">
	<wea:group context='<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage())%>'  attributes="{'groupSHBtnDisplay':'none'}" >
		<wea:item>工序</wea:item>
		<wea:item><input name="oper_fk" value='<%=oper_fk%>' class="InputStyle"></wea:item>
		
	</wea:group>
</wea:layout>
</div>
<wea:layout type="fourCol">
<wea:group context="数据列表">
<wea:item attributes="{'isTableList':'true','colspan':'full'}">
<%
String tableString = "";
int perpage=10;
String backfields = " distinct oper_fk ";
String fromSql  = "MDM_OPER_MTRL_REF a ,hrmrolemembers b,hrmroles c ";
	tableString =   " <table instanceid=\"db_list3\" tabletype=\"none\" pagesize=\""+perpage+"\"  >"+ //指定分页条数和初始化id以及是否有复选框
			"       <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlwhere)+"\" "+
			" sqlprimarykey=\"oper_fk\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
                "       <head>"+
                "           <col width=\"0%\" hide=\"true\"  text=\""+"oper_fk"+"\" column=\"oper_fk\"    />"+
	        	"           <col width=\"100%\"  text=\"工序\" column=\"oper_fk\" orderkey=\"oper_fk\"   />"+
                "       </head>"+
                " </table>";
%>

<wea:SplitPageTag  tableString='<%=tableString %>'  mode="run" />
	<!-- 显示分页数据 -->
	</wea:item>
	</wea:group>
	</wea:layout>
</FORM>


<div id="zDialog_div_bottom" class="zDialog_div_bottom">
    <wea:layout needImportDefaultJsAndCss="false">
		<wea:group context=""  attributes="{\"groupDisplay\":\"none\"}">
			<wea:item type="toolbar">
		    	<input type="button" accessKey=2  id=btnclear value="<%="2-"+SystemEnv.getHtmlLabelName(311,user.getLanguage())%>" id="zd_btn_submit" class="zd_btn_submit" onclick="btnclear_onclick();">
		    	<input type="button" accessKey=T  id=btncancel value="<%="T-"+SystemEnv.getHtmlLabelName(201,user.getLanguage())%>" id="zd_btn_cancle"  class="zd_btn_cancle" onclick="dialog.close();">
			</wea:item>
		</wea:group>
	</wea:layout>
	<script type="text/javascript">
		jQuery(document).ready(function(){
			resizeDialog(document);
		});
	</script>
</div>

</BODY></HTML>


<script language="javascript">
function btnclear_onclick(){
	if(dialog){
		var returnjson={id:"",name:""};
		try{
            dialog.callback(returnjson);
       }catch(e){}
	  	try{
	       dialog.close(returnjson);
	   }catch(e){}
	}else{
		window.parent.returnValue = {id:"",name:""};
		window.parent.close();
	}
}
function submitData()
{
	if (check_form(SearchForm,'')){
		document.getElementById("pagenum").value = "1";
		SearchForm.submit();
	}
}

function submitClear()
{
	btnclear_onclick();
}

function nextPage(){
	document.getElementById("pagenum").value=parseInt(document.getElementById("pagenum").value)+1 ;
	SearchForm.submit();	
}

function perPage(){
	document.getElementById("pagenum").value=parseInt(document.getElementById("pagenum").value)-1 ;
	SearchForm.submit();
}



jQuery(document).ready(function(){
	$("#_xTable").find("table.ListStyle").live('click',BrowseTable_onclick);
	if(jQuery("#isfirst").val()==''){
		jQuery("#requestid").val(parentWin.document.getElementById("requestid").value);
		jQuery("#isfirst").val('1');
		submitData();
	}
})
function BrowseTable_onclick(e){
   var e=e||event;
   var target=e.srcElement||e.target;

   if( target.nodeName =="TD"||target.nodeName =="A"  ){
	   
	   if(dialog){
			var returnjson={id:jQuery(jQuery(target).parents("tr")[0].cells[1]).text(),name:jQuery(jQuery(target).parents("tr")[0].cells[2]).text()};
			try{
	            dialog.callback(returnjson);
	       }catch(e){}
		  	try{
		       dialog.close(returnjson);
		   }catch(e){}
		}else{
     		window.parent.parent.returnValue = {id:jQuery(jQuery(target).parents("tr")[0].cells[1]).text(),name:jQuery(jQuery(target).parents("tr")[0].cells[2]).text()};
	 		window.parent.parent.close();
		}
	}
}
</script>

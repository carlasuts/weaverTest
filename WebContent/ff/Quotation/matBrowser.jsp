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
String shape = Util.null2String(request.getParameter("shape"));
String material = Util.null2String(request.getParameter("material"));
String sqlwhere = " 1=1 and full_name = '装片' ";
	int ishead = 0;
if(!sqlwhere.equals("")) ishead = 1;

if(!shape.equals("")){
			sqlwhere += "  and QTTN_PKG_FK like '%" + shape + "%'";
	}

if(!material.equals("")){
			sqlwhere += "  and material like '%" + material + "%'";
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

<FORM NAME=SearchForm STYLE="margin-bottom:0" action="matBrowser.jsp" method=post>
	<input type="hidden" id="shape" name="shape" value="<%=shape%>">
<div style="max-height:155px;overflow:hidden;" id="e8QuerySearchArea">
<wea:layout type="2col">
	<wea:group context='<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage())%>'  attributes="{'groupSHBtnDisplay':'none'}" >
		<wea:item>装片材料</wea:item>
		<wea:item><input name="material" value='<%=material%>' class="InputStyle"></wea:item>
	</wea:group>
</wea:layout>
</div>
<wea:layout type="fourCol">
<wea:group context="数据列表">
<wea:item attributes="{'isTableList':'true','colspan':'full'}">
<%
String tableString = "";
int perpage=10;
String backfields = " distinct material, QTTN_PKG_FK, full_name ";
String fromSql  = " (select b.name as material, a.QTTN_PKG_FK, c.full_name from MD_SD_COST_DIE a left join MD_SD_MOUNTING_MTRL_SPEC b on A.MTRL_SPEC=B.ID left join MD_SD_COST_DIE_CAT c on A.COST_DIE_CAT_FK =C.ID) ";
	tableString =   " <table instanceid=\"db_list3\" tabletype=\"none\" pagesize=\""+perpage+"\"  >"+ //指定分页条数和初始化id以及是否有复选框
			"       <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlwhere)+"\" "+
			" sqlprimarykey=\"material\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
                "       <head>"+
                "           <col width=\"0%\" hide=\"true\"  text=\""+"material"+"\" column=\"material\"    />"+
	        	"           <col width=\"100%\"  text=\"装片材料\" column=\"material\" orderkey=\"material\"   />"+
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
		SearchForm.submit();
	}
}

function submitClear()
{
	btnclear_onclick();
}

jQuery(document).ready(function(){
	$("#_xTable").find("table.ListStyle").live('click',BrowseTable_onclick);
	var shape = parentWin.document.getElementById("field19801").value;
	if(jQuery("#shape").val()==''){
		jQuery("#shape").val(shape);	
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

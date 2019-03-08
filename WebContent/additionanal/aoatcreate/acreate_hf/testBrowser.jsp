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
	BaseBean e1 = new BaseBean();
	String requestid = Util.null2String(request.getParameter("requestid"));
	int resourceid = user.getUID();
	String pkld = Util.null2String(request.getParameter("pkld"));
	String cust_id = Util.null2String(request.getParameter("cust_id"));
	String isfirst = Util.null2String(request.getParameter("isfirst"));
	String operadd = Util.null2String(request.getParameter("oper_fk"));
	String mat_id = Util.null2String(request.getParameter("mat_id"));
	String mat_desc = Util.null2String(request.getParameter("mat_desc"));
	String mat_type = Util.null2String(request.getParameter("mat_type"));
	String sqlwhere = " 1=1 ";
		int ishead = 0;
	if(!sqlwhere.equals("")) ishead = 1;
	if(!operadd.equals("")){
				sqlwhere += "  and operadd like '%" + operadd + "%'";
		}
	if(!mat_id.equals("")){
		sqlwhere += "  and mat_id like '%" + mat_id + "%'";
	}
	if(!mat_desc.equals("")){
		sqlwhere += "  and mat_desc like '%" + mat_desc + "%'";
	}
	if(!mat_type.equals("")){
		sqlwhere += "  and mat_type like '%" + mat_type + "%'";
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

<FORM NAME=SearchForm STYLE="margin-bottom:0" action="testBrowser.jsp" method=post>
	<input type="hidden" id="requestid" name="requestid" value="<%=requestid%>">	
	<input type="hidden" id="cust_id" name="cust_id" value="<%=cust_id%>">	
	<input type="hidden" id="pkld" name="pkld" value="<%=pkld%>">	
	<input type="hidden" id="isfirst" name="isfirst" value="<%=isfirst%>">
  <input type="hidden" id="pagenum" name="pagenum" value="<%=pagenum%>">
<div style="max-height:155px;overflow:hidden;" id="e8QuerySearchArea">
<wea:layout type="2col">
	<wea:group context='<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage())%>'  attributes="{'groupSHBtnDisplay':'none'}" >
		<wea:item>工序</wea:item>
		<wea:item>
			<brow:browser name="oper_fk" viewType="0" hasBrowser="true" hasAdd="false"
						  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.jsgx_hf'
						  isMustInput="1"
						  isSingle="false"
						  hasInput="true"
						  completeUrl=""  width="200px"
						  browserValue=''
						  browserSpanValue=''
			/>
		</wea:item>
		<wea:item>料号</wea:item>
		<wea:item><input name="mat_id" value='<%=mat_id%>' class="InputStyle"></wea:item>
		<wea:item>物料描述</wea:item>
		<wea:item><input name="mat_desc" value='<%=mat_desc%>' class="InputStyle"></wea:item>
		<wea:item>物料类型</wea:item>
		<wea:item><input name="mat_type" value='<%=mat_type%>' class="InputStyle"></wea:item>
	</wea:group>
</wea:layout>
</div>
<wea:layout type="fourCol">
<wea:group context="数据列表">
<wea:item attributes="{'isTableList':'true','colspan':'full'}">
<%
//int requestid1 = Util.getIntValue(request.getParameter("requestid"));//请求id
//String requestid1 = Util.null2String(request.getParameter("requestid"));
//String pkld1 = Util.null2String(request.getParameter("pkld"));
//String cust_id1 = Util.null2String(request.getParameter("cust_id"));
String orderby =" itemno ";
String tableString = "";
int perpage=10;
String backfields = " id, ITEMNO,operadd ,mat_id,mat_desc, mat_type,storage_location  ";
String fromSql  = " (select to_char(c.id) as id,  g.ITEMNO,g.operadd,c.mat_id ,c.mat_desc, c.mat_type   ,c.storage_location \n" +
		"FROM obomsetmat_hf c ,   \n" +
		"(select f.ITEMNO,f.operadd ,mp.oper_grp_4 from formtable_main_149 e,formtable_main_149_dt2 f ,mwipoprdef_hf mp  \n" +
		"  where e.requestid =  " + requestid + "\n" +
		"  and  f.mainid = e.id  \n" +
		"  and mp.oper = f.operadd ) g    \n" +
		"where g.oper_grp_4 = c.oper_grp \n" +
		"and   c.pkld = '" + pkld + "' \n" +
		"and   c.cust_id = " + cust_id + " \n" +
		"and g.operadd in (select distinct wl.oper_fk from hrmrolemembers gh,hrmroles js,MDM_OPER_MTRL_REF wl \n" +
		"  where gh.resourceid =  " + resourceid + " \n" +
		"  and gh.roleid = js.id \n" +
		"  and js.rolesmark = wl.oper_role_fk ) \n" +
		"union  \n" +
		"select seq, g.ITEMNO,g.operadd,e.mat_id,e.MAT_DESC,e.MAT_TYPE ,e.SITE_CODE \n" +
		"from OINVMATDEF e ,MDM_OPER_MTRL_REF f, \n" +
		"(select f.ITEMNO,f.operadd from formtable_main_149 e,formtable_main_149_dt2 f  \n" +
		"  where e.requestid =  " + requestid + " \n" +
		"  and  f.mainid = e.id  ) g  \n" +
		" where e.MAT_GRP = f.mtrl_group_fk \n" +
		" AND G.OPERADD = F.OPER_FK \n" +
		" and e.factory = '5010' \n" +
		" and g.operadd in (select distinct wl.oper_fk from hrmrolemembers gh,hrmroles js,MDM_OPER_MTRL_REF wl \n" +
		"  where gh.resourceid = " + resourceid + " \n" +
		"  and gh.roleid = js.id \n" +
		"  and js.rolesmark = wl.oper_role_fk )) ";
	tableString =   " <table instanceid=\"db_list3\" tabletype=\"none\" pagesize=\"6\" >"+ //指定分页条数和初始化id以及是否有复选框
			//" <checkboxpopedom  id=\"checkbox\" popedompara=\"column:id\"  />"+ //用于控制checkbox 框是否可用
			"       <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlwhere)+"\" "+
			" sqlorderby=\""+orderby+"\"   sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
                "       <head>"+
                "           <col width=\"0%\" hide=\"true\"  text=\""+"ID"+"\" column=\"id\"    />"+
                "           <col width=\"15%\"  text=\"项目号\" column=\"ITEMNO\" orderkey=\"ITEMNO\"   />"+
                "           <col width=\"60%\"  text=\"料号描述\" column=\"mat_desc\" orderkey=\"mat_desc\"   />"+
                "           <col width=\"35%\"  text=\"料号\" column=\"mat_id\" orderkey=\"mat_id\"   />"+
                "           <col width=\"15%\"  text=\"工序\" column=\"operadd\" orderkey=\"operadd\"   />"+
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
		jQuery("#cust_id").val(parentWin.document.getElementById("field31023").value);
		jQuery("#pkld").val(parentWin.document.getElementById("field20017").value);
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

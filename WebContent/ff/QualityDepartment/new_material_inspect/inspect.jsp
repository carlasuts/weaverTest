<%--
  Created by IntelliJ IDEA.
  User: zong.yq
  Date: 2019/2/26-0026
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />

<html>
<HEAD><LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>

</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<!-- <script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script> -->
<%

    String imagefilename = "/images/hdMaintenance.gif";
    String titlename = "inspect";
    String needfav = "1";
    String needhelp = "";
%>

<%
    String sqlwhere = "WHERE 1 = 1";
    String CONDITION = Util.null2String(request.getParameter("CONDITION"));

    if (!CONDITION.equals("")) {
        sqlwhere += " AND CONDITION = '" + CONDITION + "' ";
    }

    int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
    int	perpage=20;
%>

<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>

<%
    RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self}";
    RCMenuHeight += RCMenuHeightStep;
    RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",inspectUpdate.jsp,_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
    RCMenu += "{导入excel,javascript:doImportExcel(),_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
    RCMenu += "{导出当前页,javascript:_xtable_getExcel(),_self}";
    RCMenuHeight += RCMenuHeightStep;
    RCMenu += "{导出所有,javascript:_xtable_getAllExcel(),_self}";
    RCMenuHeight += RCMenuHeightStep;
%>

<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
    <colgroup>
        <col width="10">
        <col width="">
        <col width="10">

        <tr>
            <td valign="top">
                <TABLE class=Shadow>
                    <tr>
                        <td valign="top">
                            <FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="inspect.jsp" method=post>
                                <table width=300% class=ViewForm>
    <colgroup>
        <col width="16%">
        <col width="16%">
        <TR>
            <td NOWRAP width='5%'>期别</td>
            <td class=FIELD width='5%'>
                <select id='CONDITION' name='CONDITION'>
                    <option value=""></option>
                    <option value="一期">一期</option>
                    <option value="二期">二期</option>‘
                    <option value="三期">三期</option>
                </select>
            </td>
            <td NOWRAP width='25%'>
                <input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
                <input type="button" value="导出当前页" onclick="javascript:_xtable_getExcel()">&nbsp;&nbsp;
                <input type="button" value="导出所有" onclick="javascript:_xtable_getAllExcel()">
            </td>
        </TR>
        <TR class=Spacing>
            <TD class=Line1 colspan=8></TD>
        </TR>
</table>

<TABLE width="100%">
    <tr>
        <td>
            <%
                String backfields = " ID, CONDITION, PD ";
                String fromsql = " ( SELECT INS.ID, CONDITION, HRM.LASTNAME PD FROM OBASINSPECTDOP INS LEFT JOIN (SELECT ID, LASTNAME FROM HRMRESOURCE) HRM ON INS.PD = HRM.ID ) ";
                String sqlWhere = sqlwhere;
                String orderby = " ID ";
                String tableString = "";
                tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
                        + "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromsql + "\" sqlwhere=\""
                        + Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
                        + "\"  sqlprimarykey=\"ID\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>" + "		<head>"
                        + "			<col width=\"15%\" text=\"PD所属\" column=\"CONDITION\" orderkey=\"CONDITION\"  />"
                        + "			<col width=\"15%\" text=\"PD\" column=\"PD\" orderkey=\"PD\"  />"
                        + "		</head>" + "		<operates width=\"10%\">";
                tableString +=		 "    		<operate href=\"javascript:doEdit()\"  text=\"修改\" target=\"_self\" index=\"0\"/>";
                tableString +=		 "    		<operate href=\"javascript:doDel()\"  text=\"删除\" target=\"_self\" index=\"0\"/>";
                tableString += "		</operates>" + " </table>";
            %> <wea:SplitPageTag tableString="<%=tableString%>"
                                 isShowTopInfo="false" mode="run" />
        </td>
    </tr>
</TABLE>
</FORM>
</td>
</tr>
</TABLE>
</td>
</tr>
</table>

<script language=javascript>
    //查询
    function doSearch() {
        document.frmmain.submit();
    }
    //修改
    function doEdit(id){
        document.frmmain.action = "inspectUpdate.jsp?type=modi&id="+id;
        document.frmmain.submit();
    }
    // 删除
    function doDel(id){
        var isdel = confirm("真的要删除吗?");
        if(isdel){
            document.frmmain.action="inspectOperation.jsp?type=del&id="+id;
            document.frmmain.submit();
        }
    }
</script>
</BODY>
<SCRIPT language="javascript" defer="defer"
        src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>
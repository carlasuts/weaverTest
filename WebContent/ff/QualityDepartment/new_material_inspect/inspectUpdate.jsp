<%--
  Created by IntelliJ IDEA.
  User: zong.yq
  Date: 2019/2/26-0026
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ page import="weaver.general.Util,java.util.List,java.util.ArrayList"%>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<HTML>
<HEAD>
    <LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
    String imagefilename = "/images/hdMaintenance.gif";
    String titlename = "新材料PD人员更新页面";
    String needfav = "1";
    String needhelp = "";
%>
<%
    String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
    String condition = "", pd = "";
    String sql = "";
    String names = "";
    RecordSet rs = new RecordSet();
	    if(!id.equals("")){
        rs.executeSql("SELECT * FROM OBASINSPECTDOP WHERE ID = " + id);
        if(rs.next()){
            condition = rs.getString("CONDITION");
            pd = rs.getString("PD");
        }
    }

    // 姓名浏览
    sql ="SELECT OID.ID, (SELECT LISTAGG(HRM.LASTNAME, ',') WITHIN GROUP(ORDER BY HRM.ID) FROM HRMRESOURCE HRM WHERE INSTR(',' || OID.PD || ',', ',' || HRM.ID || ',') > 0) NAMES FROM OBASINSPECTDOP OID WHERE ID = '" + id +"'";
    rs.executeSql(sql);
    if (rs.next()) {
        names = rs.getString("NAMES");
    }

    String type = "";
    String readName="2";
    if (id.equals("")) {
        type = "add";
    } else {
        type = "modi";
    }
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
<%
    //保存
    RCMenu += "{" + SystemEnv.getHtmlLabelName(86, user.getLanguage()) + ",javascript:doSave(this),_self} ";
    RCMenuHeight += RCMenuHeightStep;
    //返回
    RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='insepct.jsp',_self} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
<table width=100% height=100% border="0" cellspacing="0"
       cellpadding="0">
    <colgroup>
        <col width="10">
        <col width="">
        <col width="10">
    </colgroup>
    <tr>
        <td height="10" colspan="3"></td>
    </tr>
    <tr>
        <td></td>
        <td valign="top">
            <FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="inspectOperation.jsp" method=post>
                <input type=hidden name=type value='<%=type %>'>
                <input type=hidden name='id' value='<%=id%>'>
                <table style="width: 20%" class=ListStyle>
                    <TBODY>
                        <TR>
                            <td align="right">期别：</td>
                            <td align="left">
                                <select id='condition' name='condition' >
                                    <option value="一期">一期</option>
                                    <option value="二期">二期</option>
                                    <option value="三期">三期</option>
                                </select>
                            </td>
                        </TR>
                        <TR>
                            <td align="right">PD人员：</td>
                            <td align="left">
                                <p><brow:browser name="pd" viewType="0" hasBrowser="true" hasAdd="false" browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp' isMustInput="<%=readName%>" isSingle="true" hasInput="true" completeUrl="/hrm/resource/HrmResource.jsp?id=17" isAutoComplete = "true" width="200px" browserValue='<%=pd%>' browserSpanValue='<%=names%>'/></p>
                            </td>
                        </TR>
                    </TBODY>
                </TABLE>
            </FORM>
        </td>
    </tr>
    <tr>
        <td height="10" colspan="3"></td>
    </tr>
</table>
<script language=javascript>
    function doSave(obj) {
        document.frmmain.submit();
    }
</script>
</body>
<SCRIPT language="javascript" defer="defer"
        src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>

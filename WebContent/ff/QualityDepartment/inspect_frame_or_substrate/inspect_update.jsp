<%--
  Created by IntelliJ IDEA.
  User: zong.yq
  Date: 2019/1/14
  Time: 9:01
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
    String titlename = "新框架/基板PD人员修改页面";
    String needfav = "1";
    String needhelp = "";
%>
<%
    String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
    String type = "", condition = "", pd = "", manager = "";

    RecordSet rs = new RecordSet();
    if(!id.equals("")){
        rs.executeSql("SELECT * FROM OBASINSPECT WHERE ID = " + id);
        if(rs.next()){
            type = rs.getString("TYPE");
            condition = rs.getString("CONDITION");
            pd = rs.getString("PD");
            manager = rs.getString("MANAGER");
        }
    }

    String sql = "";
    String names = "";
    //姓名浏览
    sql ="SELECT TP.ID, (SELECT LISTAGG(HRM.LASTNAME, ',') WITHIN GROUP(ORDER BY HRM.ID) FROM HRMRESOURCE HRM WHERE INSTR(',' || TP.AUDITOR || ',', ',' || HRM.ID || ',') > 0) NAMES FROM OBASTPDOP TP WHERE ID = '" + id +"'";
    rs.executeSql(sql);
    if (rs.next()) {
        names = rs.getString("NAMES");
    }

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
    RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='Technical Protocol.jsp',_self} ";
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
            <FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="Technical Protocol Operation.jsp" method=post>
                <input type=hidden name=type value='<%=type %>'>
                <input type=hidden name='id' value='<%=id%>'>
                <table style="width: 80%" class=ListStyle>
                    <TBODY>
                    <TR>
                        <td align="right">申请厂区：</td>
                        <td align="left">
                            <select id='factory' name='factory' >
                                <option value="0">崇川厂</option>
                                <option value="1">苏通厂</option>
                                <option value="2">合肥厂</option>
                                <option value="3">圆片厂</option>
                            </select>
                        </td>
                    </TR>
                    <TR>
                        <td align="right">申请部门：</td>
                        <td align="left">
                            <input type='text' id='department' name='department' value='<%=department %>' />
                        </td>
                    </TR>
                    <TR>
                        <td align="right">工序：</td>
                        <td align="left">
                            <input type='text' id='process' name='process' value='<%=process %>' />
                        </td>
                    </TR>
                    <TR>
                        <td align="right">申请人姓名：</td>
                        <td align="left">
                            <input type='text' id='name' name='name' value='<%=name %>' />
                        </td>
                    </TR>
                    <TR>
                        <td align="right">申请人工号：</td>
                        <td align="left">
                            <input type='text' id='workcode' name='workcode' value='<%=workcode %>' />
                        </td>
                    </TR>
                    <TR>
                        <td align="right">审核(工程部长/设备部长)：</td>
                        <td align="left">
                            <p><brow:browser name="auditor" viewType="0" hasBrowser="true" hasAdd="false" browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp' isMustInput="<%=readName%>" isSingle="true" hasInput="true" completeUrl="/hrm/resource/HrmResource.jsp?id=17" isAutoComplete = "true" width="200px" browserValue='<%=auditor%>' browserSpanValue='<%=names%>'/></p>
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
    var factory ="<%=factory%>"
    $("#factory").attr("value",factory);
    function doSave(obj) {
        document.frmmain.submit();
    }
</script>
</body>
<SCRIPT language="javascript" defer="defer"
        src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>
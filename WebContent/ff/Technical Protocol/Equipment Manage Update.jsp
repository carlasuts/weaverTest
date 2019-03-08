<%--
  Created by IntelliJ IDEA.
  User: zong.yq
  Date: 2019/1/22-0022
  Time: 10:56
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
    String titlename = "设备信息修改页面";
    String needfav = "1";
    String needhelp = "";
%>
<%
    String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
    BaseBean baseBean = new BaseBean();
    baseBean.writeLog("id: " + id);
    String name = "", manufacturer = "", type = "";

    RecordSet rs = new RecordSet();
    if(!id.equals("")){
        rs.executeSql("SELECT * FROM OBASEMDOP WHERE ID = " + id);
        if(rs.next()){
            name = rs.getString("NAME");
            manufacturer = rs.getString("MANUFACTURER");
            type = rs.getString("TYPE");
        }
    }

    String type1 = "";
    if (id.equals("")) {
        type1 = "add";
    } else {
        type1 = "modi";
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
    RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='Equipment Manage.jsp',_self} ";
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
            <FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="Equipment Manage Operation.jsp" method=post>
                <input type=hidden name='type1' value='<%=type1 %>'>
                <input type=hidden name='id' value='<%=id%>'>
                <table style="width: 80%" class=ListStyle>
                    <TBODY>
                    <TR>
                        <td align="right">设备名称：</td>
                        <td align="left">
                            <input type='text' id='name' name='name' value='<%=name %>' />
                        </td>
                    </TR>
                    <TR>
                        <td align="right">设备厂家：</td>
                        <td align="left">
                            <input type='text' id='manufacturer' name='manufacturer' value='<%=manufacturer %>' />
                        </td>
                    </TR>
                    <TR>
                        <td align="right">设备类型：</td>
                        <td align="left">
                            <input type='text' id='type' name='type' value='<%=type %>' />
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

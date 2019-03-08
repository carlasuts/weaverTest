<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ page import="weaver.general.Util,java.util.List,java.util.ArrayList"%>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>
<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "测试程序一览表";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String p_id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String custid_id = p_id.split("-")[0];
	String dqidh_id = p_id.split("-")[1];
	String dqidbbh_id = p_id.split("-")[2];
	String dqidbbh = "",custid = "",dqidh="",dqpmlist="",BFBZ="",gdtime="";
	String scwj = "",IMAGEFILEID="";

	RecordSet rs = new RecordSet();
	if(!p_id.equals("")){
		rs.executeSql("select custid,dqidh,dqidbbh,dqpmlist,scwj,BFBZ,gdtime from formtable_main_93 where custid ='"+custid_id+"' and dqidh = '"+ dqidh_id +"' and dqidbbh = '"+ dqidbbh_id +"' ");
		if(rs.next()){
			custid = rs.getString("custid");
			dqidh = rs.getString("dqidh");
			dqidbbh = rs.getString("dqidbbh");
			dqpmlist = rs.getString("dqpmlist").trim().replace("<br>","");
			scwj = rs.getString("scwj");
			BFBZ = rs.getString("BFBZ");
			gdtime = rs.getString("gdtime");
		}
	}
	rs.executeSql("select IMAGEFILEID from DOCIMAGEFILE where docid = '"+ scwj +"' ");
	rs.next();
	IMAGEFILEID = rs.getString("IMAGEFILEID");
%>
<BODY>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
	<%
		//保存
		RCMenu += "{" + SystemEnv.getHtmlLabelName(86, user.getLanguage()) + ",javascript:doSave(this),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		//返回
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='owiptstpgm.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" method=post >
				<input type=hidden name='id' value='<%=p_id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">客户名：</td>
								<td align="left">
									<input type='text' id='custid' name='custid' value='<%=custid %>' readonly="readonly"/>
								</td>
							</TR>
							<TR>
								<td align="right">ID号：</td>
								<td align="left">
									<input type='text' id='dqidh' name='dqidh' value='<%=dqidh %>' readonly="readonly"/>
								</td>
							</TR>
							<TR>
								<td align="right">版本号：</td>
								<td align="left">
									<input type='text' id='dqidbbh' name='dqidbbh' value='<%=dqidbbh %>' readonly="readonly"/>
								</td>
							</TR>
						 	<TR>
								<td align="right">品名list：</td>
								 <td align="left">
								 <textarea name='mat_list' rows="5" cols="50" id='mat_list' readonly="readonly"><%=dqpmlist %></textarea>
								</td> 
							</TR> 
							<TR>
								<td align="right">归档时间：</td>
								<td align="left">
									<input type='text' id='gdtime' name='gdtime' value='<%=gdtime %>' readonly="readonly"/>
								</td>
							</TR> 
							<TR>
								<td align="right">作废标识：</td>
								<td align="left">
									<a readonly="readonly"><%=BFBZ %></a>
									<%-- <input type='text' id='BFBZ' name='BFBZ' value='<%=BFBZ %>' readonly="readonly"/> --%>
								</td>
							</TR>
							<TR>
								<td align="right">附件预览/下载：</td>
								<td align="left">
								<a href="http://172.16.60.18:8008/docs/docs/DocDspExt.jsp?id=<%=scwj %>&imagefileId=<%=IMAGEFILEID %>"  target="_blank">预览/下载点击这里</a> 
								</td>
							</TR>
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
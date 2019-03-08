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
	String titlename = "技术图纸查询";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String p_id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String custid = "",TZLXNAME="",tzbh="",tzbb="";
	String pkg = "",pkld="",CADGSTZ="",YSZLSC="",IMAGEFILEID_cad="",IMAGEFILEID_ys="";
	String REQUESTID = "";
	
	RecordSet rs = new RecordSet();
	if(!p_id.equals("")){
		rs.executeSql("select custid,TZLXNAME,tzbh,tzbb,pkg,pkld,CADGSTZ,YSZLSC,REQUESTID from otecdrmedef_hf  where tzbh = '"+ p_id +"' and (tzbb, tzbh) in (select max(To_Number(tzbb)),tzbh from  otecdrmedef_hf group by tzbh)  ");
		if(rs.next()){
			custid = rs.getString("custid");
			TZLXNAME = rs.getString("TZLXNAME");
			tzbh = rs.getString("tzbh");
			tzbb = rs.getString("tzbb");
			pkg = rs.getString("pkg");
			pkld = rs.getString("pkld");
			CADGSTZ = rs.getString("CADGSTZ");
			YSZLSC = rs.getString("YSZLSC");
			REQUESTID = rs.getString("REQUESTID");
		}
	}
	rs.executeSql("select IMAGEFILEID from DOCIMAGEFILE where docid = '"+ CADGSTZ +"' ");
	rs.next();
	IMAGEFILEID_cad = rs.getString("IMAGEFILEID");
	rs.executeSql("select IMAGEFILEID from DOCIMAGEFILE where docid = '"+ YSZLSC +"' ");
	rs.next();
	IMAGEFILEID_ys = rs.getString("IMAGEFILEID");
%>
<BODY>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
	<%
		//保存
		RCMenu += "{" + SystemEnv.getHtmlLabelName(86, user.getLanguage()) + ",javascript:doSave(this),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		//返回
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='otecdrmedef.jsp',_self} ";
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
								<td align="right">图纸类型：</td>
								<td align="left">
									<input type='text' id='TZLXNAME' name='TZLXNAME' value='<%=TZLXNAME %>' readonly="readonly"/>
								</td>
							</TR>
							<TR>
								<td align="right">图纸编号：</td>
								<td align="left">
									<input type='text' id='tzbh' name='tzbh' value='<%=tzbh %>' readonly="readonly"/>
								</td>
							</TR>
							<TR>
								<td align="right">图纸版本：</td>
								<td align="left">
									<input type='text' id='tzbb' name='tzbb' value='<%=tzbb %>' readonly="readonly"/>
								</td>
							</TR>
							<TR>
								<td align="right">封装外形：</td>
								<td align="left">
									<input type='text' id='pkld' name='pkld' value='<%=pkld %>' readonly="readonly"/>
								</td>
							</TR>
							<TR>
								<td align="right">封装大类：</td>
								<td align="left">
									<input type='text' id='pkg' name='pkg' value='<%=pkg %>' readonly="readonly"/>
								</td>
							</TR>
							<!-- <TR>
								<td align="right">CAD附件预览/下载：</td>
								<td align="left">
								 <a href="http://172.16.60.18:8008/weaver/weaver.file.FileDownload?fileid=<%=IMAGEFILEID_cad %>&coworkid=0&requestid=<%=REQUESTID %>&desrequestid=0&votingId=0&workplanid=0"  target="_blank">预览/下载点击这里</a> 
								 </td>
							</TR> -->
							<TR>
								<td align="right">原始资料附件预览/下载：</td>
								<td align="left">
								<%-- <a href="http://172.16.60.63:8080/weaver/weaver.file.FileDownload?fileid=<%=IMAGEFILEID_ys %>&coworkid=0&requestid=<%=REQUESTID %>&desrequestid=0&votingId=0&workplanid=0"  target="_blank">预览/下载点击这里</a> --%>
								<a href="http://172.16.60.18:8008/weaver/weaver.file.FileDownload?fileid=<%=IMAGEFILEID_ys %>"  target="_blank">预览/下载点击这里</a> 
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
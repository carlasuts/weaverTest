<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util,weaver.file.*,java.util.*,java.io.*" %>
<%@ page import="weaver.join.hrm.in.IHrmImportAdapt"%>
<%@ page import="weaver.file.*"%>
<%@ page import="weaver.general.Util,java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.join.hrm.in.IHrmImportProcess"%>
<%@ page import="weaver.join.hrm.in.processImpl.HrmImportProcess"%>
<%@ page import="weaver.general.StaticObj"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="java.util.regex.Pattern"%>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ExcelParse" class="weaver.file.ExcelParse" scope="page" />
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%
	BaseBean baseBean = new BaseBean();
	String sql = "";
	FileUploadToPath fu = new FileUploadToPath(request);// 上传EXCEL文件
	baseBean.writeLog("request: " + request);
	String filename = fu.uploadFiles("excelfile");//获取EXCEL路径
	baseBean.writeLog("filename: " + filename);
	ExcelParse excelFile = new ExcelParse();
	excelFile.init(filename);//进行EXCEL文件初始化
	int recordercount = 0;
	String error = "";
	boolean hasvalid = true;
	String regex = ",|，|\\s+";
	String auditor = "";
	String appliantid = "";
	baseBean.writeLog("import excelFile Starting!");
	while(true) {
		recordercount ++ ;
		//以下一行一行按列读取EXCEL中的数据getValue方法中的第一个参数不要变化，固定为1，第二个参数是行号，第三个参数是列号
		if(recordercount == 1) {
			continue;//第一行为标题，一般不处理
		}
		String c1 = Util.null2String(excelFile.getValue("1", ""+recordercount, "1")).trim();
		if(c1.equals("")) {
			break;//表示已经是最后一行，处理结束
		}
		if (c1.equals("崇川厂")) {
			c1 = "0";
		}
		if (c1.equals("苏通厂")) {
			c1 = "1";
		}
		if (c1.equals("合肥厂")) {
			c1 = "2";
		}
		if (c1.equals("圆片厂")) {
			c1 = "3";
		}
		String c2 = Util.null2String(excelFile.getValue("1", ""+recordercount, "2" )).trim();
		baseBean.writeLog("c2: " + c2);
		String c3 = Util.null2String(excelFile.getValue("1", ""+recordercount, "3" )).trim();
		baseBean.writeLog("c3: " + c3);
		String c4 = Util.null2String(excelFile.getValue("1", ""+recordercount, "4" )).trim();
		baseBean.writeLog("c4: " + c4);
		String c5 = Util.null2String(excelFile.getValue("1", ""+recordercount, "5" )).trim();
		baseBean.writeLog("c5: " + c5);
		String c6 = Util.null2String(excelFile.getValue("1", ""+recordercount, "7" )).trim();
		baseBean.writeLog("c6: " + c6);
		String workcodes[] = c6.split(regex);
		for (String workcode : workcodes) {
			sql = "SELECT ID FROM HRMRESOURCE WHERE WORKCODE = '" + workcode + "'";
			rs.executeSql(sql);
			rs.next();
			auditor = auditor + rs.getString("ID") + ",";
		}
		auditor = auditor.substring(0, auditor.length() - 1);
		baseBean.writeLog("auditor : " + auditor);

		sql = "SELECT ID FROM HRMRESOURCE WHERE WORKCODE = '" + c5 + "'";
		baseBean.writeLog("Searching for appliant's ID");
		rs.executeSql(sql);
		rs.next();
		appliantid = rs.getString("ID");
		baseBean.writeLog("Appliant's ID: " + appliantid);

		sql = "INSERT INTO OBASTPDOP (FACTORY, DEPARTMENT, PROCESS, NAME, WORKCODE, AUDITOR, APPLIANTID) VALUES ('" + c1 + "', '" + c2 + "', '" + c3 + "', '" + c4 + "', '" + c5 + "', '" + auditor + "', '" + appliantid + "')";;
		baseBean.writeLog("sql: " + sql);
		rs.executeSql(sql);
	}

	if(hasvalid){
		out.println("<SCRIPT language=javascript>alert('数据导入成功!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.window.returnValue='1';window.open('','_top').close();</SCRIPT>");
	}
	else{
		out.println("<SCRIPT language=javascript>alert('" + error + "!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.document.getElementById('loading').style.display='none';</SCRIPT>");
	}
%>
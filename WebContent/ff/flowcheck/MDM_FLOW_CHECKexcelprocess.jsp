<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page
	import="weaver.general.Util,weaver.file.*,java.util.*,java.io.*"%>
<%@ page import="weaver.join.hrm.in.IHrmImportAdapt"%>
<%@ page import="weaver.file.*"%>
<%@ page import="weaver.general.Util,java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.join.hrm.in.IHrmImportProcess"%>
<%@ page import="weaver.join.hrm.in.processImpl.HrmImportProcess"%>
<%@ page import="weaver.general.StaticObj"%>
<%@ page import="weaver.conn.RecordSet"%>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ExcelParse" class="weaver.file.ExcelParse" scope="page" />
<%@ include file="/page/maint/common/initNoCache.jsp"%>
<%
	BaseBean bb = new BaseBean();
	String sql = "";
	FileUploadToPath fu = new FileUploadToPath(request); // 上传EXCEL文件
	String filename = fu.uploadFiles("excelfile"); //获取EXCEL路径
	ExcelParse excelFile = new ExcelParse();
	excelFile.init(filename); //进行EXCEL文件初始化

	int recordercount = 0;
	String error = "";
	String SELECTVALUE = "";
	boolean hasvalid = true;
	StringBuilder sb = new StringBuilder();
	while (true) {
		recordercount++;
		//以下一行一行按列读取EXCEL中的数据getValue方法中的第一个参数不要变化，固定为1，第二个参数是行号，第三个参数是列号
		if (recordercount == 1)
			continue; //第一行为标题，一般不处理

		String c2 = Util.null2String(excelFile.getValue("1", "" + recordercount, "2")).trim();

		if (c2.equals(""))
			break; //表示已经是最后一行，处理结束
		String c3 = "", c4 = "";
		c3 = Util.null2String(excelFile.getValue("1", "" + recordercount, "3")).trim();
		
		if (c2.equals("")) {
			c2 = " ";
		}
		if (c3.equals("")) {
			c3 = " ";
		}
	   	if("tray盘-CHIPTRAY".equals(c2)){
	   		SELECTVALUE = "1";
	   	}
	   	if("弹匣-AMMO".equals(c2)){
	   		SELECTVALUE = "2";
	   	}
	   	if("散装-BULK".equals(c2)){
	   		SELECTVALUE = "3";
	   	}
	   	if("料条-TUBE".equals(c2)){
	   		SELECTVALUE = "4";
	   	}
	   	if("料盘-TRAY".equals(c2)){
	   		SELECTVALUE = "5";
	   	}
	   	if("载带-CARRIER".equals(c2)){
	   		SELECTVALUE = "6";
	   	}
	   	if("".equals(SELECTVALUE))
	   		break;
	   	sql = "select * as no from mdm_flow_check where packagetype = '"+ c2 +"' and oper = '"+ c3 +"'  ";
	   	rs1.executeSql(sql);
	   	if(!rs1.next()){
			sql = "insert into mdm_flow_check (selectvalue ,packagetype ,oper) values ("
					+ "'"+ SELECTVALUE+ "',"
					+ "'"+ c2+ "',"
					+ "'"+ c3+ "'"
					+ ")";
			rs.executeSql(sql);
			bb.writeLog("mdm_flow_check detailsql:" + sql);
	   	}
	}

	if (hasvalid) {
		out.println("<SCRIPT language=javascript>alert('数据导入成功!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.window.returnValue='1';window.open('','_top').close();</SCRIPT>");
	} else {
		out.println("<SCRIPT language=javascript>alert('" + error + "!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.document.getElementById('loading').style.display='none';</SCRIPT>");
	}
%>
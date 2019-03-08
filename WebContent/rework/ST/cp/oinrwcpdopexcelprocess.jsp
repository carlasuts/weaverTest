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
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
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
	boolean hasvalid = true;
	StringBuilder sb = new StringBuilder();
	while (true) {
		recordercount++;
		//以下一行一行按列读取EXCEL中的数据getValue方法中的第一个参数不要变化，固定为1，第二个参数是行号，第三个参数是列号
		if (recordercount == 1)
			continue; //第一行为标题，一般不处理

		String c1 = Util.null2String(excelFile.getValue("1", "" + recordercount, "1")).trim();// 客户号

		if (c1.equals(""))
			break; //表示已经是最后一行，处理结束
		String c2 = "";// 知会人
		c2 = Util.null2String(excelFile.getValue("1", "" + recordercount, "2")).trim();
		String c3 = "";// 工号
		c3 = Util.null2String(excelFile.getValue("1", "" + recordercount, "3")).trim();
		if (c1.equals("")) {
			c1 = " ";
		}
		if (c2.equals("")) {
			c2 = " ";
		}
		if (c3.equals("")) {
			c3 = " ";
		}

		//重复数据更新
		sql = "SELECT * FROM OINRWCPDOP_ST WHERE CUST_ID = '" + c1 + "' AND WORK_CODE = '" + c3 + "' ";
		rs1.executeSql(sql);
		if (!rs1.next()) {
			sql = "INSERT INTO OINRWCPDOP_ST (CUST_ID, NAME, WORK_CODE) VALUES ('" + c1 + "','" + c2 + "','" + c3
					+ "')";
			rs.executeSql(sql);
		} else {
			sql = "UPDATE OINRWCPDOP_ST SET (NAME, WORK_CODE) = ('" + c2 + "','" + c3 + "') where cust_id = '" + c1
					+ "'";
			rs2.executeSql(sql);
		}
	}

	if (hasvalid) {
		out.println("<SCRIPT language=javascript>alert('数据导入成功!')</SCRIPT>");
		out.println(
				"<SCRIPT language=javascript>parent.window.returnValue='1';window.open('','_top').close();</SCRIPT>");
	} else {
		out.println("<SCRIPT language=javascript>alert('" + error + "!')</SCRIPT>");
		out.println(
				"<SCRIPT language=javascript>parent.document.getElementById('loading').style.display='none';</SCRIPT>");
	}
%>
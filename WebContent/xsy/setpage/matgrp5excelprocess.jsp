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

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ExcelParse" class="weaver.file.ExcelParse" scope="page" />
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%
	BaseBean bb = new BaseBean();
	String sql = "";
    FileUploadToPath fu = new FileUploadToPath(request) ;    // 上传EXCEL文件
	String filename = fu.uploadFiles("excelfile") ;    //获取EXCEL路径
	ExcelParse excelFile = new ExcelParse();
	excelFile.init(filename) ;    //进行EXCEL文件初始化
	
	int recordercount = 0 ;
	String error = "";
	boolean hasvalid = true;
	
	while( true ) {
		recordercount ++ ;
		//以下一行一行按列读取EXCEL中的数据getValue方法中的第一个参数不要变化，固定为1，第二个参数是行号，第三个参数是列号
		if( recordercount == 1 ) {
			rs.executeSql("DELETE FROM EXTRATABLE_74_TEMP"); //先删除TEMP表
			continue ;  //第一行为标题，一般不处理
		}
		
		String c1 = Util.null2String( excelFile.getValue("1", ""+recordercount , "1" ) ).trim() ;
        if( c1.equals("") ) break ;   //表示已经是最后一行，处理结束
        
        String c2 = Util.null2String( excelFile.getValue("1", ""+recordercount , "2" ) ).trim() ;
        String c3 = Util.null2String( excelFile.getValue("1", ""+recordercount , "3" ) ).trim() ;
        String c4 = Util.null2String( excelFile.getValue("1", ""+recordercount , "4" ) ).trim() ;
        
		StringBuilder sb = new StringBuilder();
		sb.append("INSERT INTO EXTRATABLE_74_TEMP TEMP (TEMP.MAT_GRP_5, TEMP.MARKING, TEMP.CUST_DATA_1, TEMP.CUST_DATA_2, INSERTTIME) values (");
		sb.append("'").append(c1).append("', ");
		sb.append("'").append(c2).append("', ");
		sb.append("'").append(c3).append("', ");
		sb.append("'").append(c4).append("', ");
		sb.append("SYSDATE");
		sb.append(")");
		
		rs.executeSql(sb.toString());
    }
	//bb.writeLog("导入TEMP" + sqlList.size() + "条数据");
	
	String sqlMerge = "MERGE INTO EXTRATABLE_74 TRUNK USING EXTRATABLE_74_TEMP TEMP ON (TRUNK.MAT_GRP_5 = TEMP.MAT_GRP_5) WHEN MATCHED THEN UPDATE SET TRUNK.MARKING = TEMP.MARKING, TRUNK.CUST_DATA_1 = TEMP.CUST_DATA_1, TRUNK.CUST_DATA_2 = TEMP.CUST_DATA_2, TRUNK.UPDATETIME = SYSDATE WHEN NOT MATCHED THEN INSERT (MARKING, CUST_DATA_1, CUST_DATA_2, UPDATETIME) VALUES (TEMP.MARKING, TEMP.CUST_DATA_1, TEMP.CUST_DATA_2, SYSDATE)";
	rs.executeSql(sqlMerge);
	bb.writeLog("MERGE END");
	
	
	if(hasvalid){ 
		out.println("<SCRIPT language=javascript>alert('数据导入成功!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>window.close();parent.window.returnValue='1';</SCRIPT>");
	}
	else{
		out.println("<SCRIPT language=javascript>alert('" + error + "!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.document.getElementById('loading').style.display='none';</SCRIPT>");
	}
%>
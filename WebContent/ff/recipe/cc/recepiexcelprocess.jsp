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
	alert("cccccccc");
	BaseBean bb = new BaseBean();
	String sql = "";
	bb.writeLog("recepi  ccccccccccccc");
    FileUploadToPath fu = new FileUploadToPath(request) ;    // 上传EXCEL文件
	String filename = fu.uploadFiles("excelfile") ;    //获取EXCEL路径
	ExcelParse excelFile = new ExcelParse();
	excelFile.init(filename) ;    //进行EXCEL文件初始化
	
	int recordercount = 0 ;
	String error = "";
	bb.writeLog("cskfdetailsql:----========");
	boolean hasvalid = true;
	StringBuilder sb = new StringBuilder();
	while( true ) {
		recordercount ++ ;
		//以下一行一行按列读取EXCEL中的数据getValue方法中的第一个参数不要变化，固定为1，第二个参数是行号，第三个参数是列号
		if( recordercount == 1 ) continue ;  //第一行为标题，一般不处理
		
		String c2 = Util.null2String( excelFile.getValue("1", ""+recordercount , "2" ) ).trim() ;
        if( c2.equals("") ) break ;   //表示已经是最后一行，处理结束
        String c2="",c3 = "", c4 = "", c5 = "", c6 = "", c7 = "";
         String c8="",c9 = "", c10 = "", c11 = "", c12 = "", c13 = "";
          String c14="",c15 = "", c16 = "", c17 = "";
 		
        c3 = Util.null2String( excelFile.getValue("1", ""+recordercount , "3" ) ).trim() ;
        c4 = Util.null2String( excelFile.getValue("1", ""+recordercount , "4" ) ).trim() ;
        c5 = Util.null2String( excelFile.getValue("1", ""+recordercount , "5" ) ).trim() ;
        c6 = Util.null2String( excelFile.getValue("1", ""+recordercount , "6" ) ).trim() ;
        c7 = Util.null2String( excelFile.getValue("1", ""+recordercount , "7" ) ).trim() ;
        c8 = Util.null2String( excelFile.getValue("1", ""+recordercount , "8" ) ).trim() ;
        c9 = Util.null2String( excelFile.getValue("1", ""+recordercount , "9" ) ).trim() ;
        c10 = Util.null2String( excelFile.getValue("1", ""+recordercount , "10" ) ).trim() ;
        c11 = Util.null2String( excelFile.getValue("1", ""+recordercount , "11" ) ).trim() ;
        c12 = Util.null2String( excelFile.getValue("1", ""+recordercount , "12" ) ).trim() ;
        c13 = Util.null2String( excelFile.getValue("1", ""+recordercount , "13" ) ).trim() ;
        c14 = Util.null2String( excelFile.getValue("1", ""+recordercount , "14" ) ).trim() ;
        c15 = Util.null2String( excelFile.getValue("1", ""+recordercount , "15" ) ).trim() ;
        c16 = Util.null2String( excelFile.getValue("1", ""+recordercount , "16" ) ).trim() ;
        c17 = Util.null2String( excelFile.getValue("1", ""+recordercount , "17" ) ).trim() ;
        c18 = Util.null2String( excelFile.getValue("1", ""+recordercount , "17" ) ).trim() ;

        
		sql = "insert into rule_cc (RULE_SEQ,EQ_TYPE,PKG_TYPE,RULE_NAME,RULE_VER,HOLD_FLAG,HOLD_USER,HOLD_TIME,UPDATE_USER,UPDATE_TIME,DESCRIPTION,FROM_SEQ,FROM_VER) values ("+
				"'" + c2 + "'," +
				"'" + c3 + "'," +
				"'" + c4 + "'," +
				"'" + c5 + "'," +
				"'" + c6 + "'," +
				"'" + c7 + "'," +
				"'" + c8 + "'," +
				"'" + c9 + "'," +
				"'" + c10 + "'," +
				"'" + c11 + "'," +
				"'" + c12 + "'," +
				"'" + c13 + "'," +
				"'" + c14 + "'" +
				")";
		rs.executeSql(sql); 
    }
	
	if(hasvalid){ 
		out.println("<SCRIPT language=javascript>alert('数据导入成功!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.window.returnValue='1';window.close();</SCRIPT>");
	}
	else{
		out.println("<SCRIPT language=javascript>alert('" + error + "!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.document.getElementById('loading').style.display='none';</SCRIPT>");
	}
%>
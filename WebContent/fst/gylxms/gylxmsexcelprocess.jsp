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
	String bzgylx = "";
    FileUploadToPath fu = new FileUploadToPath(request) ;    // 上传EXCEL文件
	String filename = fu.uploadFiles("excelfile") ;    //获取EXCEL路径
	ExcelParse excelFile = new ExcelParse();
	excelFile.init(filename) ;    //进行EXCEL文件初始化
	
	int recordercount = 0 ;
	String error = "";
	boolean hasvalid = true;
	StringBuilder sb = new StringBuilder();
	while( true ) {
		recordercount ++ ;
		//以下一行一行按列读取EXCEL中的数据getValue方法中的第一个参数不要变化，固定为1，第二个参数是行号，第三个参数是列号
		if( recordercount == 1 ) continue ;  //第一行为标题，一般不处理
		//第二行第三列 取得工艺路线名称
		bzgylx = Util.null2String( excelFile.getValue("1", "2", "3" ) ).trim() ;

		String c4 = Util.null2String( excelFile.getValue("1", ""+recordercount , "4" ) ).trim() ;
		
        if(c4.equals("") ) break ;   //表示已经是最后一行，处理结束
        String  c5 = "", c6 = "", c7 = "";
        c5 = Util.null2String( excelFile.getValue("1", ""+recordercount , "5" ) ).trim() ;
        c6 = Util.null2String( excelFile.getValue("1", ""+recordercount , "6" ) ).trim() ;
        c7 = Util.null2String( excelFile.getValue("1", ""+recordercount , "7" ) ).trim() ;
        if(c4.equals("")){
        	c4 = " ";
        }
        if(c5.equals("")){
        	c5 = " ";
        }
        if(c6.equals("")){
        	c6 = " ";
        }
        if(c7.equals("")){
        	c7 = " ";
        }
        sql = "select id from md_mdm_std_router where name = '"+bzgylx+"'";
        rs.executeSql(sql);
        rs.next();
        String id = rs.getString("id");
        //sql = "select * from tb_llyc where khm = '" + c2 + "' and xh = '" + c3 + "' and tester = '" + c4 + "' and pkid = '" + c5 + "'";
        //rs.executeSql(sql);
        //if(!rs.next()){
        	sql = "insert into MD_MDM_STD_ROUTER_item (ID ,master_fk,item_no,oper_fk ,factory ,oper_desc) values (SYS_GUID()||'',"+
    				"'" + id + "'," +
    				"'" + c4 + "'," +
    				"'" + c5 + "'," +
    				"'" + c6 + "'," +
    				"'" + c7 + "'" +
    				")";
    	    rs.executeSql(sql); 
            bb.writeLog("MD_MDM_STD_ROUTER_item detailsql:" + sql);
        //}
        //else{
        //	sql = "update tb_llyc set workcode ='" + c6 + "' where khm = '" + c2 + "' and xh = '" + c3 + "' and tester = '" + c4 + "' and pkid = '" + c5 + "'";
    	//    rs.executeSql(sql); 
        //    bb.writeLog("llycdetailsql:" + sql);
        //}
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
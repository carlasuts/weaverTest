<%@ page language="java" contentType="text/html; charset=GBK" %>
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
    FileUploadToPath fu = new FileUploadToPath(request) ;    // �ϴ�EXCEL�ļ�
	String filename = fu.uploadFiles("excelfile") ;    //��ȡEXCEL·��
	ExcelParse excelFile = new ExcelParse();
	excelFile.init(filename) ;    //����EXCEL�ļ���ʼ��
	
	int recordercount = 0 ;
	String error = "";
	boolean hasvalid = true;
	StringBuilder sb = new StringBuilder();
	while( true ) {
		recordercount ++ ;
		//����һ��һ�а��ж�ȡEXCEL�е�����getValue�����еĵ�һ��������Ҫ�仯���̶�Ϊ1���ڶ����������кţ��������������к�
		if( recordercount == 1 ) continue ;  //��һ��Ϊ���⣬һ�㲻����
		
		String c2 = Util.null2String( excelFile.getValue("1", ""+recordercount , "2" ) ).trim() ;
        if( c2.equals("") ) break ;   //��ʾ�Ѿ������һ�У��������
        String c3 = "", c4 = "", c5 = "", c6 = "";
        c3 = Util.null2String( excelFile.getValue("1", ""+recordercount , "3" ) ).trim() ;
        c4 = Util.null2String( excelFile.getValue("1", ""+recordercount , "4" ) ).trim() ;
        c5 = Util.null2String( excelFile.getValue("1", ""+recordercount , "5" ) ).trim() ;
        c6 = Util.null2String( excelFile.getValue("1", ""+recordercount , "6" ) ).trim() ;
        
        //sql = "select * from tb_llyc where khm = '" + c2 + "' and xh = '" + c3 + "' and tester = '" + c4 + "' and pkid = '" + c5 + "'";
        //rs.executeSql(sql);
        //if(!rs.next()){
        	sql = "insert into tb_gxnyc (khm,xh,pkid,workcode,zrr) values ("+
    				"'" + c2 + "'," +
    				"'" + c3 + "'," +
    				"'" + c4 + "'," +
    				"'" + c5 + "'," +
    				"'" + c6 + "'" +
    				")";
    	    rs.executeSql(sql); 
            bb.writeLog("gxnycdetailsql:" + sql);
        //}
        //else{
        //	sql = "update tb_llyc set workcode ='" + c6 + "' where khm = '" + c2 + "' and xh = '" + c3 + "' and tester = '" + c4 + "' and pkid = '" + c5 + "'";
    	//    rs.executeSql(sql); 
        //    bb.writeLog("llycdetailsql:" + sql);
        //}
    }
	
	if(hasvalid){ 
		out.println("<SCRIPT language=javascript>alert('���ݵ���ɹ�!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.window.returnValue='1';window.close();</SCRIPT>");
	}
	else{
		out.println("<SCRIPT language=javascript>alert('" + error + "!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.document.getElementById('loading').style.display='none';</SCRIPT>");
	}
%>
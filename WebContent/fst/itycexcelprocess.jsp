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
		
		String c1 = Util.null2String( excelFile.getValue("1", ""+recordercount , "1" ) ).trim() ;//ϵͳ��
        if( c1.equals("") ) break ;   //��ʾ�Ѿ������һ�У��������
        String c2 = "", c3 = "";
        c2 = Util.null2String( excelFile.getValue("1", ""+recordercount , "2" ) ).trim() ;//��������
        c3 = Util.null2String( excelFile.getValue("1", ""+recordercount , "3" ) ).trim() ;//����
        
        sql = "select id from tb_ityc where name = '" + c1 + "'";
        rs.executeSql(sql);
        if(rs.next()){
        	c1 = rs.getString("id");
        	sql = "select * from tb_ityc1 where systemid = '" + rs.getString("id") + "' and name = '" + c2 + "'";
            rs.executeSql(sql);
            if(!rs.next()){
            	sql = "insert into tb_ityc1 (systemid,name,workcode) values ("+
        				c1 + "," +
        				"'" + c2 + "'," +
        				"'" + c3 + "'" +
        				")";
        	    rs.executeSql(sql); 
                bb.writeLog("itycdetailsql:" + sql);
            }
            else{
            	sql = "uddate tb_ityc1 set workcode = '" + c3 + "' and systemid = " + c1 + " and name = '" + c2 + "'";
            	rs.executeSql(sql); 
                bb.writeLog("itycdetailsql:" + sql);
            }
        }
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
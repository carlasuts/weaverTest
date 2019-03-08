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
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ExcelParse" class="weaver.file.ExcelParse" scope="page" />
<%@ include file="/page/maint/common/initNoCache.jsp" %>



<%

	BaseBean bb = new BaseBean();
	String sql = "";
	String DEPART="";
	FileUploadToPath fu = new FileUploadToPath(request) ;    // 上传EXCEL文件
	String filename = fu.uploadFiles("excelfile") ;    //获取EXCEL路径
	ExcelParse excelFile = new ExcelParse();
	excelFile.init(filename) ;    //进行EXCEL文件初始化
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
    String create_time ="";
    String update_time ="";
	int recordercount = 0 ;
	String error = "";
	boolean hasvalid = true;
	StringBuilder sb = new StringBuilder();
	
     while( true ) {
		 recordercount ++ ;
		//以下一行一行按列读取EXCEL中的数据getValue方法中的第一个参数不要变化，固定为1，第二个参数是行号，第三个参数是列号
		if( recordercount == 1 ) continue ;  //第一行为标题，一般不处理
		
		String c2 = Util.null2String( excelFile.getValue("1", ""+recordercount , "2" ) ).trim() ;
	    if( c2.equals("")) break ;   //表示已经是最后一行，处理结束
	    String c3 = "", c4 = " ", c5 = "0", c6 = "0", c7 = "0",c8 = "0", c9 = "0", c10 = "0", c11 = "0";
	    c3 = Util.null2String( excelFile.getValue("1", ""+recordercount , "3" ) ).trim() ;
	    c4 = Util.null2String( excelFile.getValue("1", ""+recordercount , "4" ) ).trim() ;
// 	    c5 = Util.null2String( excelFile.getValue("1", ""+recordercount , "5" ) ).trim() ;
// 	    c6 = Util.null2String( excelFile.getValue("1", ""+recordercount , "6" ) ).trim() ;
// 	    c7 = Util.null2String( excelFile.getValue("1", ""+recordercount , "7" ) ).trim() ;
// 	    c8 = Util.null2String( excelFile.getValue("1", ""+recordercount , "8" ) ).trim() ;
// 	    c9 = Util.null2String( excelFile.getValue("1", ""+recordercount , "9" ) ).trim() ;
// 	    c10 = Util.null2String( excelFile.getValue("1", ""+recordercount , "10" ) ).trim() ;
// 	    c11 = Util.null2String( excelFile.getValue("1", ""+recordercount , "11" ) ).trim() ;
	    if(c2.equals("")){
	    	c2 = " ";
	    }
	    if(c3.equals("")){
	    	c3 = " ";
	    }
	    if(c4.equals("")){
	    	c4 = " ";
	    }
	    
	    sql="select Hrd.id  from Hrmresource hrs , Hrmdepartment hrd where   Hrs.Departmentid = hrd.id and Hrs.Workcode='"+c3+"'";
	 
	    rs1.executeSql(sql);
	    if(rs1.next()){
	    	 DEPART=rs1.getString(1);
	    }else{
	    	DEPART=" ";
	    }
	
		//根据封装外形工序确定唯一
		sql = "select * from okeyuserinf where workcode = '" + c3+"'";
		rs1.executeSql(sql);
		create_time=df.format(System.currentTimeMillis());
		update_time=df.format(System.currentTimeMillis());
		if(!rs1.next()){
			sql = "insert into OKEYUSERINF (site,workcode,name,DEPART,create_time,update_time,TOTAL_REJECT_QTY,REJECTCODE1_QTY,REJECTCODE2_QTY,REJECTCODE3_QTY,REJECTCODE4_QTY, REJECTCODE5_QTY, REJECTCODE6_QTY) values ("+
			"'" + c2 + "'," +
			"'" + c3 + "'," +
			"'" + c4 + "'," +
			"'" + DEPART + "'," +
			"'" +create_time+ "'," +
			"''," +
			"'" + c5 + "'," +
			"'" + c6 + "'," +
			"'" + c7 + "'," +
			"'" + c8 + "'," +
			"'" + c9 + "'," +
			"'" + c10 + "'," +
			"'" + c11 + "'" +
			")";
			bb.writeLog("-------------------------------------------" + sql); 
			rs.executeSql(sql); 
			bb.writeLog("OKEYUSERINF insertsql:" + sql);
		}
		else{
		sql = "update OKEYUSERINF set site = '"+ c2 +"' ,name = '"+ c4 +"' ,DEPART = '"+ DEPART +"',TOTAL_REJECT_QTY = '"+ c5 +"',REJECTCODE1_QTY = '"+ c6 +"',REJECTCODE2_QTY= '"+ c7 +"',REJECTCODE3_QTY = '"+ c8 +"',REJECTCODE4_QTY = '"+ c9+"',REJECTCODE5_QTY = '"+ c10+"',REJECTCODE6_QTY = '"+ c11+"',update_time = '"+ update_time +"' where workcode = '" + c3+"'";
	    rs.executeSql(sql);
	    bb.writeLog("OKEYUSERINF updatesql:" + sql); 
		} 
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
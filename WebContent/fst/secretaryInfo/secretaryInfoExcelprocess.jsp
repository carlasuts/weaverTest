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
<%-- <%@include file="/systeminfo/init_wev8.jsp" %> --%>
<%@include file="/page/maint/common/initNoCache.jsp" %>



<%

    int userID = user.getUID();
	BaseBean bb = new BaseBean();
	String sql = "";
	FileUploadToPath fu = new FileUploadToPath(request) ;    // 上传EXCEL文件
	String filename = fu.uploadFiles("excelfile") ;    //获取EXCEL路径
	ExcelParse excelFile = new ExcelParse();
	excelFile.init(filename) ;    //进行EXCEL文件初始化
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
	String time ="";
    String userid="";
	int recordercount = 0 ;
	String error = "";
	boolean hasvalid = true;
	StringBuilder sb = new StringBuilder();
	
	String sql3="select workcode from HrmResource where id='"+userID+"'";
    rs.executeSql(sql3);
    if(rs.next()){
    	userid = rs.getString("workcode");
	}
	
     while( true ) {
		 recordercount ++ ;
		//以下一行一行按列读取EXCEL中的数据getValue方法中的第一个参数不要变化，固定为1，第二个参数是行号，第三个参数是列号
		if( recordercount == 1 ) continue ;  //第一行为标题，一般不处理
		
		String c2 = Util.null2String( excelFile.getValue("1", ""+recordercount , "2" ) ).trim() ;
	    if( c2.equals("")) break ;   //表示已经是最后一行，处理结束
	    String c3 = "";
	    c3 = Util.null2String( excelFile.getValue("1", ""+recordercount , "3" ) ).trim() ;
	    if(c2.equals("")){
	    	c2 = " ";
	    }
	    if(c3.equals("")){
	    	c3 = " ";
	    }
	    
	    String site="";
	    String department="";
	    sql="select subcompanyid1,departmentid from Hrmresource  where  Workcode='"+c2+"'";
	   // sql="select Hrd.id  from Hrmresource hrs , Hrmdepartment hrd where   Hrs.Departmentid = hrd.id and Hrs.Workcode='"+c2+"'";
	    rs1.executeSql(sql);
	    if(rs1.next()){
	    	site=rs1.getString("subcompanyid1");
	    	department=rs1.getString("departmentid");
	    }
	    sql="select * from OBASSECDOP  where  Workcode='"+c2+"'";
	    rs1.executeSql(sql);
		time=df.format(System.currentTimeMillis());
		if(!rs1.next()){
			sql = "insert into OBASSECDOP (site,department,workcode,lastname,creater,createtime) values ("+
					"'" + site + "'," +
					"'" + department + "'," +
					"'" + c2 + "'," +
					"'" + c3 + "'," +
					"'" + userid + "'," +
					"'" + time +"'" +
					")";
			bb.writeLog("-------------------------------------------" + sql); 
			rs.executeSql(sql); 
			bb.writeLog("OBASSECDOP insertsql:" + sql);
		}
		else{
		sql = "update  OBASSECDOP set site = '" + site + "',department = '" + department +"',lastname = '" + c3 + "',updater = '" + userid + "',updatetime = '" + time +"' where  workcode = '"+c2+"'";
	    rs.executeSql(sql);
	    bb.writeLog("OBASSECDOP updatesql:" + sql); 
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
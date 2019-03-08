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
	BaseBean bb = new BaseBean();
	bb.writeLog("插入 1111111");
	String sql = "";
    FileUploadToPath fu = new FileUploadToPath(request) ;    // 上传EXCEL文件
	String filename = fu.uploadFiles("excelfile") ;    //获取EXCEL路径
	ExcelParse excelFile = new ExcelParse();
	excelFile.init(filename) ;    //进行EXCEL文件初始化
	int recordercount = 0 ;
	String error = "";
	boolean hasvalid = true;
	StringBuilder sb = new StringBuilder();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	while( true ) {
		recordercount ++ ;
		//以下一行一行按列读取EXCEL中的数据getValue方法中的第一个参数不要变化，固定为1，第二个参数是行号，第三个参数是列号
		if( recordercount == 1 ) continue ;  //第一行为标题，一般不处理
		
		String c2 = Util.null2String( excelFile.getValue("1", ""+recordercount , "2" ) ).trim() ;
		
        if( c2.equals("") ) break ;   //表示已经是最后一行，处理结束
		
        String c3 = Util.null2String( excelFile.getValue("1", ""+recordercount , "3" ) ).trim() ;

        String c4 = Util.null2String( excelFile.getValue("1", ""+recordercount , "4" ) ).trim() ;
        String c5 = Util.null2String( excelFile.getValue("1", ""+recordercount , "5" ) ).trim() ;
        String c6 = Util.null2String( excelFile.getValue("1", ""+recordercount , "6" ) ).trim() ;
        String c7 = Util.null2String( excelFile.getValue("1", ""+recordercount , "7" ) ).trim() ;
        String c8 = Util.null2String( excelFile.getValue("1", ""+recordercount , "8" ) ).trim() ; 
        String c9 = Util.null2String( excelFile.getValue("1", ""+recordercount , "9" ) ).trim() ; 
        String c10 = Util.null2String( excelFile.getValue("1", ""+recordercount , "10" ) ).trim() ;
        String c11 = Util.null2String( excelFile.getValue("1", ""+recordercount , "11" ) ).trim() ;  //邮件由工号带出 ，此列作为是否停用标志
        if(!(c11.equals("S")||c11.equals("U"))){ //是停字段控制  S 停用 U 使用
        	c11="U";
        }
        if(!Pattern.compile("-").matcher(c9).find())//如果在excel中为日期类型
        { 
        int c9N=Integer.parseInt(c9);
		GregorianCalendar gc = new GregorianCalendar(1900, 0, -1);
		gc.add(Calendar.DAY_OF_MONTH, c9N);
		java.util.Date before7days = gc.getTime();
		c9=sdf.format(before7days);
        }
        sql = "select * from sbdjxx where SBBH = '" + c5 + "' and STOPSIGN='U'"; //判断设备编号是否存在
        rs.executeSql(sql);
        if(!rs.next()){     	
        	sql = "insert into sbdjxx (FB,QB,SBLB,SBBH,SBMS,DJR,WORKCODE,ZHDJSJ,DJPL,EMAIL,STOPSIGN)  select  "+
    				"'" + c2 + "'," +
    				"'" + c3 + "'," +
    				"'" + c4 + "'," +
    				"'" + c5 + "'," +
    				"'" + c6 + "'," +
    				"'" + c7 + "'," +
    				"'" + c8 + "'," +
    				"'" + c9 + "'," +
    				"'" + c10 + "'," +
    				"email," +
    				"'" + c11 + "'" +
    				"  from Hrmresource where LOGINID='"+c8+"'";
        	

        	
    	    rs.executeSql(sql); 
            bb.writeLog("插入 sbdjxx:" + sql);
        }
        else{
        	String email="";
        	sql ="select EMAIL from Hrmresource where LOGINID='"+c8+"'";
        	rs.executeSql(sql);
        	if(rs.next())
        	 email=rs.getString("EMAIL");
        	else{
        		 bb.writeLog("sbdjxx 表更新:" + sql+"----没有这个用户");
        	}
        	sql = "update  sbdjxx set fb = '" + c2 + "',qb = '" + c3 + "',sblb = '" + c4 +"',sbms = '" + c6 +"',djr = '" + c7 +"',zhdjsj = '" + c9 +"',djpl = '" + c10 + "',workcode = '" + c8 +"',email = '" + email+"',stopsign = '" + c11 +"'   where  SBBH = '" + c5 + "' and STOPSIGN='U'";
    		rs.executeSql(sql);
            bb.writeLog("sbdjxx 表更新:" + sql);
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
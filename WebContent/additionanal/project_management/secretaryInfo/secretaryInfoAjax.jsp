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
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ExcelParse" class="weaver.file.ExcelParse" scope="page" />
<%-- <%@include file="/systeminfo/init_wev8.jsp" %>  --%>
<%@include file="/page/maint/common/initNoCache.jsp" %>



<%
int userID = user.getUID();
String result="";

String sql="",sql1="",sql2="",sql3="",sql4="",workcode="";
sql="SELECT id FROM hrmresource ";

sql1="SELECT workcode FROM OBASSECDOP WHERE (site,Department) IN (SELECT Subcompanyid1,Departmentid FROM Hrmresource WHERE id = '"+userID+"' )";

sql2="SELECT workcode FROM OBASSECDOP WHERE (site,Department) IN (SELECT Subcompanyid1,supdepid FROM Hrmdepartment WHERE (Subcompanyid1 , id) IN (SELECT Subcompanyid1,Departmentid FROM Hrmresource WHERE id = '"+userID+"'))";

sql3="SELECT workcode FROM OBASSECDOP WHERE (site,Department) IN (SELECT Subcompanyid1 , supdepid  FROM Hrmdepartment  WHERE (Subcompanyid1,id) IN  (SELECT Subcompanyid1, supdepid  FROM Hrmdepartment    WHERE (Subcompanyid1,id) IN  (SELECT Subcompanyid1,Departmentid FROM Hrmresource WHERE id ='"+userID+"'     )   ) )";

sql4="SELECT workcode FROM OBASSECDOP WHERE (site,Department) IN (SELECT Subcompanyid1, supdepid FROM Hrmdepartment WHERE (Subcompanyid1,id) IN  (SELECT Subcompanyid1,"+
"  supdepid FROM Hrmdepartment WHERE (Subcompanyid1,id) IN (SELECT Subcompanyid1, supdepid  FROM Hrmdepartment   WHERE (Subcompanyid1,id) IN (SELECT Subcompanyid1,Departmentid FROM Hrmresource WHERE id = '"+userID+"' )    )   ) )";

rs.executeSql(sql1);
if(rs.next()){
	workcode="'"+rs.getString("workcode")+"'";
	while (rs.next()){
		workcode+=",'"+rs.getString("workcode")+"'";
		}
}else{
	rs.executeSql(sql2);
	if(rs.next()){
		workcode="'"+rs.getString("workcode")+"'";
		while (rs.next()){
			workcode+=",'"+rs.getString("workcode")+"'";
			}
	}else{
		rs.executeSql(sql3);
		if(rs.next()){
			workcode="'"+rs.getString("workcode")+"'";
			while (rs.next()){
				workcode+=",'"+rs.getString("workcode")+"'";
				}
		}else{
			rs.executeSql(sql4);
			if(rs.next()){
				workcode="'"+rs.getString("workcode")+"'";
				while (rs.next()){
					workcode+=",'"+rs.getString("workcode")+"'";
					}
			}
		}
	}
}
if(!workcode.equals("")) {
	sql=sql+"WHERE workcode in ("+workcode+")";
	rs2.executeSql(sql);
	if(rs2.next()){
		result+=rs2.getString("id");
		while (rs2.next()){
		result+=",";
		result+=rs2.getString("id");
		}
	}
}


out.print(result);
%>
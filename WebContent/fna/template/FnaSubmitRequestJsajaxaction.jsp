<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
//报销金额
RecordSet rs0 = new RecordSet();
//出发地 目的地
RecordSet rs1 = new RecordSet();
RecordSet rs2 = new RecordSet();

RecordSet rs3 = new RecordSet();
RecordSet rs4 = new RecordSet();

RecordSet rs5 = new RecordSet();
RecordSet rs6 = new RecordSet();

RecordSet rs7 = new RecordSet();
RecordSet rs8 = new RecordSet();

RecordSet rs9 = new RecordSet();
RecordSet rs10 = new RecordSet();
//住宿地点
RecordSet rs11 = new RecordSet();
//出差地
RecordSet rs12 = new RecordSet();

String sql = "";
String type =  Util.null2String(request.getParameter("type"));
String result = "";

//报销金额 结算币别
if(type.equals("1")){
	String req1 =  Util.null2String(request.getParameter("req1"));
	sql = "select EERAMT5 ,CURRTYPE from formtable_main_117 where requestid = '"+ req1 +"' ";
	rs0.executeSql(sql);
	rs0.next();
	if(!"".equals(rs0.getString("EERAMT5"))){
		result +="[";
		result += "{\"EERAMT\":\"" + rs0.getString("EERAMT5")+ "\",\"CURRTYPE\":\"" + rs0.getString("CURRTYPE")+ "\"},";
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
	}
}

//交通费信息
if(type.equals("2")){
	String req =  Util.null2String(request.getParameter("req"));
	sql = "select id  from formtable_main_117 where requestid = '"+ req +"' ";
	rs3.executeSql(sql);
	rs3.next();
	if(!"".equals(rs3.getString("id"))){
		sql = "select BEGINDATE, fromcityid,tocityid,vehicle,eeramt,CURCATEGORY,RATE from formtable_main_117_dt1 where mainid = '"+ rs3.getString("id") +"' ";
		rs4.executeSql(sql);
		result +="[";
		while(rs4.next()){
			if(!"".equals(rs4.getString("fromcityid"))){
				result += "{\"fromcityid\":\"" + rs4.getString("fromcityid")+ "\",\"tocityid\":\"" + rs4.getString("tocityid") + "\",\"vehicle\":\"" + rs4.getString("vehicle") + "\",\"eeramt\":\"" + rs4.getString("eeramt") + "\",\"BEGINDATE\":\"" + rs4.getString("BEGINDATE") + "\",\"CURCATEGORY\":\"" + rs4.getString("CURCATEGORY") + "\",\"RATE\":\"" + rs4.getString("RATE") + "\"},";
			}
		}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
	}
}
//住宿费信息
if(type.equals("3")){
	String req =  Util.null2String(request.getParameter("req"));
	sql = "select id  from formtable_main_117 where requestid = '"+ req +"' ";
	rs5.executeSql(sql);
	rs5.next();
	if(!"".equals(rs5.getString("id"))){
		sql = "select BEGINDATE,ENDDATE, cityid,hotelstaydays,eeramt,CURCATEGORY,RATE from formtable_main_117_dt2  where mainid = '"+ rs5.getString("id") +"' ";
		rs6.executeSql(sql);
		result +="[";
		while(rs6.next()){
			if(!"".equals(rs6.getString("cityid"))){
				result += "{\"cityid\":\"" + rs6.getString("cityid")+ "\",\"hotelstaydays\":\"" + rs6.getString("hotelstaydays") + "\",\"eeramt\":\"" + rs6.getString("eeramt") + "\",\"BEGINDATE\":\"" + rs6.getString("BEGINDATE") + "\",\"ENDDATE\":\"" + rs6.getString("ENDDATE") + "\",\"CURCATEGORY\":\"" + rs6.getString("CURCATEGORY") + "\",\"RATE\":\"" + rs6.getString("RATE") + "\"},";
			}
		}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
	}
}
//餐补费信息
if(type.equals("4")){
	String req =  Util.null2String(request.getParameter("req"));
	sql = "select id  from formtable_main_117 where requestid = '"+ req +"' ";
	rs7.executeSql(sql);
	rs7.next();
	if(!"".equals(rs7.getString("id"))){
		sql = "select BEGINDATE,ENDDATE,cityid,mealdays,eeramt,CURCATEGORY,RATE  from formtable_main_117_dt3  where mainid = '"+ rs7.getString("id") +"' ";
		rs8.executeSql(sql);
		result +="[";
		while(rs8.next()){
			if(!"".equals(rs8.getString("cityid"))){
				result += "{\"cityid\":\"" + rs8.getString("cityid")+ "\",\"mealdays\":\"" + rs8.getString("mealdays") + "\",\"eeramt\":\"" + rs8.getString("eeramt") + "\",\"BEGINDATE\":\"" + rs8.getString("BEGINDATE") + "\",\"ENDDATE\":\"" + rs8.getString("ENDDATE") + "\",\"CURCATEGORY\":\"" + rs8.getString("CURCATEGORY")+ "\",\"RATE\":\"" + rs8.getString("RATE") + "\"},";
			}
		}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
	}
}
//其他费用信息
if(type.equals("5")){
	String req =  Util.null2String(request.getParameter("req"));
	sql = "select id  from formtable_main_117 where requestid = '"+ req +"' ";
	rs9.executeSql(sql);
	rs9.next();
	if(!"".equals(rs9.getString("id"))){
		sql = "select BEGINDATE,ENDDATE,content,eeramt,CURCATEGORY from formtable_main_117_dt4  where mainid = '"+ rs9.getString("id") +"' ";
		rs10.executeSql(sql);
		result +="[";
		while(rs10.next()){
			if(!"".equals(rs10.getString("content"))){
				result += "{\"content\":\"" + rs10.getString("content")+ "\",\"eeramt\":\"" + rs10.getString("eeramt") + "\",\"BEGINDATE\":\"" + rs10.getString("BEGINDATE") + "\",\"ENDDATE\":\"" + rs10.getString("ENDDATE") + "\",\"CURCATEGORY\":\"" + rs10.getString("CURCATEGORY") + "\"},";
			}
		}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
	}
}

//出发地
if(type.equals("6")){
	String fromcityid =  Util.null2String(request.getParameter("fromcityid"));
	sql = "select CITYNAME from HrmCity where id = '"+ fromcityid +"' ";
	rs1.executeSql(sql);
	rs1.next();
	if(!"".equals(rs1.getString("CITYNAME"))){
		result +="[";
		result += "{\"CITYNAME\":\"" + rs1.getString("CITYNAME")+ "\"},";
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
	}
}

//目的地
if(type.equals("7")){
	String tocityid =  Util.null2String(request.getParameter("tocityid"));
	sql = "select CITYNAME from HrmCity where id = '"+ tocityid +"' ";
	rs2.executeSql(sql);
	rs2.next();
	if(!"".equals(rs2.getString("CITYNAME"))){
		result +="[";
		result += "{\"CITYNAME\":\"" + rs2.getString("CITYNAME")+ "\"},";
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
	}
}

//住宿地点
if(type.equals("8")){
	String cityid =  Util.null2String(request.getParameter("cityid"));
	sql = "select CITYNAME from HrmCity where id = '"+ cityid +"' ";
	rs11.executeSql(sql);
	rs11.next();
	if(!"".equals(rs11.getString("CITYNAME"))){
		result +="[";
		result += "{\"CITYNAME\":\"" + rs11.getString("CITYNAME")+ "\"},";
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
	}
}

//出差地
if(type.equals("9")){
	String cityid1 =  Util.null2String(request.getParameter("cityid1"));
	sql = "select CITYNAME from HrmCity where id = '"+ cityid1 +"' ";
	rs12.executeSql(sql);
	rs12.next();
	if(!"".equals(rs12.getString("CITYNAME"))){
		result +="[";
		result += "{\"CITYNAME\":\"" + rs12.getString("CITYNAME")+ "\"},";
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
	}
}
out.print(result);
%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="com.alibaba.fastjson.JSON" %>
<%
int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
BaseBean e = new BaseBean();
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
String result = "";
if(type.equals("1")){
	String CUSTOMER =  Util.null2String(request.getParameter("CUSTOMER"));
	String LOT_ID =  Util.null2String(request.getParameter("LOT_ID"));
	String ASSY_LOT_CODE =  Util.null2String(request.getParameter("ASSY_LOT_CODE"));
	String CUST_RUN_ID =  Util.null2String(request.getParameter("CUST_RUN_ID"));
	String MAT_ID =  Util.null2String(request.getParameter("MAT_ID"));
	if(!"".equals(CUSTOMER)){
		RecordSetDataSource weeview = new RecordSetDataSource("STMESDB");
		String wheresql = " ";
		if(!"".equals(LOT_ID)){
			LOT_ID = "'"+LOT_ID.replace(",","','")+"'";
			wheresql += " and STS.LOT_ID in ("+LOT_ID+")";
		}
		if(!"".equals(ASSY_LOT_CODE)){
			ASSY_LOT_CODE = "'"+ASSY_LOT_CODE.replace(",","','")+"'";
			wheresql += " and ELT.ASSY_LOT_CODE in ("+ASSY_LOT_CODE+")";
		}
		if(!"".equals(CUST_RUN_ID)){
			CUST_RUN_ID = "'"+CUST_RUN_ID.replace(",","','")+"'";
			wheresql += " and ELT.CUST_RUN_ID in ("+CUST_RUN_ID+")";
		}
		if(!"".equals(MAT_ID)){
			MAT_ID = "'"+MAT_ID.replace(",","','")+"'";
			wheresql += " and MAT.MAT_SHORT_DESC in ("+MAT_ID+")";
		}
		if(!"".equals(CUSTOMER)){
			CUSTOMER = "'"+CUSTOMER.replace(",","','")+"'";
			wheresql += " and STS.LOT_CMF_2 in ("+CUSTOMER+")";
		}
		sql = "SELECT DISTINCT " +
				" STS.QTY_3 AS QTY," +
				" STS.LOT_ID AS LOT_CODE," +
				" STS.LOT_ID AS SUB_PRODUCTION_ORDER,"+
				" OSO.CUS_SO AS SALES_ORDER,"+
				" STS.MAT_ID AS MATERIAL," +
				" FUN_IERPRLT(STS.LOT_ID,'TRAN_BATCH_ID') AS BATCH," +
				" STS.ORDER_ID AS PRODUCTION_ORDER," +
				" OSO.CUS_SO AS SALES_ORDER," +
				" ELT.ASSY_LOT_CODE AS ASSY_LOT," +
				" ELT.TRACE_CODE AS TRACE_CODE," +
				" MAT.MAT_SHORT_DESC AS DESCRIPTION," +
				" ELT.CUST_RUN_ID AS WAFER_LOT," +
				" ELT.OUTBOX_ID AS WXS," +
				" FUN_IERPRLT(STS.LOT_ID,'PLANT') || '_' || FUN_IERPRLT(STS.LOT_ID,'GR_LOCATION') AS STORAGE_LOCATION" +
				" FROM MWIPLOTSTS STS " +
				" INNER JOIN MTAPCPOSTS OSO ON STS.ORDER_ID = OSO.PO_NO " +
				" INNER JOIN MWIPELTSTS ELT ON STS.LOT_ID = ELT.LOT_ID " +
				" INNER JOIN MWIPLOTHIS HIS ON STS.LOT_ID = HIS.LOT_ID " +
				" INNER JOIN MWIPMATDEF MAT ON STS.MAT_ID = MAT.MAT_ID " +
				" WHERE STS.FACTORY='FGS'" + 
				" AND STS.OPER<>'N31' " +
				" AND STS.OPER<>'N32' " +
				" AND STS.QTY_3>0 " +
				" AND STS.LOT_DEL_FLAG=' ' " +
				" AND STS.LOT_CMF_1<>'PACKAGE' "+
				" AND MAT.FACTORY = 'FGS' " + wheresql + " ORDER BY LOT_CODE";
		weeview.executeSql(sql);
		e.writeLog(sql);
		List<Map<String,String>> list = new ArrayList<Map<String, String>>();
		while(weeview.next()){
			Map<String,String>  map = new HashMap<String, String>();
			map.put("LOT_CODE",weeview.getString("LOT_CODE"));
			map.put("MATERIAL",weeview.getString("MATERIAL"));
			map.put("QTY",weeview.getString("QTY"));
			map.put("SUB_PRODUCTION_ORDER",weeview.getString("SUB_PRODUCTION_ORDER"));
			map.put("BATCH",weeview.getString("BATCH"));
			map.put("SALES_ORDER",weeview.getString("SALES_ORDER"));
			map.put("PRODUCTION_ORDER",weeview.getString("PRODUCTION_ORDER"));
			map.put("ASSY_LOT",weeview.getString("ASSY_LOT"));
			map.put("DESCRIPTION",weeview.getString("DESCRIPTION"));
			map.put("WAFER_LOT",weeview.getString("WAFER_LOT"));
			map.put("STORAGE_LOCATION",weeview.getString("STORAGE_LOCATION"));
			map.put("WXS",weeview.getString("WXS"));
			map.put("TRACE_CODE",weeview.getString("TRACE_CODE"));
			list.add(map);
		}
		result = JSON.toJSONString(list);
	}else{
		System.out.println("error!!!!!!!");
	}
}
out.print(result);
%>

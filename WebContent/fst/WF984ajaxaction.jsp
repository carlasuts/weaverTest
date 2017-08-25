<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="com.alibaba.fastjson.JSON" %>
<%
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
		RecordSetDataSource weeview = new RecordSetDataSource("weeview");
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
				" STS.MAT_ID AS MATERIAL," +
				" FUN_IERPRLT(STS.LOT_ID,'TRAN_BATCH_ID') AS BATCH," +
				" STS.ORDER_ID AS PRODUCTION_ORDER," +
				" OSO.CUS_SO AS SALES_ORDER," +
				" ELT.ASSY_LOT_CODE AS ASSY_LOT," +
				" MAT.MAT_SHORT_DESC AS DESCRIPTION," +
				" ELT.CUST_RUN_ID AS WAFER_LOT," +
				" FUN_IERPRLT(STS.LOT_ID,'PLANT') || '_' || FUN_IERPRLT(STS.LOT_ID,'GR_LOCATION') AS STORAGE_LOCATION, " +
				" FUN_OBXCOUNT(STS.LOT_ID) AS WXS" +
				" FROM MWIPLOTSTS STS " +
				" INNER JOIN MTAPCPOSTS OSO ON STS.ORDER_ID = OSO.PO_NO " +
				" INNER JOIN MWIPELTSTS ELT ON STS.LOT_ID = ELT.LOT_ID " +
				" INNER JOIN MWIPLOTHIS HIS ON STS.LOT_ID = HIS.LOT_ID " +
				" INNER JOIN MWIPMATDEF MAT ON STS.MAT_ID = MAT.MAT_ID " +
				" WHERE " +
				" STS.FACTORY = 'FGS' AND STS.LAST_TRAN_CODE = 'RECEIVE' AND STS.QTY_3 > 0 AND STS.LOT_DEL_FLAG <> 'Y' AND MAT.FACTORY = 'FGS' "+ wheresql;
		e.writeLog("type1 sql:",sql);
		weeview.executeSql(sql);
		List<Map<String,String>> list = new ArrayList<Map<String, String>>();
		while(weeview.next()){
			Map<String,String>  map = new HashMap<String, String>();
			map.put("LOT_CODE",weeview.getString("LOT_CODE"));
			map.put("MATERIAL",weeview.getString("MATERIAL"));
			map.put("QTY",weeview.getString("QTY"));
			map.put("BATCH",weeview.getString("BATCH"));
			map.put("PRODUCTION_ORDER",weeview.getString("PRODUCTION_ORDER"));
			map.put("ASSY_LOT",weeview.getString("ASSY_LOT"));
			map.put("DESCRIPTION",weeview.getString("DESCRIPTION"));
			map.put("WAFER_LOT",weeview.getString("WAFER_LOT"));
			map.put("STORAGE_LOCATION",weeview.getString("STORAGE_LOCATION"));
			map.put("WXS",weeview.getString("WXS"));
			list.add(map);
		}
		result = JSON.toJSONString(list);

	}else{
		System.out.println("error!!!!!!!");
	}

}
	if(type.equals("2")){
		String zero =  Util.null2String(request.getParameter("zero"));
		String yzx =  Util.null2String(request.getParameter("yzx"));
		List<Map<String,String>> list = new ArrayList<Map<String, String>>();
		RecordSetDataSource weeview = new RecordSetDataSource("weeview");
		if(!"".equals(zero)){
			sql = "SELECT  DISTINCT " +
					"STS.ORDER_ID AS PRODUCTION_ORDER, " +
					"STS.LOT_ID AS LOT_CODE, " +
					"STS.LOT_ID AS SUB_PRODUCTION_ORDER, " +
					"' ' AS PARENT_LOT_CODE, " +
					"DECODE((SELECT PROC_TYPE FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(STS.LOT_ID,1,14)),'AO'," +
					"(SELECT ASSY_MAT_ID FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(STS.LOT_ID,1,14)), " +
					"'AT',(SELECT TEST_MAT_ID FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(STS.LOT_ID,1,14)),STS.MAT_ID) AS MATERIAL, " +
					"(STS.QTY_3-(select NVL(SUM(QTY_3-OLD_QTY_3),0) FROM mwiplothis HIS " +
					"where HIS.LOT_ID=STS.LOT_ID and tran_code='MERGE' AND HIST_DEL_FLAG<>'Y' " +
					"and from_to_flag='T' and oper<>'6000' " +
					"AND NOT EXISTS( " +
					"SELECT /*+ INDEX(MLI CTAPIBXMLI_IDX_1)*/1 FROM CTAPOBXINF OBX,CTAPIBXMLI MLI " +
					"WHERE ((OBX.LOT_ID = HIS.LOT_ID) OR (OBX.LOT_ID LIKE HIS.LOT_ID||'-%')) AND OBX.INBOX_ID=MLI.INBOX_ID " +
					"AND MLI.MIXED_LOT_ID<>HIS.FROM_TO_LOT_ID AND OBX.FACTORY='FGS' " +
					") " +
					")) AS QTY , " +
					"OSO.CUS_SO AS SALES_ORDER, " +
					"ELT.CUST_RUN_ID AS WAFER_LOT, " +
					"ELT.ASSY_LOT_CODE AS ASSY_LOT," +
					"FUN_IERPRLT(STS.LOT_ID,'TRAN_BATCH_ID') AS BATCH,    " +
					"FUN_IERPRLT(STS.LOT_ID,'PLANT') || '_' || FUN_IERPRLT(STS.LOT_ID,'GR_LOCATION') AS STORAGE_LOCATION, " +
					"' ' AS BOX_NO " +
					"FROM MWIPLOTSTS STS  " +
					"LEFT JOIN MTAPCPOSTS OSO ON STS.ORDER_ID = OSO.PO_NO " +
					"LEFT JOIN MWIPELTSTS ELT ON STS.LOT_ID = ELT.LOT_ID " +
					"WHERE STS.LOT_ID in ("+zero+") " +
					"UNION ALL " +
					"SELECT " +
					"(SELECT ORDER_ID FROM MWIPLOTSTS WHERE LOT_ID=MRG.FROM_TO_LOT_ID) AS PRODUCTION_ORDER, " +
					"STS.LOT_ID AS PARENT_LOT_CODE, " +
					"MRG.FROM_TO_LOT_ID AS LOT_CODE, " +
					"MRG.FROM_TO_LOT_ID AS SUB_PRODUCTION_ORDER, " +
					"DECODE((SELECT PROC_TYPE FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(MRG.FROM_TO_LOT_ID,1,14)),'AO'," +
					"(SELECT ASSY_MAT_ID FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(MRG.FROM_TO_LOT_ID,1,14)), " +
					"'AT',(SELECT TEST_MAT_ID FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(MRG.FROM_TO_LOT_ID,1,14)),STS.MAT_ID) AS MATERIAL, " +
					"((select OLD_QTY_3-QTY_3 FROM mwiplothis HIS " +
					"where HIS.LOT_ID=MRG.FROM_TO_LOT_ID and tran_code='MERGE' AND HIST_DEL_FLAG<>'Y' " +
					"and from_to_flag='F' and oper<>'6000' " +
					")) AS QTY , " +
					"(SELECT DISTINCT OSO.CUS_SO FROM MTAPCPOSTS OSO,MWIPLOTSTS LOT WHERE LOT.ORDER_ID = OSO.PO_NO AND LOT.LOT_ID=MRG.FROM_TO_LOT_ID) AS SALES_ORDER, " +
					"(SELECT CUST_RUN_ID FROM MWIPELTSTS WHERE LOT_ID=MRG.FROM_TO_LOT_ID) AS WAFER_LOT, " +
					"(SELECT ASSY_LOT_CODE FROM MWIPELTSTS WHERE LOT_ID=MRG.FROM_TO_LOT_ID) AS ASSY_LOT, " +
					"FUN_IERPRLT(MRG.FROM_TO_LOT_ID,'TRAN_BATCH_ID') AS BATCH,     " +
					"FUN_IERPRLT(MRG.FROM_TO_LOT_ID,'PLANT') || '_' || FUN_IERPRLT(MRG.FROM_TO_LOT_ID,'GR_LOCATION') AS GR_LOCATION, " +
					"'' AS BOX_NO  " +
					"FROM MWIPLOTSTS STS " +
					"INNER JOIN MWIPLOTMRG MRG ON STS.LOT_ID=MRG.LOT_ID AND MRG.FROM_TO_FLAG='T' AND HIST_DEL_FLAG<>'Y' AND MRG.OPER<>'6000' " +
					"WHERE STS.LOT_ID in ("+zero+") " +
					"AND NOT EXISTS( " +
					"SELECT /*+ INDEX(MLI CTAPIBXMLI_IDX_1)*/ 1 FROM CTAPOBXINF OBX,CTAPIBXMLI MLI " +
					"WHERE ((OBX.LOT_ID = STS.LOT_ID) OR (OBX.LOT_ID LIKE STS.LOT_ID||'-%')) AND OBX.INBOX_ID=MLI.INBOX_ID " +
					"AND MLI.MIXED_LOT_ID<>MRG.FROM_TO_LOT_ID AND OBX.FACTORY='FGS' " +
					")";
			weeview.executeSql(sql);
			e.writeLog("type2 sql:" + sql);
			Map<String,String>  map = new HashMap<String, String>();
			while(weeview.next()){
				map.put("LOT_CODE",weeview.getString("LOT_CODE"));
				map.put("PRODUCTION_ORDER",weeview.getString("PRODUCTION_ORDER"));
				map.put("MATERIAL",weeview.getString("MATERIAL"));
				map.put("WAFER_LOT",weeview.getString("WAFER_LOT"));
				map.put("ASSY_LOT",weeview.getString("ASSY_LOT"));
				map.put("BATCH",weeview.getString("BATCH"));
				map.put("STORAGE_LOCATION",weeview.getString("STORAGE_LOCATION"));
				map.put("SALES_ORDER",weeview.getString("SALES_ORDER"));
				map.put("QTY",weeview.getString("QTY"));
				map.put("SUB_PRODUCTION_ORDER",weeview.getString("SUB_PRODUCTION_ORDER"));
				map.put("PARENT_LOT_CODE",weeview.getString("PARENT_LOT_CODE"));
				map.put("BOX_NO","");
				e.writeLog("map---------" + map);
				list.add(map);
				e.writeLog("list长度为:"+list.size());
			}
			
		}
		if(!"".equals(yzx)){
			sql = " SELECT PRODUCTION_ORDER,LOT_CODE,MATERIAL,WAFER_LOT,ASSY_LOT,BATCH,STORAGE_LOCATION,SALES_ORDER,SUM(MIXED_QTY) AS QTY,BOX_NO FROM  " +
					"(SELECT  " +
					"STS.ORDER_ID AS PRODUCTION_ORDER,   " +
					"MLI.MIXED_LOT_ID AS LOT_CODE,   " +
					"DECODE((SELECT PROC_TYPE FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(MLI.MIXED_LOT_ID,1,14)),'AO', " +
					"(SELECT ASSY_MAT_ID FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(MLI.MIXED_LOT_ID,1,14)), " +
					"'AT',(SELECT TEST_MAT_ID FROM MWIPELTSTS WHERE LOT_ID=SUBSTR(MLI.MIXED_LOT_ID,1,14)),STS.MAT_ID) AS MATERIAL, " +
					"MIXED_QTY , " +
					"ELT.CUST_RUN_ID AS WAFER_LOT, " +
					"ELT.ASSY_LOT_CODE AS ASSY_LOT, " +
					"FUN_IERPRLT(STS.LOT_ID,'TRAN_BATCH_ID') AS BATCH,    " +
					"FUN_IERPRLT(STS.LOT_ID,'PLANT') || '_' || FUN_IERPRLT(STS.LOT_ID,'GR_LOCATION') AS STORAGE_LOCATION,  " +
					"(SELECT OSO.CUS_SO FROM MTAPCPOSTS OSO WHERE OSO.PO_NO=STS.ORDER_ID AND CUST_LOT_ID=ELT.CUST_RUN_ID) AS SALES_ORDER,"+
					"OBX.OUTBOX_ID  AS  BOX_NO  " +
					"FROM CTAPOBXINF OBX,CTAPIBXMLI MLI,MWIPLOTSTS STS,MWIPELTSTS ELT  " +
					"WHERE OBX.INBOX_ID=MLI.INBOX_ID AND MLI.MIXED_LOT_ID=STS.LOT_ID  " +
					"AND STS.LOT_ID=ELT.LOT_ID  " +
					"AND OBX.LOT_ID in ("+yzx+") ) AA  " +
					"GROUP BY PRODUCTION_ORDER,LOT_CODE,MATERIAL,WAFER_LOT,ASSY_LOT,BATCH,STORAGE_LOCATION,SALES_ORDER,BOX_NO ";

			weeview.executeSql(sql);
			while(weeview.next()){
				Map<String,String>  map = new HashMap<String, String>();
				map.put("LOT_CODE",weeview.getString("LOT_CODE"));
				map.put("PRODUCTION_ORDER",weeview.getString("PRODUCTION_ORDER"));
				map.put("MATERIAL",weeview.getString("MATERIAL"));
				map.put("WAFER_LOT",weeview.getString("WAFER_LOT"));
				map.put("ASSY_LOT",weeview.getString("ASSY_LOT"));
				map.put("BATCH",weeview.getString("BATCH"));
				map.put("STORAGE_LOCATION",weeview.getString("STORAGE_LOCATION"));
				map.put("SALES_ORDER",weeview.getString("SALES_ORDER"));
				map.put("QTY",weeview.getString("QTY"));
				map.put("SUB_PRODUCTION_ORDER","");
				map.put("PARENT_LOT_CODE","");
				map.put("BOX_NO",weeview.getString("BOX_NO"));
				list.add(map);
			}
		}
		result = JSON.toJSONString(list);

	}
out.print(result);
%>

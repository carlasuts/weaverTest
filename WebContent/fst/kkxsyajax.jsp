<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page
	import="weaver.general.Util,java.text.*,weaver.conn.*,java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%
	try {
		BaseBean baseBean = new BaseBean();
		String lotid = request.getParameter("lotid");//lotid
		
		RecordSetDataSource rs = new RecordSetDataSource("mesdb");
		String sql = "";
		String result = "";
		String ph = "",khh = "",pm = "",fzlx = "",jbkj = "",xpcc = "",jhs = "",zhj = "",sfl = "",dd = "";
		
		sql = "SELECT LOT_CMF_2  客户号,LOT_CMF_1 封装外形 FROM MWIPLOTSTS WHERE LOT_ID = '" + lotid + "'";
		rs.execute(sql);
		if(rs.next()){
			khh = rs.getString("客户号");
			fzlx = rs.getString("封装外形");
		}
		
		sql = "SELECT ASSY_MAT_ID 品名,ASSY_LOT_CODE 批号 FROM MWIPELTSTS WHERE LOT_ID = '" + lotid + "'";
		rs.execute(sql);
		if(rs.next()){
			pm = rs.getString("品名");
			ph = rs.getString("批号");
		}
		
		sql = "SELECT INV.MAT_ID,INV.MAT_CMF_4,INV.MAT_CMF_5 FROM MBOMSETMAT BST,MWIPELTSTS ELT,MINVMATDEF INV,MWIPMATDEF MAT WHERE ELT.LOT_ID = '" + lotid +"'" +
			       " AND MAT.FACTORY = 'ASSY' AND MAT.MAT_ID = ELT.ASSY_MAT_ID AND BST.FACTORY = MAT.FACTORY AND BST.BOM_SET_ID = MAT.BOM_SET_ID AND BST.FLOW = ELT.ASSY_FLOW" +
					" AND BST.ALT_MAT_FLAG = ' '  AND INV.FACTORY = MAT.FACTORY  AND INV.MAT_ID = BST.MAT_ID AND (INV.MAT_TYPE = '基板' OR INV.MAT_TYPE = '框架')";
		rs.execute(sql);
		while(rs.next()){
			jbkj += rs.getString("MAT_CMF_4");
			if(!jbkj.equals(""))
				jbkj += ";";
			jbkj += rs.getString("MAT_CMF_5") + "|";
		}
		if(!jbkj.equals(""))
			jbkj = jbkj.substring(0,jbkj.length() - 1);
		
		sql = "SELECT INV.MAT_ID,INV.MAT_CMF_4,INV.MAT_CMF_5 FROM MBOMSETMAT BST,MWIPELTSTS ELT,MINVMATDEF INV,MWIPMATDEF MAT WHERE ELT.LOT_ID = '" + lotid + "'" + 
				  " AND MAT.FACTORY = 'ASSY' AND MAT.MAT_ID = ELT.ASSY_MAT_ID AND BST.FACTORY = MAT.FACTORY AND BST.BOM_SET_ID = MAT.BOM_SET_ID  AND BST.FLOW = ELT.ASSY_FLOW" +
					" AND BST.ALT_MAT_FLAG = ' ' AND INV.FACTORY = MAT.FACTORY AND INV.MAT_ID = BST.MAT_ID AND INV.MAT_TYPE in (select distinct key_1 from mgcmtbldat where table_name ='B@INV_MAT_CHECK' AND KEY_4 ='金丝')";
		rs.execute(sql);
		while(rs.next()){
        	jhs += rs.getString("MAT_CMF_4");
        	if(!jhs.equals(""))
        		jhs += ";";
        	jhs += rs.getString("MAT_CMF_5") + "|";
		}
		if(!jhs.equals(""))
			jhs = jhs.substring(0,jhs.length() - 1);
		
        sql = "SELECT INV.MAT_ID,INV.MAT_CMF_4,INV.MAT_CMF_5 FROM MBOMSETMAT BST,MWIPELTSTS ELT,MINVMATDEF INV,MWIPMATDEF MAT WHERE ELT.LOT_ID = '" + lotid + "'" +
				" AND MAT.FACTORY = 'ASSY' AND MAT.MAT_ID = ELT.ASSY_MAT_ID AND BST.FACTORY = MAT.FACTORY AND BST.BOM_SET_ID = MAT.BOM_SET_ID AND BST.FLOW = ELT.ASSY_FLOW"+
        		" AND BST.ALT_MAT_FLAG = ' ' AND INV.FACTORY = MAT.FACTORY AND INV.MAT_ID = BST.MAT_ID AND INV.MAT_TYPE = '塑封料'";
        rs.execute(sql);
        while(rs.next()){
           	sfl += rs.getString("MAT_CMF_4");
           	if(!sfl.equals(""))
           		sfl += ";";
            sfl += rs.getString("MAT_CMF_5") + "|";
        }
        if(!sfl.equals(""))
        	sfl = jhs.substring(0,sfl.length() - 1);
        
        sql = "SELECT INV.MAT_ID,INV.MAT_CMF_4,INV.MAT_CMF_5 FROM MBOMSETMAT BST,MWIPELTSTS ELT,MINVMATDEF INV,MWIPMATDEF MAT WHERE ELT.LOT_ID = '" + lotid + "'" +
        		" AND MAT.FACTORY = 'ASSY' AND MAT.MAT_ID = ELT.ASSY_MAT_ID AND BST.FACTORY = MAT.FACTORY AND BST.BOM_SET_ID = MAT.BOM_SET_ID AND BST.FLOW = ELT.ASSY_FLOW"+
        		" AND BST.ALT_MAT_FLAG = ' ' AND INV.FACTORY = MAT.FACTORY AND INV.MAT_ID = BST.MAT_ID AND INV.MAT_TYPE = '助焊剂'";
        rs.execute(sql);
        while(rs.next()){
	    	zhj += rs.getString("MAT_CMF_4");
	    	if(!zhj.equals(""))
	    		zhj += ";";
           	zhj += rs.getString("MAT_CMF_5") + "|";
	    }
        if(!zhj.equals(""))
        	zhj = zhj.substring(0,zhj.length() - 1);
        
	    sql = "SELECT SPM.CHAR_ID, SPM.TARGET_VALUE FROM MWIPELTSTS ELT, MSPMRELDEF REL, MSPMRELCHR SPM WHERE ELT.LOT_ID = '" + lotid + "'" +
	    		" AND REL.FACTORY = 'DIEBANK' AND REL.MAT_ID = ELT.DB_MAT_ID AND SPM.SPEC_REL_ID = REL.SPEC_REL_ID AND (SPM.CHAR_ID = 'SP_ChipSizeX' OR SPM.CHAR_ID = 'SP_ChipSizeY')";
	    rs.execute(sql);
	    while(rs.next()){
	    	xpcc += rs.getString("TARGET_VALUE") + "|";
	    }
	    if(!xpcc.equals(""))
	    	xpcc = xpcc.substring(0,xpcc.length() - 1);
	    
	    sql = "SELECT SPM.TARGET_VALUE FROM MWIPELTSTS ELT, MSPMRELDEF REL, MSPMRELCHR SPM WHERE ELT.LOT_ID = '" + lotid + "'" +
	    		" AND REL.FACTORY = 'DIEBANK' AND REL.MAT_ID = ELT.DB_MAT_ID AND SPM.SPEC_REL_ID = REL.SPEC_REL_ID AND SPM.CHAR_ID = 'SP_Plate'";
	    rs.execute(sql);
	    while(rs.next()){
	    	dd += rs.getString("TARGET_VALUE") + "|";
	    }
	    if(!dd.equals(""))
	    	dd = dd.substring(0,dd.length() - 1);
	    
		result = ph + "," + khh + "," + pm + "," + fzlx + "," + jbkj + "," + xpcc + "," + jhs + "," + zhj + "," + sfl + "," + dd;
		out.print(result);
	} 
	catch (java.lang.Exception e) {
		BaseBean baseBean = new BaseBean();
		baseBean.writeLog("start log");
		baseBean.writeLog("------------------------------------------------------------------------");
		baseBean.writeLog("/interface/ff/kkxsyajax.jsp error:" + e.getMessage());
		baseBean.writeLog("------------------------------------------------------------------------");
		baseBean.writeLog("end log");
	}
%>

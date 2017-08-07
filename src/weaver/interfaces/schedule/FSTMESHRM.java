package weaver.interfaces.schedule;

import java.util.*;
import java.text.*;
import java.math.*;

import weaver.conn.*;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.*;
import weaver.general.BaseBean;

public class FSTMESHRM extends BaseCronJob  {
	public void execute() {
		BaseBean bs = new BaseBean();
		try {
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String date = sdf.format(d);
			String ID = "";
			String FXNO = "";
			String CUST_ID = "";
			String MAT_DESC = "";
			String ASSYLOT = "";
			String CUST_RUN_ID = "";
			String CREATE_DATE = "";
			String RES_ID = "";
			String LOT_ID = "";
			String PROGRAM_ID = "";
			String PKLD = "";
			String OPER = "";
			String INPUT_QTY = "";
			String PASS_QTY = "";
			String FT_FAIL_QTY = "";
			String VD_FAIL_QTY = "";
			String TOTAL_YIELD = "";
			String TOPBIN1_PROMPT = "";
			String TOPBIN2_PROMPT = "";
			String TOPBIN3_PROMPT = "";
			String TOPBIN1_QTY = "";
			String TOPBIN2_QTY = "";
			String TOPBIN3_QTY = "";
			String TOPBIN1_FAIL_YIELD = "";
			String TOPBIN2_FAIL_YIELD = "";
			String TOPBIN3_FAIL_YIELD = "";
			String USER_ID = "";
			String FLAG = "";
			String RESV_FIELD5="";
			String sql = "";
			RecordSet rs = new RecordSet();
			RecordSet rs1 = new RecordSet();
			//待触发的流程
			sql = "MERGE INTO hrmdepartment OADEPT"+
     "USING (  SELECT deptname, innercode"+
               " FROM bd_deptdoc"+
               "WHERE canceled = 'N' AND hrcanceled = 'N'"+
            "ORDER BY innercode) SRCDEPT"+
        "ON (OADEPT.DEPARTMENTCODE = SRCDEPT.INNERCODE)"+
"WHEN MATCHED"+
"THEN"+
  " UPDATE SET"+
      "OADEPT.DEPARTMENTNAME = SRCDEPT.DEPTNAME,"+
     " OADEPT.DEPARTMENTMARK = SRCDEPT.DEPTNAME"+
"WHEN NOT MATCHED"+
"THEN"+
   "INSERT     (DEPARTMENTNAME,"+
               "DEPARTMENTMARK,"+
              "DEPARTMENTCODE,"+
               "SUBCOMPANYID1,"+
               "SUPDEPID)"+
       "VALUES (SRCDEPT.DEPTNAME,"+
               "SRCDEPT.DEPTNAME,"+
               "SRCDEPT.INNERCODE,"+
               "1,"+
               "SUBSTR (SRCDEPT.INNERCODE, LENGTH (SRCDEPT.INNERCODE) - 2));";
			rs.executeSql(sql);
			while(rs.next()){
				ID = rs.getString("ID");
				FXNO = rs.getString("FXNO");
				CUST_ID = rs.getString("CUST_ID");
				MAT_DESC = rs.getString("MAT_DESC");
				ASSYLOT = rs.getString("ASSYLOT");
				CUST_RUN_ID = rs.getString("CUST_RUN_ID");
				CREATE_DATE = rs.getString("CREATE_DATE");
				RES_ID = rs.getString("RES_ID");
				LOT_ID = rs.getString("LOT_ID");
				PROGRAM_ID = rs.getString("PROGRAM_ID");
				PKLD = rs.getString("PKLD");
				OPER = rs.getString("OPER");
				INPUT_QTY = rs.getString("INPUT_QTY");
				PASS_QTY = rs.getString("PASS_QTY");
				FT_FAIL_QTY = rs.getString("FT_FAIL_QTY");
				VD_FAIL_QTY = rs.getString("VD_FAIL_QTY");
				TOTAL_YIELD = rs.getString("TOTAL_YIELD");
				TOPBIN1_PROMPT = rs.getString("TOPBIN1_PROMPT");
				TOPBIN2_PROMPT = rs.getString("TOPBIN2_PROMPT");
				TOPBIN3_PROMPT = rs.getString("TOPBIN3_PROMPT");
				TOPBIN1_QTY = rs.getString("TOPBIN1_QTY");
				TOPBIN2_QTY = rs.getString("TOPBIN2_QTY");
				TOPBIN3_QTY = rs.getString("TOPBIN3_QTY");
				TOPBIN1_FAIL_YIELD = rs.getString("TOPBIN1_FAIL_YIELD");
				TOPBIN2_FAIL_YIELD = rs.getString("TOPBIN2_FAIL_YIELD");
				TOPBIN3_FAIL_YIELD = rs.getString("TOPBIN3_FAIL_YIELD");
				USER_ID = rs.getString("USER_ID");
				FLAG = rs.getString("FLAG");
				RESV_FIELD5 =rs.getString("RESV_FIELD5");
				
				sql = "select id from hrmresource where workcode = '" + USER_ID + "'";
				rs1.executeSql(sql);
				if(rs1.next())
					USER_ID = rs1.getString("id");
				else
					USER_ID = "1";
				
				RequestInfo requestInfo = new RequestInfo();
				MainTableInfo mainTableInfo = new MainTableInfo();
				
				/*if((TOPBIN1_PROMPT.equals("") || TOPBIN1_PROMPT.equals("0")) && (TOPBIN2_PROMPT.equals("") || TOPBIN2_PROMPT.equals("0")) && (TOPBIN3_PROMPT.equals("") || TOPBIN3_PROMPT.equals("0")) &&
					(TOPBIN1_QTY.equals("") || TOPBIN1_QTY.equals("0")) && (TOPBIN2_QTY.equals("") || TOPBIN2_QTY.equals("0")) && (TOPBIN3_QTY.equals("") || TOPBIN3_QTY.equals("0")) &&
					(TOPBIN1_FAIL_YIELD.equals("") || TOPBIN1_FAIL_YIELD.equals("0")) && (TOPBIN2_FAIL_YIELD.equals("") || TOPBIN2_FAIL_YIELD.equals("0")) && (TOPBIN3_FAIL_YIELD.equals("") || TOPBIN3_FAIL_YIELD.equals("0")) &&
					TOTAL_YIELD.equals("") || TOTAL_YIELD.equals("0")){*/
				bs.writeLog("LOT_ID:" + LOT_ID + ":LOT_ID");
				bs.writeLog("TOTAL_YIELD:" + TOTAL_YIELD + ":TOTAL_YIELD");
				bs.writeLog("RESV_FIELD5:"+ RESV_FIELD5 + ":RESV_FIELD5");
				if( (RESV_FIELD5.equals("VD_LOW_YIELD") && (!"BIN97".equals(TOPBIN1_PROMPT) && !"BIN99".equals(TOPBIN1_PROMPT)
								&& !"BROKEN".equals(TOPBIN1_PROMPT)&& !"LOST".equals(TOPBIN1_PROMPT)
								&& !"VI DEFECT".equals(TOPBIN1_PROMPT) ))
						|| (RESV_FIELD5.equals("VD_LOW_YIELD") &&(!"".equals(TOPBIN2_PROMPT) &&!"BIN97".equals(TOPBIN2_PROMPT) 
								&& !"BIN99".equals(TOPBIN2_PROMPT) && !" ".equals(TOPBIN2_PROMPT)
								&& !"BROKEN".equals(TOPBIN2_PROMPT)
								&& !"VI DEFECT".equals(TOPBIN2_PROMPT)
								&& !"LOST".equals(TOPBIN2_PROMPT)))
								||( RESV_FIELD5.equals("VD_LOW_YIELD") &&(!"".equals(TOPBIN3_PROMPT) && !" ".equals(TOPBIN3_PROMPT)))
								)
								  {
					bs.writeLog("工序内+良率异常");
					
					
	
					

					requestInfo.setCreatorid(USER_ID);
					requestInfo.setWorkflowid("401");
					requestInfo.setDescription("工序内+良率异常处理流程-" + date + "(MES自动触发)");
					
					requestInfo.setMainTableInfo(mainTableInfo);
					RequestService service = new RequestService();//创建请求服务实例
					
					String newRequestid = service.createRequest(requestInfo); 
					bs.writeLog("LLYC_MIDDLE:" + newRequestid);
					
					SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss"); 
					String udpatetime = sdf1.format(d);
					sql = "update LLYC_MIDDLE set FLAG = '100',UPDATE_TIME = '" + udpatetime + "' where id = " + ID;
					bs.writeLog("LLYC_MIDDLE update sql:" + sql);
					rs1.executeSql(sql);	
				}
				else if(TOTAL_YIELD.equals(" ") || TOTAL_YIELD.equals("")||
						(RESV_FIELD5.equals("VD_LOW_YIELD"))){
					// null == TOTAL_YIELD || "".equals(TOTAL_YIELD.trim())
				
					

					
					requestInfo.setCreatorid(USER_ID);
					requestInfo.setWorkflowid("83");
					requestInfo.setDescription("良率异常处理流程-" + date + "(MES自动触发)");
					
					requestInfo.setMainTableInfo(mainTableInfo);
					RequestService service = new RequestService();//创建请求服务实例
					
					String newRequestid = service.createRequest(requestInfo); 
					bs.writeLog("LLYC_MIDDLE:" + newRequestid);
					
					SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss"); 
					String udpatetime = sdf1.format(d);
					sql = "update LLYC_MIDDLE set FLAG = '100',UPDATE_TIME = '" + udpatetime + "' where id = " + ID;
					bs.writeLog("LLYC_MIDDLE update sql:" + sql);
					rs1.executeSql(sql);
				}
			}
		}
		catch (Exception e) {
			bs.writeLog("FSTMES83:" + e);
		}	 
    }
}

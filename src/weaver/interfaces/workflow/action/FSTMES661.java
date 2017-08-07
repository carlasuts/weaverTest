package weaver.interfaces.workflow.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.text.*;
import java.math.*;
import weaver.conn.*;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.Row;
import weaver.general.BaseBean;

public class FSTMES661 implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			
			String sql = "select TIGGERID,cz1,sfqcqr from formtable_main_9 where requestid = " + request.getRequestid();
			baseBean.writeLog(sql);
			rs.executeSql(sql);
			rs.next();
			String id = rs.getString("TIGGERID");
			String cz1 = rs.getString("cz1");
			String qc = rs.getString("sfqcqr");
			
			sql = "select selectname from workflow_selectitem where fieldid = 6742 and selectvalue = " + cz1;
			baseBean.writeLog(sql);
			rs.executeSql(sql);
			rs.next();
			cz1 = rs.getString("selectname");
			if(cz1.length() > 15){
				cz1 = cz1.substring(0, 15);	
			}
			
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
			String udpatetime = sdf.format(date);

			sql = "update LLYC_MIDDLE set flag = '200'";
			/* 
			if(!cz1.equals("")){
				sql += ",resv_field4 = '" + cz1 + "'";	
			}*/
			sql += ",UPDATE_TIME = '" + udpatetime + "' where id = " + id;
			baseBean.writeLog(sql);
			rs.execute(sql);
			
		}
		catch(java.lang.Exception e){
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTMES661 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

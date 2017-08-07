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


public class NTME321 implements Action {
	public String execute(RequestInfo request) {
        try {
            BaseBean baseBean = new BaseBean();
	        String fqbs = "";
	        String sql = "";
	        
	        String rid = request.getRequestid();

	        baseBean.writeLog("NTME321 requestid:" + rid);
	        Property[] properties = request.getMainTableInfo().getProperty();
	        for (int i = 0; i < properties.length; i++) {
	            String name = properties[i].getName().toUpperCase();
	            String value = Util.null2String(properties[i].getValue());
				//edpno
				if(name.equals("FQ")){
					fqbs = value;
				}
            }
	        baseBean.writeLog("NTME321 FQ---------:" + fqbs);

	        RecordSet rs = new RecordSet();
	        String hrmid = request.getLastoperator();

	        String sql1 = "update formtable_main_38 set fq = 1 where requestid = " + rid;
			baseBean.writeLog("TFMEMES321 sql:" + sql1);
			rs.executeSql(sql1);
	        
        }
        catch (Exception e) {
            BaseBean baseBean = new BaseBean();
	        baseBean.writeLog("start log");
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("NTME321 error:" + e.getMessage());
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("end log");
        }
	    return Action.SUCCESS;
    }
}

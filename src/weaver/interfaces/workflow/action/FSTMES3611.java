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

public class FSTMES3611 implements Action {
	public String execute(RequestInfo request) {
        try {
            BaseBean baseBean = new BaseBean();
	        String id = ""; String cz = ""; String mescz = ""; String tecz = "";
	        String sql = "";
	        Property[] properties = request.getMainTableInfo().getProperty();
	        for (int i = 0; i < properties.length; i++) {
	            String name = properties[i].getName().toUpperCase();
	            String value = Util.null2String(properties[i].getValue());
	            //ID
			    if(name.equals("TIGGERID")){
				    id = value;
			    }
				//处置
				if(name.equals("TECZPD")){
					cz = value;
				}
				//MES处置
				if(name.equals("MCZ")){
					mescz = value;
				}
				//TE处理结论
				if(name.equals("TECZ")){
					tecz = value;
                }
                //QA处置 156
				
            }
	        baseBean.writeLog("tecz:" + tecz);
	        if (tecz.length() > 15) {
	            tecz = tecz.substring(0, 15);
	        }
	        baseBean.writeLog("tecz:" + tecz);
	        Date date = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	        String udpatetime = sdf.format(date);
	        String workcode = "";

	        RecordSet rs = new RecordSet();
	        String hrmid = request.getLastoperator();
	        sql = "select workcode from hrmresource where id = " + hrmid;
	        baseBean.writeLog(sql);
	        rs.execute(sql);
	        if (rs.next()) {
	            workcode = rs.getString("workcode");
	        }
	        sql = "update CPYC_MIDDLE set flag = '200'";
	        if (!workcode.equals("")) {
	            sql = sql + ",resv_field1='" + workcode + "'";
	        }
	        if (!mescz.equals("")) {
	            sql = sql + ",resv_field2 = '" + mescz + "'";
	        }
	        if (!tecz.equals("")) {
	            sql = sql + ",resv_field4 = '" + tecz + "'";
	        }
	        sql = sql + ",UPDATE_TIME = '" + udpatetime + "' where id = " + id;
	        baseBean.writeLog(sql);
	        rs.execute(sql);
        }
        catch (Exception e) {
            BaseBean baseBean = new BaseBean();
	        baseBean.writeLog("start log");
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("FSTMES3611 error:" + e.getMessage());
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("end log");
        }
	    return Action.SUCCESS;
    }
}

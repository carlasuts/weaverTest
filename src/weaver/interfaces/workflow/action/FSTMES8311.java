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

public class FSTMES8311 implements Action{

	@Override
	public String execute(RequestInfo request) {
        try {
            BaseBean baseBean = new BaseBean();
	        String id = ""; String fxzt = ""; 
	        String sql = "";
	        Property[] properties = request.getMainTableInfo().getProperty();
	        for (int i = 0; i < properties.length; i++) {
	            String name = properties[i].getName().toUpperCase();
	            String value = Util.null2String(properties[i].getValue());
	            //ID
			    if(name.equals("TIGGERID")){
				    id = value;
			    }
				
				//TE处理结论
				if(name.equals("FXZT")){
					fxzt = value;
                }
            }
//	        baseBean.writeLog("tecz:" + fxzt);
//	        if (fxzt.length() > 15) {
//	        	fxzt = tecz.substring(0, 15);
//	        }
//	        baseBean.writeLog("tecz:" + tecz);
	        Date date = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	        String udpatetime = sdf.format(date);
	        String workcode = "";

	        RecordSet rs = new RecordSet();
			if(fxzt.equals("2")){
				//重测 在当前站点保留
				sql = "select * from llyc_middle where id = " + id;
				baseBean.writeLog(sql);
				rs.execute(sql);
				rs.next();
				String lot_id = "",oper = "",flag = "",updatetime = "";
				lot_id = rs.getString("lot_id");
				oper = rs.getString("oper");
				
				
				
				String hrmid = request.getLastoperator();
				sql = "select workcode from hrmresource where id = " + hrmid;
				baseBean.writeLog(sql);
				rs.execute(sql);
				if(rs.next()){
					workcode = rs.getString("workcode");
				}
				
				sql = "update LLYC_MIDDLE set ";
				if(!fxzt.equals("")){
					sql += "resv_field6 = '" + fxzt + "'";
				}
				/*
				if(!tecz.equals("")){
					sql += ",resv_field4 = '" + tecz + "'";	
				}*/
				sql += ",UPDATE_TIME = '" + udpatetime + "' where id = " + id;
				baseBean.writeLog(sql);
				rs.execute(sql);
			}
			else {
				//最终处理
				String hrmid = request.getLastoperator();
				sql = "select workcode from hrmresource where id = " + hrmid;
				baseBean.writeLog(sql);
				rs.execute(sql);
				if(rs.next()){
					workcode = rs.getString("workcode");
				}
				
				sql = "update LLYC_MIDDLE set flag = '200'";
				if(!workcode.equals("")){
					sql += ",resv_field1='" + workcode + "'";	
				}
				if(!fxzt.equals("")){
					sql += ",resv_field2 = '" + fxzt + "'";
				}
				/*
				if(!tecz.equals("")){
					sql += ",resv_field4 = '" + tecz + "'";	
				}*/
				sql += ",UPDATE_TIME = '" + udpatetime + "' where id = " + id;
				baseBean.writeLog(sql);
				rs.execute(sql);
			}
			
	       
        }
        catch (Exception e) {
            BaseBean baseBean = new BaseBean();
	        baseBean.writeLog("start log");
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("FSTMES8311 error:" + e.getMessage());
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("end log");
        }
		return Action.SUCCESS;
	}
	

}

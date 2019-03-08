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

//第10个节点，QA处理1离开时进行数据比对
public class NTMEMES120401 implements Action {
	public String execute(RequestInfo request) {
        try {
            BaseBean baseBean = new BaseBean();
	        String xh = "";
	        String sql = "";
	        String rid = request.getRequestid();
	        baseBean.writeLog("TFMEMES8310 requestid:" + rid);
	        Property[] properties = request.getMainTableInfo().getProperty();
	        for (int i = 0; i < properties.length; i++) {
	            String name = properties[i].getName().toUpperCase();
	            String value = Util.null2String(properties[i].getValue());
				//edpno
				if(name.equals("XH")){
					xh = value;
				}
            }
	        baseBean.writeLog("xh:" + xh);

	        RecordSet rs = new RecordSet();
	        String hrmid = request.getLastoperator();
	        sql = "select * from tb_hjpz where matid = '" + xh + "'";
	        baseBean.writeLog(sql);
	        rs.execute(sql);
	        if(rs.next()){
//	        	request.getRequestManager().setMessageid("222222");
//	            request.getRequestManager().setMessagecontent("客户未放行");
	        	String sql1 = "update formtable_main_6 set sfsj = 1 where requestid = " + rid;
				baseBean.writeLog("TFMEMES8310 sql:" + sql1);
				rs.executeSql(sql1);
	        }else{
	        	String sql1 = "update formtable_main_6 set sfsj = 0 where requestid = " + rid;
				baseBean.writeLog("TFMEMES8310 sql:" + sql1);
				rs.executeSql(sql1);
	        }
        }
        catch (Exception e) {
            BaseBean baseBean = new BaseBean();
	        baseBean.writeLog("start log");
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("TFMEMES8310 error:" + e.getMessage());
	        baseBean.writeLog("------------------------------------------------------------------------");
	        baseBean.writeLog("end log");
        }
	    return Action.SUCCESS;
    }
}

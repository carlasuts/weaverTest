package weaver.interfaces.workflow.action;

import java.util.ArrayList;
import java.util.Calendar;
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

public class FSTMES65 implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			String id = "";
			Property[] properties = request.getMainTableInfo().getProperty();// 获取表单主字段信息
			for (int i = 0; i < properties.length; i++) {// 主表数据
				String name = properties[i].getName().toUpperCase();//字段名
				String value = Util.null2String(properties[i].getValue());//值
				//ID
				if(name.equals("TIGGERID")){
					id = value;
				}
			}
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
			String udpatetime = sdf.format(date);
			String sql = "update ZZYC_MIDDLE set flag = 200,UPDATE_TIME = '" + udpatetime + "' where id = " + id;
			RecordSet rs = new RecordSet();
			rs.execute(sql);
		}
		catch(java.lang.Exception e){
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTMES65 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

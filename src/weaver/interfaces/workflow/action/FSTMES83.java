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

public class FSTMES83 implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			String id = "", cz = "", mescz = "", tecz = "";
			String sql = "";
			Property[] properties = request.getMainTableInfo().getProperty();// 获取表单主字段信息
			for (int i = 0; i < properties.length; i++) {// 主表数据
				String name = properties[i].getName().toUpperCase();// 字段名
				String value = Util.null2String(properties[i].getValue());// 值
				// ID
				if (name.equals("TIGGERID")) {
					id = value;
				}
				// 处置
				if (name.equals("TECZPD")) {
					cz = value;
				}
				// MES处置
				if (name.equals("MCZ")) {
					mescz = value;
				}
				// TE处理结论
				if (name.equals("TECZ")) {
					tecz = value;
				}
			}
			baseBean.writeLog("tecz:" + tecz);
			tecz = tecz.replaceAll("&nbsp;", " ");
			if (tecz.length() > 15) {
				tecz = tecz.substring(0, 15);
			}
			baseBean.writeLog("tecz:" + tecz);
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
			String udpatetime = sdf.format(date);
			String workcode = "";
			// 如果是需要TE再处置，插入新表
			RecordSet rs = new RecordSet();
			if (cz.equals("3")) {
				// TE处置
				sql = "select * from llyc_middle where id = " + id;
				baseBean.writeLog(sql);
				rs.execute(sql);
				rs.next();
				String lot_id = "", oper = "", flag = "", updatetime = "";
				lot_id = rs.getString("lot_id");
				oper = rs.getString("oper");

				int maxid = 1;
				sql = "select max(id) id from LLYC_END_MIDDLE";
				rs.execute(sql);
				if (rs.next()) {
					maxid = rs.getInt("id");
				}

				sql = "insert into LLYC_END_MIDDLE(id,lot_id,oper,flag,update_time) values (" + maxid + "," + "'"
						+ lot_id + "'," + "'" + oper + "'," + "'200'," + "'" + udpatetime + "'" + ")";
				baseBean.writeLog(sql);
				rs.execute(sql);

				String hrmid = request.getLastoperator();
				sql = "select workcode from hrmresource where id = " + hrmid;
				baseBean.writeLog(sql);
				rs.execute(sql);
				if (rs.next()) {
					workcode = rs.getString("workcode");
				}

				sql = "update LLYC_MIDDLE set flag = '200'";
				if (!workcode.equals("")) {
					sql += ",resv_field1='" + workcode + "'";
				}
				if (!mescz.equals("")) {
					sql += ",resv_field2 = '" + mescz + "'";
				}
				/*
				 * if(!tecz.equals("")){ sql += ",resv_field4 = '" + tecz + "'"; }
				 */
				sql += ",UPDATE_TIME = '" + udpatetime + "' where id = " + id;
				baseBean.writeLog(sql);
				rs.execute(sql);
			} else if (cz.equals("1")) {
				// 最终处理
				String hrmid = request.getLastoperator();
				sql = "select workcode from hrmresource where id = " + hrmid;
				baseBean.writeLog(sql);
				rs.execute(sql);
				if (rs.next()) {
					workcode = rs.getString("workcode");
				}

				sql = "update LLYC_MIDDLE set flag = '200'";
				if (!workcode.equals("")) {
					sql += ",resv_field1='" + workcode + "'";
				}
				if (!mescz.equals("")) {
					sql += ",resv_field2 = '" + mescz + "'";
				}
				/*
				 * if(!tecz.equals("")){ sql += ",resv_field4 = '" + tecz + "'"; }
				 */
				sql += ",UPDATE_TIME = '" + udpatetime + "' where id = " + id;
				baseBean.writeLog(sql);
				rs.execute(sql);
			} else {
				// 客户处置或QA处置
				if (!tecz.equals("")) {
					sql = "update LLYC_MIDDLE set resv_field4 = '" + tecz + "',UPDATE_TIME = '" + udpatetime
							+ "' where id = " + id;
					baseBean.writeLog(sql);
					rs.execute(sql);
				}
			}
		} catch (java.lang.Exception e) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTMES83 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

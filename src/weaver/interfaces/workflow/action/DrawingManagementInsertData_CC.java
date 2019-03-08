/**
 * ****************************************************************************
 * System      : weaverself
 * Module      : weaver.interfaces.workflow.action
 * File Name   : DrawingManagementUpdateData.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年12月7日     wei.wang     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.action;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.RequestInfo;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author wei.wang
 *
 *技术图纸管理审批流程04文管员审批插入数据otecdrmedef
 */
public class DrawingManagementInsertData_CC implements Action {
	
	private static int formId = 0;
	
    public DrawingManagementInsertData_CC() {
    }
 
    public String execute(RequestInfo request) {
        String result ="1";
        try {
            //日志对象
            BaseBean e = new BaseBean();
            String requestID = request.getRequestid();
            e.writeLog(requestID);
            formId = BillUtil.getFormId(Integer.parseInt(request.getWorkflowid()));
    		Date d = new Date();
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    		String date = sdf.format(d);
            String sql = "";
            String sqr = "";
            String tzbh = " ";//图纸编号
            String tzbb = " ";//图纸版本
            String tzlx = " ";//图纸类型
            String pkg = " ";//封装外形大类
            String pkld = " ";//封装外形
            String custid = " ";//客户号
            String cppm = " ";//品名描述
            String khpm = " ";//客户品名
            String tzlxname = " ";//图纸类型名
            String createuser = " ";//创建人
            String createtime = " ";//创建时间
            String cadgstz = " ";//CAD格式图纸
            String yszlsc = " ";//图纸、原始资料上传
            String diename = " ";//芯片名称
            
            RecordSet rs = new RecordSet();
            sql ="SELECT * FROM formtable_main_"+ formId +"  WHERE REQUESTID = "+ requestID;
            rs.executeSql(sql);
            rs.next();
            if(!"".equals(rs.getString("tzbh"))){
            	tzbh = rs.getString("tzbh");
            }
            if(!"".equals(rs.getString("tzbb"))){
            	 tzbb = rs.getString("tzbb");
            }
            if(!"".equals(rs.getString("tzlx"))){
            	tzlx = rs.getString("tzlx");
            }
            if(!"".equals(rs.getString("pkg"))){
            	pkg = rs.getString("pkg");
            }
            if(!"".equals(rs.getString("pkld"))){
            	pkld = rs.getString("pkld");
            }
            if(!"".equals(rs.getString("custid"))){
            	custid = rs.getString("custid");
            }
            if(!"".equals(rs.getString("cppm"))){
            	cppm = rs.getString("cppm");
            }
            if(!"".equals(rs.getString("khpm"))){
            	khpm = rs.getString("khpm");
            }
            if(!"".equals(rs.getString("cadgstz"))){
            	cadgstz = rs.getString("cadgstz");
            }
            if(!"".equals(rs.getString("yszlsc"))){
            	yszlsc = rs.getString("yszlsc");
            }
            if(!"".equals(rs.getString("xpmc"))){
            	diename = rs.getString("xpmc");
            }
            
            sqr = rs.getString("sqr");
            sql ="SELECT loginid FROM hrmresource  WHERE id = "+ sqr;
            rs.executeSql(sql);
            rs.next();
            createuser = rs.getString("loginid");
            sql = "select * from workflow_selectitem where fieldid =( select id from workflow_billfield where billid='-"+formId+"' and fieldname = 'tzlx')   and selectvalue ="+ tzlx;
            rs.executeSql(sql);
            rs.next();
            tzlxname = rs.getString("selectname");
            createtime = date;
        	sql = "insert into otecdrmedef_cc(tzbh,tzbb,tzlx,pkg,pkld,custid,matdesc,custmat,tzlxname,create_user,create_time,requestid,cadgstz,yszlsc,diename) values ("+
        			"'" + tzbh + "'," +
        			"'" + tzbb + "'," +
        			"'" + tzlx + "'," +
        			"'" + pkg + "'," +
        			"'" + pkld + "'," +
        			"'" + custid + "'," +
        			"'" + cppm + "'," +
        			"'" + khpm + "'," +
        			"'" + tzlxname + "'," +
        			"'" + createuser + "'," +
        			"'" + createtime + "'," +
        			"'" + requestID + "'," +
        			"'" + cadgstz + "'," +
        			"'" + yszlsc + "'," +
        			"'" + diename + "'" +
    				")";
        	e.writeLog(sql);
            rs.executeSql(sql);
            rs.next();
            
            if(tzlxname.equals("配线图")){
            	//PDF
            	sql =  "Update DOCDETAIL set SECCATEGORY = '1324' , SUBCATEGORY = '1322' ,MAINCATEGORY = '1321'  where id = '"+ yszlsc +"' ";
            	e.writeLog("崇川配线图pdf：" + sql);
                rs.executeSql(sql);
                //CAD
                sql = "Update DOCDETAIL set SECCATEGORY = '1326' , SUBCATEGORY = '1323' ,MAINCATEGORY = '1321'  where id = '"+ cadgstz +"'";
            	e.writeLog("崇川配线图cad：" + sql);
                rs.executeSql(sql);
            }
            if(tzlxname.equals("打印图")){
            	//PDF
            	sql =  "Update DOCDETAIL set SECCATEGORY = '1325' , SUBCATEGORY = '1322' ,MAINCATEGORY = '1321'  where id = '"+ yszlsc +"' ";
            	e.writeLog("崇川打印图pdf：" + sql);
                rs.executeSql(sql);
                //CAD
                sql = "Update DOCDETAIL set SECCATEGORY = '1327' , SUBCATEGORY = '1323' ,MAINCATEGORY = '1321'  where id = '"+ cadgstz +"'";
            	e.writeLog("崇川打印图cad：" + sql);
                rs.executeSql(sql);
            }
            
        } catch (Exception var11) {
            BaseBean baseBean = new BaseBean();
            baseBean.writeLog("start log");
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("DrawingManagementInsertData_CC error:" + var11.getMessage());
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("end log");
        }
        return result;
    }
}

//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package weaver.interfaces.workflow.action;

import weaver.conn.RecordSet;
import weaver.conn.RecordSetDataSource;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.sap.ZMMI040;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

import java.security.interfaces.RSAMultiPrimePrivateCrtKey;
import java.text.SimpleDateFormat;
import java.util.Date;

public class tecdrme01 implements Action {
    public tecdrme01() {
    }

    public String execute(RequestInfo request) {
        String result ="1";
        try {
            //日志对象
            BaseBean e = new BaseBean();
            String requestID = request.getRequestid();
            e.writeLog(requestID);
    		Date d = new Date();
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    		String date = sdf.format(d);
            String sql = "";
            String sqr = "";
            String gcdm = "";//工厂代码
            String tzbh = "";//图纸编号
            String tzbb = "";//图纸版本
            String tzlx = "";//图纸类型
            String pkg = "";//封装外形大类
            String pkld = "";//封装外形
            String custid = "";//客户号
            String cppm = "";//品名描述
            String khpm = "";//客户品名
            String gcname = "";//工厂名
            String tzlxname = "";//图纸类型名
            String createuser = "";//创建人
            String createtime = "";//创建时间
            String cadgstz = "";//CAD格式图纸
            String yszlsc = "";//图纸、原始资料上传
            String diename = "";//芯片名称
            
            RecordSet rs = new RecordSet();
            sql ="SELECT * FROM formtable_main_91  WHERE REQUESTID = "+ requestID;
            rs.executeSql(sql);
            rs.next();
            gcdm = rs.getString("cq");
            tzbh = rs.getString("tzbh");
            tzbb = rs.getString("tzbb");
            tzlx = rs.getString("tzlx");
            pkg = rs.getString("pkg");
            pkld = rs.getString("pkld");
            custid = rs.getString("custid");
            cppm = rs.getString("cppm");
            khpm = rs.getString("khpm");
            cadgstz = rs.getString("cadgstz");
            yszlsc = rs.getString("yszlsc");
            diename = rs.getString("xpmc");
            
            sqr = rs.getString("sqr");
            sql ="SELECT loginid FROM hrmresource  WHERE id = "+ sqr;
            rs.executeSql(sql);
            rs.next();
            createuser = rs.getString("loginid");
            sql = "select * from workflow_selectitem where fieldid =( select id from workflow_billfield where billid='-91' and fieldname = 'cq')   and selectvalue ="+ gcdm;
            rs.executeSql(sql);
            rs.next();
            gcname = rs.getString("selectname");
            sql = "select * from workflow_selectitem where fieldid =( select id from workflow_billfield where billid='-91' and fieldname = 'tzlx')   and selectvalue ="+ tzlx;
            rs.executeSql(sql);
            rs.next();
            tzlxname = rs.getString("selectname");
            createtime = date;
        	sql = "insert into otecdrmedef(gcdm,tzbh,tzbb,tzlx,pkg,pkld,custid,matdesc,khpm,gcname,tzlxname,create_user,create_time,requestid,cadgstz,yszlsc,diename) values ("+
        			"'" + gcdm + "'," +
        			"'" + tzbh + "'," +
        			"'" + tzbb + "'," +
        			"'" + tzlx + "'," +
        			"'" + pkg + "'," +
        			"'" + pkld + "'," +
        			"'" + custid + "'," +
        			"'" + cppm + "'," +
        			"'" + khpm + "'," +
        			"'" + gcname + "'," +
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
        } catch (Exception var11) {
            BaseBean baseBean = new BaseBean();
            baseBean.writeLog("start log");
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("tecdrme01 error:" + var11.getMessage());
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("end log");
        }
        return result;
    }
}

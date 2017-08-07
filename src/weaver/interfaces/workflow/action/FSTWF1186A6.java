//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package weaver.interfaces.workflow.action;

import weaver.conn.RecordSet;
import weaver.conn.RecordSetDataSource;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.hrm.HrmUserVarify;
import weaver.interfaces.sap.ZMMI040;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

import java.security.interfaces.RSAMultiPrimePrivateCrtKey;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FSTWF1186A6 implements Action {
    public FSTWF1186A6() {
    }

    public String execute(RequestInfo request) {
        String result ="1";
        try {
            //日志对象
            BaseBean e = new BaseBean();
            String requestID = request.getRequestid();
            e.writeLog(requestID);
            String sql = "";
            RecordSet rs = new RecordSet();
            sql ="SELECT ID FROM formtable_main_78  WHERE REQUESTID = "+ requestID;
            rs.executeSql(sql);
            rs.next();
            String mainId  = rs.getString("id");
            String factory = rs.getString("plant");//工厂
            String custid = rs.getString("customer");//客户名
            sql = "SELECT * formtable_main_78_dt3  where mainid =  "+ mainId;
            rs.executeSql(sql);
            if(!rs.next()){
            	String idnrk = rs.getString("idnrk");//料号
                String invname = rs.getString("invname");//料号描述
                String menge = rs.getString("menge");//组件数量
                String lgort = rs.getString("lgort");//仓储地点
                
                sql = "select count(*) as s1 from obomsetmat where mat_id = " + idnrk + "and mat_desc = " +invname;
                rs.executeSql(sql);
                rs.next();
                if(rs.getInt("s1") == 0){
                	sql = "insert into obomsetmat ";
                	sql = "insert into obomsetmat(factory,cust_id,pkld_grp,pkld,pkld_com,oper_grp,mat_type,mat_id,mat_desc,qty_1,storage_location,mustfill_flag,create_time,create_user_id) values ("+
                			"'" + factory + "'," +
                			"'" + custid + "'," +
            				"' '," +
            				"' '," +
            				"' '," +
            				"' '," +
            				"' '," +
            				"'" + idnrk + "'," +
            				"'" + invname + "'," +
            				"'" + menge + "'," +
            				"'" + lgort + "'," +
            				"''," +
            				"''," +
            				"''" +
            				")";
                }
            }
        } catch (Exception var11) {
            BaseBean baseBean = new BaseBean();
            baseBean.writeLog("start log");
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("FSTWF1186A6 error:" + var11.getMessage());
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("end log");
        }

        return result;
    }
}

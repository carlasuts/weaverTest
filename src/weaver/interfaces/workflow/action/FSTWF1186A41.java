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

public class FSTWF1186A41 implements Action {
    public FSTWF1186A41() {
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
            sql = "update formtable_main_78_dt3 set operitemno =(case when operitemno_wire is not null then operitemno_wire  when operitemno_pack is not null then operitemno_pack else operitemno_tech end) where mainid =  "+ mainId;
            rs.executeSql(sql);
        } catch (Exception var11) {
            BaseBean baseBean = new BaseBean();
            baseBean.writeLog("start log");
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("FSTWF1186A41 error:" + var11.getMessage());
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("end log");
        }

        return result;
    }
}

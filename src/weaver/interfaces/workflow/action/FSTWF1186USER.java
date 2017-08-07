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
import weaver.hrm.User;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

import java.security.interfaces.RSAMultiPrimePrivateCrtKey;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FSTWF1186USER implements Action {
	public FSTWF1186USER() {
	}

	public String execute(RequestInfo request) {
        String result ="1";
        try {
            //日志对象
            BaseBean e = new BaseBean();
            String requestID = request.getRequestid();
            e.writeLog(requestID);
            String sql = "";
            String receivedpersonids = "";
            
            String resourceId = request.getLastoperator();
            RecordSet rs = new RecordSet();
            sql = "select resourceid from hrmrolemembers "
            		+ "where roleid =( select distinct  a.id from hrmroles  a , hrmrolemembers b   "
            							+ "	where b.roleid = a.id "
            							+ "and a.rolesmark = 'MDM_ASSY_ROUTER_HANDLER' "
            							+ "and b.resourceid = '"+ resourceId +"') ";
            rs.executeSql(sql);
            while(rs.next()){
            	if(!rs.getString("resourceid").equals(resourceId)){
                	receivedpersonids = receivedpersonids + rs.getString("resourceid") + ",";
            	}
            }
            sql = "update formtable_main_78 set djs = '"+ receivedpersonids +"' where requestid = '"+ requestID +"' ";
            rs.executeSql(sql);
            
        } catch (Exception var11) {
            BaseBean baseBean = new BaseBean();
            baseBean.writeLog("start log");
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("FSTWF1186USER error:" + var11.getMessage());
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("end log");
        }

        return result;
    }
}

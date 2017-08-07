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

public class TF158101 implements Action {
    public TF158101() {
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
            String cust_id = "";//客户号
            String idh = "";//ID号
            String bbh = "";//版本号
            String pmlist = "";//品名list
            String scwj = "";//文件ID
            String filerealpath = "";//存放路径
            String filename = "";//文件名
            RecordSet rs = new RecordSet();
            sql ="SELECT * FROM formtable_main_110  WHERE REQUESTID = "+ requestID;
            rs.executeSql(sql);
            rs.next();
            cust_id = rs.getString("custid");
            idh = rs.getString("dqidh");
            bbh = rs.getString("dqidbbh");
            pmlist = rs.getString("dqpmlist");
            scwj = rs.getString("scwj");
            sql = "select * from DOCIMAGEFILE where docid = '"+ scwj +"'";
            rs.executeSql(sql);
            rs.next();
            sql = "select * from IMAGEFILE where imagefileid = '"+ rs.getString("imagefileid") +"'";
            rs.executeSql(sql);
            rs.next();
            filerealpath = rs.getString("filerealpath");
            filename = rs.getString("IMAGEFILENAME");
            sql = "select * from owiptstpgm where id = '"+ idh +"'";
            rs.executeSql(sql);
            rs.next();
            if(!"".equals(rs.getString("id"))){
            	sql = "update owiptstpgm set mat_list = '"+ pmlist +"' , versionid = '"+ bbh +"',filerealpath = '"+ filerealpath +"',filename = '"+ filename +"' where id = '"+ idh +"'";
            	e.writeLog(sql);
            }else{
                sql = "insert into owiptstpgm(cust_id,mat_list,id,versionid,filerealpath,filename)values ("+
            			"'" + cust_id + "'," +
            			"'" + pmlist + "'," +
            			"'" + idh + "'," +
            			"'" + bbh + "'," +
            			"'" + filerealpath + "'," +
            			"'" + filename + "'" +
        				")";
                e.writeLog(sql);
            }
            rs.executeSql(sql);
        } catch (Exception var11) {
            BaseBean baseBean = new BaseBean();
            baseBean.writeLog("start log");
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("TF158101 error:" + var11.getMessage());
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("end log");
        }
        return result;
    }
}

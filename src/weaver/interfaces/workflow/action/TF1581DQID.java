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
import java.util.LinkedList;
import java.util.List;

public class TF1581DQID implements Action {
    public TF1581DQID() {
    }

    public String execute(RequestInfo request) {
        String result ="1";
        try {
            //日志对象
            BaseBean e = new BaseBean();
            String requestID = request.getRequestid();
            e.writeLog(requestID);
            String sql = "";
            String XZSQIDH = "";
            String XZBBH = "";
            String xzdypmlist = "";
            String ZJPMSRID = "";
            String ZJPMBBH = "";
            String 	zjpmdylist= "";
            String SBIDH = "";
            String SBIDBBH = "";
            String sbdypmlist = "";
            String ZHIDH = "";
            String ZHIDBBH = "";
            String ZHPMDYPMLIST = "";
            String newlist = "";
            
            RecordSet rs = new RecordSet();
            sql ="SELECT * FROM formtable_main_110  WHERE REQUESTID = "+ requestID;
            rs.executeSql(sql);
            rs.next();
            XZSQIDH = rs.getString("XZSQIDH");
            XZBBH = rs.getString("XZBBH");
            ZJPMSRID = rs.getString("ZJPMSRID");
            ZJPMBBH = rs.getString("ZJPMBBH");
            SBIDH = rs.getString("SBIDH");
            SBIDBBH = rs.getString("SBIDBBH"); 
            xzdypmlist = rs.getString("xzdypmlist"); 
            zjpmdylist = rs.getString("zjpmdylist"); 
            sbdypmlist = rs.getString("sbdypmlist"); 
            ZHIDH = rs.getString("ZHIDH");
            ZHIDBBH = rs.getString("ZHIDBBH");
            ZHPMDYPMLIST = rs.getString("ZHPMDYPMLIST");
            String[] zhlist = ZHPMDYPMLIST.split("\r<br>");
            if(XZSQIDH != ""){
            	sql = "update formtable_main_110 set dqidbbh = '"+ XZBBH +"', dqidh = '"+ XZSQIDH +"', dqpmlist = '"+ xzdypmlist +"' WHERE REQUESTID = "+ requestID;
            }
            if(ZJPMSRID != ""){
            	sql = "select * from (select *  from formtable_main_110 where dqidh = '"+ ZJPMSRID +"' order by dqidbbh desc nulls last) where rownum = 1 ";
                rs.executeSql(sql);
                rs.next();
                String pmlist = rs.getString("dqpmlist");
            	sql = "update formtable_main_110 set dqidbbh = '"+ ZJPMBBH +"', dqidh = '"+ ZJPMSRID +"', dqpmlist = '"+ pmlist + "\r\n" + "<br>" + zjpmdylist +"' WHERE REQUESTID = "+ requestID;
            }
            if(SBIDH != ""){
            	sql = "update formtable_main_110 set dqidbbh = '"+ SBIDBBH +"', dqidh = '"+ SBIDH +"', dqpmlist = '"+ sbdypmlist +"' WHERE REQUESTID = "+ requestID;
            }
            if(ZHIDH !=""){
            	sql = "select * from (select *  from formtable_main_110 where dqidh = '"+ ZHIDH +"' order by dqidbbh desc nulls last) where rownum = 1 ";
            	rs.executeSql(sql);
                rs.next();
                String pmlist = rs.getString("dqpmlist");
                String[] dqlist = pmlist.split("\r<br>");
                List<String> list = new LinkedList<String>();  
                for (String str1 : dqlist) {
                	if (!list.contains(str1)) 
                	{  
                		list.add(str1); 
                	}  
                }  
                
                for (String str2 : zhlist) {
                	if(list.contains(str2))
                	{
                		list.remove(str2);  
                	}  
                } 
                
                for(int i = 0 ; i < list.size(); i++){
                	if(i<list.size()-1){
                		newlist = newlist + list.get(i) + "\r\n" + "<br>";
                	}else if(i == list.size()-1){
                		newlist = newlist + list.get(i);
                	}
                }
                sql = "update formtable_main_110 set dqidbbh = '"+ ZHIDBBH +"', dqidh = '"+ ZHIDH +"', dqpmlist = '"+ newlist +"' WHERE REQUESTID = "+ requestID;
                e.writeLog(sql);
            }
            rs.executeSql(sql);
        } catch (Exception var11) {
            BaseBean baseBean = new BaseBean();
            baseBean.writeLog("start log");
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("TF1581DQID error:" + var11.getMessage());
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("end log");
        }

        return result;
    }
}

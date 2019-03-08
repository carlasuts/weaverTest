package weaver.interfaces.schedule;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;

import java.util.List;
import java.util.Map;

public class OAMESMIDDLE {
    public static void writerlog(List<Map<String,String>> loglist ,String tablename){
        String sql = "";
        RecordSet rs = new RecordSet();
        BaseBean bb = new BaseBean();
        for(int i=0;i<loglist.size();i++) {
            Map<String,String>  logmap = loglist.get(i);
            String filedString = "";
            String valueString = "";
            for (String key : logmap.keySet()) {
                filedString += key+",";
                valueString += "'"+logmap.get(key)+"',";
            }
            if(!"".equals(filedString)){
                filedString = " ("+ filedString.substring(0,filedString.length()-1)+")";
                valueString = " ("+ valueString.substring(0,valueString.length()-1)+")";
                sql = "insert into "+tablename+filedString+" values "+valueString;
                System.out.println(sql);
                bb.writeLog("sap插入日志sql",sql);
                rs.executeSql(sql);
            }else{
                return;
            }

        }
    }
    public static boolean insert(Map<String,String> map ,String tablename){
        String sql = "";
        String filedString = "";
        String valueString = "";
        RecordSet rs = new RecordSet();
        BaseBean baseBean = new BaseBean();

        for (String key : map.keySet()) {
            filedString += key+",";
            valueString += "'"+map.get(key)+"',";
        }
        if(!"".equals(filedString)){
            filedString = " ("+ filedString.substring(0,filedString.length()-1)+")";
            valueString = " ("+ valueString.substring(0,valueString.length()-1)+")";
            sql = "INSERT INTO " + tablename+filedString + " VALUES " + valueString;
            System.out.println(sql);
            baseBean.writeLog(sql);
            rs.executeSql(sql);
        }else{
            return false;
        }
        return true;
    }

    /**
     * 在插入中间表之前先判断一下中间表内之前是否存在，如果存在，直接更新，不存在则插入
     * @param map
     * @param tableName
     * @param id
     * @return
     */
    public static boolean insert1 (Map<String, String> map, String tableName, String id) {
        BaseBean baseBean = new BaseBean();
        RecordSet rs = new RecordSet();
        String sql = "";
        String field = "";
        String value = "";
        String newSql = " SET ";
        baseBean.writeLog("ID: " + id);
        sql = "SELECT * FROM CPYC_MIDDLE WHERE ID = '" + id + "'";
        rs.execute(sql);
        if (!rs.next()) {
            baseBean.writeLog("未查询到有相应的数据，进行插入操作。。。");
            for (String key: map.keySet()) {
                field += key + ",";
                value += "'" + map.get(key) + "',";
            }
            if(!"".equals(field)){
                field = " (" + field.substring(0,field.length()-1) + ")";
                value = " (" + value.substring(0,value.length()-1) + ")";
                sql = "INSERT INTO " + tableName + field +" VALUES "+ value;
                System.out.println(sql);
                baseBean.writeLog("插入sql语句: " + sql);
                rs.execute(sql);
            }else{
                return false;
            }
        } else {
            baseBean.writeLog("查询到有对应的数据，进行更新操作。。。");
            try {
                map.remove("ID");
                String updateSql = "UPDATE " + tableName;
                String whereSql = " WHERE iD = " + id;
                for (String key: map.keySet()) {
                    newSql = newSql + key + " = '" + map.get(key) + "',";
                }
                newSql  = newSql.substring(0, newSql.length() - 1);
                sql = updateSql + newSql + whereSql;
                baseBean.writeLog("更新sql语句: " + sql);
                rs.execute(sql);
            } catch (Exception e) {
                return false;
            }
        }
        return true;
    }

}

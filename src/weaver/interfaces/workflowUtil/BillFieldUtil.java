package weaver.interfaces.workflowUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import weaver.conn.RecordSet;
import weaver.general.Util;
import weaver.general.BaseBean;
import weaver.soa.workflow.request.*;

/**
 *
 * 类描述：字段名称工具�?创建者： 项目名称�?ecologyTest 创建时间�?2013-9-14 下午3:13:07 版本号： v1.0
 */
public class BillFieldUtil {


	/**
	 *
	 * 方法描述 : 获取字段的ID 创建者：ocean 项目名称�?ecologyTest 类名�?CwUtil.java 版本�?v1.0 创建时间�?
	 * 2013-9-14 下午3:05:53
	 *
	 * @param
	 *
	 * @param num
	 *            明细�?
	 * @return Map
	 */
	public static Map getFieldId(int formid, String num) {

		formid = Math.abs(formid);
		String sql = "";
		if ("0".equals(num)) {
			sql = "select b.id,fieldname,detailtable from workflow_billfield b ,workflow_base a where b.billid=-"
					+ formid
					+ " and a.formid=b.billid and  (detailtable is null or detailtable = '') ";
		} else {
			sql = "select b.id,fieldname,detailtable from workflow_billfield b ,workflow_base a where b.billid=-"
					+ formid
					+ " and a.formid=b.billid and detailtable='formtable_main_"
					+ formid + "_dt" + num + "'";
		}

		RecordSet rs = new RecordSet();
		rs.execute(sql);
		Map array = new HashMap();
		while (rs.next()) {
			array.put(
					Util.null2String(rs.getString("fieldname")).toLowerCase(),
					Util.null2String(rs.getString("id")));
		}
		return array;
	}

	/**
	 *
	 * 方法描述 : 获取表单建模字段的ID 创建者：ocean 项目名称�?ecologyTest 类名�?CwUtil.java 版本�?v1.0
	 * 创建时间�?2013-10-31 下午3:05:53
	 *
	 * @param formid
	 *            表单id
	 * @param num
	 *            明细�?
	 * @return Map
	 */
	public static Map getModeFieldId(int formid, String num) {

		formid = Math.abs(formid);
		String sql = "";
		if ("0".equals(num)) {
			sql = "select b.id,fieldname,detailtable from workflow_billfield b ,modeinfo a where b.billid=-"
					+ formid
					+ " and a.formid=b.billid and (detailtable is null or detailtable = '') ";
		} else {
			sql = "select b.id,fieldname,detailtable from workflow_billfield b ,modeinfo a where b.billid=-"
					+ formid
					+ " and a.formid=b.billid and detailtable='formtable_main_"
					+ formid + "_dt" + num + "'";
		}

		RecordSet rs = new RecordSet();
		rs.execute(sql);
		Map array = new HashMap();
		while (rs.next()) {
			array.put(
					Util.null2String(rs.getString("fieldname")).toLowerCase(),
					Util.null2String(rs.getString("id")));
		}
		return array;
	}

	/**
	 *
	 * @Title: getlabelId
	 * @Description: TODO
	 * @param @param name 数据库字段名�?
	 * @param @param formid 表单ID
	 * @param @param ismain 是否主表 0:主表 1：明细表
	 * @param @param num 明细表序�?
	 * @param @return
	 * @return String
	 * @throws
	 */
	public static String getlabelId(String name, String formid, String ismain,
									String num) {
		String id = "";
		String sql = "";
		if ("0".equals(ismain)) {
			sql = "select b.id,fieldname,detailtable from workflow_billfield b ,workflow_base a where b.billid=-"
					+ formid
					+ " and a.formid=b.billid and lower(fieldname)='"
					+ name + "'";
		} else {
			sql = "select b.id,fieldname,detailtable from workflow_billfield b ,workflow_base a where b.billid=-"
					+ formid
					+ " and a.formid=b.billid and detailtable='formtable_main_"
					+ formid
					+ "_dt"
					+ num
					+ "' and lower(fieldname)='"
					+ name
					+ "'";
		}
		// System.out.println(sql);
		RecordSet rs = new RecordSet();
		rs.execute(sql);
		rs.next();
		id = Util.null2String(rs.getString("id"));
		return id;

	}



	public static List<Map<String,String>> getDetailTable(RequestInfo request, int v){
		List<Map<String, String>> relist = new ArrayList<Map<String, String>>();
			DetailTable[] detailtable = request.getDetailTableInfo().getDetailTable();
			DetailTable dt = detailtable[v];
			Row[] s = dt.getRow();
			for (int j = 0; j < s.length; j++) {
				Map<String, String> map = new HashMap<String, String>();
				Row r = s[j];
				Cell c[] = r.getCell();
				for (int k = 0; k < c.length; k++) {
					Cell c1 = c[k];
					map.put(c1.getName().toLowerCase(), Util.null2String(c1.getValue()));
				}
				relist.add(map);
			}
		return relist;
	}

	public static Map<String,String> getMainTable(RequestInfo request){
		Property[] var12 = request.getMainTableInfo().getProperty();
		Map<String, String> map = new HashMap<String, String>();
		for (int rs = 0; rs < var12.length; ++rs) {
			map.put(var12[rs].getName().toLowerCase(), Util.null2String(var12[rs].getValue()));
		}
		return map;
	}

	public static String  getformid(String requestid,String workflowid){
		RecordSet rs = new RecordSet();
		int formid = 0;
		String sql ="";
		if(requestid!=null) {
			 sql = "select formid from workflow_requestbase a,workflow_base b where a.workflowid=b.id and a.requestid=" + requestid;
		}
		if(workflowid!=null){
			sql = "select formid from workflow_base b where b.id=" + workflowid;
		}
			rs.executeSql(sql);
			if (rs.next()) {
				if (rs.getInt("formid") < 0) {
					formid = rs.getInt("formid");
				}
			}


		return String.valueOf(formid);
	}

	public static String getMainTableName(String requestid,String workflowid){
	 String name =	getformid(requestid,workflowid);
		if(!"0".equals(name)){
			return  "formtable_main_"+name.substring(1,name.length());
		}
		return null;
	}

	public static String getDetailTableName(String requestid,String workflowid,int v){
		String name =	getMainTableName(requestid,workflowid);
		if(name!=null){
			return  name+"_dt"+v;
		}
		return null;
	}

	public static void insert(List<Map<String,String>> loglist ,String tablename){
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
				bb.writeLog("list执行的sql="+sql);
				rs.executeSql(sql);
			}else{
				return;
			}

		}
	}

	public static void insert(Map<String,String> logmap ,String tablename){
		String sql = "";
		RecordSet rs = new RecordSet();
		BaseBean bb = new BaseBean();
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
				bb.writeLog("list执行的sql="+sql);
				rs.executeSql(sql);
			}else{
				return;
			}


	}

	public static void update(List<Map<String,String>> loglist ,String tablename){
		String sql = "";
		RecordSet rs = new RecordSet();
		BaseBean bb = new BaseBean();
		for(int i=0;i<loglist.size();i++) {
			Map<String,String>  logmap = loglist.get(i);
			String sqlwhere = logmap.get("sqlwhere");
			if(sqlwhere==null){
				sqlwhere="";
				return;
			}else{
				logmap.remove("sqlwhere");
			}
			String filedString = "";
			for (String key : logmap.keySet()) {
				if(logmap.get(key).contains("@")){
					filedString += key + "=" + logmap.get(key).replaceAll("@","") + ",";
				}else {
					filedString += key + "='" + logmap.get(key) + "',";
				}
			}
			if(!"".equals(filedString)){
				filedString =  filedString.substring(0,filedString.length()-1);
				sql = "update  "+tablename+" set  "+filedString+" "+sqlwhere;
				bb.writeLog("list执行的sql="+sql);
				rs.executeSql(sql);
			}else{
				return;
			}

		}
	}

	public static void update(Map<String,String> logmap ,String tablename){
		String sql = "";
		RecordSet rs = new RecordSet();
		BaseBean bb = new BaseBean();

			String sqlwhere = logmap.get("sqlwhere");
			if(sqlwhere==null){
				sqlwhere="";
				return;
			}else{
				logmap.remove("sqlwhere");
			}
			String filedString = "";
		    for (String key : logmap.keySet()) {
			if(logmap.get(key).contains("@")){
				filedString += key + "=" + logmap.get(key).replaceAll("@","") + ",";
			}else {
				filedString += key + "='" + logmap.get(key) + "',";
			}
	    	}
			if(!"".equals(filedString)){
				filedString =  filedString.substring(0,filedString.length()-1);
				sql = "update  "+tablename+" set  "+filedString+" "+sqlwhere;
				bb.writeLog("list执行的sql="+sql);
				rs.executeSql(sql);
			}else{
				return;
			}
	}

	public String getDatasourceName(String workflowid,String fieldname,int v){
		String sql = "";
		String wheresql ="";
		RecordSet rs = new RecordSet();
		if(v!=0){
			wheresql = " and detailtable like '%"+v+"'";
		}
		sql="select b.* from workflow_base a right join workflow_billfield b on a.formid=b.billid where a.id="+workflowid+" and fieldname='"+fieldname+"' "+wheresql;
		rs.executeSql(sql);
		if(rs.next()){
			if(rs.getString("fielddbtype").split("\\.").length==2) {
				String fielddbtype = rs.getString("fielddbtype").split("\\.")[1];
				sql = "select datasourceid from datashowset where showname='" + fielddbtype + "'";
				rs.executeSql(sql);
				if(rs.next()){
					if(rs.getString("datasourceid").split("\\.").length==2){
						return  rs.getString("datasourceid").split("\\.")[1];
					}
				}
			}
		}
		return "error";
	}
}

package weaver.interfaces.sap;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;
import weaver.general.BaseBean;


import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2017/2/8.
 */
public class OAToSAP_ZKCG65 {
	private SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private JCO.Function jcoFunction = null;
	private JCO.Client sapconnection = null;
	private BaseBean bb = new BaseBean();
	private String logtablename;
	private String requestid ;
	private Map<String,String> maintable = null;
	public OAToSAP_ZKCG65(String tablename,String rid,Map<String,String> maintable){
		logtablename = tablename;
		requestid = rid;
		this.maintable = maintable;
		init();
	}

	private  void init(){
		JCO.Repository mRepository = null;
		sapconnection  = SapConnUtil.getconn();
		mRepository = new JCO.Repository("sap", sapconnection);
		IFunctionTemplate ft = mRepository.getFunctionTemplate("ZMMI065");
		jcoFunction = new JCO.Function(ft);
	}


	public  void ZWEE_MM65(List<Map<String,String>> dt) {
		bb.writeLog("dt---" + dt);
		List<Map<String,String>> loglist = new ArrayList<Map<String,String>>();
		JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_MM65");
	  for(Map<String,String> dtmap:dt){
			mytbl.appendRow();
			Map<String,String> logmap = new HashMap<String, String>();
			UUID uuid = UUID.randomUUID();
			System.out.println(uuid.toString().substring(0,32));
			setValue(mytbl,logmap,"800", "MANDT");
			setValue(mytbl,logmap,uuid.toString().substring(0,32), "Z_WEE_ID");
			setValue(mytbl,logmap,"11", "HEADID");
			setValue(mytbl,logmap,new Date(), "BLDAT");     //DieMaterialCode 芯片料号
			setValue(mytbl,logmap,new Date(), "BUDAT");
			setValue(mytbl,logmap,dtmap.get("SALES_ORDER".toLowerCase()), "KDAUF");
			setValue(mytbl,logmap,"555555", "KDPOS");
			setValue(mytbl,logmap,"11", "IT_HEADID");
			setValue(mytbl,logmap,dtmap.get("MATERIAL".toLowerCase()), "MATNR");
			setValue(mytbl,logmap,maintable.get("WAFER_MATERIAL".toLowerCase()), "MATNR_2");
			setValue(mytbl,logmap,dtmap.get("BATCH".toLowerCase()), "CHARG");
			setValue(mytbl,logmap,dtmap.get("STORAGE_LOCATION".toLowerCase()).split("_")[0], "WERKS");
			setValue(mytbl,logmap,dtmap.get("STORAGE_LOCATION".toLowerCase()).split("_")[1], "LGORT");
			setValue(mytbl,logmap,"11TF", "LGORT_2");
			setValue(mytbl,logmap,"100", "MENGE");
			setValue(mytbl,logmap,"EA", "MEINS");
			setValue(mytbl,logmap,"OA", "USNAM_MKPF");
			setValue(mytbl,logmap,"", "MBLNR");
			setValue(mytbl,logmap,"", "MJAHR");
			setValue(mytbl,logmap,"", "ZWEESTAUTS");

			logmap.put("REQUESTID",requestid);
			loglist.add(logmap);
		}
		bb.writeLog("开始执行-------");

		sapconnection.execute(jcoFunction);
		bb.writeLog("返回数据-------");
//获取返回数据
		JCO.Table datas = jcoFunction.getTableParameterList().getTable("RETURN");
		for (int i = 0; i < datas.getNumRows(); i++) {
			datas.setRow(i);
			/*bb.writeLog("MANDT:" + datas.getString("MANDT"));
			bb.writeLog("Z_WEE_ID:" + datas.getString("Z_WEE_ID") );
			bb.writeLog("TYPE:" + datas.getString("TYPE"));
			bb.writeLog("ID:" + datas.getString("ID"));
			bb.writeLog("NUMBER:" + datas.getString("NUMBER"));*/
			bb.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
		/*	bb.writeLog("MATNR:" + datas.getString("MATNR"));
			bb.writeLog("MAKTX:" + datas.getString("MAKTX"));*/
		}
	//	writelog(loglist);
	}

	private void setValue(JCO.Table mytb,Map<String,String> logmap,Object value ,String key ){
		if(value instanceof  Date){
			String datavalue = sd.format((Date)value);
			mytb.setValue((Date)value,key);
			logmap.put(key,datavalue);
			return;
		}
		mytb.setValue(value.toString(),key);
		logmap.put(key,value.toString());
	}

	private void writelog(List<Map<String,String>> loglist){
		SapLogWriter.writerlog(loglist,logtablename);
	}


}

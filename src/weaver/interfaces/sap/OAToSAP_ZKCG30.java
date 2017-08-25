package weaver.interfaces.sap;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;

import weaver.general.BaseBean;




import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2017/2/8.
 */
public class OAToSAP_ZKCG30 {
	private SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private JCO.Function jcoFunction = null;
	private JCO.Client sapconnection = null;
	private BaseBean bb = new BaseBean();
	private String logtablename;
	private String requestid ;
	private Map<String,String> maintable = null;
	public OAToSAP_ZKCG30(String tablename,String rid,Map<String,String> maintable){
		logtablename = tablename;
		requestid = rid;
		this.maintable = maintable;
		init();
	}

	private  void init(){
		JCO.Repository mRepository = null;
		sapconnection  = SapConnUtil.getconn();
		mRepository = new JCO.Repository("sap", sapconnection);
		IFunctionTemplate ft = mRepository.getFunctionTemplate("ZSDI030");
		jcoFunction = new JCO.Function(ft);
	}


	public  void ZWEE_SD30(List<Map<String,String>> dt) {
		List<Map<String,String>> loglist = new ArrayList<Map<String,String>>();
		JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_SD30");

		for(Map<String,String> dtmap:dt){
			mytbl.appendRow();
			Map<String,String> logmap = new HashMap<String, String>();
			UUID uuid = UUID.randomUUID();
			System.out.println(uuid.toString().substring(0,32));
			setValue(mytbl,logmap,"800", "MANDT");
			setValue(mytbl,logmap,uuid.toString().substring(0,32), "Z_WEE_ID");
			setValue(mytbl,logmap,"11", "HEADID");
			setValue(mytbl,logmap,"Z008", "AUART");
			setValue(mytbl,logmap,maintable.get("CUSTOMER".toLowerCase()), "KUNNR");
			setValue(mytbl,logmap,"1000", "VKORG");
			setValue(mytbl,logmap,"10", "VTWEG");
			setValue(mytbl,logmap,"01", "SPART");
			setValue(mytbl,logmap,"", "VKBUR");
			setValue(mytbl,logmap,"", "BZIRK");
			setValue(mytbl,logmap,"", "INCO1");
			setValue(mytbl,logmap,"", "INCO2");
			setValue(mytbl,logmap,"", "BSTKD");
			setValue(mytbl,logmap,"", "IT_HEADID");
			setValue(mytbl,logmap,"10", "POSNR");
			setValue(mytbl,logmap,maintable.get("MATERIAL".toLowerCase()), "MATNR");
			setValue(mytbl,logmap,dtmap.get("QTY".toLowerCase()), "KWMENG");
			setValue(mytbl,logmap,"", "ZZZXPWL");
			setValue(mytbl,logmap,dtmap.get("WAFER_LOT".toLowerCase()), "ZZZXPWLWF");
			setValue(mytbl,logmap,dtmap.get("FINAL_BATCH".toLowerCase()), "ZZCHARG");
			setValue(mytbl,logmap,"", "ZZLYDI");
			setValue(mytbl,logmap,"", "ZZZLBH");
			setValue(mytbl,logmap,"", "ZZRQDM");
			setValue(mytbl,logmap,"", "ZZYPH2");
			setValue(mytbl,logmap,"", "ZZYXJI");
			setValue(mytbl,logmap,"", "ZZFHDI");
			setValue(mytbl,logmap,"", "ZZMOHAO");
			setValue(mytbl,logmap,"", "ZZMOMS1");
			setValue(mytbl,logmap,"", "ZZMOMS2");
			setValue(mytbl,logmap,"", "ZZMOMS3");
			setValue(mytbl,logmap,"", "ZZCSCSBB");
			setValue(mytbl,logmap,"", "ZZJPSHU");
			setValue(mytbl,logmap,"", "ZZYZ01");
			setValue(mytbl,logmap,"", "ZZYZ02");
			setValue(mytbl,logmap,"", "ZZYZ03");
			setValue(mytbl,logmap,"", "ZZYZ04");
			setValue(mytbl,logmap,"", "ZZYZ05");
			setValue(mytbl,logmap,"", "ZZWDY01");
			setValue(mytbl,logmap,"", "ZZWDY02");
			setValue(mytbl,logmap,"", "ZZWDY03");
			setValue(mytbl,logmap,"", "ZZWDY04");
			setValue(mytbl,logmap,"", "ZZWDY05");
			setValue(mytbl,logmap,"", "ZZWDY06");
			setValue(mytbl,logmap,"", "ZZWDY07");
			setValue(mytbl,logmap,"", "ZZWDY08");
			setValue(mytbl,logmap,"", "ZZWDY09");
			setValue(mytbl,logmap,"", "ZZWDY10");
			setValue(mytbl,logmap,"", "ZZWDY11");
			setValue(mytbl,logmap,"", "ZZWDY12");
			setValue(mytbl,logmap,"", "ZZWDY13");
			setValue(mytbl,logmap,"", "ZZWDY14");
			setValue(mytbl,logmap,"", "ZZWDY15");
			setValue(mytbl,logmap,"1", "ZZYPSHU1");
			setValue(mytbl,logmap,"INK", "ZMAPKEY");
			setValue(mytbl,logmap,"", "ZZPJPS");
			setValue(mytbl,logmap,"", "ZZPYPH");
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
		/*	bb.writeLog("MANDT:" + datas.getString("MANDT"));
			bb.writeLog("Z_WEE_ID:" + datas.getString("Z_WEE_ID") );
			bb.writeLog("TYPE:" + datas.getString("TYPE"));
			bb.writeLog("ID:" + datas.getString("ID"));
			bb.writeLog("NUMBER:" + datas.getString("NUMBER"));*/
			bb.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
			/*bb.writeLog("MATNR:" + datas.getString("MATNR"));
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

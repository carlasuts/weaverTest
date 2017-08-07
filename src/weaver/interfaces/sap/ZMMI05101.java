package weaver.interfaces.sap;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

import java.text.SimpleDateFormat;
import java.util.*;

public class ZMMI05101 {
	private SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private JCO.Function jcoFunction = null;
	private JCO.Client sapconnection = null;
	private BaseBean baseBean = new BaseBean();
	private String logtablename = "ZMMI05101";

	public ZMMI05101() {
		init();
	}

	private void init() {
		JCO.Repository mRepository = null;
		sapconnection = SapConnUtil.getconn();
		mRepository = new JCO.Repository("sap", sapconnection);
		IFunctionTemplate ft = mRepository.getFunctionTemplate("ZMMI051");
		jcoFunction = new JCO.Function(ft);
	}

	// 工艺路线
	public void zmmi05101insert(DetailTable dt,MainTableInfo maintableinfo, String rid) {
		String requestid = rid;
		List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
		JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_MM51");
		BaseBean baseBean = new BaseBean();
        String MANDT = "800"; //集团 固定值 800
        String Z_WEE_ID = " ";
        String HEADID = "";//头部ID
        String MATNR = "";//物料号 
        String KLART = "";//类别种类
        String CLASS = "";//类号
        String IT_HEADID = "";//ITEM所属头部ID
        String CHARACT = "";//特征名称
        String VALUE = "";//特性值 
        String ATFOR = "";//特征值数据类型 
        
        
        String TOPMARTFORMATON="";//正面打印图号
        String BACKMARTFORMATON="";//背面打印图号
        String TESTCUSTOMERMTRLCODE ="";//测试客户品名
        
        String DIEATTACHTRAIT = ""; //装片特征
        String MARK1 = "";//MARK1
        String MARK2 = "";//MARK2
        String MARK3="";//MARK3
        String MARK4 ="";//MARK4
        
        String MARK5 = "";//MARK5
        String PACKAGEOUTLINE = "";//封装外形
        String OUTDEVICE = "";//包装品名
        String ASSYCUSTOMERMTRLCODE="";//客户品名
        String VEHICLE ="";//车载品 
        String PRODUCETYPE ="";//生产类型
        String WIREBONDDIAGNO ="";//配线图号
        
        java.util.Date date = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
		String updatetime = sdf.format(date);
		String createtime = sdf.format(date);
		
		Property[] Property = maintableinfo.getProperty();
		String id;
	
		for(int ss = 0; ss < Property.length; ++ss) {
            String dataDB = Property[ss].getName().toUpperCase();
            id = Util.null2String(Property[ss].getValue());

            if(dataDB.equals("PRODUCTMATERIALCODE1")) {
            	MATNR = id;
            }
            
            if(dataDB.equals("HEADID")) {
            	HEADID = id;
            }
            if(dataDB.equals("KLART")) {
            	KLART = id;
            }
           
            if(dataDB.equals("CLASS")) {
            	CLASS = id;
            }
            if(dataDB.equals("IT_HEADID")) {
            	IT_HEADID = id;
            }
            if(dataDB.equals("CHARACT")) {
            	CHARACT = id;
            }
            if(dataDB.equals("VALUE")) {
            	VALUE = id;
            }
            if(dataDB.equals("ATFOR")) {
            	ATFOR = id;
            }
            if(dataDB.equals("TOPMARTFORMATON")) {
            	TOPMARTFORMATON = id;
            }
            if(dataDB.equals("BACKMARTFORMATON")) {
            	BACKMARTFORMATON = id;
            }
            if(dataDB.equals("ASSYCUSTOMERMTRLCODE")) {
            	ASSYCUSTOMERMTRLCODE = id;
            }
            if(dataDB.equals("DIEATTACHTRAIT")) {
            	DIEATTACHTRAIT = id;
            }
            if(dataDB.equals("MARK1")) {
            	MARK1 = id;
            }
            if(dataDB.equals("MARK2")) {
            	MARK2 = id;
            }
            if(dataDB.equals("MARK3")) {
            	MARK3 = id;
            }
            if(dataDB.equals("MARK4")) {
            	MARK4 = id;
            }
            if(dataDB.equals("MARK5")) {
            	MARK5 = id;
            }
            if(dataDB.equals("PACKAGEOUTLINE")) {
            	PACKAGEOUTLINE = id;
            }
            if(dataDB.equals("OUTDEVICE")) {
            	OUTDEVICE = id;
            }
            if(dataDB.equals("TESTCUSTOMERMTRLCODE")) {
            	TESTCUSTOMERMTRLCODE = id;
            }
            if(dataDB.equals("VEHICLE")) {
            	VEHICLE = id;
            }
            if(dataDB.equals("PRODUCETYPE")) {
            	PRODUCETYPE = id;
            }
            if(dataDB.equals("WIREBONDDIAGNO")) {
            	WIREBONDDIAGNO = id;
            }
        }
		String[] HEADID_A ={"1002","2","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"} ;
        String[] HEADID_T ={"1001","1","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"} ;
        
        String[] KLART_AT ={"022","001"," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "} ;
        
        String[] CLASS_AT ={"Z_FERT_BCH","Z_FERT_MTL"," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "} ;
        
        String[] IT_HEADID_A ={"0","0","2","2","2","2","2","2","2","2","2","2","2","2","2","2","2","2","2"} ;
        
        String[] IT_HEADID_T ={"0","0","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1"} ;
        
        String[] CHARACT_AT ={" "," ","Z_DRAW_NO","Z_FD","Z_GD","Z_LEAD","Z_MAP","Z_MARK1","Z_MARK2","Z_MARK3","Z_MARK4","Z_MARK5","Z_PACKAGE","Z_PACK_TYPE","Z_PD","Z_PROD_ID","Z_PROD_TYPE","Z_TEST_PACK_NAME","Z_WIR_DIA_NO"} ;
        
        String[] VALUE_AT ={" "," ",TOPMARTFORMATON,TESTCUSTOMERMTRLCODE,DIEATTACHTRAIT,"0",DIEATTACHTRAIT,MARK1,MARK2,MARK3,MARK4,MARK5,PACKAGEOUTLINE,OUTDEVICE,ASSYCUSTOMERMTRLCODE,VEHICLE,PRODUCETYPE,OUTDEVICE,WIREBONDDIAGNO} ;
        String[] ATFOR_AT={" "," ","CHAR","CHAR","CHAR","CHAR","CHAR","CHAR","CHAR","CHAR","CHAR","CHAR","CHAR","CHAR","CHAR","CHAR","CHAR","CHAR","CHAR"};

			
			
			UUID uuid = UUID.randomUUID();
			System.out.println(uuid.toString().substring(0, 32));
			
				

					if(MATNR.substring(0,1).equals("A")){
						for(int i =0;i<19;i++){
							mytbl.appendRow();
					Map<String, String> logmap = new HashMap<String, String>();
					setValue(mytbl, logmap, MANDT, "MANDT");
					setValue(mytbl, logmap, uuid.toString().substring(0,32), "Z_WEE_ID");
					setValue(mytbl, logmap, " ", "ZWEESTAUTS");
					setValue(mytbl, logmap, HEADID_A[i], "HEADID");
					setValue(mytbl, logmap, MATNR, "MATNR");
					setValue(mytbl, logmap, KLART_AT[i], "KLART");
					setValue(mytbl, logmap, CLASS_AT[i], "CLASS");
					setValue(mytbl, logmap, IT_HEADID_A[i], "IT_HEADID");
					setValue(mytbl, logmap, CHARACT_AT[i], "CHARACT");
					setValue(mytbl, logmap, VALUE_AT[i], "VALUE");
					setValue(mytbl, logmap, ATFOR_AT[i], "ATFOR");
					logmap.put("REQUESTID",requestid);
					logmap.put("UPDATETIME",updatetime);
					logmap.put("CREATETIME",createtime);
					loglist.add(logmap);
					}
				}else if(MATNR.substring(0,1).equals("T")){
						for(int i =0;i<19;i++){
							mytbl.appendRow();
						Map<String, String> logmap = new HashMap<String, String>();
						setValue(mytbl, logmap, MANDT, "MANDT");
						setValue(mytbl, logmap, uuid.toString().substring(0,32), "Z_WEE_ID");
						setValue(mytbl, logmap, " ", "ZWEESTAUTS");
						setValue(mytbl, logmap, HEADID_T[i], "HEADID");
						setValue(mytbl, logmap, MATNR, "MATNR");
						setValue(mytbl, logmap, KLART_AT[i], "KLART");
						setValue(mytbl, logmap, CLASS_AT[i], "CLASS");
						setValue(mytbl, logmap, IT_HEADID_T[i], "IT_HEADID");
						setValue(mytbl, logmap, CHARACT_AT[i], "CHARACT");
						setValue(mytbl, logmap, VALUE_AT[i], "VALUE");
						setValue(mytbl, logmap, ATFOR_AT[i], "ATFOR");
						logmap.put("REQUESTID",requestid);
						logmap.put("UPDATETIME",updatetime);
						logmap.put("CREATETIME",createtime);
						loglist.add(logmap);
					}
				}
			String DIEMATERIALCODE ="";
			String CHIPQTY ="";
			String MAINCHIP="";
			String[] Z_AUX_CHIP_NO={"Z_AUX_CHIP1_NO","Z_AUX_CHIP2_NO","Z_AUX_CHIP3_NO","Z_AUX_CHIP4_NO","Z_AUX_CHIP5_NO"};
			String[] Z_AUX_CHIP_QTY={"Z_AUX_CHIP1_QTY","Z_AUX_CHIP2_QTY","Z_AUX_CHIP3_QTY","Z_AUX_CHIP4_QTY","Z_AUX_CHIP5_QTY"};
			 Row[] s = dt.getRow();
			
			 for (int j = 0; j < s.length; j++) {
				 int i =0;
		            Row r = s[j];// 指定行
		            Cell c[] = r.getCell();// 每行数据再按列存储
		            for (int k = 0; k < c.length; k++) {
		                Cell c1 = c[k];// 指定列
		                String name = c1.getName().toUpperCase();// 明细字段名称
		                String value = Util.null2String(c1.getValue());// 明细字段的值
		                if (name.equals("DIEMATERIALCODE")) {
		                	DIEMATERIALCODE = value;  
		                }
		                if (name.equals("CHIPQTY")) {
		                    CHIPQTY = value;
		                }
		                if (name.equals("MAINCHIP")) {
		                	MAINCHIP = value;
		                }

		            }
		            if(MAINCHIP=="0"){
		            	if(MATNR.substring(0,1).equals("A")){
		            		mytbl.appendRow();
		            		Map<String, String> logmap = new HashMap<String, String>();
							setValue(mytbl, logmap, MANDT, "MANDT");
							setValue(mytbl, logmap, uuid.toString().substring(0,32), "Z_WEE_ID");
							setValue(mytbl, logmap, " ", "ZWEESTAUTS");
							setValue(mytbl, logmap, "0", "HEADID");
							setValue(mytbl, logmap, MATNR, "MATNR");
							setValue(mytbl, logmap, " ", "KLART");
							setValue(mytbl, logmap, " ", "CLASS");
							setValue(mytbl, logmap, "2", "IT_HEADID");
							setValue(mytbl, logmap, "Z_MAIN_CHIP_NO", "CHARACT");
							setValue(mytbl, logmap, DIEMATERIALCODE, "VALUE");
							setValue(mytbl, logmap, "CHAR", "ATFOR");
							logmap.put("REQUESTID",requestid);
							logmap.put("UPDATETIME",updatetime);
							logmap.put("CREATETIME",createtime);
							loglist.add(logmap);
							mytbl.appendRow();
							Map<String, String> logmap1 = new HashMap<String, String>();
							setValue(mytbl, logmap1, MANDT, "MANDT");
							setValue(mytbl, logmap1, uuid.toString().substring(0,32), "Z_WEE_ID");
							setValue(mytbl, logmap1, " ", "ZWEESTAUTS");
							setValue(mytbl, logmap1, "0", "HEADID");
							setValue(mytbl, logmap1, MATNR, "MATNR");
							setValue(mytbl, logmap1, " ", "KLART");
							setValue(mytbl, logmap1, " ", "CLASS");
							setValue(mytbl, logmap1, "2", "IT_HEADID");
							setValue(mytbl, logmap1, "Z_MAIN_CHIP_QTY", "CHARACT");
							setValue(mytbl, logmap1, CHIPQTY, "VALUE");
							setValue(mytbl, logmap1, "CHAR", "ATFOR");
							logmap1.put("REQUESTID",requestid);
							logmap1.put("UPDATETIME",updatetime);
							logmap1.put("CREATETIME",createtime);
							loglist.add(logmap1);

						}else if(MATNR.substring(0,1).equals("T")){
							mytbl.appendRow();
							Map<String, String> logmap = new HashMap<String, String>();
						
							setValue(mytbl, logmap, MANDT, "MANDT");
							setValue(mytbl, logmap, uuid.toString().substring(0,32), "Z_WEE_ID");
							setValue(mytbl, logmap, " ", "ZWEESTAUTS");
							setValue(mytbl, logmap, "0", "HEADID");
							setValue(mytbl, logmap, MATNR, "MATNR");
							setValue(mytbl, logmap, " ", "KLART");
							setValue(mytbl, logmap, " ", "CLASS");
							setValue(mytbl, logmap, "1", "IT_HEADID");
							setValue(mytbl, logmap, "Z_MAIN_CHIP_NO", "CHARACT");
							setValue(mytbl, logmap, DIEMATERIALCODE, "VALUE");
							setValue(mytbl, logmap, "CHAR", "ATFOR");
							logmap.put("REQUESTID",requestid);
							logmap.put("UPDATETIME",updatetime);
							logmap.put("CREATETIME",createtime);
							loglist.add(logmap);
							mytbl.appendRow();
							Map<String, String> logmap1 = new HashMap<String, String>();
							setValue(mytbl, logmap1, MANDT, "MANDT");
							setValue(mytbl, logmap1, uuid.toString().substring(0,32), "Z_WEE_ID");
							setValue(mytbl, logmap1, " ", "ZWEESTAUTS");
							setValue(mytbl, logmap1, "0", "HEADID");
							setValue(mytbl, logmap1, MATNR, "MATNR");
							setValue(mytbl, logmap1, " ", "KLART");
							setValue(mytbl, logmap1, " ", "CLASS");
							setValue(mytbl, logmap1, "1", "IT_HEADID");
							setValue(mytbl, logmap1, "Z_MAIN_CHIP_QTY", "CHARACT");
							setValue(mytbl, logmap1, CHIPQTY, "VALUE");
							setValue(mytbl, logmap1, "CHAR", "ATFOR");
							logmap1.put("REQUESTID",requestid);
							logmap1.put("UPDATETIME",updatetime);
							logmap1.put("CREATETIME",createtime);
							loglist.add(logmap1);

						}
		            }else if(MAINCHIP=="1"){
		            	if(MATNR.substring(0,1).equals("A")){
		            		mytbl.appendRow();
		            		Map<String, String> logmap = new HashMap<String, String>();
							setValue(mytbl, logmap, MANDT, "MANDT");
							setValue(mytbl, logmap, uuid.toString().substring(0,32), "Z_WEE_ID");
							setValue(mytbl, logmap, " ", "ZWEESTAUTS");
							setValue(mytbl, logmap, "0", "HEADID");
							setValue(mytbl, logmap, MATNR, "MATNR");
							setValue(mytbl, logmap, " ", "KLART");
							setValue(mytbl, logmap, " ", "CLASS");
							setValue(mytbl, logmap, "2", "IT_HEADID");
							setValue(mytbl, logmap, Z_AUX_CHIP_NO[i],"CHARACT" );
							setValue(mytbl, logmap, DIEMATERIALCODE, "VALUE");
							setValue(mytbl, logmap, "CHAR", "ATFOR");
							logmap.put("REQUESTID",requestid);
							logmap.put("UPDATETIME",updatetime);
							logmap.put("CREATETIME",createtime);
							loglist.add(logmap);
							mytbl.appendRow();
							Map<String, String> logmap1 = new HashMap<String, String>();
							setValue(mytbl, logmap1, MANDT, "MANDT");
							setValue(mytbl, logmap1, uuid.toString().substring(0,32), "Z_WEE_ID");
							setValue(mytbl, logmap1, " ", "ZWEESTAUTS");
							setValue(mytbl, logmap1, "0", "HEADID");
							setValue(mytbl, logmap1, MATNR, "MATNR");
							setValue(mytbl, logmap1, " ", "KLART");
							setValue(mytbl, logmap1, " ", "CLASS");
							setValue(mytbl, logmap1, "2", "IT_HEADID");
							setValue(mytbl, logmap1, Z_AUX_CHIP_QTY[i], "CHARACT");
							setValue(mytbl, logmap1, CHIPQTY, "VALUE");
							setValue(mytbl, logmap1, "CHAR", "ATFOR");
							logmap1.put("REQUESTID",requestid);
							logmap1.put("UPDATETIME",updatetime);
							logmap1.put("CREATETIME",createtime);
							loglist.add(logmap1);

							i++;
						}else if(MATNR.substring(0,1).equals("T")){
							mytbl.appendRow();
							Map<String, String> logmap = new HashMap<String, String>();
							setValue(mytbl, logmap, MANDT, "MANDT");
							setValue(mytbl, logmap, uuid.toString().substring(0,32), "Z_WEE_ID");
							setValue(mytbl, logmap, " ", "ZWEESTAUTS");
							setValue(mytbl, logmap, "0", "HEADID");
							setValue(mytbl, logmap, MATNR, "MATNR");
							setValue(mytbl, logmap, " ", "KLART");
							setValue(mytbl, logmap, " ", "CLASS");
							setValue(mytbl, logmap, "1", "IT_HEADID");
							setValue(mytbl, logmap,  Z_AUX_CHIP_NO[i],"CHARACT");
							setValue(mytbl, logmap, DIEMATERIALCODE, "VALUE");
							setValue(mytbl, logmap, "CHAR", "ATFOR");
							logmap.put("REQUESTID",requestid);
							logmap.put("UPDATETIME",updatetime);
							logmap.put("CREATETIME",createtime);
							loglist.add(logmap);
							mytbl.appendRow();
							Map<String, String> logmap1 = new HashMap<String, String>();
							setValue(mytbl, logmap1, MANDT, "MANDT");
							setValue(mytbl, logmap1, uuid.toString().substring(0,32), "Z_WEE_ID");
							setValue(mytbl, logmap1, " ", "ZWEESTAUTS");
							setValue(mytbl, logmap1, "0", "HEADID");
							setValue(mytbl, logmap1, MATNR, "MATNR");
							setValue(mytbl, logmap1, " ", "KLART");
							setValue(mytbl, logmap1, " ", "CLASS");
							setValue(mytbl, logmap1, "1", "IT_HEADID");
							setValue(mytbl, logmap1, Z_AUX_CHIP_QTY[i],"CHARACT" );
							setValue(mytbl, logmap1, CHIPQTY, "VALUE");
							setValue(mytbl, logmap1, "CHAR", "ATFOR");
							logmap1.put("REQUESTID",requestid);
							logmap1.put("UPDATETIME",updatetime);
							logmap1.put("CREATETIME",createtime);
							loglist.add(logmap1);
							i++;
						}
		            }   
			 }
		System.out.println("开始执行-------");

		sapconnection.execute(jcoFunction);
		System.out.println("返回数据-------");
		
		// 获取返回数据
		JCO.Table datas = jcoFunction.getTableParameterList().getTable("RETURN");
		for (int i = 0; i < datas.getNumRows(); i++) {
			datas.setRow(i);
			baseBean.writeLog("MANDT:" + datas.getString("MANDT"));
			baseBean.writeLog("Z_WEE_ID:" + datas.getString("Z_WEE_ID"));
			baseBean.writeLog("MATNR:" + datas.getString("MATNR"));
			baseBean.writeLog("CLASS:" + datas.getString("CLASS"));
			baseBean.writeLog("TYPE:" + datas.getString("TYPE"));
			baseBean.writeLog("ID:" + datas.getString("ID"));
			baseBean.writeLog("NUMBER:" + datas.getString("NUMBER"));
			baseBean.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
            
		}
		writelog(loglist);
	}

	private void setValue(JCO.Table mytb, Map<String, String> logmap,
			Object value, String key) {
		if (value instanceof Date) {
			String datavalue = sd.format((Date) value);
			mytb.setValue((Date) value, key);
			logmap.put(key, datavalue);
			return;
		}
		mytb.setValue(value.toString(), key);
		logmap.put(key, value.toString());
	}

	private void writelog(List<Map<String, String>> loglist) {
		SapLogWriter.writerlog(loglist, logtablename);
	}

}

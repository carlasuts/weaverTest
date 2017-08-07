package weaver.interfaces.sap;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.JCO;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.*;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2017/2/8.
 */
public class ZMMI040 {
    private SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private JCO.Function jcoFunction = null;
    private JCO.Client sapconnection = null;
    private BaseBean bb = new BaseBean();
    private String logtablename;
    public ZMMI040(String tablename){
        logtablename = tablename;
        init();
    }

    private  void init(){
        JCO.Repository mRepository = null;
         sapconnection  = SapConnUtil.getconn();
        mRepository = new JCO.Repository("sap", sapconnection);
        IFunctionTemplate ft = mRepository.getFunctionTemplate("ZMMI040");
        jcoFunction = new JCO.Function(ft);
    }
   //芯片
    public  void xp(DetailTable dt,String rid) {
        String requestid = rid ;
        List<Map<String,String>> loglist = new ArrayList<Map<String,String>>();
        JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_MM40");
        String DieMaterialCode = "";
        String DieMaterialDescription = "";
        String MaterialGroup = "";
        Row[] s = dt.getRow();// 当前明细表的所有数据,按行存储
        for (int j = 0; j < s.length; j++) {
            Row r = s[j];// 指定行
            Cell c[] = r.getCell();// 每行数据再按列存储
            for (int k = 0; k < c.length; k++) {
                Cell c1 = c[k];// 指定列
                String name = c1.getName().toUpperCase();// 明细字段名称
                String value = Util.null2String(c1.getValue());// 明细字段的值
                if (name.equals("DIEMATERIALCODE")) {
                    DieMaterialCode = value;
                }
                if (name.equals("DIEMATERIADESCRIPTION")) {
                    DieMaterialDescription = value;
                }
                if (name.equals("MATERIALGROUP")) {
                    MaterialGroup = value;
                }
            }
            mytbl.appendRow();
            Map<String,String> logmap = new HashMap<String, String>();
            UUID uuid = UUID.randomUUID();
            System.out.println(uuid.toString().substring(0,32));
            setValue(mytbl,logmap,"800", "MANDT");
            setValue(mytbl,logmap,uuid.toString().substring(0,32), "Z_WEE_ID");
            setValue(mytbl,logmap,"", "ZWEESTAUTS");
            setValue(mytbl,logmap,DieMaterialCode, "MATNR");     //DieMaterialCode 芯片料号
            setValue(mytbl,logmap,DieMaterialDescription, "MAKTX");
            setValue(mytbl,logmap,"ZCUS", "MTART");
            setValue(mytbl,logmap,"M", "MBRSH");
            setValue(mytbl,logmap,"", "EXTWG");
            setValue(mytbl,logmap,"", "AWSLS");
            setValue(mytbl,logmap,"", "KTGRM");
            setValue(mytbl,logmap,MaterialGroup, "MATKL");
            setValue(mytbl,logmap,"", "MVGR1");
            setValue(mytbl,logmap,"", "MVGR2");
            setValue(mytbl,logmap,"", "MVGR3");
            setValue(mytbl,logmap,"0", "PEINH");
            setValue(mytbl,logmap,"", "EKALR");
            setValue(mytbl,logmap,"", "HKMAT");
            setValue(mytbl,logmap,"", "TAXM1");
            setValue(mytbl,logmap,"", "VERSG");
            setValue(mytbl,logmap,"", "VTWEG");
            setValue(mytbl,logmap,"", "VKORG");
            setValue(mytbl,logmap,"1010", "WERKS");
            setValue(mytbl,logmap,"", "DWERK");
            setValue(mytbl,logmap,"", "GROES");
            setValue(mytbl,logmap,"001", "DISPO");
            setValue(mytbl,logmap,"PD", "DISMM");
            setValue(mytbl,logmap,"", "FXHOR");
            setValue(mytbl,logmap,"EX", "DISLS");
            setValue(mytbl,logmap,"X", "BESKZ");
            setValue(mytbl,logmap,"0", "DZEIT");
            setValue(mytbl,logmap,"", "LGPRO");
            setValue(mytbl,logmap,"", "RGEKZ");
            setValue(mytbl,logmap,"000", "FHORI");
            setValue(mytbl,logmap,"", "STRGR");
            setValue(mytbl,logmap,"02", "MTVFP");
            setValue(mytbl,logmap,"", "VINT1");
            setValue(mytbl,logmap,"", "VINT2");
            setValue(mytbl,logmap,"", "VRMOD");
            setValue(mytbl,logmap,"2", "SBDKZ");
            setValue(mytbl,logmap,"", "PRCTR");
            setValue(mytbl,logmap,"", "UEETK");
            setValue(mytbl,logmap,"", "FEVOR");
            setValue(mytbl,logmap,"", "BKLAS");
            setValue(mytbl,logmap,"EA", "MEINS");
            setValue(mytbl,logmap,"", "SFCPF");
            setValue(mytbl,logmap,"", "LADGR");
            setValue(mytbl,logmap,"0", "UMREN");
            setValue(mytbl,logmap,"0", "UMREZ");
            setValue(mytbl,logmap,"0.000", "NTGEW");
            setValue(mytbl,logmap,"", "PRDHA");
            setValue(mytbl,logmap,"", "BISMT");
            setValue(mytbl,logmap,"0.000", "LOSGR");
            setValue(mytbl,logmap,"", "NORMT");
            setValue(mytbl,logmap,"", "NCOST");
            setValue(mytbl,logmap,"0.000", "BRGEW");
            setValue(mytbl,logmap,"", "ALTSL");
            setValue(mytbl,logmap,"", "HRKFT");
            setValue(mytbl,logmap,"", "MEINH");
            setValue(mytbl,logmap,"", "GEWEI");
            setValue(mytbl,logmap,"", "LGORT");
            setValue(mytbl,logmap,"", "SPART");
            setValue(mytbl,logmap,"", "TRAGR");
            setValue(mytbl,logmap,"0", "MHDRZ");
            setValue(mytbl,logmap,"0", "MHDHB");
            setValue(mytbl,logmap,"QM0002", "QMATA");
            setValue(mytbl,logmap,"", "ZQUERY");


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
            bb.writeLog("MANDT:" + datas.getString("MANDT"));
            bb.writeLog("Z_WEE_ID:" + datas.getString("Z_WEE_ID") );
            bb.writeLog("TYPE:" + datas.getString("TYPE"));
            bb.writeLog("ID:" + datas.getString("ID"));
            bb.writeLog("NUMBER:" + datas.getString("NUMBER"));
            bb.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
            bb.writeLog("MATNR:" + datas.getString("MATNR"));
            bb.writeLog("MAKTX:" + datas.getString("MAKTX"));
        }
        writelog(loglist);
    }
    //主数据
    public  void zsj(MainTableInfo maintableinfo,String rid){
        String ATType = "";
        String AssyStage = "";
        String TestStage = "";
        String ProductMaterialCode = "";
        String CustomerMtrlDescription = "";
        String Factory="";
        Property[] var12 = maintableinfo.getProperty();
        String requestid = rid ;
        String id;
        List<Map<String,String>> loglist = new ArrayList<Map<String,String>>();
        for(int rs = 0; rs < var12.length; ++rs) {
            rid = var12[rs].getName().toUpperCase();
            id = Util.null2String(var12[rs].getValue());
            if(rid.equals("ASSYSTAGE")) {
                AssyStage = id;
            }
            if(rid.equals("TESTSTAGE")) {
                TestStage = id;
            }
            if(rid.equals("PRODUCETYPE")) {
                ATType = id;
            }
            if(rid.equals("PRODUCTMATERIALCODE2")) {
                ProductMaterialCode = id;
            }
            if(rid.equals("CUSTOMERMTRLDESCRIPTION")) {
                CustomerMtrlDescription = id;
            }
            if(rid.equals("PLANT")) {
                Factory = id;
            }
        }
      if("0".equals(ATType)){
          ATType = "AT" ;
      }else{
          ATType = "AO" ;
      }

        String sql="";
        RecordSet rs = new RecordSet();
        JCO.Table mytbl = jcoFunction.getTableParameterList().getTable("ZWEE_MM40");

        String qb = TestStage;
        String LGPRO="";     //地点LGPRO
        String PRCTR="";     //利润中心PRCTR
        String WLLX="";      //物料类型
        String BKLAS="";     //评估级别
        String SBDKZ="";     //个别_汇集SBDKZ
        String SNSCSJ="";     //厂内生产时间
        String DW="";        //单位
        String DISPO="";    //MRP控制者

            if("ASSY".equals(Factory)){
                qb=AssyStage;
            }
            sql = "select * from OMATRULDEF where DISPO='"+qb+"'  and WBWLZ='"+Factory+"' and SCFS='"+ATType+"'";
            rs.executeSql(sql);
            if(rs.next()){
                LGPRO = rs.getString("LGPRO");
                PRCTR = "000000"+ rs.getString("PRCTR");
                WLLX = rs.getString("WLLX");
                BKLAS = rs.getString("BKLAS");
                SBDKZ = rs.getString("SBDKZ");
                SNSCSJ = rs.getString("SNSCSJ");
                DW = rs.getString("DW");
                DISPO = rs.getString("DISPO");
            }
            String[] DWERK = {"1010","1030"};
            for(String wderr :DWERK) {
                mytbl.appendRow();
                Map<String,String> logmap = new HashMap<String, String>();
                UUID uuid = UUID.randomUUID();
                String WEE_ID=uuid.toString().substring(0,32);
                setValue(mytbl,logmap,"800", "MANDT");
                setValue(mytbl,logmap,WEE_ID, "Z_WEE_ID");
                setValue(mytbl,logmap,"", "ZWEESTAUTS");
                setValue(mytbl,logmap,ProductMaterialCode, "MATNR");   
                setValue(mytbl,logmap,CustomerMtrlDescription, "MAKTX");
                setValue(mytbl,logmap,WLLX, "MTART");                  
                setValue(mytbl,logmap,"M", "MBRSH");            
                setValue(mytbl,logmap,Factory, "EXTWG");        
                setValue(mytbl,logmap,"000001", "AWSLS");       
                setValue(mytbl,logmap,"01", "KTGRM");           
                setValue(mytbl,logmap,"", "MATKL");             
                setValue(mytbl,logmap,"422", "MVGR1");          
                setValue(mytbl,logmap,"", "MVGR2");             
                setValue(mytbl,logmap,"", "MVGR3");             
                setValue(mytbl,logmap,"1", "PEINH");            
                setValue(mytbl,logmap,"X", "EKALR");            
                setValue(mytbl,logmap,"X", "HKMAT");            
                setValue(mytbl,logmap,"1", "TAXM1");            
                setValue(mytbl,logmap,"1", "VERSG");            
                setValue(mytbl,logmap,"10", "VTWEG");           
                setValue(mytbl,logmap,"1000", "VKORG");         
                setValue(mytbl,logmap,wderr, "WERKS");          
                setValue(mytbl,logmap,wderr, "DWERK");          
                setValue(mytbl,logmap,"", "GROES");             
                setValue(mytbl,logmap,DISPO, "DISPO");          
                setValue(mytbl,logmap,"P1", "DISMM");           
                setValue(mytbl,logmap,"3", "FXHOR");            
                setValue(mytbl,logmap,"EX", "DISLS");           
                setValue(mytbl,logmap,"X", "BESKZ");            
                setValue(mytbl,logmap,SNSCSJ, "DZEIT");         
                setValue(mytbl,logmap,LGPRO, "LGPRO");          
                setValue(mytbl,logmap,"", "RGEKZ");             
                setValue(mytbl,logmap,"000", "FHORI");          
                setValue(mytbl,logmap,"60", "STRGR");           
                setValue(mytbl,logmap,"02", "MTVFP");           
                setValue(mytbl,logmap,"30", "VINT1");           
                setValue(mytbl,logmap,"90", "VINT2");           
                setValue(mytbl,logmap,"2", "VRMOD");            
                setValue(mytbl,logmap,SBDKZ, "SBDKZ");          
                setValue(mytbl,logmap,PRCTR, "PRCTR");          
                setValue(mytbl,logmap,"", "UEETK");             
                setValue(mytbl,logmap,"110", "FEVOR");          
                setValue(mytbl,logmap,BKLAS, "BKLAS");          
                setValue(mytbl,logmap,"EA", "MEINS");           
                setValue(mytbl,logmap,"1011", "SFCPF");         
                setValue(mytbl,logmap,"0001", "LADGR");         
                setValue(mytbl,logmap,"0", "UMREN");            
                setValue(mytbl,logmap,"0", "UMREZ");            
                setValue(mytbl,logmap,"0.000", "NTGEW");        
                setValue(mytbl,logmap,"", "PRDHA");             
                setValue(mytbl,logmap,"", "BISMT");             
                setValue(mytbl,logmap,"0.000", "LOSGR");        
                setValue(mytbl,logmap,"", "NORMT");             
                setValue(mytbl,logmap,"", "NCOST");             
                setValue(mytbl,logmap,"0.000", "BRGEW");        
                setValue(mytbl,logmap,"", "ALTSL");             
                setValue(mytbl,logmap,"", "HRKFT");             
                setValue(mytbl,logmap,"", "MEINH");             
                setValue(mytbl,logmap,"", "GEWEI");             
                setValue(mytbl,logmap,"", "LGORT");             
                setValue(mytbl,logmap,"", "SPART");             
                setValue(mytbl,logmap,"", "TRAGR");             
                setValue(mytbl,logmap,"0", "MHDRZ");            
                setValue(mytbl,logmap,"0", "MHDHB");            
                setValue(mytbl,logmap,"", "QMATA");             
                setValue(mytbl,logmap,"", "ZQUERY");

                logmap.put("REQUESTID",requestid);
                loglist.add(logmap);
            }
            bb.writeLog("开始执行-------");

//            sapconnection.execute(jcoFunction);
//
//            bb.writeLog("返回数据-------");
////获取返回数据
//            JCO.Table datas = jcoFunction.getTableParameterList().getTable("RETURN");
//            for (int i = 0; i < datas.getNumRows(); i++) {
//                datas.setRow(i);
//                bb.writeLog("MANDT:" + datas.getString("MANDT"));
//                bb.writeLog("Z_WEE_ID:" + datas.getString("Z_WEE_ID"));
//                bb.writeLog("TYPE:" + datas.getString("TYPE"));
//                bb.writeLog("ID:" + datas.getString("ID"));
//                bb.writeLog("NUMBER:" + datas.getString("NUMBER"));
//                bb.writeLog("MESSAGE:" + datas.getString("MESSAGE"));
//                bb.writeLog("MATNR:" + datas.getString("MATNR"));
//                bb.writeLog("MAKTX:" + datas.getString("MAKTX"));
//            }

        writelog(loglist);

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

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

public class FSTWF1186LCBHT implements Action {
    public FSTWF1186LCBHT() {
    }

    public String execute(RequestInfo request) {
        String result ="1";
        try {
            //日志对象
            BaseBean e = new BaseBean();
            //获取流程主表信息对象
            MainTableInfo maintableinfo = request.getMainTableInfo();

            String sql = "";

            String rid;
            String id;
            String MaterialCode = "";
            String Customer = "";
            String ProductMaterialCode = "";
            Property[] var12 = maintableinfo.getProperty();
            for (int rs = 0; rs < var12.length; ++rs) {
                rid = var12[rs].getName().toUpperCase();
                id = Util.null2String(var12[rs].getValue());
                if (rid.equals("MATERIALCODE")) {
                    MaterialCode = id;
                }
                if (rid.equals("CUSTOMER")) {
                    Customer = id;
                }
                if (rid.equals("ProductMaterialCode".toUpperCase())) {
                    ProductMaterialCode = id;
                }
            }

            sql = "select count(*) as sl  from formtable_main_78 a left join workflow_requestbase b on  a.requestid=b.requestid where b.workflowid=1186 and Customer='" + Customer + "' and MaterialCode='" + MaterialCode + "' and (ProductMaterialCode is not null or ProductMaterialCode !='')";
//            RecordSetDataSource rsmis = new RecordSetDataSource("mesdb");
//            rsmis.executeSql("SELECT key_1 FROM MGCMTBLDAT WHERE TABLE_NAME='B@CUSTOMER' AND FACTORY='" + Customer + "'");
//            rsmis.next();
//            Customer = rsmis.getString("key_1");
            e.writeLog("ProductMaterialCode" + ProductMaterialCode);
            if ("".equals(ProductMaterialCode)) {
            RecordSet rs = new RecordSet();
            rs.executeSql(sql);
            rs.next();
            int bh = rs.getInt("sl");
            int fl = bh+1;//用于判断工艺路线代码
            int mi = bh+1;//用于判断产品物料号
            String lcbh = "";
            if (fl < 10) {
                if (MaterialCode.length() > 11) {
                    lcbh = "T" + Customer + MaterialCode.substring(0, 12) + "-" + fl;
                } else {
                    lcbh = "T" + Customer + MaterialCode;
                    for (int i = MaterialCode.length(); i < 12; i++) {
                        lcbh += "9";
                    }
                    lcbh += "-" + fl;
                }
            } else {
                String bhstr = fl + "";
                if (MaterialCode.length() > 11) {
                    lcbh = "T" + Customer + MaterialCode.substring(0, 11) + bhstr.substring(0, 1) + "-" + bhstr.substring(1, 2);
                } else {
    				lcbh = "T" + Customer + MaterialCode;
    				for (int i = MaterialCode.length(); i < 11; i++) {
    					lcbh += "9";
    				}
    				lcbh += bhstr.substring(0, 1)+ "-" +  bhstr.substring(1, 2);
    			}
            }
            String rcbh="T"+Customer+String.format("%04d", fl);
            //判断生成的工艺路线代码在mes是否已经存在
            RecordSetDataSource mesrs = new RecordSetDataSource("mesdb");
        	sql = "select count(*) as no from mwipflwdef where flow = '"+rcbh +"'";
            mesrs.executeSql(sql);
            mesrs.next();
            int rc = mesrs.getInt("no");
            boolean flag = false;
            while(flag != true){
            	if(rc != 0 ){
                	rcbh="T"+Customer+String.format("%04d", ++fl);
                	sql = "select count(*) as no from mwipflwdef where flow = '"+rcbh +"'";
                    mesrs.executeSql(sql);
                    mesrs.next();
                    rc = mesrs.getInt("no");
                    flag = false;
                }else{
                	flag = true;
                }
            }
            
            //判断生成的产品物料号在mes是否已经存在
            sql = "select count(*) as no1 from mwipmatdef where mat_id = '"+lcbh +"'";
            e.writeLog(sql);
            mesrs.executeSql(sql);
            mesrs.next();
            int pmc = mesrs.getInt("no1");
            boolean flag1 = false;
            while(flag1 != true){
            	if(pmc != 0 ){
            		++mi;
            		if (mi < 10) {
                        if (MaterialCode.length() > 11) {
                            lcbh = "T" + Customer + MaterialCode.substring(0, 12) + "-" + mi;
                        } else {
                            lcbh = "T" + Customer + MaterialCode;
                            for (int i = MaterialCode.length(); i < 12; i++) {
                                lcbh += "9";
                            }
                            lcbh += "-" + fl;
                        }
                    } else {
                        String bhstr = mi + "";
                        if (MaterialCode.length() > 11) {
                            lcbh = "T" + Customer + MaterialCode.substring(0, 11) + bhstr.substring(0, 1) + "-" + bhstr.substring(1, 2);
                        } else {
            				lcbh = "T" + Customer + MaterialCode;
            				for (int i = MaterialCode.length(); i < 11; i++) {
            					lcbh += "9";
            				}
            				lcbh += bhstr.substring(0, 1)+ "-" +  bhstr.substring(1, 2);
            			}
                    }
            		sql = "select count(*) as no1 from mwipmatdef where mat_id = '"+lcbh +"'";
            		mesrs.executeSql(sql);
                    mesrs.next();
                    pmc = mesrs.getInt("no1");
                    flag1 = false;
                }else{
                	flag1 = true;
                }
            }
            sql = "update formtable_main_78 set ProductMaterialCode='"+lcbh+"' , RouterCode='"+rcbh+"' where requestid="+request.getRequestid();
            e.writeLog(sql);
            
            rs.executeSql(sql);
        }


        } catch (Exception var11) {
            BaseBean baseBean = new BaseBean();
            baseBean.writeLog("start log");
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("FSTWF1186LCBHT error:" + var11.getMessage());
            baseBean.writeLog("------------------------------------------------------------------------");
            baseBean.writeLog("end log");
        }

        return result;
    }
}

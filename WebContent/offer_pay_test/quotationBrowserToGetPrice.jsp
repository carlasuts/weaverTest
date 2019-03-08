<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="weaver.general.Util,weaver.file.*,java.util.*,java.io.*" %>
<%@ page import="weaver.join.hrm.in.IHrmImportAdapt"%>
<%@ page import="weaver.file.*"%>
<%@ page import="weaver.general.Util,java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.join.hrm.in.IHrmImportProcess"%>
<%@ page import="weaver.join.hrm.in.processImpl.HrmImportProcess"%>
<%@ page import="weaver.general.StaticObj"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ExcelParse" class="weaver.file.ExcelParse" scope="page" />
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%
String sql = "";


String shape =  Util.null2String(request.getParameter("shape"));//外形
String producttype =  Util.null2String(request.getParameter("producttype"));//生产类型
String custid =  Util.null2String(request.getParameter("custid"));//客户号
String tradeway =  Util.null2String(request.getParameter("tradeway"));//贸易方式
String wirebondtype =  Util.null2String(request.getParameter("wirebondtype"));//键合丝种类
String wirediameter =  Util.null2String(request.getParameter("wirediameter"));//线径
String silk =  Util.null2String(request.getParameter("silk"));//丝数
String grind =  Util.null2String(request.getParameter("grind"));//磨片
String chipnumber =  Util.null2String(request.getParameter("chipnumber"));//芯片个数
String chipX =  Util.null2String(request.getParameter("chipX"));//芯片X
String chipY =  Util.null2String(request.getParameter("chipY"));//芯片Y
String mat =  Util.null2String(request.getParameter("mat"));//装片材料
String frametechnology =  Util.null2String(request.getParameter("frametechnology"));//框架工艺
String moldingcompound =  Util.null2String(request.getParameter("moldingcompound"));//塑封料
String other =  Util.null2String(request.getParameter("other"));//其他
String packageform =  Util.null2String(request.getParameter("packageform"));//包装形式
String packagegrade =  Util.null2String(request.getParameter("packagegrade"));//包装档次
String taping =  Util.null2String(request.getParameter("taping"));//TAPING
String tester =  Util.null2String(request.getParameter("tester"));//测试机型号
String manipulator =  Util.null2String(request.getParameter("manipulator"));//机械手
String quotationmethod =  Util.null2String(request.getParameter("quotationmethod"));//测试报价方式
String site =  Util.null2String(request.getParameter("site"));//测试site数
String testtime =  Util.null2String(request.getParameter("testtime"));//测试时间
String uphformula =  Util.null2String(request.getParameter("uphformula"));//UPH公式
String uph =  Util.null2String(request.getParameter("uph"));//UPH


		StringBuffer sb = new StringBuffer();
		BaseBean bs = new BaseBean();
	    BigDecimal CHIP_X_A = new BigDecimal(chipX);
	    BigDecimal CHIP_Y_B = new BigDecimal(chipY);
		bs.writeLog("producttype: " + producttype);

		BigDecimal chipnumber_no = new BigDecimal(chipnumber);
 		sql ="select  NAME,DIE_SIZE_X,DIE_SIZE_Y  from MD_SD_QTTN_PKG where name = '"+shape +"'"; 
		BigDecimal CHIP_X_C = new BigDecimal(0);
		BigDecimal CHIP_Y_D = new BigDecimal(0);
		rs.executeSql(sql);
		while(rs.next()){
			CHIP_X_C = (rs.getString("DIE_SIZE_X") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DIE_SIZE_X")));
			CHIP_Y_D = (rs.getString("DIE_SIZE_Y") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DIE_SIZE_Y")));
		}
		//规则
		BigDecimal base_grind =(CHIP_X_A.multiply(CHIP_Y_B)).divide(CHIP_X_C.multiply(CHIP_Y_D),4,BigDecimal.ROUND_HALF_UP);//磨片
		BigDecimal base_scrib =(CHIP_X_A.add(CHIP_Y_B)).divide(CHIP_X_C.add(CHIP_Y_D),4,BigDecimal.ROUND_HALF_UP);//划片
		BigDecimal base_Load =(CHIP_X_A.multiply(CHIP_Y_B)).divide(CHIP_X_C.multiply(CHIP_Y_D),4,BigDecimal.ROUND_HALF_UP);//装片
		bs.writeLog("base_grind"+base_grind+"  base_scrib"+base_scrib+  "   base_Load" +base_Load );
		//划片标准成本
		BigDecimal scrib_1 = new BigDecimal(0);
		BigDecimal scrib_2 = new BigDecimal(0);
		BigDecimal scrib_3 = new BigDecimal(0);
		BigDecimal scrib_4 = new BigDecimal(0);
		BigDecimal scrib_5 = new BigDecimal(0);
		BigDecimal scrib_6 = new BigDecimal(0);
		BigDecimal scrib_7 = new BigDecimal(0);

		sql ="SELECT  a.QTTN_PKG_FK,C.FULL_NAME,b.name,MATERIAL,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER,(MATERIAL+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) AS TOTAL FROM MD_SD_COST_DIE a left join MD_SD_MOUNTING_MTRL_SPEC b on A.MTRL_SPEC=B.ID left join MD_SD_COST_DIE_CAT c on A.COST_DIE_CAT_FK =C.ID   where QTTN_PKG_FK = '"+shape+"' AND C.FULL_NAME ='划片' ";
		rs.executeSql(sql);
		bs.writeLog("sql划片标准成本"+sql);
		while(rs.next()){
			 scrib_1 = (rs.getString("MATERIAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MATERIAL")));
			 scrib_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
			 scrib_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
			 scrib_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
			 scrib_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
			 scrib_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
			 scrib_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));
		}
		//划片实际成本
		BigDecimal scrib_actual_1 = new BigDecimal(0);
		BigDecimal scrib_actual_2 = new BigDecimal(0);
		BigDecimal scrib_actual_3 = new BigDecimal(0);
		BigDecimal scrib_actual_4 = new BigDecimal(0);
		BigDecimal scrib_actual_5 = new BigDecimal(0);
		BigDecimal scrib_actual_6 = new BigDecimal(0);
		BigDecimal scrib_actual_7 = new BigDecimal(0);
		if (!producttype.equals("TO")) {
			scrib_actual_1 = scrib_1.multiply(base_scrib).multiply(chipnumber_no);
			scrib_actual_2 = scrib_2.multiply(base_scrib).multiply(chipnumber_no);
			scrib_actual_3 = scrib_3.multiply(base_scrib).multiply(chipnumber_no);
			scrib_actual_4 = scrib_4.multiply(base_scrib).multiply(chipnumber_no);
			scrib_actual_5 = scrib_5.multiply(base_scrib).multiply(chipnumber_no);
			scrib_actual_6 = scrib_6.multiply(base_scrib).multiply(chipnumber_no);
			scrib_actual_7 = scrib_7.multiply(base_scrib).multiply(chipnumber_no);
		}
		
		//磨片标准成本
		BigDecimal grind_1 = new BigDecimal(0);
		BigDecimal grind_2 = new BigDecimal(0);
		BigDecimal grind_3 = new BigDecimal(0);
		BigDecimal grind_4 = new BigDecimal(0);
		BigDecimal grind_5 = new BigDecimal(0);
		BigDecimal grind_6 = new BigDecimal(0);
		BigDecimal grind_7 = new BigDecimal(0);
		//磨片实际成本
		BigDecimal grind_actual_1 = new BigDecimal(0);
		BigDecimal grind_actual_2 = new BigDecimal(0);
		BigDecimal grind_actual_3 = new BigDecimal(0);
		BigDecimal grind_actual_4 = new BigDecimal(0);
		BigDecimal grind_actual_5 = new BigDecimal(0);
		BigDecimal grind_actual_6 = new BigDecimal(0);
		BigDecimal grind_actual_7 = new BigDecimal(0);
		
		if (Integer.parseInt(grind) == 0) {
			sql ="SELECT  a.QTTN_PKG_FK,C.FULL_NAME,b.name,MATERIAL,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER,(MATERIAL+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) AS TOTAL FROM MD_SD_COST_DIE a left join MD_SD_MOUNTING_MTRL_SPEC b on A.MTRL_SPEC=B.ID left join MD_SD_COST_DIE_CAT c on A.COST_DIE_CAT_FK =C.ID   where QTTN_PKG_FK = '"+shape+"' AND C.FULL_NAME ='磨片' ";
			rs.executeSql(sql);
			bs.writeLog("sql磨片标准成本"+sql);
			while(rs.next()){
				 grind_1 = (rs.getString("MATERIAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MATERIAL")));
				 grind_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
				 grind_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
				 grind_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
				 grind_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				 grind_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
				 grind_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));
			}
			
			if(!producttype.equals("TO")) {
				grind_actual_1 = grind_1.multiply(base_grind).multiply(chipnumber_no);
				grind_actual_2 = grind_2.multiply(base_grind).multiply(chipnumber_no);
				grind_actual_3 = grind_3.multiply(base_grind).multiply(chipnumber_no);
				grind_actual_4 = grind_4.multiply(base_grind).multiply(chipnumber_no);
				grind_actual_5 = grind_5.multiply(base_grind).multiply(chipnumber_no);
				grind_actual_6 = grind_6.multiply(base_grind).multiply(chipnumber_no);
				grind_actual_7 = grind_7.multiply(base_grind).multiply(chipnumber_no);
			}
		}
		
		
		
		//装片标准成本
		BigDecimal Load_1 = new BigDecimal(0);
		BigDecimal Load_2 = new BigDecimal(0);
		BigDecimal Load_3 = new BigDecimal(0);
		BigDecimal Load_4 = new BigDecimal(0);
		BigDecimal Load_5 = new BigDecimal(0);
		BigDecimal Load_6 = new BigDecimal(0);
		BigDecimal Load_7 = new BigDecimal(0);

		sql ="SELECT  a.QTTN_PKG_FK,C.FULL_NAME,b.name,MATERIAL,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER,(MATERIAL+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) AS TOTAL FROM MD_SD_COST_DIE a left join MD_SD_MOUNTING_MTRL_SPEC b on A.MTRL_SPEC=B.ID left join MD_SD_COST_DIE_CAT c on A.COST_DIE_CAT_FK =C.ID   where QTTN_PKG_FK = '"+shape+"' AND C.FULL_NAME ='装片' and replace(b.name,' ','') ='"+mat+"'";
		bs.writeLog("sql装片标准成本"+sql);
		rs.executeSql(sql);
		while(rs.next()){
			 Load_1 = (rs.getString("MATERIAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MATERIAL")));
			 Load_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
			 Load_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
			 Load_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
			 Load_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
			 Load_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
			 Load_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));
		}
		//装片实际成本
		BigDecimal Load_actual_1 = new BigDecimal(0);
		BigDecimal Load_actual_2 = new BigDecimal(0);
		BigDecimal Load_actual_3 = new BigDecimal(0);
		BigDecimal Load_actual_4 = new BigDecimal(0);
		BigDecimal Load_actual_5 = new BigDecimal(0);
		BigDecimal Load_actual_6 = new BigDecimal(0);
		BigDecimal Load_actual_7 = new BigDecimal(0);
		if(!producttype.equals("TO")) {
			Load_actual_1 = Load_1.multiply(base_Load).multiply(chipnumber_no);
			Load_actual_2 = Load_2.multiply(base_Load).multiply(chipnumber_no);
			Load_actual_3 = Load_3.multiply(base_Load).multiply(chipnumber_no);
			Load_actual_4 = Load_4.multiply(base_Load).multiply(chipnumber_no);
			Load_actual_5 = Load_5.multiply(base_Load).multiply(chipnumber_no);
			Load_actual_6 = Load_6.multiply(base_Load).multiply(chipnumber_no);
			Load_actual_7 = Load_7.multiply(base_Load).multiply(chipnumber_no);
		}
		//芯片实际成本

		
		
		// 装片其他费用
		BigDecimal Load_other_2 = new BigDecimal(0);
		BigDecimal Load_other_3 = new BigDecimal(0);
		BigDecimal Load_other_4 = new BigDecimal(0);
		BigDecimal Load_other_5 = new BigDecimal(0);
		BigDecimal Load_other_6 = new BigDecimal(0);
		BigDecimal Load_other_7 = new BigDecimal(0);

		sql ="select a.QTTN_PKG_FK,b.name,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER,(MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) AS TOTAL  from MD_SD_FRM_PKG a left join MD_SD_FRAME b on A.FRAME_FK = b.id where QTTN_PKG_FK ='"+shape+"'";
		bs.writeLog("sql装片其他费用"+sql);
		rs.executeSql(sql);
		while(rs.next()){
			 Load_other_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
			 Load_other_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
			 Load_other_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
			 Load_other_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
			 Load_other_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
			 Load_other_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));
		}
		BigDecimal Load_other_true_2 = new BigDecimal(0);
		BigDecimal Load_other_true_3 = new BigDecimal(0);
		BigDecimal Load_other_true_4 = new BigDecimal(0);
		BigDecimal Load_other_true_5 = new BigDecimal(0);
		BigDecimal Load_other_true_6 = new BigDecimal(0);
		BigDecimal Load_other_true_7 = new BigDecimal(0);
		if(!producttype.equals("TO")) {
			Load_other_true_2 = Load_other_2.multiply(chipnumber_no);
			Load_other_true_3 = Load_other_3.multiply(chipnumber_no);
			Load_other_true_4 = Load_other_4.multiply(chipnumber_no);
			Load_other_true_5 = Load_other_5.multiply(chipnumber_no);
			Load_other_true_6 = Load_other_6.multiply(chipnumber_no);
			Load_other_true_7 = Load_other_7.multiply(chipnumber_no);
		}


		//成本1 = 装片+磨片+划片
		BigDecimal cost_of_one =scrib_actual_7.add(grind_actual_7).add(Load_actual_7);
		bs.writeLog(" 成本1   cost_of_one" + cost_of_one);
		
		//成本2 = 装片其他费用
		BigDecimal cost_of_two =Load_other_true_7;
		bs.writeLog(" 成本2   cost_of_two" + cost_of_two);

		//键合费用
		//单价设定
		BigDecimal current_price_bonding = new BigDecimal(0);
		BigDecimal price_step_bonding = new BigDecimal(0);
		BigDecimal price_diff_bonding = new BigDecimal(0);

		sql ="select A.PIRCE,a.PIRCE_STEP,a.PIRCE_DIFF from MD_SD_WIRE_UNIT_PIRCE a left join md_sd_wire b on A.WIRE_FK=B.ID left join MD_SD_WIRE_DIAM c on A.WIRE_DIAM_FK =c.id where b.name ='"+wirebondtype+"'  and c.full_name = '"+ wirediameter +"UM'";
			rs.executeSql(sql);
			bs.writeLog("sql键合费用单价设定"+sql);
			while(rs.next()){
				 current_price_bonding = (rs.getString("PIRCE") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("PIRCE")));//单价当前价格
				 price_step_bonding = (rs.getString("PIRCE_STEP") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("PIRCE_STEP")));//步长
				 price_diff_bonding = (rs.getString("PIRCE_DIFF") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("PIRCE_DIFF")));//价差
			}
		////键合丝种类设置 取值
		BigDecimal current_price_category = new BigDecimal(0);
		BigDecimal price_category = new BigDecimal(0);

		sql ="SELECT name,PIRCE,CURRENT_PIRCE FROM MD_SD_WIRE  where name = '"+ wirebondtype +"'";
			rs.executeSql(sql);
			bs.writeLog("sql键合丝种类设置"+sql);
			while(rs.next()){
				 current_price_category = (rs.getString("CURRENT_PIRCE") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("CURRENT_PIRCE")));//类别当前价格
				 price_category = (rs.getString("PIRCE") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("PIRCE")));//类别价格
			}
		//外形键丝设定   取值 单丝长度 标准丝数
		BigDecimal wire_length = new BigDecimal(0);
		BigDecimal wire_qty = new BigDecimal(0);

		sql = "select  ID,name,WIRE_LENGTH,WIRE_QTY from MD_SD_QTTN_PKG where id='"+ shape +"'";
		bs.writeLog("sql外形键丝设定   取值 单丝长度 标准丝数"+sql);
			rs.executeSql(sql);
			while(rs.next()){
				 wire_length = (rs.getString("WIRE_LENGTH") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("WIRE_LENGTH")));//单丝长度
				 wire_qty = (rs.getString("WIRE_QTY") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("WIRE_QTY")));//标准丝数
			}
 		//键合材料成本
 		BigDecimal silk_standard = new BigDecimal(silk);//丝数
		BigDecimal bonding_mat_cost = new BigDecimal(0);
		if(!producttype.equals("TO")) {
			bonding_mat_cost =current_price_bonding.add((current_price_category.subtract(price_category)).divide(price_step_bonding,4,BigDecimal.ROUND_HALF_UP).multiply(price_diff_bonding)).multiply(wire_length).multiply(silk_standard);
		}

 		//键合标准工费 
 		BigDecimal bonded_labour_fee_1 = new BigDecimal(0);
 		BigDecimal bonded_labour_fee_2 = new BigDecimal(0);
 		BigDecimal bonded_labour_fee_3 = new BigDecimal(0);
 		BigDecimal bonded_labour_fee_4 = new BigDecimal(0);
 		BigDecimal bonded_labour_fee_5 = new BigDecimal(0);
 		BigDecimal bonded_labour_fee_6 = new BigDecimal(0);
 		BigDecimal bonded_labour_fee_7 = new BigDecimal(0);
 		 
 		sql ="select b.name,a.QTTN_PKG_FK,MTRL_COST,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER,(MTRL_COST+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) as TOTAL from MD_SD_COST_WIRE a left join md_sd_wire b on A.WIRE_FK =B.ID where QTTN_PKG_FK ='"+ shape +"' and name='"+ wirebondtype +"'";
 		bs.writeLog("sql键合标准工费"+sql);
			rs.executeSql(sql);
			while(rs.next()){

				 bonded_labour_fee_1 = (rs.getString("MTRL_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MTRL_COST")));
				 bonded_labour_fee_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
				 bonded_labour_fee_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
				 bonded_labour_fee_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
				 bonded_labour_fee_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				 bonded_labour_fee_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
				 bonded_labour_fee_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));
			}
		//键合实际工费
				BigDecimal bonded_labour_true_1 = new BigDecimal(0);
				BigDecimal bonded_labour_true_2 = new BigDecimal(0);
				BigDecimal bonded_labour_true_3 = new BigDecimal(0);
				BigDecimal bonded_labour_true_4 = new BigDecimal(0);
				BigDecimal bonded_labour_true_5 = new BigDecimal(0);
				BigDecimal bonded_labour_true_6 = new BigDecimal(0);
				BigDecimal bonded_labour_true_7 = new BigDecimal(0);
				if(!producttype.equals("TO")) {
					bonded_labour_true_1 = bonded_labour_fee_1.divide(wire_qty,4,BigDecimal.ROUND_HALF_UP).multiply(silk_standard);
					bonded_labour_true_2 = bonded_labour_fee_2.divide(wire_qty,4,BigDecimal.ROUND_HALF_UP).multiply(silk_standard);
					bonded_labour_true_3 = bonded_labour_fee_3.divide(wire_qty,4,BigDecimal.ROUND_HALF_UP).multiply(silk_standard);
					bonded_labour_true_4 = bonded_labour_fee_4.divide(wire_qty,4,BigDecimal.ROUND_HALF_UP).multiply(silk_standard);
					bonded_labour_true_5 = bonded_labour_fee_5.divide(wire_qty,4,BigDecimal.ROUND_HALF_UP).multiply(silk_standard);
					bonded_labour_true_6 = bonded_labour_fee_6.divide(wire_qty,4,BigDecimal.ROUND_HALF_UP).multiply(silk_standard);
					bonded_labour_true_7 = bonded_labour_fee_7.divide(wire_qty,4,BigDecimal.ROUND_HALF_UP).multiply(silk_standard);
				}

		//键合成本
		BigDecimal  bonding_cost =  bonding_mat_cost.add(bonded_labour_true_7);

		//销售方式材料价格影响系数
		sql ="select b.FULL_NAME,A.RATE,C.NAME from MD_SD_TRDTYP_MTRL_COST_RATE a left join MD_TRADE_TYPE b on A.TRADE_TYPE_FK =b.id left join MD_SD_COST_ELEMENT c on A.COST_ELEMENT_FK =C.ID  where  b.FULL_NAME = '" +tradeway+"'"; 
		BigDecimal rate_emat = new BigDecimal(1);//塑封料 系数
		BigDecimal rate_ftech = new BigDecimal(1);//框架工艺 系数
		rs.executeSql(sql);
		while(rs.next()){
			String NAME = rs.getString("NAME");
			if(NAME.equals("塑封料")){
				rate_emat =(rs.getString("RATE") == "" ? new BigDecimal(1) : new BigDecimal(rs.getString("RATE")));
			} else if(NAME.equals("框架工艺")){
				rate_ftech =(rs.getString("RATE") == "" ? new BigDecimal(1) : new BigDecimal(rs.getString("RATE")));
			}

			bs.writeLog("sql  NAME"+NAME);
			bs.writeLog("sql框架工艺系数"+rate_emat);
			bs.writeLog("sql框架工艺系数"+rate_ftech);
		}
			
		//组装其他费用
		//框架工艺
		BigDecimal frametechnology_fees_1 = new BigDecimal(0);
		BigDecimal frametechnology_fees_2 = new BigDecimal(0);
		BigDecimal frametechnology_fees_3 = new BigDecimal(0);
		BigDecimal frametechnology_fees_4 = new BigDecimal(0);
		BigDecimal frametechnology_fees_5 = new BigDecimal(0);
		BigDecimal frametechnology_fees_6 = new BigDecimal(0);
		BigDecimal frametechnology_fees_7 = new BigDecimal(0);

		sql ="select b.name,B.QTTN_PKG_FK,A.FULL_NAME,A.NAME,A.SORT,A.CURRENCY_FK, MATERIALCOST,MAINTENANCE_COST,UC,LABOUR,POWER,DEPR,OTHER,(MATERIALCOST+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) as TOTAL from MD_SD_COST_ASSY_OTHER_OPTION a left join  MD_SD_COST_ASSY_OTHER b on a.COST_ASSY_OTHER_FK =b.id where QTTN_PKG_FK ='"+ shape +"'  and replace(replace(a.full_name,('||'),''),' ','') ='"+frametechnology+"'";
		bs.writeLog("sql框架工艺"+sql);
			rs.executeSql(sql);
			while(rs.next()){
				 frametechnology_fees_1 = (rs.getString("MATERIALCOST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MATERIALCOST")));
				 frametechnology_fees_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
				 frametechnology_fees_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
				 frametechnology_fees_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
				 frametechnology_fees_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				 frametechnology_fees_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
				 frametechnology_fees_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));

			}
			BigDecimal frametechnology_ftech_true = new BigDecimal(0);
			if(!producttype.equals("TO")) {
				frametechnology_ftech_true = frametechnology_fees_1.multiply(rate_ftech);
			}
			BigDecimal frametechnology_fees_total =frametechnology_ftech_true.add(frametechnology_fees_2).add(frametechnology_fees_3).add(frametechnology_fees_4).add(frametechnology_fees_5).add(frametechnology_fees_6);

		//塑封料
		BigDecimal moldingcompound_fees_1 = new BigDecimal(0);
		BigDecimal moldingcompound_fees_2 = new BigDecimal(0);
		BigDecimal moldingcompound_fees_3 = new BigDecimal(0);
		BigDecimal moldingcompound_fees_4 = new BigDecimal(0);
		BigDecimal moldingcompound_fees_5 = new BigDecimal(0);
		BigDecimal moldingcompound_fees_6 = new BigDecimal(0);
		BigDecimal moldingcompound_fees_7 = new BigDecimal(0);

		sql ="select b.name,B.QTTN_PKG_FK,A.FULL_NAME,A.NAME,A.SORT,A.CURRENCY_FK, MATERIALCOST,MAINTENANCE_COST,UC,LABOUR,POWER,DEPR,OTHER,(MATERIALCOST+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) as TOTAL from MD_SD_COST_ASSY_OTHER_OPTION a left join  MD_SD_COST_ASSY_OTHER b on a.COST_ASSY_OTHER_FK =b.id where QTTN_PKG_FK ='"+ shape +"'  and a.FULL_NAME ='"+moldingcompound+"'";
			rs.executeSql(sql);
			bs.writeLog("sql塑封料"+sql);
			while(rs.next()){
				 moldingcompound_fees_1 = (rs.getString("MATERIALCOST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MATERIALCOST")));
				 moldingcompound_fees_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
				 moldingcompound_fees_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
				 moldingcompound_fees_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
				 moldingcompound_fees_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				 moldingcompound_fees_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
				 moldingcompound_fees_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));

			}
			BigDecimal moldingcompound_mat_true = new BigDecimal(0);
			if(!producttype.equals("TO")) {
				moldingcompound_mat_true = moldingcompound_fees_1.multiply(rate_emat);
			}
			BigDecimal moldingcompound_fees_total =moldingcompound_mat_true.add(moldingcompound_fees_2).add(moldingcompound_fees_3).add(moldingcompound_fees_4).add(moldingcompound_fees_5).add(moldingcompound_fees_6);

		//其他
		BigDecimal other_fees_1 = new BigDecimal(0);
		BigDecimal other_fees_2 = new BigDecimal(0);
		BigDecimal other_fees_3 = new BigDecimal(0);
		BigDecimal other_fees_4 = new BigDecimal(0);
		BigDecimal other_fees_5 = new BigDecimal(0);
		BigDecimal other_fees_6 = new BigDecimal(0);
		BigDecimal other_fees_7 = new BigDecimal(0);

		sql ="select b.name,B.QTTN_PKG_FK,A.FULL_NAME,A.NAME,A.SORT,A.CURRENCY_FK, MATERIALCOST,MAINTENANCE_COST,UC,LABOUR,POWER,DEPR,OTHER,(MATERIALCOST+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) as TOTAL from MD_SD_COST_ASSY_OTHER_OPTION a left join  MD_SD_COST_ASSY_OTHER b on a.COST_ASSY_OTHER_FK =b.id where QTTN_PKG_FK ='"+ shape +"'  and a.NAME ='"+other+"'";
		bs.writeLog("sql其他"+sql);
			rs.executeSql(sql);
			while(rs.next()){
				 other_fees_1 = (rs.getString("MATERIALCOST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MATERIALCOST")));
				 other_fees_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
				 other_fees_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
				 other_fees_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
				 other_fees_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				 other_fees_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
				 other_fees_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));

			}
		//打印
		BigDecimal print_fees_1 = new BigDecimal(0);
		BigDecimal print_fees_2 = new BigDecimal(0);
		BigDecimal print_fees_3 = new BigDecimal(0);
		BigDecimal print_fees_4 = new BigDecimal(0);
		BigDecimal print_fees_5 = new BigDecimal(0);
		BigDecimal print_fees_6 = new BigDecimal(0);
		BigDecimal print_fees_7 = new BigDecimal(0);

		if(!producttype.equals("TO")) {
			sql ="select b.name,B.QTTN_PKG_FK,A.FULL_NAME,A.NAME,A.SORT,A.CURRENCY_FK, MATERIALCOST,MAINTENANCE_COST,UC,LABOUR,POWER,DEPR,OTHER,(MATERIALCOST+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) as TOTAL from MD_SD_COST_ASSY_OTHER_OPTION a left join  MD_SD_COST_ASSY_OTHER b on a.COST_ASSY_OTHER_FK =b.id where QTTN_PKG_FK ='"+ shape +"'  and a.NAME ='打印'";
			bs.writeLog("sql打印"+sql);
			rs.executeSql(sql);
			while(rs.next()){
				print_fees_1 = (rs.getString("MATERIALCOST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MATERIALCOST")));
				print_fees_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
				print_fees_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
				print_fees_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
				print_fees_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				print_fees_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
				print_fees_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));

			}
		}
	

		//组装 各项金额
		BigDecimal assembly_mat_cost =scrib_actual_1.add(grind_actual_1).add(Load_actual_1).add(bonding_mat_cost).add(bonded_labour_true_1).add(frametechnology_ftech_true).add(moldingcompound_mat_true).add(other_fees_1);//组装材料费用
		bs.writeLog("scrib_actual_1: " + scrib_actual_1);
		bs.writeLog("grind_actual_1: " + grind_actual_1);
		bs.writeLog("Load_actual_1: " + Load_actual_1);
		bs.writeLog("bonding_mat_cost: " + bonding_mat_cost);
		bs.writeLog("bonded_labour_true_1: " + bonded_labour_true_1);
		bs.writeLog("frametechnology_ftech_true: " + frametechnology_ftech_true);
		bs.writeLog("moldingcompound_mat_true: " + moldingcompound_mat_true);
		bs.writeLog("other_fees_1: " + other_fees_1);
		BigDecimal assembly_maintenance_cost  =scrib_actual_2.add(grind_actual_2).add(Load_actual_2).add(Load_other_true_2).add(bonded_labour_true_2).add(frametechnology_fees_2).add(moldingcompound_fees_2).add(other_fees_2).add(print_fees_2);//组装维修费用
		BigDecimal assembly_labour_cost  =scrib_actual_3.add(grind_actual_3).add(Load_actual_3).add(Load_other_true_3).add(bonded_labour_true_3).add(frametechnology_fees_3).add(moldingcompound_fees_3).add(other_fees_3).add(print_fees_3);//组装人工费用
		BigDecimal assembly_power_cost  =scrib_actual_4.add(grind_actual_4).add(Load_actual_4).add(Load_other_true_4).add(bonded_labour_true_4).add(frametechnology_fees_4).add(moldingcompound_fees_4).add(other_fees_4).add(print_fees_4);//组装动力费用
		BigDecimal assembly_depr_cost  =scrib_actual_5.add(grind_actual_5).add(Load_actual_5).add(Load_other_true_5).add(bonded_labour_true_5).add(frametechnology_fees_5).add(moldingcompound_fees_5).add(other_fees_5).add(print_fees_5);//组装折旧费用
		BigDecimal assembly_other_cost  =scrib_actual_6.add(grind_actual_6).add(Load_actual_6).add(Load_other_true_6).add(bonded_labour_true_6).add(frametechnology_fees_6).add(moldingcompound_fees_6).add(other_fees_6).add(print_fees_6);//组装其他费用
		BigDecimal assembly_total_cost2  =scrib_actual_7.add(grind_actual_7).add(Load_actual_7).add(Load_other_true_7).add(bonding_mat_cost).add(bonded_labour_true_7).add(frametechnology_fees_total).add(moldingcompound_fees_total).add(other_fees_7).add(print_fees_7);//组装总成本						
 		BigDecimal assembly_total_cost =assembly_mat_cost.add(assembly_maintenance_cost).add(assembly_labour_cost).add(assembly_power_cost).add(assembly_depr_cost).add(assembly_other_cost);//组装总成本 (算法二)



		//测试费用
		//测试机 费用
		BigDecimal testing_machine_cost_2 = new BigDecimal(0);
		BigDecimal testing_machine_cost_3 = new BigDecimal(0);
		BigDecimal testing_machine_cost_4 = new BigDecimal(0);
		BigDecimal testing_machine_cost_5 = new BigDecimal(0);
		BigDecimal testing_machine_cost_6 = new BigDecimal(0);
		BigDecimal testing_machine_cost_7 = new BigDecimal(0);

		sql ="select MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER ,(MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) as TOTAL from MD_SD_TESTER_COST a left join MD_TESTER b on A.TESTER_FK =B.ID where b.name ='"+ tester +"'";
			rs.executeSql(sql);
			bs.writeLog("sql测试机 费用"+sql);
			while(rs.next()){

				 testing_machine_cost_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
				 testing_machine_cost_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
				 testing_machine_cost_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
				 testing_machine_cost_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				 testing_machine_cost_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
				 testing_machine_cost_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));

			}

 		//机械手 费用
 		BigDecimal hander_machine_cost_2 = new BigDecimal(0);
 		BigDecimal hander_machine_cost_3 = new BigDecimal(0);
 		BigDecimal hander_machine_cost_4 = new BigDecimal(0);
 		BigDecimal hander_machine_cost_5 = new BigDecimal(0);
 		BigDecimal hander_machine_cost_6 = new BigDecimal(0);
 		BigDecimal hander_machine_cost_7 = new BigDecimal(0);
 		BigDecimal index_time = new BigDecimal(0);

 		sql ="select A.INDEX_TIME,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER ,(MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER)  as TOTAL  from MD_SD_HANDLER_COST a left join MD_HANDLER b on A.HANDLER_FK=B.ID where b.name ='"+ manipulator +"'";
			rs.executeSql(sql);
			bs.writeLog("sql机械手 费用"+sql);
			while(rs.next()){

				 hander_machine_cost_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
				 hander_machine_cost_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
				 hander_machine_cost_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
				 hander_machine_cost_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				 hander_machine_cost_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
				 hander_machine_cost_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));
				 index_time = (rs.getString("INDEX_TIME") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("INDEX_TIME")));
			}

			BigDecimal test_mat_cost = new BigDecimal(0);
			BigDecimal test_maintenance_cost = new BigDecimal(0);
			BigDecimal test_labour_cost = new BigDecimal(0);
			BigDecimal test_power_cost = new BigDecimal(0);
			BigDecimal test_depr_cost = new BigDecimal(0);
			BigDecimal test_other_cost = new BigDecimal(0);
			BigDecimal test_total_cost = new BigDecimal(0);
			BigDecimal test_total_cost2 = new BigDecimal(0);
			BigDecimal test_uph = new BigDecimal(0);

			String test_model = "";
			if(quotationmethod.equals("1")){ // 小时
				 test_model = "小时";
				 test_mat_cost =new BigDecimal(0);
				 test_maintenance_cost =testing_machine_cost_2.add(hander_machine_cost_2);
				 test_labour_cost  =testing_machine_cost_3.add(hander_machine_cost_3);
				 test_power_cost  =testing_machine_cost_4.add(hander_machine_cost_4);
				 test_depr_cost  =testing_machine_cost_5.add(hander_machine_cost_5);
				 test_other_cost  =testing_machine_cost_6.add(hander_machine_cost_6);
				 test_total_cost  =testing_machine_cost_7.add(hander_machine_cost_7);

			}else if (quotationmethod.equals("0")){ // 千只
				 test_model = "千只";
				 test_uph = new BigDecimal(uph);
				 test_mat_cost =new BigDecimal(0);
				 test_maintenance_cost =testing_machine_cost_2.add(hander_machine_cost_2).divide(test_uph,7,BigDecimal.ROUND_HALF_UP).multiply( new BigDecimal(1000));
				 test_labour_cost  =testing_machine_cost_3.add(hander_machine_cost_3).divide(test_uph,7,BigDecimal.ROUND_HALF_UP).multiply( new BigDecimal(1000));
				 test_power_cost  =testing_machine_cost_4.add(hander_machine_cost_4).divide(test_uph,7,BigDecimal.ROUND_HALF_UP).multiply( new BigDecimal(1000));
				 test_depr_cost  =testing_machine_cost_5.add(hander_machine_cost_5).divide(test_uph,7,BigDecimal.ROUND_HALF_UP).multiply( new BigDecimal(1000));
				 test_other_cost  =testing_machine_cost_6.add(hander_machine_cost_6).divide(test_uph,7,BigDecimal.ROUND_HALF_UP).multiply( new BigDecimal(1000));
				 test_total_cost2  =testing_machine_cost_7.add(hander_machine_cost_7).divide(test_uph,7,BigDecimal.ROUND_HALF_UP).multiply( new BigDecimal(1000));
				 test_total_cost  =test_mat_cost.add(test_maintenance_cost).add(test_labour_cost).add(test_power_cost).add(test_depr_cost).add(test_other_cost);
			}


			//包装成本
			//包装成本=成本3+成本4
			//成本3=根据外形、包装材料、包装档次，将对应的所有费用相加
			//成本4=根据是否需要TAPING，把对应的所有费用相加
			
			//成本3
			BigDecimal pack_fees_1 = new BigDecimal(0);
			BigDecimal pack_fees_2 = new BigDecimal(0);
			BigDecimal pack_fees_3 = new BigDecimal(0);
			BigDecimal pack_fees_4 = new BigDecimal(0);
			BigDecimal pack_fees_5 = new BigDecimal(0);
			BigDecimal pack_fees_6 = new BigDecimal(0);
			BigDecimal pack_fees_7 = new BigDecimal(0);

			sql ="select MATERIAL,MAINTENANCE_COST ,LABOUR,POWER,DEPR,OTHER,(MATERIAL+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER)  as TOTAL from MD_SD_COST_PACKING a left join MD_SD_PACKING b on A.PACKING_FK =b.id left join MD_SD_PACKING_GRADE c on A.PACKING_GRADE_FK =c.id where A.QTTN_PKG_FK ='"+ shape +"' and b.name='"+ packageform +"' and c.name='"+ packagegrade +"'";
			rs.executeSql(sql);
			bs.writeLog("sql成本3"+sql);
			while(rs.next()){
				
				 pack_fees_1 = (rs.getString("MATERIAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MATERIAL")));
				 pack_fees_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
				 pack_fees_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
				 pack_fees_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
				 pack_fees_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				 pack_fees_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
				 pack_fees_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));
			}
			//成本3合计
			BigDecimal cost_of_three =pack_fees_7;

			//成本4
			BigDecimal tapping_fees_1 = new BigDecimal(0);
			BigDecimal tapping_fees_2 = new BigDecimal(0);
			BigDecimal tapping_fees_3 = new BigDecimal(0);
			BigDecimal tapping_fees_4 = new BigDecimal(0);
			BigDecimal tapping_fees_5 = new BigDecimal(0);
			BigDecimal tapping_fees_6 = new BigDecimal(0);
			BigDecimal tapping_fees_7 = new BigDecimal(0);

			sql ="select MATERIAL_COST,MAINTENANCE_COST,LABOUR_COST,POWER_COST,DEPR_COST,OTHER_COST, (MATERIAL_COST+MAINTENANCE_COST+LABOUR_COST+POWER_COST+DEPR_COST+OTHER_COST)  as total from MD_SD_QTTN_PKG_TAPING a left join MD_SD_PACKING_TAPING b on A.TAPING_FK =b.id where  A.QTTN_PKG_FK ='"+ shape +"' and B.NAME ='"+ taping +"'";
			rs.executeSql(sql);
			bs.writeLog("sql成本4"+sql);
			while(rs.next()){
				 tapping_fees_1 = (rs.getString("MATERIAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MATERIAL")));
				 tapping_fees_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MAINTENANCE_COST")));
				 tapping_fees_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
				 tapping_fees_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
				 tapping_fees_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				 tapping_fees_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
				 tapping_fees_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));
			}
			//成本4
			BigDecimal cost_of_four =pack_fees_7;
			//包装成本
				BigDecimal pack_mat_cost =pack_fees_1.add(tapping_fees_1);
				BigDecimal pack_maintenance_cost =pack_fees_2.add(tapping_fees_2);
				BigDecimal pack_labour_cost  =pack_fees_3.add(tapping_fees_3);
				BigDecimal pack_power_cost  =pack_fees_4.add(tapping_fees_4);
				BigDecimal pack_depr_cost  =pack_fees_5.add(tapping_fees_5);
				BigDecimal pack_other_cost  =pack_fees_6.add(tapping_fees_6);
				BigDecimal pack_total_cost  =pack_fees_7.add(tapping_fees_7);


			//外形标准毛利率
			BigDecimal GPM = new BigDecimal(0);
			sql="select QTTN_PKG_FK,PRDC_TYPE_FK,GPM from MD_SD_QTTN_PKG_GPM where QTTN_PKG_FK ='"+shape+"' and PRDC_TYPE_FK ='"+producttype+"'";
			rs.executeSql(sql);
			bs.writeLog("sql外形标准毛利率"+sql);
			while(rs.next()){

				 GPM = (rs.getString("GPM") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("GPM")));
			}
			//贸易方式税点设定
			BigDecimal rate = new BigDecimal(0);
			sql ="select name,full_name,RATE from MD_TRADE_TYPE  where  full_name ='"+tradeway+"'";
			rs.executeSql(sql);
			bs.writeLog("sql贸易方式税点设定"+sql);
			while(rs.next()){

				 rate = (rs.getString("RATE") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("RATE")));
			}
			//汇率
			BigDecimal exchange_rate = new BigDecimal(0);
			sql ="select FROM_FK,TO_FK,RATE from MD_SD_EXCHANGE_RATE where FROM_FK ='USD' ";
			rs.executeSql(sql);
			bs.writeLog("sql汇率"+sql);
			while(rs.next()){

				 exchange_rate = (rs.getString("RATE") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("RATE")));
			}

			// if(CURRENCY.equals("0")){
			// 	BigDecimal assy_advice =the_assembly_cost/(1-gpm)* (1+rate);
			// 	test_advice=test_cost/(1-gpm)* (1+rate);
			// 	pack_advice=packaging_cost/(1-gpm)* (1+rate);
			//建议价格  意向价格(组装  测试  包装)
				BigDecimal assy_advice = assembly_total_cost.divide(new BigDecimal(1).subtract(GPM),4,BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(1).add(rate));
				BigDecimal test_advice = test_total_cost.divide(new BigDecimal(1).subtract(GPM),4,BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(1).add(rate));
				BigDecimal pack_advice = pack_total_cost.divide(new BigDecimal(1).subtract(GPM),4,BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(1).add(rate));
				
			// }else if(CURRENCY.equals("1")){

			// 	assy_advice =the_assembly_cost/(1-gpm)/exchange_rate;
			// 	test_advice =test_cost/(1-gpm)/exchange_rate;
			// 	pack_advice =packaging_cost/(1-gpm)/exchange_rate;
			// }
			
			// if(CURRENCY.equals("0")){
			// 	 advice_chip_cose =a_single_chip_cost/(1-gpm)* (1+rate);  加一个芯片
			// 	 advice_wire_cost=a_piece_of_wire/(1-gpm)* (1+rate);  加一根丝
			//加一个芯片  加一根丝  成本
				 BigDecimal advice_chip_cose =cost_of_one.add(cost_of_two).divide(new BigDecimal(1).subtract(GPM),4,BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(1).add(rate)).divide(chipnumber_no, 4, BigDecimal.ROUND_HALF_UP);
				 BigDecimal advice_wire_cost =bonding_cost.divide(silk_standard,4,BigDecimal.ROUND_HALF_UP).divide(new BigDecimal(1).subtract(GPM),4,BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(1).add(rate));
				 
			// }else if(CURRENCY.equals("1")){
			// 	 advice_chip_cose =a_single_chip_cost/(1-gpm)/exchange_rate;
			// 	 advice_wire_cost=a_piece_of_wire/(1-gpm)/exchange_rate;
			// }

			bs.writeLog("assembly_mat_cost: " + assembly_mat_cost);
			sb.append(assembly_mat_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(assembly_maintenance_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(assembly_labour_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(assembly_power_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(assembly_depr_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(assembly_other_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(assembly_total_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(assy_advice.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(assy_advice.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(test_mat_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(test_maintenance_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(test_labour_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(test_power_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(test_depr_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(test_other_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(test_total_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(test_advice.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(test_advice.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(pack_mat_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(pack_maintenance_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(pack_labour_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(pack_power_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(pack_depr_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(pack_other_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(pack_total_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(pack_advice.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(pack_advice.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(advice_chip_cose.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(advice_wire_cost.setScale(4,BigDecimal.ROUND_HALF_UP)).append(" ").append(test_model).append(" ");
			bs.writeLog(sb);
	if(sb.length() > 0){
		sb.deleteCharAt(sb.length() - 1);
	}
out.print(sb);
%>
/**
 * ****************************************************************************
 * System      : weaver
 * Module      : weaver.interfaces.workflow.entity.quotation
 * File Name   : QuotationBrowserDaoImpl.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年10月13日     peng.xu     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.dao.quotation;

import java.math.BigDecimal;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.entity.quotation.QuotationBrowserCalculationData;
import weaver.interfaces.workflow.entity.quotation.QuotationBrowserData;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author peng.xu
 *
 */
public class QuotationBrowserDaoImpl implements QuotationBrowserDao {
	BaseBean basebean = new BaseBean();
	
	// MATERIAL：材料费用
	// MAINTENANCE_COST：维修费用
	// LABOUR：人工费用
	// POWER：动力费用
	// DEPR：折旧费用
	// OTHER：其他费用
	
	@Override
	public QuotationBrowserData getQuotationBrowserData(RequestInfo request) {
		basebean.writeLog("getQuotationBrowserData 开始运行");
		StringBuilder strBuilder = new StringBuilder();
		QuotationBrowserData data = new QuotationBrowserData();
		RecordSet rs1 = new RecordSet();
		RecordSet rs2 = new RecordSet();
		try {
			int formId = BillUtil.getFormId(Integer.parseInt(request.getWorkflowid()));
			String requsetId = request.getRequestid();// 获取当前流程的requsetId
			strBuilder.append("select guid from formtable_main_" + formId + " where requestid = '" + requsetId + "'");
			rs1.execute(strBuilder.toString());
			rs1.next();
			String guid = rs1.getString("guid");

			strBuilder = new StringBuilder();
			strBuilder.append("select * from Offer_to_apply_middle where id = '" + guid + "'");
			rs2.execute(strBuilder.toString());
			rs2.next();
			data.setShapeFast(rs2.getString("SHAPE_FAST"));
			data.setProductTypeFast(rs2.getString("PRODUCT_TYPE_FAST"));
			data.setCustFast(rs2.getString("CUST_FAST"));
			data.setTradeWayFast(rs2.getString("TRADE_WAY_FAST"));// 贸易方式 02(C)
			data.setWireBondFast(rs2.getString("WIRE_BOND_FAST"));
			data.setWireDiamFast(rs2.getString("WIRE_DIAM_FAST"));
			data.setSilkFast(rs2.getString("SILK_FAST"));// 丝数（用户填写）
			data.setGrindFast(rs2.getString("GRIND_FAST"));
			data.setChipNumFast(rs2.getString("CHIP_NUM_FAST"));
			data.setChipXFast(rs2.getString("CHIP_X_FAST"));
			data.setChipYFast(rs2.getString("CHIP_Y_FAST"));
			data.setMatFast(rs2.getString("MAT_FAST"));
			data.setFormFast(rs2.getString("FORM_FAST"));
			data.setGradeFast(rs2.getString("GRADE_FAST"));// 是否磨片 如果选择否 则不计入
			data.setTapingFast(rs2.getString("TAPING_FAST"));
			data.setFrameWorkTechFast(rs2.getString("FRAMEWORK_TECH_FAST"));
			data.setEncapsulaMatFast(rs2.getString("ENCAPSULA_MAT_FAST"));
			data.setOtherFast(rs2.getString("OTHER_FAST"));
			data.setTestModelsFast(rs2.getString("TEST_MODELS_FAST"));
			data.setHanderFast(rs2.getString("HANDER_FAST"));
			data.setTestQuotationWayFast(rs2.getString("TEST_QUOTATION_WAY_FAST"));
			data.setTestSiteForFast(rs2.getString("TEST_SITE_FOR_FAST"));
			data.setTestOfTimeFast(rs2.getString("TEST_OF_TIME_FAST"));
			data.setUphFormulaFast(rs2.getString("UPH_FORMULA_FAST"));
			data.setUphFast(rs2.getString("UPH_FAST"));

			strBuilder = new StringBuilder();
			strBuilder.append("SELECT SELECTNAME FROM WORKFLOW_SELECTITEM ");
			strBuilder.append(" WHERE SELECTVALUE = (SELECT CURRENCY FROM FORMTABLE_MAIN_" + formId
					+ " WHERE REQUESTID = '" + requsetId + "') ");
			strBuilder.append(" AND FIELDID =( SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -" + formId
					+ " AND FIELDNAME ='currency')");
			rs2.execute(strBuilder.toString());
			rs2.next();
			data.setCurrency(rs2.getString("SELECTNAME"));
			basebean.writeLog("当前币别为：" + data.getCurrency());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}

	@Override
	public QuotationBrowserCalculationData getQuotationBrowserCalculationData(QuotationBrowserData data) {
		basebean.writeLog("getQuotationBrowserCalculationData 开始运行");
		QuotationBrowserCalculationData calculationData = new QuotationBrowserCalculationData();
		try {
			calculationWireBond(calculationData, data);
			calculationChip(calculationData, data);
			calculationAssemble(calculationData, data);
			calculationTester(calculationData, data);
			calculationPackage(calculationData, data);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return calculationData;
	}

	private void calculationPackage(QuotationBrowserCalculationData calculationData, QuotationBrowserData data) {
		basebean.writeLog("calculationPackage 开始运行");
		StringBuilder strBuilder = new StringBuilder();
		RecordSet rs1 = new RecordSet();
		RecordSet rs2 = new RecordSet();
		BigDecimal packageMaterial = new BigDecimal(0);
		BigDecimal packageMaintenance = new BigDecimal(0);
		BigDecimal packageLabour = new BigDecimal(0);
		BigDecimal packagePower = new BigDecimal(0);
		BigDecimal packageDepr = new BigDecimal(0);
		BigDecimal packageOther = new BigDecimal(0);
		try {
			strBuilder.append("select MATERIAL, MAINTENANCE_COST, LABOUR, POWER, DEPR, OTHER ");
			strBuilder.append(
					"from MD_SD_COST_PACKING a left join MD_SD_PACKING b on A.PACKING_FK =b.id left join MD_SD_PACKING_GRADE c on A.PACKING_GRADE_FK =c.id ");
			strBuilder.append(" where a.QTTN_PKG_FK = '" + data.getShapeFast() + "' and b.name = '" + data.getFormFast()
					+ "' and c.name = '" + data.getGradeFast() + "'");
			basebean.writeLog("包装sql1: " + strBuilder.toString());
			rs1.execute(strBuilder.toString());
			if (rs1.getCounts() > 0) {
				rs1.next();
				BigDecimal material1 = (rs1.getString("MATERIAL") == "" || rs1.getString("MATERIAL") == null)
						? new BigDecimal(0) : new BigDecimal(rs1.getString("MATERIAL"));
				BigDecimal maintenanaceCost1 = (rs1.getString("MAINTENANCE_COST") == ""
						|| rs1.getString("MAINTENANCE_COST") == null) ? new BigDecimal(0)
								: new BigDecimal(rs1.getString("MAINTENANCE_COST"));
				BigDecimal labour1 = (rs1.getString("LABOUR") == "" || rs1.getString("LABOUR") == null)
						? new BigDecimal(0) : new BigDecimal(rs1.getString("LABOUR"));
				BigDecimal power1 = (rs1.getString("POWER") == "" || rs1.getString("POWER") == null) ? new BigDecimal(0)
						: new BigDecimal(rs1.getString("POWER"));
				BigDecimal depr1 = (rs1.getString("DEPR") == "" || rs1.getString("DEPR") == null) ? new BigDecimal(0)
						: new BigDecimal(rs1.getString("DEPR"));
				BigDecimal other1 = (rs1.getString("OTHER") == "" || rs1.getString("OTHER") == null) ? new BigDecimal(0)
						: new BigDecimal(rs1.getString("OTHER"));
				packageMaterial = packageMaterial.add(material1);
				basebean.writeLog("material1: " + material1);
				basebean.writeLog("packageMaterial: " + packageMaterial);
				packageMaintenance = packageMaintenance.add(maintenanaceCost1);
				basebean.writeLog("maintenanaceCost1: " + maintenanaceCost1);
				basebean.writeLog("packageMaintenance: " + packageMaintenance);
				packageLabour = packageLabour.add(labour1);
				basebean.writeLog("labour1: " + labour1);
				basebean.writeLog("packageLabour: " + packageLabour);
				packagePower = packagePower.add(power1);
				basebean.writeLog("power1: " + power1);
				basebean.writeLog("packagePower: " + packagePower);
				packageDepr = packageDepr.add(depr1);
				basebean.writeLog("depr1: " + depr1);
				basebean.writeLog("packageDepr: " + packageDepr);
				packageOther = packageOther.add(other1);
				basebean.writeLog("other1: " + other1);
				basebean.writeLog("packageOther: " + packageOther);
			}

			strBuilder = new StringBuilder();
			strBuilder
					.append("select MATERIAL_COST, MAINTENANCE_COST, LABOUR_COST, POWER_COST, DEPR_COST, OTHER_COST ");
			strBuilder
					.append("from MD_SD_QTTN_PKG_TAPING a left join MD_SD_PACKING_TAPING b on A.TAPING_FK =b.id where A.QTTN_PKG_FK = '"
							+ data.getShapeFast() + "' and b.name = '" + data.getTapingFast() + "'");
			basebean.writeLog("包装sql2: " + strBuilder.toString());
			rs2.execute(strBuilder.toString());
			if (rs2.getCounts() > 0) {
				rs2.next();
				BigDecimal material2 = (rs2.getString("MATERIAL_COST") == "" || rs2.getString("MATERIAL_COST") == null)
						? new BigDecimal(0) : new BigDecimal(rs2.getString("MATERIAL_COST"));
				BigDecimal maintenanaceCost2 = (rs2.getString("MAINTENANCE_COST") == ""
						|| rs2.getString("MAINTENANCE_COST") == null) ? new BigDecimal(0)
								: new BigDecimal(rs2.getString("MAINTENANCE_COST"));
				BigDecimal labour2 = (rs2.getString("LABOUR_COST") == "" || rs2.getString("LABOUR_COST") == null)
						? new BigDecimal(0) : new BigDecimal(rs2.getString("LABOUR_COST"));
				BigDecimal power2 = (rs2.getString("POWER_COST") == "" || rs2.getString("POWER_COST") == null)
						? new BigDecimal(0) : new BigDecimal(rs2.getString("POWER_COST"));
				BigDecimal depr2 = (rs2.getString("DEPR_COST") == "" || rs2.getString("DEPR_COST") == null)
						? new BigDecimal(0) : new BigDecimal(rs2.getString("DEPR_COST"));
				BigDecimal other2 = (rs2.getString("OTHER_COST") == "" || rs2.getString("OTHER_COST") == null)
						? new BigDecimal(0) : new BigDecimal(rs2.getString("OTHER_COST"));
				packageMaterial = packageMaterial.add(material2);
				basebean.writeLog("material2: " + material2);
				basebean.writeLog("packageMaterial: " + packageMaterial);
				packageMaintenance = packageMaintenance.add(maintenanaceCost2);
				basebean.writeLog("maintenanaceCost2: " + maintenanaceCost2);
				basebean.writeLog("packageMaintenance: " + packageMaintenance);
				packageLabour = packageLabour.add(labour2);
				basebean.writeLog("labour2: " + labour2);
				basebean.writeLog("packageLabour: " + packageLabour);
				packagePower = packagePower.add(power2);
				basebean.writeLog("power2: " + power2);
				basebean.writeLog("packagePower: " + packagePower);
				packageDepr = packageDepr.add(depr2);
				basebean.writeLog("depr2: " + depr2);
				basebean.writeLog("packageDepr: " + packageDepr);
				packageOther = packageOther.add(other2);
				basebean.writeLog("other2: " + other2);
				basebean.writeLog("packageOther: " + packageOther);
			}

			calculationData.setPackageMaterial(packageMaterial.toString());
			calculationData.setPackageMaintenance(packageMaintenance.toString());
			calculationData.setPackageLabour(packageLabour.toString());
			calculationData.setPackagePower(packagePower.toString());
			calculationData.setPackageDepr(packageDepr.toString());
			calculationData.setPackageOther(packageOther.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void calculationTester(QuotationBrowserCalculationData calculationData, QuotationBrowserData data) {
		basebean.writeLog("calculationTester 开始运行");
		StringBuilder strBuilder = new StringBuilder();
		RecordSet rs1 = new RecordSet();
		RecordSet rs2 = new RecordSet();
		BigDecimal testerMaintenance = new BigDecimal(0);
		BigDecimal testerLabour = new BigDecimal(0);
		BigDecimal testerPower = new BigDecimal(0);
		BigDecimal testerDepr = new BigDecimal(0);
		BigDecimal testerOther = new BigDecimal(0);

		BigDecimal testerThouMaintenance = new BigDecimal(0);
		BigDecimal testerThouLabour = new BigDecimal(0);
		BigDecimal testerThouPower = new BigDecimal(0);
		BigDecimal testerThouDepr = new BigDecimal(0);
		BigDecimal testerThouOther = new BigDecimal(0);
		try {
			String testModelsFast = ((data.getTestModelsFast() == null || data.getTestModelsFast() == "") ? ""
					: data.getTestModelsFast());
			strBuilder.append("select MAINTENANCE_COST, LABOUR, POWER, DEPR, OTHER ");
			strBuilder.append("from MD_SD_TESTER_COST a left join MD_TESTER b on A.TESTER_FK =B.ID where b.name = '"
					+ testModelsFast + "'");
			basebean.writeLog("测试sql1: " + strBuilder.toString());
			rs1.execute(strBuilder.toString());
			if (rs1.getCounts() > 0) {
				rs1.next();
				BigDecimal maintenanceCost1 = (rs1.getString("MAINTENANCE_COST") == ""
						|| rs1.getString("MAINTENANCE_COST") == null) ? new BigDecimal(0)
								: new BigDecimal(rs1.getString("MAINTENANCE_COST"));
				BigDecimal labour1 = (rs1.getString("LABOUR") == "" || rs1.getString("LABOUR") == null)
						? new BigDecimal(0) : new BigDecimal(rs1.getString("LABOUR"));
				BigDecimal power1 = (rs1.getString("POWER") == "" || rs1.getString("POWER") == null) ? new BigDecimal(0)
						: new BigDecimal(rs1.getString("POWER"));
				BigDecimal depr1 = (rs1.getString("DEPR") == "" || rs1.getString("DEPR") == null) ? new BigDecimal(0)
						: new BigDecimal(rs1.getString("DEPR"));
				BigDecimal other1 = (rs1.getString("OTHER") == "" || rs1.getString("OTHER") == null) ? new BigDecimal(0)
						: new BigDecimal(rs1.getString("OTHER"));
				testerMaintenance = testerMaintenance.add(maintenanceCost1);
				basebean.writeLog("maintenanceCost1: " + maintenanceCost1);
				testerLabour = testerLabour.add(labour1);
				basebean.writeLog("labour1: " + labour1);
				testerPower = testerPower.add(power1);
				basebean.writeLog("power1: " + power1);
				testerDepr = testerDepr.add(depr1);
				basebean.writeLog("depr1: " + depr1);
				testerOther = testerOther.add(other1);
				basebean.writeLog("other1: " + other1);
			}

			String handerFast = ((data.getHanderFast() == null || data.getHanderFast() == "") ? ""
					: data.getHanderFast());
			strBuilder = new StringBuilder();
			strBuilder.append("select MAINTENANCE_COST, LABOUR, POWER, DEPR, OTHER ");
			strBuilder.append("from MD_SD_HANDLER_COST a left join MD_HANDLER b on A.HANDLER_FK=B.ID where b.name = '"
					+ handerFast + "'");
			basebean.writeLog("测试sql2: " + strBuilder.toString());
			rs2.execute(strBuilder.toString());
			if (rs2.getCounts() > 0) {
				rs2.next();
				BigDecimal maintenanceCost2 = (rs2.getString("MAINTENANCE_COST") == ""
						|| rs2.getString("MAINTENANCE_COST") == null) ? new BigDecimal(0)
								: new BigDecimal(rs2.getString("MAINTENANCE_COST"));
				BigDecimal labour2 = (rs2.getString("LABOUR") == "" || rs2.getString("LABOUR") == null)
						? new BigDecimal(0) : new BigDecimal(rs2.getString("LABOUR"));
				BigDecimal power2 = (rs2.getString("POWER") == "" || rs2.getString("POWER") == null) ? new BigDecimal(0)
						: new BigDecimal(rs2.getString("POWER"));
				BigDecimal depr2 = (rs2.getString("DEPR") == "" || rs2.getString("DEPR") == null) ? new BigDecimal(0)
						: new BigDecimal(rs2.getString("DEPR"));
				BigDecimal other2 = (rs2.getString("OTHER") == "" || rs2.getString("OTHER") == null) ? new BigDecimal(0)
						: new BigDecimal(rs2.getString("OTHER"));
				testerMaintenance = testerMaintenance.add(maintenanceCost2);
				basebean.writeLog("maintenanceCost2: " + maintenanceCost2);
				testerLabour = testerLabour.add(labour2);
				basebean.writeLog("labour2: " + labour2);
				testerPower = testerPower.add(power2);
				basebean.writeLog("power2: " + power2);
				testerDepr = testerDepr.add(depr2);
				basebean.writeLog("depr2: " + depr2);
				testerOther = testerOther.add(other2);
				basebean.writeLog("other2: " + other2);
			}

			BigDecimal uphFast = ((data.getUphFast() == null || data.getUphFast() == "") ? new BigDecimal(1)
					: new BigDecimal(data.getUphFast()));
			basebean.writeLog("uphFast: " + uphFast);
			testerThouMaintenance = testerMaintenance.multiply(new BigDecimal(1000)).divide(uphFast, 4,
					BigDecimal.ROUND_HALF_UP);
			basebean.writeLog("testerThouMaintenance: " + testerThouMaintenance);
			testerThouLabour = testerLabour.multiply(new BigDecimal(1000)).divide(uphFast, 4, BigDecimal.ROUND_HALF_UP);
			basebean.writeLog("testerThouLabour: " + testerThouLabour);
			testerThouPower = testerPower.multiply(new BigDecimal(1000)).divide(uphFast, 4, BigDecimal.ROUND_HALF_UP);
			basebean.writeLog("testerThouPower: " + testerThouPower);
			testerThouDepr = testerDepr.multiply(new BigDecimal(1000)).divide(uphFast, 4, BigDecimal.ROUND_HALF_UP);
			basebean.writeLog("testerThouDepr: " + testerThouDepr);
			testerThouOther = testerOther.multiply(new BigDecimal(1000)).divide(uphFast, 4, BigDecimal.ROUND_HALF_UP);
			basebean.writeLog("testerThouOther: " + testerThouOther);
			calculationData.setTesterMaintenance(testerMaintenance.toString());
			calculationData.setTesterLabour(testerLabour.toString());
			calculationData.setTesterPower(testerPower.toString());
			calculationData.setTesterDepr(testerDepr.toString());
			calculationData.setTesterOther(testerOther.toString());
			calculationData.setTesterThouMaintenance(testerThouMaintenance.toString());
			calculationData.setTesterThouLabour(testerThouLabour.toString());
			calculationData.setTesterThouPower(testerThouPower.toString());
			calculationData.setTesterThouDepr(testerThouDepr.toString());
			calculationData.setTesterThouOther(testerThouOther.toString());
		} catch (Exception e) {
			e.printStackTrace();
			basebean.writeLog("错误4");
		}
	}

	private void calculationAssemble(QuotationBrowserCalculationData calculationData, QuotationBrowserData data) {
		basebean.writeLog("calculationAssemble 开始运行");
		RecordSet rs = new RecordSet();
		BigDecimal assembleMaterial = new BigDecimal(0);
		BigDecimal assembleMaintenance = new BigDecimal(0);
		BigDecimal assembleLabour = new BigDecimal(0);
		BigDecimal assemblePower = new BigDecimal(0);
		BigDecimal assembleDepr = new BigDecimal(0);
		BigDecimal assembleOther = new BigDecimal(0);
		BigDecimal frameMaterial = new BigDecimal(0);
		BigDecimal moldingMaterial = new BigDecimal(0);
		BigDecimal rate_emat = new BigDecimal(1);// 塑封料系数
		BigDecimal rate_ftech = new BigDecimal(1);// 框架工艺系数
		String productTypeFast = data.getProductTypeFast();
		try {
			if (!productTypeFast.equals("TO")) {
				StringBuilder strBuilder = new StringBuilder();
				strBuilder
						.append("select b.FULL_NAME,A.RATE,C.NAME from MD_SD_TRDTYP_MTRL_COST_RATE a left join MD_TRADE_TYPE b on A.TRADE_TYPE_FK =b.id left join MD_SD_COST_ELEMENT c on A.COST_ELEMENT_FK =C.ID  where  b.FULL_NAME = '"
								+ data.getTradeWayFast() + "'");
				basebean.writeLog("calculationAssemble sql1: " + strBuilder.toString());
				rs.execute(strBuilder.toString());
				while (rs.next()) {// 系数
					String NAME = rs.getString("NAME");
					if (NAME.equals("塑封料")) {
						rate_emat = (rs.getString("RATE") == "" || rs.getString("RATE") == null) ? new BigDecimal(1)
								: new BigDecimal(rs.getString("RATE"));
					} else if (NAME.equals("框架工艺")) {
						rate_ftech = (rs.getString("RATE") == "" || rs.getString("RATE") == null) ? new BigDecimal(1)
								: new BigDecimal(rs.getString("RATE"));
					}
				}
				strBuilder = new StringBuilder();
				strBuilder.append(
						"select b.name,B.QTTN_PKG_FK,A.FULL_NAME,A.SORT,A.CURRENCY_FK, MATERIALCOST,MAINTENANCE_COST,UC,LABOUR,POWER,DEPR,OTHER ");
				strBuilder
						.append(" from MD_SD_COST_ASSY_OTHER_OPTION a left join  MD_SD_COST_ASSY_OTHER b on a.COST_ASSY_OTHER_FK =b.id where B.QTTN_PKG_FK = '"
								+ data.getShapeFast() + "'");
				basebean.writeLog("calculationAssemble sql2: " + strBuilder.toString());
				rs.execute(strBuilder.toString());
				if (rs.getCounts() > 0) {
					while (rs.next()) {
						String name = rs.getString("NAME");
						BigDecimal material = (rs.getString("MATERIALCOST") == ""
								|| rs.getString("MATERIALCOST") == null) ? new BigDecimal(0)
										: new BigDecimal(rs.getString("MATERIALCOST"));
						if (name.equals("塑封料")) {
							material = material.multiply(rate_emat);
						} else if (name.equals("框架工艺")) {
							material = material.multiply(rate_ftech);
						}
						BigDecimal maintenanceCost = (rs.getString("MAINTENANCE_COST") == ""
								|| rs.getString("MAINTENANCE_COST") == null) ? new BigDecimal(0)
										: new BigDecimal(rs.getString("MAINTENANCE_COST"));
						BigDecimal labour = (rs.getString("LABOUR") == "" || rs.getString("LABOUR") == null)
								? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR"));
						BigDecimal power = (rs.getString("POWER") == "" || rs.getString("POWER") == null)
								? new BigDecimal(0) : new BigDecimal(rs.getString("POWER"));
						BigDecimal depr = (rs.getString("DEPR") == "" || rs.getString("DEPR") == null)
								? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR"));
						BigDecimal other = (rs.getString("OTHER") == "" || rs.getString("OTHER") == null)
								? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER"));
						if (name.equals("框架工艺")) {
							frameMaterial = (rs.getString("MATERIALCOST") == "" || rs.getString("MATERIALCOST") == null)
									? new BigDecimal(0) : new BigDecimal(rs.getString("MATERIALCOST"));
							frameMaterial = frameMaterial.multiply(rate_ftech);
						}
						if (name.equals("塑封料")) {
							moldingMaterial = (rs.getString("MATERIALCOST") == ""
									|| rs.getString("MATERIALCOST") == null) ? new BigDecimal(0)
											: new BigDecimal(rs.getString("MATERIALCOST"));
							moldingMaterial = moldingMaterial.multiply(rate_emat);
						}
						assembleMaterial = assembleMaterial.add(material);
						basebean.writeLog("material: " + material);
						assembleMaintenance = assembleMaintenance.add(maintenanceCost);
						basebean.writeLog("maintenanceCost: " + maintenanceCost);
						assembleLabour = assembleLabour.add(labour);
						basebean.writeLog("labour: " + labour);
						assemblePower = assemblePower.add(power);
						basebean.writeLog("power: " + power);
						assembleDepr = assembleDepr.add(depr);
						basebean.writeLog("depr: " + depr);
						assembleOther = assembleOther.add(other);
						basebean.writeLog("other: " + other);
					}
				}
				calculationData.setFrameMaterial(frameMaterial.toString());
				calculationData.setMoldingMaterial(moldingMaterial.toString());
				calculationData.setAssembleMaterial(assembleMaterial.toString());
				calculationData.setAssembleMaintenance(assembleMaintenance.toString());
				calculationData.setAssembleLabour(assembleLabour.toString());
				calculationData.setAssemblePower(assemblePower.toString());
				calculationData.setAssembleDepr(assembleDepr.toString());
				calculationData.setAssembleOther(assembleOther.toString());
				calculationData.setRate_emat(rate_emat.toString());
				calculationData.setRate_ftech(rate_ftech.toString());
			} else {
				calculationData.setFrameMaterial(frameMaterial.toString());
				calculationData.setMoldingMaterial(moldingMaterial.toString());
				calculationData.setAssembleMaterial(assembleMaterial.toString());
				calculationData.setAssembleMaintenance(assembleMaintenance.toString());
				calculationData.setAssembleLabour(assembleLabour.toString());
				calculationData.setAssemblePower(assemblePower.toString());
				calculationData.setAssembleDepr(assembleDepr.toString());
				calculationData.setAssembleOther(assembleOther.toString());
				calculationData.setRate_emat(rate_emat.toString());
				calculationData.setRate_ftech(rate_ftech.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			basebean.writeLog("错误5");
		}
	}

	private void calculationChip(QuotationBrowserCalculationData calculationData, QuotationBrowserData data) {
		basebean.writeLog("calculationChip 开始运行");
		StringBuilder strBuilder = new StringBuilder();
		RecordSet rs1 = new RecordSet();
		RecordSet rs2 = new RecordSet();
		BigDecimal chipMaterial = new BigDecimal(0);
		BigDecimal chipMaintenance = new BigDecimal(0);
		BigDecimal chipLabour = new BigDecimal(0);
		BigDecimal chipPower = new BigDecimal(0);
		BigDecimal chipDepr = new BigDecimal(0);
		BigDecimal chipOther = new BigDecimal(0);
		BigDecimal sliceMaterial = new BigDecimal(0);
		BigDecimal number = (data.getChipNumFast() == null || data.getChipNumFast() == "" ? new BigDecimal(1)
				: new BigDecimal(data.getChipNumFast()));
		String productTypeFast = data.getProductTypeFast();
		try {
			if (!productTypeFast.equals("TO")) {
				strBuilder.append(
						"SELECT a.QTTN_PKG_FK,C.FULL_NAME,d.DIE_SIZE_X,d.DIE_SIZE_Y,MATERIAL,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER,b.NAME ");
				strBuilder.append(
						"FROM MD_SD_COST_DIE a left join MD_SD_MOUNTING_MTRL_SPEC b on A.MTRL_SPEC=B.ID left join MD_SD_COST_DIE_CAT c on A.COST_DIE_CAT_FK =C.ID ");
				strBuilder.append("left join MD_SD_QTTN_PKG d on d.name = a.QTTN_PKG_FK where a.QTTN_PKG_FK = '"
						+ data.getShapeFast() + "'");
				basebean.writeLog("芯片sql1: " + strBuilder.toString());
				rs1.execute(strBuilder.toString());
				if (rs1.getCounts() > 0) {
					while (rs1.next()) {
						String fullName = rs1.getString("FULL_NAME");
						String name = rs1.getString("NAME");
						BigDecimal material = (rs1.getString("MATERIAL") == "" || rs1.getString("MATERIAL") == null)
								? new BigDecimal(0) : new BigDecimal(rs1.getString("MATERIAL"));
						BigDecimal maintenanceCost = (rs1.getString("MAINTENANCE_COST") == ""
								|| rs1.getString("MAINTENANCE_COST") == null) ? new BigDecimal(0)
										: new BigDecimal(rs1.getString("MAINTENANCE_COST"));
						BigDecimal labour = (rs1.getString("LABOUR") == "" || rs1.getString("LABOUR") == null)
								? new BigDecimal(0) : new BigDecimal(rs1.getString("LABOUR"));
						BigDecimal power = (rs1.getString("POWER") == "" || rs1.getString("POWER") == null)
								? new BigDecimal(0) : new BigDecimal(rs1.getString("POWER"));
						BigDecimal depr = (rs1.getString("DEPR") == "" || rs1.getString("DEPR") == null)
								? new BigDecimal(0) : new BigDecimal(rs1.getString("DEPR"));
						BigDecimal other = (rs1.getString("OTHER") == "" || rs1.getString("OTHER") == null)
								? new BigDecimal(0) : new BigDecimal(rs1.getString("OTHER"));
						BigDecimal A = (data.getChipXFast() == "" || data.getChipXFast() == null) ? new BigDecimal(1)
								: new BigDecimal(data.getChipXFast());// 快速报价页面中用户填写的芯片尺寸
						BigDecimal B = (data.getChipYFast() == "" || data.getChipYFast() == null) ? new BigDecimal(1)
								: new BigDecimal(data.getChipYFast());// 快速报价页面中用户填写的芯片尺寸
						BigDecimal C = (rs1.getString("DIE_SIZE_X") == "" || rs1.getString("DIE_SIZE_X") == null)
								? new BigDecimal(1) : new BigDecimal(rs1.getString("DIE_SIZE_X"));// 系统带出的芯片尺寸
						BigDecimal D = (rs1.getString("DIE_SIZE_Y") == "" || rs1.getString("DIE_SIZE_Y") == null)
								? new BigDecimal(1) : new BigDecimal(rs1.getString("DIE_SIZE_Y"));// 系统带出的芯片尺寸
						// 芯片计算规则
						BigDecimal base_grind = (A.multiply(B)).divide((C.multiply(D)), 4, BigDecimal.ROUND_HALF_UP);// 磨片
						BigDecimal base_scrib = (A.add(B)).divide((C.add(D)), 4, BigDecimal.ROUND_HALF_UP);// 划片
						BigDecimal base_Load = (A.multiply(B)).divide((C.multiply(D)), 4, BigDecimal.ROUND_HALF_UP);// 装片
						
						basebean.writeLog("fullName: " + fullName);
						
						if (fullName.equals("装片")) {
							chipMaterial = chipMaterial.add(base_Load.multiply(material).multiply(number));
							if (fullName.equals("装片") && !(name.replace(" ", "")).equals(data.getMatFast())) {
								chipMaterial = chipMaterial.subtract(base_Load.multiply(material).multiply(number));
							}
							if (fullName.equals("装片")) {
								sliceMaterial = base_Load.multiply(material).multiply(number);
							}
							chipMaintenance = chipMaintenance.add(base_Load.multiply(maintenanceCost).multiply(number));
							chipLabour = chipLabour.add(base_Load.multiply(labour).multiply(number));
							chipPower = chipPower.add(base_Load.multiply(power).multiply(number));
							chipDepr = chipDepr.add(base_Load.multiply(depr).multiply(number));
							chipOther = chipOther.add(base_Load.multiply(other).multiply(number));
							basebean.writeLog("chipMaterial: " + chipMaterial);
							basebean.writeLog("chipMaintenance: " + chipMaintenance);
							basebean.writeLog("chipLabour: " + chipLabour);
							basebean.writeLog("chipPower: " + chipPower);
							basebean.writeLog("chipDepr: " + chipDepr);
							basebean.writeLog("chipOther: " + chipOther);
						}
						if (fullName.equals("划片")) {
							chipMaterial = chipMaterial.add(base_scrib.multiply(material).multiply(number));
							chipMaintenance = chipMaintenance
									.add(base_scrib.multiply(maintenanceCost).multiply(number));
							chipLabour = chipLabour.add(base_scrib.multiply(labour).multiply(number));
							chipPower = chipPower.add(base_scrib.multiply(power).multiply(number));
							chipDepr = chipDepr.add(base_scrib.multiply(depr).multiply(number));
							chipOther = chipOther.add(base_scrib.multiply(other).multiply(number));
							basebean.writeLog("chipMaterial: " + chipMaterial);
							basebean.writeLog("chipMaintenance: " + chipMaintenance);
							basebean.writeLog("chipLabour: " + chipLabour);
							basebean.writeLog("chipPower: " + chipPower);
							basebean.writeLog("chipDepr: " + chipDepr);
							basebean.writeLog("chipOther: " + chipOther);
						}
						basebean.writeLog("Grind: " + data.getGrindFast());
						if (fullName.equals("磨片") && Integer.parseInt(data.getGrindFast()) != 1) {// 磨片选择"是" 才运行下面的代码 否则不计算
							chipMaterial = chipMaterial.add(base_grind.multiply(material).multiply(number));
							chipMaintenance = chipMaintenance
									.add(base_grind.multiply(maintenanceCost).multiply(number));
							chipLabour = chipLabour.add(base_grind.multiply(labour).multiply(number));
							chipPower = chipPower.add(base_grind.multiply(power).multiply(number));
							chipDepr = chipDepr.add(base_grind.multiply(depr).multiply(number));
							chipOther = chipOther.add(base_grind.multiply(other).multiply(number));
							basebean.writeLog("chipMaterial: " + chipMaterial);
							basebean.writeLog("chipMaintenance: " + chipMaintenance);
							basebean.writeLog("chipLabour: " + chipLabour);
							basebean.writeLog("chipPower: " + chipPower);
							basebean.writeLog("chipDepr: " + chipDepr);
							basebean.writeLog("chipOther: " + chipOther);
						}
					}
				}

				strBuilder = new StringBuilder();
				strBuilder.append("select a.QTTN_PKG_FK,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER ");
				strBuilder
						.append("from MD_SD_FRM_PKG a left join MD_SD_FRAME b on A.FRAME_FK = b.id where a.QTTN_PKG_FK = '"
								+ data.getShapeFast() + "'");
				basebean.writeLog("芯片sql2: " + strBuilder.toString());
				rs2.execute(strBuilder.toString());
				if (rs2.getCounts() > 0) {
					rs2.next();
					BigDecimal otherMaintenanceCost = (rs2.getString("MAINTENANCE_COST") == ""
							|| rs2.getString("MAINTENANCE_COST") == null) ? new BigDecimal(0)
									: new BigDecimal(rs2.getString("MAINTENANCE_COST"));
					BigDecimal otherLabour = (rs2.getString("LABOUR") == "" || rs2.getString("LABOUR") == null)
							? new BigDecimal(0) : new BigDecimal(rs2.getString("LABOUR"));
					BigDecimal otherPower = (rs2.getString("POWER") == "" || rs2.getString("POWER") == null)
							? new BigDecimal(0) : new BigDecimal(rs2.getString("POWER"));
					BigDecimal otherDepr = (rs2.getString("DEPR") == "" || rs2.getString("DEPR") == null)
							? new BigDecimal(0) : new BigDecimal(rs2.getString("DEPR"));
					BigDecimal otherOther = (rs2.getString("OTHER") == "" || rs2.getString("OTHER") == null)
							? new BigDecimal(0) : new BigDecimal(rs2.getString("OTHER"));
					basebean.writeLog("number: " + number);
					chipMaintenance = chipMaintenance.add(otherMaintenanceCost.multiply(number));
					basebean.writeLog("otherMaintenanceCost: " + otherMaintenanceCost);
					chipLabour = chipLabour.add(otherLabour.multiply(number));
					basebean.writeLog("otherLabour: " + otherLabour);
					chipPower = chipPower.add(otherPower.multiply(number));
					basebean.writeLog("otherPower: " + otherPower);
					chipDepr = chipDepr.add(otherDepr.multiply(number));
					basebean.writeLog("otherDepr: " + otherDepr);
					chipOther = chipOther.add(otherOther.multiply(number));
					basebean.writeLog("otherOther: " + otherOther);
				}
				calculationData.setChipMaterial(chipMaterial.toString());
				calculationData.setChipMaintenance(chipMaintenance.toString());
				calculationData.setChipLabour(chipLabour.toString());
				calculationData.setChipPower(chipPower.toString());
				calculationData.setChipDepr(chipDepr.toString());
				calculationData.setChipOther(chipOther.toString());
				calculationData.setSliceMaterial(sliceMaterial.toString());
			} else {
				calculationData.setChipMaterial(chipMaterial.toString());
				calculationData.setChipMaintenance(chipMaintenance.toString());
				calculationData.setChipLabour(chipLabour.toString());
				calculationData.setChipPower(chipPower.toString());
				calculationData.setChipDepr(chipDepr.toString());
				calculationData.setChipOther(chipOther.toString());
				calculationData.setSliceMaterial(sliceMaterial.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			basebean.writeLog("错误6");
		}
	}

	// private BigDecimal getRate(QuotationBrowserData data, String formula,
	// BigDecimal bdA, BigDecimal bdB,
	// BigDecimal bdC, BigDecimal bdD) {
	// BigDecimal rate = new BigDecimal(1);
	// ScriptEngine jse = new
	// ScriptEngineManager().getEngineByName("JavaScript");
	// try {
	// BigDecimal A = bdA;
	// BigDecimal B = bdB;
	// BigDecimal C = bdC;
	// BigDecimal D = bdD;
	// rate = new BigDecimal(jse.eval(formula).toString());
	// return rate;
	// } catch (Exception e) {
	// basebean.writeLog("错误7");
	// return rate;
	// }
	//
	// }

	private void calculationWireBond(QuotationBrowserCalculationData calculationData, QuotationBrowserData data) {
		basebean.writeLog("calculationWireBond 开始运行");
		StringBuilder strBuilder = new StringBuilder();
		BigDecimal wirebondMaterial = new BigDecimal(0);
		BigDecimal material = new BigDecimal(0);
		BigDecimal maintenanceCost = new BigDecimal(0);
		BigDecimal labour = new BigDecimal(0);
		BigDecimal power = new BigDecimal(0);
		BigDecimal depr = new BigDecimal(0);
		BigDecimal other = new BigDecimal(0);
		BigDecimal price1 = new BigDecimal(0);
		BigDecimal price2 = new BigDecimal(0);
		BigDecimal currentPirce = new BigDecimal(0);
		BigDecimal pirceStep = new BigDecimal(0);
		BigDecimal pirceDiff = new BigDecimal(0);
		BigDecimal length = new BigDecimal(0);
		BigDecimal wire_qty = new BigDecimal(0);// 标准丝数
		BigDecimal silk = new BigDecimal(0);
		RecordSet rs1 = new RecordSet();
		RecordSet rs2 = new RecordSet();
		String productTypeFast = data.getProductTypeFast();// 生产类型 AO AT TO
		try {
			if (!productTypeFast.equals("TO")) {
				String wireBondFast = (data.getWireBondFast() == null ? "" : data.getWireBondFast());
				String wireDiamFast = (data.getWireDiamFast() == null ? "" : data.getWireDiamFast());
				strBuilder.append(
						"select A.PIRCE, b.PIRCE as PIRCE2, b.CURRENT_PIRCE, a.PIRCE_STEP,a.PIRCE_DIFF,c.LENGTH ");
				strBuilder.append(
						"from MD_SD_WIRE_UNIT_PIRCE a left join md_sd_wire b on A.WIRE_FK=B.ID left join MD_SD_WIRE_DIAM c on A.WIRE_DIAM_FK =c.id ");
				strBuilder.append("where name = '" + wireBondFast + "' and c.LENGTH = '" + wireDiamFast + "'");
				basebean.writeLog("键合 sql1: " + strBuilder.toString());
				rs1.execute(strBuilder.toString());
				if (rs1.getCounts() > 0) {
					rs1.next();
					price1 = (rs1.getString("PIRCE") == "" || rs1.getString("PIRCE") == null) ? new BigDecimal(0)
							: new BigDecimal(rs1.getString("PIRCE"));// 0.08547
					basebean.writeLog("price1: " + price1);
					price2 = (rs1.getString("PIRCE2") == "" || rs1.getString("PIRCE2") == null) ? new BigDecimal(0)
							: new BigDecimal(rs1.getString("PIRCE2"));// 4600
					basebean.writeLog("price2: " + price2);
					currentPirce = (rs1.getString("CURRENT_PIRCE") == "" || rs1.getString("CURRENT_PIRCE") == null)
							? new BigDecimal(0) : new BigDecimal(rs1.getString("CURRENT_PIRCE"));// 4600
					basebean.writeLog("currentPirce: " + currentPirce);
					pirceStep = (rs1.getString("PIRCE_STEP") == "" || rs1.getString("PIRCE_STEP") == null)
							? new BigDecimal(1) : new BigDecimal(rs1.getString("PIRCE_STEP"));// 100
					basebean.writeLog("pirceStep: " + pirceStep);		
					pirceDiff = (rs1.getString("PIRCE_DIFF") == "" || rs1.getString("PIRCE_DIFF") == null)
							? new BigDecimal(0) : new BigDecimal(rs1.getString("PIRCE_DIFF"));// 0
					basebean.writeLog("pirceDiff: " + pirceDiff);
					silk = (data.getSilkFast() == "" || data.getSilkFast() == null) ? new BigDecimal(0)
							: new BigDecimal(data.getSilkFast());// 丝数
					basebean.writeLog("silk: " + silk);
				}
				strBuilder = new StringBuilder();
				strBuilder.append("select  ID,name,WIRE_LENGTH,WIRE_QTY from MD_SD_QTTN_PKG where id='"
						+ data.getShapeFast() + "'");
				basebean.writeLog("键合 sql2: " + strBuilder.toString());
				rs1.execute(strBuilder.toString());
				rs1.next();
				length = (rs1.getString("WIRE_LENGTH") == "" || rs1.getString("WIRE_LENGTH") == null)
						? new BigDecimal(0) : new BigDecimal(rs1.getString("WIRE_LENGTH"));
				basebean.writeLog("length: " + length);
				wire_qty = (rs1.getString("WIRE_QTY") == "" || rs1.getString("WIRE_QTY") == null) ? new BigDecimal(0)
						: new BigDecimal(rs1.getString("WIRE_QTY"));
				basebean.writeLog("wire_qty: " + wire_qty);
				wirebondMaterial = (price1.add(currentPirce.subtract(price2)
						.divide(pirceStep, 4, BigDecimal.ROUND_HALF_UP).multiply(pirceDiff))).multiply(length)
								.multiply(silk).setScale(4, BigDecimal.ROUND_HALF_UP);
				basebean.writeLog("wirebondMaterial: " + wirebondMaterial);
				calculationData.setWirebondMaterial(wirebondMaterial.toString());

				strBuilder = new StringBuilder();
				strBuilder.append(
						"select b.name,a.QTTN_PKG_FK,c.WIRE_QTY,MTRL_COST,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER ");
				strBuilder.append(
						"from MD_SD_COST_WIRE a left join md_sd_wire b on A.WIRE_FK =B.ID left join MD_SD_QTTN_PKG c on a.QTTN_PKG_FK = c.ID ");
				strBuilder.append(
						"where a.QTTN_PKG_FK = '" + data.getShapeFast() + "' and b.name = '" + wireBondFast + "'");
				basebean.writeLog("键合 sql3: " + strBuilder.toString());
				rs2.execute(strBuilder.toString());
				// 键合工费=外形键合成本设定中所有费用/标准丝数*丝数
				if (rs2.getCounts() > 0) {
					rs2.next();
					material = ((rs2.getString("MTRL_COST") == "" || rs2.getString("MTRL_COST") == null)
							? new BigDecimal(0) : new BigDecimal(rs2.getString("MTRL_COST")))
									.divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP).multiply(silk);
					basebean.writeLog("material: " + material);
					maintenanceCost = ((rs2.getString("MAINTENANCE_COST") == ""
							|| rs2.getString("MAINTENANCE_COST") == null) ? new BigDecimal(0)
									: new BigDecimal(rs2.getString("MAINTENANCE_COST")))
											.divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP).multiply(silk);
					basebean.writeLog("maintenanceCost: " + maintenanceCost);
					labour = ((rs2.getString("LABOUR") == "" || rs2.getString("LABOUR") == null) ? new BigDecimal(0)
							: new BigDecimal(rs2.getString("LABOUR"))).divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP)
									.multiply(silk);
					basebean.writeLog("labour: " + labour);
					power = ((rs2.getString("POWER") == "" || rs2.getString("POWER") == null) ? new BigDecimal(0)
							: new BigDecimal(rs2.getString("POWER"))).divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP)
									.multiply(silk);
					basebean.writeLog("power: " + power);
					depr = ((rs2.getString("DEPR") == "" || rs2.getString("DEPR") == null) ? new BigDecimal(0)
							: new BigDecimal(rs2.getString("DEPR"))).divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP)
									.multiply(silk);
					basebean.writeLog("depr: " + depr);
					other = ((rs2.getString("OTHER") == "" || rs2.getString("OTHER") == null) ? new BigDecimal(0)
							: new BigDecimal(rs2.getString("OTHER"))).divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP)
									.multiply(silk);
					basebean.writeLog("other: " + other);
				}
				calculationData.setShapeWirebondMaterial(material.toString());
				calculationData.setShapeWirebondMaintenance(maintenanceCost.toString());
				calculationData.setShapeWirebondLabour(labour.toString());
				calculationData.setShapeWirebondPower(power.toString());
				calculationData.setShapeWirebondDepr(depr.toString());
				calculationData.setShapeWirebondOther(other.toString());
				calculationData.setWirebondMaterial(wirebondMaterial.toString());
			} else {
				calculationData.setShapeWirebondMaterial(material.toString());
				calculationData.setShapeWirebondMaintenance(maintenanceCost.toString());
				calculationData.setShapeWirebondLabour(labour.toString());
				calculationData.setShapeWirebondPower(power.toString());
				calculationData.setShapeWirebondDepr(depr.toString());
				calculationData.setShapeWirebondOther(other.toString());
				calculationData.setWirebondMaterial(wirebondMaterial.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			basebean.writeLog("错误8");
		}
	}

	@Override
	public void updateFastQuotaion(RequestInfo request, QuotationBrowserData data) {
		StringBuilder strBuilder = new StringBuilder();
		RecordSet rs = new RecordSet();

		try {
			int formId = BillUtil.getFormId(Integer.parseInt(request.getWorkflowid()));
			String requsetId = request.getRequestid();// 获取当前流程的requsetId
			strBuilder.append("update formtable_main_" + formId + " set ");
			strBuilder.append("Trade_way_fast = '" + data.getTradeWayFast() + "', ");
			strBuilder.append("product_type_fast = '" + data.getProductTypeFast() + "', ");
			strBuilder.append("CUST_FAST = '" + data.getCustFast() + "', ");
			strBuilder.append("shape_fast = '" + data.getShapeFast() + "', ");
			strBuilder.append("WIRE_BOND_FAST = '" + data.getWireBondFast() + "', ");
			strBuilder.append("Types_of_bonding_wire = '" + data.getWireBondFast() + "', ");
			strBuilder.append("WIRE_DIAM_FAST = '" + data.getWireDiamFast() + "', ");
			strBuilder.append("Wire_diameter = '" + data.getWireDiamFast() + "', ");
			strBuilder.append("SILK_FAST = '" + data.getSilkFast() + "', ");
			strBuilder.append("Wire_bonding = '" + data.getSilkFast() + "', ");
			strBuilder.append("GRIND_FAST = '" + data.getGrindFast() + "', ");
			strBuilder.append("CHIP_NUM_FAST = '" + data.getChipNumFast() + "', ");
			strBuilder.append("Chip_number = '" + data.getChipNumFast() + "', ");
			strBuilder.append("CHIP_X_FAST = '" + data.getChipXFast() + "', ");
			strBuilder.append("CHIP_Y_FAST = '" + data.getChipYFast() + "', ");
			strBuilder.append("MAT_FAST = '" + data.getMatFast() + "', ");
			strBuilder.append("FORM_FAST = '" + data.getFormFast() + "', ");
			strBuilder.append("GRADE_FAST = '" + data.getGradeFast() + "', ");
			strBuilder.append("TAPING_FAST = '" + data.getTapingFast() + "', ");
			strBuilder.append("FRAMEWORK_TECH_FAST = '" + data.getFrameWorkTechFast() + "', ");
			strBuilder.append("ENCAPSULA_MAT_FAST = '" + data.getEncapsulaMatFast() + "', ");
			strBuilder.append("OTHER_FAST = '" + data.getOtherFast() + "', ");
			strBuilder.append("TEST_MODELS_FAST = '" + data.getTestModelsFast() + "', ");
			strBuilder.append("tester = '" + data.getTestModelsFast() + "', ");
			strBuilder.append("HANDER_FAST = '" + data.getHanderFast() + "', ");
			strBuilder.append("MD_HANDLER = '" + data.getHanderFast() + "', ");
			strBuilder.append("TEST_QUOTATION_WAY_FAST = '" + data.getTestQuotationWayFast() + "', ");
			strBuilder.append("TEST_SITE_FOR_FAST = '" + data.getTestSiteForFast() + "', ");
			strBuilder.append("TEST_OF_TIME_FAST = '" + data.getTestOfTimeFast() + "', ");
			strBuilder.append("UPH_FORMULA_FAST = '" + data.getUphFormulaFast() + "', ");
			strBuilder.append("UPH_FAST = '" + data.getUphFast() + "' ");

			strBuilder.append("where requestid = '" + requsetId + "'");
			rs.execute(strBuilder.toString());
		} catch (Exception e) {
			e.printStackTrace();
			basebean.writeLog("错误9");
		}
	}

	@Override
	public void updateQuotationBrowserCalculation(RequestInfo request, QuotationBrowserData data,
			QuotationBrowserCalculationData calculation) {
		StringBuilder strBuilder = new StringBuilder();
		RecordSet rs = new RecordSet();
		RecordSet rs1 = new RecordSet();
		BigDecimal wirebondMaterial = (calculation.getWirebondMaterial() == ""
				|| calculation.getWirebondMaterial() == null) ? new BigDecimal(0)
						: new BigDecimal(calculation.getWirebondMaterial());
		BigDecimal chipMaterial = (calculation.getChipMaterial() == "" || calculation.getChipMaterial() == null)
				? new BigDecimal(0) : new BigDecimal(calculation.getChipMaterial());
		BigDecimal shapeWirebondMaterial = (calculation.getShapeWirebondMaterial() == ""
				|| calculation.getShapeWirebondMaterial() == null) ? new BigDecimal(0)
						: new BigDecimal(calculation.getShapeWirebondMaterial());
		BigDecimal assembleMaterial = (calculation.getAssembleMaterial() == ""
				|| calculation.getAssembleMaterial() == null) ? new BigDecimal(0)
						: new BigDecimal(calculation.getAssembleMaterial());
		BigDecimal sliceMaterial = (calculation.getSliceMaterial() == "" || calculation.getSliceMaterial() == null)
				? new BigDecimal(0) : new BigDecimal(calculation.getSliceMaterial());
		BigDecimal frameMaterial = (calculation.getFrameMaterial() == "" || calculation.getFrameMaterial() == null)
				? new BigDecimal(0) : new BigDecimal(calculation.getFrameMaterial());
		BigDecimal moldingMaterial = (calculation.getMoldingMaterial() == ""
				|| calculation.getMoldingMaterial() == null) ? new BigDecimal(0)
						: new BigDecimal(calculation.getMoldingMaterial());

		BigDecimal mainMaterial = new BigDecimal(0);
		BigDecimal otherMaterial = new BigDecimal(0);
		BigDecimal assembleLabour = new BigDecimal(0);
		BigDecimal assemblePower = new BigDecimal(0);
		BigDecimal assembleDepr = new BigDecimal(0);
		BigDecimal assembleMaintenance = new BigDecimal(0);
		BigDecimal assembleOther = new BigDecimal(0);
		BigDecimal thouTotal = new BigDecimal(0);
		BigDecimal testerHourTotal = new BigDecimal(0);
		BigDecimal testerThouTotal = new BigDecimal(0);
		BigDecimal packTotal = new BigDecimal(0);
		BigDecimal materialTotal = new BigDecimal(0);
		BigDecimal labourTotal = new BigDecimal(0);
		BigDecimal powerTotal = new BigDecimal(0);
		BigDecimal deprTotal = new BigDecimal(0);
		BigDecimal maintenanceTotal = new BigDecimal(0);
		BigDecimal otherTotal = new BigDecimal(0);
		BigDecimal total = new BigDecimal(0);
		BigDecimal rate = new BigDecimal(1);

		mainMaterial = wirebondMaterial.add(sliceMaterial).add(frameMaterial).add(moldingMaterial);// 主材
		basebean.writeLog("wirebondMaterial: " + wirebondMaterial);
		basebean.writeLog("sliceMaterial: " + sliceMaterial);
		basebean.writeLog("frameMaterial: " + frameMaterial);
		basebean.writeLog("moldingMaterial: " + moldingMaterial);
		otherMaterial = (chipMaterial.add(shapeWirebondMaterial).add(assembleMaterial)).subtract(sliceMaterial)
				.subtract(frameMaterial).subtract(moldingMaterial);// 其他材料
		basebean.writeLog("chipMaterial: " + chipMaterial);
		basebean.writeLog("shapeWirebondMaterial: " + shapeWirebondMaterial);
		basebean.writeLog("assembleMaterial: " + assembleMaterial);
		assembleLabour = (new BigDecimal(calculation.getChipLabour()))
				.add(new BigDecimal(calculation.getShapeWirebondLabour()))
				.add(new BigDecimal(calculation.getAssembleLabour()));
		assemblePower = (new BigDecimal(calculation.getChipPower()))
				.add(new BigDecimal(calculation.getShapeWirebondPower()))
				.add(new BigDecimal(calculation.getAssemblePower()));
		assembleDepr = (new BigDecimal(calculation.getChipDepr()))
				.add(new BigDecimal(calculation.getShapeWirebondDepr()))
				.add(new BigDecimal(calculation.getAssembleDepr()));
		assembleMaintenance = (new BigDecimal(calculation.getChipMaintenance()))
				.add(new BigDecimal(calculation.getShapeWirebondMaintenance()))
				.add(new BigDecimal(calculation.getAssembleMaintenance()));
		assembleOther = (new BigDecimal(calculation.getChipOther()))
				.add(new BigDecimal(calculation.getShapeWirebondOther()))
				.add(new BigDecimal(calculation.getAssembleOther()));
		thouTotal = mainMaterial.add(otherMaterial).add(assembleLabour).add(assemblePower).add(assembleDepr)
				.add(assembleMaintenance).add(assembleOther);
		packTotal = (new BigDecimal(calculation.getPackageMaterial()))
				.add(new BigDecimal(calculation.getPackageLabour())).add(new BigDecimal(calculation.getPackagePower()))
				.add(new BigDecimal(calculation.getPackageDepr()))
				.add(new BigDecimal(calculation.getPackageMaintenance()))
				.add(new BigDecimal(calculation.getPackageOther()));
		testerHourTotal = (new BigDecimal(calculation.getTesterLabour()))
				.add(new BigDecimal(calculation.getTesterPower())).add(new BigDecimal(calculation.getTesterDepr()))
				.add(new BigDecimal(calculation.getTesterMaintenance()))
				.add(new BigDecimal(calculation.getTesterOther()));
		testerThouTotal = (new BigDecimal(calculation.getTesterThouLabour()))
				.add(new BigDecimal(calculation.getTesterThouPower()))
				.add(new BigDecimal(calculation.getTesterThouDepr()))
				.add(new BigDecimal(calculation.getTesterThouMaintenance()))
				.add(new BigDecimal(calculation.getTesterThouOther()));
		materialTotal = mainMaterial.add(otherMaterial).add(new BigDecimal(calculation.getPackageMaterial()));

		if (data.getTestQuotationWayFast().equals("1")) {
			labourTotal = assembleLabour.add(new BigDecimal(calculation.getTesterLabour()))
					.add(new BigDecimal(calculation.getPackageLabour()));
			powerTotal = assemblePower.add(new BigDecimal(calculation.getTesterPower()))
					.add(new BigDecimal(calculation.getPackagePower()));
			deprTotal = assembleDepr.add(new BigDecimal(calculation.getTesterDepr()))
					.add(new BigDecimal(calculation.getPackageDepr()));
			maintenanceTotal = assembleMaintenance.add(new BigDecimal(calculation.getTesterMaintenance()))
					.add(new BigDecimal(calculation.getPackageMaintenance()));
			otherTotal = assembleOther.add(new BigDecimal(calculation.getTesterOther()))
					.add(new BigDecimal(calculation.getPackageOther()));
		} else {
			labourTotal = assembleLabour.add(new BigDecimal(calculation.getTesterThouLabour()))
					.add(new BigDecimal(calculation.getPackageLabour()));
			powerTotal = assemblePower.add(new BigDecimal(calculation.getTesterThouPower()))
					.add(new BigDecimal(calculation.getPackagePower()));
			deprTotal = assembleDepr.add(new BigDecimal(calculation.getTesterThouDepr()))
					.add(new BigDecimal(calculation.getPackageDepr()));
			maintenanceTotal = assembleMaintenance.add(new BigDecimal(calculation.getTesterThouMaintenance()))
					.add(new BigDecimal(calculation.getPackageMaintenance()));
			otherTotal = assembleOther.add(new BigDecimal(calculation.getTesterThouOther()))
					.add(new BigDecimal(calculation.getPackageOther()));
		}
		total = materialTotal.add(labourTotal).add(powerTotal).add(deprTotal).add(maintenanceTotal).add(otherTotal); // 9.93
		try {
			int formId = BillUtil.getFormId(Integer.parseInt(request.getWorkflowid()));
			String requsetId = request.getRequestid();// 获取当前流程的requsetId

			strBuilder.append("select rate from MD_SD_EXCHANGE_RATE where FROM_FK = 'USD' and TO_FK = 'CNY'");
			rs1.execute(strBuilder.toString());
			if (rs1.getCounts() > 0) {
				rs1.next();
				rate = (rs1.getString("rate") == "" ? new BigDecimal(1) : new BigDecimal(rs1.getString("rate")));
			}
			basebean.writeLog("Adv_mat_assy = " + mainMaterial.toString());// 23.43
			basebean.writeLog("Oth_mat_assy = " + otherMaterial.toString());// 4.90
			basebean.writeLog("Mat_com_assy = " + (mainMaterial.add(otherMaterial)).toString());
			strBuilder = new StringBuilder();
			strBuilder.append("update formtable_main_" + formId + " set ");
			strBuilder.append("exchange_rate = '" + rate.toString() + "', ");
			strBuilder.append("wire_bond_price = '" + calculation.getWirebondMaterial() + "', ");
			strBuilder.append("frame_price = '" + calculation.getFrameMaterial() + "', ");
			strBuilder.append("molding_price = '" + calculation.getMoldingMaterial() + "', ");
			strBuilder.append("slice_price = '" + calculation.getSliceMaterial() + "', ");
			strBuilder.append("Adv_mat_assy = '" + mainMaterial.toString() + "', ");
			strBuilder.append("Oth_mat_assy = '" + otherMaterial.toString() + "', ");
			strBuilder.append("Mat_com_assy = '" + (mainMaterial.add(otherMaterial)).toString() + "', ");
			strBuilder.append("artifi_assy = '" + assembleLabour.toString() + "', ");
			strBuilder.append("power_assy = '" + assemblePower.toString() + "', ");
			strBuilder.append("deprect_assy = '" + assembleDepr.toString() + "', ");
			strBuilder.append("maintain_assy = '" + assembleMaintenance.toString() + "', ");
			strBuilder.append("other_assy = '" + assembleOther.toString() + "', ");
			strBuilder.append("thou_tal_cost_assy = '" + thouTotal.toString() + "', ");
			strBuilder.append("tester_time = '" + data.getTestModelsFast() + "', ");
			strBuilder.append("hander_time = '" + data.getHanderFast() + "', ");
			strBuilder.append("mat_time = '0.0', ");
			strBuilder.append("artifi_time = '" + calculation.getTesterLabour() + "', ");
			strBuilder.append("power_time = '" + calculation.getTesterPower() + "', ");
			strBuilder.append("deprect_time = '" + calculation.getTesterDepr() + "', ");
			strBuilder.append("maintain_time = '" + calculation.getTesterMaintenance() + "', ");
			strBuilder.append("other_time = '" + calculation.getTesterOther() + "', ");
			strBuilder.append("test_tal_cost_time = '" + testerHourTotal.toString() + "', ");
			strBuilder.append("tester_thou = '" + data.getTestModelsFast() + "', ");
			strBuilder.append("hander_thou = '" + data.getHanderFast() + "', ");
			strBuilder.append("mat_thou = '0.0', ");
			strBuilder.append("artifi_thou = '" + calculation.getTesterThouLabour() + "', ");
			strBuilder.append("power_thou = '" + calculation.getTesterThouPower() + "', ");
			strBuilder.append("deprect_thou = '" + calculation.getTesterThouDepr() + "', ");
			strBuilder.append("maintain_thou = '" + calculation.getTesterThouMaintenance() + "', ");
			strBuilder.append("other_thou = '" + calculation.getTesterThouOther() + "', ");
			strBuilder.append("test_tal_cost_thou = '" + testerThouTotal.toString() + "', ");
			strBuilder.append("form_pack = '" + data.getFormFast() + "', ");
			strBuilder.append("grade_pack = '" + data.getGradeFast() + "', ");

			strBuilder.append("mat_totl = '" + materialTotal.toString() + "', ");
			strBuilder.append("Artif_totl = '" + labourTotal.toString() + "', ");
			strBuilder.append("power_totl = '" + powerTotal.toString() + "', ");
			strBuilder.append("deprec_totl = '" + deprTotal.toString() + "', ");
			strBuilder.append("maint_totl = '" + maintenanceTotal.toString() + "', ");
			strBuilder.append("other_totl = '" + otherTotal.toString() + "', ");
			strBuilder.append("total_cost_totl = '" + total.toString() + "', ");
			strBuilder.append("mat_pack = '" + calculation.getPackageMaterial() + "', ");
			strBuilder.append("artifi_pack = '" + calculation.getPackageLabour() + "', ");
			strBuilder.append("power_pack = '" + calculation.getPackagePower() + "', ");
			strBuilder.append("deprect_pack = '" + calculation.getPackageDepr() + "', ");
			strBuilder.append("maintain_pack = '" + calculation.getPackageMaintenance() + "', ");
			strBuilder.append("other_pack = '" + calculation.getPackageOther() + "', ");
			strBuilder.append("pack_tal_cost_pack = '" + packTotal.toString() + "' ");
			strBuilder.append("where requestid = '" + requsetId + "'");
			rs.execute(strBuilder.toString());
		} catch (Exception e) {
			e.printStackTrace();
			basebean.writeLog("错误10");
		}
	}

}

/**
 * ****************************************************************************
 * System      : weaver
 * Module      : weaver.interfaces.workflow.entity.quotation
 * File Name   : QuotationBrowserCalculationData.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年10月26日     peng.xu     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.entity.quotation;

/**
 * @author peng.xu
 *
 */
public class QuotationBrowserCalculationData {
    // 键合成本
    private String wirebondMaterial;
    // 装片材料
    private String sliceMaterial;
    // 芯片材料
    private String chipMaterial;
    // 芯片维修费用
    private String chipMaintenance;
    // 芯片人工费用
    private String chipLabour;
    // 芯片动力费用
    private String chipPower;
    // 芯片折旧费用
    private String chipDepr;
    // 芯片其他费用
    private String chipOther;
    // 外形键合材料
    private String shapeWirebondMaterial;
    // 外形键合维修费用
    private String shapeWirebondMaintenance;
    // 外形键合人工费用
    private String shapeWirebondLabour;
    // 外形键合折旧费用
    private String shapeWirebondDepr;
    // 外形键合动力费用
    private String shapeWirebondPower;
    // 外形键合其他费用
    private String shapeWirebondOther;
    // 框架工艺材料
    private String frameMaterial;
    // 塑封料材料
    private String moldingMaterial;
    // 组装材料
    private String assembleMaterial;
    // 组装维修费用
    private String assembleMaintenance;
    // 组装人工费用
    private String assembleLabour;
    // 组装动力费用
    private String assemblePower;
    // 组装折旧费用
    private String assembleDepr;
    // 组装其他费用
    private String assembleOther;
    // 测试维修费用(小时)
    private String testerMaintenance;
    // 测试人工费用(小时)
    private String testerLabour;
    // 测试动力费用(小时)
    private String testerPower;
    // 测试折旧费用(小时)
    private String testerDepr;
    // 测试其他费用(小时)
    private String testerOther;
    // 测试维修费用(千只)
    private String testerThouMaintenance;
    // 测试人工费用(千只)
    private String testerThouLabour;
    // 测试动力费用(千只)
    private String testerThouPower;
    // 测试折旧费用(千只)
    private String testerThouDepr;
    // 测试其他费用(千只)
    private String testerThouOther;
    // 包装材料
    private String packageMaterial;
    // 包装维修费用
    private String packageMaintenance;
    // 包装人工费用
    private String packageLabour;
    // 包装动力费用
    private String packagePower;
    // 包装折旧费用
    private String packageDepr;
    // 包装其他费用
    private String packageOther;
    // 塑封料系数
    private String rate_emat;
    // 框架工艺系数
    private String rate_ftech;

    public String getWirebondMaterial() {
	return wirebondMaterial;
    }

    public void setWirebondMaterial(String wirebondMaterial) {
	this.wirebondMaterial = wirebondMaterial;
    }

    public String getSliceMaterial() {
	return sliceMaterial;
    }

    public void setSliceMaterial(String sliceMaterial) {
	this.sliceMaterial = sliceMaterial;
    }

    public String getChipMaterial() {
	return chipMaterial;
    }

    public void setChipMaterial(String chipMaterial) {
	this.chipMaterial = chipMaterial;
    }

    public String getChipMaintenance() {
	return chipMaintenance;
    }

    public void setChipMaintenance(String chipMaintenance) {
	this.chipMaintenance = chipMaintenance;
    }

    public String getChipLabour() {
	return chipLabour;
    }

    public void setChipLabour(String chipLabour) {
	this.chipLabour = chipLabour;
    }

    public String getChipPower() {
	return chipPower;
    }

    public void setChipPower(String chipPower) {
	this.chipPower = chipPower;
    }

    public String getChipDepr() {
	return chipDepr;
    }

    public void setChipDepr(String chipDepr) {
	this.chipDepr = chipDepr;
    }

    public String getChipOther() {
	return chipOther;
    }

    public void setChipOther(String chipOther) {
	this.chipOther = chipOther;
    }

    public String getShapeWirebondMaterial() {
	return shapeWirebondMaterial;
    }

    public void setShapeWirebondMaterial(String shapeWirebondMaterial) {
	this.shapeWirebondMaterial = shapeWirebondMaterial;
    }

    public String getShapeWirebondMaintenance() {
	return shapeWirebondMaintenance;
    }

    public void setShapeWirebondMaintenance(String shapeWirebondMaintenance) {
	this.shapeWirebondMaintenance = shapeWirebondMaintenance;
    }

    public String getShapeWirebondLabour() {
	return shapeWirebondLabour;
    }

    public void setShapeWirebondLabour(String shapeWirebondLabour) {
	this.shapeWirebondLabour = shapeWirebondLabour;
    }

    public String getShapeWirebondDepr() {
	return shapeWirebondDepr;
    }

    public void setShapeWirebondDepr(String shapeWirebondDepr) {
	this.shapeWirebondDepr = shapeWirebondDepr;
    }

    public String getShapeWirebondPower() {
	return shapeWirebondPower;
    }

    public void setShapeWirebondPower(String shapeWirebondPower) {
	this.shapeWirebondPower = shapeWirebondPower;
    }

    public String getShapeWirebondOther() {
	return shapeWirebondOther;
    }

    public void setShapeWirebondOther(String shapeWirebondOther) {
	this.shapeWirebondOther = shapeWirebondOther;
    }

    public String getFrameMaterial() {
	return frameMaterial;
    }

    public void setFrameMaterial(String frameMaterial) {
	this.frameMaterial = frameMaterial;
    }

    public String getMoldingMaterial() {
	return moldingMaterial;
    }

    public void setMoldingMaterial(String moldingMaterial) {
	this.moldingMaterial = moldingMaterial;
    }

    public String getAssembleMaterial() {
	return assembleMaterial;
    }

    public void setAssembleMaterial(String assembleMaterial) {
	this.assembleMaterial = assembleMaterial;
    }

    public String getAssembleMaintenance() {
	return assembleMaintenance;
    }

    public void setAssembleMaintenance(String assembleMaintenance) {
	this.assembleMaintenance = assembleMaintenance;
    }

    public String getAssembleLabour() {
	return assembleLabour;
    }

    public void setAssembleLabour(String assembleLabour) {
	this.assembleLabour = assembleLabour;
    }

    public String getAssemblePower() {
	return assemblePower;
    }

    public void setAssemblePower(String assemblePower) {
	this.assemblePower = assemblePower;
    }

    public String getAssembleDepr() {
	return assembleDepr;
    }

    public void setAssembleDepr(String assembleDepr) {
	this.assembleDepr = assembleDepr;
    }

    public String getAssembleOther() {
	return assembleOther;
    }

    public void setAssembleOther(String assembleOther) {
	this.assembleOther = assembleOther;
    }

    public String getTesterMaintenance() {
	return testerMaintenance;
    }

    public void setTesterMaintenance(String testerMaintenance) {
	this.testerMaintenance = testerMaintenance;
    }

    public String getTesterLabour() {
	return testerLabour;
    }

    public void setTesterLabour(String testerLabour) {
	this.testerLabour = testerLabour;
    }

    public String getTesterPower() {
	return testerPower;
    }

    public void setTesterPower(String testerPower) {
	this.testerPower = testerPower;
    }

    public String getTesterDepr() {
	return testerDepr;
    }

    public void setTesterDepr(String testerDepr) {
	this.testerDepr = testerDepr;
    }

    public String getTesterOther() {
	return testerOther;
    }

    public void setTesterOther(String testerOther) {
	this.testerOther = testerOther;
    }

    public String getTesterThouMaintenance() {
	return testerThouMaintenance;
    }

    public void setTesterThouMaintenance(String testerThouMaintenance) {
	this.testerThouMaintenance = testerThouMaintenance;
    }

    public String getTesterThouLabour() {
	return testerThouLabour;
    }

    public void setTesterThouLabour(String testerThouLabour) {
	this.testerThouLabour = testerThouLabour;
    }

    public String getTesterThouPower() {
	return testerThouPower;
    }

    public void setTesterThouPower(String testerThouPower) {
	this.testerThouPower = testerThouPower;
    }

    public String getTesterThouDepr() {
	return testerThouDepr;
    }

    public void setTesterThouDepr(String testerThouDepr) {
	this.testerThouDepr = testerThouDepr;
    }

    public String getTesterThouOther() {
	return testerThouOther;
    }

    public void setTesterThouOther(String testerThouOther) {
	this.testerThouOther = testerThouOther;
    }

    public String getPackageMaterial() {
	return packageMaterial;
    }

    public void setPackageMaterial(String packageMaterial) {
	this.packageMaterial = packageMaterial;
    }

    public String getPackageMaintenance() {
	return packageMaintenance;
    }

    public void setPackageMaintenance(String packageMaintenance) {
	this.packageMaintenance = packageMaintenance;
    }

    public String getPackageLabour() {
	return packageLabour;
    }

    public void setPackageLabour(String packageLabour) {
	this.packageLabour = packageLabour;
    }

    public String getPackagePower() {
	return packagePower;
    }

    public void setPackagePower(String packagePower) {
	this.packagePower = packagePower;
    }

    public String getPackageDepr() {
	return packageDepr;
    }

    public void setPackageDepr(String packageDepr) {
	this.packageDepr = packageDepr;
    }

    public String getPackageOther() {
	return packageOther;
    }

    public void setPackageOther(String packageOther) {
	this.packageOther = packageOther;
    }

	public String getRate_emat() {
		return rate_emat;
	}

	public void setRate_emat(String rate_emat) {
		this.rate_emat = rate_emat;
	}

	public String getRate_ftech() {
		return rate_ftech;
	}

	public void setRate_ftech(String rate_ftech) {
		this.rate_ftech = rate_ftech;
	}

}

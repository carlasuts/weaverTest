/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.sap.reprocessinTFME.entity
 * File Name   : ReprocessinTFMEDt2.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年9月8日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.sap.reprocessinTFME.entity;

/**
 * @author zong.yq
 *
 *         在库重工 明细表2实体类
 */
public class ReprocessinTFMEDt2 {

	/** 主表id */
	private int mainid;
	/** 子生产批号 */
	private String lotCode;
	/** 母生产批号 */
	private String parentLotCode;
	/** 料号 */
	private String material;
	/** 批次 */
	private String batch;
	/** 数量 */
	private int qty;
	/** 目标批次 */
	private String destBatch;
	/** 随工单 */
	private String subProductionOrder;
	/** 生产订单号 */
	private String productionOrder;
	/** 销售订单号 */
	private String salesOrder;
	/** 组装批号 */
	private String assyLot;
	/** 扩散批号 */
	private String waferLot;
	/** 库存地点 */
	private String storageLocation;
	/** 箱号 */
	private String boxNo;
	/** 整理编号 */
	private String traceCode;
	/** 品名描述 */
	private String description;
	/** 年周号 */
	private String workWeek;
	/** 销售订单行项 */
	private String salesOrderItem;

	public String getLotCode() {
		return lotCode;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public void setLotCode(String lotCode) {
		this.lotCode = lotCode;
	}

	public String getParentLotCode() {
		return parentLotCode;
	}

	public void setParentLotCode(String parentLotCode) {
		this.parentLotCode = parentLotCode;
	}

	public String getMaterial() {
		return material;
	}

	public void setMaterial(String material) {
		this.material = material;
	}

	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(Integer qty) {
		this.qty = qty;
	}

	public String getDestBatch() {
		return destBatch;
	}

	public void setDestBatch(String destBatch) {
		this.destBatch = destBatch;
	}

	public String getSubProductionOrder() {
		return subProductionOrder;
	}

	public void setSubProductionOrder(String subProductionOrder) {
		this.subProductionOrder = subProductionOrder;
	}

	public String getProductionOrder() {
		return productionOrder;
	}

	public void setProductionOrder(String productionOrder) {
		this.productionOrder = productionOrder;
	}

	public String getSalesOrder() {
		return salesOrder;
	}

	public void setSalesOrder(String salesOrder) {
		this.salesOrder = salesOrder;
	}

	public String getAssyLot() {
		return assyLot;
	}

	public void setAssyLot(String assyLot) {
		this.assyLot = assyLot;
	}

	public String getWaferLot() {
		return waferLot;
	}

	public void setWaferLot(String waferLot) {
		this.waferLot = waferLot;
	}

	public String getStorageLocation() {
		return storageLocation;
	}

	public void setStorageLocation(String storageLocation) {
		this.storageLocation = storageLocation;
	}

	public String getBoxNo() {
		return boxNo;
	}

	public void setBoxNo(String boxNo) {
		this.boxNo = boxNo;
	}

	public int getMainid() {
		return mainid;
	}

	public void setMainid(int mainid) {
		this.mainid = mainid;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @return the traceCode
	 */
	public String getTraceCode() {
		return traceCode;
	}

	/**
	 * @param traceCode
	 *            the traceCode to set
	 */
	public void setTraceCode(String traceCode) {
		this.traceCode = traceCode;
	}

	/**
	 * @return the workWeek
	 */
	public String getWorkWeek() {
		return workWeek;
	}

	/**
	 * @param workWeek
	 *            the workWeek to set
	 */
	public void setWorkWeek(String workWeek) {
		this.workWeek = workWeek;
	}

	/**
	 * @return the salesOrderItem
	 */
	public String getSalesOrderItem() {
		return salesOrderItem;
	}

	/**
	 * @param salesOrderItem
	 *            the salesOrderItem to set
	 */
	public void setSalesOrderItem(String salesOrderItem) {
		this.salesOrderItem = salesOrderItem;
	}

}

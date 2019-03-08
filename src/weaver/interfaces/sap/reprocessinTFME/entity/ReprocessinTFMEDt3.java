/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.sap.reprocessinTFME.entity
 * File Name   : ReprocessinTFMEDt3.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年9月21日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.sap.reprocessinTFME.entity;

/**
 * @author zong.yq
 * 
 *         在库重工 明细表3实体类
 */
/**
 * @author peng.xu
 *
 */
public class ReprocessinTFMEDt3 {

	/** 主表id */
	private int mainid;
	/** 数量 */
	private int qty;
	/** 最终批次 */
	private String finalBatch;
	/** 扩散批号 */
	private String waferLot;
	/** 箱号 */
	private String boxNo;
	/** 组装批号 */
	private String assyLot;
	/** 整理编号 */
	private String traceCode;
	/** 年周号 */
	private String workWeek;

	public int getMainid() {
		return mainid;
	}

	public void setMainid(int mainid) {
		this.mainid = mainid;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public String getFinalBatch() {
		return finalBatch;
	}

	public void setFinalBatch(String finalBatch) {
		this.finalBatch = finalBatch;
	}

	public String getWaferLot() {
		return waferLot;
	}

	public void setWaferLot(String waferLot) {
		this.waferLot = waferLot;
	}

	public String getBoxNo() {
		return boxNo;
	}

	public void setBoxNo(String boxNo) {
		this.boxNo = boxNo;
	}

	public String getAssyLot() {
		return assyLot;
	}

	public void setAssyLot(String assyLot) {
		this.assyLot = assyLot;
	}

	public String getTraceCode() {
	    return traceCode;
	}

	public void setTraceCode(String traceCode) {
	    this.traceCode = traceCode;
	}

	public String getWorkWeek() {
	    return workWeek;
	}

	public void setWorkWeek(String workWeek) {
	    this.workWeek = workWeek;
	}

}

/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.sap
 * File Name   : PostTest.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年9月13日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.sap;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.mes.entity.CInfBomDat;
import weaver.interfaces.mes.entity.CInfFlwDat;
import weaver.interfaces.mes.entity.CInfPatDat;
import weaver.interfaces.mes.entity.CInfSpeDat;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 *
 */
public class PostTest implements Action {

	private static final String url = "http://172.16.60.96:8099/MesWebService/req";
	private BaseBean baseBean = new BaseBean();

	CInfSpeDat cInfSpeDat = new CInfSpeDat();
	CInfPatDat cInfPatDat = new CInfPatDat();
	CInfFlwDat cInfFlwDat = new CInfFlwDat();
	CInfBomDat cInfBomDat = new CInfBomDat();
	String sql = "";
	JSONArray cInfSpeDatList = new JSONArray();
	JSONArray cinfPatDatList = new JSONArray();
	JSONArray cinfFlwDatList = new JSONArray();
	JSONArray cinfBomDatList = new JSONArray();
	JSONObject json = new JSONObject();
	JSONObject req = new JSONObject();
	JSONObject message = new JSONObject();
	RecordSet rs = new RecordSet();

	public void oaToMes(RequestInfo request) {
		String requestId = request.getRequestid();
		baseBean.writeLog("当前流程的requestId" + requestId);
		try {
			sql = "select * from cinfspedat where requestid = " + requestId;
			rs.execute(sql);
			while (rs.next()) {
				cInfSpeDat.setInfTime(rs.getString("INF_TIME"));
				cInfSpeDat.setInfSeq(Integer.valueOf(rs.getString("INF_SEQ")));
				cInfSpeDat.setFactory(rs.getString("FACTORY"));
				cInfSpeDat.setMatId(rs.getString("MAT_ID"));
				cInfSpeDat.setCustId(rs.getString("CUST_ID"));
				cInfSpeDat.setCustMatId(rs.getString("CUST_MAT_ID"));
				cInfSpeDat.setCustMatDesc(rs.getString("CUST_MAT_DESC"));
				cInfSpeDat.setDbMatId(rs.getString("DB_MAT_ID"));
				cInfSpeDat.setPkgType(rs.getString("PKG_TYPE"));
				cInfSpeDat.setPackCode(rs.getString("PACK_CODE"));
				cInfSpeDat.setPkldCode(rs.getString("PKLD_CODE"));
				cInfSpeDat.setAddBondDiagramNo(rs.getString("ADD_BOND_DIAGRAM_NO"));
				cInfSpeDat.setAddBondDiagramRev(rs.getString("ADD_BOND_DIAGRAM_REV"));
				cInfSpeDat.setFlowId(rs.getString("FLOW_ID"));
				cInfSpeDat.setOrgCustDeviceId(rs.getString("ORG_CUST_DEVICE_ID"));
				cInfSpeDat.setTopMarkFormatId(rs.getString("TOP_MARK_FORMAT_ID"));
				cInfSpeDat.setBackMarkFormatId(rs.getString("BACK_MARK_FORMAT_ID"));
				cInfSpeDat.setRecipeGroup(rs.getString("RECIPE_GROUP"));
				cInfSpeDat.setStdLotSize(rs.getString("STD_LOT_SIZE"));
				cInfSpeDat.setMatUnit(rs.getString("MAT_UNIT"));
				cInfSpeDat.setBuOper(rs.getString("BU_OPER"));
				cInfSpeDat.setTnrStdOutboxQty(rs.getString("TNR_STD_OUTBOX_QTY"));
				cInfSpeDat.setTubeStdOutboxQty(rs.getString("TUBE_STD_OUTBOX_QTY"));
				cInfSpeDat.setTubeRealPackQty(rs.getString("TUBE_REAL_PACK_QTY"));
				cInfSpeDat.setStdPackQty(rs.getString("STD_PACK_QTY"));
				cInfSpeDat.setHalfPackQty(rs.getString("HALF_PACK_QTY"));
				cInfSpeDat.setTnrQty(rs.getString("TNR_QTY"));
				cInfSpeDat.setTubeQty(rs.getString("TUBE_QTY"));
				cInfSpeDat.setTrNeedFullInbox(rs.getString("TR_NEED_FULL_INBOX"));
				cInfSpeDat.setInfo1(rs.getString("INFO1"));
				cInfSpeDat.setInfo2(rs.getString("INFO2"));
				cInfSpeDat.setInfo3(rs.getString("INFO3"));
				cInfSpeDat.setInfo4(rs.getString("INFO4"));
				cInfSpeDat.setInfo5(rs.getString("INFO5"));
				cInfSpeDat.setLable1(rs.getString("LABLE1"));
				cInfSpeDat.setLable2(rs.getString("LABLE2"));
				cInfSpeDat.setLable3(rs.getString("LABLE3"));
				cInfSpeDat.setLable4(rs.getString("LABLE4"));
				cInfSpeDat.setLable5(rs.getString("LABLE5"));
				cInfSpeDat.setLable6(rs.getString("LABLE6"));
				cInfSpeDat.setLable7(rs.getString("LABLE7"));
				cInfSpeDat.setLable8(rs.getString("LABLE8"));
				cInfSpeDat.setLable9(rs.getString("LABLE9"));
				cInfSpeDat.setLable10(rs.getString("LABLE10"));
				cInfSpeDat.setLable11(rs.getString("LABLE11"));
				cInfSpeDat.setLable12(rs.getString("LABLE12"));
				cInfSpeDat.setLable13(rs.getString("LABLE13"));
				cInfSpeDat.setLable14(rs.getString("LABLE14"));
				cInfSpeDat.setLable15(rs.getString("LABLE15"));
				cInfSpeDat.setLable16(rs.getString("LABLE16"));
				cInfSpeDat.setLable17(rs.getString("LABLE17"));
				cInfSpeDat.setLable18(rs.getString("LABLE18"));
				cInfSpeDat.setLable19(rs.getString("LABLE19"));
				cInfSpeDat.setLable20(rs.getString("LABLE20"));
				cInfSpeDat.setMark1(rs.getString("MARK1"));
				cInfSpeDat.setMark2(rs.getString("MARK2"));
				cInfSpeDat.setMark3(rs.getString("MARK3"));
				cInfSpeDat.setMark4(rs.getString("MARK4"));
				cInfSpeDat.setMark5(rs.getString("MARK5"));
				cInfSpeDat.setTrDataType(rs.getString("TR_DATA_TYPE"));
				cInfSpeDat.setInstruction1(rs.getString("INSTRUCTION1"));
				cInfSpeDat.setInstruction2(rs.getString("INSTRUCTION2"));
				cInfSpeDat.setInstruction3(rs.getString("INSTRUCTION3"));
				cInfSpeDat.setUpperWfThick(rs.getString("UPPER_WF_THICK"));
				cInfSpeDat.setLowerWfThick(rs.getString("LOWER_WF_THICK"));
				cInfSpeDat.setWfSize(rs.getString("WF_SIZE"));
				cInfSpeDat.setPrimaryTcard(rs.getString("PRIMARY_TCARD"));
				cInfSpeDat.setMsllabel(rs.getString("MSLLABEL"));
				cInfSpeDat.setBsmCode(rs.getString("BSM_CODE"));
				cInfSpeDat.setLotCode(rs.getString("LOT_CODE"));
				cInfSpeDat.setTsmCode(rs.getString("TSM_CODE"));
				cInfSpeDat.setOutDevice(rs.getString("OUT_DEVICE"));
				cInfSpeDat.setMarkngSpecVersion(rs.getString("MARKNG_SPEC_VERSION"));
				cInfSpeDat.setChipSizeX(rs.getString("CHIP_SIZE_X"));
				cInfSpeDat.setChipSizeY(rs.getString("CHIP_SIZE_Y"));
				cInfSpeDat.setScribeWidth(rs.getString("SCRIBE_WIDTH"));
				cInfSpeDat.setBpo(rs.getString("BPO"));
				cInfSpeDat.setBpp(rs.getString("BPP"));
				cInfSpeDat.setCardProcFg(rs.getString("CARD_PROC_FG"));
				cInfSpeDat.setPbFreeFg(rs.getString("PB_FREE_FG"));
				cInfSpeDat.setDieDown(rs.getString("DIE_DOWN"));
				cInfSpeDat.setBomNo(rs.getString("BOM_NO"));
				cInfSpeDat.setGrpDevice(rs.getString("GRP_DEVICE"));
				cInfSpeDat.setProdClass(rs.getString("PROD_CLASS"));
				cInfSpeDat.setSubLotSize(rs.getString("SUB_LOT_SIZE"));
				cInfSpeDat.setMaxAsyLotCnt(rs.getString("MAX_ASY_LOT_CNT"));
				cInfSpeDat.setWfIngredients(rs.getString("WF_INGREDIENTS"));
				cInfSpeDat.setChipType(rs.getString("CHIP_TYPE"));
				cInfSpeDat.setDaMode(rs.getString("DA_MODE"));
				cInfSpeDat.setDieCoating(rs.getString("DIE_COATING"));
				cInfSpeDat.setHygrosLevel(rs.getString("HYGROS_LEVEL"));
				cInfSpeDat.setCoatingType(rs.getString("COATING_TYPE"));
				cInfSpeDat.setCarProd(rs.getString("CAR_PROD"));
				cInfSpeDat.setMark(rs.getString("MARK"));
				cInfSpeDat.setPlate(rs.getString("PLATE"));
				cInfSpeDat.setReelSize(rs.getString("REEL_SIZE"));
				cInfSpeDat.setReelDiraction(rs.getString("REEL_DIRACTION"));
				cInfSpeDat.setRellQty(rs.getString("RELL_QTY"));
				cInfSpeDat.setHalogenFProd(rs.getString("HALOGEN_F_PROD"));
				cInfSpeDat.setStripProd(rs.getString("STRIP_PROD"));
				cInfSpeDat.setPadType(rs.getString("PAD_TYPE"));
				cInfSpeDat.setTestFlwChart(rs.getString("TEST_FLW_CHART"));
				cInfSpeDat.setTestPlatfom(rs.getString("TEST_PLATFOM"));
				cInfSpeDat.setTestSystem(rs.getString("TEST_SYSTEM"));
				cInfSpeDat.setTestHandler(rs.getString("TEST_HANDLER"));
				cInfSpeDat.setTestPrgRev1(rs.getString("TEST_PRG_REV1"));
				cInfSpeDat.setQaPrg1(rs.getString("QA_PRG1"));
				cInfSpeDat.setQaPrg2(rs.getString("QA_PRG2"));
				cInfSpeDat.setTestTempe(rs.getString("TEST_TEMPE"));
				cInfSpeDat.setDieRunCodeFg(rs.getString("DIE_RUN_CODE_FG"));
				cInfSpeDat.setAssyTestFg(rs.getString("ASSY_TEST_FG"));
				cInfSpeDat.setStdCycleTime(rs.getString("STD_CYCLE_TIME"));
				cInfSpeDat.setProcStatus(rs.getString("PROC_STATUS"));
				cInfSpeDat.setSeqNo(rs.getString("SEQ_NO"));
				cInfSpeDat.setBgReqFlag(rs.getString("BG_REQ_FLAG"));
				cInfSpeDat.setWfMapReqFg(rs.getString("WF_MAP_REQ_FG"));
				cInfSpeDat.setLastTestDate(rs.getString("LAST_TEST_DATE"));
				cInfSpeDat.setWfDevice(rs.getString("WF_DEVICE"));
				cInfSpeDat.setEngCode(rs.getString("ENG_CODE"));
				cInfSpeDat.setSecondTcardFactory(rs.getString("SECOND_TCARD_FACTORY"));
				cInfSpeDat.setPriTcardFactory(rs.getString("PRI_TCARD_FACTORY"));
				cInfSpeDat.setMarkSpecNo(rs.getString("MARK_SPEC_NO"));
				cInfSpeDat.setPackingMethod(rs.getString("PACKING_METHOD"));
				cInfSpeDat.setProdDesc(rs.getString("PROD_DESC"));
				cInfSpeDat.setNumberFullLabel(rs.getString("NUMBER_FULL_LABEL"));
				cInfSpeDat.setNumberInnerLabel(rs.getString("NUMBER_INNER_LABEL"));
				cInfSpeDat.setTraceFormat(rs.getString("TRACE_FORMAT"));
				cInfSpeDat.setBurninFg(rs.getString("BURNIN_FG"));
				cInfSpeDat.setCardPhaseType(rs.getString("CARD_PHASE_TYPE"));
				cInfSpeDat.setSecondTcard(rs.getString("SECOND_TCARD"));
				cInfSpeDat.setMarkType(rs.getString("MARK_TYPE"));
				cInfSpeDat.setMoldType(rs.getString("MOLD_TYPE"));
				cInfSpeDat.setPlattingType(rs.getString("PLATTING_TYPE"));
				cInfSpeDat.setWireQty(rs.getString("WIRE_QTY"));
				cInfSpeDat.setTubeRemark(rs.getString("TUBE_REMARK"));
				cInfSpeDat.setPackingType(rs.getString("PACKING_TYPE"));
				cInfSpeDat.setBpcInst(rs.getString("BPC_INST"));
				cInfSpeDat.setFlowName(rs.getString("FLOW_NAME"));
				cInfSpeDat.setLimitTime(rs.getString("LIMIT_TIME"));
				cInfSpeDat.setBdSbName(rs.getString("BD_SB_NAME"));
				cInfSpeDat.setWbDevice(rs.getString("WB_DEVICE"));
				cInfSpeDat.setMarkDevice(rs.getString("MARK_DEVICE"));
				cInfSpeDat.setBodySize(rs.getString("BODY_SIZE"));
				cInfSpeDat.setLeadCount(rs.getString("LEAD_COUNT"));
				cInfSpeDat.setFluxPrintStencil(rs.getString("FLUX_PRINT_STENCIL"));
				cInfSpeDat.setBallMountStancil(rs.getString("BALL_MOUNT_STANCIL"));
				cInfSpeDat.setPostReticle(rs.getString("POST_RETICLE"));
				cInfSpeDat.setProdPreFix(rs.getString("PROD_PRE_FIX"));
				cInfSpeDat.setResinThickness(rs.getString("RESIN_THICKNESS"));
				cInfSpeDat.setWaferThickness(rs.getString("WAFER_THICKNESS"));
				cInfSpeDat.setBallType(rs.getString("BALL_TYPE"));
				cInfSpeDat.setBallSize(rs.getString("BALL_SIZE"));
				cInfSpeDat.setBallPlacement(rs.getString("BALL_PLACEMENT"));
				cInfSpeDat.setPiReticle(rs.getString("PI_RETICLE"));
				cInfSpeDat.setRdlReticle(rs.getString("RDL_RETICLE"));
				cInfSpeDat.setUbmReticle(rs.getString("UBM_RETICLE"));
				cInfSpeDat.setResin(rs.getString("RESIN"));
				cInfSpeDat.setCmf1(rs.getString("CMF_1"));
				cInfSpeDat.setCmf2(rs.getString("CMF_2"));
				cInfSpeDat.setCmf3(rs.getString("CMF_3"));
				cInfSpeDat.setCmf4(rs.getString("CMF_4"));
				cInfSpeDat.setCmf5(rs.getString("CMF_5"));
				cInfSpeDat.setReadFlag(rs.getString("READ_FLAG"));
				cInfSpeDat.setInfMsg(rs.getString("INF_MSG"));
				cInfSpeDat.setInfFlag(rs.getString("INF_FLAG"));
				cInfSpeDat.setBumpReticle(rs.getString("BUMP_RETICLE"));
				cInfSpeDat.setCmf6(rs.getString("CMF_6"));
				cInfSpeDat.setCmf7(rs.getString("CMF_7"));
				cInfSpeDat.setCmf8(rs.getString("CMF_8"));
				cInfSpeDat.setCmf9(rs.getString("CMF_9"));
				cInfSpeDat.setCmf10(rs.getString("CMF_10"));
				cInfSpeDat.setCmf11(rs.getString("CMF_11"));
				cInfSpeDat.setCmf12(rs.getString("CMF_12"));
				cInfSpeDat.setCmf13(rs.getString("CMF_13"));
				cInfSpeDat.setCmf14(rs.getString("CMF_14"));
				cInfSpeDat.setCmf15(rs.getString("CMF_15"));
				cInfSpeDat.setCmf16(rs.getString("CMF_16"));
				cInfSpeDat.setCmf17(rs.getString("CMF_17"));
				cInfSpeDat.setCmf18(rs.getString("CMF_18"));
				cInfSpeDat.setCmf19(rs.getString("CMF_19"));
				cInfSpeDat.setCmf20(rs.getString("CMF_20"));
				cInfSpeDat.setCmf21(rs.getString("CMF_21"));
				cInfSpeDat.setCmf22(rs.getString("CMF_22"));
				cInfSpeDat.setCmf23(rs.getString("CMF_23"));
				cInfSpeDat.setCmf24(rs.getString("CMF_24"));
				cInfSpeDat.setCmf25(rs.getString("CMF_25"));
				cInfSpeDat.setCmf26(rs.getString("CMF_26"));
				cInfSpeDat.setCmf27(rs.getString("CMF_27"));
				cInfSpeDat.setCmf28(rs.getString("CMF_28"));
				cInfSpeDat.setCmf29(rs.getString("CMF_29"));
				cInfSpeDat.setCmf30(rs.getString("CMF_30"));
				cInfSpeDat.setPiReticle2(rs.getString("PI_RETICLE2"));
				cInfSpeDat.setUbmReticle2(rs.getString("UBM_RETICLE2"));
				cInfSpeDat.setResvField1(rs.getString("RESV_FIELD_1"));
				cInfSpeDat.setResvField2(rs.getString("RESV_FIELD_2"));
				cInfSpeDat.setResvField3(rs.getString("RESV_FIELD_3"));
				cInfSpeDat.setResvField4(rs.getString("RESV_FIELD_4"));
				cInfSpeDat.setResvField5(rs.getString("RESV_FIELD_5"));
				cInfSpeDat.setResvField6(rs.getString("RESV_FIELD_6"));
				cInfSpeDat.setResvField7(rs.getString("RESV_FIELD_7"));
				cInfSpeDat.setResvField8(rs.getString("RESV_FIELD_8"));
				cInfSpeDat.setResvField9(rs.getString("RESV_FIELD_9"));
				cInfSpeDat.setResvField10(rs.getString("RESV_FIELD_10"));
				cInfSpeDat.setLabel21(rs.getString("LABEL21"));
				cInfSpeDat.setLabel22(rs.getString("LABEL22"));
				cInfSpeDat.setLabel23(rs.getString("LABEL23"));
				cInfSpeDat.setLabel24(rs.getString("LABEL24"));
				cInfSpeDat.setLabel25(rs.getString("LABEL25"));
				cInfSpeDat.setLabel26(rs.getString("LABEL26"));
				cInfSpeDat.setLabel27(rs.getString("LABEL27"));
				cInfSpeDat.setLabel28(rs.getString("LABEL28"));
				cInfSpeDat.setLabel29(rs.getString("LABEL29"));
				cInfSpeDat.setLabel30(rs.getString("LABEL30"));
				json = JSONObject.fromObject(cInfSpeDat);
				cInfSpeDatList.add(json);
				message.put("cInfSpeDatList", cInfSpeDatList);
			}
			sql = "select * from cinfpatdat where requestid = " + requestId;
			rs.execute(sql);
			while (rs.next()) {
				cInfPatDat.setInfTime(rs.getString("INF_TIME"));
				cInfPatDat.setInfSeq(Integer.valueOf(rs.getString("INF_SEQ")));
				cInfPatDat.setMatnr(rs.getString("MATNR"));
				cInfPatDat.setWerks(rs.getString("WERKS"));
				cInfPatDat.setStlan(rs.getString("STLAN"));
				cInfPatDat.setStlal(rs.getString("STLAL"));
				cInfPatDat.setPlnnr(rs.getString("PLNNR"));
				cInfPatDat.setPosnr(rs.getString("POSNR"));
				cInfPatDat.setIdnrk(rs.getString("IDNRK"));
				cInfPatDat.setMenge(rs.getString("MENGE"));
				cInfPatDat.setMeins(rs.getString("MEINS"));
				cInfPatDat.setAusch(rs.getString("AUSCH"));
				cInfPatDat.setAlpgr(rs.getString("ALPGR"));
				cInfPatDat.setAlprf(rs.getString("ALPRF"));
				cInfPatDat.setAlpst(rs.getString("ALPST"));
				cInfPatDat.setEwahr(rs.getString("EWAHR"));
				cInfPatDat.setItsob(rs.getString("ITSOB"));
				cInfPatDat.setLgort(rs.getString("LGORT"));
				cInfPatDat.setSanka(rs.getString("SANKA"));
				cInfPatDat.setReadFlag(rs.getString("READ_FLAG"));
				cInfPatDat.setInfMsg(rs.getString("INF_MSG"));
				cInfPatDat.setInfFlag(rs.getString("INF_FLAG"));
				cInfPatDat.setCmf1(rs.getString("CMF_1"));
				cInfPatDat.setCmf2(rs.getString("CMF_2"));
				cInfPatDat.setCmf3(rs.getString("CMF_3"));
				cInfPatDat.setCmf4(rs.getString("CMF_4"));
				cInfPatDat.setCmf5(rs.getString("CMF_5"));
				cInfPatDat.setCmf6(rs.getString("CMF_6"));
				cInfPatDat.setCmf7(rs.getString("CMF_7"));
				cInfPatDat.setCmf8(rs.getString("CMF_8"));
				cInfPatDat.setCmf9(rs.getString("CMF_9"));
				cInfPatDat.setCmf10(rs.getString("CMF_10"));
				cInfPatDat.setDeleteFlag(rs.getString("DELETE_FLAG"));
				cInfPatDat.setCreateTime(rs.getString("CREATE_TIME"));
				cInfPatDat.setCreateUserId(rs.getString("CREATE_USER_ID"));
				cInfPatDat.setUpdateTime(rs.getString("UPDATE_TIME"));
				cInfPatDat.setUpdateUserId(rs.getString("UPDATE_USER_ID"));
				cInfPatDat.setDeleteTime(rs.getString("DELETE_TIME"));
				cInfPatDat.setDeleteUserId(rs.getString("DELETE_USER_ID"));
				json = JSONObject.fromObject(cInfPatDat);
				cinfPatDatList.add(json);
				message.put("cInfPatDatList", cinfPatDatList);
			}
			sql = "select * from cinfflwdat where requestid = " + requestId;
			rs.execute(sql);
			while (rs.next()) {
				cInfFlwDat.setInfTime(rs.getString("INF_TIME"));
				cInfFlwDat.setInfSeq(Integer.valueOf(rs.getString("INF_SEQ")));
				cInfFlwDat.setMatnr(rs.getString("MATNR"));
				cInfFlwDat.setWerks(rs.getString("WERKS"));
				cInfFlwDat.setPlnnr(rs.getString("PLNNR"));
				cInfFlwDat.setPlnal(rs.getString("PLNAL"));
				cInfFlwDat.setPlnfl(rs.getString("PLNFL"));
				cInfFlwDat.setVornr(rs.getString("VORNR"));
				cInfFlwDat.setArbpl(rs.getString("ARBPL"));
				cInfFlwDat.setSteus(rs.getString("STEUS"));
				cInfFlwDat.setKtsch(rs.getString("KTSCH"));
				cInfFlwDat.setLtxa1(rs.getString("LTXA1"));
				cInfFlwDat.setVgw01(rs.getString("VGW01"));
				cInfFlwDat.setVgw02(rs.getString("VGW02"));
				cInfFlwDat.setVgw03(rs.getString("VGW03"));
				cInfFlwDat.setVgw04(rs.getString("VGW04"));
				cInfFlwDat.setVgw05(rs.getString("VGW05"));
				cInfFlwDat.setVgw06(rs.getString("VGW06"));
				cInfFlwDat.setInfnr(rs.getString("INFNR"));
				cInfFlwDat.setEkorg(rs.getString("EKORG"));
				cInfFlwDat.setSakto(rs.getString("SAKTO"));
				cInfFlwDat.setBmsch(rs.getString("BMSCH"));
				cInfFlwDat.setUemus(rs.getString("UEMUS"));
				cInfFlwDat.setMinwe(rs.getString("MINWE"));
				cInfFlwDat.setSpmus(rs.getString("SPMUS"));
				cInfFlwDat.setSplim(rs.getString("SPLIM"));
				cInfFlwDat.setUmrez(rs.getString("UMREZ"));
				cInfFlwDat.setMeinh(rs.getString("MEINH"));
				cInfFlwDat.setReadFlag(rs.getString("READ_FLAG"));
				cInfFlwDat.setInfMsg(rs.getString("INF_MSG"));
				cInfFlwDat.setInfFlag(rs.getString("INF_FLAG"));
				cInfFlwDat.setCmf1(rs.getString("CMF_1"));
				cInfFlwDat.setCmf2(rs.getString("CMF_2"));
				cInfFlwDat.setCmf3(rs.getString("CMF_3"));
				cInfFlwDat.setCmf4(rs.getString("CMF_4"));
				cInfFlwDat.setCmf5(rs.getString("CMF_5"));
				cInfFlwDat.setCmf6(rs.getString("CMF_6"));
				cInfFlwDat.setCmf7(rs.getString("CMF_7"));
				cInfFlwDat.setCmf8(rs.getString("CMF_8"));
				cInfFlwDat.setCmf9(rs.getString("CMF_9"));
				cInfFlwDat.setCmf10(rs.getString("CMF_10"));
				cInfFlwDat.setDeleteFlag(rs.getString("DELETE_FLAG"));
				cInfFlwDat.setCreateTime(rs.getString("CREATE_TIME"));
				cInfFlwDat.setCreateUserId(rs.getString("CREATE_USER_ID"));
				cInfFlwDat.setUpdateTime(rs.getString("UPDATE_TIME"));
				cInfFlwDat.setUpdateUserId(rs.getString("UPDATE_USER_ID"));
				cInfFlwDat.setDeleteTime(rs.getString("DELETE_TIME"));
				cInfFlwDat.setDeleteUserId(rs.getString("DELETE_USER_ID"));
				json = JSONObject.fromObject(cInfFlwDat);
				cinfFlwDatList.add(json);
				message.put("cInfFlwDatList", cinfFlwDatList);
			}
			sql = "select * from cinfbomdat where requestid = " + requestId;
			rs.execute(sql);
			while (rs.next()) {
				cInfBomDat.setInfTime(rs.getString("INF_TIME"));
				cInfBomDat.setInfSeq(Integer.valueOf(rs.getString("INF_SEQ")));
				cInfBomDat.setMatnr(rs.getString("MATNR"));
				cInfBomDat.setWerks(rs.getString("WERKS"));
				cInfBomDat.setPlnnr(rs.getString("PLNNR"));
				cInfBomDat.setPlnal(rs.getString("PLNAL"));
				cInfBomDat.setPlnfl(rs.getString("PLNFL"));
				cInfBomDat.setVornr(rs.getString("VORNR"));
				cInfBomDat.setIdnrk(rs.getString("IDNRK"));
				cInfBomDat.setPosnr(rs.getString("POSNR"));
				cInfBomDat.setStlan(rs.getString("STLAN"));
				cInfBomDat.setStlal(rs.getString("STLAL"));
				cInfBomDat.setReadFlag(rs.getString("READ_FLAG"));
				cInfBomDat.setInfMsg(rs.getString("INF_MSG"));
				cInfBomDat.setInfFlag(rs.getString("INF_FLAG"));
				cInfBomDat.setCmf1(rs.getString("CMF_1"));
				cInfBomDat.setCmf2(rs.getString("CMF_2"));
				cInfBomDat.setCmf3(rs.getString("CMF_3"));
				cInfBomDat.setCmf4(rs.getString("CMF_4"));
				cInfBomDat.setCmf5(rs.getString("CMF_5"));
				cInfBomDat.setCmf6(rs.getString("CMF_6"));
				cInfBomDat.setCmf7(rs.getString("CMF_7"));
				cInfBomDat.setCmf8(rs.getString("CMF_8"));
				cInfBomDat.setCmf9(rs.getString("CMF_9"));
				cInfBomDat.setCmf10(rs.getString("CMF_10"));
				cInfBomDat.setDeleteFlag(rs.getString("DELETE_FLAG"));
				cInfBomDat.setCreateTime(rs.getString("CREATE_TIME"));
				cInfBomDat.setCreateUserId(rs.getString("CREATE_USER_ID"));
				cInfBomDat.setUpdateTime(rs.getString("UPDATE_TIME"));
				cInfBomDat.setUpdateUserId(rs.getString("UPDATE_USER_ID"));
				cInfBomDat.setDeleteTime(rs.getString("DELETE_TIME"));
				cInfBomDat.setDeleteUserId(rs.getString("DELETE_USER_ID"));
				json = JSONObject.fromObject(cInfBomDat);
				cinfBomDatList.add(json);
				message.put("cInfBomDatList", cinfBomDatList);
			}
			req.put("message", message);
			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPLOADMASTERDATA");
			req.put("token", "OATESTTOKEN");
			baseBean.writeLog("-----req-----");
			baseBean.writeLog(req);
			String theString = req.toString().replace("null", " ");
			String retSrcs = HttpClientJson.readInterfacePost(url, theString);
			String msg = JSONObject.fromObject(retSrcs).getString("msg");
			baseBean.writeLog("retSrcs" + retSrcs);
			baseBean.writeLog("msg" + msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public String execute(RequestInfo arg0) {
		return null;
	}

}

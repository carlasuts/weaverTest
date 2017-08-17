package weaver.interfaces.dao;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONObject;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 从表cinfspedat中取值 放入CInfSpeDat实体类中
 * 
 * @author zong.yq
 */
public class CInfSpeDatDao implements Action {

	private JSONObject req = new JSONObject();
	private JSONObject message = new JSONObject();
	private static final String url = "http://172.16.60.96:8099/MesWebService/req";
	private BaseBean baseBean = new BaseBean();

	public void setcinfspedat(RequestInfo request) {
		try {
			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPLOADMASTERDATA");
			req.put("token", "OATESTTOKEN");

			RecordSet rs = new RecordSet();
			String sql = "";
			String requestId = request.getRequestid();// 获取当前的requestID
			baseBean.writeLog("当前流程的requestId：" + requestId);

			sql = "select count(*) as length from cinfspedat where requestid = " + requestId;// 获取当前requestID共有多少条记录
			rs.executeSql(sql);
			rs.next();
			int length = Integer.valueOf(rs.getString("length"));
			baseBean.writeLog("查询对应RequestId下的条目：" + length);
			JSONObject[] cInfSpeDatList = new JSONObject[length];// 定义cInfSpeDatList的长度

			baseBean.writeLog("开始获取当前requestID：" + requestId + "的值");
			sql = "select * from cinfspedat where requestid = " + requestId;// 获取当前requestID的值
			rs.execute(sql);
			int i = 0;
			while (rs.next()) {
				baseBean.writeLog("for循环开始执行");
				cInfSpeDatList[i] = new JSONObject();
				cInfSpeDatList[i].put("infTime", rs.getString("INF_TIME"));
				cInfSpeDatList[i].put("infSeq", rs.getString("INF_SEQ"));
				cInfSpeDatList[i].put("factory", rs.getString("FACTORY"));
				cInfSpeDatList[i].put("matId", rs.getString("MAT_ID"));
				cInfSpeDatList[i].put("custId", rs.getString("CUST_ID"));
				cInfSpeDatList[i].put("custMatId", rs.getString("CUST_MAT_ID"));
				cInfSpeDatList[i].put("custMatDesc", rs.getString("CUST_MAT_DESC"));
				cInfSpeDatList[i].put("dbMatId", rs.getString("DB_MAT_ID"));
				cInfSpeDatList[i].put("pkgType", rs.getString("PKG_TYPE"));
				cInfSpeDatList[i].put("packCode", rs.getString("PACK_CODE"));
				cInfSpeDatList[i].put("pkldCode", rs.getString("PKLD_CODE"));
				cInfSpeDatList[i].put("addBondDiagramNo", rs.getString("ADD_BOND_DIAGRAM_NO"));
				cInfSpeDatList[i].put("addBondDiagramRev", rs.getString("ADD_BOND_DIAGRAM_REV"));
				cInfSpeDatList[i].put("flowId", rs.getString("FLOW_ID"));
				cInfSpeDatList[i].put("orgCustDeviceId", rs.getString("ORG_CUST_DEVICE_ID"));
				cInfSpeDatList[i].put("topMarkFormatId", rs.getString("TOP_MARK_FORMAT_ID"));
				cInfSpeDatList[i].put("backMarkFormatId", rs.getString("BACK_MARK_FORMAT_ID"));
				cInfSpeDatList[i].put("recipeGroup", rs.getString("RECIPE_GROUP"));
				cInfSpeDatList[i].put("stdLotSize", rs.getString("STD_LOT_SIZE"));
				cInfSpeDatList[i].put("matUnit", rs.getString("MAT_UNIT"));
				cInfSpeDatList[i].put("buOper", rs.getString("BU_OPER"));
				cInfSpeDatList[i].put("tnrStdOutboxQty", rs.getString("TNR_STD_OUTBOX_QTY"));
				cInfSpeDatList[i].put("tubeStdOutboxQty", rs.getString("TUBE_STD_OUTBOX_QTY"));
				cInfSpeDatList[i].put("tubeRealPackQty", rs.getString("TUBE_REAL_PACK_QTY"));
				cInfSpeDatList[i].put("stdPackQty", rs.getString("STD_PACK_QTY"));
				cInfSpeDatList[i].put("halfPackQty", rs.getString("HALF_PACK_QTY"));
				cInfSpeDatList[i].put("tnrQty", rs.getString("TNR_QTY"));
				cInfSpeDatList[i].put("tubeQty", rs.getString("TUBE_QTY"));
				cInfSpeDatList[i].put("trNeedFullInbox", rs.getString("TR_NEED_FULL_INBOX"));
				cInfSpeDatList[i].put("info1", rs.getString("INFO1"));
				cInfSpeDatList[i].put("info2", rs.getString("INFO2"));
				cInfSpeDatList[i].put("info3", rs.getString("INFO3"));
				cInfSpeDatList[i].put("info4", rs.getString("INFO4"));
				cInfSpeDatList[i].put("info5", rs.getString("INFO5"));
				cInfSpeDatList[i].put("lable1", rs.getString("LABLE1"));
				cInfSpeDatList[i].put("lable2", rs.getString("LABLE2"));
				cInfSpeDatList[i].put("lable3", rs.getString("LABLE3"));
				cInfSpeDatList[i].put("lable4", rs.getString("LABLE4"));
				cInfSpeDatList[i].put("lable5", rs.getString("LABLE5"));
				cInfSpeDatList[i].put("lable6", rs.getString("LABLE6"));
				cInfSpeDatList[i].put("lable7", rs.getString("LABLE7"));
				cInfSpeDatList[i].put("lable8", rs.getString("LABLE8"));
				cInfSpeDatList[i].put("lable9", rs.getString("LABLE9"));
				cInfSpeDatList[i].put("lable10", rs.getString("LABLE10"));
				cInfSpeDatList[i].put("lable11", rs.getString("LABLE11"));
				cInfSpeDatList[i].put("lable12", rs.getString("LABLE12"));
				cInfSpeDatList[i].put("lable13", rs.getString("LABLE13"));
				cInfSpeDatList[i].put("lable14", rs.getString("LABLE14"));
				cInfSpeDatList[i].put("lable15", rs.getString("LABLE15"));
				cInfSpeDatList[i].put("lable16", rs.getString("LABLE16"));
				cInfSpeDatList[i].put("lable17", rs.getString("LABLE17"));
				cInfSpeDatList[i].put("lable18", rs.getString("LABLE18"));
				cInfSpeDatList[i].put("lable19", rs.getString("LABLE19"));
				cInfSpeDatList[i].put("lable20", rs.getString("LABLE20"));
				cInfSpeDatList[i].put("mark1", rs.getString("MARK1"));
				cInfSpeDatList[i].put("mark2", rs.getString("MARK2"));
				cInfSpeDatList[i].put("mark3", rs.getString("MARK3"));
				cInfSpeDatList[i].put("mark4", rs.getString("MARK4"));
				cInfSpeDatList[i].put("mark5", rs.getString("MARK5"));
				cInfSpeDatList[i].put("trDataType", rs.getString("TR_DATA_TYPE"));
				cInfSpeDatList[i].put("instruction1", rs.getString("INSTRUCTION1"));
				cInfSpeDatList[i].put("instruction2", rs.getString("INSTRUCTION2"));
				cInfSpeDatList[i].put("instruction3", rs.getString("INSTRUCTION3"));
				cInfSpeDatList[i].put("upperWfThick", rs.getString("UPPER_WF_THICK"));
				cInfSpeDatList[i].put("lowerWfThick", rs.getString("LOWER_WF_THICK"));
				cInfSpeDatList[i].put("wfSize", rs.getString("WF_SIZE"));
				cInfSpeDatList[i].put("primaryTcard", rs.getString("PRIMARY_TCARD"));
				cInfSpeDatList[i].put("msllabel", rs.getString("MSLLABEL"));
				cInfSpeDatList[i].put("bsmCode", rs.getString("BSM_CODE"));
				cInfSpeDatList[i].put("lotCode", rs.getString("LOT_CODE"));
				cInfSpeDatList[i].put("tsmCode", rs.getString("TSM_CODE"));
				cInfSpeDatList[i].put("outDevice", rs.getString("OUT_DEVICE"));
				cInfSpeDatList[i].put("markngSpecVersion", rs.getString("MARKNG_SPEC_VERSION"));
				cInfSpeDatList[i].put("chipSizeX", rs.getString("CHIP_SIZE_X"));
				cInfSpeDatList[i].put("chipSizeY", rs.getString("CHIP_SIZE_Y"));
				cInfSpeDatList[i].put("scribeWidth", rs.getString("SCRIBE_WIDTH"));
				cInfSpeDatList[i].put("bpo", rs.getString("BPO"));
				cInfSpeDatList[i].put("bpp", rs.getString("BPP"));
				cInfSpeDatList[i].put("cardProcFg", rs.getString("CARD_PROC_FG"));
				cInfSpeDatList[i].put("pbFreeFg", rs.getString("PB_FREE_FG"));
				cInfSpeDatList[i].put("dieDown", rs.getString("DIE_DOWN"));
				cInfSpeDatList[i].put("bomNo", rs.getString("BOM_NO"));
				cInfSpeDatList[i].put("grpDevice", rs.getString("GRP_DEVICE"));
				cInfSpeDatList[i].put("prodClass", rs.getString("PROD_CLASS"));
				cInfSpeDatList[i].put("subLotSize", rs.getString("SUB_LOT_SIZE"));
				cInfSpeDatList[i].put("maxAsyLotCnt", rs.getString("MAX_ASY_LOT_CNT"));
				cInfSpeDatList[i].put("wfIngredients", rs.getString("WF_INGREDIENTS"));
				cInfSpeDatList[i].put("chipType", rs.getString("CHIP_TYPE"));
				cInfSpeDatList[i].put("daMode", rs.getString("DA_MODE"));
				cInfSpeDatList[i].put("dieCoating", rs.getString("DIE_COATING"));
				cInfSpeDatList[i].put("hygrosLevel", rs.getString("HYGROS_LEVEL"));
				cInfSpeDatList[i].put("coatingType", rs.getString("COATING_TYPE"));
				cInfSpeDatList[i].put("carProd", rs.getString("CAR_PROD"));
				cInfSpeDatList[i].put("mark", rs.getString("MARK"));
				cInfSpeDatList[i].put("plate", rs.getString("PLATE"));
				cInfSpeDatList[i].put("reelSize", rs.getString("REEL_SIZE"));
				cInfSpeDatList[i].put("reelDiraction", rs.getString("REEL_DIRACTION"));
				cInfSpeDatList[i].put("rellQty", rs.getString("RELL_QTY"));
				cInfSpeDatList[i].put("halogenFProd", rs.getString("HALOGEN_F_PROD"));
				cInfSpeDatList[i].put("stripProd", rs.getString("STRIP_PROD"));
				cInfSpeDatList[i].put("padType", rs.getString("PAD_TYPE"));
				cInfSpeDatList[i].put("testFlwChart", rs.getString("TEST_FLW_CHART"));
				cInfSpeDatList[i].put("testPlatfom", rs.getString("TEST_PLATFOM"));
				cInfSpeDatList[i].put("testSystem", rs.getString("TEST_SYSTEM"));
				cInfSpeDatList[i].put("testHandler", rs.getString("TEST_HANDLER"));
				cInfSpeDatList[i].put("testPrgRev1", rs.getString("TEST_PRG_REV1"));
				cInfSpeDatList[i].put("qaPrg1", rs.getString("QA_PRG1"));
				cInfSpeDatList[i].put("qaPrg2", rs.getString("QA_PRG2"));
				cInfSpeDatList[i].put("testTempe", rs.getString("TEST_TEMPE"));
				cInfSpeDatList[i].put("dieRunCodeFg", rs.getString("DIE_RUN_CODE_FG"));
				cInfSpeDatList[i].put("assyTestFg", rs.getString("ASSY_TEST_FG"));
				cInfSpeDatList[i].put("stdCycleTime", rs.getString("STD_CYCLE_TIME"));
				cInfSpeDatList[i].put("procStatus", rs.getString("PROC_STATUS"));
				cInfSpeDatList[i].put("seqNo", rs.getString("SEQ_NO"));
				cInfSpeDatList[i].put("bgReqFlag", rs.getString("BG_REQ_FLAG"));
				cInfSpeDatList[i].put("wfMapReqFg", rs.getString("WF_MAP_REQ_FG"));
				cInfSpeDatList[i].put("lastTestDate", rs.getString("LAST_TEST_DATE"));
				cInfSpeDatList[i].put("wfDevice", rs.getString("WF_DEVICE"));
				cInfSpeDatList[i].put("engCode", rs.getString("ENG_CODE"));
				cInfSpeDatList[i].put("secondTcardFactory", rs.getString("SECOND_TCARD_FACTORY"));
				cInfSpeDatList[i].put("priTcardFactory", rs.getString("PRI_TCARD_FACTORY"));
				cInfSpeDatList[i].put("markSpecNo", rs.getString("MARK_SPEC_NO"));
				cInfSpeDatList[i].put("packingMethod", rs.getString("PACKING_METHOD"));
				cInfSpeDatList[i].put("prodDesc", rs.getString("PROD_DESC"));
				cInfSpeDatList[i].put("numberFullLabel", rs.getString("NUMBER_FULL_LABEL"));
				cInfSpeDatList[i].put("numberInnerLabel", rs.getString("NUMBER_INNER_LABEL"));
				cInfSpeDatList[i].put("traceFormat", rs.getString("TRACE_FORMAT"));
				cInfSpeDatList[i].put("burninFg", rs.getString("BURNIN_FG"));
				cInfSpeDatList[i].put("cardPhaseType", rs.getString("CARD_PHASE_TYPE"));
				cInfSpeDatList[i].put("secondTcard", rs.getString("SECOND_TCARD"));
				cInfSpeDatList[i].put("markType", rs.getString("MARK_TYPE"));
				cInfSpeDatList[i].put("moldType", rs.getString("MOLD_TYPE"));
				cInfSpeDatList[i].put("plattingType", rs.getString("PLATTING_TYPE"));
				cInfSpeDatList[i].put("wireQty", rs.getString("WIRE_QTY"));
				cInfSpeDatList[i].put("tubeRemark", rs.getString("TUBE_REMARK"));
				cInfSpeDatList[i].put("packingType", rs.getString("PACKING_TYPE"));
				cInfSpeDatList[i].put("bpcInst", rs.getString("BPC_INST"));
				cInfSpeDatList[i].put("flowName", rs.getString("FLOW_NAME"));
				cInfSpeDatList[i].put("limitTime", rs.getString("LIMIT_TIME"));
				cInfSpeDatList[i].put("bdSbName", rs.getString("BD_SB_NAME"));
				cInfSpeDatList[i].put("wbDevice", rs.getString("WB_DEVICE"));
				cInfSpeDatList[i].put("markDevice", rs.getString("MARK_DEVICE"));
				cInfSpeDatList[i].put("bodySize", rs.getString("BODY_SIZE"));
				cInfSpeDatList[i].put("leadCount", rs.getString("LEAD_COUNT"));
				cInfSpeDatList[i].put("fluxPrintStencil", rs.getString("FLUX_PRINT_STENCIL"));
				cInfSpeDatList[i].put("ballMountStancil", rs.getString("BALL_MOUNT_STANCIL"));
				cInfSpeDatList[i].put("postReticle", rs.getString("POST_RETICLE"));
				cInfSpeDatList[i].put("prodPreFix", rs.getString("PROD_PRE_FIX"));
				cInfSpeDatList[i].put("resinThickness", rs.getString("RESIN_THICKNESS"));
				cInfSpeDatList[i].put("waferThickness", rs.getString("WAFER_THICKNESS"));
				cInfSpeDatList[i].put("ballType", rs.getString("BALL_TYPE"));
				cInfSpeDatList[i].put("ballSize", rs.getString("BALL_SIZE"));
				cInfSpeDatList[i].put("ballPlacement", rs.getString("BALL_PLACEMENT"));
				cInfSpeDatList[i].put("piReticle", rs.getString("PI_RETICLE"));
				cInfSpeDatList[i].put("rdlReticle", rs.getString("RDL_RETICLE"));
				cInfSpeDatList[i].put("ubmReticle", rs.getString("UBM_RETICLE"));
				cInfSpeDatList[i].put("resin", rs.getString("RESIN"));
				cInfSpeDatList[i].put("cmf1", rs.getString("CMF_1"));
				cInfSpeDatList[i].put("cmf2", rs.getString("CMF_2"));
				cInfSpeDatList[i].put("cmf3", rs.getString("CMF_3"));
				cInfSpeDatList[i].put("cmf4", rs.getString("CMF_4"));
				cInfSpeDatList[i].put("cmf5", rs.getString("CMF_5"));
				cInfSpeDatList[i].put("readFlag", rs.getString("READ_FLAG"));
				cInfSpeDatList[i].put("infMsg", rs.getString("INF_MSG"));
				cInfSpeDatList[i].put("infFlag", rs.getString("INF_FLAG"));
				cInfSpeDatList[i].put("bumpReticle", rs.getString("BUMP_RETICLE"));
				cInfSpeDatList[i].put("cmf6", rs.getString("CMF_6"));
				cInfSpeDatList[i].put("cmf7", rs.getString("CMF_7"));
				cInfSpeDatList[i].put("cmf8", rs.getString("CMF_8"));
				cInfSpeDatList[i].put("cmf9", rs.getString("CMF_9"));
				cInfSpeDatList[i].put("cmf10", rs.getString("CMF_10"));
				cInfSpeDatList[i].put("cmf11", rs.getString("CMF_11"));
				cInfSpeDatList[i].put("cmf12", rs.getString("CMF_12"));
				cInfSpeDatList[i].put("cmf13", rs.getString("CMF_13"));
				cInfSpeDatList[i].put("cmf14", rs.getString("CMF_14"));
				cInfSpeDatList[i].put("cmf15", rs.getString("CMF_15"));
				cInfSpeDatList[i].put("cmf16", rs.getString("CMF_16"));
				cInfSpeDatList[i].put("cmf17", rs.getString("CMF_17"));
				cInfSpeDatList[i].put("cmf18", rs.getString("CMF_18"));
				cInfSpeDatList[i].put("cmf19", rs.getString("CMF_19"));
				cInfSpeDatList[i].put("cmf20", rs.getString("CMF_20"));
				cInfSpeDatList[i].put("cmf21", rs.getString("CMF_21"));
				cInfSpeDatList[i].put("cmf22", rs.getString("CMF_22"));
				cInfSpeDatList[i].put("cmf23", rs.getString("CMF_23"));
				cInfSpeDatList[i].put("cmf24", rs.getString("CMF_24"));
				cInfSpeDatList[i].put("cmf25", rs.getString("CMF_25"));
				cInfSpeDatList[i].put("cmf26", rs.getString("CMF_26"));
				cInfSpeDatList[i].put("cmf27", rs.getString("CMF_27"));
				cInfSpeDatList[i].put("cmf28", rs.getString("CMF_28"));
				cInfSpeDatList[i].put("cmf29", rs.getString("CMF_29"));
				cInfSpeDatList[i].put("cmf30", rs.getString("CMF_30"));
				cInfSpeDatList[i].put("piReticle2", rs.getString("PI_RETICLE2"));
				cInfSpeDatList[i].put("ubmReticle2", rs.getString("UBM_RETICLE2"));
				cInfSpeDatList[i].put("resvField1", rs.getString("RESV_FIELD_1"));
				cInfSpeDatList[i].put("resvField2", rs.getString("RESV_FIELD_2"));
				cInfSpeDatList[i].put("resvField3", rs.getString("RESV_FIELD_3"));
				cInfSpeDatList[i].put("resvField4", rs.getString("RESV_FIELD_4"));
				cInfSpeDatList[i].put("resvField5", rs.getString("RESV_FIELD_5"));
				cInfSpeDatList[i].put("resvField6", rs.getString("RESV_FIELD_6"));
				cInfSpeDatList[i].put("resvField7", rs.getString("RESV_FIELD_7"));
				cInfSpeDatList[i].put("resvField8", rs.getString("RESV_FIELD_8"));
				cInfSpeDatList[i].put("resvField9", rs.getString("RESV_FIELD_9"));
				cInfSpeDatList[i].put("resvField10", rs.getString("RESV_FIELD_10"));
				cInfSpeDatList[i].put("label21", rs.getString("LABEL21"));
				cInfSpeDatList[i].put("label22", rs.getString("LABEL22"));
				cInfSpeDatList[i].put("label23", rs.getString("LABEL23"));
				cInfSpeDatList[i].put("label24", rs.getString("LABEL24"));
				cInfSpeDatList[i].put("label25", rs.getString("LABEL25"));
				cInfSpeDatList[i].put("label26", rs.getString("LABEL26"));
				cInfSpeDatList[i].put("label27", rs.getString("LABEL27"));
				cInfSpeDatList[i].put("label28", rs.getString("LABEL28"));
				cInfSpeDatList[i].put("label29", rs.getString("LABEL29"));
				cInfSpeDatList[i].put("label30", rs.getString("LABEL30"));
				message.put("cInfSpeDatList", cInfSpeDatList);
				i++;
			}
			req.put("message", message);
			baseBean.writeLog("req:" + req);
			HttpPost postMethod = new HttpPost(url);
			StringEntity SS = new StringEntity(req.toString());
			postMethod.setEntity(SS);
			HttpResponse resps = new DefaultHttpClient().execute(postMethod);
			baseBean.writeLog(resps);
		} catch (Exception e) {
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("CInfSpeDatDao error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
	}

	@Override
	public String execute(RequestInfo paramRequestInfo) {
		// TODO Auto-generated method stub
		return null;
	}
}

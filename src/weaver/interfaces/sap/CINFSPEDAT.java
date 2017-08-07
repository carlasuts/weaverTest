package weaver.interfaces.sap;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;
import weaver.conn.*;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 */
public class CINFSPEDAT {

	private String logtablename = "CINFSPEDAT";

	// 芯片
	public void insert(DetailTable dt, String rid, MainTableInfo maintableinfo,
			String creator) {
		List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
		Property[] Property = maintableinfo.getProperty();
		Map<String, String> mainMap = new HashMap<String, String>();
		for (Property p : Property) {
			if (p.getValue().isEmpty()) {
				mainMap.put(p.getName(), " ");
			} else {
				mainMap.put(p.getName().toUpperCase(), p.getValue());
			}
		}
		insertDetail(dt, rid, loglist, mainMap);
		// 主表
		Map<String, String> logmap = new HashMap<String, String>();
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String time14 = sdf.format(now);
		logmap.put("REQUESTID", rid);
		logmap.put("NODEID", "200");
		logmap.put("INF_TIME", time14);
		logmap.put("INF_SEQ", "10001");// 序号
		logmap.put("FACTORY", mainMap.get("PLANT"));
		logmap.put("MAT_ID", mainMap.get("PRODUCTMATERIALCODE"));
		logmap.put("CUST_ID", mainMap.get("CUSTOMER"));
		logmap.put("CUST_MAT_DESC", mainMap.get("CUSTOMERMTRLDESCRIPTION"));
		logmap.put("DB_MAT_ID", " ");
		logmap.put("PKG_TYPE", mainMap.get("PACKAGEOUTLINE"));
		logmap.put("PACK_CODE", " ");
		logmap.put("PKLD_CODE", mainMap.get("PACKAGEOUTLINE"));
		logmap.put("ADD_BOND_DIAGRAM_NO", mainMap.get("WIREBONDDIAGNO"));
		logmap.put("ADD_BOND_DIAGRAM_REV", mainMap.get("WIREBONDDIAGVERSION"));
		logmap.put("FLOW_ID", " ");
		logmap.put("ORG_CUST_DEVICE_ID", " ");
		logmap.put("TOP_MARK_FORMAT_ID", mainMap.get("TOPMARKFORMATNO"));
		logmap.put("BACK_MARK_FORMAT_ID", mainMap.get("BACKMARKFORMATNO"));
		logmap.put("RECIPE_GROUP", mainMap.get("WBSPECNO"));
		logmap.put("STD_LOT_SIZE", mainMap.get("LOTSIZE"));
		logmap.put("MAT_UNIT", mainMap.get("LOTUNIT"));
		logmap.put("BU_OPER", mainMap.get("BUSINESSOPERATION"));
		logmap.put("TNR_STD_OUTBOX_QTY", mainMap.get("TNRSTDBOXQTY"));
		logmap.put("TUBE_STD_OUTBOX_QTY", mainMap.get("TUBESTDBOXQTY"));
		logmap.put("TUBE_REAL_PACK_QTY", mainMap.get("REELPACKQTY"));
		logmap.put("STD_PACK_QTY", mainMap.get("STDPACKQTY"));
		logmap.put("HALF_PACK_QTY", mainMap.get("HALFPACKQTY"));
		logmap.put("TNR_QTY", mainMap.get("TNRQTY"));
		logmap.put("TUBE_QTY", mainMap.get("TUBEQTY"));
		logmap.put("TR_NEED_FULL_INBOX", mainMap.get("TUBEQTY"));
		logmap.put("INFO1", mainMap.get("INFORMATION1"));
		logmap.put("INFO2", mainMap.get("INFORMATION2"));
		logmap.put("INFO3", mainMap.get("INFORMATION3"));
		logmap.put("INFO4", mainMap.get("INFORMATION4"));
		logmap.put("INFO5", mainMap.get(" "));
		logmap.put("LABLE1", mainMap.get("LABEL1"));
		logmap.put("LABLE2", mainMap.get("LABEL2"));
		logmap.put("LABLE3", mainMap.get("LABEL3"));
		logmap.put("LABLE4", mainMap.get("LABEL4"));
		logmap.put("LABLE5", mainMap.get("LABEL5"));
		logmap.put("LABLE6", mainMap.get("LABEL6"));
		logmap.put("LABLE7", mainMap.get("LABEL7"));
		logmap.put("LABLE8", mainMap.get("LABEL8"));
		logmap.put("LABLE9", mainMap.get("LABEL9"));
		logmap.put("LABLE10", mainMap.get("LABEL10"));
		logmap.put("LABLE11", mainMap.get("LABEL11"));
		logmap.put("LABLE12", mainMap.get("LABEL12"));
		logmap.put("LABLE13", mainMap.get("LABEL13"));
		logmap.put("LABLE14", mainMap.get("LABEL14"));
		logmap.put("LABLE15", mainMap.get("LABEL15"));
		logmap.put("LABLE16", mainMap.get("LABEL16"));
		logmap.put("LABLE17", mainMap.get("LABEL17"));
		logmap.put("LABLE18", mainMap.get("LABEL18"));
		logmap.put("LABLE19", mainMap.get("LABEL19"));
		logmap.put("LABLE20", mainMap.get(" "));//LABEL120
		logmap.put("MARK1", mainMap.get("MARK1"));
		logmap.put("MARK2", mainMap.get("MARK2"));
		logmap.put("MARK3", mainMap.get("MARK3"));
		logmap.put("MARK4", mainMap.get("MARK4"));
		logmap.put("MARK5", mainMap.get("MARK5"));
		logmap.put("TR_DATA_TYPE", mainMap.get("TRACEDATATYPE"));
		logmap.put("INSTRUCTION1", mainMap.get("INSTRUCTION1"));
		logmap.put("UPPER_WF_THICK", "0");
		logmap.put("LOWER_WF_THICK", "0");
		logmap.put("WF_SIZE", " ");
		logmap.put("MSLLABEL", mainMap.get("MOISTURESENSITIVELABEL"));
		logmap.put("BSM_CODE", mainMap.get("BSMCODE"));
		logmap.put("LOT_CODE", mainMap.get("LOTCODE"));
		logmap.put("TSM_CODE", mainMap.get("TSMCODE"));
		logmap.put("OUT_DEVICE", mainMap.get("OUTDEVICE"));
		logmap.put("MARKNG_SPEC_VERSION", " ");
		logmap.put("CHIP_SIZE_X", "0");
		logmap.put("CHIP_SIZE_Y", "0");
		logmap.put("SCRIBE_WIDTH", " ");
		logmap.put("BPO", " ");
		logmap.put("BPP", " ");
		logmap.put("CARD_PROC_FG", " ");
		logmap.put("PB_FREE_FG", " ");
		logmap.put("DIE_DOWN", " ");
		logmap.put("BOM_NO", " ");
		logmap.put("GRP_DEVICE", " ");
		logmap.put("PROD_CLASS", " ");
		logmap.put("SUB_LOT_SIZE", " ");
		logmap.put("MAX_ASY_LOT_CNT", " ");
		logmap.put("WF_INGREDIENTS", " ");
		logmap.put("CHIP_TYPE", " ");
		logmap.put("DA_MODE", mainMap.get("DIEATTACHTRAIT"));
		logmap.put("DIE_COATING", " ");
		logmap.put("HYGROS_LEVEL", mainMap.get("HYGROSOPICLEVEL"));
		logmap.put("COATING_TYPE", " ");
		logmap.put("CAR_PROD", " ");
		logmap.put("MARK", mainMap.get("MARK"));
		logmap.put("PLATE", mainMap.get("PLATE"));
		logmap.put("REEL_SIZE", mainMap.get("REELSIZE"));
		logmap.put("REEL_DIRACTION", mainMap.get("REELDIRECTION"));
		logmap.put("RELL_QTY", mainMap.get("REELQTY"));
		if (mainMap.get("PLANT").equals("ASSY")) {
			logmap.put("CUST_MAT_ID", mainMap.get("ASSYCUSTOMERMTRLCODE"));
			logmap.put("INSTRUCTION2", mainMap.get("INSTRUCTION2ASSY"));
			logmap.put("INSTRUCTION3", mainMap.get("INSTRUCTION3ASSY"));
			logmap.put("PRIMARY_TCARD", mainMap.get("PRIMARYTCARDASSY"));
		} else if (mainMap.get("PLANT").equals("TEST")) {
			logmap.put("CUST_MAT_ID", mainMap.get("TESTCUSTOMERMTRLCODE"));
			logmap.put("INSTRUCTION2", mainMap.get("INSTRUCTION2TEST"));
			logmap.put("INSTRUCTION3", mainMap.get("INSTRUCTION3TEST"));
			logmap.put("PRIMARY_TCARD", mainMap.get("PRIMARYTCARDTEST"));
		}
		loglist.add(logmap);
		writelog(loglist);
	}

	// 芯片
	private void insertDetail(DetailTable dt, String rid,
			List<Map<String, String>> loglist, Map<String, String> mainMap) {
		Row[] s = dt.getRow();
		BaseBean bb = new BaseBean();
		for (int j = 0; j < s.length; j++) {
			Row r = s[j];
			Cell c[] = r.getCell();
			Map<String, String> dtMap = new HashMap<String, String>();
			for (int k = 0; k < c.length; k++) {
				Cell c1 = c[k];
				String name = c1.getName().toUpperCase();
				String value = Util.null2String(c1.getValue());
				if (Util.null2String(c1.getValue()).isEmpty()) {
					value = " ";
				} else {
					value = Util.null2String(c1.getValue());
				}
				dtMap.put(name, value);
			}
			Map<String, String> logmap = new HashMap<String, String>();
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String time14 = sdf.format(now);
			logmap.put("REQUESTID", rid);
			logmap.put("NODEID", "200");
			logmap.put("INF_TIME", time14);
			logmap.put("INF_SEQ", "1000" + (j + 1));// 序号
			logmap.put("FACTORY", "DIEBANK");
			logmap.put("MAT_ID", dtMap.get("DIEMATERIALCODE"));
			logmap.put("CUST_ID", mainMap.get("CUSTOMER"));
			logmap.put("CUST_MAT_ID", dtMap.get("DIEMATERIALDESCRIPTION"));
			logmap.put("CUST_MAT_DESC", dtMap.get("DIEMATERIALDESCRIPTION"));
			logmap.put("DB_MAT_ID", dtMap.get("DIEMATERIALCODE"));
			logmap.put("PKG_TYPE", " ");
			logmap.put("PACK_CODE", " ");
			logmap.put("PKLD_CODE", " ");
			logmap.put("ADD_BOND_DIAGRAM_NO", dtMap.get("WIREBONDDIAGNO"));
			logmap.put("ADD_BOND_DIAGRAM_REV", dtMap.get("WIREBONDDIAGVERSION"));
			logmap.put("FLOW_ID", " ");
			logmap.put("ORG_CUST_DEVICE_ID", " ");
			logmap.put("TOP_MARK_FORMAT_ID", mainMap.get("TOPMARKFORMATNO"));
			logmap.put("BACK_MARK_FORMAT_ID", mainMap.get("BACKMARKFORMATNO"));
			logmap.put("RECIPE_GROUP", mainMap.get("WBSPECNO"));
			logmap.put("STD_LOT_SIZE", mainMap.get("LOTSIZE"));
			logmap.put("MAT_UNIT", mainMap.get("LOTUNIT"));
			logmap.put("BU_OPER", " ");
			logmap.put("TNR_STD_OUTBOX_QTY", " ");
			logmap.put("TUBE_STD_OUTBOX_QTY", " ");
			logmap.put("TUBE_REAL_PACK_QTY", " ");
			logmap.put("STD_PACK_QTY", " ");
			logmap.put("HALF_PACK_QTY", " ");
			logmap.put("TNR_QTY", " ");
			logmap.put("TUBE_QTY", " ");
			logmap.put("TR_NEED_FULL_INBOX", " ");
			logmap.put("INFO1", mainMap.get("INFORMATION1"));
			logmap.put("INFO2", mainMap.get("INFORMATION2"));
			logmap.put("INFO3", mainMap.get("INFORMATION3"));
			logmap.put("INFO4", mainMap.get("INFORMATION4"));
			logmap.put("INFO5", mainMap.get(" "));//INFORMATION5
			logmap.put("LABLE1", mainMap.get("LABEL1"));
			logmap.put("LABLE2", mainMap.get("LABEL2"));
			logmap.put("LABLE3", mainMap.get("LABEL3"));
			logmap.put("LABLE4", mainMap.get("LABEL4"));
			logmap.put("LABLE5", mainMap.get("LABEL5"));
			logmap.put("LABLE6", mainMap.get("LABEL6"));
			logmap.put("LABLE7", mainMap.get("LABEL7"));
			logmap.put("LABLE8", mainMap.get("LABEL8"));
			logmap.put("LABLE9", mainMap.get("LABEL9"));
			logmap.put("LABLE10", mainMap.get("LABEL10"));
			logmap.put("LABLE11", mainMap.get("LABEL11"));
			logmap.put("LABLE12", mainMap.get("LABEL12"));
			logmap.put("LABLE13", mainMap.get("LABEL13"));
			logmap.put("LABLE14", mainMap.get("LABEL14"));
			logmap.put("LABLE15", mainMap.get("LABEL15"));
			logmap.put("LABLE16", mainMap.get("LABEL16"));
			logmap.put("LABLE17", mainMap.get("LABEL17"));
			logmap.put("LABLE18", mainMap.get("LABEL18"));
			logmap.put("LABLE19", mainMap.get("LABEL19"));
			logmap.put("LABLE20", mainMap.get(" "));//LABEL120
			logmap.put("MARK1", mainMap.get("MARK1"));
			logmap.put("MARK2", mainMap.get("MARK2"));
			logmap.put("MARK3", mainMap.get("MARK3"));
			logmap.put("MARK4", mainMap.get("MARK4"));
			logmap.put("MARK5", mainMap.get("MARK5"));
			logmap.put("TR_DATA_TYPE", " ");
			logmap.put("INSTRUCTION1", " ");
			logmap.put("INSTRUCTION2", " ");
			logmap.put("INSTRUCTION3", " ");
			logmap.put("UPPER_WF_THICK", " ");
			logmap.put("LOWER_WF_THICK", " ");
			logmap.put("WF_SIZE", " ");
			logmap.put("PRIMARY_TCARD", " ");
			logmap.put("MSLLABEL", " ");
			logmap.put("BSM_CODE", " ");
			logmap.put("LOT_CODE", " ");
			logmap.put("TSM_CODE", " ");
			logmap.put("OUT_DEVICE", " ");
			logmap.put("MARKNG_SPEC_VERSION", " ");
			logmap.put("CHIP_SIZE_X", dtMap.get("CHIPSIZEX"));
			logmap.put("CHIP_SIZE_Y", dtMap.get("CHIPSIZEY"));
			logmap.put("SCRIBE_WIDTH", dtMap.get("SCRIBEWIDTH"));
			logmap.put("BPO", dtMap.get("BPO"));
			logmap.put("BPP", dtMap.get("BPP"));
			logmap.put("CARD_PROC_FG", " ");
			logmap.put("PB_FREE_FG", " ");
			logmap.put("DIE_DOWN", " ");
			logmap.put("BOM_NO", " ");
			logmap.put("GRP_DEVICE", " ");
			logmap.put("PROD_CLASS", " ");
			logmap.put("SUB_LOT_SIZE", " ");
			logmap.put("MAX_ASY_LOT_CNT", " ");
			logmap.put("WF_INGREDIENTS", dtMap.get("WAFERINGREDIENT"));
			logmap.put("CHIP_TYPE", dtMap.get("CHIPTYPE"));
			logmap.put("DA_MODE", " ");
			logmap.put("DIE_COATING", " ");
			logmap.put("HYGROS_LEVEL", " ");
			logmap.put("COATING_TYPE", " ");
			logmap.put("CAR_PROD", " ");
			logmap.put("MARK", " ");
			logmap.put("PLATE", " ");
			logmap.put("REEL_SIZE", " ");
			logmap.put("REEL_DIRACTION", " ");
			logmap.put("RELL_QTY", " ");
			loglist.add(logmap);
		}
	}

	private void writelog(List<Map<String, String>> loglist) {
		SapLogWriter.writerlog(loglist, logtablename);
	}

}

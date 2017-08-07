package weaver.interfaces.sap;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.weaver.formmodel.util.Cn2spell;

import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.entity.CInfBomDat;
import weaver.interfaces.entity.CInfBomDatDetailTable;
import weaver.interfaces.entity.CInfBomDatMainTable;
import weaver.interfaces.entity.CInfFlwDat;
import weaver.interfaces.entity.CInfFlwDatDetailTable;
import weaver.interfaces.entity.CInfFlwDatMainTable;
import weaver.interfaces.entity.CInfPatDat;
import weaver.interfaces.entity.CInfPatDatDetailTable;
import weaver.interfaces.entity.CInfPatDatMainTable;
import weaver.interfaces.entity.CInfSpeDat;
import weaver.interfaces.entity.CInfSpeDatDetailTable;
import weaver.interfaces.entity.CInfSpeDatMainTable;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class PostTest {

	private static final String url = "http://172.16.60.96:8099/MesWebService/req";

	private CInfSpeDatMainTable cInfSpeDatMainTable = new CInfSpeDatMainTable();
	private CInfSpeDatDetailTable cInfSpeDatDetailTable = new CInfSpeDatDetailTable();
	private CInfPatDatMainTable cInfPatDatMainTable = new CInfPatDatMainTable();
	private CInfPatDatDetailTable cInfPatDatDetailTable = new CInfPatDatDetailTable();
	private CInfFlwDatMainTable cInfFlwDatMainTable = new CInfFlwDatMainTable();
	private CInfFlwDatDetailTable cInfFlwDatDetailTable = new CInfFlwDatDetailTable();
	private CInfBomDatMainTable cInfBomDatMainTable = new CInfBomDatMainTable();
	private CInfBomDatDetailTable cInfBomDatDetailTable = new CInfBomDatDetailTable();
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	String infTime = sdf.format(date);
	String createTime = sdf.format(date);
	String updateTime = sdf.format(date);
	private String name;
	String value = " ";

	/**
	 * @param dt
	 * @param rid
	 * @param maintableinfo
	 * @return
	 */
	public void setcinfspedat(DetailTable dt, String rid,
			MainTableInfo maintableinfo) {
		BaseBean baseBean = new BaseBean();
		try {
			baseBean.writeLog("*****setcinfspedat开始执行*****");
			/**
			 * 主表
			 */
			Property[] properties = maintableinfo.getProperty();// 获取表单主字段数据
			baseBean.writeLog("properties.length:" + properties.length);

			for (int i = 0; i < properties.length; i++) {// 主表数据
				name = properties[i].getName().toUpperCase();// 主表字段名
				if (Util.null2String(properties[i].getValue()) == ""
						|| Util.null2String(properties[i].getValue()) == null) {// 判断取得的值是不是为空值
																				// 若为空值
																				// 则把value赋值为空格
					value = " ";
				} else {
					value = Util.null2String(properties[i].getValue());// 值
				}
				if (name.equals("PRODUCTMATERIALDOCE2")) {
					cInfSpeDatMainTable.setProductMaterialCode2(value);
				}
				if (name.equals("CUSTOMER")) {
					cInfSpeDatMainTable.setCustomer(value);
				}
				if (name.equals("ASSYCUSTOMERMTRLCODE")
						|| name.equals("TESTCUSTOMERMTRLCODE")) {
					cInfSpeDatMainTable.setAorTCustomerMtrlCode(value);
				}
				if (name.equals("CUSTOMERMTRLDESCRIPTION")) {
					cInfSpeDatMainTable.setCustomerMtrlDescription(value);
				}
				if (name.equals("PACKAGEOUTLINE")) {
					cInfSpeDatMainTable.setPackageOutline(value);
				}
				if (name.equals("WIREBONDDIAGNO")) {
					cInfSpeDatMainTable.setWireBondDiagNo(value);
				}
				if (name.equals("WIREBONDDIAGVERSION")) {
					cInfSpeDatMainTable.setWireBondDiagVersion(value);
				}
				if (name.equals("TOPMARKFORMATNO")) {
					cInfSpeDatMainTable.setTopMarkFormatNo(value);
				}
				if (name.equals("BACKMARKFORMATNO")) {
					cInfSpeDatMainTable.setBackMarkFormatNo(value);
				}
				if (name.equals("WBSPECNO")) {
					cInfSpeDatMainTable.setWBSpecNo(value);
				}
				if (name.equals("LOTSIZE")) {
					cInfSpeDatMainTable.setLotSize(value);
				}
				if (name.equals("LOTUNIT")) {
					cInfSpeDatMainTable.setLotUnit(value);
				}
				if (name.equals("BUSINESSOPERATION")) {
					cInfSpeDatMainTable.setBusinessOperation(value);
				}
				if (name.equals("TNRSTDBOXQTY")) {
					cInfSpeDatMainTable.setTNRStdBoxQty(value);
				}
				if (name.equals("TUBESTDBOXQTY")) {
					cInfSpeDatMainTable.setTubeStdBoxQty(value);
				}
				if (name.equals("REELPACKQTY")) {
					cInfSpeDatMainTable.setReelPackQty(value);
				}
				if (name.equals("STDPACKQTY")) {
					cInfSpeDatMainTable.setStdPackQty(value);
				}
				if (name.equals("HALFPACKQTY")) {
					cInfSpeDatMainTable.setHalfPackQty(value);
				}
				if (name.equals("TNRQTY")) {
					cInfSpeDatMainTable.setTNRQty(value);
				}
				if (name.equals("TUBEQTY")) {
					cInfSpeDatMainTable.setTubeQty(value);
				}
				if (name.equals("INFORMATION1")) {
					cInfSpeDatMainTable.setInformation1(value);
				}
				if (name.equals("INFORMATION2")) {
					cInfSpeDatMainTable.setInformation2(value);
				}
				if (name.equals("INFORMATION3")) {
					cInfSpeDatMainTable.setInformation3(value);
				}
				if (name.equals("INFORMATION4")) {
					cInfSpeDatMainTable.setInformation4(value);
				}
				if (name.equals("INFORMATION5")) {
					cInfSpeDatMainTable.setInformation5(value);
				}
				if (name.equals("LABEL1")) {
					cInfSpeDatMainTable.setLable1(value);
				}
				if (name.equals("LABEL2")) {
					cInfSpeDatMainTable.setLable2(value);
				}
				if (name.equals("LABEL3")) {
					cInfSpeDatMainTable.setLable3(value);
				}
				if (name.equals("LABEL4")) {
					cInfSpeDatMainTable.setLable4(value);
				}
				if (name.equals("LABEL5")) {
					cInfSpeDatMainTable.setLable5(value);
				}
				if (name.equals("LABEL6")) {
					cInfSpeDatMainTable.setLable6(value);
				}
				if (name.equals("LABEL7")) {
					cInfSpeDatMainTable.setLable7(value);
				}
				if (name.equals("LABEL8")) {
					cInfSpeDatMainTable.setLable8(value);
				}
				if (name.equals("LABEL9")) {
					cInfSpeDatMainTable.setLable9(value);
				}
				if (name.equals("LABEL10")) {
					cInfSpeDatMainTable.setLable10(value);
				}
				if (name.equals("LABEL11")) {
					cInfSpeDatMainTable.setLable11(value);
				}
				if (name.equals("LABEL12")) {
					cInfSpeDatMainTable.setLable12(value);
				}
				if (name.equals("LABEL13")) {
					cInfSpeDatMainTable.setLable13(value);
				}
				if (name.equals("LABEL14")) {
					cInfSpeDatMainTable.setLable14(value);
				}
				if (name.equals("LABEL15")) {
					cInfSpeDatMainTable.setLable15(value);
				}
				if (name.equals("LABEL16")) {
					cInfSpeDatMainTable.setLable16(value);
				}
				if (name.equals("LABEL17")) {
					cInfSpeDatMainTable.setLable17(value);
				}
				if (name.equals("LABEL18")) {
					cInfSpeDatMainTable.setLable18(value);
				}
				if (name.equals("LABEL19")) {
					cInfSpeDatMainTable.setLable19(value);
				}
				if (name.equals("LABEL20")) {
					cInfSpeDatMainTable.setLable20(value);
				}
				if (name.equals("MARK1")) {
					cInfSpeDatMainTable.setMark1(value);
				}
				if (name.equals("MARK2")) {
					cInfSpeDatMainTable.setMark2(value);
				}
				if (name.equals("MARK3")) {
					cInfSpeDatMainTable.setMark3(value);
				}
				if (name.equals("MARK4")) {
					cInfSpeDatMainTable.setMark4(value);
				}
				if (name.equals("MARK5")) {
					cInfSpeDatMainTable.setMark5(value);
				}
				if (name.equals("TRACEDATATYPE")) {
					cInfSpeDatMainTable.setTraceDataType(value);
				}
				if (name.equals("INSTRUCTION1")) {
					cInfSpeDatMainTable.setInstruction1(value);
				}
				if (name.equals("INSTRUCTION2ASSY")
						|| name.equals("INSTRUCTION2TEST")) {
					cInfSpeDatMainTable.setInstruction2AssyorTest(value);
				}
				if (name.equals("INSTRUCTION3ASSY")
						|| name.equals("INSTRUCTION3TEST")) {
					cInfSpeDatMainTable.setInstruction3AssyorTest(value);
				}
				if (name.equals("PRIMARYTCARDTEST")
						|| name.equals("PRIMARYTCARDASSY")) {
					cInfSpeDatMainTable.setPrimaryAorTCardAssy(value);
				}
				if (name.equals("MOISTURESENSITIVELABEL")) {
					cInfSpeDatMainTable.setMoistureSensitiveLabel(value);
				}
				if (name.equals("BSMCODE")) {
					cInfSpeDatMainTable.setBSMCode(value);
				}
				if (name.equals("LOTCODE")) {
					cInfSpeDatMainTable.setLotCode(value);
				}
				if (name.equals("TSMCODE")) {
					cInfSpeDatMainTable.setTSMCode(value);
				}
				if (name.equals("OUTDEVICE")) {
					cInfSpeDatMainTable.setOutDevice(value);
				}
				if (name.equals("DIEATTACHTRAIT")) {
					cInfSpeDatMainTable.setDieAttachTrait(value);
				}
				if (name.equals("HYGROSOPICLEVEL")) {
					cInfSpeDatMainTable.setHygrosopicLevel(value);
				}
				if (name.equals("MARK")) {
					cInfSpeDatMainTable.setMark(value);
				}
				if (name.equals("PLATE")) {
					cInfSpeDatMainTable.setPlate(value);
				}
				if (name.equals("REELSIZE")) {
					cInfSpeDatMainTable.setReelSize(value);
				}
				if (name.equals("REELDIRECTION")) {
					cInfSpeDatMainTable.setReelDirection(value);
				}
				if (name.equals("REELQTY")) {
					cInfSpeDatMainTable.setReelQty(value);
				}
				if (name.equals("TESTTIME")) {
					cInfSpeDatMainTable.setTestTime(value);
				}
				if (name.equals("INDEXTIME")) {
					cInfSpeDatMainTable.setIndexTime(value);
				}
			}

			/**
			 * 明细
			 */
			Row[] rows = dt.getRow();
			JSONObject req = new JSONObject();
			JSONObject message = new JSONObject();
			JSONObject shell = new JSONObject();
			List<JSONObject> cInfSpeDatList = new ArrayList<JSONObject>();
			// JSONArray cInfSpeDatList = new JSONArray();
			for (int i = 0; i < rows.length; i++) {
				Row row = rows[i];// 指定行
				Cell[] cells = row.getCell();// 每行数据再按列存储
				for (int j = 0; j < cells.length; j++) {
					Cell cell = cells[j];// 指定列
					name = cell.getName().toUpperCase();// 明细字段名
					if (Util.null2String(cell.getValue()).isEmpty()
							|| Util.null2String(cell.getValue()) == null) {
						value = " ";
					} else {
						value = Util.null2String(cell.getValue());
					}
					if (name.equals("DIEMATERIALCODE")) {
						cInfSpeDatDetailTable.setDieMaterialCode(value);
					}
					if (name.equals("DIEMATERIALDESCRIPTION")) {
						cInfSpeDatDetailTable.setDieMaterialDescription(value);
					}
					if (name.equals("UPPERTHICK")) {
						cInfSpeDatDetailTable.setUpperThick(value);
					}
					if (name.equals("SPECIALLOWWERTHICKU1")
							|| name.equals("SPECIALLOWWERTHICKU2")
							|| name.equals("SPECIALLOWWERTHICKU3")) {
						cInfSpeDatDetailTable.setSpecialLowwerThickU1(value);
					}
					if (name.equals("WAFERSIZE")) {
						cInfSpeDatDetailTable.setWaferSize(value);
					}
					if (name.equals("CHIPSIZEX")) {
						cInfSpeDatDetailTable.setChipSizeX(value);
					}
					if (name.equals("CHIPSIZEY")) {
						cInfSpeDatDetailTable.setChipSizeY(value);
					}
					if (name.equals("SCRIBEWIDTH")) {
						cInfSpeDatDetailTable.setScribeWidth(value);
					}
					if (name.equals("BPO")) {
						cInfSpeDatDetailTable.setBPO(value);
					}
					if (name.equals("BPP")) {
						cInfSpeDatDetailTable.setBPP(value);
					}
					if (name.equals("WAFERINGREDIENT")) {
						cInfSpeDatDetailTable.setWaferIngredient(value);
					}
					if (name.equals("CHIPTYPE")) {
						cInfSpeDatDetailTable.setChipType(value);
					}
				}
				req.put("fromSystem", "OA");
				req.put("functionName", "MES_UPLOADMASTERDATA");
				req.put("token", "OATESTTOKEN");
				shell.put("infTime", infTime);
				shell.put("infSeq", i + 1001);
				shell.put("factory", "DIEBANK");
				shell.put("matId",
						cInfSpeDatMainTable.getProductMaterialCode2());
				shell.put("custId", cInfSpeDatMainTable.getCustomer());
				shell.put("custMatId",
						cInfSpeDatMainTable.getAorTCustomerMtrlCode());// 客户品名
				shell.put("custMatDesc",
						cInfSpeDatMainTable.getCustomerMtrlDescription());
				shell.put("dbMatId", cInfSpeDatDetailTable.getDieMaterialCode());
				shell.put("pkgType", cInfSpeDatMainTable.getPackageOutline());
				shell.put("packCode", "&nbsp;");
				shell.put("pkldCode", cInfSpeDatMainTable.getPackageOutline());
				shell.put("addBondDiagramNo",
						cInfSpeDatMainTable.getWireBondDiagNo());
				shell.put("addBondDiagramRev",
						cInfSpeDatMainTable.getWireBondDiagVersion());
				shell.put("flowId", "&nbsp;");
				shell.put("orgCustDeviceId", "&nbsp;");
				shell.put("topMarkFormatId",
						cInfSpeDatMainTable.getTopMarkFormatNo());
				shell.put("backMarkFormatId",
						cInfSpeDatMainTable.getBackMarkFormatNo());
				shell.put("recipeGroup", cInfSpeDatMainTable.getWBSpecNo());
				shell.put("stdLotSize", cInfSpeDatMainTable.getLotSize());
				shell.put("matUnit", cInfSpeDatMainTable.getLotUnit());
				shell.put("buOper", cInfSpeDatMainTable.getBusinessOperation());
				shell.put("tnrStdOutboxQty",
						cInfSpeDatMainTable.getTNRStdBoxQty());
				shell.put("tubeStdOutboxQty",
						cInfSpeDatMainTable.getTubeStdBoxQty());
				shell.put("tubeRealPackQty",
						cInfSpeDatMainTable.getReelPackQty());
				shell.put("stdPackQty", cInfSpeDatMainTable.getStdPackQty());
				shell.put("halfPackQty", cInfSpeDatMainTable.getHalfPackQty());
				shell.put("tnrQty", cInfSpeDatMainTable.getTNRQty());
				shell.put("tubeQty", cInfSpeDatMainTable.getTubeQty());
				shell.put("trNeedFullInbox", cInfSpeDatMainTable.getTubeQty());
				shell.put("info1", cInfSpeDatMainTable.getInformation1());
				shell.put("info2", cInfSpeDatMainTable.getInformation2());
				shell.put("info3", cInfSpeDatMainTable.getInformation3());
				shell.put("info4", cInfSpeDatMainTable.getInformation4());
				shell.put("info5", cInfSpeDatMainTable.getInformation5());// formtable_main_78
				shell.put("lable1", cInfSpeDatMainTable.getLable1());
				shell.put("lable2", cInfSpeDatMainTable.getLable2());
				shell.put("lable3", cInfSpeDatMainTable.getLable3());
				shell.put("lable4", cInfSpeDatMainTable.getLable4());
				shell.put("lable5", cInfSpeDatMainTable.getLable5());
				shell.put("lable6", cInfSpeDatMainTable.getLable6());
				shell.put("lable7", cInfSpeDatMainTable.getLable7());
				shell.put("lable8", cInfSpeDatMainTable.getLable8());
				shell.put("lable9", cInfSpeDatMainTable.getLable9());
				shell.put("lable10", cInfSpeDatMainTable.getLable10());
				shell.put("lable11", cInfSpeDatMainTable.getLable11());
				shell.put("lable12", cInfSpeDatMainTable.getLable12());
				shell.put("lable13", cInfSpeDatMainTable.getLable13());
				shell.put("lable14", cInfSpeDatMainTable.getLable14());
				shell.put("lable15", cInfSpeDatMainTable.getLable15());
				shell.put("lable16", cInfSpeDatMainTable.getLable16());
				shell.put("lable17", cInfSpeDatMainTable.getLable17());
				shell.put("lable18", cInfSpeDatMainTable.getLable18());
				shell.put("lable19", cInfSpeDatMainTable.getLable19());
				shell.put("lable20", cInfSpeDatMainTable.getLable20());
				shell.put("mark1", cInfSpeDatMainTable.getMark1());
				shell.put("mark2", cInfSpeDatMainTable.getMark2());
				shell.put("mark3", cInfSpeDatMainTable.getMark3());
				shell.put("mark4", cInfSpeDatMainTable.getMark4());
				shell.put("mark5", cInfSpeDatMainTable.getMark5());
				shell.put("trDataType", cInfSpeDatMainTable.getTraceDataType());
				shell.put("instruction1", cInfSpeDatMainTable.getInstruction1());
				shell.put("instruction2",
						cInfSpeDatMainTable.getInstruction2AssyorTest());
				shell.put("instruction3",
						cInfSpeDatMainTable.getInstruction3AssyorTest());
				shell.put("upperWfThick", cInfSpeDatDetailTable.getUpperThick());
				shell.put("lowerWfThick",
						cInfSpeDatDetailTable.getSpecialLowwerThickU1());
				shell.put("wfSize", cInfSpeDatDetailTable.getWaferSize());
				shell.put("primaryTcard",
						cInfSpeDatMainTable.getPrimaryAorTCardAssy());
				shell.put("msllabel",
						cInfSpeDatMainTable.getMoistureSensitiveLabel());
				shell.put("bsmCode", cInfSpeDatMainTable.getBSMCode());
				shell.put("lotCode", cInfSpeDatMainTable.getLotCode());
				shell.put("tsmCode", cInfSpeDatMainTable.getTSMCode());
				shell.put("outDevice", cInfSpeDatMainTable.getOutDevice());
				shell.put("markngSpecVersion", " ");
				shell.put("chipSizeX", cInfSpeDatDetailTable.getChipSizeX());
				shell.put("chipSizeY", cInfSpeDatDetailTable.getChipSizeY());
				shell.put("scribeWidth", cInfSpeDatDetailTable.getScribeWidth());
				shell.put("bpo", cInfSpeDatDetailTable.getBPO());
				shell.put("bpp", cInfSpeDatDetailTable.getBPP());
				shell.put("cardProcFg", "&nbsp;");
				shell.put("pbFreeFg", "&nbsp;");
				shell.put("dieDown", "&nbsp;");
				shell.put("bomNo", "&nbsp;");
				shell.put("grpDevice", "&nbsp;");
				shell.put("prodClass", "&nbsp;");
				shell.put("subLotSize", "&nbsp;");
				shell.put("maxAsyLotCnt", "&nbsp;");
				shell.put("wfIngredients",
						cInfSpeDatDetailTable.getWaferIngredient());
				shell.put("chipType", cInfSpeDatDetailTable.getChipType());
				shell.put("daMode", cInfSpeDatMainTable.getDieAttachTrait());
				shell.put("dieCoating", "&nbsp;");
				shell.put("hygrosLevel",
						cInfSpeDatMainTable.getHygrosopicLevel());
				shell.put("coatingType", "&nbsp;");
				shell.put("carProd", "&nbsp;");
				shell.put("mark", cInfSpeDatMainTable.getMark());
				shell.put("plate", cInfSpeDatMainTable.getPlate());
				shell.put("reelSize", cInfSpeDatMainTable.getReelSize());
				shell.put("reelDiraction",
						cInfSpeDatMainTable.getReelDirection());
				shell.put("rellQty", cInfSpeDatMainTable.getReelQty());
				shell.put("halogenFProd", "&nbsp;");
				shell.put("stripProd", "&nbsp;");
				shell.put("padType", "&nbsp;");
				shell.put("testFlwChart", "&nbsp;");
				shell.put("testPlatfom", "&nbsp;");
				shell.put("testSystem", "&nbsp;");
				shell.put("testHandler", "&nbsp;");
				shell.put("testPrgRev1", "&nbsp;");
				shell.put("qaPrg1", "&nbsp;");
				shell.put("qaPrg2", "&nbsp;");
				shell.put("testTempe", "&nbsp;");
				shell.put("dieRunCodeFg", "&nbsp;");
				shell.put("assyTestFg", "&nbsp;");
				shell.put("stdCycleTime", "&nbsp;");
				shell.put("procStatus", "&nbsp;");
				shell.put("seqNo", "&nbsp;");
				shell.put("bgReqFlag", "&nbsp;");
				shell.put("wfMapReqFg", "&nbsp;");
				shell.put("lastTestDate", "&nbsp;");
				shell.put("wfDevice", "&nbsp;");
				shell.put("engCode", "&nbsp;");
				shell.put("secondTcardFactory", "&nbsp;");
				shell.put("priTcardFactory", "&nbsp;");
				shell.put("markSpecNo", "&nbsp;");
				shell.put("packingMethod", "&nbsp;");
				shell.put("prodDesc", "&nbsp;");
				shell.put("numberFullLabel", "&nbsp;");
				shell.put("numberInnerLabel", "&nbsp;");
				shell.put("traceFormat", "&nbsp;");
				shell.put("burninFg", "&nbsp;");
				shell.put("cardPhaseType", "&nbsp;");
				shell.put("secondTcard", "&nbsp;");
				shell.put("markType", "&nbsp;");
				shell.put("moldType", "&nbsp;");
				shell.put("plattingType", "&nbsp;");
				shell.put("wireQty", "&nbsp;");
				shell.put("tubeRemark", "&nbsp;");
				shell.put("packingType", "&nbsp;");
				shell.put("bpcInst", "&nbsp;");
				shell.put("flowName", "&nbsp;");
				shell.put("limitTime", "&nbsp;");
				shell.put("bdSbName", "&nbsp;");
				shell.put("wbDevice", "&nbsp;");
				shell.put("markDevice", "&nbsp;");
				shell.put("bodySize", "&nbsp;");
				shell.put("leadCount", "&nbsp;");
				shell.put("fluxPrintStencil", "&nbsp;");
				shell.put("ballMountStancil", "&nbsp;");
				shell.put("postReticle", "&nbsp;");
				shell.put("prodPreFix", "&nbsp;");
				shell.put("resinThickness", "&nbsp;");
				shell.put("waferThickness", "&nbsp;");
				shell.put("ballType", "&nbsp;");
				shell.put("ballSize", "&nbsp;");
				shell.put("ballPlacement", "&nbsp;");
				shell.put("piReticle", "&nbsp;");
				shell.put("rdlReticle", "&nbsp;");
				shell.put("ubmReticle", "&nbsp;");
				shell.put("resin", "&nbsp;");
				shell.put("cmf1", cInfSpeDatMainTable.getTestTime());
				shell.put("cmf2", "&nbsp;");
				shell.put("cmf3", "&nbsp;");
				shell.put("cmf4", "&nbsp;");
				shell.put("cmf5", "&nbsp;");
				shell.put("readFlag", "&nbsp;");
				shell.put("infMsg", "&nbsp;");
				shell.put("infFlag", "&nbsp;");
				shell.put("bumpReticle", "&nbsp;");
				shell.put("cmf6", cInfSpeDatMainTable.getIndexTime());
				shell.put("cmf7", "&nbsp;");
				shell.put("cmf8", "&nbsp;");
				shell.put("cmf9", "&nbsp;");
				shell.put("cmf10", "&nbsp;");
				shell.put("cmf11", "&nbsp;");
				shell.put("cmf12", "&nbsp;");
				shell.put("cmf13", "&nbsp;");
				shell.put("cmf14", "&nbsp;");
				shell.put("cmf15", "&nbsp;");
				shell.put("cmf16", "&nbsp;");
				shell.put("cmf17", "&nbsp;");
				shell.put("cmf18", "&nbsp;");
				shell.put("cmf19", "&nbsp;");
				shell.put("cmf20", "&nbsp;");
				shell.put("cmf21", "&nbsp;");
				shell.put("cmf22", "&nbsp;");
				shell.put("cmf23", "&nbsp;");
				shell.put("cmf24", "&nbsp;");
				shell.put("cmf25", "&nbsp;");
				shell.put("cmf26", "&nbsp;");
				shell.put("cmf27", "&nbsp;");
				shell.put("cmf28", "&nbsp;");
				shell.put("cmf29", "&nbsp;");
				shell.put("cmf30", "&nbsp;");
				shell.put("piReticle2", "&nbsp;");
				shell.put("ubmReticle2", "&nbsp;");
				shell.put("resvField1", "&nbsp;");
				shell.put("resvField2", "&nbsp;");
				shell.put("resvField3", "&nbsp;");
				shell.put("resvField4", "&nbsp;");
				shell.put("resvField5", "&nbsp;");
				shell.put("resvField6", "&nbsp;");
				shell.put("resvField7", "&nbsp;");
				shell.put("resvField8", "&nbsp;");
				shell.put("resvField9", "&nbsp;");
				shell.put("resvField10", "&nbsp;");
				shell.put("label21", "&nbsp;");
				shell.put("label22", "&nbsp;");
				shell.put("label23", "&nbsp;");
				shell.put("label24", "&nbsp;");
				shell.put("label25", "&nbsp;");
				shell.put("label26", "&nbsp;");
				shell.put("label27", "&nbsp;");
				shell.put("label28", "&nbsp;");
				shell.put("label29", "&nbsp;");
				shell.put("label30", "&nbsp;");
				cInfSpeDatList.add(shell);
				baseBean.writeLog(cInfSpeDatList);
				message.put("cInfSpeDatList", cInfSpeDatList);
				baseBean.writeLog("message" + message);
				req.put("message", message);
				baseBean.writeLog("req" + req);
				String retSrcs = HttpClientJson.readInterfacePost(url,
						req.toString());
				JSONObject results = new JSONObject(retSrcs);
				String statusValue = results.get("statusValue").toString();
				String msg = results.get("msg").toString();
				baseBean.writeLog("retSrcs--" + retSrcs);
				baseBean.writeLog("statusValue--" + statusValue);
				baseBean.writeLog("msg--" + msg);
			}
		} catch (JSONException e) {
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("CINFPATDATTest error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}

	}

	/**
	 * 
	 * @param dt
	 * @param rid
	 * @param maintableinfo
	 * @param creator
	 * @return
	 */
	public void setcinfpatdat(DetailTable dt, String rid,
			MainTableInfo maintableinfo, String creator) {
		BaseBean baseBean = new BaseBean();
		try {
			baseBean.writeLog("*****setcinfpatdat开始执行*****");
			/**
			 * 主表
			 */
			Property[] properties = maintableinfo.getProperty();// 获取表单主字段数据
			baseBean.writeLog("properties.length:" + properties.length);
			for (int i = 0; i < properties.length; i++) {// 主表数据
				name = properties[i].getName().toUpperCase();// 主表字段名

				if (Util.null2String(properties[i].getValue()).isEmpty()) {
					value = " ";
				} else {
					value = Util.null2String(properties[i].getValue());// 值
				}
				if (name.equals("PRODUCTMATERIALCODE")) {
					cInfPatDatMainTable.setProductMaterialCode(value);
				}
				if (name.equals("PLANT")) {
					cInfPatDatMainTable.setPlant(value);
				}
				if (name.equals("USAGE")) {
					cInfPatDatMainTable.setUsage(value);
				}
				if (name.equals("ALTERNATIVEBOM")) {
					cInfPatDatMainTable.setAlternativeBom(value);
				}
			}
			// 以上是主表字段

			/**
			 * 明细
			 */
			Row[] rows = dt.getRow();
			JSONObject req = new JSONObject();
			JSONObject message = new JSONObject();
			JSONObject shell = new JSONObject();
			List<JSONObject> cInfPatDatList = new ArrayList<JSONObject>();
			for (int i = 0; i < rows.length; i++) {
				Row row = rows[i];// 指定行
				Cell[] cells = row.getCell();// 每行数据再按列存储
				for (int k = 0; k < cells.length; k++) {
					Cell cell = cells[k];// 指定列
					name = cell.getName().toUpperCase();// 明细字段名
					if (Util.null2String(cell.getValue()).isEmpty()) {
						value = " ";
					} else {
						value = Util.null2String(cell.getValue());
					}
					if (name.equals("ALTERNATIVETEXT")) {
						cInfPatDatDetailTable.setAlternativeText(value);
					}
					if (name.equals("POSNR")) {
						cInfPatDatDetailTable.setPOSNR(value);
					}
					if (name.equals("IDNRK")) {
						cInfPatDatDetailTable.setIDNRK(value);
					}
					if (name.equals("OPERITEMNO")) {
						cInfPatDatDetailTable.setOPERITEMNO(value);
					}
					if (name.equals("OPERDESC")) {
						cInfPatDatDetailTable.setOPERDESC(value);
					}
					if (name.equals("INVNAME")) {
						cInfPatDatDetailTable.setINVNAME(value);
					}
					if (name.equals("MENGE")) {
						cInfPatDatDetailTable.setMENGE(value);
					}
					if (name.equals("SILKQTY")) {
						cInfPatDatDetailTable.setSILKQTY(value);
					}
					if (name.equals("MEINS")) {
						cInfPatDatDetailTable.setMEINS(value);
					}
					if (name.equals("ALPGR")) {
						cInfPatDatDetailTable.setALPGR(value);
					}
					if (name.equals("ALPRF")) {
						cInfPatDatDetailTable.setALPRF(value);
					}
					if (name.equals("ALPST")) {
						cInfPatDatDetailTable.setALPST(value);
					}
					if (name.equals("ALPM")) {
						cInfPatDatDetailTable.setALPM(value);
					}
					if (name.equals("LGORT")) {
						cInfPatDatDetailTable.setLGORT(value);
					}
					if (name.equals("SANKA")) {
						cInfPatDatDetailTable.setSANKA(value);
					}
					if (name.equals("BYMPQTY")) {
						cInfPatDatDetailTable.setBumpQTY(value);
					}
				}
				req.put("fromSystem", "OA");
				req.put("functionName", "MES_UPLOADMASTERDATA");
				req.put("token", "OATESTTOKEN");
				shell.put("infTime", infTime);
				shell.put("infSeq", String.valueOf(i + 1));
				shell.put("matnr", cInfPatDatMainTable.getProductMaterialCode());
				shell.put("werks", cInfPatDatMainTable.getPlant());
				shell.put("stlan", cInfPatDatMainTable.getUsage());
				shell.put("stlal", cInfPatDatMainTable.getAlternativeBom());
				shell.put("plnnr", "&nbsp;");
				shell.put("posnr", cInfPatDatDetailTable.getPOSNR());
				shell.put("idnrk", cInfPatDatDetailTable.getIDNRK());
				shell.put("menge", cInfPatDatDetailTable.getMENGE());
				shell.put("meins", cInfPatDatDetailTable.getMEINS());
				shell.put("ausch", cInfPatDatDetailTable.getSILKQTY());
				shell.put("alpgr", cInfPatDatDetailTable.getALPGR());
				shell.put("alprf", cInfPatDatDetailTable.getALPRF());
				shell.put("alpst", cInfPatDatDetailTable.getALPST());
				shell.put("ewahr", "&nbsp;");
				shell.put("itsob", "&nbsp;");
				shell.put("lgort", cInfPatDatDetailTable.getLGORT());
				shell.put("sanka", cInfPatDatDetailTable.getSANKA());
				shell.put("readFlag", "&nbsp;");
				shell.put("infMsg", "&nbsp;");
				shell.put("infFlag", "&nbsp;");
				shell.put("cmf1", "&nbsp;");
				shell.put("cmf2", "&nbsp;");
				shell.put("cmf3", "&nbsp;");
				shell.put("cmf4", "&nbsp;");
				shell.put("cmf5", "&nbsp;");
				shell.put("cmf6", "&nbsp;");
				shell.put("cmf7", "&nbsp;");
				shell.put("cmf8", "&nbsp;");
				shell.put("cmf9", "&nbsp;");
				shell.put("cmf10", "&nbsp;");
				shell.put("deleteFlag", "&nbsp;");
				shell.put("createTime", createTime);
				shell.put("createUserId", creator);
				shell.put("updateTime", updateTime);
				shell.put("updateUserId", creator);
				shell.put("deleteTime", "&nbsp;");
				shell.put("deleteUserId", "&nbsp;");
				cInfPatDatList.add(shell);
				baseBean.writeLog(cInfPatDatList);
				message.put("cInfPatDatList", cInfPatDatList);
				baseBean.writeLog("message" + message);
				req.put("message", message);
				baseBean.writeLog("req" + req);
				String retSrcs = HttpClientJson.readInterfacePost(url,
						req.toString());
				JSONObject results = new JSONObject(retSrcs);
				String statusValue = results.get("statusValue").toString();
				String msg = results.get("msg").toString();
				baseBean.writeLog("retSrcs--" + retSrcs);
				baseBean.writeLog("statusValue--" + statusValue);
				baseBean.writeLog("msg--" + msg);
			}
		} catch (JSONException e) {
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("CINFPATDATTest error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
	}
	
	/**
	 * 
	 * @param dt
	 * @param rid
	 * @param maintableinfo
	 * @param creator
	 */
	public void setcinfflwdat(DetailTable dt, String rid,
			MainTableInfo maintableinfo, String creator) {
		BaseBean baseBean = new BaseBean();
		try {
			baseBean.writeLog("*****setcinfflwdat开始执行*****");
			/**
			 * 主表
			 */
			Property[] properties = maintableinfo.getProperty();// 获取表单主字段数据
			for (int i = 0; i < properties.length; i++) {// 主表数据
				name = properties[i].getName().toUpperCase();// 主表字段名
				if (Util.null2String(properties[i].getValue()).isEmpty()) {
					value = " ";
				} else {
					value = Util.null2String(properties[i].getValue());// 值
				}
				if (name.equals("PRODUCTMATERIALCODE1")) {
					cInfFlwDatMainTable.setProductMaterialCode1(value);
				}
				if (name.equals("PLANT")) {
					cInfFlwDatMainTable.setPlant(value);
				}
				if (name.equals("ROUTERCODE")) {
					cInfFlwDatMainTable.setRouteCode(value);
				}
				if (name.equals("GROUPCOUNT")) {
					cInfFlwDatMainTable.setGroupCount(value);
				}
				if (name.equals("USAGE")) {
					cInfFlwDatMainTable.setUsage(value);
				}
				if (name.equals("UNIT")) {
					cInfFlwDatMainTable.setUnit(value);
				}
				if (name.equals("DESCRIPTION")) {
					cInfFlwDatMainTable.setDescription(value);
				}
				if (name.equals("SEQUENCE")) {
					cInfFlwDatMainTable.setSequence(value);
				}
			}

			/**
			 * 明细
			 */
			Row[] rows = dt.getRow();
			JSONObject req = new JSONObject();
			JSONObject message = new JSONObject();
			JSONObject shell = new JSONObject();
			List<JSONObject> cInfFlwDatList = new ArrayList<JSONObject>();
			for (int i = 0; i < rows.length; i++) {
				Row row = rows[i];// 指定行
				Cell[] cells = row.getCell();// 每行数据再按列存储
				for (int j = 0; j < cells.length; j++) {
					Cell cell = cells[j];// 指定列
					name = cell.getName().toUpperCase();// 明细字段名
					if (Util.null2String(cell.getValue()).isEmpty()) {
						value = " ";
					} else {
						value = Util.null2String(cell.getValue());
					}
					if (name.equals("ITEMNO")) {
						cInfFlwDatDetailTable.setItemNo(value);
					}
					if (name.equals("OPER")) {
						cInfFlwDatDetailTable.setOPERADD(value);
					}
					if (name.equals("OPERDEC")) {
						cInfFlwDatDetailTable.setOPERDEC(value);
					}
					if (name.equals("WORK_CENTER_FK")) {
						cInfFlwDatDetailTable.setWorkCenterFk(value);
					}
					if (name.equals("UPH")) {
						cInfFlwDatDetailTable.setUPH(value);
					}
				}
				req.put("fromSystem", "OA");
				req.put("functionName", "MES_UPLOADMASTERDATA");
				req.put("token", "OATESTTOKEN");
				shell.put("infTime", infTime);
				if (cInfFlwDatMainTable.getProductMaterialCode1()
						.substring(0, 1).equals("A")) {
					shell.put("infSeq", String.valueOf(i + 1));
				} else if (cInfFlwDatMainTable.getProductMaterialCode1()
						.substring(0, 1).equals("T")) {
					shell.put("infSeq", String.valueOf(i + 1001));
				}
				shell.put("matnr",
						cInfFlwDatMainTable.getProductMaterialCode1());
				shell.put("werks", cInfFlwDatMainTable.getPlant());
				shell.put("plnnr", cInfFlwDatMainTable.getRouteCode());
				shell.put("plnal", cInfFlwDatMainTable.getGroupCount());
				shell.put("plnfl", cInfFlwDatMainTable.getSequence());
				shell.put("vornr", cInfFlwDatDetailTable.getItemNo());
				shell.put("arbpl", cInfFlwDatDetailTable.getWorkCenterFk());
				shell.put("steus", "PP01");
				shell.put("ktsch", cInfFlwDatDetailTable.getOPERADD());
				shell.put("ltxa1", cInfFlwDatDetailTable.getOPERDEC());
				shell.put("vgw01", "0");
				shell.put("vgw02", "60");
				shell.put("vgw03", "60");
				shell.put("vgw04", "60");
				shell.put("vgw05", "60");
				shell.put("vgw06", "60");
				shell.put("infnr", "&nbsp;");
				shell.put("ekorg", "&nbsp;");
				shell.put("sakto", "&nbsp;");
				shell.put("bmsch", cInfFlwDatDetailTable.getUPH());
				shell.put("uemus", "&nbsp;");
				shell.put("minwe", "&nbsp;");
				shell.put("spmus", "&nbsp;");
				shell.put("splim", "&nbsp;");
				shell.put("umrez", cInfFlwDatMainTable.getUsage());
				shell.put("meinh", cInfFlwDatMainTable.getUnit());
				shell.put("readFlag", "&nbsp;");
				shell.put("infMsg", "&nbsp;");
				shell.put("infFlag", "&nbsp;");
				shell.put("cmf1", cInfFlwDatMainTable.getDescription());
				shell.put("cmf2", "&nbsp;");
				shell.put("cmf3", "&nbsp;");
				shell.put("cmf4", "&nbsp;");
				shell.put("cmf5", "&nbsp;");
				shell.put("cmf6", "&nbsp;");
				shell.put("cmf7", "&nbsp;");
				shell.put("cmf8", "&nbsp;");
				shell.put("cmf9", "&nbsp;");
				shell.put("cmf10", "&nbsp;");
				shell.put("deleteFlag", "&nbsp;");
				shell.put("createTime", createTime);
				shell.put("createUserId", creator);
				shell.put("updateTime", updateTime);
				shell.put("updateUserId", creator);
				shell.put("deleteTime", "&nbsp;");
				shell.put("deleteUserId", "&nbsp;");
				cInfFlwDatList.add(shell);
				baseBean.writeLog(cInfFlwDatList);
				message.put("cInfFlwDatList", cInfFlwDatList);
				baseBean.writeLog("message" + message);
				req.put("message", message);
				baseBean.writeLog("req" + req);
				String retSrcs = HttpClientJson.readInterfacePost(url,
						req.toString());
				JSONObject results = new JSONObject(retSrcs);
				String statusValue = results.get("statusValue").toString();
				String msg = results.get("msg").toString();
				baseBean.writeLog("retSrcs--" + retSrcs);
				baseBean.writeLog("statusValue--" + statusValue);
				baseBean.writeLog("msg--" + msg);
			}
		} catch (JSONException e) {
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("CINFPATDATTest error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
	}

	/**
	 * @param dt
	 * @param rid
	 * @param maintableinfo
	 * @param creator
	 */
	public void setcinfbomdat(DetailTable dt, String rid,
			MainTableInfo maintableinfo, String creator) {
		BaseBean baseBean = new BaseBean();
		try {
			baseBean.writeLog("*****setcinfbomdat开始执行*****");
			/**
			 * 主表
			 */
			Property[] properties = maintableinfo.getProperty();// 获取表单主字段数据
			baseBean.writeLog("properties.length:" + properties.length);
			for (int i = 0; i < properties.length; i++) {// 主表数据
				name = properties[i].getName().toUpperCase();// 主表字段名
				if (!Util.null2String(properties[i].getValue()).isEmpty()) {
					value = " ";
				} else {
					value = Util.null2String(properties[i].getValue());// 值
				}
				if (name.equals("PRODUCTMATERIALCODE")) {
					cInfBomDatMainTable.setProductMaterialCode(value);
				}
				if (name.equals("PLANT")) {
					cInfBomDatMainTable.setPlant(value);
				}
				if (name.equals("ROUTERCODE")) {
					cInfBomDatMainTable.setRouteCode(value);
				}
				if (name.equals("GROUPCOUNT")) {
					cInfBomDatMainTable.setGroupCount(value);
				}
				if (name.equals("SEQUENCE")) {
					cInfBomDatMainTable.setSequence(value);
				}
				if (name.equals("USAGE")) {
					cInfBomDatMainTable.setUsage(value);
				}
			}

			/**
			 * 明细
			 */
			Row[] rows = dt.getRow();
			JSONObject req = new JSONObject();
			JSONObject message = new JSONObject();
			JSONObject shell = new JSONObject();
			List<JSONObject> cInfBomDatList = new ArrayList<JSONObject>();
			for (int i = 0; i < rows.length; i++) {
				Row row = rows[i];// 指定行
				Cell[] cells = row.getCell();// 每行数据再按列存储
				for (int j = 0; j < cells.length; j++) {
					Cell cell = cells[j];// 指定列
					name = cell.getName().toUpperCase();// 明细字段名
					if (Util.null2String(cell.getValue()).isEmpty()) {
						value = " ";
					} else {
						value = Util.null2String(cell.getValue());
					}
					if (name.equals("IDNRK")) {
						cInfBomDatDetailTable.setIDNRK(value);
					}
					if (name.equals("POSNR")) {
						cInfBomDatDetailTable.setPOSNR(value);
					}
					if (name.equals("OPERITEMNO")) {
						cInfBomDatDetailTable.setOPERItemNo(value);
					}
				}
				req.put("fromSystem", "OA");
				req.put("functionName", "MES_UPLOADMASTERDATA");
				req.put("token", "OATESTTOKEN");
				shell.put("infTime", infTime);
				if (cInfBomDatMainTable.getProductMaterialCode()
						.substring(0, 1).equals("A")) {
					shell.put("infSeq", String.valueOf(i + 1));
				} else if (cInfBomDatMainTable.getProductMaterialCode()
						.substring(0, 1).equals("T")) {
					shell.put("infSeq", String.valueOf(i + 1001));
				}
				shell.put("matnr", cInfBomDatMainTable.getProductMaterialCode());
				shell.put("werks", cInfBomDatMainTable.getPlant());
				shell.put("plnnr", cInfBomDatMainTable.getRouteCode());
				shell.put("plnal", cInfBomDatMainTable.getGroupCount());
				shell.put("plnfl", cInfBomDatMainTable.getSequence());
				shell.put("vornr", cInfBomDatDetailTable.getIDNRK());
				shell.put("idnrk", cInfBomDatDetailTable.getPOSNR());
				shell.put("posnr", cInfBomDatDetailTable.getOPERItemNo());
				shell.put("stlan", cInfBomDatMainTable.getUsage());
				shell.put("stlal", cInfBomDatMainTable.getGroupCount());
				shell.put("readFlag", "&nbsp;");
				shell.put("infMsg", "&nbsp;");
				shell.put("infFlag", "&nbsp;");
				shell.put("cmf1", "&nbsp;");
				shell.put("cmf2", "&nbsp;");
				shell.put("cmf3", "&nbsp;");
				shell.put("cmf4", "&nbsp;");
				shell.put("cmf5", "&nbsp;");
				shell.put("cmf6", "&nbsp;");
				shell.put("cmf7", "&nbsp;");
				shell.put("cmf8", "&nbsp;");
				shell.put("cmf9", "&nbsp;");
				shell.put("cmf10", "&nbsp;");
				shell.put("deleteFlag", "&nbsp;");
				shell.put("createTime", createTime);
				shell.put("createUserId", creator);
				shell.put("updateTime", updateTime);
				shell.put("updateUserId", creator);
				shell.put("deleteTime", "&nbsp;");
				shell.put("deleteUserId", "&nbsp;");
				cInfBomDatList.add(shell);
				baseBean.writeLog(cInfBomDatList);
				message.put("cInfBomDatList", cInfBomDatList);
				baseBean.writeLog("message" + message);
				req.put("message", message);
				baseBean.writeLog("req" + req);
				String retSrcs = HttpClientJson.readInterfacePost(url,
						req.toString());
				JSONObject results = new JSONObject(retSrcs);
				String statusValue = results.get("statusValue").toString();
				String msg = results.get("msg").toString();
				baseBean.writeLog("retSrcs--" + retSrcs);
				baseBean.writeLog("statusValue--" + statusValue);
				baseBean.writeLog("msg--" + msg);
			}
		} catch (JSONException e) {
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("CINFPATDATTest error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
	}
}
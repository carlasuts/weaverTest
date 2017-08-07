package weaver.interfaces.sap;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONObject;

import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class CINFSPEDATPOST {

	private SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static final String url = "http://172.16.60.96:8099/MesWebService/req";
	private BaseBean bb = new BaseBean();
	private String logtablename = "CINFSPEDAT";

	public void setcinfspedat(DetailTable dt, String rid,
			MainTableInfo maintableinfo) {
		try {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("CINFPATDATPOST,程序开始执行");
			baseBean.writeLog("**************************");
			baseBean.writeLog("CINFSPEDATPOST,第1步");
			List<Map<String, String>> loglist = new ArrayList<Map<String, String>>();
			baseBean.writeLog("CINFSPEDATPOST,第2步");
			Property[] Property = maintableinfo.getProperty();
			baseBean.writeLog("CINFSPEDATPOST,第3步");
			HttpPost postMethod = new HttpPost(url);
			// CloseableHttpClient client = HttpClients.createDefault();
			baseBean.writeLog("CINFSPEDATPOST,第4步");
			JSONObject req = new JSONObject();

			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPLOADMASTERDATA");
			req.put("token", "OATESTTOKEN");

			String ProductMaterialCode2 = "";
			String Customer = "";
			String AorTCustomerMtrlCode = "";
			String CustomerMtrlDescription = "";
			String PackageOutline = "";
			String WireBondDiagNo = "";
			String WireBondDiagVersion = "";
			String TopMarkFormatNo = "";
			String BackMarkFormatNo = "";
			String WBSpecNo = "";
			String LotSize = "";
			String LotUnit = "";
			String BusinessOperation = "";
			String TNRStdBoxQty = "";
			String TubeStdBoxQty = "";
			String ReelPackQty = "";
			String StdPackQty = "";
			String HalfPackQty = "";
			String TNRQty = "";
			String TubeQty = "";
			String Information1 = "";
			String Information2 = "";
			String Information3 = "";
			String Information4 = "";
			String Information5 = "";
			String Lable1 = "";
			String Lable2 = "";
			String Lable3 = "";
			String Lable4 = "";
			String Lable5 = "";
			String Lable6 = "";
			String Lable7 = "";
			String Lable8 = "";
			String Lable9 = "";
			String Lable10 = "";
			String Lable11 = "";
			String Lable12 = "";
			String Lable13 = "";
			String Lable14 = "";
			String Lable15 = "";
			String Lable16 = "";
			String Lable17 = "";
			String Lable18 = "";
			String Lable19 = "";
			String Lable20 = "";
			String Mark1 = "";
			String Mark2 = "";
			String Mark3 = "";
			String Mark4 = "";
			String Mark5 = "";
			String TraceDataType = "";
			String Instruction1 = "";
			String Instruction2AssyorTest = "";
			String Instruction3AssyorTest = "";
			String PrimaryAorTCardAssy = "";
			String MoistureSensitiveLabel = "";
			String BSMCode = "";
			String LotCode = "";
			String TSMCode = "";
			String OutDevice = "";
			String DieAttachTrait = "";
			String HygrosopicLevel = "";
			String Mark = "";
			String Plate = "";
			String ReelSize = "";
			String ReelDirection = "";
			String ReelQty = "";
			String TestTime = "";
			String IndexTime = "";

			String id;
			String re;

			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyyMMddHHmmss");
			String INF_TIME = sdf.format(date);
			for (int ss = 0; ss < Property.length; ++ss) {
				re = Property[ss].getName().toUpperCase();
				id = Util.null2String(Property[ss].getValue());
				if (re.equals("ProductMaterialCode2")) {
					ProductMaterialCode2 = id;
				}
				if (re.equals("Customer")) {
					Customer = id;
				}
				if (re.equals("AssyCustomerMtrlCode")) {
					AorTCustomerMtrlCode = id;
				}
				if (re.equals("TestCustomerMtrlCode")) {
					AorTCustomerMtrlCode = id;
				}
				if (re.equals("CustomerMtrlDescription")) {
					CustomerMtrlDescription = id;
				}
				if (re.equals("PackageOutline")) {
					PackageOutline = id;
				}
				if (re.equals("WireBondDiagNo")) {
					WireBondDiagNo = id;
				}
				if (re.equals("WireBondDiagVersion")) {
					WireBondDiagVersion = id;
				}
				if (re.equals("TopMarkFormatNo")) {
					TopMarkFormatNo = id;
				}
				if (re.equals("BackMarkFormatNo")) {
					BackMarkFormatNo = id;
				}
				if (re.equals("WBSpecNo")) {
					WBSpecNo = id;
				}
				if (re.equals("LotSize")) {
					LotSize = id;
				}
				if (re.equals("LotUnit")) {
					LotUnit = id;
				}
				if (re.equals("BusinessOperation")) {
					BusinessOperation = id;
				}
				if (re.equals("TNRStdBoxQty")) {
					TNRStdBoxQty = id;
				}
				if (re.equals("TubeStdBoxQty")) {
					TubeStdBoxQty = id;
				}
				if (re.equals("ReelPackQty")) {
					ReelPackQty = id;
				}
				if (re.equals("StdPackQty")) {
					StdPackQty = id;
				}
				if (re.equals("HalfPackQty")) {
					HalfPackQty = id;
				}
				if (re.equals("TNRQty")) {
					TNRQty = id;
				}
				if (re.equals("TubeQty")) {
					TubeQty = id;
				}
				if (re.equals("Information1")) {
					Information1 = id;
				}
				if (re.equals("Information2")) {
					Information2 = id;
				}
				if (re.equals("Information3")) {
					Information3 = id;
				}
				if (re.equals("Information4")) {
					Information4 = id;
				}
				if (re.equals("Information5")) {
					Information5 = id;
				}
				if (re.equals("Label1")) {
					Lable1 = id;
				}
				if (re.equals("Label2")) {
					Lable2 = id;
				}
				if (re.equals("Label3")) {
					Lable3 = id;
				}
				if (re.equals("Label4")) {
					Lable4 = id;
				}
				if (re.equals("Label5")) {
					Lable5 = id;
				}
				if (re.equals("Label6")) {
					Lable6 = id;
				}
				if (re.equals("Label7")) {
					Lable7 = id;
				}
				if (re.equals("Label8")) {
					Lable8 = id;
				}
				if (re.equals("Label9")) {
					Lable9 = id;
				}
				if (re.equals("Label10")) {
					Lable10 = id;
				}
				if (re.equals("Label11")) {
					Lable11 = id;
				}
				if (re.equals("Label12")) {
					Lable12 = id;
				}
				if (re.equals("Label13")) {
					Lable13 = id;
				}
				if (re.equals("Label14")) {
					Lable14 = id;
				}
				if (re.equals("Label15")) {
					Lable15 = id;
				}
				if (re.equals("Label16")) {
					Lable16 = id;
				}
				if (re.equals("Label17")) {
					Lable17 = id;
				}
				if (re.equals("Label18")) {
					Lable18 = id;
				}
				if (re.equals("Label19")) {
					Lable19 = id;
				}
				if (re.equals("Label20")) {
					Lable20 = id;
				}
				if (re.equals("Mark1")) {
					Mark1 = id;
				}
				if (re.equals("Mark2")) {
					Mark2 = id;
				}
				if (re.equals("Mark3")) {
					Mark3 = id;
				}
				if (re.equals("Mark4")) {
					Mark4 = id;
				}
				if (re.equals("Mark5")) {
					Mark5 = id;
				}
				if (re.equals("TraceDataType")) {
					TraceDataType = id;
				}
				if (re.equals("Instruction1")) {
					Instruction1 = id;
				}
				if (re.equals("Instruction2Assy")) {
					Instruction2AssyorTest = id;
				}
				if (re.equals("Instruction2Test")) {
					Instruction2AssyorTest = id;
				}
				if (re.equals("Instruction3Assy")) {
					Instruction3AssyorTest = id;
				}
				if (re.equals("Instruction3Test")) {
					Instruction3AssyorTest = id;
				}
				if (re.equals("PrimaryTcardTest")) {
					PrimaryAorTCardAssy = id;
				}
				if (re.equals("PrimaryTCardAssy")) {
					PrimaryAorTCardAssy = id;
				}
				if (re.equals("MoistureSensitiveLabel")) {
					MoistureSensitiveLabel = id;
				}
				if (re.equals("BSMCode")) {
					BSMCode = id;
				}
				if (re.equals("LotCode")) {
					LotCode = id;
				}
				if (re.equals("TSMCode")) {
					TSMCode = id;
				}
				if (re.equals("OutDevice")) {
					OutDevice = id;
				}
				if (re.equals("DieAttachTrait")) {
					DieAttachTrait = id;
				}
				if (re.equals("HygrosopicLevel")) {
					HygrosopicLevel = id;
				}
				if (re.equals("Mark")) {
					Mark = id;
				}
				if (re.equals("Plate")) {
					Plate = id;
				}
				if (re.equals("ReelSize")) {
					ReelSize = id;
				}
				if (re.equals("ReelDirection")) {
					ReelDirection = id;
				}
				if (re.equals("ReelQty")) {
					ReelQty = id;
				}
				if (re.equals("TestTime")) {
					TestTime = id;
				}
				if (re.equals("IndexTime")) {
					IndexTime = id;
				}
			}

			// 明细
			String DieMaterialCode = "";
			String DieMaterialDescription = "";
			String UpperThick = "";
			String SpecialLowwerThickU1 = "";
			String WaferSize = "";
			String ChipSizeX = "";
			String ChipSizeY = "";
			String ScribeWidth = "";
			String BPO = "";
			String BPP = "";
			String WaferIngredient = "";
			String ChipType = "";

			Row[] s = dt.getRow();
			JSONObject message = new JSONObject();
			for (int j = 0; j < s.length; j++) {
				Row r = s[j];// 指定行
				Cell c[] = r.getCell();// 每行数据再按列存储
				for (int k = 0; k < c.length; k++) {
					Cell c1 = c[k];// 指定列
					String name = c1.getName().toUpperCase();// 明细字段名称
					String value = Util.null2String(c1.getValue());// 明细字段的值
					if (name.equals("DieMaterialCode")) {
						DieMaterialCode = value;
					}
					if (name.equals("DieMaterialDescription")) {
						DieMaterialDescription = value;
					}
					if (name.equals("WireBondDiagNo")) {
						WireBondDiagNo = value;
					}
					if (name.equals("WireBondDiagVersion")) {
						WireBondDiagVersion = value;
					}
					if (name.equals("UpperThick")) {
						UpperThick = value;
					}
					if (name.equals("SpecialLowwerThickU1")) {
						SpecialLowwerThickU1 = value;
					}
					if (name.equals("SpecialLowwerThickU2")) {
						SpecialLowwerThickU1 = value;
					}
					if (name.equals("SpecialLowwerThickU3")) {
						SpecialLowwerThickU1 = value;
					}
					if (name.equals("WaferSize")) {
						WaferSize = value;
					}
					if (name.equals("ChipSizeX")) {
						ChipSizeX = value;
					}
					if (name.equals("ChipSizeY")) {
						ChipSizeY = value;
					}
					if (name.equals("ScribeWidth")) {
						ScribeWidth = value;
					}
					if (name.equals("BPO")) {
						BPO = value;
					}
					if (name.equals("BPP")) {
						BPP = value;
					}
					if (name.equals("WaferIngredient")) {
						WaferIngredient = value;
					}
					if (name.equals("ChipType")) {
						ChipType = value;
					}
				}
				Map<String, String> logmap = new HashMap<String, String>();
				JSONObject[] cInfSpeDatList = new JSONObject[s.length];
				cInfSpeDatList[j] = new JSONObject();
				cInfSpeDatList[j].put("InfTime", INF_TIME);
				cInfSpeDatList[j].put("InfSeq", String.valueOf(j + 1001));
				cInfSpeDatList[j].put("Factory", "DIEBANK");
				cInfSpeDatList[j].put("MatId", ProductMaterialCode2);
				cInfSpeDatList[j].put("CustId", Customer);
				cInfSpeDatList[j].put("CustMatId", AorTCustomerMtrlCode);// 客户品名
																			// 测试客户品名
				cInfSpeDatList[j].put("CustMatDesc", CustomerMtrlDescription);
				cInfSpeDatList[j].put("DbMatId", DieMaterialCode);
				cInfSpeDatList[j].put("PkgType", PackageOutline);
				cInfSpeDatList[j].put("PackCode", " ");
				cInfSpeDatList[j].put("PkldCode", PackageOutline);
				cInfSpeDatList[j].put("AddBondDiagramNo", WireBondDiagNo);
				cInfSpeDatList[j].put("AddBondDiagramRev", WireBondDiagVersion);
				cInfSpeDatList[j].put("FlowId", " ");
				cInfSpeDatList[j].put("OrgCustDeviceId", " ");
				cInfSpeDatList[j].put("TopMarkFormatId", TopMarkFormatNo);
				cInfSpeDatList[j].put("BackMarkFormatId", BackMarkFormatNo);
				cInfSpeDatList[j].put("RecipeGroup", WBSpecNo);
				cInfSpeDatList[j].put("StdLotSize", LotSize);
				cInfSpeDatList[j].put("MatUnit", LotUnit);
				cInfSpeDatList[j].put("BuOper", BusinessOperation);
				cInfSpeDatList[j].put("TnrStdOutboxQty", TNRStdBoxQty);
				cInfSpeDatList[j].put("TubeStdOutboxQty", TubeStdBoxQty);
				cInfSpeDatList[j].put("TubeRealPackQty", ReelPackQty);
				cInfSpeDatList[j].put("StdPackQty", StdPackQty);
				cInfSpeDatList[j].put("HalfPackQty", HalfPackQty);
				cInfSpeDatList[j].put("TnrQty", TNRQty);
				cInfSpeDatList[j].put("TubeQty", TubeQty);
				cInfSpeDatList[j].put("TrNeedFullInbox", TubeQty);
				cInfSpeDatList[j].put("Info1", Information1);
				cInfSpeDatList[j].put("Info2", Information2);
				cInfSpeDatList[j].put("Info3", Information3);
				cInfSpeDatList[j].put("Info4", Information4);
				cInfSpeDatList[j].put("Info5", Information5);// formtable_main_78
																// 没有这个栏位
				cInfSpeDatList[j].put("Lable1", Lable1);
				cInfSpeDatList[j].put("Lable2", Lable2);
				cInfSpeDatList[j].put("Lable3", Lable3);
				cInfSpeDatList[j].put("Lable4", Lable4);
				cInfSpeDatList[j].put("Lable5", Lable5);
				cInfSpeDatList[j].put("Lable6", Lable6);
				cInfSpeDatList[j].put("Lable7", Lable7);
				cInfSpeDatList[j].put("Lable8", Lable8);
				cInfSpeDatList[j].put("Lable9", Lable9);
				cInfSpeDatList[j].put("Lable10", Lable10);
				cInfSpeDatList[j].put("Lable11", Lable11);
				cInfSpeDatList[j].put("Lable12", Lable12);
				cInfSpeDatList[j].put("Lable13", Lable13);
				cInfSpeDatList[j].put("Lable14", Lable14);
				cInfSpeDatList[j].put("Lable15", Lable15);
				cInfSpeDatList[j].put("Lable16", Lable16);
				cInfSpeDatList[j].put("Lable17", Lable17);
				cInfSpeDatList[j].put("Lable18", Lable18);
				cInfSpeDatList[j].put("Lable19", Lable19);
				cInfSpeDatList[j].put("Lable20", Lable20);// formtable_main_78
															// 没有这个栏位
				cInfSpeDatList[j].put("Mark1", Mark1);
				cInfSpeDatList[j].put("Mark2", Mark2);
				cInfSpeDatList[j].put("Mark3", Mark3);
				cInfSpeDatList[j].put("Mark4", Mark4);
				cInfSpeDatList[j].put("Mark5", Mark5);
				cInfSpeDatList[j].put("TrDataType", TraceDataType);
				cInfSpeDatList[j].put("Instruction1", Instruction1);
				cInfSpeDatList[j].put("Instruction2", Instruction2AssyorTest);
				cInfSpeDatList[j].put("Instruction3", Instruction3AssyorTest);
				cInfSpeDatList[j].put("UpperWfThick", UpperThick);
				cInfSpeDatList[j].put("LowerWfThick", SpecialLowwerThickU1);
				cInfSpeDatList[j].put("WfSize", WaferSize);
				cInfSpeDatList[j].put("PrimaryTcard", PrimaryAorTCardAssy);//
				cInfSpeDatList[j].put("Msllabel", MoistureSensitiveLabel);
				cInfSpeDatList[j].put("BsmCode", BSMCode);
				cInfSpeDatList[j].put("LotCode", LotCode);
				cInfSpeDatList[j].put("TsmCode", TSMCode);
				cInfSpeDatList[j].put("OutDevice", OutDevice);
				cInfSpeDatList[j].put("MarkngSpecVersion", " ");
				cInfSpeDatList[j].put("ChipSizeX", ChipSizeX);
				cInfSpeDatList[j].put("ChipSizeY", ChipSizeY);
				cInfSpeDatList[j].put("ScribeWidth", ScribeWidth);
				cInfSpeDatList[j].put("Bpo", BPO);
				cInfSpeDatList[j].put("Bpp", BPP);
				cInfSpeDatList[j].put("CardProcFg", " ");
				cInfSpeDatList[j].put("PbFreeFg", " ");
				cInfSpeDatList[j].put("DieDown", " ");
				cInfSpeDatList[j].put("BomNo", " ");
				cInfSpeDatList[j].put("GrpDevice", " ");
				cInfSpeDatList[j].put("ProdClass", " ");
				cInfSpeDatList[j].put("SubLotSize", " ");
				cInfSpeDatList[j].put("MaxAsyLotCnt", " ");
				cInfSpeDatList[j].put("WfIngredients", WaferIngredient);
				cInfSpeDatList[j].put("ChipType", ChipType);
				cInfSpeDatList[j].put("DaMode", DieAttachTrait);
				cInfSpeDatList[j].put("DieCoating", " ");
				cInfSpeDatList[j].put("HygrosLevel", HygrosopicLevel);
				cInfSpeDatList[j].put("CoatingType", " ");
				cInfSpeDatList[j].put("CarProd", " ");
				cInfSpeDatList[j].put("Mark", Mark);
				cInfSpeDatList[j].put("Plate", Plate);
				cInfSpeDatList[j].put("ReelSize", ReelSize);
				cInfSpeDatList[j].put("ReelDiraction", ReelDirection);
				cInfSpeDatList[j].put("RellQty", ReelQty);
				cInfSpeDatList[j].put("HalogenFProd", " ");
				cInfSpeDatList[j].put("StripProd", " ");
				cInfSpeDatList[j].put("PadType", " ");
				cInfSpeDatList[j].put("TestFlwChart", " ");
				cInfSpeDatList[j].put("TestPlatfom", " ");
				cInfSpeDatList[j].put("TestSystem", " ");
				cInfSpeDatList[j].put("TestHandler", " ");
				cInfSpeDatList[j].put("TestPrgRev1", " ");
				cInfSpeDatList[j].put("QaPrg1", " ");
				cInfSpeDatList[j].put("QaPrg2", " ");
				cInfSpeDatList[j].put("TestTempe", " ");
				cInfSpeDatList[j].put("DieRunCodeFg", " ");
				cInfSpeDatList[j].put("AssyTestFg", " ");
				cInfSpeDatList[j].put("StdCycleTime", " ");
				cInfSpeDatList[j].put("ProcStatus", " ");
				cInfSpeDatList[j].put("SeqNo", " ");
				cInfSpeDatList[j].put("BgReqFlag", " ");
				cInfSpeDatList[j].put("WfMapReqFg", " ");
				cInfSpeDatList[j].put("LastTestDate", " ");
				cInfSpeDatList[j].put("WfDevice", " ");
				cInfSpeDatList[j].put("EngCode", " ");
				cInfSpeDatList[j].put("SecondTcardFactory", " ");
				cInfSpeDatList[j].put("PriTcardFactory", " ");
				cInfSpeDatList[j].put("MarkSpecNo", " ");
				cInfSpeDatList[j].put("PackingMethod", " ");
				cInfSpeDatList[j].put("ProdDesc", " ");
				cInfSpeDatList[j].put("NumberFullLabel", " ");
				cInfSpeDatList[j].put("NumberInnerLabel", " ");
				cInfSpeDatList[j].put("TraceFormat", " ");
				cInfSpeDatList[j].put("BurninFg", " ");
				cInfSpeDatList[j].put("CardPhaseType", " ");
				cInfSpeDatList[j].put("SecondTcard", " ");
				cInfSpeDatList[j].put("MarkType", " ");
				cInfSpeDatList[j].put("MoldType", " ");
				cInfSpeDatList[j].put("PlattingType", " ");
				cInfSpeDatList[j].put("WireQty", " ");
				cInfSpeDatList[j].put("TubeRemark", " ");
				cInfSpeDatList[j].put("PackingType", " ");
				cInfSpeDatList[j].put("BpcInst", " ");
				cInfSpeDatList[j].put("FlowName", " ");
				cInfSpeDatList[j].put("LimitTime", " ");
				cInfSpeDatList[j].put("BdSbName", " ");
				cInfSpeDatList[j].put("WbDevice", " ");
				cInfSpeDatList[j].put("MarkDevice", " ");
				cInfSpeDatList[j].put("BodySize", " ");
				cInfSpeDatList[j].put("LeadCount", " ");
				cInfSpeDatList[j].put("FluxPrintStencil", " ");
				cInfSpeDatList[j].put("BallMountStancil", " ");
				cInfSpeDatList[j].put("PostReticle", " ");
				cInfSpeDatList[j].put("ProdPreFix", " ");
				cInfSpeDatList[j].put("ResinThickness", " ");
				cInfSpeDatList[j].put("WaferThickness", " ");
				cInfSpeDatList[j].put("BallType", " ");
				cInfSpeDatList[j].put("BallSize", " ");
				cInfSpeDatList[j].put("BallPlacement", " ");
				cInfSpeDatList[j].put("PiReticle", " ");
				cInfSpeDatList[j].put("RdlReticle", " ");
				cInfSpeDatList[j].put("UbmReticle", " ");
				cInfSpeDatList[j].put("Resin", " ");
				cInfSpeDatList[j].put("Cmf1", TestTime);
				cInfSpeDatList[j].put("Cmf2", " ");
				cInfSpeDatList[j].put("Cmf3", " ");
				cInfSpeDatList[j].put("Cmf4", " ");
				cInfSpeDatList[j].put("Cmf5", " ");
				cInfSpeDatList[j].put("ReadFlag", " ");
				cInfSpeDatList[j].put("InfMsg", " ");
				cInfSpeDatList[j].put("InfFlag", " ");
				cInfSpeDatList[j].put("BumpReticle", " ");
				cInfSpeDatList[j].put("Cmf6", IndexTime);
				cInfSpeDatList[j].put("Cmf7", " ");
				cInfSpeDatList[j].put("Cmf8", " ");
				cInfSpeDatList[j].put("Cmf9", " ");
				cInfSpeDatList[j].put("Cmf4", " ");
				cInfSpeDatList[j].put("Cmf10", " ");
				cInfSpeDatList[j].put("Cmf11", " ");
				cInfSpeDatList[j].put("Cmf12", " ");
				cInfSpeDatList[j].put("Cmf13", " ");
				cInfSpeDatList[j].put("Cmf14", " ");
				cInfSpeDatList[j].put("Cmf15", " ");
				cInfSpeDatList[j].put("Cmf16", " ");
				cInfSpeDatList[j].put("Cmf17", " ");
				cInfSpeDatList[j].put("Cmf18", " ");
				cInfSpeDatList[j].put("Cmf19", " ");
				cInfSpeDatList[j].put("Cmf20", " ");
				cInfSpeDatList[j].put("Cmf21", " ");
				cInfSpeDatList[j].put("Cmf22", " ");
				cInfSpeDatList[j].put("Cmf23", " ");
				cInfSpeDatList[j].put("Cmf24", " ");
				cInfSpeDatList[j].put("Cmf25", " ");
				cInfSpeDatList[j].put("Cmf26", " ");
				cInfSpeDatList[j].put("Cmf27", " ");
				cInfSpeDatList[j].put("Cmf28", " ");
				cInfSpeDatList[j].put("Cmf29", " ");
				cInfSpeDatList[j].put("Cmf30", " ");
				cInfSpeDatList[j].put("PiReticle2", " ");
				cInfSpeDatList[j].put("UbmReticle2", " ");
				cInfSpeDatList[j].put("ResvField1", " ");
				cInfSpeDatList[j].put("ResvField2", " ");
				cInfSpeDatList[j].put("ResvField3", " ");
				cInfSpeDatList[j].put("ResvField4", " ");
				cInfSpeDatList[j].put("ResvField5", " ");
				cInfSpeDatList[j].put("ResvField6", " ");
				cInfSpeDatList[j].put("ResvField7", " ");
				cInfSpeDatList[j].put("ResvField8", " ");
				cInfSpeDatList[j].put("ResvField9", " ");
				cInfSpeDatList[j].put("ResvField10", " ");
				cInfSpeDatList[j].put("Label21", " ");
				cInfSpeDatList[j].put("Label22", " ");
				cInfSpeDatList[j].put("Label23", " ");
				cInfSpeDatList[j].put("Label24", " ");
				cInfSpeDatList[j].put("Label25", " ");
				cInfSpeDatList[j].put("Label26", " ");
				cInfSpeDatList[j].put("Label27", " ");
				cInfSpeDatList[j].put("Label28", " ");
				cInfSpeDatList[j].put("Label29", " ");
				cInfSpeDatList[j].put("Label30", " ");

				message.put("cInfSpeDatList", cInfSpeDatList);
			}
			req.put("message", message);
			StringEntity SS = new StringEntity(req.toString());
			postMethod.setEntity(SS);
			HttpResponse resps = new DefaultHttpClient().execute(postMethod);
		} catch (java.lang.Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void writelog(List<Map<String, String>> loglist) {
		SapLogWriter.writerlog(loglist, logtablename);

	}

}

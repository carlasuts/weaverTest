package weaver.interfaces.workflow.action;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.JSONException;
import org.json.JSONObject;

import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.sap.HttpClientJson;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class POST {

	private static final String url = "http://172.16.60.96:8099/MesWebService/req";
	BaseBean baseBean = new BaseBean();

	public String setPost(DetailTable dt, String requestId,
			MainTableInfo mainTableInfo, String creator) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat();
		String CREATE_TIME = sdf.format(date);
		String UPDATE_TIME = sdf.format(date);
		String INF_TIME = sdf.format(date);
		String value = "";// 字段值

		/**
		 * 主表
		 */
		Property[] properties = mainTableInfo.getProperty();// 获取表单主字段数据
		for (int i = 0; i < properties.length; i++) {// 主表数据
			String name = properties[i].getName().toUpperCase();// 主表字段名
			if (!Util.null2String(properties[i].getValue()).isEmpty()) {
				value = Util.null2String(properties[i].getValue());// 值
			}
			if (name.equals("PRODUCTMATERIALCODE")) {
				String ProductMaterialCode = value;
			}
			if (name.equals("PLANT")) {
				String Plant = value;
			}
			if (name.equals("USAGE")) {
				String Usage = value;
			}
			if (name.equals("ALTERNATIVEBOM")) {
				String AlternativeBom = value;
			}
			if (name.equals("PRODUCTMATERIALCODE1")) {
				String PRODUCTMATERIALCODE1 = value;
			}
			if (name.equals("ROUTERCODE")) {
				String ROUTERCODE = value;
			}
			if (name.equals("GROUPCOUNT")) {
				String GROUPCOUNT = value;
			}
			if (name.equals("UNIT")) {
				String UNIT = value;
			}
			if (name.equals("DESCRIPTION")) {
				String DESCRIPTION = value;
			}
			if (name.equals("SEQUENCE")) {
				String SEQUENCE = value;
			}
			if (name.equals("ProductMaterialCode2")) {
				String ProductMaterialCode2 = value;
			}
			if (name.equals("Customer")) {
				String Customer = value;
			}
			if (name.equals("AssyCustomerMtrlCode")) {
				String AorTCustomerMtrlCode = value;
			}
			if (name.equals("TestCustomerMtrlCode")) {
				String AorTCustomerMtrlCode = value;
			}
			if (name.equals("CustomerMtrlDescription")) {
				String CustomerMtrlDescription = value;
			}
			if (name.equals("PackageOutline")) {
				String PackageOutline = value;
			}
			if (name.equals("WireBondDiagNo")) {
				String WireBondDiagNo = value;
			}
			if (name.equals("WireBondDiagVersion")) {
				String WireBondDiagVersion = value;
			}
			if (name.equals("TopMarkFormatNo")) {
				String TopMarkFormatNo = value;
			}
			if (name.equals("BackMarkFormatNo")) {
				String BackMarkFormatNo = value;
			}
			if (name.equals("WBSpecNo")) {
				String WBSpecNo = value;
			}
			if (name.equals("LotSize")) {
				String LotSize = value;
			}
			if (name.equals("LotUnit")) {
				String LotUnit = value;
			}
			if (name.equals("BusinessOperation")) {
				String BusinessOperation = value;
			}
			if (name.equals("TNRStdBoxQty")) {
				String TNRStdBoxQty = value;
			}
			if (name.equals("TubeStdBoxQty")) {
				String TubeStdBoxQty = value;
			}
			if (name.equals("ReelPackQty")) {
				String ReelPackQty = value;
			}
			if (name.equals("StdPackQty")) {
				String StdPackQty = value;
			}
			if (name.equals("HalfPackQty")) {
				String HalfPackQty = value;
			}
			if (name.equals("TNRQty")) {
				String TNRQty = value;
			}
			if (name.equals("TubeQty")) {
				String TubeQty = value;
			}
			if (name.equals("Information1")) {
				String Information1 = value;
			}
			if (name.equals("Information2")) {
				String Information2 = value;
			}
			if (name.equals("Information3")) {
				String Information3 = value;
			}
			if (name.equals("Information4")) {
				String Information4 = value;
			}
			if (name.equals("Information5")) {
				String Information5 = value;
			}
			if (name.equals("Label1")) {
				String Lable1 = value;
			}
			if (name.equals("Label2")) {
				String Lable2 = value;
			}
			if (name.equals("Label3")) {
				String Lable3 = value;
			}
			if (name.equals("Label4")) {
				String Lable4 = value;
			}
			if (name.equals("Label5")) {
				String Lable5 = value;
			}
			if (name.equals("Label6")) {
				String Lable6 = value;
			}
			if (name.equals("Label7")) {
				String Lable7 = value;
			}
			if (name.equals("Label8")) {
				String Lable8 = value;
			}
			if (name.equals("Label9")) {
				String Lable9 = value;
			}
			if (name.equals("Label10")) {
				String Lable10 = value;
			}
			if (name.equals("Label11")) {
				String Lable11 = value;
			}
			if (name.equals("Label12")) {
				String Lable12 = value;
			}
			if (name.equals("Label13")) {
				String Lable13 = value;
			}
			if (name.equals("Label14")) {
				String Lable14 = value;
			}
			if (name.equals("Label15")) {
				String Lable15 = value;
			}
			if (name.equals("Label16")) {
				String Lable16 = value;
			}
			if (name.equals("Label17")) {
				String Lable17 = value;
			}
			if (name.equals("Label18")) {
				String Lable18 = value;
			}
			if (name.equals("Label19")) {
				String Lable19 = value;
			}
			if (name.equals("Label20")) {
				String Lable20 = value;
			}
			if (name.equals("Mark1")) {
				String Mark1 = value;
			}
			if (name.equals("Mark2")) {
				String Mark2 = value;
			}
			if (name.equals("Mark3")) {
				String Mark3 = value;
			}
			if (name.equals("Mark4")) {
				String Mark4 = value;
			}
			if (name.equals("Mark5")) {
				String Mark5 = value;
			}
			if (name.equals("TraceDataType")) {
				String TraceDataType = value;
			}
			if (name.equals("Instruction1")) {
				String Instruction1 = value;
			}
			if (name.equals("Instruction2Assy")) {
				String Instruction2AssyorTest = value;
			}
			if (name.equals("Instruction2Test")) {
				String Instruction2AssyorTest = value;
			}
			if (name.equals("Instruction3Assy")) {
				String Instruction3AssyorTest = value;
			}
			if (name.equals("Instruction3Test")) {
				String Instruction3AssyorTest = value;
			}
			if (name.equals("PrimaryTcardTest")) {
				String PrimaryAorTCardAssy = value;
			}
			if (name.equals("PrimaryTCardAssy")) {
				String PrimaryAorTCardAssy = value;
			}
			if (name.equals("MoistureSensitiveLabel")) {
				String MoistureSensitiveLabel = value;
			}
			if (name.equals("BSMCode")) {
				String BSMCode = value;
			}
			if (name.equals("LotCode")) {
				String LotCode = value;
			}
			if (name.equals("TSMCode")) {
				String TSMCode = value;
			}
			if (name.equals("OutDevice")) {
				String OutDevice = value;
			}
			if (name.equals("DieAttachTrait")) {
				String DieAttachTrait = value;
			}
			if (name.equals("HygrosopicLevel")) {
				String HygrosopicLevel = value;
			}
			if (name.equals("Mark")) {
				String Mark = value;
			}
			if (name.equals("Plate")) {
				String Plate = value;
			}
			if (name.equals("ReelSize")) {
				String ReelSize = value;
			}
			if (name.equals("ReelDirection")) {
				String ReelDirection = value;
			}
			if (name.equals("ReelQty")) {
				String ReelQty = value;
			}
			if (name.equals("TestTime")) {
				String TestTime = value;
			}
			if (name.equals("IndexTime")) {
				String IndexTime = value;
			}
		}

		/**
		 * 明细
		 */
		String POSNR = "";
		String IDNRK = "";
		String MENGE = "";
		String MEINS = "";
		String SILKQTY = "";
		String ALPGR = "";
		String ALPRF = "";
		String ALPST = "";
		String LGORT = "";
		String SANKA = "";
		String ProductMaterialCode = "";
		String Plant = "";
		String Usage = "";
		String AlternativeBom = "";
		String ITEMNO = "";
		String OPERADD = "";
		String OPERDEC = "";
		String WORKCENTER = "";
		String UPH = "";
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
		String OPERITEMNO = "";
		String WireBondDiagNo = "";
		String WireBondDiagVersion = "";

		Row[] rows = dt.getRow();
		JSONObject req = new JSONObject();
		JSONObject[] cInfPatDatList = new JSONObject[rows.length];
		JSONObject[] cInfFlwDatList = new JSONObject[rows.length];

		for (int i = 0; i < rows.length; i++) {
			Row row = rows[i];// 指定行
			Cell cells[] = row.getCell();// 每行数据再按列存储
			for (int j = 0; j < cells.length; j++) {
				Cell cell = cells[j];// 指定列
				String name = cell.getName().toUpperCase();// 明细字段名
				if (!Util.null2String(cell.getValue()).isEmpty()) {
					value = Util.null2String(cell.getValue());
				}
				if (name.equals("POSNR")) {
					POSNR = value;
				}
				if (name.equals("IDNRK")) {
					IDNRK = value;
				}
				if (name.equals("MENGE")) {
					MENGE = value;
				}
				if (name.equals("MEINS")) {
					MEINS = value;
				}
				if (name.equals("SILKQTY")) {
					SILKQTY = value;
				}
				if (name.equals("ALPGR")) {
					ALPGR = value;
				}
				if (name.equals("ALPRF")) {
					ALPRF = value;
				}
				if (name.equals("ALPST")) {
					ALPST = value;
				}
				if (name.equals("LGORT")) {
					LGORT = value;
				}
				if (name.equals("SANKA")) {
					SANKA = value;
				}
				if (name.equals("ITEMNO")) {
					ITEMNO = value;
				}
				if (name.equals("OPER")) {
					OPERADD = value;
				}
				if (name.equals("OPERDEC")) {
					OPERDEC = value;
				}
				if (name.equals("WORKCENTER")) {
					WORKCENTER = value;
				}
				if (name.equals("UPH")) {
					UPH = value;
				}
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
			int lenth = 0;
			try {
				req.put("fromSystem", "OA");
				req.put("functionName", "MES_UPLOADMASTERDATA");
				req.put("token", "OATESTTOKEN");
				JSONObject message = new JSONObject();
				cInfPatDatList[i] = new JSONObject();
				cInfPatDatList[i].put("infTime", INF_TIME);
				cInfPatDatList[i].put("infSeq", String.valueOf(i + 1));
				cInfPatDatList[i].put("matnr", ProductMaterialCode);
				cInfPatDatList[i].put("werks", Plant);
				cInfPatDatList[i].put("stlan", Usage);
				cInfPatDatList[i].put("stlal", AlternativeBom);
				cInfPatDatList[i].put("plnnr", " ");
				cInfPatDatList[i].put("posnr", POSNR);
				cInfPatDatList[i].put("idnrk", IDNRK);
				cInfPatDatList[i].put("menge", MENGE);
				cInfPatDatList[i].put("meins", MEINS);
				cInfPatDatList[i].put("ausch", SILKQTY);
				cInfPatDatList[i].put("alpgr", ALPGR);
				cInfPatDatList[i].put("alprf", ALPRF);
				cInfPatDatList[i].put("alpst", ALPST);
				cInfPatDatList[i].put("ewahr", " ");
				cInfPatDatList[i].put("itsob", " ");
				cInfPatDatList[i].put("lgort", LGORT);
				cInfPatDatList[i].put("sanka", SANKA);
				cInfPatDatList[i].put("readFlag", " ");
				cInfPatDatList[i].put("infMsg", " ");
				cInfPatDatList[i].put("infFlag", " ");
				cInfPatDatList[i].put("cmf1", " ");
				cInfPatDatList[i].put("cmf2", " ");
				cInfPatDatList[i].put("cmf3", " ");
				cInfPatDatList[i].put("cmf4", " ");
				cInfPatDatList[i].put("cmf5", " ");
				cInfPatDatList[i].put("cmf6", " ");
				cInfPatDatList[i].put("cmf7", " ");
				cInfPatDatList[i].put("cmf8", " ");
				cInfPatDatList[i].put("cmf9", " ");
				cInfPatDatList[i].put("cmf10", " ");
				cInfPatDatList[i].put("deleteFlag", " ");
				cInfPatDatList[i].put("createTime", CREATE_TIME);
				cInfPatDatList[i].put("createUserId", creator);
				cInfPatDatList[i].put("updateTime", UPDATE_TIME);
				cInfPatDatList[i].put("updateUserId", creator);
				cInfPatDatList[i].put("deleteTime", " ");
				cInfPatDatList[i].put("deleteUserId", " ");
			
				message.put("cInfPatDatList", cInfPatDatList);

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
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		return Action.SUCCESS;

	}

}

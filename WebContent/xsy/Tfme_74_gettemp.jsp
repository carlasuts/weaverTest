<%@ page contentType="text/html; charset=UTF-8"%>

<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="weaver.conn.RecordSet"%>
<%@page import="weaver.cpt.capital.CapitalComInfo"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.general.Util"%>
<%@page import="weaver.interfaces.workflow.pojo.TFME_74_Temp"%>
<%@page import="weaver.interfaces.workflow.util.RPTConn"%>
<%@page import="weaver.interfaces.workflow.util.OATestConn"%>
<%!
	static Connection rptConn = null;
	static Connection oaTestConn = null;
%>
	
<%
	if (Util.null2String(request.getParameter("msg")).equals("hello")) {
		BaseBean bs = new BaseBean();
		bs.writeLog("74_Begin to write into temptable");
		List<TFME_74_Temp> listTemp = new ArrayList<TFME_74_Temp>();
		try {
			//先清理原数据
			bs.writeLog("74_Clean temp table");
			RecordSet rsDelete = new RecordSet();
			rsDelete.execute("DELETE FROM EXTRATABLE_74_TEMPRECODER");
			
			// 初始化连接
			rptConn = RPTConn.getConn();
			PreparedStatement psBaseData = null;
			ResultSet rsBaseData = null;
			String sqlBaseData = "SELECT STS.LOT_ID, STS.OPER, STS.MAT_ID, (SELECT MAT.MAT_GRP_5 FROM MWIPMATDEF MAT WHERE MAT.MAT_ID = STS.MAT_ID AND MAT.FACTORY = 'TEST') AS MAT_GRP_5, ELT.CUST_LOT_ID, ELT.CUST_DATA_1, ELT.CUST_DATA_2, STS.HOLD_CODE, STS.HOLD_FLAG, NVL ( (SELECT 'Y' FROM ETRNLOTNTY WHERE LOT_NO = ELT.CUST_LOT_ID AND ROWNUM = 1), 'N') AS NTY_RCV_FLAG, NVL ( (SELECT 'Y' FROM MTAPLBLHIS WHERE LOT_ID = STS.LOT_ID AND ROWNUM = 1), 'N') AS PRINT_FLAG, SYSDATE, SYS_GUID()||'' AS ID FROM MWIPLOTSTS STS, MWIPELTSTS ELT WHERE STS.LOT_ID = ELT.LOT_ID AND STS.LOT_CMF_2 = '656' AND STS.LOT_DEL_FLAG = ' ' AND STS.FACTORY = 'TEST' AND STS.QTY_3 > 0 AND STS.OPER <> 'N21' UNION ALL SELECT ELT.LOT_ID, STS.OPER, STS.MAT_ID, (SELECT MAT.MAT_GRP_5 FROM MWIPMATDEF MAT WHERE MAT.MAT_ID = STS.MAT_ID AND MAT.FACTORY = 'TEST') AS MAT_GRP_5, ELT.CUST_LOT_ID, ELT.CUST_DATA_1, ELT.CUST_DATA_2, STS.HOLD_CODE, STS.HOLD_FLAG, NVL ( (SELECT 'Y' FROM ETRNLOTNTY WHERE LOT_NO = ELT.CUST_LOT_ID AND ROWNUM = 1), 'N') AS NTY_RCV_FLAG, NVL ( (SELECT 'Y' FROM MTAPLBLHIS WHERE LOT_ID = STS.LOT_ID AND ROWNUM = 1), 'N') AS PRINT_FLAG, SYSDATE, SYS_GUID()||'' AS ID FROM MWIPLOTSTS STS, MWIPELTSTS ELT, MWIPLOTMRG MRG WHERE STS.LOT_ID = MRG.LOT_ID AND MRG.FROM_TO_LOT_ID = ELT.LOT_ID AND STS.LOT_CMF_2 = '656' AND STS.LOT_DEL_FLAG = ' ' AND STS.FACTORY = 'TEST' AND STS.OPER <> 'N21' AND STS.QTY_3 > 0 AND MRG.FROM_TO_FLAG = 'T' AND MRG.HIST_DEL_FLAG = ' ' AND MRG.OPER <> '6000'";

			try {
				psBaseData = rptConn.prepareStatement(sqlBaseData);
				rsBaseData = psBaseData.executeQuery();
				int i = 0;
				int j = 0;
				while (rsBaseData.next()) {

					String custLotId = rsBaseData
							.getString("CUST_LOT_ID");
					String custLotIdInRecord = custLotId;
					String lotId = rsBaseData.getString("LOT_ID");
					String oper = rsBaseData.getString("OPER");
					String matId = rsBaseData.getString("MAT_ID");
					String matGrp5InRecord = rsBaseData
							.getString("MAT_GRP_5");
					String holdFlag = rsBaseData.getString("HOLD_FLAG");
					String holdCode = rsBaseData.getString("HOLD_CODE");
					String ntyRcvFlag = rsBaseData
							.getString("NTY_RCV_FLAG");
					String printFlag = rsBaseData
							.getString("PRINT_FLAG");
					String sysdate = rsBaseData.getString("SYSDATE");
					String id = rsBaseData.getString("ID");

					if ("Y".equals(holdFlag)
							&& "AUTOHOLD".equals(holdCode)
							&& "N".equals(ntyRcvFlag)
							|| ("Y".equals(printFlag))) {
						custLotIdInRecord = setCustLotId(custLotIdInRecord);
					}

					//将信息存入listTemp中
					TFME_74_Temp temp = new TFME_74_Temp();
					temp.setCustLotId(custLotId);
					temp.setCustLotIdInRecord(custLotIdInRecord);
					temp.setLotId(lotId);
					temp.setOper(oper);
					temp.setMatId(matId);
					temp.setMatGrp5InRecord(matGrp5InRecord);
					temp.setSysdate(sysdate);
					temp.setId(id);
					
					listTemp.add(temp);
					i++;
				}

				bs.writeLog("当前一共" + i + "条记录");

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				// 关闭记录集
				if (rsBaseData != null) {
					try {
						rsBaseData.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				// 关闭声明
				if (psBaseData != null) {
					try {
						psBaseData.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				// 关闭链接对象
				if (rptConn != null) {
					try {
						rptConn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
			bs.writeLog("Get Data Ok");

			//输出CSV
			SimpleDateFormat sdfOfFull = new SimpleDateFormat("yyyyMMddHHmmss");
			Calendar cal = Calendar.getInstance();
			Date date = cal.getTime();
			String dateOfFullString = sdfOfFull.format(date);
			File f = new File("D:/localtestfolder/WriteToFile-"
					+ dateOfFullString + ".csv");
			FileOutputStream fos = new FileOutputStream(f);
			StringBuffer sbFile = new StringBuffer();
			sbFile.append("CUST_LOT_ID,").append(
					"CUST_LOT_ID_INRECORD,");
			sbFile.append("LOT_ID").append("OPER,");
			sbFile.append("MAT_ID,").append("MAT_GRP_5_INRECORD");
			sbFile.append("INSERTTIME").append("ID").append("\r\n");
			for (TFME_74_Temp tfme_74_Temp : listTemp) {
				sbFile.append(tfme_74_Temp.getCustLotId()).append(",");
				sbFile.append(tfme_74_Temp.getCustLotIdInRecord())
						.append(",");
				sbFile.append(tfme_74_Temp.getLotId()).append(",");
				sbFile.append(tfme_74_Temp.getOper()).append(",");
				sbFile.append(tfme_74_Temp.getMatId()).append(",");
				sbFile.append(tfme_74_Temp.getMatGrp5InRecord())
						.append(",");
				sbFile.append(tfme_74_Temp.getSysdate()).append(",");
				sbFile.append(tfme_74_Temp.getId()).append("\r\n");
			}
			//输出所找到的所有
			fos.write(sbFile.toString().getBytes("UTF-8"));
			fos.flush();
			fos.close();
			bs.writeLog("CSV write Ok");

			//存入tempTable
			List<String> sqlList = new ArrayList<String>();
			String sqlInsertData = "INSERT INTO EXTRATABLE_74_TEMPRECODER TEMPRE (TEMPRE.ID, TEMPRE.CUST_LOT_ID, TEMPRE.CUST_LOT_ID_INRECORD, TEMPRE.LOT_ID, TEMPRE.OPER, TEMPRE.MAT_ID, TEMPRE.MAT_GRP_5_INRECORD, TEMPRE.INSERTTIME) VALUES (";
			for (TFME_74_Temp temp : listTemp) {
				StringBuffer sb = new StringBuffer();
				sb.append(sqlInsertData);
				sb.append("'").append(temp.getId()).append("', ");
				sb.append("'").append(temp.getCustLotId()).append("', ");
				sb.append("'").append(temp.getCustLotIdInRecord()).append("', ");
				sb.append("'").append(temp.getLotId()).append("', ");
				sb.append("'").append(temp.getOper()).append("', ");
				sb.append("'").append(temp.getMatId()).append("', ");
				sb.append("'").append(temp.getMatGrp5InRecord()).append("', ");
				sb.append("'").append(temp.getSysdate()).append("'");
				sb.append(")");
				sqlList.add(sb.toString());
			}
			
			RecordSet rsInsert = new RecordSet();
			bs.writeLog("开始插入TEMP: " + listTemp.size());
			int l = 0;
	        for(int i = 0; i < sqlList.size(); i++){
	            rsInsert.execute(sqlList.get(i).toString());
	            l++;
	        }
	        bs.writeLog("插了" + l + "条记录 ");
	        //清除缓存，费总都这么写的
	        CapitalComInfo cci;
			try {
				cci = new CapitalComInfo();
				cci.removeCapitalCache();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			bs.writeLog("74_Exception: \n" + e);
		} finally {
			bs.writeLog("74_TEMP_END ");
		}
		out.print("OK");
	}
%>

<%!
	/**
	 * 取自张嘉裕的代码，作用为适应“-”后1位和“-”后有多位的情况下，更改当前的CUST_LOT_ID为原CUST_LOT_ID
	 * 
	 * @param custLotId
	 * @return
	 */
	public static String setCustLotId(String custLotId) {
		String result = null;
		if (!custLotId.contains("-")) {
			result = custLotId + "-1";
		} else {
			String tmpStr = custLotId.substring(custLotId.indexOf('-') + 1);
			char[] values = tmpStr.toCharArray();
			// int index = 0;
			if (values.length == 1)// -后有1位
			{
				result = custLotId.substring(0, custLotId.indexOf('-'));
			} else// -后有多位
			{
				result = subCustLotId(custLotId, 0, false);
			}
		}
		return result;
	}

	/**
	 * 取自张嘉裕的代码，作用为当-后有多位更改当前的CUST_LOT_ID为原CUST_LOT_ID
	 * 
	 * @param str
	 * @param index
	 * @param flag
	 * @return
	 */
	public static String subCustLotId(String str, int index, boolean flag) {
		String result = null;
		String tmpStr = str.substring(str.indexOf('-') + 1);
		char[] values = tmpStr.toCharArray();
		boolean numFlag = false;
		if (index == 0) {
			if (48 <= values[values.length - 1 - index]
					&& values[values.length - 1 - index] <= 57) {
				numFlag = true;
			}
			index++;
			result = subCustLotId(str, index, numFlag);
			if (result.length() != 0 && result != null) {
				return result;
			}
		} else {
			if (48 <= values[values.length - 1 - index]
					&& values[values.length - 1 - index] <= 57) {
				numFlag = true;
			}
			if (flag == numFlag) {
				index++;
				if (values.length == index) {
					result = str.substring(0, str.indexOf('-'));
					return result;
				} else {
					result = subCustLotId(str, index, flag);
					if (result.length() != 0 && result != null) {
						return result;
					}
				}
			}
		}
		result = str.substring(0, str.length() - index);
		return result;
	}
%>

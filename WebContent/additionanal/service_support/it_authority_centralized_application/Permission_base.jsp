<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util,net.sf.json.JSONObject,weaver.general.BaseBean"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.soa.workflow.request.Property"%>

<%@ page import="weaver.interfaces.workflow.util.BillUtil"%>
<%
   Map<String,String> map = new HashMap<String,String>();
   BaseBean bb=new BaseBean();
	//当前基本信息
	bb.writeLog("---------------------------");

  	int nodeid =Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
	int formid =Util.getIntValue(request.getParameter("formid"));//表单id
	int workflowid =Util.getIntValue(request.getParameter("workflowid"));//流程id
	map.put("workflowid", workflowid+"");
	bb.writeLog("---------------------------"+nodeid+formid+workflowid);
	//节点信息
	int nodeStart = BillUtil.getNodeId(workflowid, "01 申请");
	map.put("nodeStart", nodeStart+"");
	//main
	String applicant = BillUtil.getLabelId(formid,0,"CREATER");//创建人
	map.put("applicant", applicant);
	
	String fieldMAdminroles = BillUtil.getLabelId(formid, 0, "ADMINROLES");
	map.put("fieldMAdminroles", fieldMAdminroles);
	String fieldMIfMes = BillUtil.getLabelId(formid, 0, "IFMES");//
	map.put("fieldMIfMes", fieldMIfMes);
	String fieldMFactory =BillUtil.getLabelId(formid, 0, "FACTORY");
	map.put("fieldMFactory", fieldMFactory);

	
	
	//dt1
	String fieldDt1Category = BillUtil.getLabelId(formid, 1, "CATEGORY");
	map.put("fieldDt1Category", fieldDt1Category);
	
	String fieldDt1System = BillUtil.getLabelId(formid, 1, "SYSTEM");
	map.put("fieldDt1System", fieldDt1System);
	
	String fieldDt1Remark = BillUtil.getLabelId(formid, 1, "REMARK");
	map.put("fieldDt1Remark", fieldDt1Remark);
	
	String fieldDt1Admin = BillUtil.getLabelId(formid, 1, "ADMIN");
	map.put("fieldDt1Admin", fieldDt1Admin);
	
	
	
	
	//dt2
	String fieldDt2EmpNo = BillUtil.getLabelId(formid, 2, "EMP_NO");
	map.put("fieldDt2EmpNo", fieldDt2EmpNo);
	
	String fieldDt2EmpRemark = BillUtil.getLabelId(formid, 2, "EMP_REMARK");
	map.put("fieldDt2EmpRemark", fieldDt2EmpRemark);
	
	String fieldDt2DateExpireFlag = BillUtil.getLabelId(formid, 2, "DATE_EXPIRE_FLAG");
	map.put("fieldDt2DateExpireFlag", fieldDt2DateExpireFlag);
	
	String fieldDt2DateExpire = BillUtil.getLabelId(formid, 2, "DATE_EXPIRE");
	map.put("fieldDt2DateExpire", fieldDt2DateExpire);
	
	
	
	
	//select
	//MAIN
	int optionMainFactoryCC = BillUtil.getSelectValue(formid, 1, "FACTORY", "崇川");
	map.put("optionMainFactoryCC", optionMainFactoryCC+"");
	
	int optionMainFactoryST = BillUtil.getSelectValue(formid, 1, "FACTORY", "苏通");
	map.put("optionMainFactoryST", optionMainFactoryST+"");
	
	int optionMainFactoryHF = BillUtil.getSelectValue(formid, 1, "FACTORY", "合肥");
	map.put("optionMainFactoryHF", optionMainFactoryHF+"");
	
	
	
	
	//dt1
	int optionDt1SystemSAP = BillUtil.getSelectValue(formid, 1, "SYSTEM", "SAP");
	map.put("optionDt1SystemSAP", optionDt1SystemSAP+"");
	
	int optionDt1SystemWEE = BillUtil.getSelectValue(formid, 1, "SYSTEM", "WEE");
	map.put("optionDt1SystemWEE", optionDt1SystemWEE+"");
	
	int optionDt1SystemOA = BillUtil.getSelectValue(formid, 1, "SYSTEM", "OA");
	map.put("optionDt1SystemOA", optionDt1SystemOA+"");
	
	int optionDt1SystemMES = BillUtil.getSelectValue(formid, 1, "SYSTEM", "MES");
	map.put("optionDt1SystemMES", optionDt1SystemMES+"");

	int optionDt1SystemEMS = BillUtil.getSelectValue(formid, 1, "SYSTEM", "EMS");
	map.put("optionDt1SystemEMS", optionDt1SystemEMS+"");
	
	int optionDt1SystemFMB = BillUtil.getSelectValue(formid, 1, "SYSTEM", "FMB");
	map.put("optionDt1SystemFMB", optionDt1SystemFMB+"");
	
	int optionDt1SystemNopaper = BillUtil.getSelectValue(formid, 1, "SYSTEM", "无纸化");
	map.put("optionDt1SystemNopaper", optionDt1SystemNopaper+"");
	
	int optionDt1SystemGotonet = BillUtil.getSelectValue(formid, 1, "SYSTEM", "上网");
	map.put("optionDt1SystemGotonet", optionDt1SystemGotonet+"");
	
	int optionDt1SystemEmail = BillUtil.getSelectValue(formid, 1, "SYSTEM", "个人邮箱");
	map.put("optionDt1SystemEmail", optionDt1SystemEmail+"");
	
	int optionDt1SystemSKYPE = BillUtil.getSelectValue(formid, 1, "SYSTEM", "SKYPE");
	map.put("optionDt1SystemSKYPE", optionDt1SystemSKYPE+"");
	
	int optionDt1SystemFTPSFTP = BillUtil.getSelectValue(formid, 1, "SYSTEM", "FTP/SFTP");
	map.put("optionDt1SystemFTPSFTP", optionDt1SystemFTPSFTP+"");
	
	int optionDt1SystemSSLVPN = BillUtil.getSelectValue(formid, 1, "SYSTEM", "SSLVPN");
	map.put("optionDt1SystemSSLVPN", optionDt1SystemSSLVPN+"");
	
	int optionDt1SystemEmailGroup = BillUtil.getSelectValue(formid, 1, "SYSTEM", "邮件组");
	map.put("optionDt1SystemEmailGroup", optionDt1SystemEmailGroup+"");
	
	int optionDt1SystemReport = BillUtil.getSelectValue(formid, 1, "SYSTEM", "REPORT");
	map.put("optionDt1SystemReport", optionDt1SystemReport+"");
	
	int optionDt1SystemUsb = BillUtil.getSelectValue(formid, 1, "SYSTEM", "USB接口");
	map.put("optionDt1SystemUsb", optionDt1SystemUsb+"");
	
	int optionDt1SystemRemote = BillUtil.getSelectValue(formid, 1, "SYSTEM", "远程协助");
	map.put("optionDt1SystemRemote", optionDt1SystemRemote+"");
	int optionDt1SystemBackup = BillUtil.getSelectValue(formid, 1, "SYSTEM", "服务器数据备份");
	map.put("optionDt1SystemBackup", optionDt1SystemBackup+"");
	int optionDt1SystemMachine = BillUtil.getSelectValue(formid, 1, "SYSTEM", "堡垒机");
	map.put("optionDt1SystemMachine", optionDt1SystemMachine+"");
    //门禁系统
	int optionDt1SystemEntranceGuard= BillUtil.getSelectValue(formid, 1, "SYSTEM", "门禁系统");
	map.put("optionDt1SystemEntranceGuard", optionDt1SystemEntranceGuard+"");
	//客户主机托管
	int optionDt1SystemWebHosting= BillUtil.getSelectValue(formid, 1, "SYSTEM", "客户主机托管");
	map.put("optionDt1SystemWebHosting", optionDt1SystemWebHosting+"");
    //文件共享
	int optionDt1SystemFileShare= BillUtil.getSelectValue(formid, 1, "SYSTEM", "文件共享");
	map.put("optionDt1SystemFileShare", optionDt1SystemFileShare+"");
	
	JSONObject jsonObject = JSONObject.fromObject(map);  
	bb.writeLog("---------------------------"+jsonObject.toString());
	out.print(jsonObject);
%>

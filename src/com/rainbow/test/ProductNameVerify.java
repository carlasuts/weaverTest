package com.rainbow.test;

import java.io.File;
import java.rmi.Naming;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.workflow.pojo.TestDepartment.programList.ProductNameVerifyPojo;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.interfaces.workflow.util.IHello;
import weaver.interfaces.workflow.util.ZipUtil;
import weaver.soa.workflow.request.RequestInfo;

public class ProductNameVerify implements Action {
	private static int formId = 0;

	@Override
	public String execute(RequestInfo request) {

		formId = BillUtil.getFormId(Integer.parseInt(request.getWorkflowid()));
		BaseBean baseBean = new BaseBean();
		RecordSet rs = new RecordSet();

		String sql = "";
		String rid = request.getRequestid();// 获取当且流程的id
		baseBean.writeLog("**********程序开始执行**********");

		try {

			String rmiurl = baseBean.getPropValue("RMIService", "rmiurl");// 这边似乎有问题
			baseBean.writeLog("rmiurl:" + rmiurl);
			sql = "select * from formtable_main_" + formId + " where requestid = " + rid;
			baseBean.writeLog("从formtable_main_" + formId + "查询数据" + sql);
			rs.executeSql(sql);
			rs.next();

			String SCWJ = rs.getString("SCWJ");// SCWJ即下面要使用的docid
			// 申请类型 0:新建 1:升版 2:作废
			String SQLX = rs.getString("SQLX");
			baseBean.writeLog("这里是申请类型：" + SQLX);

			String productNameListString = "";

			/**
			 * 判断是新增还是升版 如果是新增就把XZDYPMLIST字段里的值赋给productNameList
			 * 如果是升版就把SBDYPMLIST字段里的值赋给productNameList
			 */
			if (SQLX.equals("0")) { // 申请类型为新增
				sql = "SELECT replace(XZDYPMLIST,'&nbsp;','') as xzdypmlist FROM formtable_main_" + formId
						+ " where requestid = " + rid;
				baseBean.writeLog("替换数据库中XZDYPMLIST的空格:" + sql);
				String xjProductNameList = rs.getString("xzdypmlist");
				rs.executeSql(sql);
				rs.next();
				productNameListString = xjProductNameList;
				baseBean.writeLog("xjProductNameList" + xjProductNameList);
			} else if (SQLX.equals("1")) {// 申请类型为升版
				sql = "SELECT replace(SBDYPMLIST,'&nbsp;','') as sbdypmlist FROM formtable_main_" + formId
						+ " where requestid = " + rid;
				baseBean.writeLog("替换数据库中SBDYPMLIST的空格:" + sql);
				String sbProductNameList = rs.getString("sbdypmlist");
				baseBean.writeLog("ProductNameVerify sql:" + sql);
				rs.executeSql(sql);
				rs.next();
				productNameListString = sbProductNameList;
				baseBean.writeLog("sbProductNameList" + sbProductNameList);
			} else if (SQLX.equals("2")) { // 申请类型为作废
				return Action.SUCCESS;
			}
			baseBean.writeLog("替换之后的productNameList：" + productNameListString);

			sql = "select * from DOCIMAGEFILE where docid = '" + SCWJ + "'";
			rs.executeSql(sql);
			rs.next();

			String imagefileid = rs.getString("imagefileid");
			baseBean.writeLog("imagefileid:" + imagefileid);

			String fileType = rs.getString("IMAGEFILENAME").substring(rs.getString("IMAGEFILENAME").indexOf("."));
			baseBean.writeLog("fileType:" + fileType);

			sql = "select * from IMAGEFILE where imagefileid = '" + imagefileid + "'";
			rs.executeSql(sql);
			rs.next();

			String filerealpath = rs.getString("filerealpath");

			baseBean.writeLog("压缩包真实路径 filerealpath:" + filerealpath);

			ZipUtil.unzip(filerealpath);

			String unzipfilepath = filerealpath.replace(".zip", "");
			baseBean.writeLog("解压后的文件路径:" + unzipfilepath);

			File file = new File(unzipfilepath);
			if (file.exists()) {
				file.renameTo(new File(unzipfilepath + fileType));
			}
			String test = unzipfilepath + fileType;
			baseBean.writeLog("解压后文件的全路径" + test);

			baseBean.writeLog("解压后文件的全路径");
			baseBean.writeLog("productNameListString: " + productNameListString);
			String[] productName = productNameListString.split("\r<br>");
			List<String> productList = new ArrayList<String>(Arrays.asList(productName));
			Iterator<String> it = productList.iterator();
			while (it.hasNext()) {
				String x = it.next();
				if ("".equals(x)) {
					it.remove();
				}
			}
			for (String string : productList) {
				baseBean.writeLog(string);
			}
			Set<String> productNameSet = new HashSet<String>(productList);
			if (productList.size() != productNameSet.size()) {
				request.getRequestManager().setMessageid("录入内容有误");
				request.getRequestManager().setMessagecontent("录入的品名中包含重复项");
				throw new RuntimeException("录入的品名中包含重复项");
			} else {
				baseBean.writeLog("录入内容无重复项 size:" + productNameSet.size());
			}
			IHello rhello = (IHello) Naming.lookup(rmiurl);
			ProductNameVerifyPojo rmipojo = rhello.getDescsByFile(test);

			if (!rmipojo.isOk()) {
				request.getRequestManager().setMessageid("文档有误");
				request.getRequestManager().setMessagecontent(rmipojo.getMsg());
				throw new RuntimeException(rmipojo.getMsg());
			} else {
				baseBean.writeLog("RMI正常返回");
				Set<String> rmiproductNameSet = new HashSet<String>(rmipojo.getContent());
				baseBean.writeLog("rmiproductNameSet.size:" + rmiproductNameSet.size());
				if (rmiproductNameSet.size() != productNameSet.size()) {
					baseBean.writeLog("条目数不一致");
					baseBean.writeLog("rmiproductNameSet.size:" + rmiproductNameSet.size());
					for (String string : rmiproductNameSet) {
						baseBean.writeLog(string);
					}
					baseBean.writeLog("productNameSet.size:" + productNameSet.size());
					for (String string : rmiproductNameSet) {
						baseBean.writeLog(string);
					}
					request.getRequestManager().setMessageid("录入内容或文档有误");
					request.getRequestManager().setMessagecontent("条目数不一致");
					throw new RuntimeException("条目数不一致");
				} else if (!rmiproductNameSet.equals(productNameSet)) {
					baseBean.writeLog("内容不一致");
					baseBean.writeLog("rmiproductNameSet content");
					for (String string : rmiproductNameSet) {
						baseBean.writeLog(string);
					}
					baseBean.writeLog("productNameSet content");
					for (String string : rmiproductNameSet) {
						baseBean.writeLog(string);
					}
					request.getRequestManager().setMessageid("录入内容或文档有误");
					request.getRequestManager().setMessagecontent("内容不一致");
					throw new RuntimeException("内容不一致");
				}
			}

		} catch (Exception e) {
			if (request.getRequestManager().getMessageid() == null) {
				request.getRequestManager().setMessageid("Other");
			}
			request.getRequestManager().setMessagecontent(e.getMessage());
			sql = "UPDATE formtable_main_" + formId
					+ " SET XZSQIDH=NULL,XZBBH=NULL,SBIDH=NULL,SBIDBBH=NULL,SCWJ=NULL,BZXX=NULL,CUSTID=NULL,XZDYPMLIST=NULL,SBDYPMLIST=NULL,ZFIDH=NULL,ZFIDBBH=NULL,ZFDYPMLIST=NULL,BFBZ=NULL,SHR=NULL,THBZ=1 where requestid ="
					+ rid;
			rs.execute(sql);
			rs.next();
			baseBean.writeLog("请联系管理员：" + sql);

			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("ProductNameVerify Message:" + e.getMessage());
			baseBean.writeLog("ProductNameVerify StackTrace:" + e.getStackTrace());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		baseBean.writeLog("**********程序结束**********");
		return Action.SUCCESS;
	}
}
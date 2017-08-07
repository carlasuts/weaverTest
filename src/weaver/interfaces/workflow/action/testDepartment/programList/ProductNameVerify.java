package weaver.interfaces.workflow.action.testDepartment.programList;

import java.io.File;
import java.io.FileInputStream;
import java.net.URL;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.hwpf.usermodel.Table;
import org.apache.poi.hwpf.usermodel.TableIterator;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.workflow.util.ZipUtil;
import weaver.soa.workflow.request.RequestInfo;

public class ProductNameVerify implements Action {
	public String execute(RequestInfo request) {

		BaseBean baseBean = new BaseBean();
		RecordSet rs = new RecordSet();
		String sql = "";
		String rid = request.getRequestid();// 获取当且流程的id
		baseBean.writeLog("**********程序开始执行**********");

		try {
			ClassLoader classloader = POIFSFileSystem.class.getClassLoader();
			URL res = classloader
					.getResource("org/apache/poi/poifs/filesystem/POIFSFileSystem.class");
			String path = res.getPath();

			sql = "select * from formtable_main_93 where requestid = " + rid;
			baseBean.writeLog("从formtable_main_93查询数据" + sql);
			rs.executeSql(sql);
			rs.next();

			String SCWJ = rs.getString("SCWJ");// SCWJ即下面要使用的docid

			// String ifIncrease = rs.getString("SFXJ");
			//
			// String ifRise = rs.getString("SFSB");
			//
			// String ifZF = rs.getString("SFZF");

			// 申请类型 0:新建 1:升版 2:作废
			String SQLX = rs.getString("SQLX");
			baseBean.writeLog("这里是申请类型：" + SQLX);

			String productNameList = "";

			/**
			 * 判断是新增还是升版 如果是新增就把XZDYPMLIST字段里的值赋给productNameList
			 * 如果是升版就把SBDYPMLIST字段里的值赋给productNameList
			 */
			if (SQLX.equals("0")) { // 申请类型为新增
				sql = "SELECT replace(XZDYPMLIST,'<br>','') as xzdypmlist FROM FORMTABLE_MAIN_93 where requestid = "
						+ rid;
				baseBean.writeLog("替换数据库中XZDYPMLIST的<br>:" + sql);
				String xjProductNameList = rs.getString("xzdypmlist");
				rs.executeSql(sql);
				rs.next();
				productNameList = xjProductNameList;
				baseBean.writeLog("xjProductNameList" + xjProductNameList);
			} else if (SQLX.equals("1")) {// 申请类型为升版
				sql = "SELECT replace(SBDYPMLIST,'<br>','') as sbdypmlist FROM FORMTABLE_MAIN_93 where requestid = "
						+ rid;
				baseBean.writeLog("替换数据库中SBDYPMLIST的<br>:" + sql);
				String sbProductNameList = rs.getString("sbdypmlist");
				baseBean.writeLog("ProductNameVerify sql:" + sql);
				rs.executeSql(sql);
				rs.next();
				productNameList = sbProductNameList;
				baseBean.writeLog("sbProductNameList" + sbProductNameList);
			} else if (SQLX.equals("2")) { // 申请类型为作废
				return Action.SUCCESS;
			}
			baseBean.writeLog("替换之后的productNameList：" + productNameList);

			sql = "select * from DOCIMAGEFILE where docid = '" + SCWJ + "'";
			rs.executeSql(sql);
			rs.next();

			String imagefileid = rs.getString("imagefileid");
			baseBean.writeLog("imagefileid:" + imagefileid);

			String fileType = rs.getString("IMAGEFILENAME").substring(
					rs.getString("IMAGEFILENAME").indexOf("."));
			baseBean.writeLog("fileType:" + fileType);

			sql = "select * from IMAGEFILE where imagefileid = '" + imagefileid
					+ "'";
			rs.executeSql(sql);
			rs.next();

			String filerealpath = rs.getString("filerealpath");

			filerealpath = "\\\\172.16.60.63\\d"
					+ filerealpath.substring(filerealpath.indexOf(":") + 1);

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

			/**
			 * 对附件进行读取操作和卡控操作
			 */
			try {
				FileInputStream in = new FileInputStream(test);
				// 数据库中取出来的productNameList按照<br>分割
				String[] productName = productNameList.split("\r<br>");

				int length = productName.length;
				baseBean.writeLog("productName的长度:" + length);
				int count = 0;
				/**
				 * 如果是docx结尾的word文档
				 */
				if (test.toLowerCase().endsWith("docx")) {
					XWPFDocument xwpf = new XWPFDocument(in);
					Iterator it = xwpf.getTablesIterator();
					if (it.hasNext()) {
						XWPFTable table = (XWPFTable) it.next();
						List rows = table.getRows();
						String aftersString = "";
						for (int i = 1; i < rows.size(); i++) {
							XWPFTableRow row = (XWPFTableRow) rows.get(i);
							List cells = row.getTableCells();
							XWPFTableCell cell = (XWPFTableCell) cells.get(0);
							if (!cell.getText().trim().isEmpty()) {// 判断文档中的表格有没有空白行
								count++;
							}
							aftersString = aftersString + cell.getText() + ",";
						}
						String[] afterList = aftersString.split(",");
						baseBean.writeLog("附件表格变换内容:" + aftersString);
						baseBean.writeLog("计数count:" + count);
						for (String al : afterList) {
							baseBean.writeLog("docx的al" + al);
							boolean flag = false;
							for (String pn : productName) {
								baseBean.writeLog("docx的pn" + pn);
								if (pn.equals(al)) {
									flag = true;
								}
							}
							if (!flag) {
								request.getRequestManager().setMessageid("400");
								request.getRequestManager().setMessagecontent(
										"输入的品名和附件中的品名不符,请检查后提交");
								sql = "UPDATE formtable_main_93 SET SFXJ=NULL,XZSQIDH=NULL,XZBBH=NULL,SBIDH=NULL,SBIDBBH=NULL,SCWJ=NULL,BZXX=NULL,SFSB=NULL,LSFJ=NULL,CUSTID=NULL,XZDYPMLIST=NULL,SBDYPMLIST=NULL,SFZF=NULL,ZFIDH=NULL,ZFIDBBH=NULL,ZFDYPMLIST=NULL,BFBZ=NULL,SHR=NULL,PKLD=NULL where requestid ="
										+ rid;
								rs.execute(sql);
								rs.next();
								baseBean.writeLog("docx品名不符：" + sql);
							}
						}
					}
				} else {// word文档为doc结尾
					HWPFDocument hwpf = new HWPFDocument(in);
					Range range = hwpf.getRange();
					TableIterator it = new TableIterator(range);

					if (it.hasNext()) {
						Table tb = it.next();
						String aftersString = "";
						for (int i = 1; i < tb.numRows(); i++) {
							if (!tb.getRow(i).getCell(0).text().trim()
									.isEmpty()) {
								count++;
							}
							aftersString = aftersString
									+ tb.getRow(i).getCell(0).text().trim()
									+ ",";
						}
						baseBean.writeLog("doc" + aftersString);
						baseBean.writeLog("doc" + productNameList);
						String[] afterList = aftersString.split(",");
						for (String al : afterList) {
							baseBean.writeLog("doc的al" + al);
							boolean flag = false;
							for (String pn : productName) {
								baseBean.writeLog("doc的pn" + pn);
								if (pn.equals(al)) {
									flag = true;
								}
							}
							if (!flag) {
								request.getRequestManager().setMessageid("401");
								request.getRequestManager().setMessagecontent(
										"输入的品名和附件中的品名不符,请检查后提交");
								sql = "UPDATE formtable_main_93 SET XZSQIDH=NULL,XZBBH=NULL,SBIDH=NULL,SBIDBBH=NULL,SCWJ=NULL,BZXX=NULL,CUSTID=NULL,XZDYPMLIST=NULL,SBDYPMLIST=NULL,ZFIDH=NULL,ZFIDBBH=NULL,ZFDYPMLIST=NULL,BFBZ=NULL,SHR=NULL,THBZ=1 where requestid ="
										+ rid;
								rs.execute(sql);
								rs.next();
								baseBean.writeLog("doc品名不符：" + sql);
							}
						}
					}
				}
				baseBean.writeLog("这边数目怎么就不一样了");
				baseBean.writeLog("count:" + count);
				baseBean.writeLog("productName.length:" + productName.length);
				if (count != productName.length) {
					request.getRequestManager().setMessageid("402");
					request.getRequestManager().setMessagecontent(
							"输入的品名和附件中的品名数目不符合，请检查后提交");
					sql = "UPDATE formtable_main_93 SET XZSQIDH=NULL,XZBBH=NULL,SBIDH=NULL,SBIDBBH=NULL,SCWJ=NULL,BZXX=NULL,CUSTID=NULL,XZDYPMLIST=NULL,SBDYPMLIST=NULL,ZFIDH=NULL,ZFIDBBH=NULL,ZFDYPMLIST=NULL,BFBZ=NULL,SHR=NULL,THBZ=1 where requestid ="
							+ rid;
					rs.execute(sql);
					rs.next();
					baseBean.writeLog("品名数目不符：" + sql);
				}
			} catch (Exception e) {
				baseBean.writeLog(e.getMessage());
			}
		} catch (Exception e) {
			request.getRequestManager().setMessageid("403");
			request.getRequestManager().setMessagecontent("附件只能上传一个，请检查后重新提交！");
			sql = "UPDATE formtable_main_93 SET XZSQIDH=NULL,XZBBH=NULL,SBIDH=NULL,SBIDBBH=NULL,SCWJ=NULL,BZXX=NULL,CUSTID=NULL,XZDYPMLIST=NULL,SBDYPMLIST=NULL,ZFIDH=NULL,ZFIDBBH=NULL,ZFDYPMLIST=NULL,BFBZ=NULL,SHR=NULL,THBZ=1 where requestid ="
					+ rid;
			rs.execute(sql);
			rs.next();
			baseBean.writeLog("请联系管理员：" + sql);

			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("ProductNameVerify Message:" + e.getMessage());
			baseBean.writeLog("ProductNameVerify StackTrace:"
					+ e.getStackTrace());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		baseBean.writeLog("**********程序结束**********");
		return Action.SUCCESS;
	}
}
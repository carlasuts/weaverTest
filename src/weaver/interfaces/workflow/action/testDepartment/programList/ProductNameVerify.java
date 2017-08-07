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
		String rid = request.getRequestid();// ��ȡ�������̵�id
		baseBean.writeLog("**********����ʼִ��**********");

		try {
			ClassLoader classloader = POIFSFileSystem.class.getClassLoader();
			URL res = classloader
					.getResource("org/apache/poi/poifs/filesystem/POIFSFileSystem.class");
			String path = res.getPath();

			sql = "select * from formtable_main_93 where requestid = " + rid;
			baseBean.writeLog("��formtable_main_93��ѯ����" + sql);
			rs.executeSql(sql);
			rs.next();

			String SCWJ = rs.getString("SCWJ");// SCWJ������Ҫʹ�õ�docid

			// String ifIncrease = rs.getString("SFXJ");
			//
			// String ifRise = rs.getString("SFSB");
			//
			// String ifZF = rs.getString("SFZF");

			// �������� 0:�½� 1:���� 2:����
			String SQLX = rs.getString("SQLX");
			baseBean.writeLog("�������������ͣ�" + SQLX);

			String productNameList = "";

			/**
			 * �ж��������������� ����������Ͱ�XZDYPMLIST�ֶ����ֵ����productNameList
			 * ���������Ͱ�SBDYPMLIST�ֶ����ֵ����productNameList
			 */
			if (SQLX.equals("0")) { // ��������Ϊ����
				sql = "SELECT replace(XZDYPMLIST,'<br>','') as xzdypmlist FROM FORMTABLE_MAIN_93 where requestid = "
						+ rid;
				baseBean.writeLog("�滻���ݿ���XZDYPMLIST��<br>:" + sql);
				String xjProductNameList = rs.getString("xzdypmlist");
				rs.executeSql(sql);
				rs.next();
				productNameList = xjProductNameList;
				baseBean.writeLog("xjProductNameList" + xjProductNameList);
			} else if (SQLX.equals("1")) {// ��������Ϊ����
				sql = "SELECT replace(SBDYPMLIST,'<br>','') as sbdypmlist FROM FORMTABLE_MAIN_93 where requestid = "
						+ rid;
				baseBean.writeLog("�滻���ݿ���SBDYPMLIST��<br>:" + sql);
				String sbProductNameList = rs.getString("sbdypmlist");
				baseBean.writeLog("ProductNameVerify sql:" + sql);
				rs.executeSql(sql);
				rs.next();
				productNameList = sbProductNameList;
				baseBean.writeLog("sbProductNameList" + sbProductNameList);
			} else if (SQLX.equals("2")) { // ��������Ϊ����
				return Action.SUCCESS;
			}
			baseBean.writeLog("�滻֮���productNameList��" + productNameList);

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

			baseBean.writeLog("ѹ������ʵ·�� filerealpath:" + filerealpath);

			ZipUtil.unzip(filerealpath);

			String unzipfilepath = filerealpath.replace(".zip", "");
			baseBean.writeLog("��ѹ����ļ�·��:" + unzipfilepath);

			File file = new File(unzipfilepath);
			if (file.exists()) {
				file.renameTo(new File(unzipfilepath + fileType));
			}
			String test = unzipfilepath + fileType;
			baseBean.writeLog("��ѹ���ļ���ȫ·��" + test);

			/**
			 * �Ը������ж�ȡ�����Ϳ��ز���
			 */
			try {
				FileInputStream in = new FileInputStream(test);
				// ���ݿ���ȡ������productNameList����<br>�ָ�
				String[] productName = productNameList.split("\r<br>");

				int length = productName.length;
				baseBean.writeLog("productName�ĳ���:" + length);
				int count = 0;
				/**
				 * �����docx��β��word�ĵ�
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
							if (!cell.getText().trim().isEmpty()) {// �ж��ĵ��еı����û�пհ���
								count++;
							}
							aftersString = aftersString + cell.getText() + ",";
						}
						String[] afterList = aftersString.split(",");
						baseBean.writeLog("�������任����:" + aftersString);
						baseBean.writeLog("����count:" + count);
						for (String al : afterList) {
							baseBean.writeLog("docx��al" + al);
							boolean flag = false;
							for (String pn : productName) {
								baseBean.writeLog("docx��pn" + pn);
								if (pn.equals(al)) {
									flag = true;
								}
							}
							if (!flag) {
								request.getRequestManager().setMessageid("400");
								request.getRequestManager().setMessagecontent(
										"�����Ʒ���͸����е�Ʒ������,������ύ");
								sql = "UPDATE formtable_main_93 SET SFXJ=NULL,XZSQIDH=NULL,XZBBH=NULL,SBIDH=NULL,SBIDBBH=NULL,SCWJ=NULL,BZXX=NULL,SFSB=NULL,LSFJ=NULL,CUSTID=NULL,XZDYPMLIST=NULL,SBDYPMLIST=NULL,SFZF=NULL,ZFIDH=NULL,ZFIDBBH=NULL,ZFDYPMLIST=NULL,BFBZ=NULL,SHR=NULL,PKLD=NULL where requestid ="
										+ rid;
								rs.execute(sql);
								rs.next();
								baseBean.writeLog("docxƷ��������" + sql);
							}
						}
					}
				} else {// word�ĵ�Ϊdoc��β
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
							baseBean.writeLog("doc��al" + al);
							boolean flag = false;
							for (String pn : productName) {
								baseBean.writeLog("doc��pn" + pn);
								if (pn.equals(al)) {
									flag = true;
								}
							}
							if (!flag) {
								request.getRequestManager().setMessageid("401");
								request.getRequestManager().setMessagecontent(
										"�����Ʒ���͸����е�Ʒ������,������ύ");
								sql = "UPDATE formtable_main_93 SET XZSQIDH=NULL,XZBBH=NULL,SBIDH=NULL,SBIDBBH=NULL,SCWJ=NULL,BZXX=NULL,CUSTID=NULL,XZDYPMLIST=NULL,SBDYPMLIST=NULL,ZFIDH=NULL,ZFIDBBH=NULL,ZFDYPMLIST=NULL,BFBZ=NULL,SHR=NULL,THBZ=1 where requestid ="
										+ rid;
								rs.execute(sql);
								rs.next();
								baseBean.writeLog("docƷ��������" + sql);
							}
						}
					}
				}
				baseBean.writeLog("�����Ŀ��ô�Ͳ�һ����");
				baseBean.writeLog("count:" + count);
				baseBean.writeLog("productName.length:" + productName.length);
				if (count != productName.length) {
					request.getRequestManager().setMessageid("402");
					request.getRequestManager().setMessagecontent(
							"�����Ʒ���͸����е�Ʒ����Ŀ�����ϣ�������ύ");
					sql = "UPDATE formtable_main_93 SET XZSQIDH=NULL,XZBBH=NULL,SBIDH=NULL,SBIDBBH=NULL,SCWJ=NULL,BZXX=NULL,CUSTID=NULL,XZDYPMLIST=NULL,SBDYPMLIST=NULL,ZFIDH=NULL,ZFIDBBH=NULL,ZFDYPMLIST=NULL,BFBZ=NULL,SHR=NULL,THBZ=1 where requestid ="
							+ rid;
					rs.execute(sql);
					rs.next();
					baseBean.writeLog("Ʒ����Ŀ������" + sql);
				}
			} catch (Exception e) {
				baseBean.writeLog(e.getMessage());
			}
		} catch (Exception e) {
			request.getRequestManager().setMessageid("403");
			request.getRequestManager().setMessagecontent("����ֻ���ϴ�һ��������������ύ��");
			sql = "UPDATE formtable_main_93 SET XZSQIDH=NULL,XZBBH=NULL,SBIDH=NULL,SBIDBBH=NULL,SCWJ=NULL,BZXX=NULL,CUSTID=NULL,XZDYPMLIST=NULL,SBDYPMLIST=NULL,ZFIDH=NULL,ZFIDBBH=NULL,ZFDYPMLIST=NULL,BFBZ=NULL,SHR=NULL,THBZ=1 where requestid ="
					+ rid;
			rs.execute(sql);
			rs.next();
			baseBean.writeLog("����ϵ����Ա��" + sql);

			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("ProductNameVerify Message:" + e.getMessage());
			baseBean.writeLog("ProductNameVerify StackTrace:"
					+ e.getStackTrace());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		baseBean.writeLog("**********�������**********");
		return Action.SUCCESS;
	}
}
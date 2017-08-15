package weaver.interfaces.workflow.action.testDepartment.programList;

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
		String rid = request.getRequestid();// ��ȡ�������̵�id
		baseBean.writeLog("**********����ʼִ��**********");

		try {

			String rmiurl = baseBean.getPropValue("RMIService", "rmiurl");// ����ƺ�������
			baseBean.writeLog("rmiurl:" + rmiurl);
			sql = "select * from formtable_main_" + formId + " where requestid = " + rid;
			baseBean.writeLog("��formtable_main_" + formId + "��ѯ����" + sql);
			rs.executeSql(sql);
			rs.next();

			String SCWJ = rs.getString("SCWJ");// SCWJ������Ҫʹ�õ�docid
			// �������� 0:�½� 1:���� 2:����
			String SQLX = rs.getString("SQLX");
			baseBean.writeLog("�������������ͣ�" + SQLX);

			String productNameListString = "";

			/**
			 * �ж��������������� ����������Ͱ�XZDYPMLIST�ֶ����ֵ����productNameList
			 * ���������Ͱ�SBDYPMLIST�ֶ����ֵ����productNameList
			 */
			if (SQLX.equals("0")) { // ��������Ϊ����
				sql = "SELECT replace(XZDYPMLIST,'&nbsp;','') as xzdypmlist FROM formtable_main_" + formId
						+ " where requestid = " + rid;
				baseBean.writeLog("�滻���ݿ���XZDYPMLIST�Ŀո�:" + sql);
				String xjProductNameList = rs.getString("xzdypmlist");
				rs.executeSql(sql);
				rs.next();
				productNameListString = xjProductNameList;
				baseBean.writeLog("xjProductNameList" + xjProductNameList);
			} else if (SQLX.equals("1")) {// ��������Ϊ����
				sql = "SELECT replace(SBDYPMLIST,'&nbsp;','') as sbdypmlist FROM formtable_main_" + formId
						+ " where requestid = " + rid;
				baseBean.writeLog("�滻���ݿ���SBDYPMLIST�Ŀո�:" + sql);
				String sbProductNameList = rs.getString("sbdypmlist");
				baseBean.writeLog("ProductNameVerify sql:" + sql);
				rs.executeSql(sql);
				rs.next();
				productNameListString = sbProductNameList;
				baseBean.writeLog("sbProductNameList" + sbProductNameList);
			} else if (SQLX.equals("2")) { // ��������Ϊ����
				return Action.SUCCESS;
			}
			baseBean.writeLog("�滻֮���productNameList��" + productNameListString);

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

			baseBean.writeLog("��ѹ���ļ���ȫ·��");
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
				request.getRequestManager().setMessageid("¼����������");
				request.getRequestManager().setMessagecontent("¼���Ʒ���а����ظ���");
				throw new RuntimeException("¼���Ʒ���а����ظ���");
			} else {
				baseBean.writeLog("¼���������ظ��� size:" + productNameSet.size());
			}

			IHello rhello = (IHello) Naming.lookup(rmiurl);
			baseBean.writeLog("rmiurl:" + rmiurl);
			ProductNameVerifyPojo rmipojo = rhello.getDescsByFile(test);
			baseBean.writeLog("ȫ·��:" + test);

			if (!rmipojo.isOk()) {
				request.getRequestManager().setMessageid("�ĵ�����");
				request.getRequestManager().setMessagecontent(rmipojo.getMsg());
				throw new RuntimeException(rmipojo.getMsg());
			} else {
				baseBean.writeLog("RMI��������");
				Set<String> rmiproductNameSet = new HashSet<String>(rmipojo.getContent());
				baseBean.writeLog("rmiproductNameSet.size:" + rmiproductNameSet.size());
				if (rmiproductNameSet.size() != productNameSet.size()) {
					baseBean.writeLog("��Ŀ����һ��");
					baseBean.writeLog("rmiproductNameSet.size:" + rmiproductNameSet.size());
					for (String string : rmiproductNameSet) {
						baseBean.writeLog(string);
					}
					baseBean.writeLog("productNameSet.size:" + productNameSet.size());
					for (String string : rmiproductNameSet) {
						baseBean.writeLog(string);
					}
					request.getRequestManager().setMessageid("¼�����ݻ��ĵ�����");
					request.getRequestManager().setMessagecontent("��Ŀ����һ��");
					throw new RuntimeException("��Ŀ����һ��");
				} else if (!rmiproductNameSet.equals(productNameSet)) {
					baseBean.writeLog("���ݲ�һ��");
					baseBean.writeLog("rmiproductNameSet content");
					for (String string : rmiproductNameSet) {
						baseBean.writeLog(string);
					}
					baseBean.writeLog("productNameSet content");
					for (String string : rmiproductNameSet) {
						baseBean.writeLog(string);
					}
					request.getRequestManager().setMessageid("¼�����ݻ��ĵ�����");
					request.getRequestManager().setMessagecontent("���ݲ�һ��");
					throw new RuntimeException("���ݲ�һ��");
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
			baseBean.writeLog("����ϵ����Ա��" + sql);

			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("ProductNameVerify Message:" + e.getMessage());
			baseBean.writeLog("ProductNameVerify StackTrace:" + e.getStackTrace());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		baseBean.writeLog("**********�������**********");
		return Action.SUCCESS;
	}
}
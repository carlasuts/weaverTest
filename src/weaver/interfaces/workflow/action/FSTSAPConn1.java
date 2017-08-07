package weaver.interfaces.workflow.action;

import weaver.general.BaseBean;

import com.sap.mw.jco.JCO;
import com.sap.mw.jco.JCO.Client;

public class FSTSAPConn1 {
	final static String POOL_NAME = "Pool";
	private static JCO.Client mConnection = null;

	private static BaseBean bb = new BaseBean();
	private static String sapclient = "";
	private static String userid = "";
	private static String password = "";
	private static String hostname = "";
	private static String systemnumber = "";
	private static String Language = "";

	/*
	 * ��ʼ������
	 */
	public FSTSAPConn1() {
		bb.writeLog("-------------XSYSAPConn ----------------");
	}

	/*
	 * ��ʼ������
	 */
	private static void createConn() {
		try {
			bb.writeLog("-------------SAP Client Connects Start ----------------");
			sapclient = bb.getPropValue("SAPConn", "SAPClient");
			userid = bb.getPropValue("SAPConn", "Userid");
			password = bb.getPropValue("SAPConn", "Password");
			hostname = bb.getPropValue("SAPConn", "HostName");
			systemnumber = bb.getPropValue("SAPConn", "SystemNumber");
			Language = bb.getPropValue("SAPConn", "Language");

			JCO.Pool pool = JCO.getClientPoolManager().getPool(POOL_NAME);
			if (pool == null) {
				JCO.addClientPool(
						POOL_NAME, // pool name
						100, // maximum number of connections
						sapclient, userid, password, Language, hostname,
						systemnumber);
			}
			setConnection(JCO.getClient(POOL_NAME));// ��ȡ����
			bb.writeLog("get connection success");

		} catch (Exception e) {
			bb.writeLog("get connection error:" + e);
		}

	}

	/*
	 * �ͷ�����
	 */
	public static void releaseC() {
		if (mConnection != null)
			JCO.releaseClient(mConnection);
	}

	/*
	 * ��ȡ����
	 */
	public static Client getConnection() {
		if (mConnection == null) {
			createConn();
		}
		return mConnection;
	}

	/*
	 * ��������
	 */
	public static void setConnection(JCO.Client conn) {
		mConnection = conn;
	}

}

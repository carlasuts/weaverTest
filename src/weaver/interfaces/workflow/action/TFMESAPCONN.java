package weaver.interfaces.workflow.action;


import com.sap.mw.jco.*;
import weaver.general.BaseBean;

public class TFMESAPCONN {
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
	*初始化连接
	*/
	public void FSTSAPConn () {
		bb.writeLog("-------------FSTSAPConn ----------------");
	}

	/*
	*初始化连接
	*/
	private void init(){
		try{
			bb.writeLog("-------------SAP Client Connects Start ----------------");
			sapclient = bb.getPropValue("SAPConn", "SAPClient");
			userid = bb.getPropValue("SAPConn", "Userid");
			password = bb.getPropValue("SAPConn", "Password");
			hostname = bb.getPropValue("SAPConn", "HostName");
			systemnumber = bb.getPropValue("SAPConn", "SystemNumber");
			Language = bb.getPropValue("SAPConn", "Language");

			JCO.Pool pool = JCO.getClientPoolManager().getPool(POOL_NAME);
			if (pool == null) {
				JCO.addClientPool(POOL_NAME, // pool name
						100, // maximum number of connections
						sapclient,
						userid,
						password,
						Language,
						hostname,
						systemnumber);
			}
			setConnection(JCO.getClient(POOL_NAME));//获取连接
			bb.writeLog("get connection success");
		}
		catch (Exception e) {
			bb.writeLog("get connection error:"+e);
		}

	}
	/*
	*释放连接
	*/
	public void releaseC(){
		if(mConnection != null)
			JCO.releaseClient(mConnection);
	}

	/*
	*获取连接
	*/
	public JCO.Client getConnection(){
		if (mConnection == null){
			init();
		}
		return mConnection;
	}
	/*
	*设置连接
	*/
	public void setConnection(JCO.Client conn){
		mConnection = conn;
	}
	
	/*
	*执行Bapi
	*/
	public JCO.Function excuteBapi(String s ) {
		bb.writeLog("GET INTO Function Bapi!");
		TFMESAPCONN sapconn = new TFMESAPCONN();
		JCO.Client sapconnection = sapconn.getConnection();
		JCO.Repository mRepository;
		JCO.Function jcoFunction = null;
		bb.writeLog("sapconnection=="+sapconnection);
		if(sapconnection==null) return jcoFunction;

		try {
			mRepository = new JCO.Repository("sap", sapconnection);
			bb.writeLog("mRepository==" + mRepository);
			IFunctionTemplate ft = mRepository.getFunctionTemplate(s);
			
			jcoFunction = new JCO.Function(ft);
			bb.writeLog("excuete Bapi Success");
			return jcoFunction;
		} 
		catch (Exception e) {
			bb.writeLog(e);
			//JOptionPane.showMessageDialog(null, e.getMessage(), "错误信息", 0);
			return null;
		} 
		finally {
		}
	}
	
}

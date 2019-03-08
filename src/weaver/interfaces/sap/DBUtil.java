package weaver.interfaces.sap;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	
	public static Connection getConnection() throws Exception{
		
		String driver = "oracle.jdbc.driver.OracleDriver";
    	String dbName = "RPTDB";
    	String passwrod = "oaprod";
    	String userName = "oaprod_new";
    	String url = "jdbc:oracle:thin:@//172.16.20.6:1521/"+ dbName;
    	Connection conn = null;
    	String matGrp5 = "";
    	
//		PreparedStatement ps = null;
//		ResultSet rs = null;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, userName, passwrod);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return conn;
	}
	
//    public static void main(String[] args) {
//    	String driver = "oracle.jdbc.driver.OracleDriver";
//    	String dbName = "RPTDB";
//    	String passwrod = "oaprod_new";
//    	String userName = "oaprod";
//    	String url = "jdbc:oracle:thin:@//172.16.20.6:1521/"
//    			+ dbName;
//    	
//    	Connection conn = null;
//    	String matGrp5 = "";
//    	
//		PreparedStatement psOfMatId = null;
//		ResultSet rsOfMatId = null;
//		try {
//			Class.forName(driver);
//			conn = DriverManager.getConnection(url, userName, passwrod);
//			
////			String sqlOfMatId = "SELECT MAT.MAT_ID FROM MWIPMATDEF MAT WHERE MAT.MAT_GRP_5 = ? AND MAT.DELETE_FLAG = ' ' AND MAT.FACTORY = 'TEST'";
//			psOfMatId = conn.prepareStatement(sqlOfMatId);
////			psOfMatId.setString(1, matGrp5);
//			rsOfMatId = psOfMatId.executeQuery();
//
//			StringBuffer sb = new StringBuffer();
//			
//			while (rsOfMatId.next()) {
//				sb.append(rsOfMatId.getString(1)).append(",");
//			}
//			
//			if ("".equals(sb)) {
//				sb = sb.deleteCharAt(sb.length() - 1);
//			}
//			
//			String result = sb.toString();
//			
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			// 关闭记录集
//			if (rsOfMatId != null) {
//				try {
//					rsOfMatId.close();
//				} catch (SQLException e) {
//					e.printStackTrace();
//				}
//			}
//			// 关闭声明
//			if (psOfMatId != null) {
//				try {
//					psOfMatId.close();
//				} catch (SQLException e) {
//					e.printStackTrace();
//				}
//			}
//		}
//    }
	public static void close(Connection conn){
		if(conn !=null){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(getConnection());
	}
}
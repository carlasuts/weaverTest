package weaver.interfaces.workflow.action;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 * 获得和关闭数据库连接的工具类
 * @author tarena
 *
 */
public class DBUtil {
	public static Connection getConnection() throws Exception{
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/dangdang?" +
					"useUnicode=true&characterEncoding=utf8",
					"root","root");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return conn;
	}
	
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

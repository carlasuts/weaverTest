package flp.inster;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBUtil {

	public static final String url = "jdbc:oracle:thin:@//172.16.20.179:1521/prod";
	public static final String name = "oracle.jdbc.driver.OracleDriver";
	public static final String user = "oaprod";
	public static final String password = "oaprod";

	public Connection conn = null;
	public PreparedStatement pst = null;

	public DBUtil(String sql) throws Exception {
		try {
			Class.forName(name);// 指定连接类型
			conn = DriverManager.getConnection(url, user, password);// 获取连接
			pst = conn.prepareStatement(sql);// 准备执行语句
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public void close() {
		try {
			this.pst.close();
			this.conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

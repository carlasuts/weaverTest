package flp.inster;

import java.sql.ResultSet;
import java.sql.SQLException;

import flp.inster.DBUtil;

public class DbTest {

	static String sql = null;
	static DBUtil db1 = null;
	static ResultSet ret = null;

	public static void main(String[] args) throws Exception {
		sql = "select * from sys_task_lock";// SQL语句
		db1 = new DBUtil(sql);// 创建DBHelper对象

		try {
			ret = db1.pst.executeQuery();// 执行语句，得到结果集
			while (ret.next()) {
				String id = ret.getString(1);
				String loc = ret.getString(2);
				String date_create = ret.getString(3);
				System.out.println(id + "\t" + loc + "\t" + date_create);
			}// 显示数据
			ret.close();
			db1.close();// 关闭连接
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

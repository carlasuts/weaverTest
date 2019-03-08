<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.conn.*"%>
<%@ page import="weaver.general.Util"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="weaver.interfaces.workflow.util.DbConn"%>
<%@page import="weaver.general.BaseBean"%>
<%
	//接收传入的参数
	String matGrp5 = Util.null2String(request.getParameter("MatGrp5"));
	StringBuffer sb = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	Connection conn = null;
	BaseBean bb = new BaseBean();
	try {
		conn = DbConn.getConn("MESConn");
		
		bb.writeLog("GET_MES");
		String sql = "SELECT LOT_NO AS CUST_LOT_ID, PRODUCT AS MAT_GRP_5 FROM ETRNLOTWIP WHERE DELETE_FLAG = ' ' AND CLOSE_FLAG = ' ' AND LOT_STATUS = 'RECEIVED' AND PRODUCT LIKE ?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, "%" + matGrp5 + "%");
		rs = ps.executeQuery();

		sb = new StringBuffer();

		while (rs.next()) {
			sb.append(rs.getString(1)).append(",")
					.append(rs.getString(2)).append(";");
		}

		//去掉一个分号
		if (!"".equals(sb)) {
			sb = sb.deleteCharAt(sb.length() - 1);
		}
	} catch (Exception e) {
		bb.writeLog("GET_MES EXCEPTION:" + e);
	} finally {
		// 关闭记录集
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		// 关闭声明
		if (ps != null) {
			try {
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		// 关闭链接对象
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	out.print(sb.toString());
%>

<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@page import="weaver.general.Util" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="weaver.interfaces.workflow.util.DbConn"%>
<%
				
    	//接收传入的参数
		String matShortDesc =  Util.null2String(request.getParameter("MatShortDesc"));
    	
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null;
		String matId = null;
		StringBuffer sb = null;
		
		try {
			conn = DbConn.getConn("RPTConn");
			
			String sql = "SELECT MAT.MAT_ID FROM MWIPMATDEF MAT WHERE MAT.FACTORY = 'TEST' AND MAT.MAT_SHORT_DESC = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, matShortDesc);
			rs = ps.executeQuery();

			sb = new StringBuffer();
			
			if (rs.next()) {
				matId = rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
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

out.print(matId);
%>

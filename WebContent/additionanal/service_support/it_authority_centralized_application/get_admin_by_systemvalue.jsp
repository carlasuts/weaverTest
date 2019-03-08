<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.conn.*"%>
<%@page import="weaver.general.Util"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="weaver.interfaces.workflow.util.DbConn"%>
<%@page import="weaver.general.BaseBean"%>
<%
	//接收传入的参数
	String systemValue = Util.null2String(request.getParameter("SystemValue"));
	String factoryid = Util.null2String(request.getParameter("Factoryid"));
	StringBuffer sb = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	Connection conn = null;
	BaseBean bb = new BaseBean();
	try {
		bb.writeLog("IT_AUTHORITY_CENTRALIZED_APPLICATION IS GETTING ADMIN NOW");
		conn = DbConn.getConn("OAConn");
		
		int value = Integer.parseInt(systemValue);
		String name = null;
		if(factoryid.equals("0")){
			switch (value)
			{
				//SAP
				case 0:
					name = "SAP管理员";
					break;
				//WEE
				case 1:
					name = "WEE管理员";
					break;
				//OA
				case 2:
					name = "OA管理员";
					break;
				//MES
				case 3:
					name = "崇川MES管理员";
					break;
				//EMS
				case 4:
					name = "崇川EMS管理员";
					break;
				//FMB
				case 5:
					name = "FMB管理员";
					break;
				//无纸化
				case 6:
					name = "无纸化管理员";
					break;
				//电脑
				//case "7":
				//	name = "COMPUTER";
				//	break;
				//上网
				case 8:
					name = "上网管理员";
					break;
				//个人邮箱
				case 9:
					name = "个人邮箱管理员";
					break;
				//SKYPE
				case 10:
					name = "SKYPE管理员";
					break;
				//FTP共享文件夹
				case 11:
					name = "FTP管理员";
					break;
				//SSLVPN
				case 12:
					name = "崇川SSLVPN管理员";
					break;
				//邮件组
				case 13:
					name = "邮件组管理员";
					break;
				//REPORT
				case 14:
					name = "REPORT管理员";
					break;
				//USB
				case 15:
					name = "USB管理员";
					break;
				//远程协助
				case 16:
					name = "远程管理员";
					break;
				//服务器数据备份
				case 17:
					name = "数据备份管理员";
					break;
				//堡垒机
				case 18:
					name = "堡垒机管理员";
					break;
                                //门禁系统
				case 19:
					name = "崇川门禁管理员";
					break;
				case 20:
					name = "客户主机托管管理员";
					break;
				case 21:
					name = "文件共享管理员";
					break;
				default:
					break;
			}
		}else if(factoryid.equals("1")){
			switch (value)
			{
				//SAP
				case 0:
					name = "SAP管理员";
					break;
				//WEE
				case 1:
					name = "WEE管理员";
					break;
				//OA
				case 2:
					name = "OA管理员";
					break;
				//MES
				case 3:
					name = "苏通MES管理员";
					break;
				//EMS
				case 4:
					name = "苏通EMS管理员";
					break;
				//FMB
				case 5:
					name = "FMB管理员";
					break;
				//无纸化
				case 6:
					name = "无纸化管理员";
					break;
				//电脑
				//case "7":
				//	name = "COMPUTER";
				//	break;
				//上网
				case 8:
					name = "上网管理员";
					break;
				//个人邮箱
				case 9:
					name = "个人邮箱管理员";
					break;
				//SKYPE
				case 10:
					name = "SKYPE管理员";
					break;
				//FTP共享文件夹
				case 11:
					name = "FTP管理员";
					break;
				//SSLVPN
				case 12:
					name = "苏通SSLVPN管理员";
					break;
				//邮件组
				case 13:
					name = "邮件组管理员";
					break;
				//REPORT
				case 14:
					name = "REPORT管理员";
					break;
				//USB
				case 15:
					name = "USB管理员";
					break;
				//远程协助
				case 16:
					name = "远程管理员";
					break;
				//服务器数据备份
				case 17:
					name = "数据备份管理员";
					break;
				//堡垒机
				case 18:
					name = "堡垒机管理员";
					break;
                                //门禁系统
				case 19:
					name = "苏通门禁管理员";
					break;
				case 20:
					name = "客户主机托管管理员";
					break;
				case 21:
					name = "文件共享管理员";
					break;
				default:
					break;
			}			
					
		} else if(factoryid.equals("2")){
			switch (value)
			{
				//SAP
				case 0:
					name = "SAP管理员";
					break;
				//WEE
				case 1:
					name = "WEE管理员";
					break;
				//OA
				case 2:
					name = "OA管理员";
					break;
				//MES
				case 3:
					name = "合肥MES管理员";
					break;
				//EMS
				case 4:
					name = "合肥EMS管理员";
					break;
				//FMB
				case 5:
					name = "FMB管理员";
					break;
				//无纸化
				case 6:
					name = "无纸化管理员";
					break;
				//电脑
				//case "7":
				//	name = "COMPUTER";
				//	break;
				//上网
				case 8:
					name = "上网管理员";
					break;
				//个人邮箱
				case 9:
					name = "个人邮箱管理员";
					break;
				//SKYPE
				case 10:
					name = "SKYPE管理员";
					break;
				//FTP共享文件夹
				case 11:
					name = "FTP管理员";
					break;
				//SSLVPN
				case 12:
					name = "合肥SSLVPN管理员";
					break;
				//邮件组
				case 13:
					name = "邮件组管理员";
					break;
				//REPORT
				case 14:
					name = "REPORT管理员";
					break;
				//USB
				case 15:
					name = "USB管理员";
					break;
				//远程协助
				case 16:
					name = "远程管理员";
					break;
				//服务器数据备份
				case 17:
					name = "数据备份管理员";
					break;
				//堡垒机
				case 18:
					name = "堡垒机管理员";
					break;
                                //门禁系统
				case 19:
					name = "合肥门禁管理员";
					break;
				case 20:
					name = "客户主机托管管理员";
					break;
				case 21:
					name = "文件共享管理员";
					break;
				default:
					break;
			}			
		}
		String sql = "SELECT HRMR.WORKCODE, HRMR.LASTNAME, HRMR.ID FROM HRMRESOURCE HRMR INNER JOIN HRMROLEMEMBERS MEMS ON MEMS.RESOURCEID = HRMR.ID INNER JOIN HRMROLES RS ON MEMS.ROLEID = RS.ID WHERE RS.ROLESMARK = ?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, name);
		rs = ps.executeQuery();

		sb = new StringBuffer();

		if (rs.next()) {
			sb.append(rs.getString(1)).append(";").append(rs.getString(2)).append(";").append(rs.getString(3));
		}
	} catch (Exception e) {
		bb.writeLog("IT_AUTHORITY_CENTRALIZED_APPLICATION ADMIN EXCEPTION:" + e);
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
		bb.writeLog("IT_AUTHORITY_CENTRALIZED_APPLICATION ADMIN END");
	}

	out.print(sb.toString());
%>

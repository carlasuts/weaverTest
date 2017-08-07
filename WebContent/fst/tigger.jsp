<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>

<%
	int userId = user.getUID();
	String HOLD_CODE_DESC = "";
	String HOLD_COMMENT = "";
	String TRAN_TIME = "";
	String OPER = "";
	String USER_ID = "";
	String ID = "";
	String LOT_ID = "";
	String MAT_ID = "";
	String sql = "";
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	RecordSet rs = new RecordSet();
	RecordSet rs1 = new RecordSet();
	sql = "select ID,HOLD_CODE_DESC, HOLD_COMMENT, LOT_ID, MAT_ID, TRAN_TIME, OPER, USER_ID, FLAG from ZZYC_MIDDLE where flag = 0";
	rs.executeSql(sql);
	while(rs.next()){
		HOLD_CODE_DESC = rs.getString("HOLD_CODE_DESC");
		HOLD_COMMENT = rs.getString("HOLD_COMMENT");
		TRAN_TIME = rs.getString("TRAN_TIME");
		OPER = rs.getString("OPER");
		USER_ID = rs.getString("USER_ID");
		ID = rs.getString("ID");
		LOT_ID = rs.getString("LOT_ID");
		MAT_ID = rs.getString("MAT_ID");
		
		TRAN_TIME = TRAN_TIME.substring(0,4) + "-" + TRAN_TIME.substring(4,6) + "-" + TRAN_TIME.substring(6,8);
		
		sql = "select id from hrmresource where workcode = '" + USER_ID + "'";
		rs1.executeSql(sql);
		rs1.next();
		USER_ID = rs1.getString("id");
		
		RequestInfo requestInfo = new RequestInfo();
		MainTableInfo mainTableInfo = new MainTableInfo();
		
		Property[] propertyArray = new Property[6];
		propertyArray[0] = new Property();
		propertyArray[0].setName("jianm");
		propertyArray[0].setValue(HOLD_CODE_DESC);
		
		propertyArray[1] = new Property();
		propertyArray[1].setName("ycms");
		propertyArray[1].setValue(HOLD_COMMENT);
		
		propertyArray[2] = new Property();
		propertyArray[2].setName("faxr");
		propertyArray[2].setValue(TRAN_TIME);
		
		propertyArray[3] = new Property();
		propertyArray[3].setName("fxgx");
		propertyArray[3].setValue(OPER);
		
		propertyArray[4] = new Property();
		propertyArray[4].setName("ddz");
		propertyArray[4].setValue(USER_ID);
		
		propertyArray[5] = new Property();
		propertyArray[5].setName("tiggerid");
		propertyArray[5].setValue(ID);
		
		mainTableInfo.setProperty(propertyArray);
		
		requestInfo.setCreatorid(USER_ID);
		requestInfo.setWorkflowid("65");
		requestInfo.setDescription("制造异常处理流程-" + TRAN_TIME + "(MES自动触发)");
		
		requestInfo.setMainTableInfo(mainTableInfo);
		RequestService service = new RequestService();//创建请求服务实例
		String newRequestid = service.createRequest(requestInfo);  
		
		//get mainid
		sql = "select id from formtable_main_3 where requestid = " + newRequestid;
		rs1.executeSql(sql);
		rs1.next();
		String mainid = rs1.getString("id");
		//insert detail
		sql = "insert into formtable_main_3_dt1 (mainid,lotid,xingh) values(";
		sql += mainid;
		sql += "'" + LOT_ID + "',";
		sql += "'" + MAT_ID + "')";
		//set middle flag
		sql = "update ZZYC_MIDDLE set FLAG = 1 where id = " + ID;
		rs1.executeSql(sql);
		
		out.print("newRequestid:" + newRequestid + "<br>");
	}
%>
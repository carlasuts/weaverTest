package weaver.interfaces.sap;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class ZMMI051INSERT {

	public void zmmi051insert(DetailTable dt, MainTableInfo maintableinfo,
			String rid) {

		BaseBean baseBean = new BaseBean();
		String MANDT = ""; // ���� �̶�ֵ 800
		String HEADID = "";// ͷ��ID
		String MATNR = "";// ���Ϻ�
		String KLART = "";// �������
		String CLASS = "";// ���
		String IT_HEADID = "";// ITEM����ͷ��ID
		String CHARACT = "";// ��������
		String VALUE = "";// ����ֵ
		String ATFOR = "";// ����ֵ��������

		String TOPMARTFORMATON = "";// �����ӡͼ��
		String BACKMARTFORMATON = "";// �����ӡͼ��
		String TESTCUSTOMERMTRLCODE = "";// ���Կͻ�Ʒ��

		String DIEATTACHTRAIT = ""; // װƬ����
		String MARK1 = "";// MARK1
		String MARK2 = "";// MARK2
		String MARK3 = "";// MARK3
		String MARK4 = "";// MARK4

		String MARK5 = "";// MARK5
		String PACKAGEOUTLINE = "";// ��װ����
		String OUTDEVICE = "";// ��װƷ��
		String ASSYCUSTOMERMTRLCODE = "";// �ͻ�Ʒ��
		String VEHICLE = "";// ����Ʒ
		String PRODUCETYPE = "";// ��������
		String WIREBONDDIAGNO = "";// ����ͼ��

		String requestid = rid;
		String nodeid = "";
		RecordSet rs = new RecordSet();
		try {

			Property[] Property = maintableinfo.getProperty();
			String id;
			for (int ss = 0; ss < Property.length; ++ss) {
				String dataDB = Property[ss].getName().toUpperCase();
				id = Util.null2String(Property[ss].getValue());
				if (dataDB.equals("MANDT")) {
					MANDT = id;
				}
				if (dataDB.equals("MATNR")) {
					MATNR = id;
				}

				if (dataDB.equals("HEADID")) {
					HEADID = id;
				}
				if (dataDB.equals("KLART")) {
					KLART = id;
				}

				if (dataDB.equals("CLASS")) {
					CLASS = id;
				}
				if (dataDB.equals("IT_HEADID")) {
					IT_HEADID = id;
				}
				if (dataDB.equals("CHARACT")) {
					CHARACT = id;
				}
				if (dataDB.equals("VALUE")) {
					VALUE = id;
				}
				if (dataDB.equals("ATFOR")) {
					ATFOR = id;
				}
				if (dataDB.equals("TOPMARTFORMATON")) {
					TOPMARTFORMATON = id;
				}
				if (dataDB.equals("BACKMARTFORMATON")) {
					BACKMARTFORMATON = id;
				}
				if (dataDB.equals("ASSYCUSTOMERMTRLCODE")) {
					ASSYCUSTOMERMTRLCODE = id;
				}
				if (dataDB.equals("DIEATTACHTRAIT")) {
					DIEATTACHTRAIT = id;
				}
				if (dataDB.equals("MARK1")) {
					MARK1 = id;
				}
				if (dataDB.equals("MARK2")) {
					MARK2 = id;
				}
				if (dataDB.equals("MARK3")) {
					MARK3 = id;
				}
				if (dataDB.equals("MARK4")) {
					MARK4 = id;
				}
				if (dataDB.equals("MARK5")) {
					MARK5 = id;
				}
				if (dataDB.equals("PACKAGEOUTLINE")) {
					PACKAGEOUTLINE = id;
				}
				if (dataDB.equals("OUTDEVICE")) {
					OUTDEVICE = id;
				}
				if (dataDB.equals("TESTCUSTOMERMTRLCODE")) {
					TESTCUSTOMERMTRLCODE = id;
				}
				if (dataDB.equals("VEHICLE")) {
					VEHICLE = id;
				}
				if (dataDB.equals("PRODUCETYPE")) {
					PRODUCETYPE = id;
				}
				if (dataDB.equals("WIREBONDDIAGNO")) {
					WIREBONDDIAGNO = id;
				}
			}
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyyMMddHHmmss");
			String udpatetime = sdf.format(date);
			String createtime = sdf.format(date);
			UUID uuid = UUID.randomUUID();
			String sql = "";
			if (MATNR.substring(0, 1).equals("A")) {

				sql = " insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'1002',"
						+ "'"
						+ MATNR
						+ "',"
						+ "'022','Z_FERT_BCH',"
						+ "'0',' ',' ',' ',"
						+ "'"
						+ createtime
						+ "',"
						+ "'"
						+ udpatetime + "'" + ")";

				rs.executeSql(sql);

				sql = " insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'2',"
						+ "'"
						+ MATNR
						+ "',"
						+ "'001','Z_FERT_MTL',"
						+ "'0',' ',' ',' ',"
						+ "'"
						+ createtime
						+ "',"
						+ "'"
						+ udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = " insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_DRAW_NO',"
						+ "'"
						+ TOPMARTFORMATON
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_FD',"
						+ "'"
						+ TESTCUSTOMERMTRLCODE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime + "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = " insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_GD',"
						+ "'"
						+ DIEATTACHTRAIT
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_LEAD','0',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'"
						+ udpatetime + "'" + ")";
				rs.executeSql(sql);
				// ������ϸ
				String DIEMATERIALCODE = "";
				String CHIPQTY = "";
				Row[] s = dt.getRow();
				for (int j = 0; j < s.length; j++) {
					Row r = s[j];// ָ����
					Cell c[] = r.getCell();// ÿ�������ٰ��д洢
					for (int k = 0; k < c.length; k++) {
						Cell c1 = c[k];// ָ����
						String name = c1.getName().toUpperCase();// ��ϸ�ֶ�����
						String value = Util.null2String(c1.getValue());// ��ϸ�ֶε�ֵ
						if (name.equals("DIEMATERIALCODE")) {
							DIEMATERIALCODE = value;
						}
						if (name.equals("CHIPQTY")) {
							CHIPQTY = value;
						}

					}
					sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
							+ "'"
							+ requestid
							+ "',"
							+ "'"
							+ nodeid
							+ "'"
							+ ",'"
							+ MANDT
							+ "',"
							+ "'"
							+ uuid
							+ "',"
							+ "'0'"
							+ ","
							+ "'0',"
							+ "'"
							+ MATNR
							+ "',"
							+ "' ',' ',"
							+ "'2','Z_MAIN_CHIP_NO',"
							+ "'"
							+ DIEMATERIALCODE
							+ "',"
							+ "'CHAR',"
							+ "'"
							+ createtime
							+ "',"
							+ "'"
							+ udpatetime + "'" + ")";
					rs.executeSql(sql);
					sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
							+ "'"
							+ requestid
							+ "',"
							+ "'"
							+ nodeid
							+ "'"
							+ ",'"
							+ MANDT
							+ "',"
							+ "'"
							+ uuid
							+ "',"
							+ "'0'"
							+ ","
							+ "'0',"
							+ "'"
							+ MATNR
							+ "',"
							+ "' ',' ',"
							+ "'2','Z_MAIN_CHIP_QTY',"
							+ "'"
							+ CHIPQTY
							+ "',"
							+ "'CHAR',"
							+ "'"
							+ createtime
							+ "',"
							+ "'"
							+ udpatetime + "'" + ")";
					rs.executeSql(sql);
				}

				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_MAP',"
						+ "'"
						+ DIEATTACHTRAIT
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_MARK1',"
						+ "'"
						+ MARK1
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_MARK2',"
						+ "'"
						+ MARK2
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_MARK3',"
						+ "'"
						+ MARK3
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_MARK4',"
						+ "'"
						+ MARK4
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_MARK5',"
						+ "'"
						+ MARK5
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_PACKAGE',"
						+ "'"
						+ PACKAGEOUTLINE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_PACK_TYPE',"
						+ "'"
						+ OUTDEVICE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_PD',"
						+ "'"
						+ ASSYCUSTOMERMTRLCODE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime + "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_PROD_ID',"
						+ "'"
						+ VEHICLE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_PROD_TYPE',"
						+ "'"
						+ PRODUCETYPE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime + "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_TEST_PACK_NAME',"
						+ "'"
						+ OUTDEVICE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'2','Z_WIR_DIA_NO',"
						+ "'"
						+ WIREBONDDIAGNO
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime + "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
			} else if (MATNR.substring(0, 1).equals("T")) {
				sql = " insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'1001',"
						+ "'"
						+ MATNR
						+ "',"
						+ "'022','Z_FERT_BCH',"
						+ "'0',' ',' ',' ',"
						+ "'"
						+ createtime
						+ "',"
						+ "'"
						+ udpatetime + "'" + ")";
				rs.executeSql(sql);

				sql = " insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'1',"
						+ "'"
						+ MATNR
						+ "',"
						+ "'001','Z_FERT_MTL',"
						+ "'0',' ',' ',' ',"
						+ "'"
						+ createtime
						+ "',"
						+ "'"
						+ udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = " insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_DRAW_NO',"
						+ "'"
						+ TOPMARTFORMATON
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_FD',"
						+ "'"
						+ TESTCUSTOMERMTRLCODE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime + "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = " insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_GD',"
						+ "'"
						+ DIEATTACHTRAIT
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_LEAD','0',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'"
						+ udpatetime + "'" + ")";
				rs.executeSql(sql);
				// ������ϸ
				String DIEMATERIALCODE = "";
				String CHIPQTY = "";
				Row[] s = dt.getRow();
				for (int j = 0; j < s.length; j++) {
					Row r = s[j];// ָ����
					Cell c[] = r.getCell();// ÿ�������ٰ��д洢
					for (int k = 0; k < c.length; k++) {
						Cell c1 = c[k];// ָ����
						String name = c1.getName().toUpperCase();// ��ϸ�ֶ�����
						String value = Util.null2String(c1.getValue());// ��ϸ�ֶε�ֵ
						if (name.equals("DIEMATERIALCODE")) {
							DIEMATERIALCODE = value;
						}
						if (name.equals("CHIPQTY")) {
							CHIPQTY = value;
						}

					}
					sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
							+ "'"
							+ requestid
							+ "',"
							+ "'"
							+ nodeid
							+ "'"
							+ ",'"
							+ MANDT
							+ "',"
							+ "'"
							+ uuid
							+ "',"
							+ "'0'"
							+ ","
							+ "'0',"
							+ "'"
							+ MATNR
							+ "',"
							+ "' ',' ',"
							+ "'1','Z_MAIN_CHIP_NO',"
							+ "'"
							+ DIEMATERIALCODE
							+ "',"
							+ "'CHAR',"
							+ "'"
							+ createtime
							+ "',"
							+ "'"
							+ udpatetime + "'" + ")";
					rs.executeSql(sql);
					sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
							+ "'"
							+ requestid
							+ "',"
							+ "'"
							+ nodeid
							+ "'"
							+ ",'"
							+ MANDT
							+ "',"
							+ "'"
							+ uuid
							+ "',"
							+ "'0'"
							+ ","
							+ "'0',"
							+ "'"
							+ MATNR
							+ "',"
							+ "' ',' ',"
							+ "'1','Z_MAIN_CHIP_QTY',"
							+ "'"
							+ CHIPQTY
							+ "',"
							+ "'CHAR',"
							+ "'"
							+ createtime
							+ "',"
							+ "'"
							+ udpatetime + "'" + ")";
					rs.executeSql(sql);
				}

				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_MAP',"
						+ "'"
						+ DIEATTACHTRAIT
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_MARK1',"
						+ "'"
						+ MARK1
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_MARK2',"
						+ "'"
						+ MARK2
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_MARK3',"
						+ "'"
						+ MARK3
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_MARK4',"
						+ "'"
						+ MARK4
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_MARK5',"
						+ "'"
						+ MARK5
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_PACKAGE',"
						+ "'"
						+ PACKAGEOUTLINE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_PACK_TYPE',"
						+ "'"
						+ OUTDEVICE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_PD',"
						+ "'"
						+ ASSYCUSTOMERMTRLCODE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime + "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_PROD_ID',"
						+ "'"
						+ VEHICLE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "',"
						+ "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_PROD_TYPE',"
						+ "'"
						+ PRODUCETYPE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime + "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_TEST_PACK_NAME',"
						+ "'"
						+ OUTDEVICE
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime
						+ "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
				sql = "  insert into zmmi05101 (requestid,nodeid,mandt,z_wee_id,zweestauts,headid,matnr,klart,class,it_headid,charact,value,atfor,createtime,updatetime) values ("
						+ "'"
						+ requestid
						+ "',"
						+ "'"
						+ nodeid
						+ "'"
						+ ",'"
						+ MANDT
						+ "',"
						+ "'"
						+ uuid
						+ "',"
						+ "'0'"
						+ ","
						+ "'0',"
						+ "'"
						+ MATNR
						+ "',"
						+ "' ',' ',"
						+ "'1','Z_WIR_DIA_NO',"
						+ "'"
						+ WIREBONDDIAGNO
						+ "',"
						+ "'CHAR',"
						+ "'"
						+ createtime + "'," + "'" + udpatetime + "'" + ")";
				rs.executeSql(sql);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		/*
		 * Map<String, String> map = new HashMap<String, String>();
		 * map.put("MANDT",MANDT ); map.put("HEADID", HEADID); map.put("KLART",
		 * KLART); map.put("CLASS",CLASS ); map.put("IT_HEADID", IT_HEADID);
		 * map.put("CHARACT", CHARACT); map.put("VALUE",VALUE );
		 * map.put("ATFOR", ATFOR);
		 */

	}
}

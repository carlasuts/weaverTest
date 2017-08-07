package weaver.interfaces.workflow.action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.soa.workflow.request.RequestInfo;

public class FSTWF1186POSNR implements Action {
	public FSTWF1186POSNR() {
	}

	private class DetailInfo {
		private String id;
		private String matType;
		private String posnr;

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getMatType() {
			return matType;
		}

		public void setMatType(String matType) {
			this.matType = matType;
		}

		public String getPosnr() {
			return posnr;
		}

		public void setPosnr(String posnr) {
			this.posnr = posnr;
		}

		@Override
		public int hashCode() {
			return matType == null ? 0 : matType.hashCode();
		}

		@Override
		public boolean equals(Object o) {
			if (this == o) {
				return true;
			}
			if (o == null || getClass() != o.getClass()) {
				return false;
			}
			DetailInfo di = (DetailInfo) o;
			if (matType != null ? !matType.equals(di.getMatType()) : di.getMatType() != null) {
				return false;
			}
			return true;
		}

	}

	public String execute(RequestInfo request) {
		String result = "1";
		try {
			// 日志对象
			BaseBean e = new BaseBean();
			e.writeLog("FSTWF1186POSNR start");
			String sql = "";
			String sql2 = "";
			String sql3 = "";
			String rid = request.getRequestid();

			sql = "select id from formtable_main_78 where requestid='" + rid + "'";
			RecordSet rs = new RecordSet();
			RecordSet rs2 = new RecordSet();
			RecordSet rs3 = new RecordSet();
			rs.executeSql(sql);
			e.writeLog(sql);
			rs.next();
			String mainId = rs.getString("id");
			sql = "select id,indrk from formtable_main_78_dt3 where mainid='" + mainId + "'";
			rs.executeSql(sql);
			ArrayList<DetailInfo> diList = new ArrayList<DetailInfo>();
			Set<DetailInfo> diSet = new HashSet<DetailInfo>();
			while (rs.next()) {
				DetailInfo di = new DetailInfo();
				di.setId(rs.getString("id"));
				sql2 = "select mat_type from obomsetmat where mat_id='" + rs.getString("indrk") + "'";
				rs2.executeSql(sql2);
				rs2.next();
				if("".equals(rs2.getString("mat_type"))){
					sql3 = "select mat_type_fk as mat_type from BOMINFO where mat_id = '" + rs.getString("indrk") + "'";
					rs3.executeSql(sql3);
					rs3.next();
					di.setMatType(rs3.getString("mat_type"));
				}
				else{
					di.setMatType(rs2.getString("mat_type"));
				}
				diList.add(di);
			}
			for (DetailInfo di : diList) {
				diSet.add(di);
				int postnr = diSet.size() * 10 + 10;
				di.setPosnr(String.valueOf(postnr));
				sql = "update formtable_main_78_dt3 dt3 set dt3.posnr='" + di.getPosnr() + "' where dt3.id='"
						+ di.getId() + "'";
				e.writeLog(sql);
				rs.executeSql(sql);
			}
			e.writeLog("FSTWF1186POSNR end");
		} catch (Exception var11) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF1186POSNR error:" + var11.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}

		return result;
	}
}

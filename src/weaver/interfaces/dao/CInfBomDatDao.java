package weaver.interfaces.dao;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.mes.entity.CInfBomDat;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 从表cinfbomdat中取值 放入CInfBomDat实体类中
 * 
 * @author zong.yq
 */
public class CInfBomDatDao implements Action {

	private CInfBomDat cInfBomDat = new CInfBomDat();

	public String execute(RequestInfo request) {
		BaseBean baseBean = new BaseBean();
		RecordSet recordSet = new RecordSet();
		String sql = "";
		String requestId = request.getRequestid();
		sql = "select * from cinfbomdat where requestid = " + requestId;
		baseBean.writeLog("查询cinfbomdat表中的值");
		recordSet.executeSql(sql);
		recordSet.next();

		cInfBomDat.setInfTime(recordSet.getString("INF_TIME"));
		cInfBomDat.setInfSeq(Integer.valueOf(recordSet.getString("INF_SEQ")));
		cInfBomDat.setMatnr(recordSet.getString("MATNR"));
		cInfBomDat.setWerks(recordSet.getString("WERKS"));
		cInfBomDat.setPlnnr(recordSet.getString("PLNNR"));
		cInfBomDat.setPlnal(recordSet.getString("PLNAL"));
		cInfBomDat.setPlnfl(recordSet.getString("PLNFL"));
		cInfBomDat.setVornr(recordSet.getString("VORNR"));
		cInfBomDat.setIdnrk(recordSet.getString("IDNRK"));
		cInfBomDat.setPosnr(recordSet.getString("POSNR"));
		cInfBomDat.setStlan(recordSet.getString("STLAN"));
		cInfBomDat.setStlal(recordSet.getString("STLAL"));
		cInfBomDat.setReadFlag(recordSet.getString("READ_FLAG"));
		cInfBomDat.setInfMsg(recordSet.getString("INF_MSG"));
		cInfBomDat.setInfFlag(recordSet.getString("INF_FLAG"));
		cInfBomDat.setCmf1(recordSet.getString("CMF_1"));
		cInfBomDat.setCmf2(recordSet.getString("CMF_2"));
		cInfBomDat.setCmf3(recordSet.getString("CMF_3"));
		cInfBomDat.setCmf4(recordSet.getString("CMF_4"));
		cInfBomDat.setCmf5(recordSet.getString("CMF_5"));
		cInfBomDat.setCmf6(recordSet.getString("CMF_6"));
		cInfBomDat.setCmf7(recordSet.getString("CMF_7"));
		cInfBomDat.setCmf8(recordSet.getString("CMF_8"));
		cInfBomDat.setCmf9(recordSet.getString("CMF_9"));
		cInfBomDat.setCmf10(recordSet.getString("CMF_10"));
		cInfBomDat.setDeleteFlag(recordSet.getString("DELETE_FLAG"));
		cInfBomDat.setCreateTime(recordSet.getString("CREATE_TIME"));
		cInfBomDat.setCreateUserId(recordSet.getString("CREATE_USER_ID"));
		cInfBomDat.setUpdateTime(recordSet.getString("UPDATE_TIME"));
		cInfBomDat.setUpdateUserId(recordSet.getString("UPDATE_USER_ID"));
		cInfBomDat.setDeleteTime(recordSet.getString("DELETE_TIME"));
		cInfBomDat.setDeleteUserId(recordSet.getString("DELETE_USER_ID"));

		return null;
	}

}

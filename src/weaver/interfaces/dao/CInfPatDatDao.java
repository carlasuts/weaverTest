package weaver.interfaces.dao;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.mes.entity.CInfPatDat;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 从表cinfpatdat中取值 放入CInfPatDat实体类中
 * 
 * @author zong.yq
 */
public class CInfPatDatDao implements Action {

	private CInfPatDat cInfPatDat = new CInfPatDat();

	@Override
	public String execute(RequestInfo request) {
		BaseBean baseBean = new BaseBean();
		RecordSet recordSet = new RecordSet();
		String sql = "";
		String requestId = request.getRequestid();
		sql = "select * from cinfpatdat where requestid = " + requestId;
		baseBean.writeLog("查询cinfpatdat表中的值");
		recordSet.executeSql(sql);
		recordSet.next();

		cInfPatDat.setInfTime(recordSet.getString("INF_TIME"));
		cInfPatDat.setInfSeq(Integer.valueOf(recordSet.getString("INF_SEQ")));
		cInfPatDat.setMatnr(recordSet.getString("MATNR"));
		cInfPatDat.setWerks(recordSet.getString("WERKS"));
		cInfPatDat.setStlan(recordSet.getString("STLAN"));
		cInfPatDat.setStlal(recordSet.getString("STLAL"));
		cInfPatDat.setPlnnr(recordSet.getString("PLNNR"));
		cInfPatDat.setPosnr(recordSet.getString("POSNR"));
		cInfPatDat.setIdnrk(recordSet.getString("IDNRK"));
		cInfPatDat.setMenge(recordSet.getString("MENGE"));
		cInfPatDat.setMeins(recordSet.getString("MEINS"));
		cInfPatDat.setAusch(recordSet.getString("AUSCH"));
		cInfPatDat.setAlpgr(recordSet.getString("ALPGR"));
		cInfPatDat.setAlprf(recordSet.getString("ALPRF"));
		cInfPatDat.setAlpst(recordSet.getString("ALPST"));
		cInfPatDat.setEwahr(recordSet.getString("EWAHR"));
		cInfPatDat.setItsob(recordSet.getString("ITSOB"));
		cInfPatDat.setLgort(recordSet.getString("LGORT"));
		cInfPatDat.setSanka(recordSet.getString("SANKA"));
		cInfPatDat.setReadFlag(recordSet.getString("READ_FLAG"));
		cInfPatDat.setInfMsg(recordSet.getString("INF_MSG"));
		cInfPatDat.setInfFlag(recordSet.getString("INF_FLAG"));
		cInfPatDat.setCmf1(recordSet.getString("CMF_1"));
		cInfPatDat.setCmf2(recordSet.getString("CMF_2"));
		cInfPatDat.setCmf3(recordSet.getString("CMF_3"));
		cInfPatDat.setCmf4(recordSet.getString("CMF_4"));
		cInfPatDat.setCmf5(recordSet.getString("CMF_5"));
		cInfPatDat.setCmf6(recordSet.getString("CMF_6"));
		cInfPatDat.setCmf7(recordSet.getString("CMF_7"));
		cInfPatDat.setCmf8(recordSet.getString("CMF_8"));
		cInfPatDat.setCmf9(recordSet.getString("CMF_9"));
		cInfPatDat.setCmf10(recordSet.getString("CMF_10"));
		cInfPatDat.setDeleteFlag(recordSet.getString("DELETE_FLAG"));
		cInfPatDat.setCreateTime(recordSet.getString("CREATE_TIME"));
		cInfPatDat.setCreateUserId(recordSet.getString("CREATE_USER_ID"));
		cInfPatDat.setUpdateTime(recordSet.getString("UPDATE_TIME"));
		cInfPatDat.setUpdateUserId(recordSet.getString("UPDATE_USER_ID"));
		cInfPatDat.setDeleteTime(recordSet.getString("DELETE_TIME"));
		cInfPatDat.setDeleteUserId(recordSet.getString("DELETE_USER_ID"));

		return null;
	}

}

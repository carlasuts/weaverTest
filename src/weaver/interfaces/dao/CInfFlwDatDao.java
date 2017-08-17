package weaver.interfaces.dao;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.mes.entity.CInfFlwDat;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 从表cinfflwdat中取值 放入CInfFlwDat实体类中
 * 
 * @author zong.yq
 */
public class CInfFlwDatDao implements Action {

	private CInfFlwDat cInfFlwDat = new CInfFlwDat();

	@Override
	public String execute(RequestInfo request) {
		BaseBean baseBean = new BaseBean();
		RecordSet recordSet = new RecordSet();
		String sql = "";
		String requestId = request.getRequestid();
		sql = "select * from cinfflwdat where requestid = " + requestId;
		baseBean.writeLog("查询cinfflwdat表中的值");
		recordSet.executeSql(sql);
		recordSet.next();

		cInfFlwDat.setInfTime(recordSet.getString("INF_TIME"));
		cInfFlwDat.setInfSeq(Integer.valueOf(recordSet.getString("INF_SEQ")));
		cInfFlwDat.setMatnr(recordSet.getString("MATNR"));
		cInfFlwDat.setWerks(recordSet.getString("WERKS"));
		cInfFlwDat.setPlnnr(recordSet.getString("PLNNR"));
		cInfFlwDat.setPlnal(recordSet.getString("PLNAL"));
		cInfFlwDat.setPlnfl(recordSet.getString("PLNFL"));
		cInfFlwDat.setVornr(recordSet.getString("VORNR"));
		cInfFlwDat.setArbpl(recordSet.getString("ARBPL"));
		cInfFlwDat.setSteus(recordSet.getString("STEUS"));
		cInfFlwDat.setKtsch(recordSet.getString("KTSCH"));
		cInfFlwDat.setLtxa1(recordSet.getString("LTXA1"));
		cInfFlwDat.setVgw01(recordSet.getString("VGW01"));
		cInfFlwDat.setVgw02(recordSet.getString("VGW02"));
		cInfFlwDat.setVgw03(recordSet.getString("VGW03"));
		cInfFlwDat.setVgw04(recordSet.getString("VGW04"));
		cInfFlwDat.setVgw05(recordSet.getString("VGW05"));
		cInfFlwDat.setVgw06(recordSet.getString("VGW06"));
		cInfFlwDat.setInfnr(recordSet.getString("INFNR"));
		cInfFlwDat.setEkorg(recordSet.getString("EKORG"));
		cInfFlwDat.setSakto(recordSet.getString("SAKTO"));
		cInfFlwDat.setBmsch(recordSet.getString("BMSCH"));
		cInfFlwDat.setUemus(recordSet.getString("UEMUS"));
		cInfFlwDat.setMinwe(recordSet.getString("MINWE"));
		cInfFlwDat.setSpmus(recordSet.getString("SPMUS"));
		cInfFlwDat.setSplim(recordSet.getString("SPLIM"));
		cInfFlwDat.setUmrez(recordSet.getString("UMREZ"));
		cInfFlwDat.setMeinh(recordSet.getString("MEINH"));
		cInfFlwDat.setReadFlag(recordSet.getString("READ_FLAG"));
		cInfFlwDat.setInfMsg(recordSet.getString("INF_MSG"));
		cInfFlwDat.setInfFlag(recordSet.getString("INF_FLAG"));
		cInfFlwDat.setCmf1(recordSet.getString("CMF_1"));
		cInfFlwDat.setCmf2(recordSet.getString("CMF_2"));
		cInfFlwDat.setCmf3(recordSet.getString("CMF_3"));
		cInfFlwDat.setCmf4(recordSet.getString("CMF_4"));
		cInfFlwDat.setCmf5(recordSet.getString("CMF_5"));
		cInfFlwDat.setCmf6(recordSet.getString("CMF_6"));
		cInfFlwDat.setCmf7(recordSet.getString("CMF_7"));
		cInfFlwDat.setCmf8(recordSet.getString("CMF_8"));
		cInfFlwDat.setCmf9(recordSet.getString("CMF_9"));
		cInfFlwDat.setCmf10(recordSet.getString("CMF_10"));
		cInfFlwDat.setDeleteFlag(recordSet.getString("DELETE_FLAG"));
		cInfFlwDat.setCreateTime(recordSet.getString("CREATE_TIME"));
		cInfFlwDat.setCreateUserId(recordSet.getString("CREATE_USER_ID"));
		cInfFlwDat.setUpdateTime(recordSet.getString("UPDATE_TIME"));
		cInfFlwDat.setUpdateUserId(recordSet.getString("UPDATE_USER_ID"));
		cInfFlwDat.setDeleteTime(recordSet.getString("DELETE_TIME"));
		cInfFlwDat.setDeleteUserId(recordSet.getString("DELETE_USER_ID"));

		return null;
	}

}

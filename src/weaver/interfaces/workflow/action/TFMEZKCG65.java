//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package weaver.interfaces.workflow.action;

import weaver.general.BaseBean;
import weaver.interfaces.mes.cc.OaToMes_ZKCG_Action_CC;
import weaver.interfaces.mes.hf.OaToMes_ZKCG_Action_HF;
import weaver.interfaces.mes.st.OaToMes_ZKCG_Action_ST;
import weaver.interfaces.sap.OAToSAP_ZKCG65;
import weaver.interfaces.workflowUtil.BillFieldUtil;
import weaver.soa.workflow.request.RequestInfo;

public class TFMEZKCG65 implements Action {

	private static int workflowid = 0;

	public String execute(RequestInfo request) {

		try {
			BaseBean e = new BaseBean();

			e.writeLog("workflowid��" + request.getWorkflowid());
			
			workflowid = Integer.valueOf(request.getWorkflowid());// ����workflow_base�е�ID��ȷ������ 7102���紨  7103����ͨ  7105���Ϸ�
			
			e.writeLog("ת���ӿ�action��ʼִ��");

			String rid = request.getRequestid();
			String table = "ZWEE_MM65";
			OAToSAP_ZKCG65 zw = new OAToSAP_ZKCG65(table, rid, BillFieldUtil.getMainTable(request));
			// ��ϸ��2������
			String[] status = new String[1];
			zw.ZWEE_MM65(BillFieldUtil.getDetailTable(request, 1), request, status);
			e.writeLog("ZWEE_MM65�ӿ����ݴ���");
			e.writeLog("end");

			if (status[0].equals("S")) {
				e.writeLog("***��ʼִ����MES�б��ϲ���***");
				if (workflowid == 7102) {
					e.writeLog("***OaToMes_ZKCG_Post_CC��ʼִ��***");
					OaToMes_ZKCG_Action_CC oaToMes_ZKCG_Action_CC = new OaToMes_ZKCG_Action_CC();
					e.writeLog("��ʼִ�г紨����OaToMes_ZKCG_Post�ڵ�oaToMes����");
					oaToMes_ZKCG_Action_CC.oaToMes(request);
				} else if (workflowid == 7103) {
					e.writeLog("***OaToMes_ZKCG_Post_ST��ʼִ��***");
					OaToMes_ZKCG_Action_ST oaToMes_ZKCG_Action_ST = new OaToMes_ZKCG_Action_ST();
					e.writeLog("��ʼִ����ͨ����OaToMes_ZKCG_Post�ڵ�oaToMes����");
					oaToMes_ZKCG_Action_ST.oaToMes(request);
				} else {
					e.writeLog("***OaToMes_ZKCG_Post_HF��ʼִ��***");
					OaToMes_ZKCG_Action_HF oaToMes_ZKCG_Action_HF = new OaToMes_ZKCG_Action_HF();
					e.writeLog("��ʼִ�кϷʳ���OaToMes_ZKCG_Post�ڵ�oaToMes����");
					oaToMes_ZKCG_Action_HF.oaToMes(request);
				}
			}

		} catch (Exception var11) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("TFMEZKCG65 error:" + var11.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
			request.getRequestManager().setMessageid("Exception");
			request.getRequestManager().setMessagecontent("ת���ʧ�ܣ�����ϵ����Ա:" + var11.getMessage());
		}

		return Action.SUCCESS;
	}
}

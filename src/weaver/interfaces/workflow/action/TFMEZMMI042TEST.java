package weaver.interfaces.workflow.action;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.*;

import java.text.SimpleDateFormat;
import java.util.*;
import weaver.interfaces.sap.ZMMI042;

public class TFMEZMMI042TEST implements Action {

	@Override
	public String execute(RequestInfo request) {
		String result = "";
		try {
			// ��־����
			BaseBean e = new BaseBean();
			// ��ȡ����������Ϣ����
			MainTableInfo maintableinfo = request.getMainTableInfo();

			String sql = "";
			Date d = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nd = sf.format(d);
			// ��ȡ���̵�����id
			String rid = request.getRequestid();
			// ��ȡ������ϸ����Ϣ����
			DetailTable[] detailtable = request.getDetailTableInfo().getDetailTable();
			ZMMI042 zm042 = new ZMMI042();
			// ����sap�ӿ�
			zm042.gylx(maintableinfo,rid);
			
			// ��������������ύ
			request.getRequestManager().setMessagecontent("�����ʲ���������");
			request.getRequestManager().setMessageid("1022");
			
		} catch (Exception var11) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("TFMEZMMI042TEST error:" + var11.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return result;
	}

}

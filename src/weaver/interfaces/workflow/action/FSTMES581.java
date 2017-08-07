package weaver.interfaces.workflow.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.text.*;
import java.math.*;

import weaver.conn.*;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.Row;
import weaver.general.BaseBean;

public class FSTMES581 implements Action {
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			String id = "";
			String sql = "";
			Property[] properties = request.getMainTableInfo().getProperty();// ��ȡ�����ֶ���Ϣ
			for (int i = 0; i < properties.length; i++) {// ��������
				String name = properties[i].getName().toUpperCase();//�ֶ���
				String value = Util.null2String(properties[i].getValue());//ֵ
				//ID
				if(name.equals("TIGGERID")){
					id = value;
				}
			

			}
			
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
			String udpatetime = sdf.format(date);
			String workcode = "";
			//�������ҪTE�ٴ��ã������±�
			RecordSet rs = new RecordSet();
			
		}
		catch(java.lang.Exception e){
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTMES581 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}

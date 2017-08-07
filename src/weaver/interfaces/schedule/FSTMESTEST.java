package weaver.interfaces.schedule;

import java.util.*;
import java.text.*;
import java.math.*;

import weaver.conn.*;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.*;
import weaver.general.BaseBean;

public class FSTMESTEST extends BaseCronJob {
	public void execute() {
		BaseBean bs = new BaseBean();
		try	{
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String date = sdf.format(d);
			bs.writeLog("date:" + date);
		}
		catch (Exception e) {
			bs.writeLog("FSTMESTEST:" + e);
		}	 
	}
}

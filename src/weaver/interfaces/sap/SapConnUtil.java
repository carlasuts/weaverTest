package weaver.interfaces.sap;

import com.sap.mw.jco.JCO;

/**
 * Created by Administrator on 2017/2/8.
 */
public class SapConnUtil {

    public static JCO.Client getconn(){
        String  POOL_NAME="Pool";
        String sapclient = "800";
        String userid = "OASAP";
        String password = "abc1234";
        String hostname = "172.16.20.56";
        String systemnumber = "00";
        String Language = "ZH";
        JCO.Pool pool = null;
        int maxconn = 100;

        pool = JCO.getClientPoolManager().getPool(POOL_NAME);
        if(pool == null) {
            JCO.addClientPool(POOL_NAME, maxconn, sapclient, userid, password, Language, hostname, systemnumber);
        }
        //获取连接
        JCO.Client sapconnection = JCO.getClient(POOL_NAME);
        return  sapconnection;
    }
}

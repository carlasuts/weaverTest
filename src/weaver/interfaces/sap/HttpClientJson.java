package weaver.interfaces.sap;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import weaver.general.BaseBean;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class HttpClientJson {

	public static String readInterfacePost(String detailUrl, String str) {
		HttpClient client = new HttpClient();
		BaseBean baseBean = new BaseBean();
		final PostMethod post = new PostMethod(detailUrl);
		try {
			// post.setRequestHeader("User-Agent",
			// "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0");
			final RequestEntity re = new StringRequestEntity(str, "application/json", "UTF-8");
			post.setRequestEntity(re);
			baseBean.writeLog("client开始" + new Date());
			client.executeMethod(post);
			String emsReturn = post.getResponseBodyAsString();
			baseBean.writeLog("client结束" + new Date());
			return emsReturn;
		} catch (final Exception e) {
			e.printStackTrace();
			baseBean.writeLog("client结束" + new Date());
		} finally {
			post.releaseConnection();
		}
		return null;
	}

    public static String readInterfaceGet() {
	    HttpClient client = new HttpClient();
	    BaseBean baseBean = new BaseBean();
	    // 创建参数队列
        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("username", "OAUser"));
        params.add(new BasicNameValuePair("password", "OAUser"));

        try {
            // 参数转换为字符串
            String paramStr = EntityUtils.toString(new UrlEncodedFormEntity(params, "UTF-8"));
            String url = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/SalesQuoteCollection?$filter=ID%20eq%20'31'&$expand=SalesQuoteItem,SalesQuoteParty&$format=json" + "?" + params;
        } catch (Exception e) {
            e.printStackTrace();
        }
	    return null;
    }
}

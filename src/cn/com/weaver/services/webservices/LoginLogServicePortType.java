
package cn.com.weaver.services.webservices;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.2.9-b130926.1035
 * Generated source version: 2.2
 * 
 */
@WebService(name = "LoginLogServicePortType", targetNamespace = "webservices.services.weaver.com.cn")
@XmlSeeAlso({
    ObjectFactory.class
})
public interface LoginLogServicePortType {


    /**
     * 
     * @param in5
     * @param in0
     * @param in2
     * @param in1
     * @param in4
     * @param in3
     * @return
     *     returns java.lang.String
     */
    @WebMethod
    @WebResult(name = "out", targetNamespace = "webservices.services.weaver.com.cn")
    @RequestWrapper(localName = "getLoginLog", targetNamespace = "webservices.services.weaver.com.cn", className = "cn.com.weaver.services.webservices.GetLoginLog")
    @ResponseWrapper(localName = "getLoginLogResponse", targetNamespace = "webservices.services.weaver.com.cn", className = "cn.com.weaver.services.webservices.GetLoginLogResponse")
    public String getLoginLog(
        @WebParam(name = "in0", targetNamespace = "webservices.services.weaver.com.cn")
        String in0,
        @WebParam(name = "in1", targetNamespace = "webservices.services.weaver.com.cn")
        int in1,
        @WebParam(name = "in2", targetNamespace = "webservices.services.weaver.com.cn")
        int in2,
        @WebParam(name = "in3", targetNamespace = "webservices.services.weaver.com.cn")
        int in3,
        @WebParam(name = "in4", targetNamespace = "webservices.services.weaver.com.cn")
        String in4,
        @WebParam(name = "in5", targetNamespace = "webservices.services.weaver.com.cn")
        String in5);

    /**
     * 
     * @param in0
     * @return
     *     returns java.lang.String
     */
    @WebMethod
    @WebResult(name = "out", targetNamespace = "webservices.services.weaver.com.cn")
    @RequestWrapper(localName = "getLoginInfo", targetNamespace = "webservices.services.weaver.com.cn", className = "cn.com.weaver.services.webservices.GetLoginInfo")
    @ResponseWrapper(localName = "getLoginInfoResponse", targetNamespace = "webservices.services.weaver.com.cn", className = "cn.com.weaver.services.webservices.GetLoginInfoResponse")
    public String getLoginInfo(
        @WebParam(name = "in0", targetNamespace = "webservices.services.weaver.com.cn")
        String in0);

    /**
     * 
     * @param in0
     * @param in1
     * @return
     *     returns java.lang.String
     */
    @WebMethod
    @WebResult(name = "out", targetNamespace = "webservices.services.weaver.com.cn")
    @RequestWrapper(localName = "updateBlockStatus", targetNamespace = "webservices.services.weaver.com.cn", className = "cn.com.weaver.services.webservices.UpdateBlockStatus")
    @ResponseWrapper(localName = "updateBlockStatusResponse", targetNamespace = "webservices.services.weaver.com.cn", className = "cn.com.weaver.services.webservices.UpdateBlockStatusResponse")
    public String updateBlockStatus(
        @WebParam(name = "in0", targetNamespace = "webservices.services.weaver.com.cn")
        String in0,
        @WebParam(name = "in1", targetNamespace = "webservices.services.weaver.com.cn")
        String in1);

}

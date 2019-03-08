package com.nan.test;

public class JwsServiceHelloProxy implements com.nan.test.JwsServiceHello {
  private String _endpoint = null;
  private com.nan.test.JwsServiceHello jwsServiceHello = null;
  
  public JwsServiceHelloProxy() {
    _initJwsServiceHelloProxy();
  }
  
  public JwsServiceHelloProxy(String endpoint) {
    _endpoint = endpoint;
    _initJwsServiceHelloProxy();
  }
  
  private void _initJwsServiceHelloProxy() {
    try {
      jwsServiceHello = (new com.nan.test.JwsServiceHelloServiceLocator()).getJwsServiceHelloPort();
      if (jwsServiceHello != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)jwsServiceHello)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)jwsServiceHello)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (jwsServiceHello != null)
      ((javax.xml.rpc.Stub)jwsServiceHello)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.nan.test.JwsServiceHello getJwsServiceHello() {
    if (jwsServiceHello == null)
      _initJwsServiceHelloProxy();
    return jwsServiceHello;
  }
  
  public java.lang.String getValue(java.lang.String arg0) throws java.rmi.RemoteException{
    if (jwsServiceHello == null)
      _initJwsServiceHelloProxy();
    return jwsServiceHello.getValue(arg0);
  }
  
  
}
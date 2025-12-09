<%@ page import="com.i2.x2.util.xcore.ExecuteMethodRequest" %>
<%@ page import="java.util.*" %>
<%@ page import="org.jdom.Element" %>
<%@ page import="com.i2.x2.servlet.*" %> 
<%@ page import="com.i2.x2.context.*" %>
<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<%

    String contextPath;
    contextPath = request.getContextPath();

    HttpSession _session = request.getSession();
    Object fromLogin = com.i2.x2.servlet.HttpUtil.getSessionAttribute(_session, "fromLogin", false );
    Object chooseAuthID = com.i2.x2.servlet.HttpUtil.getSessionAttribute(_session, "chooseAuthID", false );
    Object securityCheck = com.i2.x2.servlet.HttpUtil.getSessionAttribute(_session, "securityCheck", false );  
    Object currInstance = com.i2.x2.servlet.HttpUtil.getSessionAttribute(_session, "currentInstance", false ); 
    Object instEnabled = com.i2.x2.servlet.HttpUtil.getSessionAttribute(_session, "sessionInstanceVar", false ); 
      
    System.out.println("Security Auth fromLogin --> " + fromLogin);
    System.out.println("more than one Auth ID present --> " + chooseAuthID);
    System.out.println("securityCheck --> " + securityCheck);
    
    
    if(instEnabled !=null && instEnabled.equals("true") && (currInstance == null || currInstance.toString().length()==0))
    {
      response.sendRedirect( contextPath + "/bcm/framework/alerts/data_management.jsp");
    }
    else if(securityCheck.equals("yes") && fromLogin.equals("yes") && chooseAuthID.equals("yes"))
    {
      System.out.println("security.jsp");
	    response.sendRedirect( contextPath + "/bcm/framework/security/security.jsp?MODE=START");
    }
    else
    {
      response.sendRedirect( contextPath + "/bcm/framework/alerts/data_management.jsp");
    }
     
%>
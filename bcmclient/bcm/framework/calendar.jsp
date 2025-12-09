
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/system/tld/xrequest.tld" prefix="x2" %>
<%@ taglib uri="/WEB-INF/system/tld/i2uitaglib.tld" prefix="i2" %>
<%@ taglib uri="/WEB-INF/system/tld/i18n.tld" prefix="i18n" %>
<%@ page import ="javax.servlet.jsp.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title><i18n:text>Date Picker</i18n:text></title>
      <%@ include file="/core/include_css.jsp" %>
      <i2:javascript path="/calendar_func.js"></i2:javascript>
	  
<%
  String close =  request.getParameter("close");
  
  if (request.isRequestedSessionIdValid()) 
  {
  	close="false";
  }
  else
  {
  	close="true";
  }

%>

  </head>
  <body onblur="self.focus()" 
  <%  if((close != null) && (close.equals("true")))
      {
        out.println("onload='javascript:onLoadLogin()'");
      }
    %>
  <%  if((close != null) && (close.equals("false")))
      {
        out.println("onload='javascript:onLoad()'");
      }
    %>    
    >
    
    <center>
      <i2:xslt xslfile="xsl/calendar.xsl">
        <x2:execute command="core.common:getCalendarInfo"/>
      </i2:xslt>
    </center>
    <script>
      function onLoadLogin()
      {
          top.opener.location.href = omxContextPath + "/bcm/framework/common/logoutFromSession.cmd";
          //alert("closing child");
          this.close();
      }
    </script>
    
  </body>
  


</html>
<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title><i18n:text>Date Picker</i18n:text></title>
    <%@ include file="/core/include_css.jsp" %>
	  <i2:javascript path="/calendar_func.js"></i2:javascript>
    <%
      String close =  request.getParameter("close");
    %>
  </head>
  <body 
    <%  if((close != null) && (close.equals("true")))
    {
      out.println("onload='javascript:onLoadClose()'");
    }
    %>
    >
    <center>
      <i2:xslt xslfile="xsl/calendar.xsl">
        <x2:execute command="core.common:getCalendarInfo"/>
      </i2:xslt>
    </center>
  </body>
</html>
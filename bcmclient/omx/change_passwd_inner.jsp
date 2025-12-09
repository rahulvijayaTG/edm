<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Search</title>
    
<%@ include file="/core/include_header.jsp" %>
<%@ include file="/core/include_css.jsp" %>

<%
      String jscript = request.getParameter("JSCRIPT");
      String contextPath = request.getContextPath();
      if( jscript != null && !(jscript.equals("")) )
      {
      %>
      <script type="text/javascript" src="<%=contextPath%>/<%=jscript%>"></script>
      <%
      }
%> 

  </head>
  
    <i2:xslt xslfile="$xsl:change_passwd_inner">
      <x2:execute command="bcm.framework.config:getChangePasswordInnerPage"/>
    </i2:xslt>
      
</html>
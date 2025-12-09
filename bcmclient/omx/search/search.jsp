<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Search</title>
    

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
  
    <i2:xslt xslfile="/omx/search/xsl/search.xsl">
      <x2:execute command="omx.search.search:load"/>
    </i2:xslt>
</html>

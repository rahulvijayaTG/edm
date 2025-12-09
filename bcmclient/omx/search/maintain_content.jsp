<%@ include file="../headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <title>Header Content</title>
      <script type="text/javascript" src="../javascript/calendar.js"></script>
      <script type="text/javascript" src="../javascript/CheckDateTime.js"></script>
      <script type="text/javascript" src="js/search.js"></script>
      
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
    
  <body class="contentFrameBody" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()">
    
    <i2:xslt xslfile="xsl/search.xsl">
	    <x2:execute command="omx.search.maintain:load"/>
    </i2:xslt>
  </body>
</html>

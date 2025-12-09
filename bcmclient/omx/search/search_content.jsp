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
    
  <body onload="onLoad()"  onresize="onResize()"  class="contentFrameBody" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()">
    
    <i2:xslt xslfile="xsl/search.xsl">
	    <x2:execute command="omx.search.search:load"/>
    </i2:xslt>
    
    <i2:popupmenu name="sortOrder">
			<i2:popupmenuoption  url="javascript:sortOrder('Ascending')"><i2:attribute name="text"><i18n:text>Ascending</i18n:text></i2:attribute></i2:popupmenuoption>
			<i2:popupmenuoption  url="javascript:sortOrder('Descending')"><i2:attribute name="text"><i18n:text>Descending</i18n:text></i2:attribute></i2:popupmenuoption>
		</i2:popupmenu>

  </body>
</html>

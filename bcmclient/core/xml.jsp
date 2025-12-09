<%@ include file="/omx/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Xml View</title>

<%
  String command =  request.getParameter("CMD");
%>
<%
  String template =  request.getParameter("XSL");
  if( template != null && !(template.equals("")) )
  {
    template="$xsl:xml";
  }
%>

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
 
  <body class="contentFrameBody" onFocus="checkForPopUps()" onload="initContainer('detailed_review')" onResize="resizeContainer('detailed_review')">
  
    <i2:xslt xslfile='$xsl:xml'>
      <x2:execute command ='<%=command%>'/>
    </i2:xslt>
    <br/>
  
  </body>
</html>

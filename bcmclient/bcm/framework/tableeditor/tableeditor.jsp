<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Search</title>
    
    <%@ include file="/core/include_header.jsp" %>
    <%@ include file="/core/include_css.jsp" %>

    <i2:javascript path="/tableeditor.js"></i2:javascript>
    <i2:javascript path="/calendar.js"></i2:javascript>

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
  
  <i2:xslt xslfile="$xsl:tableeditor">
    <x2:execute command="bcm.framework.tableeditor.TableEditorView:load"/>
  </i2:xslt>
      
</html>
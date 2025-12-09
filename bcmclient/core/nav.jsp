<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <title>Navigation</title>
    <%@ include file="/core/include_css.jsp" %>
  </head>

  <body style="background-color:#E6E6E6">
    <i2:xslt xslfile="$xsl:core_nav">
      <x2:execute command="core.navigation.solutions:getLinks"/>
    </i2:xslt>
  </body>
</html>

<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
  <head>
    <title>Header</title>
  </head>
  <body topmargin="3" leftmargin="0" marginwidth="0" marginheight="0" class="shellContent" onLoad="initFrameToggleGif('../')" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()">
    <i2:xslt xslfile="xsl/header.xsl"><x2:execute command="bcm.framework.index:getHomeHeader"/></i2:xslt>
  </body>
</html>



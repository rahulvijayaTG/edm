<%@ include file="/bcm/framework/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
  <head>
    <title>Confirmation</title>
  </head>

  <body class="contentFrameBody" onFocus="checkForPopUps()" >
    <i2:xslt xslfile="xsl/confirmation.xsl">
      <x2:execute command="omx.common:getConfirmationParameters"/>
    </i2:xslt>
  </body>
</html>

<%@ include file="/bcm/framework/headerinclude.jsp" %>
<%@ include file="/bcm/framework/include_dbformfilter.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>User Admin Content</title>
  </head>

  <script type="text/javascript" src="js/user_admin.js"></script>
  <body  class="contentFrameBody" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()" onLoad="javascript:requiredFieldCheck('onLoad')">
	    <!-- Tabbed Container -->
	    <i2:xslt xslfile="$xsl:user_admin_users">
	        <x2:execute command="omx.user_admin.user_admin_users:load"/>
	    </i2:xslt>
  </body>
</html>
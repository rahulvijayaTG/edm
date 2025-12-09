<%@ include file="/bcm/framework/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>User Admin Content</title>
  </head>

   <script type="text/javascript" src="../saved_trans/search_transactions.js"></script>

   <script type="text/javascript" src="js/user_admin.js"></script>

  <body  class="contentFrameBody" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()" onLoad="javascript:requiredFieldCheck('onLoad')">
	    <!-- Tabbed Container -->
	    <i2:xslt xslfile="$xsl:user_admin_users">
	        <x2:execute command="omx.user_admin.user_admin_users:load"/>
	    </i2:xslt>
  </body>
</html>
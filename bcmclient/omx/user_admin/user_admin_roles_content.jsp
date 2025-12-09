<%@ include file="/bcm/framework/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>User Admin Content</title>
  </head>
  <body  class="contentFrameBody" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()">
    <!-- Tabbed Container -->
    <i2:xslt xslfile="xsl/user_admin_roles.xsl"><xrequest:batch>
        <xrequest:executeCommand name="getUserAdminLinks">
          <PAGE Value="user_admin_roles"/>
        </xrequest:executeCommand>
        <xrequest:executeCommand name="getUserAdminRoles"/>
      </xrequest:batch>
    </i2:xslt>
  </body>
</html>



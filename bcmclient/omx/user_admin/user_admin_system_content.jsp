<%@ include file="/bcm/framework/headerinclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>User Admin System Content</title>
    <script type="text/javascript">
       function save()
       {
             document.systemForm.action="saveSystemConfig.cmd";
             document.systemForm.submit();
       }
    </script>
  </head>
  <body  class="contentFrameBody" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()">

	    <!-- Tabbed Container -->
	    <i2:xslt xslfile="xsl/user_admin_system.xsl"><xrequest:batch>
	        <xrequest:executeCommand name="getUserAdminLinks">
	          <PAGE Value="user_admin_system"/>
	        </xrequest:executeCommand>
	        <xrequest:executeCommand name="getSystemConfig"/>
	      </xrequest:batch>
	    </i2:xslt>
  </body>
</html>
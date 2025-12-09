<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>User Admin Content new nwrw wnwnwnw </title>
  </head>


   <script type="text/javascript" src="js/user_admin.js"></script>

   <body  class="contentFrameBody">

      <i2:xslt xslfile="$xsl:user_admin_groups_role_domain">
			<x2:execute command="bcm.framework.user_admin.user_admin_groups_new:getRoleTemplateDomainTabData"/>
      </i2:xslt>

    </body>
</html>

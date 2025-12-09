<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>i2 Technologies</title>
        <script type="text/javascript">

      function logout (interface_login_url)
      {
       if(interface_login_url != null)
         top.location.href="/i2/login.jsp?Logout=yes&mdm=yes";
       else
        {
         message = "Are you sure you really want to log out?"
         locstr = "alert/redirectToConfirm.cmd?MESSAGE=" + message + "&ACTION=javascript:logout();";
         popUpWindow(locstr,'popUp5');
        }
            
      }
      </script>
  </head>
  <i2:xslt xslfile="$xsl:profile"><x2:execute command="bcm.framework.config:getIndexPage"/></i2:xslt>
</html>

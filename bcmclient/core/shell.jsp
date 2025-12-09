<%@ include file="/core/include_header.jsp" %>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>i2 Technologies</title>
<%@ include file="/core/include_css.jsp" %>
    <script type="text/javascript">
      
      function logout()
      {
  			msg = "Are you sure you really want to log out?"
        var theButtonClicked = core_confirm(msg);
        if (theButtonClicked == 'yes')
        {
          parent.location = "login/controller/logout.x2c";     
          return;
        }
        else
        {
          return;
        }
      }
      
      </script>
	</head>
	<i2:xslt xslfile="$xsl:core_shell">
    <x2:execute command="core.shell.view:load"/>
  </i2:xslt>
</html>

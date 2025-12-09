<script>
  if( top != self ){
    top.document.location = document.location;
  }
</script>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/system/tld/xrequest.tld" prefix="x2" %>
<%@ taglib uri="/WEB-INF/system/tld/i2uitaglib.tld" prefix="i2" %>
<%@ taglib uri="/WEB-INF/system/tld/i18n.tld" prefix="i18n" %>
<HTML>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  	<TITLE>i2 Technologies</TITLE>
	  <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
	  <i2:stylesheet path="/omx_core.css"></i2:stylesheet>
	  <i2:javascript path="/global_javascript.js"></i2:javascript>
   	  <SCRIPT LANGUAGE="JavaScript">
  
  		function validate()
  		{
  			document.userfm.CHANGE_PASSWD.value = "no";
  			document.userfm.submit();
  		}
		
		function changePasswd()
  		{
  			document.userfm.CHANGE_PASSWD.value = "yes";
  			document.userfm.submit();
  		}
  
    </SCRIPT>
  </head>
	<i2:xslt xslfile="$xsl:ssologin"><x2:execute command="core.sso:getLoginPage"/></i2:xslt>
</html>

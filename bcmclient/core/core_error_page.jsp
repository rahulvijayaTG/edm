<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/system/tld/xrequest.tld" prefix="x2" %>
<%@ taglib uri="/WEB-INF/system/tld/i2uitaglib.tld" prefix="i2" %>
<%@ taglib uri="/WEB-INF/system/tld/i18n.tld" prefix="i18n" %>
<html>
  <head>
  </head>
</html>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>DOM Error Page</title>
  <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
	<i2:stylesheet path="/i2uipad.css"></i2:stylesheet>
	<i2:javascript path="/global_javascript.js"></i2:javascript>
	<i2:dhtml padsupport="yes"></i2:dhtml>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellContent" onFocus="checkForPopUps()">
<table width="50%" cellspaing="2" cellpadding="2"><tr><td>
<i2:container title="Unable to process your request">
  <table width="100%" cellspaing="5" cellpadding="5" class="containerBodyUneditable">
    <tr>
      <td>
        Unable to process your request due to one of the following reason(s):<br/><br/>
        &nbsp;&nbsp;-&nbsp;<%=request.getParameter("MSG")%><br/><br/>
        Please contact your system administrator for further assistance.
      </td>
    </tr>
  </table>
  <i2:footer>
    <i2:buttonbar>
      <i2:button onclick="javascript:history.back();">&nbsp;Back&nbsp;</i2:button>
    </i2:buttonbar>
  </i2:footer>
</i2:container>
</td></tr></table>
</body>
</html>

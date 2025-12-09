<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Home Page</title>

    <script type="text/javascript">
      function setfocus()
      {
        if ( document.search_form )
          document.search_form.SEARCH_CRITERIA.focus();
      }
      </script>    
  </head>
  
  <body class="contentFrameBody" onFocus="checkForPopUps()" onload="setfocus()">
  
    <table border="0" cellpadding="0" cellspacing="8" width="100%">
      <tr>
        <!-- Search Module -->
        <!-- end Search Module -->
  
        <!-- My Alerts Module -->
        <i2:xslt xslfile="$xsl:alerts_summary">
          <x2:execute command="bcm.framework.alerts.data:getAlerts"/>
        </i2:xslt>
        <!-- end My Alerts Module -->  
      </tr>
      <tr>
        <!-- Recent Transactions Module -->
        <td width="100%" colspan="2" >
        </td>
        <!-- end Recent Transactions Module -->
      </tr>

    </table> 
  </body>
</html>

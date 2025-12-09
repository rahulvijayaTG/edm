<%@ include file="/core/include_header.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>User Admin Content</title>
  </head>

   <script type="text/javascript" src="js/user_admin_user_pref.js"></script>

  <body  class="contentFrameBody" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()">
      <i2:container id="container" width="100%" scrollable="no">
        <i2:attribute name="title"><i18n:text>User Preferences</i18n:text></i2:attribute>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td>
            <i2:xslt xslfile="$xsl:user_admin_users_notification_pref">
                  <x2:execute command="bcm.framework.user_admin.user_admin_users_pref:loadNotificationUserPref"/>
              </i2:xslt>
          </td>
        </tr>
      </table>
    </i2:container>
  </body>
</html>

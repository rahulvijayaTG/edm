<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <xsl:output method="html"/>

  <xsl:template match="LOGIN_PAGE">
    <script type="text/javascript">
      <![CDATA[
      function setfocus()
      {
        if ( document.userfm.USER_NAME )
          document.userfm.USER_NAME.focus();
      }

      function onLoad()
      {
         var height = document.body.offsetHeight - 90;
         var obj = document.getElementById('panel_img');
         //alert(obj.height);
//         alert(height)
         obj.height = height;


        setfocus();
      }

      function onResize()
      {
        onLoad();
      }
      function validate()
      {
        if ( document.userfm.USER_NAME )
        {
          if (document.userfm.USER_NAME.value == "")
          {
          core_login_alert("Please enter your Username");
          document.userfm.USER_NAME.focus();
          return;
          }


          if (document.userfm.PASSWORD.value == "")
          {
          core_login_alert("Please enter your Password");
          document.userfm.PASSWORD.focus();
          return;
          }
        }

        document.userfm.CHANGE_PASSWD.value = "no";
        document.userfm.submit();
      }

    function changePasswd()
      {
        document.userfm.CHANGE_PASSWD.value = "yes";

        if (document.userfm.USER_NAME.value == "")
        {
        core_login_alert("Please enter your Username");
        document.userfm.USER_NAME.focus();
        return;
        }


        if (document.userfm.PASSWORD.value == "")
        {
        core_login_alert("Please enter your Password");
        document.userfm.PASSWORD.focus();
        return;
        }

        document.userfm.submit();
      }

      function SetfocusSubmit( target ) {
          if ( target == document.userfm.USER_NAME ){
            document.userfm.PASSWORD.focus();
          } else {
            validate();
          }
      }

       function IEEnterKey() {

        if( window.event.keyCode == 13 && ((window.event.srcElement.name == "USER_NAME") || (window.event.srcElement.name == "PASSWORD")) ){
          SetfocusSubmit(window.event.srcElement)
          event.returnValue=false;
        }
      }

      function NetEnterKey(e) {
        key = e.which;
        if(key == 13){
          SetfocusSubmit( e.target )
          return false;}
      }

      browserName = navigator.appName;

      if (browserName == "Netscape") {
        document.captureEvents(Event.KEYPRESS);
        document.onkeypress=NetEnterKey;}
      else{ if (browserName.indexOf("Explorer") >= 0){
            document.onkeypress=IEEnterKey;}
        }
    ]]>
    </script>


    <i2:shell logo="{@logo}" background="{@background}">
      <body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" onLoad="javascript:onLoad();" onResize="javascript:onResize();">

        <form name="userfm" method="POST" action="{@command}">
          <input type="hidden" name="CHANGE_PASSWD" value="no"/>
          <input type="hidden" name="CONTENT_URL" value="{@contentUrl}"/>
          <table>
            <tr>
              <td valign="top">
                <i2:img id="panel_img" src="{@panelImage}" width="134" height="607"/>
              </td>
              <td valign="top">

                <!-- Error Message -->
                <xsl:if test="string-length(@error) > 0">
                  <table border="0" cellPadding="0" cellSpacing="0" width="100%">
                    <tr>
                      <td align="center">
                        <i2:img src="/alert_static.gif" border="0" align="middle">
                          <i2:attribute name="alt">
                            <i18n:text>Error</i18n:text>
                          </i2:attribute>
                        </i2:img>
                      </td>
                      <td nowrap="yes">&#xA0;
                        <b>
                          <i18n:text>Login failed</i18n:text>.&#xA0;
                          <i18n:text>Please try again</i18n:text>.
                        </b>
                      </td>
                      <xsl:if test="string-length(@errorDescription) > 0">
                        <td nowrap="yes" width="100%">&#xA0;
                          <b>
                            <i18n:text><xsl:value-of select="@errorDescription"/></i18n:text>
                          </b>
                        </td>
                      </xsl:if>
                    </tr>
                    <tr>
                      <td colspan="5">
                        <hr size="0"/>
                      </td>
                    </tr>
                  </table>
                </xsl:if>

                <table border="0" cellPadding="2" cellSpacing="5">

                  <xsl:choose>
                    <xsl:when test="(string-length(@from) > 0) and ((@from = 'change_passwd') or (@from = 'logout'))">
                      <xsl:choose>
                        <!-- From change password -->
                        <xsl:when test="@from = 'change_passwd'">
                          <tr>
                            <td colspan="5">
                              <span class="TMHead">
                                <b>
                                  <i18n:text>You have successfully changed your Password</i18n:text>
                                </b>
                              </span>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">
                              <HR size="0"/>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">
                              <span class="TMHead">
                                <b>
                                  <i18n:text>To Log in:</i18n:text>
                                </b>
                              </span>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">
                              <span class="TMHead">
                                <i18n:text>Please enter your user ID and password below.</i18n:text>
                              </span>
                            </td>
                          </tr>
                        </xsl:when>
                        <!-- From log out -->
                        <xsl:when test="@from = 'logout'">
                          <tr>
                            <td colspan="5">
                              <span class="TMHead">
                                <b>
                                  <i18n:text>You have successfully Logged Out</i18n:text>
                                </b>
                              </span>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">
                              <HR size="0"/>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">
                              <span class="TMHead">
                                <b>
                                  <i18n:text>To Log in again:</i18n:text>
                                </b>
                              </span>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">
                              <span class="TMHead">
                                <i18n:text>Please enter your user ID and password below.</i18n:text>
                              </span>
                            </td>
                          </tr>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:when>
                    <!-- Direct  -->
                    <xsl:otherwise>
                      <tr>
                        <td colspan="5">
                          <span class="TMHead">
                            <b>
                              <i18n:text>Welcome</i18n:text>!
                            </b>
                            <br/>
                            <i18n:text>Please enter your user ID and password below.</i18n:text>
                          </span>
                        </td>
                      </tr>
                    </xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                    <xsl:when test="string-length(@displayPage) > 0">
                      <tr>
                        <td>
                          <table>
                            <tr>
                              <input type="hidden" name="SSO_ENABLED" value="yes"/>
                              <td>
                                <table border="0" cellpadding="0" cellspacing="5">
                                  <!-- Entire template as provided by CIS -->
                                  <xsl:value-of select="@displayPage" disable-output-escaping="yes"/>
                                  <!--tr><td><p>User Name:</p></td> <td><input type="text" name="PTLM_loginUser" class="inputField"/></td></tr><tr><td><p>Password:</p></td> <td><input type="password" name="PTLM_loginPassword" class="inputField"/></td></tr><tr><td><p>Other Info:</p></td> <td><input type="text" name="PTLM_otherInfo" class="inputField"/></td></tr-->
                                </table>
                              </td>
                              <td valign="bottom">
                                <table border="0" cellpadding="0" cellspacing="5">
                                  <tr>
                                    <td>
                                      <i2:button emphasized="yes" onclick="javascript:validate()">&#xA0;&#xA0;
                                        <i18n:text>Log In</i18n:text>&#xA0;&#xA0;
                                      </i2:button>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </xsl:when>
                    <xsl:otherwise>
                      <!-- User Id -->
                      <TR>
                        <TD nowrap="yes">
                          <i18n:text>User ID</i18n:text>:
                        </TD>
                        <TD>
                          <input type="field" class="inputFieldIE" name="USER_NAME" value="{@userName}" size="20" TABINDEX="5"/>
                        </TD>
                        <td colspan="3"></td>
                      </TR>
                      <!-- Password -->
                      <TR>
                        <TD nowrap="yes">
                          <i18n:text>Password</i18n:text>:
                        </TD>
                        <TD>
                          <input type="password" class="inputFieldIE" name="PASSWORD" value="" size="20" TABINDEX="6"/>
                        </TD>
                        <!-- Login Button -->
                        <td width="100%">
                          <i2:button emphasized="yes" onclick="javascript:validate()">&#xA0;&#xA0;
                            <i18n:text>Log In</i18n:text>&#xA0;&#xA0;
                          </i2:button>
                        </td>
                        <td colspan="2">
                        </td>
                      </TR>
                      <!-- Info -->
                      <tr>
                        <xsl:choose>
                          <xsl:when test="@from = 'logout'">
                            <td colspan="5">
                              <i18n:text>Please contact your system administrator for help with logout</i18n:text>.
                            </td>
                          </xsl:when>
                          <xsl:otherwise>
                            <td colspan="5">
                              <i18n:text>Please contact your system administrator for help with login</i18n:text>.
                            </td>
                          </xsl:otherwise>
                        </xsl:choose>
                      </tr>
                      <!-- Button -->
                      <tr>
                        <xsl:if test="@changePwd = 'yes'">
                          <td colspan="2">
                            <i2:button onclick="javascript:changePasswd()">&#xA0;&#xA0;
                              <i18n:text name="Change Password">Change Password</i18n:text>&#xA0;&#xA0;
                            </i2:button>
                          </td>
                        </xsl:if>
                        <td colspan="3">
                        </td>
                      </tr>
                    </xsl:otherwise>
                  </xsl:choose>
                </table>

                <table border="0" cellPadding="2" cellSpacing="50" width="100%">
                  <tr rowspan="10">
                    <td nowrap="yes">&#xA0;</td>
                  </tr>
                </table>

                <!-- CopyRight Message -->
                <table border="0" cellPadding="2" cellSpacing="2" width="100%">
                  <tr>
                    <td colspan="5">
                      <HR size="0"/>
                    </td>
                  </tr>
                  <tr>
                    <td nowrap="yes">&#xA0;
                      <span class="TMHead">
                        <i18n:text>Copyright &#169;  2000-2004 i2 Technologies US, Inc. All Rights Reserved.</i18n:text>&#xA0;
                      </span>
                    </td>
                  </tr>
                  <tr>
                    <td nowrap="yes">&#xA0;
                      <span class="TMHead">
                        <i18n:text>This product is protected by US and international patents and copyrights</i18n:text>&#xA0;
                      </span>
                    </td>
                  </tr>
                  <tr>
                    <td nowrap="yes">&#xA0;
                      <span class="TMHead">
                        <i18n:text>as described in the About box.</i18n:text>&#xA0;
                      </span>
                    </td>
                  </tr>
                </table>

                <br/>
              </td>

            </tr>
          </table>
        </form>
      </body>
    </i2:shell>
  </xsl:template>

</xsl:stylesheet>



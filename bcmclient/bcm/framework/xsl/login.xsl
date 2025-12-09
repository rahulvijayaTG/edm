<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:output method="html"/>

  <xsl:template match="LOGIN_PAGE_INFO">
    <i2:shell logo="{MASTHEAD_IMAGE/@Value}" background="../../i2/images/i2shellbackground.gif">
      <body onLoad="javascript:setfocus()">
        <FORM NAME="userfm" METHOD="POST" action="{COMMAND/@Value}">
          <input type="hidden" name="CHANGE_PASSWD" value="no"/>
          <table border="0" cellpadding="0px" cellspacing="0px" width="100%" height="100%">
            <tr height="100%" valign="top">
<!--              <td>
                <i2:img src="{PANEL_IMAGE/@Value}" width="134" height="487"/>
              </td>-->
              <td width="134px" height="100%">
                    <table style="background-color:424FAD" border="0" cellpadding="0px" cellspacing="0px" width="134px" height="100%">
                      <tr>
                        <td height="280px" valign="top">
                          <i2:img border="0" src="/login_panel_top.jpg" width="134px" height="280"/>
                        </td>
                   </tr>
                    <tr>
                        <td height="100%">
                          <i2:img border="0" src="/login_panel_filler.jpg" width="134px" height="100%"/>
                        </td>
                   </tr>
                      <tr>
                        <td height="100px">
                           <i2:img border="0" src="/login_panel_bottom.jpg" width="134px" height="100"/>
                        </td>
                   </tr>
                 </table>
              </td>
              <td valign="top">

                <!-- Error Message -->
                <xsl:if test="ERROR/@Value">
                  <table border="0" cellPadding="0" cellSpacing="0" width="100%">
                    <tr>
                      <td align="left">
                        <i2:img src="/alert_static.gif" border="0" align="middle">
                          <i2:attribute name="alt"><i18n:text>Error</i18n:text></i2:attribute>
                        </i2:img>
                      </td>
                      <xsl:choose>
                          <xsl:when test="DESCRIPTION/@Value = 'INACTIVE_LOGIN_NAME'">
                            <td nowrap="yes" align="left">&#xA0;<b><i18n:text>Login failed</i18n:text>.&#xA0;<i18n:text>Please contact your administrator</i18n:text>.</b></td>
                          </xsl:when>
                          <xsl:otherwise>
                            <td nowrap="yes" align="left">&#xA0;<b><i18n:text>Login failed</i18n:text>.&#xA0;<i18n:text>Please try again</i18n:text>.</b></td>
                          </xsl:otherwise>
                      </xsl:choose>                        
                    </tr>
                    <tr>
                      <td align="left">
                      </td>
                      <xsl:if test="DESCRIPTION">
                        <td nowrap="yes" width="100%">&#xA0;<i18n:text>Error</i18n:text>:&#xA0;<i18n:text><xsl:value-of select="DESCRIPTION/@Value"/></i18n:text>
                        </td>
                      </xsl:if>
                    </tr>
                    <tr>
                      <td colspan="5">

                        <HR size="0"/>
                      </td>
                    </tr>
                  </table>
                </xsl:if>

                <table border="0" cellPadding="2" cellSpacing="5">

                  <xsl:choose>
                    <xsl:when test="(FROM/@Value) and ((FROM/@Value = 'change_passwd') or (FROM/@Value = 'logout') or (FROM/@Value = 'SESSION'))">
                      <xsl:choose>
                        <!-- From change password -->
                        <xsl:when test="FROM/@Value = 'change_passwd'">
                          <tr>
                            <td colspan="5"><span class="TMHead"><b><i18n:text>You have successfully changed your Password</i18n:text></b></span></td>
                          </tr>
                          <tr>
                            <td colspan="5">
                              <HR size="0"/>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">
                              <span class="TMHead"><b><i18n:text>To Log in:</i18n:text></b></span>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5"><span class="TMHead"><i18n:text>Please enter your User ID and Password below.</i18n:text></span>
                            </td>
                          </tr>
                        </xsl:when>
                        <!-- From log out -->
                        <xsl:when test="FROM/@Value = 'logout'">
                          <tr>
                            <td colspan="5"><span class="TMHead"><b><i18n:text>You have successfully Logged Out</i18n:text></b></span>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">
                              <HR size="0"/>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">
                              <span class="TMHead"><b><i18n:text>To Log in again:</i18n:text></b></span>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5"><span class="TMHead"><i18n:text>Please enter your User ID and Password below.</i18n:text></span>
                            </td>
                          </tr>
                        </xsl:when>
                        <!-- From Session timed out -->
            <xsl:when test="FROM/@Value = 'SESSION'">
              <tr>
                <td colspan="5"><span class="TMHead"><b><i18n:text>Your session has expired. Please Log in again</i18n:text></b></span>
                </td>
              </tr>
              <tr>
                <td colspan="5">
                  <HR size="0"/>
                </td>
              </tr>
              <tr>
                <td colspan="5">
                  <span class="TMHead"><b><i18n:text>To Log in again:</i18n:text></b></span>
                </td>
              </tr>
              <tr>
                <td colspan="5"><span class="TMHead"><i18n:text>Please enter your User ID and Password below.</i18n:text></span>
                </td>
              </tr>
            </xsl:when>
                      </xsl:choose>
                    </xsl:when>
                    <!-- Direct  -->
                    <xsl:otherwise>
                      <tr>
                        <td colspan="5"><span class="TMHead"><b><i18n:text>Welcome</i18n:text>!</b><br/>
                            <i18n:text>Please enter your User ID and Password below.</i18n:text></span></td>
                      </tr>
                    </xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                    <xsl:when test="DISPLAY_PAGE">
                      <tr>
                        <td>
                          <table>
                            <tr>
                              <input type="hidden" name="SSO_ENABLED" value="yes"/>
                              <td>
                                <table border="0" cellpadding="0" cellspacing="5">
                                  <!-- Entire template as provided by CIS -->
                                  <xsl:value-of select="DISPLAY_PAGE/@Value" disable-output-escaping="yes"/>
                                  <!--tr><td><p>User Name:</p></td> <td><input type="text" name="PTLM_loginUser" class="inputField"/></td></tr><tr><td><p>Password:</p></td> <td><input type="password" name="PTLM_loginPassword" class="inputField"/></td></tr><tr><td><p>Other Info:</p></td> <td><input type="text" name="PTLM_otherInfo" class="inputField"/></td></tr-->
                                </table>
                              </td>
                              <td valign="bottom">
                                <table border="0" cellpadding="0" cellspacing="5">
                                  <tr>
                                    <td>
                                      <i2:button emphasized="yes" onclick="javascript:validate()">&#xA0;&#xA0;<i18n:text>Log In</i18n:text>&#xA0;&#xA0;</i2:button>
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
                    <TD nowrap="yes"><i18n:text>User ID</i18n:text>:</TD>
                    <TD>
                      <input type="field" class="inputFieldIE" name="USER_NAME" value="" size="20" TABINDEX="5"/>
                    </TD>
                    <td colspan="3"></td>
                  </TR>
                  <!-- Password -->
                  <TR>
                    <TD nowrap="yes"><i18n:text>Password</i18n:text>:</TD>
                    <TD>
                      <input type="password" class="inputFieldIE" name="PASSWORD" value="" size="20" TABINDEX="6"/>
                    </TD>
                    <!-- Login Button -->
                    <td width="100%">
                      <i2:button emphasized="yes" onclick="javascript:validate()">&#xA0;&#xA0;<i18n:text>Log In</i18n:text>&#xA0;&#xA0;</i2:button>
                    </td>
                    <td colspan="2">
                    </td>
                  </TR>
                  <!-- Info -->
                  <tr>
                    <xsl:choose>
                      <xsl:when test="FROM/@Value = 'logout'">
                        <td colspan="5"><i18n:text>Please contact your system administrator for help with logout issues.</i18n:text></td>
                      </xsl:when>
                      <xsl:otherwise>
                        <td colspan="5"><i18n:text>Please contact your system administrator for help with login issues.</i18n:text></td>
                      </xsl:otherwise>
                    </xsl:choose>
                  </tr>
                  <!-- Button -->
                  <tr>
                    <xsl:if test="CHANGE_PWD/@Value = 'yes'">
                      <td align="left">
                        <i2:button onclick="javascript:changePasswd()">&#xA0;<i18n:text name="Change Password">Change Password</i18n:text>&#xA0;</i2:button>
                      </td>
                    </xsl:if>
                    <td align="center">
                        <i2:button onclick="javascript:forgotPasswd()">&#xA0;<i18n:text name="Forgot Password">Forgot Password</i18n:text>&#xA0;</i2:button>
                    </td>
                    <td align="left">
                        <i2:button onclick="javascript:forgotLogin()">&#xA0;<i18n:text name="Forgot Login Name">Forgot Login Name</i18n:text>&#xA0;</i2:button>
                    </td>
                  </tr>
                   </xsl:otherwise>
                  </xsl:choose>
                </table>

                  <table border="0" cellPadding="2" cellSpacing="10" width="100%">
                    <tr rowspan="10">
                      <td nowrap="yes">&#xA0;</td>
                    </tr>
                  </table>

                <!-- CopyRight Message -->
                  <table border="0" cellPadding="2" cellSpacing="2" width="100%">
                    <tr>
                      <td nowrap="yes">&#xA0;<span class="TMHead"><b><i18n:text>The application is best viewed with these settings</i18n:text></b>&#xA0;</span></td>
                    </tr>
                    <tr>
                      <td nowrap="yes">&#xA0;<span class="TMHead"><i18n:text>Browser Type:Internet Explorer 5.5 or 6.0</i18n:text>&#xA0;</span></td>
                    </tr>
                    <tr>
                      <td nowrap="yes">&#xA0;<span class="TMHead"><i18n:text>Display Resolution:1024x768</i18n:text>&#xA0;</span></td>
                    </tr>
                    <tr>
                      <td nowrap="yes">&#xA0;<span class="TMHead"><i18n:text>Display Color:65536 colors(min)</i18n:text>&#xA0;</span></td>
                    </tr>
                    <tr>
                      <tr rowspan="10">
                        <td nowrap="yes">&#xA0;</td>
                      </tr>
                      <td colspan="5">
                        <HR size="0"/>
                      </td>
                    </tr>
                    <tr>
                      <td nowrap="yes">&#xA0;<span class="TMHead"><i18n:text>Copyright &#169;  2004-2005 i2 Technologies US, Inc. All Rights Reserved.</i18n:text>&#xA0;</span></td>
                    </tr>
                    <tr>
                      <td nowrap="yes">&#xA0;<span class="TMHead"><i18n:text>This product is protected by US and international patents and copyrights.</i18n:text>&#xA0;</span></td>
                    </tr>
                  </table>

                <br/>
              </td>

            </tr>
          </table>
        </FORM>
      </body>
    </i2:shell>
  </xsl:template>

</xsl:stylesheet>



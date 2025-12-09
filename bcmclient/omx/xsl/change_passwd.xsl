<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../core/xsl/error.xsl"/>

  <xsl:import href="code_master.xsl"/>
  <xsl:output method="html"/>
  <xsl:template match="CHANGE_PWD_INFO">


    <i2:shell logo="{MASTHEAD_IMAGE/@Value}" background="../i2/images/i2shellbackground.gif">
<!--
      <body onLoad="javascript:setfocus()">
-->
      <body >
        <FORM NAME="userfm" METHOD="POST" action="{COMMAND/@Value}">
          <input type="hidden" name="USER_NAME" value="{USER_NAME/@Value}"/>
          <input type="hidden" name="PROMPT_SECRET_QUESTION" value="{/RESPONSES/RESPONSE/PROMPT_SECRET_QUESTION/@Value}"/>
          <input type="hidden" name="MY_PROFILE" value="{/RESPONSES/RESPONSE/MY_PROFILE/@Value}"/>
          <table>
            <tr>
              <td>
                <i2:img src="{PANEL_IMAGE/@Value}" width="134" height="607"/>
              </td>
              <td valign="top">
                <xsl:call-template name="change_passwd_required_field"/>
                <xsl:if test="ERROR/@Value">
                  <table border="0" cellPadding="0" cellSpacing="0" width="100%">
                    <tr/>
                    <tr>
                      <td align="left" valign="middle" width="5%">
                        <i2:img src="/alert_static.gif" alt="Error" border="0" align="left"/>
                      </td>
                      <td align="left" nowrap="yes" colspan="2">
                      <b><i18n:text>Password change failed</i18n:text>.&#xA0;
                      	 <i18n:text>Please try again</i18n:text>.</b>
                      </td>
                     </tr>
                     <tr>
                     <td>
                      <xsl:if test="DESCRIPTION">
                        <td width="100%"><b>
                            <i18n:text>
                              <xsl:value-of select="DESCRIPTION/@Value"/>
                            </i18n:text>
                          </b>
                        </td>
                      </xsl:if>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="5">
                        <HR size="0"/>
                      </td>
                    </tr>
                  </table>
                  <br/>
                </xsl:if>
                <table border="0" cellPadding="2" cellSpacing="3">
                  <tr>
                    <td colspan="3">
                      <b>
                        <i18n:text>Please change your password by entering appropriate values in the following fields.</i18n:text>
                      </b>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="1">
                      <i18n:text>Old Password</i18n:text>:
                      <xsl:call-template name="display_alert_mark"/>
                      </td>
                    <td align="left">
                      <input type="password" class="inputFieldIE" name="OLD_PASSWORD" value="" size="27" TABINDEX="6"/>
                    </td>
                    <td/>
                  </tr>
                  <tr>
                    <td colspan="1">
                      <i18n:text>New Password</i18n:text>:
                      <xsl:call-template name="display_alert_mark"/>
                    </td>
                    <td>
                      <input type="password" class="inputFieldIE" name="NEW_PASSWORD" value="" size="27" TABINDEX="6"/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <i18n:text>Confirm New Password</i18n:text>:
                      <xsl:call-template name="display_alert_mark"/>
                    </td>
                    <td>
                      <input type="password" class="inputFieldIE" name="CONFIRM_PASSWORD" value="" size="27" TABINDEX="6"/>
                    </td>
                  </tr>
                  <!-- Nikhil: Added to capture secret question and password to assist in login/password recovery -->
                  <xsl:if test="/RESPONSES/RESPONSE/PROMPT_SECRET_QUESTION/@Value = 'yes' ">
                    <tr>
                      <td>
                        <i18n:text>Secret Question</i18n:text>
                      <xsl:call-template name="display_alert_mark"/>
                      </td>
                      <td>
                        <select class="inputfieldIE" name="PWD_QUESTION" tabIndex="10">
                          <option value="">
                            <i18n:text>Select...</i18n:text>
                          </option>
                          <xsl:choose>
                            <xsl:when test="string-length(USER_INFORMATION/PWD_QUESTION/@Value) &gt; 0">
                              <xsl:apply-templates select="/RESPONSES/RESPONSE/PWD_QUESTIONS/CODE_MASTER_VALUE" mode="pulldown">
                                <xsl:sort select="DESCRIPTION/@Value"/>
                                <xsl:with-param name="selectedId" select="USER_INFORMATION/PWD_QUESTION/@Value"/>
                              </xsl:apply-templates>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:apply-templates select="/RESPONSES/RESPONSE/PWD_QUESTIONS/CODE_MASTER_VALUE" mode="pulldown"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </select>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <i18n:text>Secret Answer</i18n:text>
                      <xsl:call-template name="display_alert_mark"/>
                      </td>
                      <td>
                        <input type="field" name="PWD_ANSWER" value="{USER_INFORMATION/PWD_ANSWER/@Value}" tabIndex="15" class="inputfieldIE" maxlength="32" size="27"/>
                      </td>
                    </tr>
                  </xsl:if>
                  <tr>
                    <td align="left" width="72%">
                      <table border="0" cellPadding="0" cellSpacing="3">
                        <tr>
                          <td>
                            <i2:button onclick="javascript:cancel()">&#xA0;&#xA0;<i18n:text>Cancel</i18n:text>&#xA0;&#xA0;</i2:button>
                          </td>
                          <td>
                            <i2:button emphasized="yes" onclick="javascript:validate()">&#xA0;&#xA0;<i18n:text>Change</i18n:text>&#xA0;&#xA0;</i2:button>
                          </td>
                        </tr>
                      </table>
                    </td>
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
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onLoad_js">

/*
    This javascript has been moved to change_passwd.jsp
    function onLoad()
    {
      requiredFieldCheck('onLoad');
    }
*/
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="change_passwd_required_field">
    <table border="0" id="denotes_required_field" cellpadding="0" cellspacing="0" width="100%" >
      <tr>
        <td align="left" width="100%">
          <font color="red">*</font>&#xA0;
          <i18n:text>denotes required field</i18n:text>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="display_alert_mark">
    <font color="red">*</font>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
</xsl:stylesheet>

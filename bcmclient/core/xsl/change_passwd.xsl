<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:output method="html"/>
  
  <xsl:template match="CHANGE_PWD_INFO">
    <i2:shell logo="{MASTHEAD_IMAGE/@Value}" background="../i2/images/i2shellbackground.gif">
      <body onLoad="javascript:setfocus()">
        
        
        <FORM NAME="userfm" METHOD="POST" action="{COMMAND/@Value}">
          <table>
            <tr>
              <td><i2:img src="{PANEL_IMAGE/@Value}" width="134" height="607"/></td>
              <td valign="top">
                <xsl:if test="ERROR/@Value">
                  <table border="0" cellPadding="0" cellSpacing="0" width="100%">
                    <tr>
                    </tr>
                    <tr>
                      <td align="center">
                        <i2:img src="/alert_static.gif" border="0" align="middle">
                          <i2:attribute name="alt"><i18n:text>Error</i18n:text></i2:attribute>
                        </i2:img>  
                      </td>
                      <xsl:if test="DESCRIPTION/@Value != 'PASSWORD_EXPIRED'">
                        <td nowrap="yes" colspan="2">&#xA0;<b><i18n:text>Password change failed</i18n:text>.&#xA0;<i18n:text>Please try again</i18n:text>.</b></td>
                      </xsl:if>
                      <xsl:if test="DESCRIPTION">
                        <td width="100%">&#xA0;<b><i18n:text><xsl:value-of select="DESCRIPTION/@Value"/></i18n:text></b>
                        </td>
                      </xsl:if>
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
                      <b><i18n:text>To Change your current password</i18n:text>:</b><br/>
                      <i18n:text>Please fill in the required fields below.</i18n:text>
                    </td>
                  </tr>
                  <tr>
                    <td nowrap="nowrap"><i18n:text>User ID</i18n:text>:</td>
                    <td>
                      <input class="inputFieldIE" name="ID" value="{ID/@Value}" size="20" TABINDEX="6"/>
                    </td>
                    <td>
                    </td>
                  </tr>
                  <tr>
                    <td nowrap="nowrap"><i18n:text>Old Password</i18n:text>:</td>
                    <td>
                      <input type="password" class="inputFieldIE" name="OLD_PASSWORD" value="" size="20" TABINDEX="6"/>
                    </td>
                    <td>
                    </td>
                  </tr>
                  <tr>
                    <td nowrap="nowrap"><i18n:text>New Password</i18n:text>:</td>
                    <td>
                      <input type="password" class="inputFieldIE" name="NEW_PASSWORD" value="" size="20" TABINDEX="6"/>
                    </td>
                  </tr>
                  <tr>
                    <td nowrap="nowrap"><i18n:text>Confirm Password</i18n:text>:</td>
                    <td>
                      <input type="password" class="inputFieldIE" name="CONFIRM_PASSWORD" value="" size="20" TABINDEX="6"/>
                    </td>
                  </tr>
                  <tr>
                    <td>&#xA0;</td>
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
                  <tr>
                    <td colspan="3"><i18n:text>Please contact your system administrator for help with changing your password</i18n:text>.</td>
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

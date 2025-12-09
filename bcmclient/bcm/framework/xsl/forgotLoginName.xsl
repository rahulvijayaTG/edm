<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:output method="html"/>
  <xsl:template match="RECOVER_LOGIN_INFO">
    <i2:shell logo="{MASTHEAD_IMAGE/@Value}" background="../i2/images/i2shellbackground.gif">
<!--
      <body onLoad="javascript:setfocus()">
-->
      <body >
        <FORM NAME="userfm" METHOD="POST" action="{COMMAND/@Value}">
          <input type="hidden" name="CHANGE_PASSWD" value="no"/>
          <table>
            <tr>
              <td>
                <i2:img src="{PANEL_IMAGE/@Value}" width="134" height="607"/>
              </td>
              <td valign="top">
                <!-- Error Message -->
                <xsl:if test="ERROR/@Value and ERROR/@Value='true' ">
                  <table border="0" cellPadding="0" cellSpacing="0" width="100%">
                    <tr>
                      <td align="center">
                        <i2:img src="/alert_static.gif" border="0" align="middle">
                          <i2:attribute name="alt">
                            <i18n:text>Error</i18n:text>
                          </i2:attribute>
                        </i2:img>
                      </td>
                      <td nowrap="yes">
										&#xA0;<b>
                          <i18n:text>ERROR : </i18n:text>
										&#xA0;<i18n:text>Please try again</i18n:text>.</b>
                      </td>
                      <xsl:if test="DESCRIPTION">
                        <td nowrap="yes" width="100%">&#xA0;<b>
                            <i18n:text>
                              <xsl:value-of select="DESCRIPTION/@Value"/>
                            </i18n:text>
                          </b>
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
                <xsl:if test="ERROR/@Value and ERROR/@Value='false' ">
                  <table border="0" cellPadding="0" cellSpacing="0" width="100%">
                    <tr>
                      <td align="center">
                        <i2:img src="/alert_green_static.gif" border="0" align="middle">
                          <i2:attribute name="alt">
                            <i18n:text>Success</i18n:text>
                          </i2:attribute>
                        </i2:img>
                      </td>
                      <td nowrap="yes">&#xA0;</td>
                      <xsl:if test="DESCRIPTION">
                        <td nowrap="yes" width="100%">&#xA0;
												<b>
                            <i18n:text>
                              <xsl:value-of select="DESCRIPTION/@Value"/>
                            </i18n:text>
                          </b>
                        </td>
                      </xsl:if>
                    </tr>
                    <tr>
                      <td colspan="5">
                        <HR size="0"/>
                      </td>
                    </tr>
                  </table>
                  <table border="0" cellPadding="2" cellSpacing="5">
                    <TR>
                      <TD colspan="1"/>
                      <TD>
                        <i2:button emphasized="no" onclick="javascript:cancel()">
    									&#xA0;&#xA0;<i18n:text>OK</i18n:text>&#xA0;&#xA0;
    							 </i2:button>
                      </TD>
                    </TR>
                  </table>
                </xsl:if>
                <xsl:if test=" not( ERROR/@Value='false' ) ">
                  <table border="0" cellPadding="2" cellSpacing="5">
                    <tr>
                      <td colspan="5">
                        <span class="TMHead">
                          <b>
                            <i18n:text>Welcome</i18n:text>!</b>
                          <br/>
                          <i18n:text>Please enter your email address below.</i18n:text>
                        </span>
                      </td>
                    </tr>
                    <!-- EMAIL_ADDRESS -->
                    <TR>
                      <TD nowrap="yes">
                        <i18n:text>Email Address</i18n:text>:</TD>
                      <TD>
                        <input type="field" class="inputFieldIE" name="EMAIL_ADDRESS" value="{EMAIL_ADDRESS/@Value}" size="30" TABINDEX="5"/>
                      </TD>
                      <TD colspan="3">
                        <i2:button emphasized="yes" onclick="javascript:validate()">
									&#xA0;&#xA0;<i18n:text>Recover Login Name</i18n:text>&#xA0;&#xA0;
							 </i2:button>
                      </TD>
                    </TR>
                    <!-- Password  Answer -->
                    <TR>
                      <TD colspan="1"/>
                      <TD>
                        <i2:button emphasized="no" onclick="javascript:cancel()">
									&#xA0;&#xA0;<i18n:text>Cancel</i18n:text>&#xA0;&#xA0;
							 </i2:button>
                      </TD>
                    </TR>
                  </table>
                  <table border="0" cellPadding="2" cellSpacing="50" width="100%">
                    <tr rowspan="10">
                      <td nowrap="yes">&#xA0;</td>
                    </tr>
                  </table>
                </xsl:if>
                <!-- CopyRight Message -->
                <table border="0" cellPadding="2" cellSpacing="2" width="100%">
                  <tr>
                    <td colspan="5">
                      <HR size="0"/>
                    </td>
                  </tr>
                  <tr>
                    <td nowrap="yes">&#xA0;<span class="TMHead">
                        <i18n:text>Copyright &#169;  2004-2005 i2 Technologies US, Inc. All Rights Reserved.</i18n:text>&#xA0;</span>
                    </td>
                  </tr>
                  <tr>
                    <td nowrap="yes">&#xA0;<span class="TMHead">
                        <i18n:text>This product is protected by US and international patents and copyrights</i18n:text>&#xA0;</span>
                    </td>
                  </tr>
                  <!-- TAR ID : 510088 -->
		   <!-- <tr>
		         <td nowrap="yes">&#xA0;<span class="TMHead">
		            <i18n:text>as described in the About box.</i18n:text>&#xA0;</span>
		         </td>
		       </tr> -->
                  <!-- TAR ID : 510088 -->
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

<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../core/xsl/mdm_buttons.xsl"/>
  <xsl:output method="html"/>
  <xsl:variable name="numCatalogItems" select="count(/RESPONSES/RESPONSE/CA_ITEM)"/>
  <xsl:variable name="numCustOrders" select="count(/RESPONSES/RESPONSE/CUSTOMER_ORDER)"/>
  <xsl:template match="/RESPONSES/RESPONSE">
    <xsl:call-template name="onLoad_js"/>
    <xsl:call-template name="include_javascript_table_resize"/>
    <i2:container id="calendar_container" inner="no"  scrollable="yes">
      <i2:table id="calendar_table" bgcolor="gray" border="1" cellspacing="0" cellpadding="0">
        <FORM NAME="calControl" method="POST">
          <input type="hidden" name="day" value="{DAY/@Value}"/>
          <input type="hidden" name="mon" value="{MON/@Value}"/>
          <input type="hidden" name="year" value="{YEAR/@Value}"/>
          <xsl:variable name="formattedDate">
            <i18n:date format="common">
              <xsl:value-of select="FORMATTED_DATE/@Value"/>
            </i18n:date>
          </xsl:variable>
          <input type="hidden" name="formattedDate" value="{$formattedDate}"/>
          
          <xsl:variable name="formattedDateTime">
						<i18n:date format="datetime">
							<xsl:value-of select="FORMATTED_DATE/@Value"/>
						</i18n:date>
					</xsl:variable>
					<input type="hidden" name="formattedDateTime" value="{$formattedDateTime}"/>

          <tr bgcolor="#bec5e7" bordercolor="#bec5e7">
            <td align="left">
              <i2:button onclick="javascript:setPreviousYear()">&#xA0;<i2:img src="/back_double_arrow.gif" border="0"/>&#xA0;</i2:button>
            </td>
            <td align="center">
              <b>
                <xsl:value-of select="YEAR/@Value"/>
              </b>
            </td>
            <td align="right">
              <i2:button onclick="javascript:setNextYear()">&#xA0;<i2:img src="/forward_double_arrow.gif" border="0"/>&#xA0;</i2:button>
            </td>
          </tr>
          <tr bgcolor="#d1d6f0" bordercolor="#d1d6f0">
            <td align="left">
              <i2:button onclick="javascript:setPreviousMonth()">&#xA0;&#xA0;<i2:img src="/back_single_arrow.gif" border="0"/>&#xA0;</i2:button>
            </td>
            <td align="center">
              <b>
                <xsl:call-template name="getMonthName">
                  <xsl:with-param name="month" select="MON/@Value"/>
                </xsl:call-template>
              </b>
            </td>
            <td align="right">
              <i2:button onclick="javascript:setNextMonth()">&#xA0;<i2:img src="/forward_single_arrow.gif" border="0"/>&#xA0;&#xA0;</i2:button>
            </td>
          </tr>
          <tr bgcolor="#f7f8fd">
            <td colspan="3">
              <table cellpadding="6" align="center" border="0">
                <tr>
                  <td>
                    <table CELLPADDING="0" CELLSPACING="0" ALIGN="CENTER" BORDER="0">
                      <tr bordercolor="#f7f8fd">
                        <td width="18px" height="18px" align="center" bordercolor="#f7f8fd">
                          <b>
                            <i18n:text>Sunday</i18n:text>
                          </b>
                        </td>
                        <td width="18px" height="18px" align="center" bordercolor="#f7f8fd">
                          <b>
                            <i18n:text>Monday</i18n:text>
                          </b>
                        </td>
                        <td width="18px" height="18px" align="center" bordercolor="#f7f8fd">
                          <b>
                            <i18n:text>Tuesday</i18n:text>
                          </b>
                        </td>
                        <td width="18px" height="18px" align="center" bordercolor="#f7f8fd">
                          <b>
                            <i18n:text>Wednesday</i18n:text>
                          </b>
                        </td>
                        <td width="18px" height="18px" align="center" bordercolor="#f7f8fd">
                          <b>
                            <i18n:text>Thursday</i18n:text>
                          </b>
                        </td>
                        <td width="18px" height="18px" align="center" bordercolor="#f7f8fd">
                          <b>
                            <i18n:text>Friday</i18n:text>
                          </b>
                        </td>
                        <td width="18px" height="18px" align="center" bordercolor="#f7f8fd">
                          <b>
                            <i18n:text>Saturday</i18n:text>
                          </b>
                        </td>
                      </tr>
                      <tr>
                        <td colspan="7">
                          <table CELLPADDING="0" CELLSPACING="0" ALIGN="CENTER" BORDER="1">
                            <script>
                    buildDays();
                    </script>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr bgcolor="#bec5e7">
            <td colspan="3">
              <table border="0" cellpadding="2" cellspacing="0" width="100%">
                <tr>
                  <td>
                    <xsl:call-template name="mdmButton">
                        <xsl:with-param name="onclick" select="'javascript:setToday();'"/>
                        <xsl:with-param name="text" select="'Today'"/>
                    </xsl:call-template>
                    <!--i2:button onclick="javascript:setToday()">&#xA0;<i18n:text>Today</i18n:text>&#xA0;</i2:button-->
                  </td>
                  <td align="center">
                    <i2:buttonbar>
                      <i2:buttonbardivider/>
                    </i2:buttonbar>
                  </td>
                  <td>
                    <xsl:call-template name="mdmButton">
                        <xsl:with-param name="onclick" select="'javascript:closeCalendar();'"/>
                        <xsl:with-param name="text" select="'Cancel'"/>
                    </xsl:call-template>
                    <!--i2:button onclick="javascript:closeCalendar()">&#xA0;<i18n:text>Cancel</i18n:text>&#xA0;</i2:button-->
                  </td>
                  <td>
                    <xsl:call-template name="mdmButton">
                        <xsl:with-param name="onclick" select="'javascript:returnDate();'"/>
                        <xsl:with-param name="text" select="'Ok'"/>
                        <xsl:with-param name="emphasized" select="'yes'"/>
                    </xsl:call-template>
                    <!--i2:button emphasized="yes" onclick="javascript:returnDate()">&#xA0;<i18n:text>Ok</i18n:text>&#xA0;</i2:button-->
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </FORM>
      </i2:table>
    </i2:container>
  </xsl:template>
  <xsl:template name="getMonthName">
    <xsl:param name="month" select="0"/>
    <xsl:choose>
      <xsl:when test="number($month) = 1">
        <i18n:text>January</i18n:text>
      </xsl:when>
      <xsl:when test="number($month) = 2">
        <i18n:text>February</i18n:text>
      </xsl:when>
      <xsl:when test="number($month) = 3">
        <i18n:text>March</i18n:text>
      </xsl:when>
      <xsl:when test="number($month) = 4">
        <i18n:text>April</i18n:text>
      </xsl:when>
      <xsl:when test="number($month) = 5">
        <i18n:text>May</i18n:text>
      </xsl:when>
      <xsl:when test="number($month) = 6">
        <i18n:text>June</i18n:text>
      </xsl:when>
      <xsl:when test="number($month) = 7">
        <i18n:text>July</i18n:text>
      </xsl:when>
      <xsl:when test="number($month) = 8">
        <i18n:text>August</i18n:text>
      </xsl:when>
      <xsl:when test="number($month) = 9">
        <i18n:text>September</i18n:text>
      </xsl:when>
      <xsl:when test="number($month) = 10">
        <i18n:text>October</i18n:text>
      </xsl:when>
      <xsl:when test="number($month) = 11">
        <i18n:text>November</i18n:text>
      </xsl:when>
      <xsl:when test="number($month) = 12">
        <i18n:text>December</i18n:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="onLoad_js">
  <script>
    function onLoad()
    {  
      resize_Containers();
    }
    </script>
  </xsl:template>
  <xsl:template name="include_javascript_table_resize">
    <script>
      function resize_Containers()
      {      
        i2uiResizeScrollableContainer('calendar_container',document.body.offsetHeight, null, document.body.offsetWidth - 25, true, 'yes');        
      }
    </script>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">


<xsl:output method="html"/>

  <xsl:template match="/">
    <xsl:apply-templates select="/RESPONSES/RESPONSE/REPORTS"/>
  </xsl:template>

  <xsl:template match="REPORTS" >
    <i2:container scrollable="true" title="{REPORT_TYPE/@Value}">

      <i2:header>
        <table border="0" cellpadding="2" cellspacing="0" width="100%">
          <tr>
            <td align="right" nowrap="true">
              <xsl:value-of select="count(REPORT)"/>
              <i18n:text> Reports Available</i18n:text>
            </td>
          </tr>
        </table>
      </i2:header>

      <table width="100%" cellspacing="10" cellpadding="10">
        <tr><td>

      <i2:table scrollable="true">
        <xsl:choose>
          <xsl:when test="count(REPORT) = 0">
            <i2:tr>
              <td>
                <i18n:text>No reports were found</i18n:text>
              </td>
            </i2:tr>
          </xsl:when>

          <xsl:otherwise>
            <i2:tr header="yes">
              <th align="left" nowrap="true"><i18n:text>Report List</i18n:text></th>
            </i2:tr>
          </xsl:otherwise>
        </xsl:choose>
        
        <xsl:apply-templates select="REPORT"/>

      </i2:table>

     </td></tr></table>

      <i2:footer>
        <i2:buttonbar>
          <i2:button onclick="javascript:onRefresh()">Refresh</i2:button>
        </i2:buttonbar>
      </i2:footer>
            
    </i2:container>
  </xsl:template>

  <xsl:template match="REPORT" >

    <i2:tr>
      <td>
        <a href="{REPORT_URL/@Value}" target="_self">
          <xsl:value-of select="REPORT_NAME/@Value"/>
        </a>
      </td>
    </i2:tr>
  </xsl:template>

</xsl:stylesheet>

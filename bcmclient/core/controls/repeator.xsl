<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

 <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="REPEATOR" mode="layout">

    <table cellpadding="0" cellspacing="0" border="0" width="100%">

      <!-- Inner Layouts -->
      <xsl:for-each select="CONTAINER|SEARCH|GRID|FIELDS|REPORT|FORM|HORIZONTAL_RULER|DYNAMIC_PGL|CHART|EXCEL_WORKBOOK|PIVOT|EXCEL_PIVOT|HORIZONTAL_TREE|TREE_CONTROL">
        <tr>
          <td>
            <xsl:apply-templates select="." mode="layout"/>
          </td>
        </tr>
      </xsl:for-each>

    </table>

 </xsl:template>

</xsl:stylesheet>


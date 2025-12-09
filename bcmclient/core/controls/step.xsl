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
  <xsl:template match="STEP" mode="container_content">

    <xsl:apply-templates select="VALIDATION" mode="validation_area"/>

    <xsl:variable name="pad">
      <xsl:choose>
        <xsl:when test="CONTAINER">6</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <table cellpadding="0" cellspacing="{$pad}" border="0" width="100%">

      <!-- Inner Layouts -->
      <xsl:for-each select="CONTAINER|SEARCH|GRID|FIELDS|REPORT|FORM|HORIZONTAL_RULER|DYNAMIC_PGL|CHART|EXCEL_WORKBOOK|PIVOT|EXCEL_PIVOT|HORIZONTAL_TREE|TREE_CONTROL|REPEATOR">
        <tr>
          <td>
            <xsl:apply-templates select="." mode="layout"/>
          </td>
        </tr>
      </xsl:for-each>

    </table>

    <xsl:apply-templates select="script"/>

  </xsl:template>


  <!-- **********************************************************************
    *********************************************************************** -->
    <xsl:template match="DYNAMIC_PGL" mode="layout">

        <xsl:apply-templates select="*[name() != 'BUTTONS']" mode="layout"/>

        <xsl:apply-templates select="." mode="footer"/>

    </xsl:template>

<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>


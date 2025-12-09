<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="../../core/xsl/page.xsl"/>
  
  <xsl:output method="html"/>
  
  <xsl:template match="RESPONSES" mode="content">
    <xsl:variable name="title"><i18n:text>Welcome!</i18n:text></xsl:variable>
    <i2:container title="{$title}">
      <table><tr><td>
        <i18n:text>Please select a workflow from the left menu.</i18n:text>
      </td></tr></table>
    </i2:container>
  </xsl:template>  
</xsl:stylesheet>

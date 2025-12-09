<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../core/xsl/container.xsl"/>

  <xsl:output method="html"/>
  
  <!-- Entry Point -->
  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:call-template name="msg"/>
  </xsl:template>
  <xsl:template name="msg">
    <table>
      <tr>
        <td>Please remove this page from navigation pad</td>
      </tr>
    </table>
  </xsl:template>
</xsl:stylesheet>

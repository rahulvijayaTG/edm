<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../core/controls/page.xsl"/>
  <xsl:import href="../../../core/controls/page_header.xsl"/>

  <xsl:output method="html"/>

  <!-- Root Enty Point -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="/">
    <xsl:call-template name="include_javascript_page"/>
      
    <!-- AppFrame -->
    <xsl:apply-templates select="/" mode="appFrame"/>

  </xsl:template>

  <!-- ********************************************************************** 
  *********************************************************************** -->      
  <xsl:template match="/" mode="appFrame">
    <tr>
      <td height="25px" >
        <table border="0" cellpadding="0" cellspacing="0" width="100%" >
          <tr>
            <td height="25px">
              <xsl:apply-templates select="/RESPONSES/RESPONSE/HEADER" mode="content_header"/>
            </td>
          </tr>
        </table>
      </td>
    </tr>      
  </xsl:template>
</xsl:stylesheet>


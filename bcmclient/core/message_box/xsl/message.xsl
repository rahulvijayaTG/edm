<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">
  
  <xsl:import href="../../xsl/page.xsl"/>
  <xsl:import href="message_container.xsl"/>
  
  <xsl:output method="html"/> 
   
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="page_title">  
   <i18n:text><xsl:value-of select="$title"/></i18n:text>
  </xsl:template>
  
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/REQUEST_PARAMETERS"/>
  </xsl:template>
  
</xsl:stylesheet>

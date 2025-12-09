<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <!--<xsl:import href="../../authorization/xsl/authorization_view.xsl"/>-->
  <!-- this will over-ride the core button templete NOTE: keep this import at end -->
  <xsl:import href="../../../../bcm/framework/xsl/code_master.xsl"/>
  <xsl:import href="../../xsl/core_buttons.xsl"/>
  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../../core/xsl/search.xsl"/>
  <xsl:output method="html"/>
  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">
    <xsl:if test="string-length(ERROR_MESSAGE/@Value) > 0 or string-length(SUCCESS_MESSAGE/@Value) > 0">
      <xsl:call-template name="display_instruction_area"/>
    </xsl:if>    
    <xsl:apply-templates select="SEARCH"/>
  </xsl:template>    
</xsl:stylesheet>

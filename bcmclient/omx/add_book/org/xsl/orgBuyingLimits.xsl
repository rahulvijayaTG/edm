<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <xsl:import href="../../../xsl/tabs2.xsl"/>
  <xsl:import href="../../../xsl/buttons.xsl"/>
  <xsl:import href="../../xsl/buyinglimits.xsl"/>

<xsl:output method="html"/>

<xsl:template match="RESPONSES">

  <xsl:apply-templates select="RESPONSE">
    <xsl:with-param name="page" select="'org_buying_limits'"/>
    <xsl:with-param name="entityType" select="'Org'"/>
    <xsl:with-param name="entityId" select="/RESPONSES/RESPONSE/ENTITY/ENTITY_ID/@Value"/>
  </xsl:apply-templates>

</xsl:template>

</xsl:stylesheet>

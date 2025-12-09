<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:import href="../../../xsl/code_master.xsl"/>
<xsl:import href="../../../xsl/tabs2.xsl"/>
<xsl:import href="../../../xsl/buttons.xsl"/>
<xsl:import href="viewOrg.xsl"/>
<xsl:import href="editOrg.xsl"/>
<xsl:import href="editLocalOrg.xsl"/>

<xsl:output method="html"/>

<xsl:template match="RESPONSES/RESPONSE">

  <xsl:apply-templates mode="edit" select="ORGANIZATION"/>

</xsl:template>

</xsl:stylesheet>












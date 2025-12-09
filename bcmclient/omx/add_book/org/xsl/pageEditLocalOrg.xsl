<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:import href="../../../xsl/code_master.xsl"/>
<xsl:import href="../../xsl/addr_book_tabs.xsl"/>
<xsl:import href="viewOrg.xsl"/>
<xsl:import href="editOrg.xsl"/>
<xsl:import href="editLocalOrg.xsl"/>

<xsl:output method="html"/>

<xsl:template match="/">
 
<i2:tabbedcontainer>

<xsl:apply-templates mode="tabs" select="/RESPONSES/RESPONSE/TAB_INFO"/>

    <xsl:apply-templates mode="view" select="/RESPONSES/RESPONSE/ORGANIZATION"/>
    <xsl:apply-templates mode="edit" select="/RESPONSES/RESPONSE/LOCAL_CUSTOMER"/>

</i2:tabbedcontainer>

</xsl:template>

</xsl:stylesheet>


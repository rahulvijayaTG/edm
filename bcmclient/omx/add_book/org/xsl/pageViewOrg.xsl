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
  <xsl:import href="viewLocalOrg.xsl"/>
  <xsl:import href="editOrg.xsl"/>
  <xsl:import href="editLocalOrg.xsl"/>
  
  <xsl:output method="html"/>
  
  <xsl:template match="RESPONSES/RESPONSE">
    
    <xsl:choose>
      <xsl:when test="(ORGANIZATION/EDITABLE or ORGANIZATION/IS_NEW)">
        <xsl:apply-templates mode="edit" select="ORGANIZATION"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="view" select="ORGANIZATION"/>
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:if test="(ORGANIZATION/CUSTOMER_STATUS/@Value != 'NONE' and ORGANIZATION/CUSTOMER_STATUS/@Value != 'DORMANT')">
      <xsl:choose>
        <xsl:when test="(LOCAL_CUSTOMER/EDITABLE or LOCAL_CUSTOMER/IS_NEW)">
          <xsl:apply-templates mode="edit" select="LOCAL_CUSTOMER"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates mode="view" select="LOCAL_CUSTOMER"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <!-- JDJ -->
    <xsl:if test="(ORGANIZATION/SELLER_STATUS/@Value != 'NONE' and ORGANIZATION/SELLER_STATUS/@Value != 'DORMANT')">
      <xsl:choose>
        <xsl:when test="(LOCAL_SELLER/EDITABLE or LOCAL_SELLER/IS_NEW)">
          <xsl:apply-templates mode="edit" select="LOCAL_SELLER"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates mode="view" select="LOCAL_SELLER"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

  </xsl:template>
  
</xsl:stylesheet>








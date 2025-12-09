<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">


  <xsl:variable name="tabsmaxlen">30</xsl:variable>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="CONTAINER" mode="tabs">
    <xsl:param name="content" select="/RESPONSES"/>


    <!-- TabbedContainer -->
    <i2:tabbedcontainer  id="container" scrollable="{@Scrollable}">

      <!-- Tabs -->
      <i2:tabset id="tabs_container" field="grey">
        <xsl:apply-templates select="STEP" mode="tabs"/>
      </i2:tabset>

      <!-- Header -->
      <xsl:apply-templates select="STEP[@Selected = 'true' or @Selected = 'yes']" mode="header"/>

      <!-- Content -->
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <xsl:if test="STEP[(@Selected = 'true' or @Selected = 'yes') and ( @Editable='false' or @Editable = 'no')] ">
          <xsl:attribute name="class">unEditableContainer</xsl:attribute>
        </xsl:if>
        <tr>
          <td valign="top" nowrap="yes" colspan="2">
            <xsl:apply-templates select="$content" mode="container_content"/>
          </td>
        </tr>
      </table>

      <!--  Footer -->
      <xsl:apply-templates select="STEP[@Selected = 'true' or @Selected = 'yes']" mode="footer"/>

    </i2:tabbedcontainer>
  </xsl:template>

  <!-- Tab -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="STEP" mode="tabs">

        <xsl:variable name="text">
        <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
      </xsl:variable>

        <xsl:variable name="truncatedText">
        <xsl:choose>
          <xsl:when test="string-length($text) > $tabsmaxlen">
            <xsl:value-of select="concat(substring($text,0,$tabsmaxlen -3), '...')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$text"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>


    <i2:tab alttext="{@AltText}" onclick="{@OnClick}" selected="{@Selected}" target="{$target}" hotkey="@HotKey">
      <i18n:text><xsl:value-of select="$truncatedText"/></i18n:text>
    </i2:tab>
  </xsl:template>



  <!-- Target -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:variable name="target">
    <xsl:choose>
      <xsl:when test="string-length(/RESPONSES/RESPONSE/CONTAINER/@Target) > 0"><xsl:value-of select="/RESPONSES/RESPONSE/CONTAINER/@Target"/></xsl:when>
      <xsl:otherwise>appFrame</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>


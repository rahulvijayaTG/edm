<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:variable name="quote">'</xsl:variable>

  <!-- **********************************************************************
       *********************************************************************** -->
    <xsl:template match="BUTTONS" mode="layout">
      <i2:buttonbar>
        <xsl:apply-templates/>
      </i2:buttonbar>


    </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="BUTTONS">
    <i2:buttonbar>
      <xsl:apply-templates mode="footer_content"/>
    </i2:buttonbar>
  </xsl:template>


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="BUTTON" mode="footer_content">
    <xsl:apply-templates select="." mode="content"/>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="*" mode="footer_content">
    <td nowrap="yes">
      <xsl:apply-templates select="." mode="label_form"/>
      <xsl:apply-templates select="." mode="content"/>
    </td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="BUTTON" mode="content">
    <td nowrap="yes">
      <xsl:apply-templates select="."/>
    </td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="BUTTON" mode="label_form">
    <td nowrap="yes"></td>
  </xsl:template>


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="BUTTON">
    <i2:button id="{./@Id}" name="{./@Name}" emphasized="{./@Emphasized}" target="{./@Target}">
      <i2:attribute name="onclick">
        <xsl:choose>
          <xsl:when test="@Type = 'popup'">javascript:popUpWindow('<xsl:value-of select="./@OnClick"/>','<xsl:value-of select="@PopupName"/>')</xsl:when>
          <xsl:otherwise><xsl:value-of select="./@OnClick"/></xsl:otherwise>
        </xsl:choose>
      </i2:attribute>

      <!-- Display Text -->
      &#xA0;<i18n:text><xsl:value-of select="./@DisplayText"/></i18n:text>&#xA0;

        <xsl:if test="@Disabled = 'true'">
          <xsl:variable name="type">
            <xsl:choose>
              <xsl:when test="@Emphasized = 'true'">Emphasized</xsl:when>
              <xsl:otherwise>Regular</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <script><xsl:value-of select="concat('i2uiToggleButtonState(',  $quote,@Id, $quote,',', $quote, 'disabled', $quote, ',' , $quote, $type, $quote, ');')"/></script>
        </xsl:if>

    </i2:button>


    <xsl:apply-templates select="script"/>

  </xsl:template>


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="DIVIDER">
    <i2:buttonbardivider/>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
</xsl:stylesheet>
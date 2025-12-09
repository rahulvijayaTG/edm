<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

 <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="LINK">
    <td>
      <xsl:apply-templates select="." mode="content"/>
    </td>
    <td>&#xA0;</td>
  </xsl:template>


  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="LINK" mode="content">
      <xsl:variable name="title"><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text></xsl:variable>

      <xsl:variable name="onclick">
        <xsl:choose>
          <xsl:when test="@Type = 'popup'">javascript:popUpWindow('<xsl:value-of select="@OnClick"/>','<xsl:value-of select="@PopupName"/>')</xsl:when>
          <xsl:when test="starts-with(@OnClick,'javascript')"><xsl:value-of select="@OnClick"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="@OnClick"/></xsl:otherwise>
        </xsl:choose>
     </xsl:variable>

      <xsl:if test="IMAGE/@Src">
        <a class="text" >
          <xsl:if test="string-length(@OnClick) > 0">
            <xsl:attribute name="href">
              <xsl:value-of select="$onclick"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="string-length(@tabIndex) > 0">
            <xsl:attribute name="tabIndex">
              <xsl:value-of select="@tabIndex"/>
            </xsl:attribute>
          </xsl:if>
          <i2:img src="/{IMAGE/@Src}" width="16" height="16" border="0">
            <i2:attribute name="alt">
              <i18n:text><xsl:value-of select="$title"/></i18n:text>
            </i2:attribute>
          </i2:img>
       </a>
      </xsl:if>

  </xsl:template>

<!-- **********************************************************************
     *********************************************************************** -->
  <!-- Help -->
  <xsl:template match="HELP">
    <td>
    <a class="text" href="javascript:onHelp();">
      <xsl:attribute name="onClick">javascript:popUpWindow( '<xsl:value-of select="@Url"/>', 'popUp4')</xsl:attribute>
      <xsl:variable name="txtAltAttr"><i18n:text>Help</i18n:text></xsl:variable>
      <i2:img src="/help_avail.gif" alt="{$txtAltAttr}" border="0" align="middle"/>
    </a>
  </td>
  </xsl:template>

<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>


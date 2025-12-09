<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i2="http://www.i2.com"
  exclude-result-prefixes="i2"
  version="1.0">

  <!--
    An xsl fragment that allows us to share the common definitions of the skins directories
    without having to include i2uitaglib.xsl
  -->

  <xsl:param name="cfgDirectory">.</xsl:param>
  <xsl:param name="contextPath"/>

  <xsl:variable name="cfgFile"><xsl:value-of select="$cfgDirectory"/>/i2uiskins.xml</xsl:variable>

  <xsl:variable name="skin">
    <xsl:choose>
      <xsl:when test="//i2:skin[@name]"><xsl:value-of select="//i2:skin/@name"/></xsl:when>
      <xsl:when test="document($cfgFile)/plaf/skins/defaults/skinName"><xsl:value-of select="document($cfgFile)/plaf/skins/defaults/skinName"/></xsl:when>
      <xsl:otherwise>i2 standard</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="imageDirectory">
    <xsl:value-of select="$contextPath"/>
    <xsl:choose>
      <xsl:when test="document($cfgFile)/plaf/skins/skin[@name = $skin]/directories/image">
        <xsl:value-of select="document($cfgFile)/plaf/skins/skin[@name = $skin]/directories/image"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="document($cfgFile)/plaf/skins/defaults/directories/image"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="javascriptDirectory">
    <xsl:value-of select="$contextPath"/>
    <xsl:choose>
      <xsl:when test="document($cfgFile)/plaf/skins/skin[@name = $skin]/directories/javascript">
        <xsl:value-of select="document($cfgFile)/plaf/skins/skin[@name = $skin]/directories/javascript"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="document($cfgFile)/plaf/skins/defaults/directories/javascript"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="cssDirectory">
    <xsl:value-of select="$contextPath"/>
    <xsl:choose>
      <xsl:when test="document($cfgFile)/plaf/skins/skin[@name = $skin]/directories/css">
        <xsl:value-of select="document($cfgFile)/plaf/skins/skin[@name = $skin]/directories/css"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="document($cfgFile)/plaf/skins/defaults/directories/css"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- define the skin templates -->
  <xsl:template match="i2:skin" mode="taglib">
  </xsl:template>
  <xsl:template match="i2:skin" mode="taglibNS4">
  </xsl:template>
  <xsl:template match="i2:skin" mode="taglibNS6">
  </xsl:template>

</xsl:stylesheet>

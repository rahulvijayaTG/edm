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
  <xsl:template match="POPUP_MENU" mode="layout">
  	<i2:popupmenu name="{@Name}">
  	 <xsl:apply-templates select="POPUP_MENU_ITEM" mode="layout"/>
  	</i2:popupmenu>
  </xsl:template>

	<!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="POPUP_MENU_ITEM" mode="layout">
  	<i2:popupmenuoption  url="{@OnClick}" text="{@DisplayText}"/>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
</xsl:stylesheet>

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
  <xsl:template match="HORIZONTAL_TREE" mode="top">
    <xsl:apply-templates select="." mode="layout"/>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="HORIZONTAL_TREE" mode="layout">

               <!-- Container -->
              <i2:container id="container_{@Id}" inner="yes" scrollable="yes" collapsable="{@Collapsable}">

                <!-- Title -->
                <i2:attribute name="title">
                  <xsl:apply-templates select="." mode="title"/>
                </i2:attribute>
		

		 <i2:horizontaltree>
			<xsl:copy-of select="*"/>
		</i2:horizontaltree>


              </i2:container>
  </xsl:template>





  <!-- Title -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match= "HORIZONTAL_TREE" mode="title">
    <b><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text></b>
  </xsl:template>




</xsl:stylesheet>

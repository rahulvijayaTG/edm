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
  <xsl:template match="FORM" mode="top">
    <form name="{@Name}" method="{@method}" action="{@Action}" target="{@Target}">
      <xsl:apply-templates select="CONTAINER">
        <xsl:with-param name="content" select="CONTAINER/STEP"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="FIELDS" mode="layout"/>
      <input type="hidden" name="BUTTON_ID" value="BUTTON_ID"></input>
    </form>
  </xsl:template>


  <!-- **********************************************************************
      *********************************************************************** -->
   <xsl:template match="FORM" mode="layout">
     <form name="{@Name}" method="{@method}" action="{@Action}" target="{@Target}">
       <xsl:apply-templates select="CONTAINER">
          <xsl:with-param name="content" select="CONTAINER/STEP"/>
       </xsl:apply-templates>
       <xsl:apply-templates select="FIELDS" mode="layout"/>
     </form>
   </xsl:template>

  <!-- **********************************************************************
        *********************************************************************** -->
</xsl:stylesheet>

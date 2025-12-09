<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:output method="html"/>

  <xsl:template match="TAB_INFO" mode="tabs">
    <i2:tabset id="tabset" field="grey">
      <xsl:apply-templates select="NAV_PAGE" mode="tabs"/>
		</i2:tabset>
    <xsl:apply-templates select="HELP" mode="tabs"/>
  </xsl:template>

  <xsl:template match="NAV_PAGE" mode="tabs">
    <i2:tab alttext="" onclick="{URL/@Value}" selected="{SELECTED/@Value}" target="appFrame">
      <i18n:text><xsl:value-of select="DISPLAY_TEXT/@Value"/></i18n:text>
    </i2:tab>
  </xsl:template>

  <xsl:template match="HELP" mode="tabs">
    <i2:header>
      <table border="0" cellpadding="2" cellspacing="0" width="100%">
        <tr>
          <td align="right">
            <a class="text" href="#">
              <xsl:attribute name="onClick">popUpWindow( '<xsl:value-of select="URL/@Value"/>', 'popUp4')</xsl:attribute>
              <i2:img border="0" align="middle" src="/help_avail.gif"/>
            </a>
          </td>
        </tr>
      </table>
    </i2:header>
  </xsl:template>
  
</xsl:stylesheet>
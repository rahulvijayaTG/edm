<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <xsl:output method="html"/>

  <xsl:template match="MIDDLE_PAGE_INFO">
    
    <xsl:choose>
      <xsl:when test="NAV_FRAME/@Value = 'show'">
        <frameset marginwidth="0" marginheight="0" cols="172,*" frameborder="no" border="0" bordercolor="#e6e6e6">
        	<frame marginwidth="0" marginheight="0" name="navFrame" src="{NAV_PAGE_URL/@Value}" noresize="yes" scrolling="no"/>
        	<frame name="appFrame" src="{HOME_PAGE_URL/@Value}" noresize="yes" scrolling="no"/>
        </frameset>
      </xsl:when>
      <xsl:otherwise>
        <frameset marginwidth="0" marginheight="0" cols="0,*" frameborder="no" border="0" bordercolor="#e6e6e6">
        	<frame marginwidth="0" marginheight="0" name="navFrame" src="{NAV_PAGE_URL/@Value}" noresize="yes" scrolling="no"/>
        	<frame name="appFrame" src="{HOME_PAGE_URL/@Value}" noresize="yes" scrolling="no"/>
        </frameset>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>

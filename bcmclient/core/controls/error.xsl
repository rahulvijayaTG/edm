<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalan="http://xml.apache.org/xalan"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                exclude-result-prefixes="xalan"
                version="1.0">

    <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="_ERRORS" mode="icon_tip">
    <xsl:for-each select="_ERROR">
      <xsl:variable name="alt">
        <i18n:text><xsl:value-of select="./@Value"/></i18n:text>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="@Severity = 'WARNING'">
          &#xA0;<i2:img onclick="javascript:core_warning('{$alt}')" src="/result_warning_sml.gif" alt="{$alt}" border="0" align="middle"/>
        </xsl:when>
        <xsl:otherwise>
          &#xA0;<i2:img onclick="javascript:core_alert('{$alt}')" src="/alert_sml.gif" alt="{$alt}" border="0" align="middle"/>
        </xsl:otherwise>
      </xsl:choose>
      <script>
        <xsl:value-of select="concat('javascript:validation_addMessage(', $quote,  $alt,  $quote, ',', $quote,./../../@containerId, $quote, ');')"/>
      </script>
    </xsl:for-each>

  </xsl:template>

  
  <!-- ********************************************************************** 
  *********************************************************************** -->
</xsl:stylesheet>
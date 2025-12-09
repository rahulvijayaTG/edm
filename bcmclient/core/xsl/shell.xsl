<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:output method="html"/>

<!-- ********************************************************************** 
     *********************************************************************** -->
  <xsl:template match="/RESPONSES/RESPONSE/SHELL">

    <xsl:variable name="helpPath">javascript:window.open("<xsl:value-of select="HELP_ACTION/@Value"/>","popUp4","height=600,width=800,scrollbars=yes,resizable=yes");void(0); </xsl:variable>
    <xsl:variable name="aboutPath">javascript:window.open("<xsl:value-of select="ABOUT_ACTION/@Value"/>","aboutbox","width=394, height=548,scrollbars=auto");void(0);</xsl:variable>

    <xsl:variable name="logout_title"><i18n:text>Log Out</i18n:text></xsl:variable>
    <xsl:variable name="help_title"><i18n:text>Help</i18n:text></xsl:variable>
    <xsl:variable name="about_title"><i18n:text>About</i18n:text></xsl:variable>

      <xsl:choose>
      <xsl:when test="@ForcedLogout = 'true'">
        <i2:shell 
          logo="{@Logo}" 
          background="{@Background}" 
          username="{@UserName}" 
          actions="&lt;a target=\'_top\' href=\'{LOGOUT_ACTION/@Value}\'&gt;{$logout_title}&lt;/a&gt; | &lt;a href=\'{$helpPath}\'&gt;{$help_title}&lt;/a&gt; | &lt;a href=\'{$aboutPath}\'&gt;{$about_title}&lt;/a&gt;" 
          contenturl="{@contenturl}" 
          framed="{@Framed}"/>
      </xsl:when>
      <xsl:otherwise>
        <i2:shell 
            logo="{@Logo}" 
            background="{@Background}" 
            username="{@UserName}" 
            actions="&lt;a target=\'_top\' href=\'javascript:logout()\'&gt;{$logout_title}&lt;/a&gt; | &lt;a href=\'{$helpPath}\'&gt;{$help_title}&lt;/a&gt; | &lt;a href=\'{$aboutPath}\'&gt;{$about_title}&lt;/a&gt;" 
            contenturl="{@contenturl}" 
            framed="{@Framed}"/>
      </xsl:otherwise>
    </xsl:choose>
   
   

  </xsl:template>

<!-- ********************************************************************** 
     *********************************************************************** -->
</xsl:stylesheet>
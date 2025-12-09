<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:output method="html"/>

  <xsl:template match="/RESPONSES/RESPONSE">
    <xsl:variable name="role">
      <xsl:for-each select="ROLE">
        <xsl:if test="position() > 1">,&#xA0;</xsl:if>
        <i18n:text><xsl:value-of select="./@Value"/></i18n:text>
      </xsl:for-each>
    </xsl:variable>

    <!--xsl:variable name="name">
      <xsl:value-of select="/RESPONSES/RESPONSE/USER_PROFILE/CONTACT_INFO_LINK/CONTACT/FIRST_NAME/@Value"/>&#xA0;<xsl:value-of select="/RESPONSES/RESPONSE/USER_PROFILE/CONTACT_INFO_LINK/CONTACT/LAST_NAME/@Value"/>
    </xsl:variable-->

    <xsl:variable name="helpPath">javascript:window.open("<xsl:value-of select="HELP_ACTION/@Value"/>","popUp4","height=275,width=400,scrollbars=yes,resizable=yes");void(0); </xsl:variable>
    <xsl:variable name="aboutPath">javascript:window.open("<xsl:value-of select="ABOUT_ACTION/@Value"/>","aboutbox","width=394, height=548,scrollbars=auto");void(0);</xsl:variable>

    <xsl:variable name="logout_title"><i18n:text>Log Out</i18n:text></xsl:variable>

    <xsl:variable name="help_title"><i18n:text>Help</i18n:text></xsl:variable>

    <xsl:variable name="about_title"><i18n:text>About</i18n:text></xsl:variable>
    
    <xsl:variable name="i18nscenario_string"><i18n:text>Scenario</i18n:text></xsl:variable>
    
    <xsl:variable name="flag"><xsl:value-of select="'true'"/></xsl:variable>

    <xsl:variable name="scenario_string">
      <xsl:if test="string-length(SCENARIO/@Value) &gt; 0">
        <xsl:value-of select="concat('     ',$i18nscenario_string,': ', SCENARIO/@Value)"/>
      </xsl:if>
    </xsl:variable>

     <xsl:choose>
        <xsl:when test="FORCED_LOGOUT/@Value = 'true'">
          <xsl:if test="count(SOLUTION) = 0">
           <i2:shell logo="{MASTHEAD_IMAGE/@Value}" background="../../i2/images/i2shellbackground.gif" username="{$role}: {USERNAME/@Value} {$scenario_string}" actions="&lt;a target=\'_top\' href=\'{LOGOUT_ACTION/@Value}\'&gt;{$logout_title}&lt;/a&gt; | &lt;a href=\'{$aboutPath}\'&gt;{$about_title}&lt;/a&gt;" onload="i2ui_shell_content.location.href='../framework/middle.jsp?ACTIVITY={ACTIVITY/@Value}'"  contenturl="../framework/blank.jsp" framed="yes"/>
          </xsl:if>
          <xsl:if test="(count(SOLUTION) &gt; 0) or (FROMCOMMONUI/@Value='yes')">
           <i2:shell logo="{MASTHEAD_IMAGE/@Value}" background="../../i2/images/i2shellbackground.gif" username="{$role}: {USERNAME/@Value} {$scenario_string}" actions="&lt;a target=\'_top\' href=\'javascript:logout({$flag})\'&gt;{$logout_title}&lt;/a&gt; | &lt;a href=\'{$aboutPath}\'&gt;{$about_title}&lt;/a&gt;" onload="i2ui_shell_content.location.href='../framework/middle.jsp?ACTIVITY={ACTIVITY/@Value}&amp;SOLUTION={SOLUTION/@Value}'"  contenturl="../framework/blank.jsp" framed="yes"/>
          </xsl:if>  


        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="count(SOLUTION) = 0">
           <i2:shell logo="{MASTHEAD_IMAGE/@Value}" background="../../i2/images/i2shellbackground.gif" username="{$role}: {USERNAME/@Value} {$scenario_string}" actions="&lt;a target=\'_top\' href=\'javascript:logout()\'&gt;{$logout_title}&lt;/a&gt; | &lt;a href=\'{$aboutPath}\'&gt;{$about_title}&lt;/a&gt;" onload="i2ui_shell_content.location.href='../framework/middle.jsp?ACTIVITY={ACTIVITY/@Value}'"  contenturl="../framework/blank.jsp" framed="yes"/>
          </xsl:if>
          <xsl:if test="(count(SOLUTION) &gt; 0) or (FROMCOMMONUI/@Value='yes')">
           <i2:shell logo="{MASTHEAD_IMAGE/@Value}" background="../../i2/images/i2shellbackground.gif" username="{$role}: {USERNAME/@Value} {$scenario_string}" actions="&lt;a target=\'_top\' href=\'javascript:logout({$flag})\'&gt;{$logout_title}&lt;/a&gt; | &lt;a href=\'{$aboutPath}\'&gt;{$about_title}&lt;/a&gt;" onload="i2ui_shell_content.location.href='../framework/middle.jsp?ACTIVITY={ACTIVITY/@Value}&amp;SOLUTION={SOLUTION/@Value}'"  contenturl="../framework/blank.jsp" framed="yes"/>
          </xsl:if>


        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
 

</xsl:stylesheet>

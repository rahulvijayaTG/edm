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
  <xsl:template match="SHELL">

    <xsl:variable name="helpPath">javascript:window.open("<xsl:value-of select="@help-action"/>","popUp4","height=600,width=800,scrollbars=yes,resizable=yes");void(0); </xsl:variable>
    <xsl:variable name="aboutPath">javascript:window.open("<xsl:value-of select="@about-action"/>","aboutbox","width=394, height=548,scrollbars=auto");void(0);</xsl:variable>

    <xsl:variable name="logout_title"><i18n:text>Log Out</i18n:text></xsl:variable>
    <xsl:variable name="help_title"><i18n:text>Help</i18n:text></xsl:variable>
    <xsl:variable name="about_title"><i18n:text>About</i18n:text></xsl:variable>

    <script type="text/javascript">

      function logout()
      {
        msg = "Are you sure you really want to log out?"
        var theButtonClicked = core_confirm(msg);
        if (theButtonClicked == 'yes')
        {
          parent.location = "login/controller/logout.x2c";
          return;
        }
        else
        {
          return;
        }
      }

    </script>

      <xsl:choose>
      <xsl:when test="@forced-logout = 'true'">
        <i2:shell
          logo="{@logo}"
          background="{@background}"
          username="{@user-name}"
          actions="&lt;a target=\'_top\' href=\'{@logout-action}\'&gt;{$logout_title}&lt;/a&gt; | &lt;a href=\'{$helpPath}\'&gt;{$help_title}&lt;/a&gt; | &lt;a href=\'{$aboutPath}\'&gt;{$about_title}&lt;/a&gt;"
          navurl="{@nav-url}"
          appurl="{@app-url}"
          framed="{@framed}"/>
      </xsl:when>
      <xsl:otherwise>
        <i2:shell
            logo="{@logo}"
            background="{@background}"
            username="{@user-name}"
            actions="&lt;a target=\'_top\' href=\'javascript:logout()\'&gt;{$logout_title}&lt;/a&gt; | &lt;a href=\'{$helpPath}\'&gt;{$help_title}&lt;/a&gt; | &lt;a href=\'{$aboutPath}\'&gt;{$about_title}&lt;/a&gt;"
            contenturl="{@content-url}"
          navurl="{@nav-url}"
          appurl="{@app-url}"
            framed="{@framed}"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

<!-- **********************************************************************
     *********************************************************************** -->

</xsl:stylesheet>
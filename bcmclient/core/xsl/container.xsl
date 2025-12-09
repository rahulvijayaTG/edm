<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:import href="header.xsl"/>
  <xsl:import href="footer.xsl"/>
  <xsl:import href="wizard.xsl"/>
  <xsl:import href="tabs.xsl"/>

  <xsl:output method="html"/>


  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="CONTAINER" mode="container">
    <xsl:param name="content" select="/RESPONSES"/>
    <xsl:param name="selectedStep" select="STEP[@Selected = 'true']"/>


    <xsl:variable name="editable">
      <xsl:choose>
        <xsl:when test="string-length(STEP[@Selected = 'true']/@Editable) > 0">
          <xsl:value-of select="STEP[@Selected = 'true']/@Editable"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@Editable"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="collapsable">
      <xsl:choose>
        <xsl:when test="string-length(STEP[@Selected = 'true']/@Collapsable) > 0">
          <xsl:value-of select="STEP[@Selected = 'true']/@Collapsable"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@Collapsable"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <xsl:variable name="width">
        <xsl:choose>
          <xsl:when test="@Width">
            <xsl:value-of select="@Width"/>
          </xsl:when>
          <xsl:otherwise>100%</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="height">
        <xsl:if test="@Height">
          <xsl:value-of select="@Height"/>
        </xsl:if>
      </xsl:variable>



    <xsl:variable name="id">
      <xsl:choose>
        <xsl:when test="string-length(STEP[@Selected = 'true']/@Id) > 0">
          <xsl:value-of select="STEP[@Selected = 'true']/@Id"/>
        </xsl:when>
        <xsl:when test="string-length(@Id) > 0">
          <xsl:value-of select="@Id"/>
        </xsl:when>
        <xsl:otherwise>container</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Scrollable -->
    <xsl:variable name="scrollable">
      <xsl:choose>
        <xsl:when test="string-length(@Scrollable)">
          <xsl:value-of select="@Scrollable"/>
        </xsl:when>
        <xsl:otherwise>yes</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Container -->
    <i2:container  id="{$id}" width="{$width}" height="{$height}"  collapsable="{$collapsable}"  stretch="{$selectedStep/@Stretch}" scrollable="{$scrollable}" inner="{$selectedStep/@Inner}">
       <i2:attribute name="title">
       <xsl:choose>
        <xsl:when test="string-length(STEP[@Selected = 'true']/@DisplayText) > 0">
          <b><i18n:text><xsl:value-of select="STEP[@Selected = 'true']/@DisplayText"/></i18n:text></b>
        </xsl:when>
        <xsl:otherwise>
          <b><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text></b>
        </xsl:otherwise>
      </xsl:choose>
     </i2:attribute>
      <xsl:if test="string-length($editable) > 0">
        <i2:attribute name="editable">
          <xsl:value-of select="$editable"/>
        </i2:attribute>
      </xsl:if>
      <!--  Header -->
      <xsl:apply-templates select="STEP[@Selected = 'true' or @Selected = 'yes']" mode="header"/>

     <!-- Content -->
     <xsl:apply-templates select="$content" mode="container_content"/>

      <!--  Footer -->
      <xsl:apply-templates select="STEP[@Selected = 'true' or @Selected = 'yes']" mode="footer"/>

    </i2:container>

  </xsl:template>




  <!-- Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="javascript_resizeContainer">
    i2uiResizeScrollableContainer('container',document.body.offsetHeight - 90, null, document.body.offsetWidth -20, true, 'yes');
  </xsl:template>


<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

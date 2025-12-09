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
    <xsl:template match="CONTAINER" mode="top">
      <xsl:apply-templates select=".">
        <xsl:with-param name="content" select="STEP"/>
      </xsl:apply-templates>
    </xsl:template>

  <!-- **********************************************************************
       *********************************************************************** -->
    <xsl:template match="CONTAINER" mode="layout">
      <xsl:apply-templates select=".">
        <xsl:with-param name="content" select="STEP"/>
      </xsl:apply-templates>
    </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="CONTAINER">
    <xsl:param name="content" select="/RESPONSES"/>


    <xsl:choose>
      <!-- Container -->
      <xsl:when test="(@Hide = 'true')  or (count(STEP) = 1 and( string-length(@Force) = 0  or @Force !='true'))">
        <xsl:apply-templates select="." mode="container">
          <xsl:with-param name="content" select="$content"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- wizard -->
      <xsl:when test="@Type = 'Wizard'">
        <xsl:apply-templates select="." mode="wizard">
          <xsl:with-param name="content" select="$content"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- tabs -->
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="tabs">
          <xsl:with-param name="content" select="$content"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
    <input type="hidden" name="{@Id}_SELECTED_STEP" value="{STEP[@Selected = 'true']/@Id}"/>

  </xsl:template>


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


    <!-- Container -->
    <i2:container  id="{$id}" width="{$width}" height="{$height}"  collapsable="{$collapsable}"  stretch="{$selectedStep/@Stretch}" scrollable="{@Scrollable}" inner="{@Inner}">
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

<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

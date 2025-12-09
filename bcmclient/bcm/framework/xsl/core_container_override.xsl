<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
   <!-- import -->
  <xsl:import href="../../../core/xsl/container.xsl"/>

    <xsl:output method="html"/>


    <!-- ********************* OVERRIDE ***************************************
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
      <i2:container  id="{$id}"  width="100%" collapsable="{$collapsable}"  stretch="{$selectedStep/@Stretch}" scrollable="{$scrollable}" inner="{$selectedStep/@Inner}">
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
        <!--  Footer -->
        <xsl:apply-templates select="." mode="footer"/>

      </i2:container>

    </xsl:template>

    <!-- Tabs -->
    <!-- **********************************************************************
       *********************************************************************** -->
    <xsl:template match="CONTAINER" mode="tabs">
      <xsl:param name="content" select="/RESPONSES"/>

       <xsl:call-template name="include_javascript_links"/>

      <!-- Scrollable -->
      <xsl:variable name="scrollable">
        <xsl:choose>
          <xsl:when test="string-length(@Scrollable)">
            <xsl:value-of select="@Scrollable"/>
          </xsl:when>
          <xsl:otherwise>yes</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <!-- TabbedContainer -->
      <i2:tabbedcontainer  id="container" scrollable="{$scrollable}">

        <!-- Tabs -->
        <i2:tabset id="tabs_container" field="grey">
          <xsl:apply-templates select="STEP" mode="tabs"/>
        </i2:tabset>

        <!-- Header -->
        <xsl:apply-templates select="STEP[@Selected = 'true' or @Selected = 'yes']" mode="header"/>

        <!-- Content -->
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
          <xsl:if test="STEP[(@Selected = 'true' or @Selected = 'yes') and ( @Editable='false' or @Editable = 'no')] ">
            <xsl:attribute name="class">tableRow1</xsl:attribute>
          </xsl:if>
          <tr>
            <td valign="top" nowrap="yes" colspan="2">
              <xsl:apply-templates select="$content" mode="container_content"/>
            </td>
          </tr>
        </table>

        <!--  STEP Footer -->
        <xsl:apply-templates select="STEP[@Selected = 'true' or @Selected = 'yes']" mode="footer"/>
        <!--  CONTANER  Footer -->
        <xsl:apply-templates select="." mode="footer"/>
      </i2:tabbedcontainer>

    </xsl:template>


</xsl:stylesheet>

<?xml version="1.0" standalone="no"?>

<!--

Author             : Sirajudeen Samsudeen
Creation Date   : Jul 19, 2003
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n" version="1.0">

  <xsl:output method="html"/>

  <xsl:variable name="defaultNonScrollableAreaHeight" select="120"/>
  <xsl:variable name="defaultNonScrollableAreaWidth" select="35"/>

  <xsl:template name="generateResizingJavascript">
      function onLoad() {
          <!-- required fields-->
          <xsl:if test="count(/RESPONSES/RESPONSE/PAGE/PRESENTATION/HTML_TABLE/PROPERTY/@Required) > 0 or /RESPONSES/RESPONSE/ERROR_MESSAGE">
            requiredFieldCheck('onLoad');
          </xsl:if>
        <!-- For tabbed container, we have to call different functions in onLoad and onResize -->
        <xsl:apply-templates select="LAYOUT/TABBED_CONTAINER" mode="javascript_onLoad"/>
        onResize();
      }

      function onResize() {
        var scrollableAreaHeight = null;
        var scrollableAreaWidth  = null;

        <xsl:apply-templates select="LAYOUT/*" mode="javascript_onResize"/>
      }
  </xsl:template>

  <xsl:template match="CONTAINER | TABLE" mode="javascript_onResize">
    <xsl:if test="@Scrollable = 'yes' ">
      <xsl:choose>
        <xsl:when test="@ResizeJavascript">
          <xsl:value-of select="@ResizeJavascript"/>;
        </xsl:when>

        <xsl:otherwise>
          <!-- Override the values for nonScrollableAreaHeight and nonScrollableAreaWidth
                if they are provided -->
          <xsl:variable name="nonScrollableAreaHeight">
            <xsl:choose>
              <xsl:when test="@NonScrollableAreaHeight">
                <xsl:value-of select="@NonScrollableAreaHeight"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$defaultNonScrollableAreaHeight"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>

          <xsl:variable name="nonScrollableAreaWidth">
            <xsl:choose>
              <xsl:when test="@NonScrollableAreaWidth">
                <xsl:value-of select="@NonScrollableAreaWidth"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$defaultNonScrollableAreaWidth"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>

          <xsl:variable name="containerHeight">
            <xsl:choose>
              <xsl:when test="@Height">
                <xsl:value-of select="substring-before(@Height, '%')" />
              </xsl:when>
              <xsl:otherwise>100</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>

          <xsl:variable name="containerWidth">
            <xsl:choose>
              <xsl:when test="@Width">
                <xsl:value-of select="substring-before(@Width, '%')" />
              </xsl:when>
              <xsl:otherwise>100</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>

          scrollableAreaHeight = <xsl:value-of select="$containerHeight"/> *
              document.body.offsetHeight / 100 - <xsl:value-of select="$nonScrollableAreaHeight"/>;
          scrollableAreaWidth = <xsl:value-of select="$containerWidth"/> *
              document.body.offsetWidth / 100 - <xsl:value-of select="$nonScrollableAreaWidth"/> ;

          <xsl:choose>
            <xsl:when test="name() = 'CONTAINER' ">
              i2uiResizeScrollableContainer('<xsl:value-of select="@Id"/>', scrollableAreaHeight,
                null, scrollableAreaWidth, true, 'yes');
            </xsl:when>
            <xsl:when test="name() = 'TABLE' ">
              i2uiResizeScrollableArea('<xsl:value-of select="@Id"/>', scrollableAreaHeight,
                  scrollableAreaWidth, null, null, null,5, null);
<!--              i2uiResizeColumns('<xsl:value-of select="@Id"/>');-->
            </xsl:when>
          </xsl:choose>

        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <!-- Process any containers/tables inside this container. Table cannot contain
          any other layout components inside. -->
    <xsl:if test="name() = 'CONTAINER' ">
      <xsl:apply-templates mode="javascript_onResize"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="TABBED_CONTAINER" mode="javascript_onLoad">
    <xsl:if test="@Scrollable = 'yes' ">
      var tabSetWidth = document.body.offsetWidth - <xsl:value-of select="@nonScrollableAreaWidth"/>;
      i2uiManageTabs('<xsl:value-of select="@Id"/>', tabSetWidth);
    </xsl:if>

    <xsl:apply-templates select="TABBED_CONTAINER" mode="javascript_onLoad"/>
  </xsl:template>

  <xsl:template match="TABBED_CONTAINER" mode="javascript_onResize">
    <xsl:if test="@Scrollable = 'yes' ">
      i2uiResetTabs('<xsl:value-of select="@Id"/>');
    </xsl:if>

    <xsl:apply-templates mode="javascript_onResize"/>
  </xsl:template>

</xsl:stylesheet>
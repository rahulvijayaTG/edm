<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:import href="../../../core/xsl/links.xsl"/>      

  <xsl:output method="html"/>

  <!-- Support Existing Start:: -->

  <!-- Root Entry point -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="/" >
    <xsl:apply-templates select="RESPONSES/RESPONSE/TABS"/>
  </xsl:template>

  <!-- Support Existing End. -->


  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="TABS">
    <xsl:param name="tabContent" select="/RESPONSES"/>


    <xsl:call-template name= "include_javascript_links"/>


    <xsl:choose>
      <!-- Container -->
      <xsl:when test="(@Hide = 'true')  or (count(TAB) = 1 and( string-length(@Force) = 0  or @Force !='true'))">
        <xsl:apply-templates select="." mode="container">
          <xsl:with-param name="tabContent" select="$tabContent"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- tabs -->
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="tabs">
          <xsl:with-param name="tabContent" select="$tabContent"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- Tabs -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="TABS" mode="tabs">
    <xsl:param name="tabContent" select="/RESPONSES"/>

    <!-- Scrollable -->
    <xsl:variable name="scrollable">
      <xsl:choose>
        <xsl:when test="string-length(@Scrollable)">
          <xsl:value-of select="@Scrollable"/>
        </xsl:when>
        <xsl:otherwise>no</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- TabbedContainer -->
    <i2:tabbedcontainer  id="container" scrollable="{$scrollable}">

      <!-- Tabs -->
      <i2:tabset id="tabs_container" field="grey">
        <xsl:apply-templates select="TAB" mode="tabs"/>
      </i2:tabset>

      <!-- Header -->
      <xsl:call-template name="header"/>

      <!-- Content -->
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <xsl:if test="TAB[(@Selected = 'true' or @Selected = 'yes') and ( @Editable='true' or @Editable = 'yes')] ">
          <xsl:attribute name="class">tableRow1</xsl:attribute>
        </xsl:if>
        <tr>
          <td valign="top" nowrap="yes" colspan="2">
            <xsl:apply-templates select="$tabContent"/>
          </td>
        </tr>
      </table>

      <!--  Footer -->
      <xsl:call-template name="footer"/>

    </i2:tabbedcontainer>

  </xsl:template>


  <!-- Container -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="TABS" mode="container">
    <xsl:param name="tabContent" select="/RESPONSES"/>

    <!-- Title -->
    <xsl:variable name="title">
      <i18n:text><xsl:value-of select="TAB[@Selected = 'true' or @Selected = 'yes']/@DisplayText"/></i18n:text>
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
    <i2:container id="container" title="{$title}" width="100%"  scrollable="{$scrollable}">

      <!--  Header -->
      <xsl:call-template name="header"/>

      <!-- Content -->
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <xsl:if test="TAB[(@Selected = 'true' or @Selected = 'yes') and ( @Editable='true' or @Editable = 'yes')] ">
          <xsl:attribute name="class">tableRow1</xsl:attribute>
        </xsl:if>
        <tr>
          <td valign="top" nowrap="yes" colspan="2">
            <xsl:apply-templates select="$tabContent"/>
          </td>
        </tr>
      </table>

      <!--  Footer -->
      <xsl:call-template name="footer"/>

    </i2:container>

  </xsl:template>


  <!-- Tab -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TAB" mode="tabs">
    <i2:tab alttext="{@AltText}" onclick="{@OnClick}" selected="{@Selected}" target="{$target}" hotkey="@HotKey">
      <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
    </i2:tab>
  </xsl:template>


  <!-- Header -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="header">

    <!-- Header/Help -->
    <i2:header>
      <table border="0" cellpadding="2" cellspacing="0" width="100%">
        <tr>
          <td align="right">
            <table border="0" cellpadding="0" cellspacing="0" align="right">
              <tr>


                <xsl:choose>
                  <!-- All tabs header -->
                  <xsl:when test = "HEADER/LINK">
                    <xsl:apply-templates select="HEADER/LINK"/>
                  </xsl:when>
                </xsl:choose>


                <xsl:choose>
                  <!-- Selected tabs help -->
                  <xsl:when test = "TAB[@Selected = 'true' or @Selected = 'yes']/HELP">
                    <xsl:apply-templates select="TAB[@Selected = 'true' or @Selected = 'yes']/HELP"/>
                  </xsl:when>
                  <!-- All tabs help -->
                  <xsl:when test = "HELP">
                    <xsl:apply-templates select="HELP"/>
                  </xsl:when>
                </xsl:choose>


              </tr>
            </table>
          </td>
        </tr>
      </table>

    </i2:header>

  </xsl:template>


  <!-- Footer -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="footer">

    <xsl:variable name="formName">
      <xsl:choose>
        <xsl:when test="count(TAB[@Selected = 'true' or @Selected = 'yes']/PAGINATION) > 0 or count(PAGINATION) > 0">
          <xsl:value-of select="'search_footer_form'"/>
        </xsl:when>
        <xsl:otherwise>no_form</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:if test="count(BUTTONS) > 0 or count(TAB[@Selected = 'true' or @Selected = 'yes']/BUTTONS) > 0 or  count(TAB[@Selected = 'true' or @Selected = 'yes']/PAGINATION) > 0 or count(PAGINATION) > 0">

      <!--  Footer -->
      <i2:footer>
        <table cellspacing="0" cellpadding="0" width="100%"  border="0">
          <form name="{$formName}">
            <tr>
              <!-- Pagination -->
              <td>
                <xsl:apply-templates select="PAGINATION"/>
              </td>

              <td>
                <xsl:apply-templates select="TAB[@Selected = 'true' or @Selected = 'yes']/PAGINATION"/>
              </td>

              <!-- Common Buttons (All tabs) -->
              <td  align="right">
                <xsl:apply-templates select="BUTTONS"/>
              </td>
              <!-- Selected Tab's Buttons -->
              <td>
                <xsl:apply-templates select="TAB[@Selected = 'true' or @Selected = 'yes']/BUTTONS"/>
              </td>
            </tr>
            <xsl:if test="count(PAGINATION) > 0 or count(TAB[@Selected = 'true' or @Selected = 'yes']/PAGINATION ) > 0">
              <input type="hidden" name="RECORD_COUNT" value="{$totalRecordCount}"/>
              <input type="hidden" name="START_COUNT" value="{$startAtRow}"/>
            </xsl:if>
          </form>
        </table>

      </i2:footer>
    </xsl:if>
  </xsl:template>



  <!-- Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="javascript_initTabs">
    i2uiResizeScrollableContainer('container',document.body.offsetHeight - 105, null, document.body.offsetWidth -20, true, 'yes');
    i2uiResizeScrollableContainer('tabs_container_description',document.body.offsetHeight - 105, null, document.body.offsetWidth -20, true, 'yes');
  </xsl:template>


  <!-- Target -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:variable name="target">
    <xsl:choose>
      <xsl:when test="string-length(/RESPONSES/RESPONSE/TABS/@Target) > 0"><xsl:value-of select="/RESPONSES/RESPONSE/TABS/@Target"/></xsl:when>
      <xsl:otherwise>appFrame</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

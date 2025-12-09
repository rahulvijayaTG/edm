<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <!-- Exising - Support Start::-->
  <xsl:import href="../../../bcm/framework/xsl/tabs2.xsl"/>
  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../core/xsl/pagination.xsl"/>
  <xsl:import href="../../../core/xsl/form.xsl"/>
  <xsl:import href="../../../bcm/framework/xsl/table.xsl"/>
  <xsl:import href="../../../bcm/framework/xsl/buttons.xsl"/>
  <xsl:import href="../../../core/xsl/links.xsl"/>
 
  <xsl:output method="html"/>

  <xsl:template match = "RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/TABS">
      <xsl:with-param name="tabContent" select="RESPONSE/SEARCH"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- Exising - Support End.-->


<!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="SEARCH">

    <!-- Javascript -->
    <i2:javascript path="/search.js"></i2:javascript>
    <i2:javascript path="/calendar.js"></i2:javascript>
    <i2:javascript path="/date_validation.js"></i2:javascript>

    <!-- Search Form -->
    <xsl:apply-templates select="FORM"/>

    <!-- Search Error -->
    <xsl:apply-templates select="REPORT/_ERROR"/>

    <!-- Search Report -->
     <xsl:apply-templates select="REPORT/TABLE"/>

  </xsl:template>


  <!-- Popup -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="hide_i2uiPopupmenu">
    <i2:popupmenu name="sortOrder">
      <i2:popupmenuoption  url="javascript:sortOrder('Ascending')"><i2:attribute name="text"><i18n:text>Ascending</i18n:text></i2:attribute></i2:popupmenuoption>
      <i2:popupmenuoption  url="javascript:sortOrder('Descending')"><i2:attribute name="text"><i18n:text>Descending</i18n:text></i2:attribute></i2:popupmenuoption>
    </i2:popupmenu>
  </xsl:template>



  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
      requiredFieldCheck('onLoad')
      resizeScrollableTables();
      setFocus();

      <xsl:call-template name="javascript_initTabs"/>
      <xsl:call-template name="javascript_onLoad_page"/>
      onResize();
    }
  </xsl:template>


  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onResize_js">
    function onResize()
    {
      resizeScrollableTables();
      <xsl:call-template name="javascript_initTabs"/>
      <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>



  <!-- **********************************************************************
       *********************************************************************** -->


  <!-- Sort Image -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:variable name="sortImage">
    <xsl:choose>
      <xsl:when test="/RESPONSES/RESPONSE/SEARCH/FORM/FIELD[@Name = 'SORT_ORDER']/@Value = 'Descending'">
        &#xA0;&#xA0;&#xA0;&lt;img src="../../i2/images/descending_table_column.gif"/&gt;
      </xsl:when>
      <xsl:when test="/RESPONSES/RESPONSE/SEARCH/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_ORDER']/@Value = 'Descending'">
        &#xA0;&#xA0;&#xA0;&lt;img src="../../i2/images/ascending_table_column.gif"/&gt;
      </xsl:when>
      <xsl:otherwise>
        &#xA0;&#xA0;&#xA0;&#xA0;&lt;img src="../../i2/images/ascending_table_column.gif"/&gt;
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Sort By -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:variable name="sortBy">
    <xsl:choose>
      <xsl:when test="string-length(/RESPONSES/RESPONSE/SEARCH/FORM/FIELD[@Name= 'SORT_BY']/@Value) > 0">
        <xsl:value-of select = "/RESPONSES/RESPONSE/SEARCH/FORM/FIELD[@Name= 'SORT_BY']/@Value"/>
      </xsl:when>
      <xsl:when test="string-length(/RESPONSES/RESPONSE/SEARCH/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_BY']/@Value) > 0 ">
        <xsl:value-of select = "/RESPONSES/RESPONSE/SEARCH/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_BY']/@Value"/>
      </xsl:when>
      <xsl:otherwise>ID</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:variable name="noOfColumns"><xsl:value-of select="count(/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[position() = 1])"/></xsl:variable>
  <xsl:variable name="noOfRows"><xsl:value-of select="count(/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[not(@Type) or @Type != 'Hidden']) -1"/></xsl:variable>
  <xsl:variable name="totalRecordCount"><xsl:value-of select="/RESPONSES/RESPONSE/SEARCH/REPORT/@TotalRecordCount"/></xsl:variable>
  <xsl:variable name="startAtRow"><xsl:value-of select="/RESPONSES/RESPONSE/SEARCH/REPORT/@StartAtRow"/></xsl:variable>
  <xsl:variable name="maxRows"><xsl:value-of select="/RESPONSES/RESPONSE/SEARCH/REPORT/@MaxRows"/></xsl:variable>



  <!-- Search Error -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match = "_ERROR">

    <table  width="100%"   cellspacing="1" cellpadding="0" border="0">
      <tr>
        <td>
          <!-- Title -->
          <xsl:variable name="title">
            &lt;b&gt;<i18n:text>Search Error</i18n:text>&lt;/b&gt;:&#xA0;&lt;i&gt;<xsl:value-of select="@Description"/>
          </xsl:variable>

          <i2:container inner="yes" title="{$title}">
          </i2:container>
        </td>
      </tr>
    </table>
  </xsl:template>

<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

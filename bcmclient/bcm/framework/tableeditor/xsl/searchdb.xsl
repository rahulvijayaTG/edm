<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../../core/xsl/links.xsl"/>
  <xsl:import href="dbtable.xsl"/>

  <xsl:output method="html"/>
<!-- **********************************************************************
     *********************************************************************** -->
     
  <xsl:variable name="formName">result_form</xsl:variable>
  <xsl:variable name="tableId">result_table</xsl:variable>
  <xsl:variable name="tableContainerId">result_container</xsl:variable>


<!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="SEARCH">

    <!-- Javascript -->
    <xsl:call-template name="include_javascript_search"/>

    <!-- Search Error -->
    <xsl:apply-templates select="REPORT/_ERROR"/>

    <!-- Table Editor Search Report -->
     <xsl:apply-templates select="REPORT/TABLE"/>

  </xsl:template>


  <!-- Popup -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <!--xsl:variable name="frozenColumn">
    <xsl:choose>
      <xsl:when test="string-length(/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_BY']/@Value) > 0 ">
        <xsl:value-of select = "true"/>
      </xsl:when>
      <xsl:otherwise>
           <xsl:value-of select = "false"/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:variable-->


  <xsl:template name="hide_i2uiPopupmenu">
    <i2:popupmenu name="sortOrder">
      <i2:popupmenuoption  url="javascript:sortOrder('Ascending')"><i2:attribute name="text"><i18n:text>Ascending</i18n:text></i2:attribute></i2:popupmenuoption>
      <i2:popupmenuoption  url="javascript:sortOrder('Descending')"><i2:attribute name="text"><i18n:text>Descending</i18n:text></i2:attribute></i2:popupmenuoption>
      <!--i2:popupmenuoption  url="javascript:hideIt()"><i2:attribute name="text"><i18n:text>Hide</i18n:text></i2:attribute></i2:popupmenuoption>
      <i2:popupmenuoption  url="javascript:showAll()"><i2:attribute name="text"><i18n:text>Show All</i18n:text></i2:attribute></i2:popupmenuoption-->
      <i2:popupmenuoption  url="javascript:unfreeze()"><i2:attribute name="text"><i18n:text>Unfreeze</i18n:text></i2:attribute></i2:popupmenuoption>
      <i2:popupmenuoption  url="javascript:freeze()"><i2:attribute name="text"><i18n:text>Freeze</i18n:text></i2:attribute></i2:popupmenuoption>
    </i2:popupmenu>
    <i2:popupmenu name="sortOrder_noFreeze">
      <i2:popupmenuoption  url="javascript:sortOrder('Ascending')"><i2:attribute name="text"><i18n:text>Ascending</i18n:text></i2:attribute></i2:popupmenuoption>
      <i2:popupmenuoption  url="javascript:sortOrder('Descending')"><i2:attribute name="text"><i18n:text>Descending</i18n:text></i2:attribute></i2:popupmenuoption>
      <!--i2:popupmenuoption  url="javascript:hideIt()"><i2:attribute name="text"><i18n:text>Hide</i18n:text></i2:attribute></i2:popupmenuoption>
      <i2:popupmenuoption  url="javascript:showAll()"><i2:attribute name="text"><i18n:text>Show All</i18n:text></i2:attribute></i2:popupmenuoption-->
    </i2:popupmenu>
    <i2:popupmenu name="editorMenu">
      <!--i2:popupmenuoption  url="javascript:hideIt()"><i2:attribute name="text"><i18n:text>Hide</i18n:text></i2:attribute></i2:popupmenuoption>
      <i2:popupmenuoption  url="javascript:showAll()"><i2:attribute name="text"><i18n:text>Show All</i18n:text></i2:attribute></i2:popupmenuoption-->
        <i2:popupmenuoption  url="javascript:unfreeze()"><i2:attribute name="text"><i18n:text>Unfreeze</i18n:text></i2:attribute></i2:popupmenuoption>
        <i2:popupmenuoption  url="javascript:freeze()"><i2:attribute name="text"><i18n:text>Freeze</i18n:text></i2:attribute></i2:popupmenuoption>
    </i2:popupmenu>
    <i2:popupmenu name="editorMenu_noFreeze">
      <!--i2:popupmenuoption  url="javascript:hideIt()"><i2:attribute name="text"><i18n:text>Hide</i18n:text></i2:attribute></i2:popupmenuoption>
      <i2:popupmenuoption  url="javascript:showAll()"><i2:attribute name="text"><i18n:text>Show All</i18n:text></i2:attribute></i2:popupmenuoption-->
    </i2:popupmenu>

  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="dbeditor_i2uiPopupmenu">
    <i2:popupmenu name="editorMenu">
      <!--i2:popupmenuoption  url="javascript:hideIt()"><i2:attribute name="text"><i18n:text>Hide</i18n:text></i2:attribute></i2:popupmenuoption>
      <i2:popupmenuoption  url="javascript:showAll()"><i2:attribute name="text"><i18n:text>Show All</i18n:text></i2:attribute></i2:popupmenuoption-->
        <i2:popupmenuoption  url="javascript:unfreeze()"><i2:attribute name="text"><i18n:text>Unfreeze</i18n:text></i2:attribute></i2:popupmenuoption>
        <i2:popupmenuoption  url="javascript:freeze()"><i2:attribute name="text"><i18n:text>Freeze</i18n:text></i2:attribute></i2:popupmenuoption>
    </i2:popupmenu>
  </xsl:template>

  <!-- **********************************************************************
       *********************************************************************** -->
 <xsl:template name="include_javascript_search">
  <script>
  </script>
</xsl:template>
  <!-- Sort Image -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:variable name="sortImage">
    <xsl:choose>
      <xsl:when test="/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_ORDER']/@Value = 'Descending'">
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
      <xsl:when test="string-length(/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_BY']/@Value) > 0 ">
        <xsl:value-of select = "/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_BY']/@Value"/>
      </xsl:when>
      <xsl:otherwise>ID</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:variable name="noOfColumns"><xsl:value-of select="count(/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[position() = 1])"/></xsl:variable>
  <xsl:variable name="noOfRows"><xsl:value-of select="count(/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[not(@Type) or @Type != 'Hidden']) -2"/></xsl:variable>
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

  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {

      resizeScrollableTables();
      <xsl:if test="string-length(/RESPONSES/RESPONSE/ERROR_MESSAGE/@Value) > 0 or string-length(/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value) > 0">
           requiredFieldCheck('onLoad');
     </xsl:if>
     setFocus();

    }
  </xsl:template>

<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

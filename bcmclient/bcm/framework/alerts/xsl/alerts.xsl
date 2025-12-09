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
  <xsl:import href="searchtable.xsl"/>
  <xsl:import href="../../xsl/buttons.xsl"/>
  <xsl:output method="html"/>


  <xsl:variable name="noOfColumns"><xsl:value-of select="count(/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[position() = 1])"/></xsl:variable>
  <xsl:variable name="noOfRows"><xsl:value-of select="count(/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[not(@Type) or @Type != 'Hidden']) -1"/></xsl:variable>

  <!-- Pagination.xsl - Start:: -->
  <xsl:variable name="totalRecordCount"><xsl:value-of select="/RESPONSES/RESPONSE/SEARCH/REPORT/@TotalRecordCount"/></xsl:variable>
  <xsl:variable name="startAtRow"><xsl:value-of select="/RESPONSES/RESPONSE/SEARCH/REPORT/@StartAtRow"/></xsl:variable>
  <xsl:variable name="maxRows"><xsl:value-of select="/RESPONSES/RESPONSE/SEARCH/REPORT/@MaxRows"/></xsl:variable>

  <!-- Page.xsl -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match = "RESPONSES" mode="content">
    <xsl:call-template name="include_javascript_alerts"/>
    <xsl:call-template name="include_javascript_alerts_resize"/>

     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="tabs">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>

  </xsl:template>

  <!-- Page.xsl -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="hide_i2uiPopupmenu">
    <i2:popupmenu name="sortOrder">
      <i2:popupmenuoption  url="javascript:sortOrder('Ascending')"><i2:attribute name="text"><i18n:text>Ascending</i18n:text></i2:attribute></i2:popupmenuoption>
        <i2:popupmenuoption  url="javascript:sortOrder('Descending')"><i2:attribute name="text"><i18n:text>Descending</i18n:text></i2:attribute></i2:popupmenuoption>
    </i2:popupmenu>
  </xsl:template>


  <!-- Container.xsl -->
  <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template match = "RESPONSE" mode="container_content">
    <!-- Form -->
     <xsl:apply-templates select="SEARCH/FORM"/>

    <!-- Report -->
     <xsl:apply-templates select="SEARCH/REPORT/TABLE"/>

  </xsl:template>


  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_onLoad">
  <script>
  function onLoad()
  {
    <xsl:call-template name="javascript_onLoad_page"/>

    // resize Everyting
    parentIsScolling = resizeContainers_alerts();

    // if parent not scrolling
    if (parentIsScolling == false)
    {
      // determine if parent is really not scrolling
      var obj = document.getElementById('container_scroller');
      if(obj)
      {
        // if the parent is now scrolling
        if ((obj.clientWidth &lt; obj.offsetWidth))
        {
          // resize again so that table vertical scrollbar
          //  is not hidden behind parents vertical scrollabar
          resizeContainers_alerts();
        }
      }
    }
  }
  </script>
  </xsl:template>

  <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template name="include_javascript_onResize">
  <script>
    function onResize()
    {
      <xsl:call-template name="javascript_onResize_page"/>
      resizeContainers_alerts();
    }
  </script>
  </xsl:template>

 <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="include_javascript_alerts_resize">
  <script>
  <![CDATA[
  // Resizing All containers
    function resizeContainers_alerts()
    {
      parentContainer_id = 'tabs_container_description';
      parentContainerScroller_id = parentContainer_id + '_scroller';
      parentIsScrolling = false;

      table_id = 'result_form_table';
      table_container_id = 'result_form_container';
      search_form_container_id = 'search_form_container'

      // resize top level container
      i2uiResizeScrollableContainer(parentContainer_id,document.body.offsetHeight - 90, null, document.body.offsetWidth -20, true, 'yes');


      var width = document.body.offsetWidth - 25;
        var height = document.body.scrollHeight - 100;

      // resize table   approx
      i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null)
      i2uiResizeColumns(table_id);


      // if parent container is scrolling
      var obj = document.getElementById(parentContainerScroller_id);
      if(obj)
      {
        // subtract its scrollbar
        width = width- (obj.offsetWidth - obj.clientWidth) ;
        if ((obj.offsetWidth - obj.clientWidth) > 0)
        {
          parentIsScrolling = true;
        }

      }

     tablewidth = width-16; // for now

     // resize table
     i2uiResizeScrollableArea(table_id, height, tablewidth, null, null, null,null, null)
     i2uiResizeColumns(table_id);
     // resize the table container
     i2uiResizeScrollableContainer(table_container_id, document.body.offsetHeight - 20, null, width  , true, 'yes');

     // resize top level container
     i2uiResizeScrollableContainer(parentContainer_id,document.body.offsetHeight - 20, null, document.body.offsetWidth -20, true, 'yes');

     // resize the search container
     i2uiResizeScrollableContainer(search_form_container_id,document.body.offsetHeight - 20, null, width  , true, 'yes');

     // resize top level container
     i2uiResizeScrollableContainer(parentContainer_id,document.body.offsetHeight - 90, null, document.body.offsetWidth -20, true, 'yes');

     return parentIsScrolling;
  }

// Pagination
function getRecords(actionName, startCount, result_form, page_form)
{
    if(page_form == null)  page_form = document.search_footer_form;
    if(page_form == null)  page_form = document.result_form;

    if(result_form == null || result_form == 'null')  result_form = document.result_form;

    jumpToPage(actionName, startCount, result_form, page_form);
}

  function jumpToPage(actionName, startCount, result_form, page_form)
{
    var nextCount = parseInt(startCount) + maxRows;
    var prevCount = 0;

    if (startCount == null)
      startCount=page_form.pagenum.value;

    if ( parseInt(startCount) > 0 )
        prevCount = parseInt(startCount) - maxRows;


    var pagenum= parseInt(startCount);  pagenum--;

    if (actionName == "jump")
    {
      if(( page_form.RECORD_COUNT.value == 0 || page_form.RECORD_COUNT.value > pagenum*maxRows)  && (pagenum+1>0) && (page_form.START_COUNT.value != pagenum*maxRows))
      {
          result_form.DO_SEARCH.value='Yes';
          result_form.START_COUNT.value=pagenum*maxRows;
          result_form.target="appFrame";
          displayBusyBox();
          result_form.submit();
        }
    else
    {
      core_alert("PAGINATION_ALERT");
    }
     }
}
 

// Sorting
function sort(value)
{
    document.result_form.reset();
    document.result_form.SORT_BY.value=value;

    i2uiShowMenu('sortOrder');
}

function SetfocusSubmit( target )
{   
  if(target.name == 'pagenum')
  {
    getRecords('jump');
  }
}  



]]>
</script>

</xsl:template>


  <!-- Table.xsl - Start::-->
  <!-- **********************************************************************
       *********************************************************************** -->

  <!-- Pagination.xsl - End. -->

  <!-- Sorting Start:: -->

  <!-- Sort Image -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:variable name="sortImage">
    <xsl:choose>
      <xsl:when test="/RESPONSES/RESPONSE/SEARCH//REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_ORDER']/@Value = 'Descending'">
<!--
        &#xA0;&#xA0;&#xA0;&lt;i2:img src="/descending_table_column.gif"/&gt;
-->
        &#xA0;&#xA0;&#xA0;<i2:img src="/descending_table_column.gif" alt="Descending"/>
      </xsl:when>
      <xsl:otherwise>
<!--
        &#xA0;&#xA0;&#xA0;&#xA0;&lt;i2:img src="/ascending_table_column.gif"/&gt;
-->
        &#xA0;&#xA0;&#xA0;<i2:img src="/ascending_table_column.gif" alt="Ascending"/>
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
      <xsl:when test="string-length(/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_BY']/@Value) > 0 ">
        <xsl:value-of select = "/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_BY']/@Value"/>
      </xsl:when>
      <xsl:otherwise>ID</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Sorting - End. -->
<!-- Table - End. -->

<!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template name="include_javascript_alerts">

  <i2:javascript path="/search.js"></i2:javascript>

  <script>
      var totalRecordCount = <xsl:value-of select="$totalRecordCount"/>  
      var maxRows = <xsl:value-of select="$maxRows"/>
      var max_rows = "<xsl:value-of select="$maxRows"/>";
      var startCount = "<xsl:value-of select="$startAtRow"/>";

    // Sorting
    function sort(value)
    {
        document.result_form.reset();
        document.result_form.SORT_BY.value=value;
        i2uiShowMenu('sortOrder');
    }

    function sortOrder(order)
    {
        document.result_form.SORT_ORDER.value=order;
        document.result_form.START_COUNT.value=0;
        document.result_form.submit();
    }
  </script>

  <script>

  <![CDATA[
  function onClear()
  {
    if(checkifAnySelected(document.result_form))
    {
      document.result_form.target="appFrame";
      document.result_form.method="POST";
      document.result_form.action= "data_management/controller/clear.cmd";
      displayBusyBox();
      result_form.START_COUNT.value=0;
      document.result_form.submit();
    }
    else
    {
      core_alert("PLEASE_SELECT_ALERT");
    }
    return;
  }
  
  function display(url,prty)
  {
        document.result_form.action=url+"?PRIORITY="+prty;
        result_form.START_COUNT.value=0;
        displayBusyBox();
        document.result_form.submit();
  }
]]>
</script>
</xsl:template>
<!-- **********************************************************************
      *********************************************************************** -->
</xsl:stylesheet>
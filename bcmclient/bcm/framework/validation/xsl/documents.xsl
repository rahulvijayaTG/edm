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
  <!-- importing different search xsl to display only one date field -->
  <xsl:import href="../../../../omx/search/xsl/search.xsl"/>
  <i2:javascript path="/search.js"></i2:javascript>

  <xsl:output method="html"/>

  <!-- Page.xsl -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match = "RESPONSES" mode="content">

    <xsl:call-template name="include_javascript_alerts"/>
    <xsl:call-template name="include_javascript_alerts_resize"/>

     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
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
     <xsl:apply-templates select="SEARCH">
     </xsl:apply-templates>
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


  <!-- Current.xsl - Javascript -->
  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="include_javascript_alerts">
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

]]>
</script>

</xsl:template>


<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>
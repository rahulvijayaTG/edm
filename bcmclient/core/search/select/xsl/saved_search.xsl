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
  <xsl:import href="../../../../core/search/xsl/search.xsl"/>

  <xsl:output method="html"/>


  <!-- Page Title -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="page_title">  
    <i18n:text>Select Saved Searches</i18n:text>
  </xsl:template>

  <!-- Page Content -->  
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">
   
     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>

    <xsl:call-template name="include_javascript_current"/>
    <xsl:call-template name="include_javascript_resize"/>

  </xsl:template>
  
  <!-- Container Content -->
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
        onLoadSuper();//Page.xsl
        resizeContainers();
        setFocus();
      }
    </script>
  </xsl:template>
  
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template name="include_javascript_onResize">  
    <script>
      function onResize()
      {
        onResizeSuper();//Page.xsl
        resizeContainers();
      }
    </script>
  </xsl:template>
  

  <!-- Current.xsl Javascript -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="include_javascript_current">  
    <script>
      function onDelete()
      {
        if (checkifAnySelected(document.result_form))
        {
          document.result_form.target="appFrame";
          document.result_form.action="saved_search/controller/delete.x2c";
          document.result_form.submit();
        }
      }
    
    </script>
  </xsl:template>   

 <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template name="include_javascript_resize">
  <script>

  <![CDATA[
  // Resizing All containers 
    function resizeContainers()
    {
      parentContainer_id = 'container';
      parentContainerScroller_id = parentContainer_id + '_scroller';
      parentIsScrolling = false;

      table_id = 'result_form_table';
      table_container_id = 'result_form_container';
      search_form_container_id = 'search_form_container'
   
      // resize top level container 
      i2uiResizeScrollableContainer(parentContainer_id,document.body.offsetHeight - 70, null, document.body.offsetWidth -20, true, 'yes');


      var width = document.body.offsetWidth - 25;  
      var height = document.body.scrollHeight - 70;
    
      // resize table   approx
      i2uiResizeScrollableArea(table_id, height, width-16, null, null, null,null, null)    
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
     i2uiResizeScrollableContainer(parentContainer_id,document.body.offsetHeight - 70, null, document.body.offsetWidth -20, true, 'yes');
    
     return parentIsScrolling; 
  }
  ]]>
  </script>

</xsl:template>

<!-- ********************************************************************** 
     *********************************************************************** -->
</xsl:stylesheet>   

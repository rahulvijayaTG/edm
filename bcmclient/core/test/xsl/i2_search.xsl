<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                 version="1.0">

  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../core/search/xsl/search.xsl"/>

                 
  <!-- Page Title -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="page_title">  
    <i18n:text><xsl:value-of select="/RESPONSES/RESPONSE/SEARCH/FORM/@DisplayText"/></i18n:text>
  </xsl:template>
  
  <!-- Page.xsl --> 
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">
            
    <xsl:apply-templates select="RESPONSE/SEARCH">
    </xsl:apply-templates>
     
     <xsl:call-template name="include_javascript_search_resize_form_table"/>
     <xsl:call-template name="include_javascript_current"/>

  </xsl:template>
  
  
  
  <!-- page.xsl Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="include_javascript_onLoad">  
    <script>
      function onLoad()
      {
        onLoadSuper();//Page.xsl
        setFocus();

        <xsl:if test="count(/RESPONSES/RESPONSE/SEARCH/FORM/FIELD/_ERRORS) = 0 and count(/RESPONSES/RESPONSE/SEARCH/FORM/FIELD[@Required = 'true']) = 0 ">
          i2uiToggleItemVisibility('instruction_area', 'hide');
        </xsl:if>
    
        i2uiManageTreeTableUserFunction = 'onClickNorgie';
        i2uiToggleContentUserFunction = 'onClickNorgie';

        resizeContainers(0,0);
        
        highlightSelectedRows(result_form); 
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
        resizeContainers(0,0);
      }
    </script>
  </xsl:template>
  

 <!-- Current.xsl Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="include_javascript_current">  
  <script>
  <![CDATA[
  
    function validate_search()
    {
      var bIsFormValid = isFormValid('search_form') &&
        isValid_compare_date(document.search_form,'VALID_DATE_FIRST_DC','VALID_DATE_LAST_DC', '<', null,'To Date should be greater that From Date');
      return   bIsFormValid;
    }
  ]]>

    function onSaveSearch()
    {
      if ( validateSaveSearch() == true )
      {
        document.search_form.action='program/controller/save.x2c';
        document.search_form.submit();
      }
    }
    
    function downloadDocument() 
    {
      if ( checkifAnySelected(result_form) == true )
      {
        document.result_form.target = "i2ui_shell_bottom";          
        document.result_form.action='program/controller/downloadDocument.x2c';
        document.result_form.submit();
      } 
      else
      {
        core_alert("Please select a program to download.");
      } 
    }
    
    function saveReport()
    {
      if ( checkifAnySelected(result_form) == true )
      {
        document.result_form.target = "i2ui_shell_bottom";          
        document.result_form.action='program/controller/saveReport.x2c';
        document.result_form.submit();
      } 
      else
      {  
        core_alert("Please select rows to save.");
      } 
    }

    


  </script>

  </xsl:template>

<!-- ********************************************************************** 
       *********************************************************************** -->
</xsl:stylesheet>
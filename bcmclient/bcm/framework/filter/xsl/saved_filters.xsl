<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalan="http://xml.apache.org/xalan"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                exclude-result-prefixes="xalan"
                version="1.0">


  <!-- Core -->
  <xsl:import href="../../queryform/xsl/searchformfilter.xsl"/>
  <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>

  <xsl:output method="html"/>

  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">
     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>          
     <xsl:call-template name="include_javascript_tableeditor_filter"/>
  </xsl:template>

   <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">
    <table id="filter_table" width="100%">
        <tr>
          <td>
                <xsl:apply-templates select="SEARCH">
                  <xsl:with-param name="formName" select="'result_form'"/>
                </xsl:apply-templates>
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
         resize_Containers();
      }
    </xsl:template>
   <xsl:template name="onResize_js">
      function onResize()
      {
         resize_Containers();
      }
    </xsl:template>
  <!-- Javascript -->
 <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="include_javascript_tableeditor_filter">
  <script>
   <![CDATA[

   function dispatchSearch()
   {
        document.result_form.target="appFrame";
        document.result_form.action="saved_filters.jsp";
        document.result_form.submit();

   }
   function onClearFilter()
	 {
	     clearFields(result_form);
	     dispatchSearch();
   }    

   function onCreate()
   {
        document.result_form.target="appFrame";
        document.result_form.action="controller/createFilter.cmd";
        document.result_form.submit();

   }
   function onEdit()
   {
        document.result_form.target="appFrame";
        document.result_form.action="controller/editFilter.cmd";
        document.result_form.submit();

   }
   function onApplyAndReturn()
   {
        document.result_form.target="appFrame";
        document.result_form.action="controller/applyAndReturnFilter.cmd";
        displayBusyBox();
        document.result_form.submit();

   }
   function onRemove()
   {
        document.result_form.target="appFrame";
        document.result_form.action="controller/removeFilter.cmd";
        document.result_form.submit();

   }
   function onCancel()
   {
        document.result_form.target="appFrame";
        document.result_form.action="controller/cancel.cmd";
        document.result_form.submit();

   }
    function resize_Containers()
    {
      //alert("hello");
      var  table_id = 'result_form_table';
      var width = document.body.offsetWidth -40 ;
      var height = document.body.offsetHeight  ;

      // resize table   approx

      i2uiResizeColumns(table_id);
      i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null);
   }
  ]]>

  </script>
</xsl:template>

<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>


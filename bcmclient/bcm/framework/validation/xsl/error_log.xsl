<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">

   <xsl:import href="../../queryform/xsl/searchformfilter.xsl"/>

  <xsl:output method="html"/>
  <!-- Page Content -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">


    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <script>
      <xsl:call-template name="include_javascript_error_log"/>
    </script>
    <xsl:call-template name="include_javascript_table_resize"/>
  </xsl:template>
  <!-- Container.xsl -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template match = "RESPONSE" mode="container_content">
     <xsl:apply-templates select="SEARCH">
       <xsl:with-param name="formName" select="'result_form'"/>
     </xsl:apply-templates>
  </xsl:template>

    <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="include_javascript_error_log">
      function onFixErrors()
      {
//            document.err_rept_form.action="error_log.jsp";
//            document.err_rept_form.submit();
      }
      function onCancel()
      {
//            document.result_form.DOCUMENT_NAME.value="";
//            document.result_form.SERVICE_NAME.value="";
//            document.result_form.action="documents.jsp";
            document.result_form.action="doc_error/onCancel.cmd";
            document.result_form.submit();
      }
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
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="onResize_js">  
    function onResize()
    {
      <xsl:call-template name="javascript_onResize_page"/>
      resize_Containers();
    }
  </xsl:template>
  <!-- ********************************************************************** 
      *********************************************************************** -->
  <!-- Javascript -->
  <xsl:template name="include_javascript_table_resize">
    <script>
  <![CDATA[
     function resize_Containers()
    {
      var table_id = 'result_form_table';
      var width = document.body.offsetWidth-30;
      var height = document.body.offsetHeight -50;
      
      i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null)    

      i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight - 150, null, document.body.offsetWidth - 25, true, 'yes');
    }  
    ]]></script>
  </xsl:template>
  <!-- ********************************************************************** 
      *********************************************************************** -->
</xsl:stylesheet>

<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:import href="../../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../../../core/search/xsl/search.xsl"/>

  <xsl:output method="html"/>


  <!-- Page Content -->  
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">
    
    <xsl:call-template name="include_javascript_select_shared"/>
    
     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>
  </xsl:template>
  
  <!-- Container Content -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template match = "RESPONSE" mode="container_content">
   
     <xsl:apply-templates select="SEARCH">
     </xsl:apply-templates>
  </xsl:template>


 <!-- Form instruction -->
 <!-- ********************************************************************** 
     *********************************************************************** -->
  <xsl:template match="FORM" mode="instruction_area">
    <xsl:if test="/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value">
      <xsl:call-template name="display_validation_area">    
        <xsl:with-param name="pFormName" select="'search_form'"/>
        <xsl:with-param name="pAnyFieldIsRequired" select="count(FIELD[@Required = 'true']) > 0"/>
        <xsl:with-param name="pInstructionMessage" select="INSTRUCTION/@DisplayText"/>
        <xsl:with-param name="pSuccessMessage" select="/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value"/>
      </xsl:call-template>     
    </xsl:if>  
  </xsl:template>

 
  <!-- page.xsl Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="onLoad_js">  
  function onLoad()
  {
    <xsl:call-template name="javascript_onLoad_search"/>
    <xsl:call-template name="javascript_onLoad_page"/> 
   }
  </xsl:template>
  
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template name="onResize_js">  
    function onResize()
    {
      <xsl:call-template name="javascript_onResize_search"/>
      <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>
  

  <!-- Search.xsl Javascript -->  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="javascript_resizeContainers">  

    <xsl:call-template name="javascript_resizeTables"> 
      <xsl:with-param name="pHeight" select="250"/>
      <xsl:with-param name="pWidth" select="5 + 20 +16 +5"/>
      <xsl:with-param name="ptlcWidth" select="40"/>
      <xsl:with-param name="ptlcHeight" select="40"/>
      <xsl:with-param name="pParentContainerId" select="'container'"/>
   </xsl:call-template>

  </xsl:template>


  <!-- Current.xsl Javascript -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="include_javascript_select_shared">  
    <script>
	  function onShare()
	  {
		document.result_form.action = "shared/controller/share.cmd";
		document.result_form.submit();
	  }
    </script>
  </xsl:template>	  

<!-- ********************************************************************** 
     *********************************************************************** -->
</xsl:stylesheet>   

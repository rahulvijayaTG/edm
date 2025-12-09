<?xml version="1.0" standalone='no'?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
	<xsl:import href="../../../../framework/queryform/xsl/searchformfilter.xsl"/>
  <xsl:import href="../../../../context/xsl/context_header.xsl"/>
  <xsl:output method="html"/>
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_timeHierarchy"/>
  </xsl:template>
  <!-- **********************************************************************-->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
	     <table cellpadding="0" width="100%">
	      <xsl:if test="count(SUCCESS_MESSAGE) &gt; 0">
	        <tr>
	          <td>
	            <xsl:apply-templates select="SUCCESS_MESSAGE"/>
	          </td>
	        </tr>
	      </xsl:if>
	      <xsl:if test="count(ERROR_MESSAGE) &gt; 0">
	        <tr>
	          <td>
	            <xsl:apply-templates select="ERROR_MESSAGE"/>
	          </td>
	        </tr>
	      </xsl:if>
	    </table>
	    <table cellpadding="0" width="100%">
			        <tr>
			          <td>
			            <xsl:apply-templates select="SUCCESS_MESSAGE"/>
			          </td>
			        </tr>
			</table>
	 	    <xsl:apply-templates select="SEARCH">
	          <xsl:with-param name="formName" select="'result_form'"/>
	      </xsl:apply-templates>
	    
	    <xsl:call-template name="include_javascript_timeHierarchy"/>
	  </xsl:template>
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
      resize_Containers();
    }
  </xsl:template>   
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_timeHierarchy">
     <script>
       
   function resize_Containers()
	 {
	  	resizeScrollableTables();
 	 }
 	 function back()
	 {
	   document.result_form.target="appFrame";
	   document.result_form.action=omxContextPath+ "/bcm/framework/breadcrumb/controller/back.cmd";
	   document.result_form.submit();
		}
  	           
      function onClear()
      {
         clearFields(result_form);
         dispatchSearch();
      }

   
   </script>
  </xsl:template>        
  
</xsl:stylesheet>

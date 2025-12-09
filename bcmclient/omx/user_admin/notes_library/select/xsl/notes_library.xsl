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
    
    <xsl:call-template name="include_javascript_notes_library"/>
    
     <xsl:apply-templates select="RESPONSE/CONTAINER">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>
  </xsl:template>
  
  <!-- Container Content -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template match = "RESPONSE" mode="container_content">
	
    <xsl:apply-templates select="/RESPONSES/RESPONSE/SUCCESS_MESSAGE"/>
    <xsl:apply-templates select="/RESPONSES/RESPONSE/ERROR_MESSAGE"/>
	
    <xsl:apply-templates select="SEARCH"/>

  </xsl:template>

  <!-- Container Content -->
  <!-- ********************************************************************** 
       *********************************************************************** -->

  <xsl:template match = "SUCCESS_MESSAGE">
  
    <table border="0" id="success_message" cellpadding="0" cellspacing="0" width="100%" class="instructionArea">
      <tr>
        <td align="middle" valign="middle" width="5%">
          <i2:img src="/alert_green_static.gif" alt="Success" border="0" align="middle"/>
        </td>
        <td align="left" valign="middle" width="100%">
          <i18n:text><xsl:value-of select="@Value"/></i18n:text>
        </td>
      </tr>
    </table>
    
  </xsl:template>
  
  <!-- Container Content -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template match = "ERROR_MESSAGE">
	
    <table border="0" id="error_message" cellpadding="0" cellspacing="0" width="100%" class="instructionArea">
      <tr>
        <td align="middle" valign="middle" width="5%">
          <i2:img src="/alert_static.gif" alt="Error" border="0" align="middle"/>
        </td>
        <td align="left" valign="middle" width="100%">
          <i18n:text><xsl:value-of select="@Value"/></i18n:text>
        </td>
      </tr>
    </table>

  </xsl:template>
  
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template match = "TD[@Name='IS_EDITABLE']" mode="content">
    <xsl:variable name="value">
	  <xsl:choose>
	    <xsl:when test="@Value='false'">
		  No
		</xsl:when>
		<xsl:when test="@Value='true'">
		  Yes
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="@Value"/>
		</xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
    <td nowrap="yes" align="left">
      <xsl:call-template name="i18nize">
        <xsl:with-param name="pData" select="$value"/>
        <xsl:with-param name="pNoData" select="' '"/>                
        <xsl:with-param name="pType" select="@Type"/>
        <xsl:with-param name="pFormat" select="@Format"/>           
        <xsl:with-param name="pDecimals" select="@Decimals"/>  
      </xsl:call-template>    
	</td>
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
  <xsl:template name="include_javascript_notes_library">  
  <script>
	function onDelete()
	{
	    document.result_form.action='controller/deleteNote.cmd';
	    document.result_form.submit();
	}
	
	function onAdd()
	{
	    document.result_form.action='controller/addNote.cmd';
	    document.result_form.submit();
	}
	
	function onView()
	{
	    document.result_form.action='controller/viewNote.cmd';
	    document.result_form.submit();
	}
  </script>
  </xsl:template>	  

<!-- ********************************************************************** 
     *********************************************************************** -->
</xsl:stylesheet>   

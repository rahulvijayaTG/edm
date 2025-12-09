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
 <xsl:import href="../../../../../core/xsl/validation.xsl"/>
 <xsl:import href="../../../../xsl/code_master.xsl"/>
  
  <xsl:output method="html"/>
  
  
  <!-- Entry Point -->
  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
  
    <xsl:call-template name="include_javascript_general"/>
  
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>

  </xsl:template>
  
  <!-- ********************************************************************** 
     *********************************************************************** --> 
  <xsl:template match="RESPONSE" mode="container_content">
    <table border="0" cellpadding="0" cellspacing="0" width="100%"><tr>
      <form name="form" method="post" target="appFrame">
	  <td>
        <!-- Body -->
      	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
	        <tr><td  width="100%">
			  <input type="hidden" name="EDITABLE" value="{/RESPONSES/RESPONSE/EDITABLE/@Value}"/>
	          <xsl:apply-templates select="STATES"/>
	        </td></tr>
         </table>
		 </td>
       </form>
     </tr>
   </table>
 </xsl:template>
 
 <!-- ********************************************************************** 
     *********************************************************************** -->
 <xsl:template match="STATES">
   <table width="100%">
     <tr>
	   <xsl:apply-templates select="CODE_MASTER_VALUE">
	     <xsl:sort select="DESCRIPTION/@Value"/>
	   </xsl:apply-templates>
     </tr>
   </table>
   <input type="hidden" name="FEIN" value="{/RESPONSES/RESPONSE/FEIN/@Value}"/>
   <input type="hidden" name="ID" value="{/RESPONSES/RESPONSE/ID/@Value}"/>
 </xsl:template> 
 
 <!-- ********************************************************************** 
     *********************************************************************** --> 
 <xsl:template match="CODE_MASTER_VALUE">
    <xsl:choose>
      <xsl:when  test="CHECKED/@Value='True'">
        <td width="25%" >
          <input type="checkbox" name="STATE" value="{VALUE_ID/@Value}" checked="checked" >
            <i18n:text><xsl:value-of select="DESCRIPTION/@Value"/></i18n:text>
          </input>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td width="25%" >
          <input type="checkbox" name="STATE" value="{VALUE_ID/@Value}">
            <i18n:text><xsl:value-of select="DESCRIPTION/@Value"/></i18n:text>
          </input>
        </td>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="position() mod 4 = 0">&lt;/tr&gt;&lt;tr width="100%" &gt;</xsl:if>
  </xsl:template>
  
  <!-- page.xsl Javascript -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
    <xsl:call-template name="javascript_onLoad_tab"/>
    <xsl:call-template name="javascript_onLoad_page"/>
    }
  </xsl:template>


  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="onResize_js">

    function onResize()
    {
    <xsl:call-template name="javascript_onResize_tab"/>
    <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>


  <!-- Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="javascript_onLoad_tab">
    <xsl:call-template name="javascript_resizeTabs"/>
  </xsl:template>


  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="javascript_onResize_tab">
    <xsl:call-template name="javascript_resizeTabs"/>
  </xsl:template>

   <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="include_javascript_general">
    <script type="text/javascript">
	  function onUpdate()
	  {
    	document.form.action= "nexus/controller/update.cmd";
	  	document.form.submit();
  		return;
	  }
    </script>
  </xsl:template>
  
  <!-- ********************************************************************** 
       *********************************************************************** -->
  
</xsl:stylesheet>


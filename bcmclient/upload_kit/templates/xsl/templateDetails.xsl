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

  <xsl:output method="html"/>
  
  <!-- Entry Point -->
  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER">
      <xsl:with-param name="content" select="RESPONSE/TEMPLATE"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- ********************************************************************** 
       ********************************************************************** --> 
  <xsl:template match="TEMPLATE" mode="container_content">  
    
    <!-- Template Details -->
    <table width="60%" calss="tablerow1" border="0">
      <tr>							
      	<td nowrap="yes"><i18n:text>Template Name</i18n:text>:</td>
				<td nowrap="yes">
                  <xsl:value-of select="@DisplayName"/>
				</td>
				<td/><td/>
				<td nowrap="yes"><i18n:text>Api Name</i18n:text>:</td>
				<td nowrap="yes">
				  <i18n:text><xsl:value-of select="@ApiName"/></i18n:text>
				</td>
      </tr>
      <tr>
			  <td nowrap="yes"><i18n:text>Template Type</i18n:text>:</td>
				<td nowrap="yes">
				  <xsl:value-of select="@TemplateType"/>
				</td>
				<td/><td/>
				<td nowrap="yes"><i18n:text>Data Type</i18n:text>:</td>
				<td nowrap="yes">
				  <i18n:text><xsl:value-of select="@DataType"/></i18n:text>
				</td>
      </tr>
      <tr>
        <td nowrap="yes"><i18n:text>Service Name</i18n:text>:</td>
				<td nowrap="yes">
				  <i18n:text><xsl:value-of select="@ServiceName"/></i18n:text>
				</td>
      </tr>
	  <!--
  	  <tr>
        <td nowrap="true"><i18n:text>Api Name</i18n:text>:&#xA0;
  		  <i18n:text><xsl:value-of select="@ApiName"/></i18n:text>
  		</td>
      </tr>
  	  <tr>
        <td nowrap="true"><i18n:text>Data Type</i18n:text>:&#xA0;
  		  <i18n:text><xsl:value-of select="@DataType"/></i18n:text>
  		</td>
      </tr>
	  -->
	  </table>
	  <table width="100%" border="0">
  	  <tr>
  	    <td>
  		    <xsl:call-template name="Property"/>
  		  </td>
  	  </tr>
    </table>
  </xsl:template>
  
  <xsl:template name="Property">
    <xsl:variable name="property_header">
    	<i18n:text>Property Details</i18n:text>
    </xsl:variable>
    <xsl:variable name="propertyName">
      <xsl:value-of select="@Name" />
    </xsl:variable>
    <i2:container title="{$property_header}" width="100%">
      <table width="100%" border="0" cellpadding="0" >
        <tr>
          <td>
            <i2:table>
           	<i2:tr header="yes">		
                <td nowrap="yes" align="center">
  	            <i18n:text>Property Name</i18n:text>
  			  </td>
              </i2:tr>
  			<xsl:for-each select="/RESPONSES/RESPONSE/TEMPLATE/PROPERTY">
  			  <i2:tr>
  			    <td nowrap="yes">
  			      <i18n:text><xsl:value-of select="@Name"/></i18n:text>
  			    </td>
  			  </i2:tr>
  			</xsl:for-each>
  		  </i2:table>
  		</td>
  	  </tr>
  	</table>
    </i2:container>
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
</xsl:stylesheet>

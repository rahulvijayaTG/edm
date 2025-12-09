<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
 
  extension-element-prefixes="i2 "
  version="1.0">
  
<xsl:import href="../../core/xsl/page.xsl"/>
<xsl:import href="../../core/xsl/container.xsl"/>
    
<xsl:output method="html"/>

<!-- Entry point -->  
  <!-- ********************************************************************** 
     *********************************************************************** -->  
  <xsl:template match="RESPONSES" mode="content">

   <xsl:apply-templates select="RESPONSE" mode="container_content">
   
   </xsl:apply-templates>    

 </xsl:template>   

   <!-- page.xsl Javascript -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="onLoad_js">  
    function onLoad()
    {
      <xsl:call-template name="javascript_resizeContainer"/>
      <xsl:call-template name="javascript_onLoad_page"/>
    }
  </xsl:template>
  
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="onResize_js">  
    
    function onResize()
    {
      <xsl:call-template name="javascript_resizeContainer"/>
     <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>
  

<xsl:template match="RESPONSE" mode="container_content">
<i2:container title="XML" scrollable="yes" id="container">
		<i2:table id="TT1" width="100%" cols="6">
			<xsl:apply-templates/>
		</i2:table> 
 </i2:container>   
</xsl:template>        

<xsl:template match="*">
	
	 <!-- Print this Element.name   -->
	 	<i2:tr >
		<!-- Determine if this node has children -->
		<xsl:variable name="nochild">  
			<xsl:choose>
				<xsl:when test="count(descendant::node()) &gt; 0"> 
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise><xsl:text>true</xsl:text></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
	 	 
		<!-- Display in tree cell-->
		<!-- Take the depth as ancestors  -->
		<i2:treecell depth = "{count(ancestor::node())}"  nochildren="{$nochild}" >
				<xsl:value-of  select="name()"/>
		</i2:treecell>
		
		<!-- print all its  attributes -->
		<xsl:for-each select="@*"> 
			<xsl:call-template name="printattribute"/>
		</xsl:for-each>	
		<td></td><td></td>		 <td></td>		 <td></td>		 <td></td>		 <td></td>		 <td></td>		 <td></td>		 		
		</i2:tr> 
	<!-- Repeat this each of its children -->
	<xsl:apply-templates/>
</xsl:template>

<xsl:template name="printattribute"> 
	<td>
		<xsl:value-of select="name()"/>(<xsl:value-of select = "."/>)
	</td>
</xsl:template>
</xsl:stylesheet>
  
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
  <xsl:import href="../../../xsl/contact.xsl"/>

  <xsl:output method="html"/>


  <!-- Page Content -->  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match = "RESPONSES" mode="content">
    
	<xsl:call-template name="include_javascript_contacts_common"/>
	<xsl:call-template name="include_javascript_contacts"/>
	<xsl:call-template name="include_javascript_org_contact"/>
	
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <!-- Container Content -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match = "RESPONSE" mode="container_content">
    <xsl:choose>
	  <xsl:when test="CONTACT_MAP/EDITABLE or CONTACT_MAP/IS_NEW">
	    <xsl:apply-templates select="CONTACT_MAP" mode="edit"> 
      	  <xsl:with-param name="page" select="'org_contact'"/>
      	  <xsl:with-param name="entityType" select="'Org'"/>
      	  <xsl:with-param name="entityId" select="/RESPONSES/RESPONSE/ENTITY/ENTITY_ID/@Value"/>
    	</xsl:apply-templates>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:apply-templates select="CONTACT_MAP" mode="view"> 
      	  <xsl:with-param name="page" select="'org_contact'"/>
      	  <xsl:with-param name="entityType" select="'Org'"/>
      	  <xsl:with-param name="entityId" select="/RESPONSES/RESPONSE/ENTITY/ENTITY_ID/@Value"/>
    	</xsl:apply-templates>
	  </xsl:otherwise>
	</xsl:choose>
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
  
  <!-- Current.xsl Javascript -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="include_javascript_org_contact">  
    <script>
	  function onReset()
	  {
	    document.addNewContactForm.action = "contact/controller/reset.cmd";
		document.addNewContactForm.target="appFrame";
    	document.addNewContactForm.submit();
	  }
	</script>
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
</xsl:stylesheet>   

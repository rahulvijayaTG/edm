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

  
 <xsl:import href="../../../../../core/xsl/page.xsl"/>
 <xsl:import href="../../../../../core/xsl/container.xsl"/>
 <xsl:import href="../../../../../core/xsl/validation.xsl"/>
 <xsl:import href="../../../xsl/buyinglimits.xsl"/>

 
  <!-- Entry Point -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
  
    <xsl:call-template name="include_javascript_org_buying_limits"/>
  
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="tabs">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>

  </xsl:template>

  <!-- ********************************************************************** 
  *********************************************************************** --> 
  <xsl:template match="RESPONSE" mode="container_content">     
    <xsl:apply-templates select="../RESPONSE"> 
      <xsl:with-param name="page" select="'org_buying_limits'"/>
      <xsl:with-param name="entityType" select="'Org'"/>
      <xsl:with-param name="entityId" select="/RESPONSES/RESPONSE/ENTITY/ENTITY_ID/@Value"/>
    </xsl:apply-templates>
  </xsl:template>  
  
  <!-- page.xsl Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="onLoad_js">  
  function onLoad()
  {
    initBuyingLimitsTable();
    <xsl:call-template name="javascript_onLoad_page"/>
  }
  </xsl:template>


  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="onResize_js">

    function onResize()
    {
	  initBuyingLimitsTable();
      <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>


  <!-- Javascript -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="javascript_onLoad_tab">
    <xsl:call-template name="javascript_resizeOrgTabs"/>
  </xsl:template>


  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="javascript_onResize_tab">
    <xsl:call-template name="javascript_resizeOrgTabs"/>
  </xsl:template>

  <!-- overrides the js in tabs.xsl -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="javascript_resizeOrgTabs">  
    i2uiResizeScrollableContainer('container',document.body.offsetHeight - 90, null, document.body.offsetWidth - 40, true, 'yes');
    i2uiResizeScrollableContainer('tabs_container_description',document.body.offsetHeight -105, null, document.body.offsetWidth - 20, true, 'yes');
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="include_javascript_org_buying_limits">
    <script language="JavaScript" src="../../../javascript/calendar.js"/>
    <script language="JavaScript" src="../../../javascript/CheckDateTime.js"/>
    <script type="text/javascript">
	  function onReset(orgid)
	  {
	    document.location="buying_limits.jsp?ORG_ID=" + orgid;
	  }   

  	  function onSave()
	  {
       checkgroups('buyingLimitsForm');
 	    var bIsFormValid = isFormValid('buyingLimitsForm') ;
      	if ( bIsFormValid == true)
        {
    	  document.buyingLimitsForm.action = "buying_limits/controller/save.cmd";
	  	  document.buyingLimitsForm.submit();
  		}
  		return;
	  }  
	  
	  function initBuyingLimitsTable()
	  {
	    initContainer('buying_container');
  		if (!document.layers)
  		{
    		var x = document.body.scrollWidth - 50;
    		i2uiResizeScrollableArea('paymentMethodTable',218,x,null,20);
    		i2uiResizeColumns('paymentMethodTable');
    		i2uiCollapseTreeTable('paymentMethodTable', 0, null, 1)    
  		}
		initContainer('buying_container');
	  }   
	  function showCalendar(fieldName)
	  {
	  	setDateField(fieldName);
	  }
        
	  	
	</script>
  </xsl:template>

</xsl:stylesheet>


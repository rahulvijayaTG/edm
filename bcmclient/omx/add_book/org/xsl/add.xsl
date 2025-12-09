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

  
 <xsl:import href="../../../../core/xsl/page.xsl"/>
 <xsl:import href="../../../../core/xsl/container.xsl"/>
 <xsl:import href="../../../../core/xsl/validation.xsl"/>
 <xsl:import href="../../../xsl/code_master.xsl"/>
 <xsl:import href="org.xsl"/>

 
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

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
	  <tr>
      <form name="form" method="post" target="appFrame">
	  <td>
        <input type="hidden" name="PAGE" value="add_org"/>
        <!-- Body -->
      	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
	        <tr><td  width="100%">
	          <xsl:apply-templates select="ORGANIZATION" mode="edit"/>
	        </td></tr>
         </table>
		 </td>
       </form>
     </tr>
   </table>
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
	function activateCustomer()
	{		
		if(document.form.ORG_ID.value){
			document.form.action = "add/controller/activateCustomer.cmd";
			document.form.submit();
		}

		else {
			document.form.CUSTOMER_STATUS.value = "ACTIVE";
			document.form.action = "add/controller/refreshOrg.cmd";
			document.form.submit();
		}
	}

	function activateSeller()
	{
	  if(document.form.ORG_ID.value){
		document.form.action = "add/controller/activateSeller.cmd";
		document.form.submit();
	  }

	  else {
		document.form.SELLER_STATUS.value = "ACTIVE";
		document.form.action = "add/controller/refreshOrg.cmd";
		document.form.submit();
	  }

	}
	
	function deactivateCustomer()
	{
	  if(document.form.ORG_ID.value){
	    document.form.action = "add/controller/removeCustomer.cmd";
		document.form.submit();
	  }
	  else {
		document.form.CUSTOMER_STATUS.value = "NONE";
		document.form.action = "add/controller/refreshOrg.cmd";
		document.form.submit();
	  }

	}

	function deactivateSeller()
	{
	  if(document.form.ORG_ID.value){
		document.form.action = "add/controller/removeSeller.cmd";
		document.form.submit();
	  }
	  else {
		document.form.SELLER_STATUS.value = "NONE";
		document.form.action = "add/controller/refreshOrg.cmd";
		document.form.submit();
	  }

	}
	
	function save()
	{
	  var bIsFormValid = isFormValid('form') ;
	  if ( bIsFormValid == true)
	  {
	    document.form.action="add/controller/add.cmd";
		document.form.IS_NEW.value = "true";
		document.form.target="appFrame";
		document.form.submit();
	  }
  	}
	
	function reset()
	{
	  document.form.action="add/controller/reset.cmd";
	  document.form.target="appFrame";
	  document.form.submit();
	}
	
   </script>
   </xsl:template>

</xsl:stylesheet>


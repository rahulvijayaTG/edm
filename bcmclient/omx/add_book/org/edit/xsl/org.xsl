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
  <xsl:import href="../../xsl/org.xsl"/>
  <xsl:import href="../../xsl/local_org.xsl"/>

  <xsl:output method="html"/>


  <!-- Page Content -->  
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">
    
    <xsl:call-template name="include_javascript_edit_org"/>
    
     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="tabs">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>
  </xsl:template>
  
  <!-- Container Content -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template match = "RESPONSE" mode="container_content">
   
     <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <form name="form" method="post" target="appFrame">
    <td>
        <input type="hidden" name="PAGE" value="edit_org"/>
        <!-- Body -->
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr><td  width="100%">
        <xsl:choose>
              <xsl:when test="(ORGANIZATION/EDITABLE or ORGANIZATION/IS_NEW)">
              <xsl:apply-templates mode="edit" select="ORGANIZATION"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates mode="view" select="ORGANIZATION"/>
            </xsl:otherwise>
          </xsl:choose>
          
        <!-- Customer Relationship Details -->
          <xsl:if test="(ORGANIZATION/CUSTOMER_STATUS/@Value != 'NONE' and ORGANIZATION/CUSTOMER_STATUS/@Value != 'DORMANT')">
              <xsl:choose>
              <xsl:when test="(LOCAL_CUSTOMER/EDITABLE/@Value='true' or LOCAL_CUSTOMER/IS_NEW)">
                <xsl:apply-templates mode="edit" select="LOCAL_CUSTOMER"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates mode="view" select="LOCAL_CUSTOMER"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        
        <!-- Seller Relationship Details -->
          <xsl:if test="(ORGANIZATION/SELLER_STATUS/@Value != 'NONE' and ORGANIZATION/SELLER_STATUS/@Value != 'DORMANT')">
            <xsl:apply-templates select="LOCAL_SELLER"/>
          </xsl:if>
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
  
  <!-- Current.xsl Javascript -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="include_javascript_edit_org">  
    <script>
  
    function onSaveAsNew()
    {
      var bIsFormValid = isFormValid('form') ;
          if ( bIsFormValid == true)
          {
        document.form.action = "org/controller/addEdit.cmd";
        document.form.IS_NEW.value = "true";
        document.form.ACTIVATABLE.value = "false";
        document.form.DEACTIVATABLE.value = "false";
        document.form.submit();
        }
        return;
    }
    
    function onUpdate()
      {
      var bIsFormValid = isFormValid('form') ;
          if ( bIsFormValid == true)
          {
        document.form.action="org/controller/addEdit.cmd";
        document.form.target="appFrame";
        document.form.submit();
      }
      }
    
    function onReset(id, orgid)
    {
        document.location="org.jsp?ORG_ID=" + id;
    }
    
    function onActivateLocal()
    {
        document.form.action = "org/controller/changeLocalStatus.cmd";
      document.form.target="appFrame";
        document.form.submit();
    }

    function onDeactivateLocal()
    {
        document.form.action = "org/controller/changeLocalStatus.cmd";
      document.form.target="appFrame";
        document.form.submit();
    }
    
    function onSaveLocal()
    {
        document.form.action = "org/controller/addEditLocal.cmd";
      document.form.target="appFrame";
        document.form.submit();
    }
    
    function onActivateLocalSeller()
    {
        document.form.action = "org/controller/changeLocalSellerStatus.cmd";
      document.form.target="appFrame";
        document.form.submit();
    }

    function onDeactivateLocalSeller()
    {
        document.form.action = "org/controller/changeLocalSellerStatus.cmd";
      document.form.target="appFrame";
        document.form.submit();
    }
    
    function onSaveLocalSeller()
    {
        document.form.action = "org/controller/addEditLocalSeller.cmd";
      document.form.target="appFrame";
        document.form.submit();
    }
      function activateCustomer()
  {    
    if(document.form.ORG_ID.value){
      document.form.action = "../add/controller/activateCustomer.cmd";
      document.form.submit();
    }

    else {
      document.form.CUSTOMER_STATUS.value = "ACTIVE";
      document.form.action = "../add/controller/refreshOrg.cmd";
      document.form.submit();
    }
  }

  function activateSeller()
  {
    if(document.form.ORG_ID.value){
    document.form.action = "../add/controller/activateSeller.cmd";
    document.form.submit();
    }

    else {
    document.form.SELLER_STATUS.value = "ACTIVE";
    document.form.action = "../add/controller/refreshOrg.cmd";
    document.form.submit();
    }

  }
  
  function deactivateCustomer()
  {
    if(document.form.ORG_ID.value){
      document.form.action = "../add/controller/removeCustomer.cmd";
    document.form.submit();
    }
    else {
    document.form.CUSTOMER_STATUS.value = "NONE";
    document.form.action = "../add/controller/refreshOrg.cmd";
    document.form.submit();
    }

  }

  function deactivateSeller()
  {
    if(document.form.ORG_ID.value){
    document.form.action = "../add/controller/removeSeller.cmd";
    document.form.submit();
    }
    else {
    document.form.SELLER_STATUS.value = "NONE";
    document.form.action = "../add/controller/refreshOrg.cmd";
    document.form.submit();
    }

  }

    </script>
  </xsl:template>    

<!-- ********************************************************************** 
     *********************************************************************** -->
</xsl:stylesheet>   

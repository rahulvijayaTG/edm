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
        <input type="hidden" name="PAGE" value="org_overview"/>
        <!-- Body -->
      	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
	        <tr><td  width="100%">
			  <xsl:apply-templates select="ORGANIZATION"/>
	        </td></tr>
         </table>
		 </td>
       </form>
     </tr>
   </table>
 </xsl:template>

 <!-- ********************************************************************** 
  *********************************************************************** -->
 <xsl:template match="/RESPONSES/RESPONSE/ORGANIZATION">
   
    <xsl:variable name="orgtype">
      <xsl:choose>
        <xsl:when test="((CUSTOMER_STATUS/@Value = 'ACTIVE') or (CUSTOMER_STATUS/@Value = 'INACTIVE')) and ((SELLER_STATUS/@Value = 'ACTIVE') or (SELLER_STATUS/@Value = 'INACTIVE'))">
          <xsl:variable name="txtAltAttr"><i18n:text>Help</i18n:text></xsl:variable>
          <i18n:text>Customer and Seller</i18n:text>
        </xsl:when>
        <xsl:when test="((CUSTOMER_STATUS/@Value = 'ACTIVE') or (CUSTOMER_STATUS/@Value = 'INACTIVE'))">
          <xsl:variable name="txtAltAttr"><i18n:text>Help</i18n:text></xsl:variable>
          <i18n:text>Customer</i18n:text>
        </xsl:when>
        <xsl:when test="((SELLER_STATUS/@Value = 'ACTIVE') or (SELLER_STATUS/@Value = 'INACTIVE'))">
          <xsl:variable name="txtAltAttr"><i18n:text>Help</i18n:text></xsl:variable>
          <i18n:text>Seller</i18n:text>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
	
    <xsl:variable name="caption_title">
      <i18n:text><xsl:value-of select="concat(FULL_NAME/@Value,' is of type ', $orgtype)"/></i18n:text>
    </xsl:variable>
    <table border="0" cellpadding="0" cellspacing="1" width="100%" height="100%">
      <tr>
        <td height="100%">
          <i2:container title="{$caption_title}" inner="yes" width="100%" stretch="yes">        
            <i2:table>
              <xsl:for-each select="CHILD_ENTITY">
                <i2:tr>
                  <td height="27px" width="25%">
                    <i2:img src="/tree_bullet.gif" border="0"/>&#xA0;&#xA0;
                    <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
                  </td>
                  <td height="27px" align="left">
                    <table border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td align="right">
						  <xsl:if test="@addUrl">
                            <xsl:if test=" @Editable = 'true' ">
                              <xsl:attribute name="class">rightBorder</xsl:attribute>
                            </xsl:if>
						  </xsl:if>
						  <xsl:if test="@searchUrl">
                            <a href="{@searchUrl}" target="appFrame">
                              <i18n:text>Search</i18n:text>
                            </a>
						  </xsl:if>
						  <xsl:if test="@viewUrl">
                            <a href="{@viewUrl}" target="appFrame">
                              <i18n:text>View</i18n:text>
                            </a>
						  </xsl:if>
						  <xsl:if test="@manageUrl">
                            <a href="{@manageUrl}" target="appFrame">
                              <i18n:text>Manage</i18n:text>
                            </a>
						  </xsl:if>
                        </td>
						<xsl:if test="@addUrl">
                          <xsl:if test=" @Editable = 'true' ">
                            <td align="left">
                              <a href="{@addUrl}"  target="appFrame">
                                <i18n:text>Add New</i18n:text>
                              </a>
                            </td>
                          </xsl:if>  
						</xsl:if>
                      </tr>
                    </table>
                  </td>
                </i2:tr>
              </xsl:for-each>
            </i2:table>
          </i2:container>
        </td>
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
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
</xsl:stylesheet>   

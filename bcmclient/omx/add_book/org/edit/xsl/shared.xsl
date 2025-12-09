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
    
	<xsl:call-template name="include_javascript_org_shared"/>
	
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
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
        <input type="hidden" name="PAGE" value="org_shared"/>
        <!-- Body -->
      	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
	        <tr><td  width="100%">
			  <xsl:apply-templates select="SHARED"/>
	        </td></tr>
         </table>
		 </td>
       </form>
     </tr>
   </table>
 </xsl:template>
 
 <!-- ********************************************************************** 
  *********************************************************************** -->
 <xsl:template match="SHARED">
   <xsl:variable name="caption_title">
     <i18n:text>Organizations in Shared List</i18n:text>
   </xsl:variable>
   <table cellspacing="1" cellpadding="0" border="0" width="100%" height="100%">
     <tr>
        <input type="hidden" name="SOURCE_ORG_ID" value="{ORG_ID/@Value}"/>
	    <td>
          <i2:container title="{$caption_title}">
            <table cellspacing="1" cellpadding="0" border="0" width="100%" height="100%">
              <tr>
                <td>
   			      <xsl:choose>
                    <xsl:when test="count( /RESPONSES/RESPONSE/SHARED/ORGANIZATION ) > 0">	
					  <i2:table>
                        <i2:tr header="yes">
	                      <td nowrap="yes" align="center">
	                        <input type="checkbox" name="SHARED_CHECKBOX" value="true" onclick="javascript:toggleCheckboxes(document.forms.form, document.forms.form.TARGET_ORG_ID, document.forms.form.SHARED_CHECKBOX);"/>
	                      </td>
	                      <td nowrap="yes">
	                        <i18n:text>Shared Organizations</i18n:text>
	                      </td>
	                    </i2:tr>   
		                <xsl:apply-templates select="/RESPONSES/RESPONSE/SHARED/ORGANIZATION"/>
					  </i2:table>
	                </xsl:when>
	                <xsl:otherwise>
	                  <i18n:text>Addresses are not shared with any other organizations</i18n:text>.
	                </xsl:otherwise>
	              </xsl:choose>
				</td>
			  </tr>
			</table>
		  </i2:container>
		</td>
      </tr>
    </table>
  </xsl:template>

  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="ORGANIZATION">
    <i2:tr>	
      <xsl:if test="/RESPONSES/RESPONSE/SHARED/EDITABLE">
	    <td width="30" align="center">
          <input type="checkbox" name="TARGET_ORG_ID" value="{ID/@Value}"/>
	    </td>
	  </xsl:if>
	  <td>
	    <a href="org.jsp?ORG_ID={ID/@Value}&amp;CUSTOMER_ORG_ID={ID/@Value}" target="appFrame"><i18n:text><xsl:value-of select="FULL_NAME/@Value"/></i18n:text>
		</a>
	  </td>
    </i2:tr>
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
  <xsl:template name="include_javascript_org_shared">  
    <script>
	  function onRemove()
	  {       
	    document.form.action="shared/controller/remove.cmd";
  		document.form.target="appFrame"; 
  		document.form.submit();    
	  }
	</script>
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
</xsl:stylesheet>   

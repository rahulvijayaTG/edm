<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">
  <!-- Core -->
  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../../bcm/framework/xsl/required_field.xsl"/>
  <xsl:import href="../../../../bcm/framework/xsl/code_master.xsl"/>
  <!-- Errors -->
  <xsl:import href="../../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:call-template name="include_javascript_dom_assign"/>
    <i2:container id="container" title="Search Result">
      <table border="0" cellpadding="0" cellspacing="5" height="100%" width="100%">
        <tr>
          <td>
            <form name="result_form" method="POST">
              <input name="domainType" type="hidden" value="{/RESPONSES/RESPONSE/domainType/@Value}"/>
              <xsl:apply-templates select="RESPONSE" mode="container_content"/>
            </form>
          </td>
        </tr>
        <tr>
          <td>
            <i2:footer>
              <table cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                  <td>
                    <xsl:apply-templates select="RESPONSE/BUTTONS"/>
                  </td>
                </tr>
              </table>
            </i2:footer>
          </td>
        </tr>
      </table>
    </i2:container>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">
    <xsl:apply-templates select="AUTH_DOCS"/>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="AUTH_DOCS">
    <xsl:apply-templates select="AUTH_DOC"/>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="Header_row">
    <i2:tr header="yes">
      <td>View</td>
      <td>Edit</td>
      <td>Name</td>
    </i2:tr>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="AUTH_DOC">
    <i2:table>
      <xsl:call-template name="Header_row"/>
      <xsl:apply-templates select="AUTH_ID"/>
    </i2:table>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="AUTH_ID">
    <i2:tr>
      <td>
        <input type="checkbox" name="view" value="{descendant::*/@Value}"/>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="descendant::*/@Action='_ALL_'">
            <input type="checkbox" name="edit" value="{descendant::*/@Value}"/>
          </xsl:when>
          <xsl:otherwise>
            <input type="checkbox" name="edit" value="{descendant::*/@Value}" disabled="disabled"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td nowrap="nowrap">
        <xsl:value-of select="descendant::*/@Value"/>
      </td>
    </i2:tr>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_dom_assign">
    <script>
        function onAdd()
        {
           if ((document.result_form.domainType.value== null)||(document.result_form.domainType.value=="") )
               { 
                   core_alert("Please select the Domain Type from the Domain Tree using a Left Click");
                  }
                   else
                {

                   document.result_form.target="domainFrame";
                   document.result_form.method="POST";
                   document.result_form.action='assignDomainController/merge.cmd';
                   document.result_form.submit();
               }
         

        }
	</script>
  </xsl:template>
</xsl:stylesheet>

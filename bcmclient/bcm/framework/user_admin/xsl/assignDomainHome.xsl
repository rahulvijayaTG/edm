<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">
  <!-- Core -->
  <xsl:import href="../../../../core/xsl/page.xsl"/>
<!--  <xsl:import href="../../../../core/xsl/container.xsl"/>-->
  <xsl:import href="../../../../bcm/framework/xsl/core_container_override.xsl"/>
  <xsl:import href="../../../../bcm/framework/xsl/required_field.xsl"/>
  <xsl:import href="../../../../bcm/framework/xsl/code_master.xsl"/>
  <!-- Errors -->
  <xsl:import href="../../../../core/xsl/error.xsl"/>
  <xsl:import href="../../xsl/pagingControl.xsl"/>  
  <xsl:output method="html"/>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <form name="assign_domain_form">      
      <xsl:apply-templates select="RESPONSE/CONTAINER" mode="tabs">
        <xsl:with-param name="content" select="RESPONSE"/>
      </xsl:apply-templates>
      <input type="hidden" name="docName" value="{./RESPONSE/docName/@Value}"/>
      <input type="hidden" name="ID" value="{./RESPONSE/ID/@Value}"/>
      <input type="hidden" name="tabIndex" value="{./RESPONSE/tabIndex/@Value}"/>
    </form>
    <xsl:call-template name="include_javascript"/>
  </xsl:template>
  <xsl:template match="AUTH_DOC" mode="container_content">
    <i2:table>
      <i2:tr header="yes">
        <td nowrap="nowrap"/>
        <td nowrap="nowrap">Scope</td>
        <td nowrap="nowrap">View</td>
        <td nowrap="nowrap">All</td>
      </i2:tr>
      <xsl:apply-templates select="AUTH_ID"/>
    </i2:table>
    <!--  Footer -->
    <i2:footer>
      <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
          <!-- Pagination -->
          <td>
            <xsl:apply-templates select="PAGINATION"/>
          </td>
          <!-- Buttons  -->
          <td align="right">
            <xsl:apply-templates select="BUTTONS"/>
          </td>
        </tr>
        <!-- Hidden fields for pagination -->
        <xsl:if test="count(PAGINATION) > 0 ">
          <input type="hidden" name="RECORD_COUNT" value="{$totalRecordCount}"/>
          <input type="hidden" name="START_COUNT" value="{$startAtRow}"/>
        </xsl:if>
      </table>
    </i2:footer>
  </xsl:template>
  <xsl:template match="AUTH_ID">
    <i2:tr>
      <td nowrap="nowrap">
        <input type="checkbox" name="row" value="{descendant::*/@Value}"/>
      </td>
      <td nowrap="nowrap">
        <xsl:value-of select="descendant::*/@Value"/>
      </td>
      <td>
        <input type="radio" name="{descendant::*/@Value}" value="_VIEW_ONLY_">
          <xsl:if test="descendant::*/@Action='_VIEW_ONLY_'">
            <xsl:attribute name="checked"/>
          </xsl:if>
        </input>
      </td>
      <td>
        <input type="radio" name="{descendant::*/@Value}" value="_ALL_">
          <xsl:if test="descendant::*/@Action='_ALL_'">
            <xsl:attribute name="checked"/>
          </xsl:if>
        </input>
      </td>
    </i2:tr>
  </xsl:template>
  <xsl:template name="include_javascript">
    <script>
      function onAdd()
      {
        document.assign_domain_form.action ="assDomController/addScope.cmd";
        document.assign_domain_form.submit();
      }
      function onSave()
      {
        document.assign_domain_form.action ="assDomController/saveScope.cmd";
        document.assign_domain_form.target="appFrame";
        document.assign_domain_form.submit();
      }
      function onRemove()
      {
        if(checkifAnySelected(assign_domain_form))
        {        
          document.assign_domain_form.action ="assDomController/removeScope.cmd";
          document.assign_domain_form.submit();
        }
        else
        {
          core_alert("Please select a domain to remove");
        }
      }
      <![CDATA[
    function checkifAnySelected(form)
   {
        var count;
        var elementsLen = form.elements.length;
        var foundChecked = false;

        for(count = 0; count < elementsLen; count++)
        {
          if( form.elements[count].type == "checkbox" && form.elements[count].checked == true  &&
             form.elements[count].name != "SELECT_ALL"  ){
              foundChecked = true;
              break;
           }
        }
        return foundChecked;
   }
    ]]>
  </script>
  </xsl:template>
</xsl:stylesheet>

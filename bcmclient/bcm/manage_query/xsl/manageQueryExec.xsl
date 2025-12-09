<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">
  <!-- Core -->
  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../core/xsl/container.xsl"/>
  <xsl:import href="../../framework/xsl/required_field.xsl"/>
  <xsl:import href="../../framework/queryform/xsl/searchformfilter.xsl"/>
  <!-- Errors -->
  <xsl:import href="../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>
  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:call-template name="include_javascript_sc_preview"/>
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">
    <!--xsl:call-template name="display_instruction_area"/-->
    <!-- Body -->
    <table id="top_table" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td colspan="3">
          <xsl:apply-templates select="QUERY_DETAILS"/>
        </td>
      </tr>
      <tr valign="TOP" align="left" width="100%">
        <td align="left" colspan="1">
          <xsl:apply-templates select="PARAMETER_DETAILS"/>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!--***********************************************************************
     *********************************************************************** -->
  <xsl:template match="QUERY_DETAILS">
    <!--i2:container id="bom_container" title="{$title}"-->
      <table id="bom_tab" width="100%">
        <form name="result_form" method="POST" target="appFrame">
          <tr>
            <td>
              <table id="org_res_param_inner_table" border="0" cellpadding="0" cellspacing="9" width="100%">
                <tr>
                  <td nowrap="nowrap" width="10%">
                    <i18n:text>Query Name</i18n:text>
                    <xsl:text>:</xsl:text>
                  </td>
                  <td nowrap="nowrap">
                    <xsl:value-of select="queryName/@Value"/>
                  </td>
                </tr>
                <tr>
                  <td valign="top" nowrap="nowrap" width="10%">
                    <i18n:text>Query Detail</i18n:text>
                    <xsl:text>:</xsl:text>
                  </td>
                  <td nowrap="nowrap">
                  <!--EQ:574796-->
                   <TEXTAREA NAME="queryString" ROWS="15" COLS="60" CLASS="inputfieldIE" required="true" readonly="true">
                      <xsl:value-of select="queryString/@Value"/>
                    </TEXTAREA>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </form>
      </table>
    <!--/i2:container-->
  </xsl:template>
  <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="PARAMETER_DETAILS">
    <table id="param_tab" border="0" cellpadding="0" cellspacing="9" width="100%">
      <tr width="100%">
        <td nowrap="nowrap" width="100%">
          <xsl:apply-templates select="SEARCH">
            <xsl:with-param name="formName" select="'param_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!-- Javascript -->
  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
      //requiredFieldCheck('onLoad');
      //alert("onload anish");
      resizeAll();
    }
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onResize_js">
    function onResize()
    {
      //alert("hello resizing");
      resizeAll();
    }
  </xsl:template>
  <!-- Javascript -->
  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="include_javascript_sc_preview">
    <script>
      function IEEnterKey(){
        if(window.event.keyCode == 13){
          SetfocusSubmit(window.event.srcElement)
          event.returnValue=false;
        }
      }
      
      function SetfocusSubmit( target ){
        onExecute();
      }

      function onExecute(){
        document.param_form.target="appFrame";
        document.param_form.action="manageQueryController/execute.cmd";
        document.param_form.submit();
      }

      function onCancel(){
        document.result_form.target="appFrame";
        document.result_form.action="manageQueryController/cancel.cmd";
        document.result_form.submit();
      }

      function onSaveAndReturn(){
        error = "false";
        error = requiredFieldCheck();
        if ( error == 'false' ){
          document.result_form.target="appFrame";
          document.result_form.action="manageQueryController/";
          document.result_form.submit();
        }
        return;
      }

      // Resizing All containers
      function resizeAll(){
        var table_id = 'param_tab';
        var width = document.body.offsetWidth -5 ;
        var height = document.body.scrollHeight;
        // resize table   approx
        //i2uiResizeColumns(table_id);
        //i2uiResizeScrollableArea(table_id, height-200, width-30, null, null, null,null, null);
        i2uiResizeScrollableContainer('container',document.body.offsetHeight-100, null, document.body.offsetWidth - 20, true, 'yes');
      }
  </script>
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

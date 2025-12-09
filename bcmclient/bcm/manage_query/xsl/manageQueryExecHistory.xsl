<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">
  <!-- Core -->
  <xsl:import href="../../framework/queryform/xsl/searchformfilter.xsl"/>
  <!--xsl:import href="../../context/xsl/context_header.xsl"/-->
  <!-- Errors -->
  <xsl:import href="../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>
  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:call-template name="include_javascript_history"/>
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">
    <xsl:call-template name="include_form_validation_js"/>
    <!-- Body -->
    <table id="top_table" border="0" cellpadding="0" cellspacing="0">
      <tr width="100%">
        <td align="CENTER" >
          <xsl:apply-templates select="QUERY_DETAILS"/>
        </td>
      </tr>
      <tr width="100%">
        <td align="CENTER" >
          <xsl:apply-templates select="EXECUTION_HISTORY"/>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!--***********************************************************************
     *********************************************************************** -->
  <xsl:template match="QUERY_DETAILS">
      <table id="bom_tab" width="100%">
          <tr>
            <td nowrap="nowrap">
    <i2:container id="queryDetail_container" title="Query Details">
              <table id="queryHistory_inner_table" border="0" cellpadding="0" cellspacing="9" width="100%">
                <tr>
                  <td nowrap="nowrap" width="50%">
                    <i18n:text>Query Name</i18n:text>
                    <xsl:text>:</xsl:text>
                    <xsl:value-of select="queryName/@Value"/>
                  </td>
                  <td nowrap="nowrap" width="50%">
                    <i18n:text>Last Executed By</i18n:text>
                    <xsl:text>:</xsl:text>
                    <xsl:value-of select="lastExecutedBy/@Value"/>
                  </td>
                  <td nowrap="nowrap" width="50%">
                    <i18n:text>Last Executed Result</i18n:text>
                    <xsl:text>:</xsl:text>
                    <xsl:value-of select="lastResult/@Value"/>
                  </td>
                </tr>
                <tr>
                  <td nowrap="nowrap" width="50%">
                    <i18n:text>Created By</i18n:text>
                    <xsl:text>:</xsl:text>
                    <xsl:value-of select="CREATED_BY/@Value"/>
                  </td>
                  <td nowrap="nowrap" width="50%">
                    <i18n:text>Last Executed Timestamp</i18n:text>
                    <xsl:text>:</xsl:text>
                    <xsl:value-of select="lastRunDateTime/@Value"/>
                  </td>
                  <td nowrap="nowrap" width="50%">
                    <i18n:text>Last Executed Runtime</i18n:text>
                    <xsl:text>:</xsl:text>
                    <xsl:value-of select="lastRunTime/@Value"/>
                  </td>
                </tr>
                <tr>
                  <td nowrap="nowrap" width="50%">
                    <i18n:text>Number of times Executed</i18n:text>
                    <xsl:text>:</xsl:text>
                    <xsl:value-of select="TOTAL_RECORD_COUNT/@Value"/>
                  </td>
                </tr>
              </table>
    </i2:container>
            </td>
          </tr>
      </table>
  </xsl:template>
  <!--***********************************************************************
  *********************************************************************** -->
  <xsl:template match="EXECUTION_HISTORY">
    <table id="history_tab" border="0" cellpadding="0" cellspacing="2" width="100%">
      <tr width="100%">
        <td nowrap="nowrap" width="100%">
          <xsl:apply-templates select="SEARCH">
            <xsl:with-param name="formName" select="'result_form'"/>
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
      requiredFieldCheck('onLoad');
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
  <xsl:template name="include_javascript_history">
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

      function onCancel(){
        document.result_form.target="appFrame";
        document.result_form.action="manageQueryController/cancel.cmd";
        document.result_form.submit();
      }

      // Resizing All containers
      function resizeAll(){
        //alert("in resize");
    	var table_id = 'result_form_table';
    	var width = document.body.offsetWidth -5 ;
    	var height = document.body.scrollHeight;
    	// resize table   approx
    	//i2uiResizeColumns(table_id);
    	i2uiResizeScrollableArea(table_id, height-200, width-39, null, null, null,null, null);
    	i2uiResizeScrollableArea('queryHistory_inner_table', height-200, width-37, null, null, null,null, null);
    	i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight-10, null, document.body.offsetWidth - 20, true, 'yes');
    	i2uiResizeScrollableContainer('queryDetail_container',document.body.offsetHeight-10, null, document.body.offsetWidth - 20, true, 'yes');
      }
  </script>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
</xsl:stylesheet>

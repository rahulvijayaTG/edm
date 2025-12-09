<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../queryform/xsl/searchformfilter.xsl"/>
  <xsl:output method="html"/>
  <xsl:template match="RESPONSES" mode="content">
    <xsl:if test="count(RESPONSE/HEADER_CONTEXT/*) > 0 ">
      <xsl:apply-templates select="RESPONSE/HEADER_CONTEXT"/>
    </xsl:if>
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <table>
      <tr>
        <td>
         &#xA0;&#xA0;
       </td>
      </tr>
    </table>
    <xsl:call-template name="include_javascript_table"/>
  </xsl:template>
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <table id="resource_table" width="100%">
      <xsl:if test="count(SUCCESS_MESSAGE) &gt; 0">
        <tr>
          <td>
            <!-- Location save success message -->
            <xsl:apply-templates select="SUCCESS_MESSAGE"/>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="count(ERROR_MESSAGE) &gt; 0">
        <tr>
          <td>
            <!-- Location save error message -->
            <xsl:apply-templates select="ERROR_MESSAGE"/>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td>
          <!-- Location search -->
          <xsl:apply-templates select="SEARCH">
            <xsl:with-param name="formName" select="'result_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>
  <xsl:template match="SUCCESS_MESSAGE">
    <i2:img src="/alert_green_static.gif" border="0" align="middle">
      <i2:attribute name="alt">
        <i18n:text>Success</i18n:text>
      </i2:attribute>
    </i2:img>
        &#xA0;
        <i18n:text>
      <xsl:value-of select="@Value"/>
    </i18n:text>
  </xsl:template>
  <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="ERROR_MESSAGE">
    <i2:img src="/alert_static.gif" border="0" align="middle">
      <i2:attribute name="alt">
        <i18n:text>Error</i18n:text>
      </i2:attribute>
    </i2:img>
        &#xA0;
        <i18n:text>
      <xsl:value-of select="@Value"/>
    </i18n:text>
  </xsl:template>
  <!--**************************************************
  *********************************************************************** -->
  <xsl:template name="include_javascript_table">
    <script>
   function saveReport()
    {
      document.result_form.target = "i2ui_shell_bottom";
      document.result_form.action='controller/exportToExcel.cmd';
      document.result_form.submit();
    }
    function onDelete()
    {
      var confirmMesg = "<i18n:text>LOC_REMOVE</i18n:text>"
      if (checkifAnySelected(document.result_form))
      {
              if( core_confirm( confirmMesg ) == 'yes' )
                {
                document.result_form.target="appFrame";
                document.result_form.START_COUNT.value = 0 ;
                document.result_form.action="controller/delete.cmd";
                document.result_form.submit();
                }
         }
      	 else
         {
             core_alert("<i18n:text>LOC_DEL</i18n:text>");
         }
      }
      function onAdd()
      {
        document.result_form.ACTION.value = 'createLoc';
        document.result_form.target="appFrame";
        document.result_form.method="POST";
        document.result_form.action="detail/controller/display.cmd";
        document.result_form.submit();
      }
      function onClear()
      {
        document.result_form.target="appFrame";
        document.result_form.PAGE.value="searchLocation";
        document.result_form.action="../framework/filter/controller/clearFilter.cmd";
        document.result_form.submit();
      }
      
      function onCopy()
      {
        if (checkifAnySelected(document.result_form))
        {
          if(checkifOneSelected(document.result_form))
          {
            document.result_form.ACTION.value = 'COPY';
            document.result_form.target="appFrame";
            document.result_form.START_COUNT.value = 0 ;
            document.result_form.action="detail/controller/display.cmd";
            document.result_form.submit();        
          }
          else
          {
             core_alert("<i18n:text>Please select only one Location to copy.</i18n:text>");
          }          
        }
        else
        {
          core_alert("<i18n:text>Please select a Location to Copy.</i18n:text>");
        }
      }
      
      function checkifOneSelected(form)
      {
	var count;
	var numOfChecks = 0;
	var elementsLen = form.elements.length;
	var oneCheck = true;
	for(count = 0; count &lt; elementsLen; count++)
	{
	  if( form.elements[count].type == "checkbox" &amp;&amp; form.elements[count].checked == true  &amp;&amp;
    	     form.elements[count].name != "SELECT_ALL"  )
	   {
	     numOfChecks++;
	   }
	}
	if (numOfChecks &gt; 1)
	{
	  oneCheck = false;
	}
	return oneCheck;
      }
      
      function onExportToExcel(fileName,fileFormat){
	exportAll = 'YES';
        document.result_form.target="appFrame";
	document.result_form.action=omxContextPath+ "/bcm/framework/util/exportToExcel.cmd?EXPORT_ALL="+exportAll+"&amp;FILE_NAME="+fileName+"&amp;FILE_FORMAT="+fileFormat;
	document.result_form.submit();
      }
      
      function getErrorsS1(Classification){
        if (Classification == 'Total'){ Classification = ''}
        document.result_form.target="appFrame";
	document.result_form.action="dataValidationSummaryView/getErrorSearchPage.cmd?Classification="+Classification+"&amp;Severity=S1";
	document.result_form.submit();
      }

      function getErrorsS2(Classification){
        if (Classification == 'Total'){ Classification = ''}
        document.result_form.target="appFrame";
	document.result_form.action="dataValidationSummaryView/getErrorSearchPage.cmd?Classification="+Classification+"&amp;Severity=S2";
	document.result_form.submit();
      }

      function getErrorsS3(Classification){
        if (Classification == 'Total'){ Classification = ''}
        document.result_form.target="appFrame";
	document.result_form.action="dataValidationSummaryView/getErrorSearchPage.cmd?Classification="+Classification+"&amp;Severity=S3";
	document.result_form.submit();
      }

      function getErrorsS4(Classification){
        if (Classification == 'Total'){ Classification = ''}
        document.result_form.target="appFrame";
	document.result_form.action="dataValidationSummaryView/getErrorSearchPage.cmd?Classification="+Classification+"&amp;Severity=S4";
	document.result_form.submit();
      }

      function getErrorsAll(Classification){
        if (Classification == 'Total'){ Classification = ''}
        document.result_form.target="appFrame";
	document.result_form.action="dataValidationSummaryView/getErrorSearchPage.cmd?Classification="+Classification+"&amp;Severity=";
	document.result_form.submit();
      }
    </script>
  </xsl:template>
</xsl:stylesheet>

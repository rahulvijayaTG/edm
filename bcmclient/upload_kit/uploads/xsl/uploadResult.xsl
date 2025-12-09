<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:import href="../../../core/xsl/page.xsl"/>
<xsl:import href="../../../core/xsl/container.xsl"/>

<xsl:output method="html"/>

  <!-- Entry Point -->
  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  </xsl:template>

<!-- ********************************************************************** 
     *********************************************************************** --> 
  <xsl:template match="RESPONSE" mode="container_content">  
    <script type="text/javascript">
  function showReports()
    { 
    document.location.href="../reports/reports/showReports.x2c";
    }
    
    function showReportDetails()
    {
      var reportId = document.resultsForm.ReportId.value;
      document.location.href="../reports/reports/showReportDetails.x2c?REPORT_ID=" + reportId;
    }
  </script>
  <xsl:variable name="result_header">
    <i18n:text>Upload Confirmation</i18n:text>
  </xsl:variable>      
  
  <!-- Template Property Details -->
  <table width="100%" border="0" class="tableRow1" cellspacing="0">
      <tr>
        <form name="resultsForm" method="post">
          <input type="hidden" name="ReportId" value="{REPORT_ID/@Value}"/>
          <td  width="100%" height="100%" valign="top">
        <table>
        <xsl:if test="WARNING">
          <tr>
          <td colspan="2">
            <i18n:text><xsl:value-of select="STATUS/@Value"/></i18n:text>: <i18n:text><xsl:value-of select="WARNING/@Value"/></i18n:text>
            <br/>
          </td>
        </tr>
        </xsl:if>
        <xsl:if test="not(WARNING)">
          <tr>
              <td colspan="2">
              <i18n:text>Your upload request has been successfully submitted.</i18n:text>
            </td>
              </tr>
            <tr>
              <td nowrap="yes">
            <i18n:text>Report ID is</i18n:text> &#xA0; <b><a href="javascript:showReportDetails()"> <xsl:value-of select="REPORT_ID/@Value"/></a></b>
          </td>
            </tr>
        </xsl:if>
        </table>
          </td>
        </form>
      </tr>
    </table>
</xsl:template>

</xsl:stylesheet>

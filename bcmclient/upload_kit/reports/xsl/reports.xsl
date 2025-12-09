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

  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <script type="text/javascript" src="../uploadkit.js"></script>

    <xsl:call-template name="javascript_functions"/>
    
    <form name="reportsForm" method="POST">
      <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
        <xsl:with-param name="content" select="RESPONSE/REPORTS"/>
      </xsl:apply-templates>
    </form>
  </xsl:template>

  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="REPORTS" mode="container_content">

    <xsl:choose>    
      <xsl:when test="count(REPORT) > 0">
        <i2:table>
          <i2:tr header="yes">
            <td nowrap="yes" align="center">
              <input type="checkbox" name="REPORT_CHECKBOX" value="true" onclick="javascript:toggleCheckboxes(document.reportsForm, document.reportsForm.REPORT_ID, document.reportsForm.REPORT_CHECKBOX);"/>
            </td>
            <td nowrap="yes">
              <i18n:text>Report ID</i18n:text>
            </td>
            <td nowrap="yes">
              <i18n:text>Document Type</i18n:text>
            </td>
            <td nowrap="yes">
              <i18n:text>Report Time</i18n:text>
            </td>
            <td width="22%" nowrap="yes">
              <i18n:text>Records Processed</i18n:text>
            </td>
            <td nowrap="yes">
              <i18n:text>Progress</i18n:text>
            </td>
            <td nowrap="yes">
              <i18n:text>Status</i18n:text>
            </td>
          </i2:tr>
          <xsl:apply-templates select="REPORT" />
        </i2:table>
      </xsl:when>
      <xsl:otherwise>
        <i18n:text>No upload reports available</i18n:text>
      </xsl:otherwise>
    </xsl:choose>       
  </xsl:template>

  <xsl:template match="REPORT">
    <xsl:variable name="reportId">
      <xsl:value-of select="@ReportId" />
    </xsl:variable>
    <i2:tr>   
          <td nowrap="yes" align="center">
        <input type="checkbox" name="REPORT_ID" value="{$reportId}">
        </input>
          </td>
          <td nowrap="yes">
        <a href="report_details.jsp?REPORT_ID={$reportId}" target="appFrame"><xsl:value-of select="$reportId"/></a>
          </td>
          <td nowrap="yes">
            <i18n:text><xsl:value-of select="TEMPLATE/@DisplayName"/></i18n:text>
          </td>
          <td nowrap="yes">
            <i18n:date><xsl:value-of select="@StartTime"/></i18n:date>
          </td>
      <td nowrap="yes">
            <xsl:value-of select="@Index"/>
          </td>
          <td nowrap="yes">
            <i18n:text><xsl:value-of select="@Progress"/></i18n:text>
          </td>
      <td nowrap="yes">
            <i18n:text><xsl:value-of select="@Status"/></i18n:text>
          </td>
    </i2:tr>
  </xsl:template>

  <xsl:template name="javascript_functions">
    <script type="text/javascript">
      <![CDATA[
      function deleteReport()
      {
        if (!isCheckboxSelected())
          omx_alert("You much select at least one report to delete");
        else
        {
          document.reportsForm.action="reports/deleteReport.x2c";
          document.reportsForm.submit();
        }
      }
  
      function isCheckboxSelected()
      {
        if(!document.reportsForm.REPORT_ID)
          return false;
        else
        {
          var length = document.reportsForm.REPORT_ID.length;
          if(isNaN(length))
          {
            if (document.reportsForm.REPORT_ID.checked)
              return true;
          }
          for (var i=0;i<length;i++)
          {
            if (document.reportsForm.REPORT_ID[i].checked)
            {
              return true;
            }
          }       
        }  
        return false;
      }
    ]]>
    </script>  
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

</xsl:stylesheet>

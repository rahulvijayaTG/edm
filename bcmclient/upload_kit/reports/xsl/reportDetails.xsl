<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../core/xsl/container.xsl"/>
  
  <xsl:output method="html"/>
  <xsl:template match="RESPONSES" mode="content">
    <script type="text/javascript" src="../reports.js"/>
    <script type="text/javascript" src="../../i2/javascript/search.js"/>
    <xsl:call-template name="include_javascript_current"/>
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE/REPORTS"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template match="REPORTS" mode="container_content">
    <!-- Report Details -->
    <table width="100%">
      <tr>
        <td>
          <xsl:apply-templates select="REPORT"/>
        </td>
      </tr>
      <xsl:if test="BASIC_ERROR_REPORT/*">
        <tr>
          <td>
            <xsl:apply-templates select="BASIC_ERROR_REPORT">
              <xsl:with-param name="pReportID" select="REPORT/@ReportId"/>
            </xsl:apply-templates>
          </td>
        </tr>
      </xsl:if>
    </table>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="REPORT">
    <table width="100%">
      <!--tr class="text">
        <td nowrap="yes">
          <i18n:text>Template Name</i18n:text>:
        </td>
        <td nowrap="yes">
          <i18n:text><xsl:value-of select="../UPLOAD_PROGRESS_REPORT/TEMPLATE_NAME/@Value"/></i18n:text>
        </td>
      </tr-->
      <tr class="text">
        <td nowrap="yes">
          <i18n:text>Report Id</i18n:text>:
        </td>
        <td nowrap="yes">
        <b><a href="javascript:showReportDetails()"> <xsl:value-of select="@ReportId"/></a></b>
          <!--xsl:value-of select="@ReportId"/-->
        </td>
      </tr>
      <tr class="text">
        <td nowrap="yes">
          <i18n:text>Start Time</i18n:text>:
        </td>
        <td nowrap="yes">
          <i18n:date format="datetime">
            <xsl:value-of select="@StartTime"/>
          </i18n:date>
        </td>
      </tr>
      <tr class="text">
        <td nowrap="yes">
          <i18n:text>Process Time</i18n:text>:
        </td>
        <td nowrap="yes">
          <i18n:date format="datetime">
            <xsl:value-of select="@ProcessTime"/>
          </i18n:date>
        </td>
      </tr>
      <tr class="text">
        <td nowrap="yes">
          <i18n:text>Progress</i18n:text>:
        </td>
        <td nowrap="yes">
          <i18n:text>
            <xsl:value-of select="@Progress"/>
          </i18n:text>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- Table Title -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="BASIC_ERROR_REPORT" mode="title">
    <i18n:text>Errors</i18n:text>
    <xsl:variable name="currentPage"><xsl:value-of select="ceiling((@StartAtRow+1) div @MaxRows)"/></xsl:variable>
    <xsl:variable name="endPage">
      <xsl:choose>
        <xsl:when test="@TotalRowCount = '1000000000000000'"><i18n:text>UnKnown</i18n:text>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="ceiling(@TotalRowCount div @MaxRows)"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="endPage_i18n">
      <xsl:choose>
        <xsl:when test="$endPage='UnKnown'">
        </xsl:when>
        <xsl:otherwise>
          <i18n:text>of</i18n:text>&#xA0;<i18n:number><xsl:value-of select="$endPage"/></i18n:number>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>:&#xA0;<i18n:text>Page</i18n:text>&#xA0;<i18n:number><xsl:value-of select="$currentPage"/></i18n:number>&#xA0;<xsl:value-of select="$endPage_i18n"/>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="BASIC_ERROR_REPORT">
    <xsl:param name="pReportID"/>

    <form name="result_form" method="post">
      <input type="hidden" name="ID" value="{$pReportID}"/>
      <i2:container id="errorContainer">
        <!-- Title -->
        <i2:attribute name="title">
          <xsl:apply-templates select="." mode="title"/>
        </i2:attribute>
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td>
              <i2:table id="errorsTable">
                <i2:tr header="yes">
                  <td nowrap="yes">
                    <i18n:text>#</i18n:text>
                  </td>
                  <td nowrap="yes">
                    <i18n:text>Description</i18n:text>
                  </td>
                </i2:tr>
                <xsl:apply-templates select="ERROR">
                  <xsl:with-param name="pReportID" select="$pReportID"/>
                </xsl:apply-templates>
              </i2:table>
            </td>
          </tr>
        </table>

        <xsl:call-template name="footer">
          <xsl:with-param name="pMaxRows" select="@MaxRows"/>
          <xsl:with-param name="pStartAtRow" select="@StartAtRow"/>
          <xsl:with-param name="pTotalRowCount" select="@TotalRowCount"/>
        </xsl:call-template>
      </i2:container>
    </form>
    <xsl:call-template name="pagination_forms">
      <xsl:with-param name="pMaxRows" select="@MaxRows"/>
      <xsl:with-param name="pStartAtRow" select="@StartAtRow"/>
      <xsl:with-param name="pTotalRowCount" select="@TotalRowCount"/>
      <xsl:with-param name="pReportID" select="$pReportID"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ERROR">
    <xsl:param name="pReportID"/>
    <i2:tr>
      <td nowrap="yes">
        <a href="../uploads/uploadcorrection/upload_correction.jsp?INDEX={@Index}&amp;REPORT_ID={$pReportID}" target="appFrame">
        	<xsl:value-of select="@Index"/>
        </a>
      </td>
      <td nowrap="yes">
        <xsl:value-of select="@Message"/>
      </td>
    </i2:tr>
  </xsl:template>

  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="onLoad_js">function onLoad() {
    <xsl:call-template name="javascript_onLoad_tab"/>
    <xsl:call-template name="javascript_onLoad_page"/>
    }
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="onResize_js">function onResize() {
    <xsl:call-template name="javascript_onResize_tab"/>
    <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>
  <!-- Javascript -->
  <!-- **********************************************************************
               *********************************************************************** -->
  <xsl:template name="javascript_onLoad_tab">
    <xsl:call-template name="javascript_resizeTabs"/>
    resize_errors_table();
  </xsl:template>
  <!-- **********************************************************************
               *********************************************************************** -->
  <xsl:template name="javascript_onResize_tab">
    <xsl:call-template name="javascript_resizeTabs"/>
    resize_errors_table();
  </xsl:template>
  <!-- Current.xsl Javascript -->
  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="include_javascript_current">
    <script>
    var reportID = '<xsl:value-of select="/RESPONSES/RESPONSE/REPORT_ID/@Value"/>';
    function resize_errors_table()
    {
            if (!document.layers)
            {
                var x = document.body.scrollWidth - 50;
                i2uiResizeScrollableArea('errorsTable',220,x,null,10);
                i2uiResizeColumns('errorsTable');
                i2uiResizeScrollableContainer('container',document.body.offsetHeight -100, null, document.body.offsetWidth - 20, true, 'yes');
            }
    }
    function showReportDetails()
    {
    	document.location.href="../reports/reports/showReports.x2c?REPORT_ID=" + reportID;
    }

    </script>
  </xsl:template>
  <!-- **********************************************************************
          *********************************************************************** -->
  <xsl:template name="footer">
    <xsl:param name="pMaxRows" select="'10'"/>
    <xsl:param name="pStartAtRow" select="'0'"/>
    <xsl:param name="pTotalRowCount" select="'1'"/>
    <i2:footer>
      <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
          <!-- Pagination -->
          <td>
            <i2:pagingcontrol currentPage="{ceiling((number($pStartAtRow)+1) div number($pMaxRows))}" recordsPerPage="{number($pMaxRows)}" totalRecords="{number($pTotalRowCount)}"/>
          </td>
        </tr>
      </table>
      <input type="hidden" name="RECORD_COUNT" value="{number($pTotalRowCount)}"/>
      <input type="hidden" name="START_COUNT" value="{number($pStartAtRow)}"/>
      <input type="hidden" name="MAX_ROWS" value="{number($pMaxRows)}"/>
    </i2:footer>
  </xsl:template>
  <xsl:template name="pagination_forms">
    <xsl:param name="pMaxRows" select="'10'"/>
    <xsl:param name="pStartAtRow" select="'0'"/>
    <xsl:param name="pTotalRowCount" select="'1'"/>
    <xsl:param name="pReportID"/>
    <form name="search_form">
      <input type="hidden" name="RECORD_COUNT" value="{number($pTotalRowCount)}"/>
      <input type="hidden" name="START_COUNT" value="{number($pStartAtRow)}"/>
      <input type="hidden" name="MAX_ROWS" value="{number($pMaxRows)}"/>
      <input type="hidden" name="REPORT_ID" value="{$pReportID}"/>
    </form>
  </xsl:template>
</xsl:stylesheet>


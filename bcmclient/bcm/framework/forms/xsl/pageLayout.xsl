<?xml version="1.0" standalone='no'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n" version="1.0">

  <xsl:import href="gridLayout.xsl"/>
  <xsl:import href="flowLayout.xsl"/>
  <xsl:import href="resizeJavascript.xsl"/>

  <xsl:import href="../../../../core/xsl/page_header.xsl"/>
  <xsl:import  href="../../../../bcm/framework/xsl/buttons.xsl"/>

  <xsl:output method="html"/>


  <xsl:variable name="page" select="/RESPONSES/RESPONSE/PAGE"/>
  <xsl:variable name="updt_act" select="$page/SUBMITTED_DATA/UPDATE_ACTION/@Value"/>
  <xsl:variable name="updt_md" select="$page/SUBMITTED_DATA/UPDATE_MODE/@Value"/>
  <xsl:variable name="frm_id" select="$page/SUBMITTED_DATA/FORM_ID/@Value"/>
  <xsl:variable name="pg" select="$page/SUBMITTED_DATA/PAGE/@Value"/>
  <xsl:variable name="st_cnt" select="$page/SUBMITTED_DATA/START_COUNT/@Value"/>
  <xsl:variable name="fltr_text" select="$page/SUBMITTED_DATA/FILTER_TEXT/@Value"/>
  <xsl:variable name="tab_name" select="$page/SUBMITTED_DATA/TABLE_NAME/@Value"/>

  <xsl:template match="PAGE">
    <html>
      <xsl:call-template name="getHTMLHeader"/>
      <xsl:call-template name="getHTMLBody"/>
    </html>
  </xsl:template>

  <xsl:template name="getHTMLHeader">
    <head>
      <xsl:call-template name="addCommonCSSFiles"/>
      <xsl:call-template name="addCommonJavascriptFiles"/>
      <xsl:call-template name="addPageSpecificJavascriptFiles"/>
      <title><xsl:call-template name="getPageTitle"/></title>

      <script>
        <!-- Refer to resize_javascript.xsl for this template code -->
        <xsl:call-template name="generateResizingJavascript"/>
        <xsl:call-template name="includeOverrideJavascript"/>
      </script>
    </head>
  </xsl:template>

  <xsl:template name="getHTMLBody">
    <body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0"
      class="shellContent" onLoad="onLoad();" onResize="onResize();">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
          <!-- Header -->
          <xsl:choose>
            <xsl:when test="HEADER/SCM_CONTEXT/@Value = 'TRUE'">
              <script>
                findscmtop();
                scmtop.globalaction_frame.location = "../../../scenario/mdm_globalaction_frame.jsp";
                scmtop.scmHistory.setSolutionName("Data Management");
                scmtop.scmHistory.clearHistory();

                <xsl:for-each select="HEADER/BREADCRUMBS/BREADCRUMB">
                  scmtop.scmHistory.addHistory('<xsl:value-of select="DISPLAY_TEXT/@Value"/>','<xsl:value-of select="URL/@Value"/>', '<xsl:value-of select="URL/@Value"/>', scmtop.data_frame.appFrame);
                </xsl:for-each>
              </script>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="HEADER">
                <tr>
                  <td height="25px">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                      <tr>
                        <td height="25px">
                          <xsl:apply-templates select="HEADER" mode="content_header"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>

          <tr>
            <form name="main_form" method="POST">
              <!--Added all these variables for FK look ups for QForm massupdates -->
		<input type="hidden" name="FROM_TABLE"/>
		<input type="hidden" name="FROM_COLUMN"/>
		<input type="hidden" name="REFERRED_TABLE"/>
		<input type="hidden" name="REFERRED_COLUMN"/>
		<input type="hidden" name="SERVICE"/>
		<input type="hidden" name="PAGE1"/>
		<input type="hidden" name="UPDATE_ACTION" value="{$updt_act}"/>
		<input type="hidden" name="UPDATE_MODE" value="{$updt_md}"/>
		<input type="hidden" name="PAGE" value="{$pg}"/>
		<input type="hidden" name="FORM_ID" value="{$frm_id}"/>
		<input type="hidden" name="TABLE_NAME" value="{$tab_name}"/>
		<input type="hidden" name="FILTER_TEXT" value="{$fltr_text}"/>
    		<input type="hidden" name="START_COUNT" value="{$st_cnt}"/>
            <td valign="top" height="100%" class="contentFrameBody">
              <table border="0" cellpadding="0" cellspacing="8" width="100%" height="100%">
                <tr>
                  <td valign="top" width="100%" height="100%">
                    <xsl:apply-templates mode="pageSpecific"/>
                    <xsl:apply-templates select="LAYOUT"/>
                  </td>
                </tr>
              </table>
            </td>
            <xsl:apply-templates select="HIDDEN_FIELD"/>
            <xsl:call-template name="includePageSpecificFormVariables"/>
            </form>
          </tr>
        </table>

        <script>
          <xsl:call-template name="includePageLoadedJavascript"/>
        </script>
    </body>
  </xsl:template>

  <xsl:template name="includePageLoadedJavascript"/>
  <xsl:template name="includePageSpecificFormVariables"/>
  <xsl:template name="addCommonCSSFiles">
    <!-- Doubt :Siraj : i2uipad.css is included by i2uitaglib DHMTL tag. And our dtml implementation
          Doubt : Siraj : calls omxSetContextPath() javascript function -->
    <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
    <i2:stylesheet path="/omx_core.css"></i2:stylesheet>
    <i2:stylesheet path="/i2uipad.css"></i2:stylesheet>
  </xsl:template>

  <xsl:template name="addPageSpecificJavascriptFiles"/>

  <xsl:template name="addCommonJavascriptFiles">
    <!--TODO Siraj : Cleanup global javascript. Lotta omx-specific code -->
    <i2:javascript path="/global_javascript.js"></i2:javascript>
    <i2:javascript path="/date_validation.js"></i2:javascript>
    <i2:javascript path="/calendar.js"></i2:javascript>
    <!--TODO Siraj : The gap javascript has been put into this file -->
    <i2:javascript path="/gap.js"></i2:javascript>

    <i2:dhtml padsupport="yes"/>
  </xsl:template>


  <!-- A placeholder for including custom Javascript that are specific to each page
        being displayed. Just need to put the javascript directly inside the template.
        No need to enclose it with the script tag -->
  <xsl:template name="includeOverrideJavascript"/>

  <xsl:template name="getPageTitle">
    <i18n:text>Home Page</i18n:text>
  </xsl:template>

  <!--TODO Siraj : Make sure that the container has an id if it is scrollable -->
  <xsl:template match="CONTAINER">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@Width">
          <xsl:value-of select="@Width"/>
        </xsl:when>
        <xsl:otherwise>100%</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="titleSuffix">
      <xsl:call-template name="getTitleSuffix"/>
    </xsl:variable>
    <i2:container id="{@Id}" title="{@Title}" titlesuffix="{$titleSuffix}"
      width="{$width}" height="{@Height}" collapsable="{@Collapsable}" scrollable="{@Scrollable}"
      indentcontent="{@IndentContent}" inner="{@Inner}">

      <i2:header>
        <table border="0" cellpadding="2" cellspacing="0" width="100%">
          <tr>
            <td align="right">
              <table border="0" cellpadding="0" cellspacing="0" align="right">
                <tr>
<!--
                  <xsl:choose>
                    <xsl:when test = "HEADER/LINK">
                      <xsl:apply-templates select="HEADER/LINK"/>
                    </xsl:when>
                  </xsl:choose>
-->
                      <xsl:apply-templates select="HELP"/>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </i2:header>

      <xsl:if test="@FooterText">
        <i2:attribute name="footer">
          <xsl:value-of select="@FooterText"/>
        </i2:attribute>
      </xsl:if>

      <xsl:apply-templates select="CONTAINER | TABBED_CONTAINER | TABLE | HTML_TABLE | CUSTOM_TEMPLATE" />

      <xsl:if test="count(BUTTONS/*) &gt; 0">
        <i2:footer>
          <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
              <td align="right">
                <xsl:apply-templates select="BUTTONS"/>
              </td>
            </tr>
          </table>
        </i2:footer>
      </xsl:if>

    </i2:container>
  </xsl:template>

  <xsl:template name="getTitleSuffix">
    <xsl:value-of select="@TitleSuffix"/>
  </xsl:template>

  <xsl:template match="CUSTOM_TEMPLATE">
    <xsl:apply-templates select="$page/*" mode="customTemplate"/>
  </xsl:template>

  <xsl:template match="TABBED_CONTAINER">
    <i2:tabbedcontainer collapsable="yes">
      <i2:tabset id="tabs_container" field="grey">
        <xsl:apply-templates/>
      </i2:tabset>
      <xsl:apply-templates select="TAB/*"/>
    </i2:tabbedcontainer>
  </xsl:template>

  <xsl:template match="TAB">
    <i2:tab name="{@Name}" selected="{@Selected}" onclick="{@OnClick}" alttext="{@AltText}">
    </i2:tab>
  </xsl:template>

  <xsl:template match="ROW">
    <table>
      <tr>

      </tr>
    </table>
  </xsl:template>

  <xsl:template match="HTML_TABLE">
    <xsl:variable name="dataTag" select="@DataTag"/>

    <xsl:variable name="columns">
      <xsl:choose>
        <xsl:when test="@Columns">
          <xsl:value-of select="@Columns"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="1"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="doFlowLayout">
      <xsl:with-param name="noOfColumns" select="$columns"/>
      <xsl:with-param name="cellpadding" select="@CellPadding"/>
      <xsl:with-param name="cellspacing" select="@CellSpacing"/>
      <xsl:with-param name="element" select="/RESPONSES/RESPONSE/PAGE/*[name() = $dataTag]"/>
    </xsl:call-template>

  </xsl:template>

  <xsl:template match="TABLE">
    <xsl:variable name="dataTag" select="@DataTag"/>
    <xsl:variable name="presentationName" select="@Presentation"/>

    <xsl:call-template name="TableLayout">
      <xsl:with-param name="tableRowList" select="/RESPONSES/RESPONSE/PAGE/*[name() = $dataTag]"/>
      <xsl:with-param name="tableMetaData" select="/RESPONSES/RESPONSE/PAGE/PRESENTATION/TABLE[@Name = $presentationName]"/>
      <xsl:with-param name="filterData" select="/RESPONSES/RESPONSE/PAGE/FILTER_DATA"/>
      <xsl:with-param name="pageSize" select="@PageSize"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="HELP">
    <td>
    <a class="text" href="javascript:onHelp();">
      <xsl:attribute name="onClick">javascript:popUpWindow( '<xsl:value-of select="@Url"/>', 'popUp4')</xsl:attribute>
      <xsl:variable name="txtAltAttr"><i18n:text>Help</i18n:text></xsl:variable>
      <i2:img src="/help_avail.gif" alt="{$txtAltAttr}" border="0" align="middle"/>
    </a>
  </td>
  </xsl:template>

  <xsl:template match="HIDDEN_FIELD">
    <input type="hidden" name="{@Name}" value="{@Value}"/>
  </xsl:template>
</xsl:stylesheet>


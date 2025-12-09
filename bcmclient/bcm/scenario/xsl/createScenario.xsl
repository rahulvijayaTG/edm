<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../core/xsl/page.xsl"/>
<!--
  <xsl:import href="../../../core/xsl/container.xsl"/>
-->
  <xsl:import href="../../../bcm/framework/xsl/core_container_override.xsl"/>
  <xsl:import href="../../../bcm/framework/xsl/required_field.xsl"/>
  <!-- Errors -->
  <xsl:import href="../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>
  <xsl:variable name="dateFormat">
    <xsl:value-of select="/RESPONSES/RESPONSE/dateFormat/@Value"/>
  </xsl:variable>
  <!-- Page Content -->
  <!-- ********************************************************************************************************************************************* -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:call-template name="include_javascript_table"/>
    <xsl:call-template name="include_javascript_table_resize"/>
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- ********************************************************************************************************************************************* -->
  <xsl:template match="RESPONSE" mode="container_content">
    <xsl:variable name="name">
      <i18n:text>Name</i18n:text>
    </xsl:variable>
    <xsl:variable name="description">
      <i18n:text>Description</i18n:text>
    </xsl:variable>
    <xsl:variable name="parentScenarioName">
      <i18n:text>Parent Scenario</i18n:text>
    </xsl:variable>
    <table id="result_form_table" border="0" cellpadding="0" cellspacing="5" width="100%">
      <form id="result_form" name="result_form" method="POST">
        <tr>
          <td>
            <xsl:if test="count(SUCCESS_MESSAGE) &gt; 0">
              <xsl:apply-templates select="SUCCESS_MESSAGE"/>
            </xsl:if>
            <xsl:if test="count(ERROR_MESSAGE) &gt; 0">
              <xsl:apply-templates select="ERROR_MESSAGE"/>
            </xsl:if>
            <xsl:call-template name="display_instruction_area"/>
            <table id="table1" width="100%">
              <tr class="text">
                <td align="left" width="25%">
                  <xsl:value-of select="$name"/>:
                  <xsl:call-template name="display_alert_mark"/>
                </td>
                <td align="left">
                  <input type="field" name="name" value="" required="true" tabIndex="" class="inputfieldIE" size="22"/>
                  <xsl:call-template name="display_alert_image">
                    <xsl:with-param name="fieldName" select="'name'"/>
                  </xsl:call-template>
                </td>
              </tr>
              <tr class="text">
                <td align="left">
                  <xsl:value-of select="$description"/>:
                </td>
                <td align="left">
                  <input type="field" name="scenarioDescription" value="" tabIndex="" class="inputfieldIE" size="22"/>
                </td>
              </tr>
              <xsl:if test="SCENARIO/ACTION/@Value = 'Copy' ">
                <tr class="text">
                  <td align="left">
                    <xsl:value-of select="$parentScenarioName"/>:
                  </td>
                  <td align="left">
                    <i18n:text>
                      <xsl:value-of select="SCENARIO/name/@Value"/>
                    </i18n:text>
                  </td>
                </tr>
              </xsl:if>
            </table>
          </td>
        </tr>
      </form>
    </table>
  </xsl:template>
  <!--************************************************** 
  *********************************************************************** -->
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
        <i2:img src="/alert_static_small.gif" border="0" align="middle">
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
    <script><![CDATA[
    function onSave()
    {    
    	   error = "false";
        error = requiredFieldCheck();
    	   if ( error == 'false' )
        {
      	document.result_form.target="appFrame";
      	document.result_form.action="controller/saveScenario.cmd";
      	document.result_form.submit();
        }
    }

    function onCancel()  
    {    
	document.result_form.target="appFrame";
	document.result_form.action="scenarioSearch.jsp";
	document.result_form.submit();
    }
  ]]></script>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
      requiredFieldCheck('onLoad');
      resize_Containers();
    }
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onResize_js">
    function onResize()
    {
      <xsl:call-template name="javascript_onResize_page"/>
      resize_Containers();
    }
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
  <!-- Javascript -->
  <xsl:template name="include_javascript_table_resize">
    <script><![CDATA[
	function resize_Containers()
	{
		var width = document.body.offsetWidth - 50;
		var height = document.body.scrollHeight - 300;
		
		var table_id = 'result_form_table';
		i2uiResizeScrollableArea(table_id, 100, width, null, null, null,null, null);
		i2uiResizeColumns(table_id);
		i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight - 280, null, document.body.offsetWidth - 30, true, 'yes');
	}
]]></script>
  </xsl:template>
  <!-- **********************************************************************
   *********************************************************************** -->
  <xsl:template name="include_javascript_calendar">
    <i2:javascript path="/calendar.js"/>
  </xsl:template>
  <!-- **********************************************************************
   *********************************************************************** -->
</xsl:stylesheet>

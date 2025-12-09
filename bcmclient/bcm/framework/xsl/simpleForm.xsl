<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../core/xsl/i18n.xsl"/>
  <xsl:import href="required_field.xsl"/>
  <xsl:output method="html"/>
  <!-- Table Title -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TABLE" mode="table_title">
    <!-- Title -->
    <xsl:variable name="title">
      <xsl:choose>
        <xsl:when test="(string-length(@NoTitle) > 0 and @NoTitle = 'yes')"/>
        <xsl:when test="string-length(@Title) > 0">
          <i18n:text>
            <xsl:value-of select="@Title"/>
          </i18n:text>
        </xsl:when>
        <xsl:when test="(@DoSearch != 'false')">
          <b>
            <i18n:text>Search Results</i18n:text>
          </b>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <b>
      <xsl:value-of select="$title"/>
    </b>
  </xsl:template>
  <!-- Table -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TABLE" mode="table_container_header">
    <i2:header>
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td align="right">
            <table border="0" cellpadding="0" cellspacing="0" align="right">
              <tr>
                <xsl:apply-templates select="HELP"/>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </i2:header>
  </xsl:template>
  <!-- Table -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TABLE">
    <xsl:param name="formName"/>
    <xsl:variable name="tableId">
      <xsl:value-of select="concat($formName,'_table')"/>
    </xsl:variable>
    <xsl:variable name="tableContainerId">
      <xsl:value-of select="concat($formName,'_container')"/>
    </xsl:variable>
    <!-- Give Defaults - Start:: -->
    <xsl:variable name="method">
      <xsl:choose>
        <xsl:when test="@Method">
          <xsl:value-of select="@Method"/>
        </xsl:when>
        <xsl:otherwise>POST</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- html form -->
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
      <form name="{$formName}" method="{$method}">
        <tr>
          <td>
            <i2:container id="{$tableContainerId}" inner="yes">
              <xsl:if test="@ScrollableContainer = 'yes' ">
                <i2:attribute name="scrollable">yes</i2:attribute>
              </xsl:if>
              <xsl:if test="@CollapsableContainer = 'yes' ">
                <i2:attribute name="collapsable">yes</i2:attribute>
              </xsl:if>
              <i2:attribute name="title">
                <xsl:apply-templates select="." mode="table_title"/>
              </i2:attribute>
              <xsl:apply-templates select="." mode="table_container_header"/>
              <i2:table id="{$tableId}">
                <xsl:if test="@Scrollable = 'yes'  ">
                  <i2:attribute name="scrollablerows">yes</i2:attribute>
                  <i2:attribute name="scrollablecolumns">yes</i2:attribute>
                </xsl:if>
                <xsl:apply-templates select="TR[@Header]"/>
                <xsl:for-each select="TR[not(@Header)]">
                  <xsl:apply-templates select="."/>
                  <i2:tr>
                    <td colspan="2"/>
                  </i2:tr>
                </xsl:for-each>
              </i2:table>
              <xsl:apply-templates select="." mode="table_container_footer"/>
            </i2:container>
          </td>
        </tr>
        <!-- Hidden Rows -->
        <xsl:apply-templates select="TR[@Type='Hidden']" mode="hidden"/>
      </form>
    </table>
  </xsl:template>
  <!-- Table Row -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="TR[not(@Type) and not(@Header)]">
    <script type="">
  alert("sumanta6");
  </script>
uhwefiuhwefiuhwefiuhwefiuhwefiuhw
    <xsl:if test="string-length(@Type) = 0">
      <xsl:apply-templates select="TD" mode="content">
        <!-- do sorting -->
        <xsl:sort select="@Sequence" data-type="number" order="ascending"/>
        <xsl:with-param name="rowNo" select="position()-2"/>
        <xsl:with-param name="header" select="@Header"/>
        <xsl:with-param name="validate" select="../@Validation"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:template>
  <!-- Field - CheckBox -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[@Type = 'CheckBox']" mode="content">
    <xsl:param name="header" select="../@Header"/>
    <xsl:variable name="onclick">
      <xsl:choose>
        <xsl:when test="@OnClick">
          <xsl:value-of select="@OnClick"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <!-- Todo use class="checkboxColumn" only if first column -->
    <th nowrap="yes" align="center" class="checkboxColumn">
      <input type="checkbox" name="{@Name}" value="{@Value}" onclick="{$onclick}">
        <xsl:if test="@Checked = 'true'">
          <xsl:attribute name="checked">true</xsl:attribute>
        </xsl:if>
      </input>
    </th>
  </xsl:template>
  <!-- Field Radio -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[@Type = 'Radio']" mode="content">
    <!-- Todo use class="checkboxColumn" only if first column -->
    <th nowrap="yes" align="center" class="checkboxColumn">
      <input type="radio" name="{@Name}" value="{@Value}" onclick="{@OnClick}">
        <xsl:if test="@Checked">
          <xsl:attribute name="checked"/>
        </xsl:if>
      </input>
    </th>
  </xsl:template>
  <!-- Field Text, Date, Number -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (not (@Type) or @Type = 'Text' or @Type = 'Date'  or @Type = 'Currency' or @Type = 'Number' or @Type='Select') and not(@Editable)]" mode="content">
    <xsl:param name="header" select="../@Header"/>
    <xsl:param name="validate"/>
    <xsl:variable name="onmouseover">
      <xsl:choose>
        <xsl:when test="@OnMouseOver">
          <xsl:value-of select="@OnMouseOver"/>
        </xsl:when>
        <xsl:when test="@Sortable='yes' and $header = 'yes'">javascript:i2uiSetMenuCoords(this,event)</xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="align">
      <xsl:choose>
        <xsl:when test="@Align">
          <xsl:value-of select="@Align"/>
        </xsl:when>
        <xsl:when test="@Type = 'CheckBox'">center</xsl:when>
        <xsl:when test="@Type = 'Radio'">center</xsl:when>
        <xsl:when test="@Type = 'Currency'">right</xsl:when>
        <xsl:when test="@Type = 'Number'">right</xsl:when>
        <xsl:otherwise>left</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="isOverriden">
      <xsl:choose>
        <xsl:when test="@Overridden='yes'">#fff6a6</xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="onclick">
      <xsl:choose>
        <xsl:when test="@OnClick">
          <xsl:value-of select="@OnClick"/>
        </xsl:when>
        <xsl:when test="@Sortable = 'yes' and  $header = 'yes'">
          <xsl:variable name="quote">'</xsl:variable>
          <xsl:value-of select="concat('javascript:sort(', $quote, @Name, $quote, ')' )"/>
        </xsl:when>
        <xsl:when test="string-length(@Url) > 0">
          <xsl:value-of select="@Url"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <!-- start the row -->
    <i2:tr>
      <td bgcolor="{$isOverriden}" bordercolor="{$isOverriden}">
        <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
        <xsl:if test=" $validate='yes' and @Required = 'yes' and $header='yes' ">
          <xsl:call-template name="display_alert_mark"/>
        </xsl:if>
      </td>
      <td nowrap="yes" align="{$align}" bgcolor="{$isOverriden}" bordercolor="{$isOverriden}">
        <xsl:choose>
          <xsl:when test="string-length($onclick) > 0">
            <!--a onmouseover="{$onmouseover}" href="{$onclick}" >
            <xsl:if test="string-length(@Target) > 0  and string-length($onmouseover) = 0">
              <xsl:attribute name="target">
                <xsl:value-of select="@Target"/>
              </xsl:attribute>
            </xsl:if-->
            <i18n:text>
              <xsl:value-of select="@Value"/>
            </i18n:text>
            <!--/a-->
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="i18nize">
              <xsl:with-param name="pData" select="@Value"/>
              <xsl:with-param name="pNoData" select="' '"/>
              <xsl:with-param name="pType" select="@Type"/>
              <xsl:with-param name="pFormat" select="@Format"/>
              <xsl:with-param name="pDecimals" select="@Decimals"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </i2:tr>
  </xsl:template>
  <!-- Field - Phone -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Phone') and not(@Editable)]" mode="content">
    <td align="left" nowrap="yes">
      (<xsl:value-of select="substring(@Value,1,3)"/>)&#xA0;<xsl:value-of select="substring(@Value,4,3)"/>&#xA0;-&#xA0;<xsl:value-of select="substring(@Value,7,4)"/>
    </td>
  </xsl:template>
  <!-- Editable - Text -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Text') and (@Editable)]" mode="content">
    <xsl:param name="validate"/>
    <td align="left" nowrap="yes">
      <input fieldtype="text" name="{@Name}" value="{@Value}" required="true" tabIndex="" type="field" class="inputfieldIE" size="17"/>
      <xsl:if test="$validate='yes' and @Required = 'yes' ">
        <xsl:call-template name="display_alert_image">
          <xsl:with-param name="fieldName" select="@Name"/>
        </xsl:call-template>
      </xsl:if>
    </td>
  </xsl:template>
  <!-- Editable - Number -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Number') and (@Editable)]" mode="content">
    <xsl:param name="validate"/>
    <td align="left" nowrap="yes">
      <input fieldtype="text" name="{@Name}" value="{@Value}" required="true" tabIndex="" onkeyup="javascript:onlyInteger();" type="field" class="inputfieldIE" size="10"/>
      <xsl:if test="$validate='yes' and @Required = 'yes' ">
        <xsl:call-template name="display_alert_image">
          <xsl:with-param name="fieldName" select="@Name"/>
        </xsl:call-template>
      </xsl:if>
    </td>
  </xsl:template>
  <!-- Editable - Hidden -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Hidden' or @Type = 'None') and (@Editable)]" mode="content">
    <input name="{@Name}" value="{@Value}" type="hidden"/>
  </xsl:template>
  <!-- Editable - Select -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Select') and (@Editable)]" mode="content">
    <td nowrap="yes" align="left">
      <select class="pulldown" name="{@Name}" onchange="{@OnChange}">
        <xsl:choose>
          <xsl:when test=" @SelectAll='false' or @SelectAll = 'No' or @SelectAll ='no' "/>
          <xsl:otherwise>
            <option value="">
              <i18n:text>Select All</i18n:text>
            </option>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="OPTION"/>
      </select>
    </td>
  </xsl:template>
  <!-- Editable - Date -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Date') and (@Editable)]" mode="content">
    <xsl:param name="noOfRows"/>
    <xsl:param name="formName"/>
    <xsl:variable name="value">
      <i18n:date format="common">
        <xsl:value-of select="@Value"/>
      </i18n:date>
    </xsl:variable>
    <td align="left" nowrap="yes">
      <!-- input field -->
      <input fieldtype="text" name="{@Name}_DC" value="{$value}" type="field" class="inputfieldIE" size="10"/>&#xA0;

      <xsl:choose>
        <!-- If there > 1 rows -->
        <xsl:when test="$noOfRows > 1">
          <A HREF="javascript:setDateField(document.{$formName}.{@Name}_DC);" onclick="setDateField(document.{$formName}.{@Name}_DC);">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/>
          </A>
        </xsl:when>
        <!-- If 1 row -->
        <xsl:otherwise>
          <A HREF="javascript:doNothing()" onclick="setDateField(document.{$formName}.{@Name}_DC);">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/>
          </A>
        </xsl:otherwise>
      </xsl:choose>
      <!-- Calendar - End. -->
    </td>
  </xsl:template>
  <!-- Editable - Phone -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Phone') and (@Editable)]" mode="content">
    <td align="left" nowrap="yes">
      (<input fieldtype="{@Type}" name="{concat(@Name,'_AREA_CODE')}" value="{substring(@Value,1,3)}" type="field" class="inputfieldIE" size="3"/>)&#xA0;<input fieldtype="{@Type}" name="{concat(@Name,'_LOCAL_NUM_1')}" value="{substring(@Value,4,3)}" type="field" class="inputfieldIE" size="3"/>&#xA0;-&#xA0;<input fieldtype="{@Type}" name="{concat(@Name,'_LOCAL_NUM_2')}" value="{substring(@Value,7,4)}" type="field" class="inputfieldIE" size="4"/>
    </td>
  </xsl:template>
  <!-- Editable Select Option -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="OPTION">
    <xsl:choose>
      <xsl:when test="./@Id and ./@Value">
        <xsl:choose>
          <xsl:when test="../@Value = ./@Id">
            <option selected="yes" value="{./@Id}">
              <i18n:text>
                <xsl:value-of select="./@Value"/>
              </i18n:text>
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option value="{./@Id}">
              <i18n:text>
                <xsl:value-of select="./@Value"/>
              </i18n:text>
            </option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="./@Id and string-length(./@Value) = 0">
        <xsl:choose>
          <xsl:when test="../@Value = ./@Id">
            <option selected="yes" value="{./@Id}">
              <i18n:text>
                <xsl:value-of select="./@Id"/>
              </i18n:text>
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option value="{./@Id}">
              <i18n:text>
                <xsl:value-of select="./@Id"/>
              </i18n:text>
            </option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="./@Value and string-length(./@Id) = 0">
        <xsl:choose>
          <xsl:when test="../@Value = ./@Value">
            <option selected="yes" value="{./@Value}">
              <i18n:text>
                <xsl:value-of select="./@Value"/>
              </i18n:text>
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option value="{./@Value}">
              <i18n:text>
                <xsl:value-of select="./@Value"/>
              </i18n:text>
            </option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- Table Footer -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TABLE" mode="table_container_footer">
    <xsl:param name="formName"/>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">


  <xsl:import href="../../../core/xsl/i18n.xsl"/>                   

  <xsl:output method="html"/>

  <!-- Form Name -->
  <xsl:variable name="formName">result_form</xsl:variable>
  <xsl:variable name="tableId"><xsl:value-of select="concat($formName,'_table')"/></xsl:variable>
  <xsl:variable name="tableContainerId"><xsl:value-of select="concat($formName,'_container')"/></xsl:variable>


  <!-- Table Title -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match= "TABLE" mode="table_title">




  <!-- Title -->
  <xsl:variable name="title">
    <xsl:choose>
  		  <xsl:when test="(string-length(@NoTitle) > 0 and @NoTitle = 'yes')">
  		  </xsl:when>
        <xsl:when test="string-length(@Title) > 0">
          <b><i18n:text><xsl:value-of select="@Title"/></i18n:text></b></xsl:when>
        <xsl:when test="(@DoSearch != 'false')">
         <b><i18n:text>Search Results</i18n:text></b></xsl:when>
        <xsl:when test="$noOfRows != 0">
         <b><i18n:text>Search Results</i18n:text></b></xsl:when>
      </xsl:choose>
    </xsl:variable>

      <xsl:variable name="pagingTitle">
      <!-- 1 of 10 -->
      <xsl:if test="@PagingTitle">

      <xsl:variable name="endPage_i18n">
        <xsl:choose>
          <xsl:when test="$endPage='UnKnown'">
          </xsl:when>
          <xsl:otherwise>
           <i18n:text>of</i18n:text>&#xA0;<i18n:number><xsl:value-of select="$endPage"/></i18n:number>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

        <xsl:if test="$noOfRows > 0">:&#xA0;<i18n:text>Page</i18n:text>&#xA0;<i18n:number><xsl:value-of select="$currentPage"/></i18n:number>&#xA0;<xsl:value-of select="$endPage_i18n"/>
        </xsl:if>
      </xsl:if>
      </xsl:variable>

    <xsl:variable name="noRowsTitle">
    <!--  no rec found -->
    <xsl:if test="$noOfRows = 0">

      <xsl:variable name="noRowsTitle">
        <!-- Search Mode -->
        <xsl:if test="@DoSearch = 'Yes' or @DoSearch='yes' or @DoSearch='true'">
          <xsl:choose>
            <!-- Custom title -->
            <xsl:when test="string-length(@NoRecordsTitle) > 0">
              &lt;i&gt;<i18n:text><xsl:value-of select="@NoRecordsTitle"/></i18n:text>&lt;/i&gt;
            </xsl:when>
            <!-- NO_DOC_TYPE_FOUND -->
            <xsl:when test="string-length(@Document) > 0">
              <i18n:text><xsl:value-of select="concat('NO_',@Document,'_FOUND')"/></i18n:text>
            </xsl:when>
            <!-- No Records Found -->
            <xsl:otherwise>
               :&#xA0;<i18n:text>No records found</i18n:text>.
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:variable>

                <i18n:text><xsl:value-of select="$noRowsTitle"/></i18n:text>
              </xsl:if>

              </xsl:variable>
    <xsl:value-of select="concat($title,$pagingTitle,$noRowsTitle)"/>
  </xsl:template>


  <!-- Table -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match = "TABLE" mode="table_container_header">
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
  <xsl:template match = "TABLE">

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

    <table  width="100%"   cellspacing="0" cellpadding="0" border="0">
      <form name="{$formName}" method="{$method}">
      	<tr>
          <td>

            <!-- Hidden Fields -->

            <xsl:for-each select = "FIELD[@Type='Hidden']">
              <input name="{@Name}" type="hidden" value="{@Value}"/>
            </xsl:for-each>


            <i2:container id = "{$tableContainerId}" inner="yes" scrollable="yes">

              <i2:attribute name="title">
                <xsl:apply-templates select="." mode="table_title"/>
              </i2:attribute>

              <xsl:apply-templates select="." mode="table_container_header"/>

              <xsl:if test="$noOfRows > 0">
                <i2:table id="{$tableId}">
                  <xsl:if test="@Scrollable = 'yes'">
                    <i2:attribute name="scrollablerows">yes</i2:attribute>
                    <i2:attribute name="scrollablecolumns">auto</i2:attribute></xsl:if>
                      <xsl:apply-templates/>
                </i2:table>
              </xsl:if>

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
  <xsl:template match = "TR">
    <xsl:if test="string-length(@Type) = 0">
      <i2:tr><xsl:if test="string-length(@Header) > 0"> <i2:attribute name="header">yes</i2:attribute> </xsl:if>
        <xsl:apply-templates select="TD" mode="content">
          <xsl:with-param  name="rowNo" select="position()-2"/>
          <xsl:with-param name="header" select="@Header"/>
        </xsl:apply-templates>
      </i2:tr>
    </xsl:if>
  </xsl:template>

  <!-- Table Row Hidden -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match = "TR" mode="hidden">
    <xsl:apply-templates select="TD" mode="content">
      <xsl:with-param  name="rowNo" select="position()-2"/>
      <xsl:with-param name="header" select="@Header"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- Field - Hidden -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[@Type = 'Hidden']" mode="content">
      <input name="{@Name}" type="hidden" value="{@Value}"/>
  </xsl:template>

  <!-- Field - CheckBox -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[@Type = 'CheckBox']" mode="content">
    <xsl:param name="header" select="../@Header"/>

    <xsl:param name="onclick"/>
    <xsl:param name="onmouseover"/>
    <xsl:param name="target"/>

    <xsl:variable name="onclick">
      <xsl:choose>
        <xsl:when test="@OnClick">
          <xsl:value-of select="@OnClick"/>
        </xsl:when>
        <xsl:when test="$header = 'yes'">
          <xsl:variable name="quote">'</xsl:variable>
          <xsl:variable name="currentTDPosition"><xsl:value-of select="position()"/></xsl:variable>
          <xsl:variable name="controlledCheckBoxName"><xsl:value-of select = "../../TR[position() != 1]/TD[position() = $currentTDPosition]/@Name"/>
          </xsl:variable>
             <xsl:value-of select="concat('javascript:toggleCheckboxes(document.forms.', $formName, ',' , 'document.forms.', $formName, '.', $controlledCheckBoxName, ',document.forms.', $formName, '.', @Name, ')' )"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

  <!-- Todo use class="checkboxColumn" only if first column -->
  <th nowrap="yes" align="center"  class="checkboxColumn">
    <input type="checkbox" name="{@Name}" value="{@Value}" onclick="{$onclick}">
      <xsl:if test="@Checked = 'true'"><xsl:attribute name="checked">true</xsl:attribute>
      </xsl:if>
    </input>
  </th>
  </xsl:template>

  <!-- Field None -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="TD[@Type = 'None']" mode="content">
  </xsl:template>

  <!-- Field Radio -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[@Type = 'Radio']" mode="content">
    <!-- Todo use class="checkboxColumn" only if first column -->
    <th nowrap="yes"  align="center"   class="checkboxColumn">
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

    <td nowrap="yes" align="{$align}">
      <xsl:choose>
        <xsl:when test="string-length($onclick) > 0">
          <a onmouseover="{$onmouseover}" href="{$onclick}" >
            <xsl:if test="string-length(@Target) > 0  and string-length($onmouseover) = 0">
              <xsl:attribute name="target">
                <xsl:value-of select="@Target"/>
              </xsl:attribute>
            </xsl:if>
            <i18n:text><xsl:value-of select="@Value"/></i18n:text>
          </a>
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

      <xsl:if test="@Sortable ='yes' and $header='yes' and $sortBy = @Name">
        <b>
<!--
        <xsl:value-of select="$sortImage"/>
-->
        <xsl:choose>
          <xsl:when test="/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_ORDER']/@Value = 'Descending'">
            &#xA0;&#xA0;&#xA0;<i2:img src="/descending_table_column.gif"/>
          </xsl:when>
          <xsl:otherwise>
            &#xA0;&#xA0;&#xA0;&#xA0;<i2:img src="/ascending_table_column.gif"/>
          </xsl:otherwise>
        </xsl:choose>
        </b>
      </xsl:if>

    </td>
  </xsl:template>


  <!-- Field - Phone -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Phone') and not(@Editable)]" mode="content">
    <td align="left" nowrap="yes">
      (<xsl:value-of select="substring(@Value,1,3)" />)&#xA0;<xsl:value-of select="substring(@Value,4,3)"/>&#xA0;-&#xA0;<xsl:value-of 	select="substring(@Value,7,4)"/>
    </td>
  </xsl:template>


  <!-- Editable - Text -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Text') and (@Editable)]" mode="content">
    <td align="left" nowrap="yes">
      <input fieldtype="text" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="17"/>
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
      <select  class="pulldown" name="{@Name}" onchange="{@OnChange}">
        <xsl:choose><xsl:when test=" @SelectAll='false' or @SelectAll = 'No' or @SelectAll ='no' "></xsl:when>
          <xsl:otherwise>
            <option value=""><i18n:text>Select All</i18n:text></option>
          </xsl:otherwise></xsl:choose>
        <xsl:apply-templates select="OPTION"/>
      </select>
    </td>
  </xsl:template>


  <!-- Editable - Date -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Date') and (@Editable)]" mode="content">
   <xsl:param name="rowNo"/>
    <xsl:variable name="value">
      <i18n:date format="common"><xsl:value-of select="@Value"/></i18n:date>
    </xsl:variable>

    <td align="left" nowrap="yes">
      <!-- input field -->
      <input fieldtype="text" name="{@Name}_DC" value="{$value}" type="field" class="inputfieldIE" size="10"/>&#xA0;

      <xsl:choose>
        <!-- If there > 1 rows -->
        <xsl:when test="$noOfRows > 1">
          <A HREF="javascript:setDateField(document.{$formName}.{@Name}_DC[{$rowNo - 1}]);" onclick="setDateField(document.{$formName}.{@Name}_DC[{$rowNo - 1}]);">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/></A>
        </xsl:when>
        <!-- If 1 row -->
        <xsl:otherwise>
          <A HREF="javascript:doNothing()" onclick="setDateField(document.{$formName}.{@Name}_DC);">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/></A>
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
      <xsl:when test="./@Id and ./@Value" >
        <xsl:choose>
          <xsl:when test="../@Value = ./@Id">
            <option selected="yes" value="{./@Id}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
          </xsl:when>
          <xsl:otherwise>
            <option  value="{./@Id}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
     <xsl:when test="./@Id and string-length(./@Value) = 0" >
        <xsl:choose>
          <xsl:when test="../@Value = ./@Id">
            <option selected="yes" value="{./@Id}"><i18n:text><xsl:value-of select="./@Id"/></i18n:text></option>
          </xsl:when>
          <xsl:otherwise>
            <option  value="{./@Id}"><i18n:text><xsl:value-of select="./@Id"/></i18n:text></option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
     <xsl:when test="./@Value and string-length(./@Id) = 0" >
        <xsl:choose>
          <xsl:when test="../@Value = ./@Value">
            <option selected="yes" value="{./@Value}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
          </xsl:when>
          <xsl:otherwise>
            <option value="{./@Value}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Table Footer -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TABLE" mode="table_container_footer">

    <xsl:if test="count(BUTTONS) > 0 or count(PAGINATION) > 0">
      <!--  Footer -->
      <i2:footer>
        <table cellspacing="0" cellpadding="0" width="100%"  border="0">
          <tr>
            <!-- Pagination -->
            <td>
              <xsl:apply-templates select="PAGINATION"/>
            </td>

            <!-- Buttons  -->
            <td  align="right">
              <xsl:apply-templates select="BUTTONS">
               <xsl:with-param name="noOfRows" select="$noOfRows"/>
              </xsl:apply-templates>
            </td>
          </tr>

          <!-- Hidden fields for pagination -->
          <xsl:if test="count(PAGINATION) > 0 ">
            <input type="hidden" name="RECORD_COUNT" value="{$totalRecordCount}"/>
            <input type="hidden" name="START_COUNT" value="{$startAtRow}"/>
          </xsl:if>
        </table>

      </i2:footer>
    </xsl:if>
  </xsl:template>

<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

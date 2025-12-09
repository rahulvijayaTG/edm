<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <!-- **********************************************************************
      *********************************************************************** -->
      <xsl:template match="REPORT" mode="top">
         <xsl:apply-templates select="TABLE" mode="no_forms"/>
      </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
      <xsl:template match="REPORT" mode="layout">
       <xsl:choose>
        <xsl:when test="HORIZONTAL_TABLE">
          <xsl:apply-templates select="HORIZONTAL_TABLE" mode="layout"/>
        </xsl:when>
        <xsl:when test="FREEZE_TABLE">
          <xsl:apply-templates select="FREEZE_TABLE" mode="layout"/>
        </xsl:when>
         <xsl:otherwise>
           <xsl:apply-templates select="TABLE" mode="no_forms"/>
         </xsl:otherwise>
       </xsl:choose>
     </xsl:template>


  <!-- Table -->
      <!-- **********************************************************************
      *********************************************************************** -->
      <xsl:template match = "TABLE" mode="no_forms">

        <!-- html form -->
        <table cellspacing="0" cellpadding="0" border="0">
          <xsl:attribute name="width">
            <xsl:choose>
              <xsl:when test="string-length(@Width) &gt; 0">
                <xsl:value-of select="@Width"/>
              </xsl:when>
              <xsl:otherwise>100%</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
              <tr>
              <td>
                 <xsl:apply-templates select="." mode="content"/>
              </td>
            </tr>

            <!-- Hidden Rows -->
             <xsl:apply-templates select="." mode="hidden_rows">
            </xsl:apply-templates>
        </table>

      </xsl:template>



  <!-- Table -->
    <!-- **********************************************************************
    *********************************************************************** -->
    <xsl:template match = "TABLE" mode="content">

      <xsl:variable name="checkboxName">
        <xsl:value-of select="TR[not(@Header)]/ROW_SELECTOR/@Name"/>
      </xsl:variable>
      
      <xsl:variable name="allowExpInFilter" select="@AllowExpressionInFilter"/>
      
               <!-- Container -->
              <i2:container id = "{@ContainerId}" inner="yes" scrollable="yes" collapsable="{@Collapsable}">

                <!-- Title -->
                <i2:attribute name="title">
                  <xsl:apply-templates select="." mode="title"/>
                </i2:attribute>

                <!-- Header -->
                <xsl:apply-templates select="." mode="header">
                  <xsl:with-param name="tableId" select="@Id"/>
                </xsl:apply-templates>    

                <xsl:apply-templates select="VALIDATION" mode="validation_area"/>

                <!-- Table -->
                <xsl:if test="@NoOfRows > 0">
                  <i2:table>
                    <i2:attribute name="id"><xsl:value-of select="@Id"/></i2:attribute>
                    <xsl:if test="@Scrollable = 'true' or @Scrollable = 'yes'">
                      <i2:attribute name="scrollablerows">yes</i2:attribute>
                      <i2:attribute name="scrollablecolumns">auto</i2:attribute></xsl:if>

                      <!-- Header Row -->
                      <xsl:apply-templates select="." mode="header_row">
                        <xsl:with-param name="formName" select="@FormName"/>
                        <xsl:with-param name="sortBy" select="@SortBy"/>
                        <xsl:with-param name="sortOrder" select="@SortOrder"/>
                      </xsl:apply-templates>
 
                      <!-- Filter Row -->
                      <xsl:apply-templates select="FILTER_ROW" mode="filter_row">
                        <xsl:with-param name="formName" select="@FormName"/>
                        <xsl:with-param name="allowExpression" select="$allowExpInFilter"/>
                      </xsl:apply-templates>
                      
                      <!-- Mass Entry Row -->
                      <xsl:apply-templates select="MASS_ENTRY_ROW" mode="mass_entry_row">
                        <xsl:with-param name="formName" select="@FormName"/>
                        <xsl:with-param name="checkboxName" select="$checkboxName"/>
                      </xsl:apply-templates>

                      <!-- All Rows -->
                      <xsl:apply-templates select="." mode="rows">
                        <xsl:with-param name="formName" select="@FormName"/>
                      </xsl:apply-templates>
                  </i2:table>
                </xsl:if>

                <!-- Footer -->
                <xsl:apply-templates select="." mode="footer"/>

              </i2:container>

            <script><xsl:value-of select="concat('table_createSorter(', $quote , @Id, $quote , ',', $quote , @SortBy, $quote, ',', $quote , @SortOrder, $quote ,');')"/> </script>

      <xsl:apply-templates select="script"/>



    </xsl:template>

  <!-- Table Title -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match= "TABLE" mode="title">
    <b><xsl:apply-templates select="." mode="regular_title"/></b>
    <xsl:apply-templates select="." mode="paging_title"/>
    <xsl:apply-templates select="." mode="no_rows_title"/>
  </xsl:template>

  <!--  PSR This needs to be defined other wise all children are evaluated-->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match= "TABLE" mode="no_rows_title"/>
  <xsl:template match= "TABLE" mode="paging_title"/>
  <xsl:template match= "TABLE" mode="regular_title"/>
  <xsl:template match= "TABLE" mode="custom_header_row"/>


  <!-- Regular Title -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match= "TABLE[string-length(@NoTitle) = 0 or @NoTitle = 'no']" mode="regular_title">
    <xsl:choose>
      <xsl:when test="string-length(@Title) > 0">
        <i18n:text><xsl:value-of select="@Title"/></i18n:text></xsl:when>
      <xsl:when test="(@DoSearch != 'false')">
        <i18n:text>Search Results</i18n:text></xsl:when>
      <xsl:when test="@NoOfRows != 0">
        <i18n:text>Search Results</i18n:text></xsl:when>
    </xsl:choose>
  </xsl:template>


  <!-- Paging Title -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match= "TABLE[@NoOfRows > 0 and @MaxRows > 0]" mode="paging_title">

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

  <!-- no Rows Title -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match= "TABLE[@NoOfRows = 0  and (@MaxRows > 0 or @MaxRows = -1)]" mode="no_rows_title">
    <xsl:choose>
      <xsl:when test="string-length(@NoRecordsTitle) > 0">:&#xA0;<i18n:text><xsl:value-of select="@NoRecordsTitle"/></i18n:text></xsl:when>
      <xsl:otherwise>:&#xA0;<i18n:text>No records found</i18n:text>.</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Header -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match = "TABLE" mode="header">
    <xsl:param name="tableId"/>
    <xsl:param name="horizontal" select="'false'"/>

    <i2:header>
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td align="right">
            <table border="0" cellpadding="0" cellspacing="0" align="right">
              <tr>
                <xsl:if test="@Configurable = 'true' and @NoOfRows > 0">
                  <td>&#xA0;</td>
                  <td>
                    <a class="text" href="javascript:onLink();" onclick="javascript:ui_configureTable('{$tableId}')">
                      <i2:img src="/cstmz_actv.gif" width="16" height="16" border="0">
                        <i2:attribute name="alt">
                          <i18n:text>Customize Table</i18n:text>
                        </i2:attribute>
                      </i2:img>
                    </a>
                  </td>
                  <td>&#xA0;</td>
                </xsl:if>
  
                <xsl:if test="@NoOfRows > 0 and (@Exportable != 'false' )">
                  <xsl:call-template name="table_download">  
                    <xsl:with-param name="tableId" select="$tableId"/>
                    <xsl:with-param name="horizontal" select="$horizontal"/>
                  </xsl:call-template>
                </xsl:if>
  
                <xsl:if test="@help">
                  <td>
                    <a class="text" href="javascript:onHelp();">
                      <xsl:attribute name="onClick">javascript:popUpWindow( '<xsl:value-of select="@help"/>', 'popUp4')</xsl:attribute>
                      <xsl:variable name="txtAltAttr"><i18n:text>Help</i18n:text></xsl:variable>
                      <i2:img src="/help_avail.gif" alt="{$txtAltAttr}" border="0" align="middle"/>
                    </a>
                  </td>
                </xsl:if>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </i2:header>
  </xsl:template>


  <!--  Footer -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TABLE" mode="footer">

    <xsl:if test="BUTTONS or @MaxRows > 0">
      <!--  Footer -->
      <i2:footer>
        <table cellspacing="0" cellpadding="0" width="100%"  border="0">
          <tr>
            <!-- Pagination -->
            <td>
              <xsl:variable name="pagePrefix">
                <xsl:choose>
                  <xsl:when test="number(@TABLE_COUNT) &gt; 0">
                    <xsl:value-of select="@Id"/>
                  </xsl:when>
                  <xsl:otherwise>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:if test="@MaxRows > 0">
                <i2:pagingcontrol currentPage="{ceiling((number(@StartAtRow)+1) div number(@MaxRows))}" recordsPerPage="{number(@MaxRows)}" totalRecords="{number(@TotalRowCount)}" paginationPrefix="{$pagePrefix}" />
              </xsl:if>
            </td>

            <!-- Buttons  -->
            <td  align="right">
              <xsl:apply-templates select="BUTTONS"/>
            </td>
          </tr>

          <!-- Hidden fields for pagination -->
          <xsl:if test="@MaxRows > 0">
            <xsl:choose>
              <xsl:when test="number(@TABLE_COUNT) &gt; 0">
                <input type="hidden" name="{@Id}_SORT_BY" value="{@SortBy}"/>
                <input type="hidden" name="{@Id}_SORT_ORDER" value="{@SortOrder}"/>
                <input type="hidden" name="{@Id}_RECORD_COUNT" value="{number(@TotalRowCount)}"/>
                <input type="hidden" name="{@Id}_START_COUNT" value="{number(@StartAtRow)}"/>
                <input type="hidden" name="{@Id}_MAX_ROWS" value="{number(@MaxRows)}"/>
                <input type="hidden" name="{@Id}_NO_OF_ROWS" value="{number(@NoOfRows)}"/>
              </xsl:when>
              <xsl:otherwise>
                <input type="hidden" name="RECORD_COUNT" value="{number(@TotalRowCount)}"/>
                <input type="hidden" name="SORT_BY" value="{@SortBy}"/>
                <input type="hidden" name="SORT_ORDER" value="{@SortOrder}"/>
                <input type="hidden" name="START_COUNT" value="{number(@StartAtRow)}"/>
                <input type="hidden" name="MAX_ROWS" value="{number(@MaxRows)}"/>
                <input type="hidden" name="NO_OF_ROWS" value="{number(@NoOfRows)}"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </table>

      </i2:footer>
    </xsl:if>
  </xsl:template>


  <!-- Header Row -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match = "TABLE" mode="header_row">
    <xsl:param name="formName"/>
    <xsl:param name="sortBy"/>
    <xsl:param name="sortOrder"/>
    <xsl:apply-templates select="." mode="custom_header_row"/>

    <xsl:apply-templates select="TR[@Header]">
      <xsl:with-param name="noOfRows" select="@NoOfRows"/>
      <xsl:with-param name="formName" select="$formName"/>
      <xsl:with-param name="sortBy" select="$sortBy"/>
      <xsl:with-param name="sortOrder" select="$sortOrder"/>
      <xsl:with-param name="tableId" select="@Id"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- Filter Row -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TABLE" mode="filter_row">
    <xsl:param name="formName"/>
    <xsl:apply-templates select="." mode="custom_header_row"/>

    <xsl:apply-templates select="FILTER_ROW" mode="filter_row"/>

  </xsl:template>
  
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="FILTER_ROW" mode="filter_row">
    <xsl:param name="allowExpression" select="'true'"/>

    <i2:tr>
      <xsl:apply-templates select="ROW_SELECTOR" mode="content"/>
      <xsl:apply-templates select="FILTER_COLUMN" mode="filter_column">
        <xsl:with-param name="allowExpression" select="$allowExpression"/>
      </xsl:apply-templates>
    </i2:tr>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="FILTER_COLUMN" mode="filter_column">
    <xsl:param name="allowExpression" select="'true'"/>
    
    <td  style="padding-left:0px;padding-right:0px;">
      <xsl:if test="@Name">
        <xsl:variable name="name">
          <xsl:choose>
            <xsl:when test="$allowExpression = 'false'"><xsl:value-of select="@InputName"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="@Name"/></xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:variable name="size">
          <xsl:choose>
            <xsl:when test="@Size"><xsl:value-of select="@Size"/></xsl:when>
            <xsl:otherwise>12</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:variable name="imageSrc">
          <xsl:choose>
            <xsl:when test="string-length(@Value) > 0">
              <xsl:value-of select="'i2/images/clearfield.gif'"/>
            </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'i2/images/clearfield_disabled.gif'"/></xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
   
        <table cellpadding="0" cellspacing="0" border="0" width="1">
          <tr>
            <td style="padding-left:0px;padding-right:0px;">
              <IMG alt="Clear Filter" width="16" height="16" border="0">
                <xsl:attribute name="Name"><xsl:value-of select="concat('IMG_',$name)"/></xsl:attribute>
                <xsl:attribute name="SRC"><xsl:value-of select="$imageSrc"/></xsl:attribute>
                <xsl:attribute name="onClick"><xsl:value-of select="concat('javascript:ui_clear(document.form.',$name,',document.form.IMG_',$name,');')"/></xsl:attribute> 
                <xsl:attribute name="onMouseOver">javascript:this.style.cursor='hand';</xsl:attribute>                
              </IMG>
            </td>
            <td style="padding-left:0px;padding-right:0px;" nowrap="yes">
              <input type="text" value="{@Value}" size="{$size}" class="inputfieldIE" fieldtype="{@DataType}">
                <xsl:attribute name="onChange">
                  <xsl:value-of select="concat('javascript:ui_switch_image(this.value,document.form.IMG_',$name,');')"/>
                </xsl:attribute>
                <xsl:if test="$allowExpression = 'false'">
                  <xsl:attribute name="onkeyup">javascript:validation_onlyValidData()</xsl:attribute>
                </xsl:if>
                <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
              </input>
              <xsl:if test="@DataType = 'Date' and $allowExpression = 'false'">
                &#xA0;<A  href="javascript:onLink()" onclick="javascript:ui_calendar(this);" >
                <i2:img src="/cal_icon.gif" border="0" align="middle"/>
                </A>
                <span style="display:none" type="data-type-validator" message="Invalid Filter" severity="STOP">
                  <xsl:variable name="quote">'</xsl:variable>
                   &#xA0;<i2:img onclick="javascript:core_alert('Invalid Filter')" src="/alert_static_small.gif" border="0" align="middle">
                    <i2:attribute name="alt">
                      <i18n:text>Invalid Filter</i18n:text>
                    </i2:attribute>
                   </i2:img>
                </span>
              </xsl:if>
            </td>
            <td style="padding-left:0px;padding-right:0px;">
              <IMG src="i2/images/fltr_actv.gif" alt="Apply Filter" width="16" height="16" border="0">
                <xsl:attribute name="onMouseOver">javascript:this.style.cursor='hand';</xsl:attribute> 
                <xsl:attribute name="onClick">javascript:apply_filters();</xsl:attribute> 
              </IMG>
            </td>
          </tr>
        </table>
        
      </xsl:if>     
    </td>   
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="MASS_ENTRY_ROW" mode="mass_entry_row">
    <xsl:param name="checkboxName"/>
    <i2:tr>
      <xsl:apply-templates select="*" mode="mass_entry_row">
        <xsl:with-param name="checkboxName" select="$checkboxName"/>
      </xsl:apply-templates>
    </i2:tr>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="MASS_ENTRY_COLUMN" mode="mass_entry_row">
    <td nowrap="yes" style="background:#fffde6;">&#xA0;&#xA0;</td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="ROW_SELECTOR" mode="mass_entry_row">
    <td align="center" style="background:#fffde6;" nowrap="yes">&#xA0;</td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_ENTRY" mode="mass_entry_row">
    <xsl:param name="checkboxName"/>
    
    <xsl:variable name="fieldName" select="substring(@InputName,12)"/>

    <!-- Check if this column has atleast one editable entry -->		
    <xsl:variable name="editableFieldCount" select="count(../../TR[not(@Header)]/T_FIELD_ENTRY[(@InputName = $fieldName) and (@Editable = 'true')])"/>

    <td nowrap="yes" align="{@Align}" style="background:#fffde6;">
      <xsl:if test="$editableFieldCount > 0">
      <table cellpadding="0" cellspacing="0" border="0" width="1">
        <tr>
          <td nowrap="yes" style="padding-left:0px;padding-right:0px;">
            <input name="{@InputName}" value="{@Value}" fieldtype="{@DataType}" size="{@Size}" maxlength="{@MaxLength}"  class="inputfieldIE"
               onkeyup="javascript:validation_onlyValidData()" containerId="{@containerId}">

              <xsl:choose>
                <xsl:when test="string-length(@onChange) > 0" >
                  <xsl:attribute name="onchange">
                    <xsl:value-of select="@onChange"/>
                  </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="type">javascript:isValid_field_if_data(this)</xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>

              <!-- id -->
              <xsl:if test="string-length(@Id) > 0">
               <xsl:attribute name="id">
                 <xsl:value-of select="@Id"/>
               </xsl:attribute>
              </xsl:if>

              <!-- hasErrors -->
              <xsl:if test="_ERRORS">
               <xsl:attribute name="validationmsg">
                 <xsl:value-of select="'error'"/>
               </xsl:attribute>
              </xsl:if>
            </input>
            <xsl:if test="@DataType = 'Date'">
              &#xA0;<A  href="javascript:onLink()" onclick="javascript:ui_calendar(this);" >
              <i2:img src="/cal_icon.gif" border="0" align="middle"/>
              </A>
            </xsl:if>
          </td>
          <td style="padding-left:2px;padding-right:0px;">
            <i2:img src="/mass_row_edit.gif" width="16" height="16" border="0">
              <i2:attribute name="alt">
                <i18n:text>Mass Update</i18n:text>
              </i2:attribute>
              <i2:attribute name="onclick">
                <xsl:value-of select="concat('javascript:mass_entry_update(', $quote, @InputName,$quote, ',', $quote, $checkboxName, $quote, ');')"/>
              </i2:attribute>
              <i2:attribute name="onmouseover">javascript:this.style.cursor='hand';</i2:attribute>
            </i2:img>
          </td>
        </tr>
      </table>
      </xsl:if>
    </td>
   </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_SELECT" mode="mass_entry_row">
    <xsl:param name="checkboxName"/>

    <xsl:variable name="fieldName" select="substring(@Name,12)"/>

    <!-- Check if this column has atleast one editable entry -->		
    <xsl:variable name="editableFieldCount" select="count(../../TR[not(@Header)]/T_FIELD_SELECT[(@Name = $fieldName) and (@Editable = 'true')])"/>

    <td nowrap="yes" align="left" style="background:#fffde6;">
      <xsl:if test="$editableFieldCount > 0">
      <table cellpadding="0" cellspacing="0" border="0" width="1">
        <tr>
          <td style="padding-left:0px;padding-right:0px;">
            <select  containerId="{@containerId}" class="pulldown" name="{@InputName}" onchange="javascript:isValid_field_if_data(this);{@onChange}" size="{@Size}">
              <xsl:choose>
               <xsl:when test="@Size&gt;'1'"> <xsl:attribute name="multiple"/> </xsl:when>
              </xsl:choose>

              <xsl:choose>
                <xsl:when test="@SelectOne = 'true'">
                  <option value=""><i18n:text>Select...</i18n:text></option>
                </xsl:when>
                <xsl:when test="@SelectAll = 'true'">
                  <option value=""><i18n:text>All</i18n:text></option>
                </xsl:when>
              </xsl:choose>

              <xsl:choose>
                <xsl:when test="string-length(@Sort) &gt; 0">
                  <xsl:apply-templates select="OPTION">
                    <xsl:sort select="@Value" order="{@Sort}"/>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="OPTION"/>
                </xsl:otherwise>
              </xsl:choose>

              <xsl:apply-templates select="CODE_MASTER_VALUE" mode="pulldown">
                <xsl:sort select="DESCRIPTION/@Value"/>
                <xsl:with-param name="selectedId" select="@Value"/>
              </xsl:apply-templates>

            </select>
          </td>
          <td style="padding-left:2px;padding-right:0px;">
            <i2:img src="/mass_row_edit.gif" width="16" height="16" border="0">
              <i2:attribute name="alt">
                <i18n:text>Mass Update</i18n:text>
              </i2:attribute>
              <i2:attribute name="onclick">
                <xsl:value-of select="concat('javascript:mass_entry_update(', $quote, @InputName,$quote, ',', $quote, $checkboxName, $quote, ');')"/>
              </i2:attribute>
              <i2:attribute name="onmouseover">javascript:this.style.cursor='hand';</i2:attribute>
            </i2:img>
          </td>
        </tr>
      </table>
      </xsl:if>
    </td>
  </xsl:template>

  <!-- All Rows -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match = "TABLE" mode="rows">
    <xsl:param name="formName"/>

    <xsl:apply-templates select="TR[not(@Header)]">
      <xsl:with-param name="noOfRows" select="@NoOfRows"/>
      <xsl:with-param name="formName" select="$formName"/>
    </xsl:apply-templates>

  </xsl:template>

  <!-- Header Row -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match = "TR[@Header]">
     <xsl:param  name="noOfRows"/>
     <xsl:param  name="formName"/>
     <xsl:param  name="sortBy"/>
     <xsl:param  name="sortOrder"/>
     <xsl:param name="tableId"/>

      <i2:tr><xsl:if test="string-length(@Header) > 0"> <i2:attribute name="header">yes</i2:attribute> </xsl:if>
       <xsl:apply-templates select="ROW_SELECTOR" mode="content"/>

       <xsl:apply-templates select="T_FIELD_HR" mode="content">
          <xsl:with-param  name="rowNo" select="position()-2"/>
          <xsl:with-param name="header" select="@Header"/>
          <xsl:with-param  name="noOfRows" select="$noOfRows"/>
          <xsl:with-param  name="formName" select="$formName"/>
          <xsl:with-param name="sortBy" select="$sortBy"/>
          <xsl:with-param name="sortOrder" select="$sortOrder"/>
          <xsl:with-param name="tableId" select="$tableId"/>
        </xsl:apply-templates>
      </i2:tr>
  </xsl:template>

  <!-- All Row -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match = "TR[not(@Header)]">
     <xsl:param  name="noOfRows"/>
     <xsl:param  name="formName"/>
      <i2:tr id="{@Id}">
        <input type="hidden" name="SUB_TREE" value="{@SubTree}"/>

        <xsl:if test="@Class">
        <i2:attribute name="class">
            <xsl:value-of select="@Class"/>
        </i2:attribute>
        </xsl:if>

       <xsl:apply-templates select="*" mode="content">
          <xsl:with-param  name="rowNo" select="position()-1"/>
          <xsl:with-param name="header" select="@Header"/>
          <xsl:with-param  name="noOfRows" select="$noOfRows"/>
          <xsl:with-param  name="formName" select="$formName"/>
          <xsl:with-param name="inTable" select="true()"/>
        </xsl:apply-templates>
      </i2:tr>
  </xsl:template>

  <!-- Hidden Rows -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match = "TABLE" mode="hidden_rows">
    <xsl:apply-templates select="TR_HIDDEN">
    </xsl:apply-templates>

  </xsl:template>

  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match = "TR_HIDDEN">
    <xsl:apply-templates select="T_FIELD_HIDDEN" mode="content">
    </xsl:apply-templates>
  </xsl:template>

  <!-- ********************************************************************** 
  *********************************************************************** -->  
  <xsl:template name = "table_download"> 
    <xsl:param name="tableId"/>
    <xsl:param name="horizontal" select="'false'"/>
  
    <td>&#xA0;</td>
    <td>
      <input type="hidden" name="CORE_SAVE_REPORT"/>
      <a class="text" href="javascript:onLink();" onclick="javascript:table_export('{$tableId}','{$horizontal}', '{@Exportable}')">
        <i2:img src="/dnld_avail.gif" width="16" height="16" border="0">
          <i2:attribute name="alt">
            <i18n:text>Export To Excel</i18n:text>
          </i2:attribute>
        </i2:img>
      </a>
    </td>
    <td>&#xA0;</td>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
</xsl:stylesheet>

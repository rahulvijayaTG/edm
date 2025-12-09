<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../../core/xsl/i18n.xsl"/>
  <xsl:output method="html"/>
  <xsl:variable name="quote">'</xsl:variable>
  <xsl:variable name="frozen_sequence">
    <xsl:if test="count(/RESPONSES/RESPONSE/FROZEN_SEQUENCE/@Value) = 0 or /RESPONSES/RESPONSE/FROZEN_SEQUENCE/@Value = ''">-999</xsl:if>
    <xsl:if test="count(/RESPONSES/RESPONSE/FROZEN_SEQUENCE/@Value) != 0 and count(/RESPONSES/RESPONSE/FROZEN_SEQUENCE/@Value) != ''">
      <xsl:value-of select="/RESPONSES/RESPONSE/FROZEN_SEQUENCE/@Value"/>
    </xsl:if>
  </xsl:variable>
  <!-- Table Title -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TABLE" mode="table_title">
    <!-- Title -->
    <xsl:variable name="title">
      <xsl:choose>
        <xsl:when test="(string-length(@NoTitle) > 0 and @NoTitle = 'yes')"/>
        <xsl:when test="string-length(@Title) > 0">
          <b>
            <i18n:text>
              <xsl:value-of select="@Title"/>
            </i18n:text>
          </b>
        </xsl:when>
        <xsl:when test="(@DoSearch != 'false')">
          <b>
            <i18n:text>Search Results</i18n:text>
          </b>
        </xsl:when>
        <xsl:when test="$noOfRows != 0">
          <b>
            <i18n:text>Search Results</i18n:text>
          </b>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="pagingTitle">
      <!-- 1 of 10 -->
      <xsl:if test="@PagingTitle and  $totalRecordCount > 0">
        <xsl:variable name="endPage_i18n">
          <xsl:choose>
            <xsl:when test="$endPage='UnKnown'"/>
            <xsl:otherwise>
              <i18n:text>of</i18n:text>&#xA0;<i18n:number>
                <xsl:value-of select="$endPage"/>
              </i18n:number>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:if test="$totalRecordCount > 0">:&#xA0;<i18n:text>Page</i18n:text>&#xA0;<i18n:number>
            <xsl:value-of select="$currentPage"/>
          </i18n:number>&#xA0;<xsl:value-of select="$endPage_i18n"/>
        </xsl:if>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="noRowsTitle">
      <!--  no rec found -->
      <xsl:if test="$totalRecordCount = 0">
        <xsl:variable name="noRowsTitle">
          <!-- Search Mode -->
          <xsl:if test="@DoSearch = 'Yes' or @DoSearch='yes' or @DoSearch='true'">
            <xsl:choose>
              <!-- Custom title -->
              <xsl:when test="string-length(@NoRecordsTitle) > 0">
                &lt;i&gt;<i18n:text>
                  <xsl:value-of select="@NoRecordsTitle"/>
                </i18n:text>&lt;/i&gt;
              </xsl:when>
              <!-- NO_DOC_TYPE_FOUND -->
              <xsl:when test="string-length(@Document) > 0">
                <i18n:text>
                  <xsl:value-of select="concat('NO_',@Document,'_FOUND')"/>
                </i18n:text>
              </xsl:when>
              <!-- No Records Found -->
              <xsl:otherwise>
                 :&#xA0;<i18n:text>No records found</i18n:text>.
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:variable>
        <i18n:text>
          <xsl:value-of select="$noRowsTitle"/>
        </i18n:text>
      </xsl:if>
      <xsl:if test="$totalRecordCount &gt; 0">
        <xsl:variable name="noRowsTitle">
          <!-- Search Mode -->
          <xsl:if test="@DoSearch = 'Yes' or @DoSearch='yes' or @DoSearch='true'">            
                &#xA0;<i18n:text>Total records</i18n:text>&#xA0;<i18n:text><xsl:value-of select="$totalRecordCount"/></i18n:text>
          </xsl:if>
        </xsl:variable>
        <i18n:text>
          <xsl:value-of select="$noRowsTitle"/>
        </i18n:text>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="filterTitle">
      <xsl:if test="(string-length(@FilterTitle) > 0 )">
           &#xA0;:&#xA0;<i18n:text>Filtered </i18n:text>(<xsl:value-of select="@FilterTitle"/>)
          </xsl:if>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length($filterTitle) > 0 ">
        <table border="0" cellpadding="0" cellspacing="0" height="100%">
          <tr>
            <td align="left">
              <xsl:value-of select="concat($title,$pagingTitle,$noRowsTitle,$filterTitle)"/>
            </td>
          </tr>
        </table>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($title,$pagingTitle,$noRowsTitle)"/>
      </xsl:otherwise>
    </xsl:choose>
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
    <!-- Give Defaults - Start:: -->
    <xsl:variable name="method">
      <xsl:choose>
        <xsl:when test="@Method">
          <xsl:value-of select="@Method"/>
        </xsl:when>
        <xsl:otherwise>POST</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="noOfColumns">
      <xsl:value-of select="count(./TR[position() = 1]/TD[@ Type!='Hidden' and @Sequence != '-100'])"/>
    </xsl:variable>
    <!-- html form -->
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
      <form name="{$formName}" method="POST" ACTION="tableeditor.jsp">
        <tr>
          <td>
            <input type="hidden" name="DATE_FORMAT" value="{/RESPONSES/RESPONSE/FORMAT/@Date}"/>
            <!-- Hidden Fields -->
            <xsl:for-each select="FIELD[@Type='Hidden']">
              <input name="{@Name}" type="hidden" value="{@Value}"/>
            </xsl:for-each>
            <xsl:variable name="scrollableContainer">
              <xsl:choose>
                <xsl:when test="$noOfRows = 0">yes</xsl:when>
                <xsl:otherwise>no</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <i2:container id="{$tableContainerId}" inner="yes" scrollable="{$scrollableContainer}" height="100%">
              <i2:attribute name="title">
                <xsl:apply-templates select="." mode="table_title"/>
              </i2:attribute>
              <!--chandru start-->
              <xsl:choose>
                <xsl:when test="$frozen_sequence >= 0">
                  <xsl:variable name="scrollableTableId">
                    <xsl:value-of select="concat($tableId, '_slave')"/>
                  </xsl:variable>
                  <table width="100%" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                      <xsl:apply-templates select="." mode="table_container_header"/>
                    </tr>
                    <tr>
                      <td valign="top" border="0" style="padding:0px;">
                        <i2:table id="result_table_slave">
                          <!--<i2:attribute name="scrollablerows">hidden</i2:attribute> -->
                          <i2:attribute name="scrollablerows">hidden</i2:attribute>
                          <!--i2:attribute name="scrollablecolumns">yes</i2:attribute-->
                          <!--xsl:apply-templates/-->
                          <xsl:apply-templates select="TR">
                            <xsl:with-param name="isFrozen" select="true()"/>
                            <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                          </xsl:apply-templates>
                        </i2:table>
                      </td>
                      <td valign="top" width="100%" border="0" style="padding:0px;">
                        <i2:table id="{$tableId}" scrollablesyncedtable="result_table_slave">
                          <i2:attribute name="scrollablerows">yes</i2:attribute>
                          <i2:attribute name="scrollablecolumns">yes</i2:attribute>
                          <!--i2:attribute name="scrollablesyncedtable" value ="{$scrollableTableId}"/-->
                          <!--i2:attribute name="scrollablesyncedtable">result_table_slave</i2:attribute-->
                          <xsl:apply-templates select="TR">
                            <xsl:with-param name="isFrozen" select="false()"/>
                            <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                          </xsl:apply-templates>
                        </i2:table>
                      </td>
                    </tr>
                  </table>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="." mode="table_container_header"/>
                  <i2:table id="{$tableId}">
                    <xsl:if test="@Scrollable = 'yes' and $noOfRows > 0">
                      <i2:attribute name="scrollablerows">yes</i2:attribute>
                      <i2:attribute name="scrollablecolumns">auto</i2:attribute>
                    </xsl:if>
                    <xsl:apply-templates select="TR">
                      <xsl:with-param name="isFrozen" select="false()"/>
                      <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                    </xsl:apply-templates>
                  </i2:table>
                </xsl:otherwise>
              </xsl:choose>
              <!--chandru end-->
            </i2:container>
          </td>
        </tr>
        <tr>
          <td>
            <xsl:apply-templates select="." mode="table_container_footer"/>
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
  <xsl:template match="TR">
    <xsl:param name="isFrozen"/>
    <xsl:param name="noOfColumns"/>
    <xsl:if test="string-length(@Type) = 0">
      <i2:tr>
        <xsl:if test="string-length(@Header)  > 0">
          <i2:attribute name="header">yes</i2:attribute>
        </xsl:if>
        <xsl:if test="$frozen_sequence = -999">
          <xsl:apply-templates select="TD" mode="content">
            <!-- do sorting anish-->
            <!--xsl:sort select="@Sequence" data-type="number" order="ascending"/-->
            <xsl:with-param name="rowNo" select="position()-2"/>
            <xsl:with-param name="header" select="@Header"/>
            <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="$frozen_sequence != -999">
          <xsl:choose>
            <xsl:when test="$isFrozen = true()">
              <xsl:apply-templates select="TD[$frozen_sequence > @Sequence ]" mode="content">
                <!-- do sorting anish-->
                <!--xsl:sort select="@Sequence" data-type="number" order="ascending"/-->
                <xsl:with-param name="rowNo" select="position()-2"/>
                <xsl:with-param name="header" select="@Header"/>
                <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
              </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="TD[@Sequence >= $frozen_sequence] | TD[@Type = 'Hidden']" mode="content">
                <!-- do sorting anish-->
                <!--xsl:sort select="@Sequence" data-type="number" order="ascending"/-->
                <xsl:with-param name="rowNo" select="position()-2"/>
                <xsl:with-param name="header" select="@Header"/>
                <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
              </xsl:apply-templates>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </i2:tr>
    </xsl:if>
  </xsl:template>
  <!-- Table Row Hidden -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="TR" mode="hidden">
    <xsl:apply-templates select="TD" mode="content">
      <xsl:with-param name="rowNo" select="position()-2"/>
      <xsl:with-param name="header" select="@Header"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- Field - Hidden -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Hidden') and (@Header)]" mode="content">
    <input name="{@Name}" value="{@Value}" type="hidden"/>
  </xsl:template>
  <!-- Field - CheckBox -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <!-- anish added ROW_SELECTOR -->
  <xsl:template match="TD[@Type = 'CheckBox']" mode="content">
    <xsl:param name="rowNo"/>
    <xsl:param name="header"/>
    <!--xsl:param name="header" select="../@Header"/>
    <xsl:param name="onclick"/>
    <xsl:param name="onmouseover"/>
    <xsl:param name="target"/-->
    <!--chandru start -->
    <!--xsl:choose>
       <xsl:when test="$totalRecordCount &gt; 0" >
            <i2:rowselector checked="{@Checked}" select="{@Select}" name="{@Name}" value="{@Value}" global="{@Header}">
            </i2:rowselector>
       </xsl:when>
       <xsl:otherwise>
           <th nowrap="yes" align="center"  class="checkboxColumn"/>
       </xsl:otherwise>
   </xsl:choose-->
    <xsl:choose>
      <xsl:when test="$totalRecordCount &gt; 0">
        <xsl:variable name="onclick">
          <xsl:value-of select="concat('javascript:toggleRowSelectionState(this,', $rowNo, ')' )"/>
        </xsl:variable>
        <xsl:variable name="rowselectorid">
          <xsl:if test="$header = true()">_rowselector_header</xsl:if>
          <xsl:if test="$header = false()">_rowselector</xsl:if>
        </xsl:variable>
        <td nowrap="yes" class="checkboxColumn">
          <input type="checkbox" name="{@Name}" value="{@Value}" onclick="{$onclick}" id="{$rowselectorid}">
            <xsl:if test="@Checked = 'true'">
              <xsl:attribute name="checked">true</xsl:attribute>
            </xsl:if>
          </input>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <th nowrap="yes" align="center" class="checkboxColumn"/>
      </xsl:otherwise>
    </xsl:choose>
    <!--chandru end-->
    <!--xsl:variable name="onclick">
      <xsl:choose>
        <xsl:when test="@OnClick">
          <xsl:value-of select="@OnClick"/>
        </xsl:when>
        <xsl:when test="$header = 'yes'">
          <xsl:variable name="quote">'</xsl:variable>
          <xsl:variable name="currentTDPosition"><xsl:value-of select="position()"/></xsl:variable>
          <xsl:variable name="controlledCheckBoxName"><xsl:value-of select = "'SELECTED_ID'"/>
          </xsl:variable>
             <xsl:value-of select="concat('javascript:toggleCheckboxes(document.forms.', $formName, ',' , 'document.forms.', $formName, '.', $controlledCheckBoxName, ',document.forms.', $formName, '.', @Name, ')' )"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable-->
    <!-- Todo use class="checkboxColumn" only if first column -->
    <!--th nowrap="yes" align="center"  class="checkboxColumn">
    <xsl:if test="$totalRecordCount &gt; 0" >
    <input type="checkbox" name="{@Name}" value="{@Value}" onclick="{$onclick}">
      <xsl:if test="@Checked = 'true'"><xsl:attribute name="checked">true</xsl:attribute>
      </xsl:if>
    </input>
    </xsl:if>
  </th-->
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- anish added ROW_SELECTOR -->
  <xsl:template match="TD[@Header and @Select='single']" mode="content">
    <td nowrap="yes"/>
  </xsl:template>
  <!-- Field None -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="TD[@Type = 'None']" mode="content"/>
  <!-- Field Radio -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <!-- anish added ROW_SELECTOR -->
  <xsl:template match="TD[@Type = 'Radio']" mode="content">
    <xsl:param name="rowNo"/>
    <xsl:param name="header"/>
    <!--i2:rowselector checked="{@Checked}" select="{@Select}" name="{@Name}" value="{@Value}" global="{@Header}">
    </i2:rowselector-->
    <xsl:choose>
      <xsl:when test="$totalRecordCount &gt; 0">
        <xsl:variable name="onclick">
          <xsl:value-of select="concat('javascript:toggleSingleRowSelectionState(this,', $rowNo, ')' )"/>
        </xsl:variable>
        <xsl:variable name="rowselectorid">
          <xsl:if test="$header = true()">_rowselector_header</xsl:if>
          <xsl:if test="$header = false()">_rowselector</xsl:if>
        </xsl:variable>
        <td nowrap="yes" class="checkboxColumn">
          <input type="radio" name="{@Name}" value="{@Value}" onclick="{$onclick}" id="{$rowselectorid}">
            <xsl:if test="@Checked = 'true'">
              <xsl:attribute name="checked">true</xsl:attribute>
            </xsl:if>
          </input>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <th nowrap="yes" align="center" class="checkboxColumn"/>
      </xsl:otherwise>
    </xsl:choose>
    <!-- Todo use class="checkboxColumn" only if first column -->
    <!--th nowrap="yes"  align="center"   class="checkboxColumn">
      <input type="radio" name="{@Name}" value="{@Value}" onclick="{@OnClick}">
        <xsl:if test="@Checked">
          <xsl:attribute name="checked"/>
        </xsl:if>
      </input>
    </th-->
  </xsl:template>
  <!-- Field Text, Date, Number -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (not (@Type) or @Type = 'Text' or @Type = 'Date' or @Type = 'textarea' or @Type = 'DateTime' or @Type = 'Currency' or @Type = 'Number' or @Type='Select' or @Type='Image') and not(@Editable)]" mode="content">
    <xsl:param name="header" select="../@Header"/>
    <xsl:param name="noOfColumns"/>
    <xsl:variable name="isSortable">
      <xsl:choose>
        <xsl:when test="$totalRecordCount = 1 or /RESPONSES/RESPONSE/MULTI_SORT_ENABLED/@Value ='yes'">
          <xsl:value-of select="'no'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@Sortable"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="onmouseover">
      <xsl:choose>
        <xsl:when test="@OnMouseOver">
          <xsl:value-of select="@OnMouseOver"/>
        </xsl:when>
        <!--xsl:when test="@Sortable='yes' and $header = 'yes'">javascript:i2uiSetMenuCoords(this,event)</xsl:when-->
        <xsl:when test="$header = 'yes'">       
        javascript:i2uiSetMenuCoords(this,event)      
        </xsl:when>
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
        <!--xsl:when test="$totalRecordCount > 1 and @Sortable = 'yes' and  $header = 'yes'"-->
        <xsl:when test="$totalRecordCount > 0 and  $header = 'yes'">
          <xsl:variable name="quote">'</xsl:variable>
          <xsl:variable name="currentSequence">
            <xsl:value-of select="@Sequence"/>
          </xsl:variable>
          <xsl:variable name="isFrozenAllowed">yes</xsl:variable>
          <!--xsl:choose>
                <xsl:when test="count(../TD[@Type != 'Hidden' and $currentSequence > @Sequence  ]) &lt; 5">yes</xsl:when>
                <xsl:otherwise>no</xsl:otherwise>
           </xsl:choose>
          </xsl:variable-->
          <!--xsl:if test="/RESPONSES/RESPONSE/MUTI_SORT_ENABLED/@Value ='yes'">
      <xsl:set-variable name="isSortable" select="'no'"/>
         </xsl:if-->
          <xsl:if test="$isSortable ='yes' or  $isFrozenAllowed='yes' ">
            <xsl:value-of select="concat('javascript:sort(', $quote, @Name, $quote,',', @Sequence,',', $quote, $isSortable,$quote,',',$quote, $isFrozenAllowed,$quote,',',$quote, $noOfColumns, $quote, ')' )"/>
          </xsl:if>
        </xsl:when>
        <!--xsl:when test=" @Sortable = 'no' and $header = 'yes'">
              <xsl:value-of select="concat('javascript:showMenu(', $quote, @Name, $quote, ')' )"/>
        </xsl:when-->
        <xsl:when test="string-length(@Url) > 0">
          <xsl:value-of select="@Url"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <td nowrap="yes" align="{$align}" width="100%">
      <nobr>
        <xsl:choose>
          <xsl:when test="string-length($onclick) > 0">
            <a onmouseover="{$onmouseover}" href="{$onclick}">
              <xsl:if test="string-length(@Target) > 0  and string-length($onmouseover) = 0">
                <xsl:attribute name="target"><xsl:value-of select="@Target"/></xsl:attribute>
              </xsl:if>
              <!-- i18n logic for data(clickable). For header i18n logic is part of cnd file -->
            <xsl:choose>
              <xsl:when test="@I18Nize='true' and not($header = 'yes')">
                <i18n:text><xsl:value-of select="@Value"/></i18n:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@Value"/>
              </xsl:otherwise>
            </xsl:choose>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="not(@Value) or string-length(@Value) = 0 or @Type='Text' or @Type='Select'">
                <!-- i18n logic for data(non clickable). For header i18n logic is part of cnd file -->
              <xsl:choose>
                <xsl:when test="string-length(@Value) > 50">
                  <xsl:variable name="str1">
                    <xsl:value-of select="concat('javascript:showClob(', $quote,@Value, $quote,')' )"/>
                  </xsl:variable>
                  <a href="{$str1}"><xsl:value-of select="substring(@Value,1,50)"/></a>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="@I18Nize='true' and not($header = 'yes')">
                      <i18n:text><xsl:value-of select="@Value"/></i18n:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="@Value"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>

              </xsl:when>
              <xsl:when test="@Type='DateTime'">
                <xsl:call-template name="i18nize">
                  <xsl:with-param name="pData" select="@Value"/>
                  <xsl:with-param name="pNoData" select="' '"/>
                  <xsl:with-param name="pType" select="'Date'"/>
                  <xsl:with-param name="pFormat" select="'datetime'"/>
                  <xsl:with-param name="pDecimals" select="@Decimals"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="@Type='textarea'">
                           <xsl:variable name="str1">
                  <xsl:value-of select="concat('javascript:showClob(', $quote,@Value, $quote,')' )"/>
                </xsl:variable>
                          <xsl:variable name="strLong">
                 <xsl:value-of select="@Value"/>
                </xsl:variable>
                <a href="{$str1}">
                  <xsl:choose>
                    <xsl:when test="string-length(@Value) > 50">
                      <xsl:value-of select="substring(@Value,1,50)"/>
                    </xsl:when>
              <xsl:otherwise>
                      <xsl:value-of select="@Value"/>
                    </xsl:otherwise>
                  </xsl:choose>
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
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="/RESPONSES/RESPONSE/MULTI_SORT_ENABLED/@Value ='yes'">
            <xsl:choose>
              <xsl:when test="@Multisortorder and string-length(@Multisortorder)>0 ">
                <xsl:if test="@Multisortorder='Descending'">
               &#xA0;&#xA0;&#xA0;<xsl:value-of select="@Multisortnumber"/>
                  <i2:img src="/descending_table_column.gif"/>
                </xsl:if>
                <xsl:if test="@Multisortorder ='Ascending'">
               &#xA0;&#xA0;&#xA0;<xsl:value-of select="@Multisortnumber"/>
                  <i2:img src="/ascending_table_column.gif"/>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="@Sortable ='yes' and $header='yes' and $sortBy = @Name">
              <!--  <xsl:value-of select="$sortImage"/>-->
              <xsl:choose>
                <xsl:when test="/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_ORDER']/@Value = 'Descending'">
                  &#xA0;&#xA0;&#xA0;<i2:img src="/descending_table_column.gif"/>
                </xsl:when>
                <xsl:otherwise>
                 &#xA0;&#xA0;&#xA0;&#xA0;<i2:img src="/ascending_table_column.gif"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </nobr>
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
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Text') and (@Filter = 'no')]" mode="content">
    <td align="left" nowrap="yes"/>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[@Sequence = '-100' and not(@Type)]" mode="content">
    <td nowrap="yes" class="checkboxColumn"/>
  </xsl:template>
  <!-- Editable - Filter -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Text')  and (@Filter = 'yes')]" mode="content">
    <xsl:variable name="quote">'</xsl:variable>
    <xsl:variable name="searchtooltip">
      <i18n:text>Search</i18n:text>
    </xsl:variable>
    <xsl:variable name="clearfilter_tooltip">
      <i18n:text>Clear Filter</i18n:text>
    </xsl:variable>
    <td align="center" nowrap="yes" style="padding:3px;">
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="bottom" nowrap="yes" style="padding:0px;">
            <xsl:choose>
              <xsl:when test=" string-length(./@Value) > 0">
                <A HREF="{concat('javascript:doSomething(document.forms.', $formName, '.' , @Name , '.value=', $quote , $quote , ');')}">
                  <i2:img src="/clearfilter.gif" border="0" width="16" height="16" align="bottom" alt="{$clearfilter_tooltip}"/>
                </A>
                <input fieldtype="{@Type}" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="8"/>
              </xsl:when>
              <xsl:when test=" string-length(./@Value)= 0">
                <input fieldtype="{@Type}" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="8"/>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
            <!--A HREF="javascript:dispatchSearch();">
        <i2:img src="/srch_actv.gif" border="0" width="16" height="16" align="bottom" alt="{$searchtooltip}"/></A-->
          </td>
        </tr>
      </table>
    </td>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'DateFilter') and (@Filter = 'no')]" mode="content">
    <td align="left" nowrap="yes"/>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'NumberFilter') and (@Filter = 'no')]" mode="content">
    <td align="left" nowrap="yes"/>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'DateFilter')  and (@Filter = 'yes')]" mode="content">
    <!--xsl:variable name="value">
    <i18n:date format="common"><xsl:value-of select="@Value"/></i18n:date>
  </xsl:variable-->
    <xsl:variable name="searchtooltip">
      <i18n:text>Search</i18n:text>
    </xsl:variable>
    <xsl:variable name="clearfilter_tooltip">
      <i18n:text>Clear Filter</i18n:text>
    </xsl:variable>
    <td align="center" nowrap="yes" style="padding:0px;">
      <table>
        <tr>
          <td align="bottom" nowrap="yes" style="padding:3px;">
            <xsl:variable name="date1" select="concat(@Name , '_DS')"/>
            <xsl:variable name="date2" select="concat(@Name , '_DE')"/>
            <xsl:choose>
              <xsl:when test="string-length(/RESPONSES/RESPONSE/*[name() = $date1 ]/@Value) > 0">
                <A HREF="{concat('javascript:clearDateFields(document.forms.', $formName, '.' , $date1 , '_DC' , '.value=', $quote , $quote , ');javascript:clearDateFields(document.forms.', $formName, '.' , $date2 , '_DC' , '.value=', $quote , $quote , ');')}">
                  <i2:img src="/clearfilter.gif" border="0" width="16" height="16" align="bottom" alt="{$clearfilter_tooltip}"/>
                </A>
              </xsl:when>
              <xsl:when test="string-length(/RESPONSES/RESPONSE/*[name() = $date1 ]/@Value) = 0">
                <!--              <i2:img src="/clearfilter_disabled.gif" border="0" width="16" height="16" align="bottom" alt="Clear Filter"/>-->
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
            <!-- start date input field -->
            <xsl:variable name="i18ndate1">
              <i18n:date>
                <xsl:value-of select="/RESPONSES/RESPONSE/*[name() = $date1 ]/@Value"/>
              </i18n:date>
            </xsl:variable>
            <input fieldtype="DateRange" name="{@Name}_DS_DC" value="{$i18ndate1}" type="field" class="inputfieldIE" size="8"/>
            <!--A HREF="javascript:setDateField(document.{$formName}.{@Name}_DS);" onclick="setDateField(document.{$formName}.{@Name}_DS);"-->
            <A HREF="javascript:doNothing()" onclick="showCalendar(document.{$formName}.{@Name}_DS_DC);">
              <i2:img src="/cal_icon.gif" border="0" align="bottom"/>
            </A>
            <!-- end date input field -->
            <xsl:variable name="i18ndate2">
              <i18n:date>
                <xsl:value-of select="/RESPONSES/RESPONSE/*[name() = $date2 ]/@Value"/>
              </i18n:date>
            </xsl:variable>
            <input fieldtype="DateRange" name="{@Name}_DE_DC" value="{$i18ndate2}" type="field" class="inputfieldIE" size="8"/>
            <A HREF="javascript:doNothing()" onclick="showCalendar(document.{$formName}.{@Name}_DE_DC);">
              <i2:img src="/cal_icon.gif" border="0" align="bottom"/>
            </A>
            <!--A HREF="javascript:dispatchSearch();">
        <i2:img src="/srch_actv.gif" border="0" width="16" height="16" align="bottom" alt="{$searchtooltip}"/></A-->
          </td>
        </tr>
      </table>
      <!-- Calendar - End. -->
    </td>
  </xsl:template>
  <!-- Editable - Hidden -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Hidden' or @Type = 'None') and (@Editable)]" mode="content">
    <!--input name="{@Name}" value="{@Value}" type="hidden"/-->
  </xsl:template>
  <!-- Editable - Select -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Select') and (@Editable)]" mode="content">
    <td nowrap="yes" align="left" style="padding:3px;">
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
  <!-- Filterable - Select -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Select')  and (@Filter = 'yes')]" mode="content">
    <xsl:variable name="searchtooltip">
      <i18n:text>Search</i18n:text>
    </xsl:variable>
    <xsl:variable name="clearfilter_tooltip">
      <i18n:text>Clear Filter</i18n:text>
    </xsl:variable>
    <td nowrap="yes" align="left" style="padding:0px;">
      <Table>
        <tr>
          <td style="padding:3px;">
            <xsl:if test=" string-length(./@Value) > 0">
              <xsl:variable name="var1" select="concat('document.forms.', $formName, '.' ,
                    @Name , '.value=', $quote , $quote )"/>
              <A HREF="{concat('javascript:doSomething( ',$var1,');')}">
                <i2:img src="/clearfilter.gif" border="0" width="16" height="16" align="bottom" alt="{$clearfilter_tooltip}"/>
              </A>
            </xsl:if>
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
            <!--A HREF="javascript:dispatchSearch();">
               <i2:img src="/srch_actv.gif" border="0" width="16" height="16" align="bottom" alt="{$searchtooltip}"/></A-->
          </td>
        </tr>
      </Table>
    </td>
  </xsl:template>
  <!-- Editable - Date -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Date') and (@Editable)]" mode="content">
    <xsl:param name="rowNo"/>
    <xsl:variable name="value">
      <i18n:date format="common">
        <xsl:value-of select="@Value"/>
      </i18n:date>
    </xsl:variable>
    <td align="left" nowrap="yes" style="padding:3px;">
      <!-- input field -->
      <input fieldtype="text" name="{@Name}_DC" value="{$value}" type="field" class="inputfieldIE" size="10"/>&#xA0;

      <xsl:choose>
        <!-- If there > 1 rows -->
        <xsl:when test="$noOfRows > 1">
          <A HREF="javascript:setDateField(document.{$formName}.{@Name}_DC[{$rowNo - 1}]);" onclick="setDateField(document.{$formName}.{@Name}_DC[{$rowNo - 1}]);">
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
  <!-- Editable - DateTime -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'DateTime') and (@Editable)]" mode="content">
    <xsl:param name="rowNo"/>
    <xsl:variable name="value">
      <i18n:date format="datetime">
        <xsl:value-of select="@Value"/>
      </i18n:date>
    </xsl:variable>
    <td align="left" nowrap="yes" style="padding:3px;">
      <!-- input field -->
      <input fieldtype="text" name="{@Name}_DT" value="{$value}" type="field" class="inputfieldIE" size="10"/>&#xA0;

      <xsl:choose>
        <!-- If there > 1 rows -->
        <xsl:when test="$noOfRows > 1">
          <A HREF="javascript:setDateField(document.{$formName}.{@Name}_DT[{$rowNo - 1}]);" onclick="setDateField(document.{$formName}.{@Name}_DT[{$rowNo - 1}]);">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/>
          </A>
        </xsl:when>
        <!-- If 1 row -->
        <xsl:otherwise>
          <A HREF="javascript:doNothing()" onclick="setDateField(document.{$formName}.{@Name}_DT);">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/>
          </A>
        </xsl:otherwise>
      </xsl:choose>
      <!-- Calendar - End. -->
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
    <xsl:if test="count(BUTTONS) > 0 or count(PAGINATION) > 0">
      <i2:container id="button_container" scrollable="yes" editable="no">
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
          <tr>
            <!-- Pagination -->
            <td>
              <xsl:apply-templates select="PAGINATION"/>
            </td>
            <!-- Buttons  -->
            <td align="right">
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
      </i2:container>
    </xsl:if>
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="TD[(@Type = 'NumberFilter')  and (@Filter = 'yes')]" mode="content">
    <xsl:variable name="searchtooltip">
      <i18n:text>Search</i18n:text>
    </xsl:variable>
    <xsl:variable name="clearfilter_tooltip">
      <i18n:text>Clear Filter</i18n:text>
    </xsl:variable>
    <xsl:variable name="name" select=" concat(@Name, '_OPERATOR') "/>
    <xsl:variable name="operatorValue" select="/RESPONSES/RESPONSE/*[name() = $name]/@Value"/>
    <td align="bottom" nowrap="yes" style="padding:0px;">
      <table>
        <tr>
          <td style="padding:3px;">
            <xsl:choose>
              <xsl:when test=" string-length(./@Value) > 0">
                <xsl:variable name="var1" select="concat('document.forms.', $formName, '.' ,
                                    @Name , '.value=', $quote , $quote )"/>
                <xsl:variable name="var2" select="concat('document.forms.', $formName, '.' ,
                                    @Name , '_OPERATOR.value=', $quote , $quote )"/>
                <A HREF="{concat('javascript:doSomething( ',$var1, ',' , $var2,');')}">
                  <i2:img src="/clearfilter.gif" border="0" width="16" height="16" align="bottom" alt="{$clearfilter_tooltip}"/>
                </A>
              </xsl:when>
              <xsl:when test=" string-length(./@Value)= 0">
                <!--
                                <i2:img src="/clearfilter_disabled.gif" border="0" width="16"
                                    height="16" align="bottom" alt="Clear Filter"/>
-->
              </xsl:when>
            </xsl:choose>
            <select class="pulldown" name="{concat(@Name, '_OPERATOR')}">
              <option value="EQUAL">
                <xsl:if test="$operatorValue = 'EQUAL'">
                  <xsl:attribute name="selected">true</xsl:attribute>
                </xsl:if>
                                =
                            </option>
              <option value="NOT_EQUAL">
                <xsl:if test="$operatorValue = 'NOT_EQUAL'">
                  <xsl:attribute name="selected">true</xsl:attribute>
                </xsl:if>
                                !=
                            </option>
              <option value="GREATER">
                <xsl:if test="$operatorValue = 'GREATER'">
                  <xsl:attribute name="selected">true</xsl:attribute>
                </xsl:if>
                                &gt;
                            </option>
              <option value="GREATER_EQUAL">
                <xsl:if test="$operatorValue = 'GREATER_EQUAL'">
                  <xsl:attribute name="selected">true</xsl:attribute>
                </xsl:if>
                                &gt;=
                            </option>
              <option value="LESS">
                <xsl:if test="$operatorValue = 'LESS'">
                  <xsl:attribute name="selected">true</xsl:attribute>
                </xsl:if>
                                &lt;
                            </option>
              <option value="LESS_EQUAL">
                <xsl:if test="$operatorValue = 'LESS_EQUAL'">
                  <xsl:attribute name="selected">true</xsl:attribute>
                </xsl:if>
                                &lt;=
                            </option>
            </select>
          </td>
          <td style="padding:0px;">
            <input fieldtype="text" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="8" onkeyup="javascript:onlyValidCharacters(/[0123456789.,\u0020\u00A0]/)"/>
            <!--A HREF="javascript:dispatchSearch();">
                            <i2:img src="/srch_actv.gif" border="0" width="16" height="16"
                                align="bottom" alt="{$searchtooltip}"/>
                        </A-->
          </td>
        </tr>
      </table>
    </td>
  </xsl:template>
</xsl:stylesheet>

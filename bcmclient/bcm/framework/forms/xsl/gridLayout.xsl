<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
        xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
        xmlns:extension-function="xalan://com.i2.bcm.x2.xsl.extensions.XalanExtensionFunctions"
        extension-element-prefixes="i2 i18n" version="1.0">

  <xsl:output method="html"/>

  <xsl:variable name="singleQuote">'</xsl:variable>

  <xsl:template name="TableLayout">
    <xsl:param name="tableRowList"/>
    <xsl:param name="tableMetaData"/>
    <xsl:param name="filterData"/>
    <xsl:param name="pageSize"/>

    <xsl:variable name="pageLength">
      <xsl:choose>
        <xsl:when test="string-length($pageSize) &gt; 0">
          <xsl:value-of select="$pageSize"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="10"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <i2:container width="100%" id="placeholderContainerForI2Table">
      <xsl:if test="count($tableRowList/*) = 0">
        <i2:attribute name="scrollable">yes</i2:attribute>
      </xsl:if>
      <table width="100%">
        <tr>
          <td>
            <!-- Not able to find another meaningful name -->
            <xsl:variable name="currentPage"
              select="ceiling($tableRowList/@StartAtRow div $pageLength) + 1"/>
            <xsl:variable name="endPage">
              <xsl:choose>
                <xsl:when test="$tableRowList/@StartAtRow = $tableRowList/@TotalRowCount">
                  <xsl:value-of select="ceiling($tableRowList/@TotalRowCount div $pageLength) + 1"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="ceiling($tableRowList/@TotalRowCount div $pageLength)"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>

            <xsl:variable name="pagingTitle">
              <xsl:choose>
                <xsl:when test="$tableRowList/@TotalRowCount &gt; 0">
                  <i18n:text>Page</i18n:text>&#xA0;
                  <i18n:number>
                    <xsl:value-of select="$currentPage"/>
                  </i18n:number>&#xA0;of&#xA0;
                  <i18n:number><xsl:value-of select="$endPage"/></i18n:number>
                </xsl:when>
              </xsl:choose>
            </xsl:variable>
            <xsl:variable name="width">
              <xsl:choose>
                <xsl:when test="@Width">
                  <xsl:value-of select="@Width" />
                </xsl:when>
                <xsl:otherwise>100%</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>

<!--
            <xsl:choose>
              <xsl:when test="count($tableRowList/*) &gt; 0">
-->
                <i2:table id="{@Id}" width="{$width}" >
                  <xsl:if test="@Pagination = 'yes' ">
                    <xsl:variable name="title">
                      <xsl:choose>
                        <xsl:when test="$tableMetaData/@Title">
                          <xsl:value-of select="concat($tableMetaData/@Title, ' : ', $pagingTitle)" />
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="$pagingTitle" />
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:variable>

                  <i2:attribute name="title"><xsl:value-of select="$title"/> </i2:attribute>
                  </xsl:if>

                  <!-- Make the table scrollable only if there is at least one row in the table.
                        Otherwise, the table is not rendered properly -->
<!--
                  <i2:attribute name="scrollablerows">yes</i2:attribute>
                  <i2:attribute name="scrollablecolumns">auto</i2:attribute>
-->
                  <xsl:if test="@Scrollable = 'yes' and count($tableRowList/*) &gt; 0">
                    <i2:attribute name="scrollablerows">yes</i2:attribute>
                    <i2:attribute name="scrollablecolumns">auto</i2:attribute>
                  </xsl:if>

                  <!-- Render the table header by using the presentation metadata -->
                    <xsl:call-template name="renderTableHeader">
                      <xsl:with-param name="tableMetaData" select="$tableMetaData"/>
                      <xsl:with-param name="tableRowList" select="$tableRowList"/>
                    </xsl:call-template>

                  <xsl:if test="$tableMetaData/@ShowFilterRow = 'yes' ">
                    <xsl:call-template name="renderFilterRow">
                      <xsl:with-param name="tableMetaData" select="$tableMetaData"/>
                      <xsl:with-param name="filterData" select="$filterData"/>
                    </xsl:call-template>
                  </xsl:if>

                  <!-- Now render the rows of the table one by one -->
                  <xsl:for-each select="$tableRowList/*">
                    <xsl:call-template name="renderTableRow">
                      <xsl:with-param name="tableMetaData" select="$tableMetaData"/>
                    </xsl:call-template>
                  </xsl:for-each>
                </i2:table>
            <!--
              </xsl:when>

              <xsl:otherwise>
                <i2:container title="{$pagingTitle}" >
                  <table><tr><td>No records found...</td></tr> </table>
                </i2:container>
              </xsl:otherwise>
            </xsl:choose>
-->
          </td>

          <!-- If the Move Up and Move Down buttons need to be displayed, display
                 them when there is atleast a row in the table -->
          <xsl:if test="$tableMetaData/ROW_SELECTION/@MoveUpAndDown='yes' and
                    count($tableRowList/*) &gt; 0">
            <input type="hidden" name="OPERATION"/>
            <td>
              <xsl:call-template name="renderMoveUpDownButtons"/>
            </td>
          </xsl:if>
        </tr>
      </table>

      <xsl:if test="@Pagination = 'yes' or count(BUTTONS/*) &gt; 0">
        <i2:footer>
          <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
              <xsl:if test="@Pagination = 'yes' and $tableRowList/@TotalRowCount &gt; 0">
<!--
                <xsl:if test="$tableRowList/@TotalRowCount &gt; 10">
                  <td align="center">
                    <input type="checkbox" name="SELECT_FILTERED_SET" onclick="javascript:toggleFilteredSetSelection(this);" />
                  </td>
                </xsl:if>
-->
                <td nowrap="yes" align="left" >
                <i2:pagingcontrol currentPage="{ceiling((number($tableRowList/@StartAtRow)+1) div $pageLength)}"
                  recordsPerPage="{$pageLength}" totalRecords="{number($tableRowList/@TotalRowCount)}"/>
                <input type="hidden" name="RECORD_COUNT" value="{$tableRowList/@TotalRowCount}"/>
                <input type="hidden" name="START_COUNT" value="{$tableRowList/@StartAtRow}"/>
                <input type="hidden" name="PAGE_SIZE" value="{$pageLength}"/>
                </td>
              </xsl:if>

              <td align="right">
                <xsl:apply-templates select="BUTTONS">
                  <xsl:with-param name="noOfRows" select="$tableRowList/@TotalRowCount"/>
                </xsl:apply-templates>
              </td>
            </tr>
          </table>
        </i2:footer>
      </xsl:if>
    </i2:container>
  </xsl:template>

  <xsl:template name="renderTableHeader">
    <xsl:param name="tableMetaData"/>
    <xsl:param name="tableRowList"/>

    <i2:tr header="yes">
      <!-- If the table needs selectable rows, create it as the first column in the table-->
        <xsl:call-template name="getRowSelectionColumnForTableHeader">
          <xsl:with-param name="selectionType" select="$tableMetaData/ROW_SELECTION/@Type"/>
          <xsl:with-param name="rowsPresent" select="count($tableRowList/*) &gt; 0"/>
        </xsl:call-template>

      <!-- Now create the rest of the header columns -->
      <xsl:for-each select="$tableMetaData/PROPERTY[not(@Hidden) or @Hidden != 'yes']">
        <xsl:call-template name="getTableHeaderColumn">
          <xsl:with-param name="property" select="."/>
        </xsl:call-template>
      </xsl:for-each>
    </i2:tr>
  </xsl:template>

  <xsl:template name="renderFilterRow">
    <xsl:param name="tableMetaData" />
    <xsl:param name="filterData" />

    <i2:tr header="yes">
      <xsl:if test="$tableMetaData/ROW_SELECTION/@Type = 'SINGLE_ROW' or
                         $tableMetaData/ROW_SELECTION/@Type = 'MULTIPLE_ROWS'  ">
        <td class="checkboxColumn"/>
      </xsl:if>

      <xsl:for-each select="$tableMetaData/PROPERTY">
        <xsl:call-template name="getTableFilterColumn">
          <xsl:with-param name="property" select="."/>
          <xsl:with-param name="filterData" select="$filterData"/>
        </xsl:call-template>
      </xsl:for-each>
    </i2:tr>
  </xsl:template>

  <xsl:template name="getRowSelectionColumnForTableHeader" >
    <xsl:param name="selectionType"/>
    <xsl:param name="rowsPresent" />

    <xsl:choose>
      <xsl:when test="not($rowsPresent)">
        <td nowrap="yes" />
      </xsl:when>
      <xsl:when test="$selectionType = 'SINGLE_ROW' ">
        <td nowrap="yes" />
      </xsl:when>
      <xsl:when test="$selectionType = 'MULTIPLE_ROWS' ">
        <!--TODO See the class attribute later -->
        <td nowrap="yes" align="center" class="checkboxColumn" >
          <input type="checkbox" name="SELECT_ALL_ROWS" onclick="javascript:toggleRowSelection(this.checked);"/>
        </td>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="getTableHeaderColumn">
    <xsl:param name="property"/>

    <td nowrap="yes" align="center" >
      <i18n:text><xsl:value-of select="$property/@DisplayName"/></i18n:text>
    </td>
  </xsl:template>

  <xsl:template name="getTableFilterColumn">
    <xsl:param name="property"/>
    <xsl:param name="filterData"/>

    <xsl:choose>
      <xsl:when test="$property/@Filterable = 'yes' ">
        <td nowrap="yes" align="center">
          <table cellpadding="1" >
            <tr>
              <td nowrap="yes" align="bottom">
                <xsl:variable name="filterName" select="concat('Filter.', $property/@Name)"/>
                <xsl:variable name="filterValue" select="$filterData/*[name() = $filterName]/@Value"/>
                <xsl:if test="string($filterValue)">
                  <a href="{concat('javascript:onClearFilter(' , $singleQuote, $filterName, $singleQuote, ');' )}">
                    <i2:img src="/clearfilter.gif" border="0" width="16" height="16" valign="bottom" alt="Clear Filter"/>
                  </a>
                </xsl:if>
                <input fieldtype="text" name="{$filterName}" value="{$filterValue}" type="field" class="inputfieldIE" size="10"/>
                <a href="javascript:onSearch();">
                  <i2:img src="/srch_actv.gif" border="0" width="16" height="16" align="bottom" alt="Search"/>
                </a>
              </td>
            </tr>
          </table>
        </td>
      </xsl:when>
      <xsl:when test="$property/@Filterable ='hidden' ">
        <td nowrap="yes" align="center">
          <xsl:variable name="filterName" select="concat('Filter.', $property/@Name)"/>
          <input fieldtype="text" name="{$filterName}" type="field" class="inputfieldIE" style="border:none; background-color:transparent" size="10"/>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td>&#xA0;</td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="renderMoveUpDownButtons">
    <table>
      <tr>
        <td>
          <i2:img onclick="javascript:onMoveUp()" src="/arrow_move_up.gif" align="bottom" border="0">
            <i2:attribute name="alt">Move Up</i2:attribute>
          </i2:img>
        </td>
      </tr>
      <tr>
        <td>&#xA0;</td>
      </tr>
      <tr>
        <td>
          <i2:img onclick="javascript:onMoveDown()" src="/arrow_move_down.gif" align="bottom" border="0">
            <i2:attribute name="alt">Move Down</i2:attribute>
          </i2:img>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="renderTableRow">
    <xsl:param name="tableMetaData"/>

    <!-- Since this template is called from within the for loop, the current node
           is visible here -->
    <xsl:variable name="tableRowData" select="."/>

    <i2:tr>
      <xsl:call-template name="getRowSelectionColumnForTableRow" >
        <xsl:with-param name="tableMetaData" select="$tableMetaData"/>
        <xsl:with-param name="tableRowData" select="$tableRowData"/>
      </xsl:call-template>

      <!-- Now render all other columns in the current row-->
      <xsl:for-each select="$tableMetaData/PROPERTY[not(@Hidden) or @Hidden != 'yes']">
        <xsl:call-template name="renderTableColumn">
          <xsl:with-param name="tableRowData" select="$tableRowData"/>
        </xsl:call-template>
      </xsl:for-each>
    </i2:tr>
  </xsl:template>

  <xsl:template name="getRowSelectionColumnForTableRow" >
    <xsl:param name="tableMetaData"/>
    <xsl:param name="tableRowData"/>

    <!-- If the table needs selectable rows, create a radio button or checkbox depending
          upon whether the selection is single/multiple rows -->
    <xsl:if test="$tableMetaData/ROW_SELECTION">
      <td align="center" class="checkboxColumn" >
<!--      <td align="center" class="checkboxColumn" width="1%">-->
        <xsl:variable name="selectedIdValue">
          <xsl:choose>
            <xsl:when test="$tableMetaData/ROW_SELECTION/@GenerationMode = 'CUSTOM' ">
              <xsl:value-of select="extension-function:getSelectedID($tableMetaData/ROW_SELECTION/COLUMN, $tableRowData/*)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="extension-function:getSelectedID($tableMetaData/PROPERTY[@PrimaryKey='yes'], $tableRowData/*)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$tableMetaData/ROW_SELECTION/@Type = 'SINGLE_ROW' ">
            <!-- TODO Change the row background color on selection - implement onclick for this -->
            <!--TODO What abt. the class attribute for these radios -->
            <input type="radio" name="{$tableMetaData/ROW_SELECTION/@SelectedIdName}" onclick="javascript:onRowSelection(this);" value="{$selectedIdValue}"/>
          </xsl:when>
          <xsl:when test="$tableMetaData/ROW_SELECTION/@Type = 'MULTIPLE_ROWS' ">
            <!--TODO What abt. the class attribute for these checkboxes -->
            <input type="checkbox" name="{$tableMetaData/ROW_SELECTION/@SelectedIdName}" onclick="javascript:onRowSelection(this);" value="{$selectedIdValue}"/>
          </xsl:when>
        </xsl:choose>

      </td>
    </xsl:if>
  </xsl:template>

  <xsl:template name="renderTableColumn">
    <xsl:param name="tableRowData"/>

    <td nowrap="yes">
      <xsl:variable name="columnName" select="@Name"/>
      <xsl:value-of select="$tableRowData/*[name() = $columnName]/@Value"/>
    </td>
  </xsl:template>

</xsl:stylesheet>
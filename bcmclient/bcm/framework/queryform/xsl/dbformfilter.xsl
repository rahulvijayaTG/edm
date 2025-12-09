<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../../core/xsl/i18n.xsl"/>
  <xsl:import href="../../xsl/required_field.xsl"/>
  <xsl:output method="html"/>
  <!-- Table Title -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TABLE" mode="table_title">
    <xsl:param name="noOfColumns"/>
    <xsl:param name="noOfRows"/>
    <xsl:param name="totalRecordCount"/>
    <xsl:param name="startAtRow"/>
    <xsl:param name="maxRows"/>
    <!--xsl:variable name="pagingTitle">
      <xsl:choose>
        <xsl:when test="@PagingTitle">
          <xsl:value-of select="@PagingTitle"/>
        </xsl:when>
        <xsl:otherwise>yes</xsl:otherwise>
      </xsl:choose>
    </xsl:variable-->
    <xsl:variable name="currentPage">
      <xsl:value-of select="ceiling(($startAtRow+1) div $maxRows)"/>
    </xsl:variable>
    <xsl:variable name="endPage">
      <xsl:choose>
        <xsl:when test="$totalRecordCount = '1000000000000000'">
          <i18n:text>UnKnown</i18n:text>
        </xsl:when>
        <xsl:when test="$totalRecordCount = '0'">
          <i18n:number>1</i18n:number>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="ceiling($totalRecordCount div $maxRows)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
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
        <xsl:if test="$noOfRows > 0">
            :&#xA0;
            <i18n:text>Page</i18n:text>
            &#xA0;
            <i18n:number>
            <xsl:value-of select="$currentPage"/>
          </i18n:number>
            &#xA0;<xsl:value-of select="$endPage_i18n"/>
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
                        :&#xA0;
                        <i18n:text>
                  <xsl:value-of select="@NoRecordsTitle"/>
                </i18n:text>
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
    </xsl:variable>
    <xsl:variable name="filterTitle">
      <xsl:choose>
        <xsl:when test="(string-length(@FilterTitle) > 0 )">
          &#xA0;&#xA0;:&#xA0;Filtered (<xsl:value-of select="@FilterTitle"/>)
          </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <!--xsl:choose>
       <xsl:when test=" $totalRecordCount > 0 ">
          <xsl:value-of select="concat($title,$pagingTitle,$noRowsTitle,$filterTitle)"/>
       </xsl:when>
       <xsl:otherwise>
          <xsl:value-of select="concat($title,$noRowsTitle,$filterTitle)"/>
       </xsl:otherwise>
    </xsl:choose-->
    <xsl:variable name="countTitle">
      <xsl:if test="$totalRecordCount > 0">
          &#xA0;<i18n:text>Total records</i18n:text>&#xA0; <i18n:number>
          <xsl:value-of select="$totalRecordCount"/>
        </i18n:number>
      </xsl:if>
    </xsl:variable>
    <xsl:value-of select="concat($title,$pagingTitle,$noRowsTitle,$filterTitle, $countTitle)"/>
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
    <xsl:param name="noOfColumns"/>
    <xsl:param name="noOfRows"/>
    <xsl:param name="totalRecordCount"/>
    <xsl:param name="startAtRow"/>
    <xsl:param name="maxRows"/>
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
    <xsl:variable name="action">
      <xsl:choose>
        <xsl:when test="@Action">
          <xsl:value-of select="@Action"/>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="columnCount">
      <xsl:value-of select="count(./TR[position() = 1]/TD[@Type!='Hidden' and @Type!='None' and @Sequence != '-100'])"/>
    </xsl:variable>
    <xsl:variable name="frozen_sequence">
      <xsl:choose>
        <xsl:when test="@FrozenSequence and string-length(@FrozenSequence) > 0">
          <xsl:choose>
            <xsl:when test="not($columnCount > (@FrozenSequence))">
                  -999
                  </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@FrozenSequence"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>-999</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="freezable">
      <xsl:choose>
        <xsl:when test="@Freezable">
          <xsl:value-of select="@Freezable"/>
        </xsl:when>
        <xsl:otherwise>no</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="overridden">
      <xsl:choose>
        <xsl:when test="@Overridden">
          <xsl:value-of select="@Overridden"/>
        </xsl:when>
        <xsl:otherwise>yes</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--columnCount to disable hide when there is only one column-->
    <!-- html form -->
    <table id="table_id" width="100%" cellspacing="0" cellpadding="0" border="0">
      <form id="form_id" action="{$action}" name="{$formName}" method="{$method}">
        <tr>
          <td>
            <!-- Hidden Fields -->
            <xsl:for-each select="FIELD[@Type='Hidden']">
              <input name="{@Name}" type="hidden" value="{@Value}"/>
            </xsl:for-each>
            <i2:container id="{$tableContainerId}" inner="yes">
              <xsl:if test="$freezable='no' and (@ScrollableContainer = 'yes' or  $totalRecordCount = 0) ">
                <i2:attribute name="scrollable">yes</i2:attribute>
              </xsl:if>
              <xsl:if test="@CollapsableContainer = 'yes' ">
                <i2:attribute name="collapsable">yes</i2:attribute>
              </xsl:if>
              <i2:attribute name="title">
                <xsl:apply-templates select="." mode="table_title">
                  <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                  <xsl:with-param name="noOfRows" select="$noOfRows"/>
                  <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                  <xsl:with-param name="startAtRow" select="$startAtRow"/>
                  <xsl:with-param name="maxRows" select="$maxRows"/>
                </xsl:apply-templates>
              </i2:attribute>
              <!--xsl:apply-templates select="." mode="table_container_header"/-->
              <!--xsl:if test="$noOfRows > 1"-->
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
                        <i2:table id="result_form_table_slave">
                          <i2:attribute name="scrollablerows">hidden</i2:attribute>
                          <xsl:apply-templates select="TR">
                            <xsl:with-param name="formName" select="$formName"/>
                            <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                            <xsl:with-param name="noOfRows" select="$noOfRows"/>
                            <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                            <xsl:with-param name="startAtRow" select="$startAtRow"/>
                            <xsl:with-param name="maxRows" select="$maxRows"/>
                            <xsl:with-param name="validate" select="@Validation"/>
                            <xsl:with-param name="isFrozen" select="true()"/>
                            <xsl:with-param name="frozenSequence" select="$frozen_sequence"/>
                            <xsl:with-param name="freezable" select="$freezable"/>
                            <xsl:with-param name="overridden" select="$overridden"/>
                            <xsl:with-param name="columnCount" select="$columnCount"/>
                          </xsl:apply-templates>
                        </i2:table>
                      </td>
                      <td valign="top" width="100%" border="0" style="padding:0px;">
                        <i2:table id="{$tableId}" scrollablesyncedtable="result_form_table_slave">
                          <i2:attribute name="scrollablerows">yes</i2:attribute>
                          <i2:attribute name="scrollablecolumns">yes</i2:attribute>
                          <xsl:apply-templates select="TR">
                            <xsl:with-param name="formName" select="$formName"/>
                            <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                            <xsl:with-param name="noOfRows" select="$noOfRows"/>
                            <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                            <xsl:with-param name="startAtRow" select="$startAtRow"/>
                            <xsl:with-param name="maxRows" select="$maxRows"/>
                            <xsl:with-param name="validate" select="@Validation"/>
                            <xsl:with-param name="isFrozen" select="false()"/>
                            <xsl:with-param name="frozenSequence" select="$frozen_sequence"/>
                            <xsl:with-param name="freezable" select="$freezable"/>
                            <xsl:with-param name="overridden" select="$overridden"/>
                            <xsl:with-param name="columnCount" select="$columnCount"/>
                          </xsl:apply-templates>
                        </i2:table>
                      </td>
                    </tr>
                  </table>
                </xsl:when>
                <xsl:otherwise>
                  <table width="100%" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                      <td width="100%">
                        <xsl:apply-templates select="." mode="table_container_header"/>
                      </td>
                    </tr>
                    <tr>
                      <td valign="top" border="0" width="100%" style="padding:0px;">
                        <i2:table id="{$tableId}">
                          <xsl:choose>
                            <xsl:when test="$freezable='yes'">
                              <i2:attribute name="scrollablerows">yes</i2:attribute>
                              <i2:attribute name="scrollablecolumns">auto</i2:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:if test="@Scrollable = 'yes' and $totalRecordCount > 0 ">
                                <i2:attribute name="scrollablerows">yes</i2:attribute>
                                <i2:attribute name="scrollablecolumns">auto</i2:attribute>
                              </xsl:if>
                            </xsl:otherwise>
                          </xsl:choose>
                          <xsl:apply-templates select="TR">
                            <xsl:with-param name="formName" select="$formName"/>
                            <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                            <xsl:with-param name="noOfRows" select="$noOfRows"/>
                            <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                            <xsl:with-param name="startAtRow" select="$startAtRow"/>
                            <xsl:with-param name="maxRows" select="$maxRows"/>
                            <xsl:with-param name="validate" select="@Validation"/>
                            <xsl:with-param name="isFrozen" select="false()"/>
                            <xsl:with-param name="frozenSequence" select="$frozen_sequence"/>
                            <xsl:with-param name="freezable" select="$freezable"/>
                            <xsl:with-param name="overridden" select="$overridden"/>
                            <xsl:with-param name="columnCount" select="$columnCount"/>
                          </xsl:apply-templates>
                        </i2:table>
                      </td>
                    </tr>
                  </table>
                </xsl:otherwise>
              </xsl:choose>
              <!--chandru end-->
              <!--i2:table id="{$tableId}">
                <xsl:if test="@Scrollable = 'yes' and $totalRecordCount > 0 ">
                  <i2:attribute name="scrollablerows">yes</i2:attribute>
                  <i2:attribute name="scrollablecolumns">auto</i2:attribute>
                </xsl:if>
                <xsl:apply-templates>
                  <xsl:with-param name="formName" select="$formName"/>
                  <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                  <xsl:with-param name="noOfRows" select="$noOfRows"/>
                  <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                  <xsl:with-param name="startAtRow" select="$startAtRow"/>
                  <xsl:with-param name="maxRows" select="$maxRows"/>
                  <xsl:with-param name="validate" select="@Validation"/>
                </xsl:apply-templates>
              </i2:table-->
              <!--/xsl:if-->
              <xsl:apply-templates select="." mode="table_container_footer">
                <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                <xsl:with-param name="noOfRows" select="$noOfRows"/>
                <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                <xsl:with-param name="startAtRow" select="$startAtRow"/>
                <xsl:with-param name="maxRows" select="$maxRows"/>
                <xsl:with-param name="formName" select="$formName"/>
              </xsl:apply-templates>
            </i2:container>
          </td>
        </tr>
        <!-- Hidden Rows -->
        <xsl:apply-templates select="TR[@Type='Hidden']" mode="hidden"/>
        <script type="">
         var resultFormName = "<xsl:value-of select="$formName"/>";
         if (document.forms[resultFormName].DISPLAY_COUNT != null &amp;&amp; document.forms[resultFormName].DISPLAY_COUNT != '' )
         {
            document.forms[resultFormName].DISPLAY_COUNT.value = "<xsl:value-of select="$columnCount"/>"
         }
         </script>
      </form>
    </table>
  </xsl:template>
  <!-- Table with move up and down -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TABLE" mode="moveupdown">
    <xsl:param name="formName"/>
    <xsl:param name="noOfColumns"/>
    <xsl:param name="noOfRows"/>
    <xsl:param name="totalRecordCount"/>
    <xsl:param name="startAtRow"/>
    <xsl:param name="maxRows"/>
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
    <xsl:variable name="columnCount">
      <xsl:value-of select="count(./TR[position() = 1]/TD[@Type!='Hidden' and @Type!='None' and @Sequence != '-100'])"/>
    </xsl:variable>
    <xsl:variable name="frozen_sequence">
      <xsl:choose>
        <xsl:when test="@FrozenSequence and string-length(@FrozenSequence) > 0">
          <xsl:choose>
            <xsl:when test="not($columnCount > (@FrozenSequence))">
                  -999
                  </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@FrozenSequence"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>-999</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="freezable">
      <xsl:choose>
        <xsl:when test="@Freezable">
          <xsl:value-of select="@Freezable"/>
        </xsl:when>
        <xsl:otherwise>no</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="overridden">
      <xsl:choose>
        <xsl:when test="@Overridden">
          <xsl:value-of select="@Overridden"/>
        </xsl:when>
        <xsl:otherwise>yes</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--columnCount to disable hide when there is only one column-->
    <!-- html form -->
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
      <form name="{$formName}" method="{$method}">
        <tr>
          <td>
            <!-- Hidden Fields -->
            <xsl:for-each select="FIELD[@Type='Hidden']">
              <input name="{@Name}" type="hidden" value="{@Value}"/>
            </xsl:for-each>
            <i2:container id="{$tableContainerId}" inner="yes">
              <xsl:if test="$freezable='no' and (@ScrollableContainer = 'yes' or  $totalRecordCount = 0) ">
                <i2:attribute name="scrollable">yes</i2:attribute>
              </xsl:if>
              <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td>
                    <i2:attribute name="title">
                      <xsl:apply-templates select="." mode="table_title">
                        <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                        <xsl:with-param name="noOfRows" select="$noOfRows"/>
                        <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                        <xsl:with-param name="startAtRow" select="$startAtRow"/>
                        <xsl:with-param name="maxRows" select="$maxRows"/>
                      </xsl:apply-templates>
                    </i2:attribute>
                    <!--xsl:apply-templates select="." mode="table_container_header"/-->
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
                            <td valign="top" border="0">
                              <i2:table id="result_form_table_slave">
                                <i2:attribute name="scrollablerows">hidden</i2:attribute>
                                <xsl:apply-templates select="TR">
                                  <xsl:with-param name="formName" select="$formName"/>
                                  <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                                  <xsl:with-param name="noOfRows" select="$noOfRows"/>
                                  <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                                  <xsl:with-param name="startAtRow" select="$startAtRow"/>
                                  <xsl:with-param name="maxRows" select="$maxRows"/>
                                  <xsl:with-param name="validate" select="@Validation"/>
                                  <xsl:with-param name="isFrozen" select="true()"/>
                                  <xsl:with-param name="frozenSequence" select="$frozen_sequence"/>
                                  <xsl:with-param name="freezable" select="$freezable"/>
                                  <xsl:with-param name="overridden" select="$overridden"/>
                                  <xsl:with-param name="columnCount" select="$columnCount"/>
                                </xsl:apply-templates>
                              </i2:table>
                            </td>
                            <td valign="top" width="100%" border="0">
                              <i2:table id="{$tableId}" scrollablesyncedtable="result_form_table_slave">
                                <i2:attribute name="scrollablerows">yes</i2:attribute>
                                <i2:attribute name="scrollablecolumns">yes</i2:attribute>
                                <xsl:apply-templates select="TR">
                                  <xsl:with-param name="formName" select="$formName"/>
                                  <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                                  <xsl:with-param name="noOfRows" select="$noOfRows"/>
                                  <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                                  <xsl:with-param name="startAtRow" select="$startAtRow"/>
                                  <xsl:with-param name="maxRows" select="$maxRows"/>
                                  <xsl:with-param name="validate" select="@Validation"/>
                                  <xsl:with-param name="isFrozen" select="false()"/>
                                  <xsl:with-param name="frozenSequence" select="$frozen_sequence"/>
                                  <xsl:with-param name="freezable" select="$freezable"/>
                                  <xsl:with-param name="overridden" select="$overridden"/>
                                  <xsl:with-param name="columnCount" select="$columnCount"/>
                                </xsl:apply-templates>
                              </i2:table>
                            </td>
                          </tr>
                        </table>
                      </xsl:when>
                      <xsl:otherwise>
                        <table width="100%" cellspacing="0" cellpadding="0" border="0">
                          <tr>
                            <td width="100%">
                              <xsl:apply-templates select="." mode="table_container_header"/>
                            </td>
                          </tr>
                          <tr>
                            <td valign="top" border="0" width="100%">
                              <i2:table id="{$tableId}">
                                <xsl:choose>
                                  <xsl:when test="$freezable='yes'">
                                    <i2:attribute name="scrollablerows">yes</i2:attribute>
                                    <i2:attribute name="scrollablecolumns">auto</i2:attribute>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:if test="@Scrollable = 'yes' and $totalRecordCount > 0 ">
                                      <i2:attribute name="scrollablerows">yes</i2:attribute>
                                      <i2:attribute name="scrollablecolumns">auto</i2:attribute>
                                    </xsl:if>
                                  </xsl:otherwise>
                                </xsl:choose>
                                <xsl:apply-templates select="TR">
                                  <xsl:with-param name="formName" select="$formName"/>
                                  <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                                  <xsl:with-param name="noOfRows" select="$noOfRows"/>
                                  <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                                  <xsl:with-param name="startAtRow" select="$startAtRow"/>
                                  <xsl:with-param name="maxRows" select="$maxRows"/>
                                  <xsl:with-param name="validate" select="@Validation"/>
                                  <xsl:with-param name="isFrozen" select="false()"/>
                                  <xsl:with-param name="frozenSequence" select="$frozen_sequence"/>
                                  <xsl:with-param name="freezable" select="$freezable"/>
                                  <xsl:with-param name="overridden" select="$overridden"/>
                                  <xsl:with-param name="columnCount" select="$columnCount"/>
                                </xsl:apply-templates>
                              </i2:table>
                            </td>
                          </tr>
                        </table>
                      </xsl:otherwise>
                    </xsl:choose>
                    <!--xsl:if test="$noOfRows > 0"-->
                    <!--i2:table id="{$tableId}">
                      <xsl:if test="@Scrollable = 'yes' and $totalRecordCount > 0">
                        <i2:attribute name="scrollablerows">yes</i2:attribute>
                        <i2:attribute name="scrollablecolumns">auto</i2:attribute>
                      </xsl:if>
                      <xsl:apply-templates>
                        <xsl:with-param name="formName" select="$formName"/>
                        <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                        <xsl:with-param name="noOfRows" select="$noOfRows"/>
                        <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                        <xsl:with-param name="startAtRow" select="$startAtRow"/>
                        <xsl:with-param name="maxRows" select="$maxRows"/>
                        <xsl:with-param name="validate" select="@Validation"/>
                      </xsl:apply-templates>
                    </i2:table!-->
                    <!--/xsl:if-->
                  </td>
                  <xsl:if test="$totalRecordCount>1">
                    <td>
                      <table>
                        <tr>
                          <td>
                            <i2:img onclick="javascript:onMoveUp()" src="/arrow_move_up.gif" align="bottom" border="0">
                              <i2:attribute name="alt">
                                <i18n:text>Move Up...</i18n:text>
                              </i2:attribute>
                            </i2:img>
                          </td>
                        </tr>
                        <tr>
                          <td>&#xA0;</td>
                        </tr>
                        <tr>
                          <td>
                            <i2:img onclick="javascript:onMoveDown()" src="/arrow_move_down.gif" align="bottom" border="0">
                              <i2:attribute name="alt">
                                <i18n:text>Move Down...</i18n:text>
                              </i2:attribute>
                            </i2:img>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </xsl:if>
                </tr>
              </table>
              <xsl:apply-templates select="." mode="table_container_footer">
                <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                <xsl:with-param name="noOfRows" select="$noOfRows"/>
                <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                <xsl:with-param name="startAtRow" select="$startAtRow"/>
                <xsl:with-param name="maxRows" select="$maxRows"/>
              </xsl:apply-templates>
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
  <!--xsl:template match="TR">
    <xsl:param name="formName"/>
    <xsl:param name="noOfRows"/>
    <xsl:param name="totalRecordCount"/>
    <xsl:param name="validate"/>
    
    <xsl:if test="string-length(@Type) = 0">
      <i2:tr>
        <xsl:if test="string-length(@Header) > 0 or string-length(@Filter) > 0">
          <i2:attribute name="header">yes</i2:attribute>
        </xsl:if>
        <xsl:if test="@Disabled">
          <i2:attribute name="highlight">true</i2:attribute>
        </xsl:if>
        <xsl:apply-templates select="TD" mode="content">
          <xsl:sort select="@Sequence" data-type="number" order="ascending"/>
          <xsl:with-param name="rowNo" select="position()-2"/>
          <xsl:with-param name="header" select="@Header"/>
          <xsl:with-param name="formName" select="$formName"/>
          <xsl:with-param name="noOfRows" select="$noOfRows"/>
          <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
          <xsl:with-param name="validate" select="$validate"/>
        </xsl:apply-templates>
      </i2:tr>
    </xsl:if>
  </xsl:template-->
  <!--chandru start-->
  <xsl:template match="TR">
    <xsl:param name="formName"/>
    <xsl:param name="noOfRows"/>
    <xsl:param name="totalRecordCount"/>
    <xsl:param name="validate"/>
    <xsl:param name="isFrozen"/>
    <xsl:param name="frozenSequence"/>
    <xsl:param name="freezable"/>
    <xsl:param name="overridden"/>
    <xsl:param name="columnCount"/>
    <xsl:if test="string-length(@Type) = 0">
      <i2:tr>
        <xsl:if test="string-length(@Header)  > 0">
          <i2:attribute name="header">yes</i2:attribute>
        </xsl:if>
        <xsl:if test="$frozenSequence = -999">
          <xsl:apply-templates select="TD" mode="content">
            <!--xsl:sort select="@Sequence" data-type="number" order="ascending"/-->
            <xsl:with-param name="rowNo" select="position()-2"/>
            <xsl:with-param name="header" select="@Header"/>
            <xsl:with-param name="formName" select="$formName"/>
            <xsl:with-param name="noOfRows" select="$noOfRows"/>
            <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
            <xsl:with-param name="validate" select="$validate"/>
            <xsl:with-param name="frozenSequence" select="$frozenSequence"/>
            <xsl:with-param name="freezable" select="$freezable"/>
            <xsl:with-param name="overridden" select="$overridden"/>
            <xsl:with-param name="columnCount" select="$columnCount"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="$frozenSequence != -999">
          <xsl:choose>
            <xsl:when test="$isFrozen = true()">
              <xsl:apply-templates select="TD[$frozenSequence > @Sequence ]" mode="content">
                <!--xsl:sort select="@Sequence" data-type="number" order="ascending"/-->
                <xsl:with-param name="rowNo" select="position()-2"/>
                <xsl:with-param name="header" select="@Header"/>
                <xsl:with-param name="formName" select="$formName"/>
                <xsl:with-param name="noOfRows" select="$noOfRows"/>
                <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                <xsl:with-param name="validate" select="$validate"/>
                <xsl:with-param name="frozenSequence" select="$frozenSequence"/>
                <xsl:with-param name="freezable" select="$freezable"/>
                <xsl:with-param name="overridden" select="$overridden"/>
                <xsl:with-param name="columnCount" select="$columnCount"/>
              </xsl:apply-templates>
            </xsl:when>  
            <xsl:otherwise>
              <xsl:apply-templates select="TD[@Sequence >= $frozenSequence] | TD[@Type = 'Hidden']" mode="content">
                <xsl:sort select="@Sequence" data-type="number" order="ascending"/>
                <xsl:with-param name="rowNo" select="position()-2"/>
                <xsl:with-param name="header" select="@Header"/>
                <xsl:with-param name="formName" select="$formName"/>
                <xsl:with-param name="noOfRows" select="$noOfRows"/>
                <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                <xsl:with-param name="validate" select="$validate"/>
                <xsl:with-param name="frozenSequence" select="$frozenSequence"/>
                <xsl:with-param name="freezable" select="$freezable"/>
                <xsl:with-param name="overridden" select="$overridden"/>
                <xsl:with-param name="columnCount" select="$columnCount"/>
              </xsl:apply-templates>
            </xsl:otherwise>
          </xsl:choose> 
        </xsl:if>
      </i2:tr>
    </xsl:if>
  </xsl:template>
  <!--chandru end-->
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
  <xsl:template match="TD[@Type = 'None']" mode="content">
    <input name="{@Name}" type="hidden" value="{@Value}"/>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[@Type = 'None' and @Header]" mode="content"/>
  <xsl:template match="TD[@Type = 'None' and @Filter]" mode="content"/>
  <!-- Field - CheckBox -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[@Type = 'CheckBox']" mode="content">
    <xsl:param name="rowNo"/>
    <xsl:param name="header"/>
    <xsl:param name="totalRecordCount"/>
    <xsl:param name="frozenSequence"/>
    <!--xsl:param name="totalRecordCount"/-->
    <xsl:choose>
      <xsl:when test="$frozenSequence &lt; 0">
        <xsl:choose>
          <xsl:when test="$totalRecordCount &gt; 0">
            <i2:rowselector checked="{@Checked}" select="{@Select}" name="{@Name}" value="{@Value}" global="{@Header}"/>
          </xsl:when>
          <xsl:otherwise>
            <th nowrap="yes" align="center" class="checkboxColumn"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
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
      </xsl:otherwise>
    </xsl:choose>
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
  <xsl:template match="TD[@Type = 'Hidden']" mode="content"/>
  <!-- Field Radio -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[@Type = 'Radio']" mode="content">
    <xsl:param name="rowNo"/>
    <xsl:param name="header"/>
    <xsl:param name="totalRecordCount"/>
    <xsl:param name="frozenSequence"/>
    <xsl:choose>
      <xsl:when test="$frozenSequence &lt; 0">
        <xsl:choose>
          <xsl:when test="$totalRecordCount &gt; 0">
            <i2:rowselector checked="{@Checked}" select="{@Select}" name="{@Name}" value="{@Value}" global="{@Header}"/>
          </xsl:when>
          <xsl:otherwise>
            <th nowrap="yes" align="center" class="checkboxColumn"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
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
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- Field Text, Date, Number -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (not (@Type) or @Type = 'Text' or @Type = 'Date' or @Type = 'DateTime'  or @Type = 'Currency' or @Type = 'Number' or @Type='Select') and not(@Editable)]" mode="content">
    <xsl:param name="header" select="../@Header"/>
    <xsl:param name="validate"/>
    <xsl:param name="formName"/>
    <xsl:param name="totalRecordCount"/>
    <xsl:param name="frozenSequence"/>
    <xsl:param name="freezable"/>
    <xsl:param name="overridden"/>
    <xsl:param name="columnCount"/>
    <xsl:variable name="isSortable">
      <xsl:choose>
        <xsl:when test="$totalRecordCount = 1 or /RESPONSES/RESPONSE/MULTI_SORT_ENABLED/@Value ='yes' or /RESPONSES/RESPONSE/SEARCH/MULTI_SORT_ENABLED/@Value ='yes'">
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
        <xsl:when test="$overridden='no' and $formName='result_form' and $header = 'yes'">                  javascript:i2uiSetMenuCoords(this,event)           
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
        <!--xsl:when test="$totalRecordCount > 1 and @Sortable = 'yes' and  $header = 'yes'">
          <xsl:variable name="quote">'</xsl:variable>
          <xsl:value-of select="concat('javascript:sort(', $quote, @Name, $quote, ')' )"/>
        </xsl:when-->
        <!--show the popup menus  only if the form name is not overridden i.3 if the name is result_form-->
        <!--review this later if this is correct - chandru -->
        <xsl:when test="$overridden='no' and $totalRecordCount > 0 and  $header = 'yes' and $formName = 'result_form'">
          <xsl:variable name="quote">'</xsl:variable>
          <xsl:variable name="currentSequence">
            <xsl:value-of select="@Sequence"/>
          </xsl:variable>
          <xsl:variable name="isFrozenAllowed">
            <xsl:choose>
              <!--xsl:when test="count(../TD[@Type != 'Hidden' and $currentSequence > @Sequence  ]) &lt; 5 and $freezable='yes'">yes</xsl:when-->
              <xsl:when test="$freezable='yes'">yes</xsl:when>
              <xsl:otherwise>no</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <!-- showing the menu only if sortable or freezable is yes since hise is now removed -->
          <xsl:if test="$isSortable='yes' or $freezable='yes'">
            <xsl:value-of select="concat('javascript:sort(', $quote, @Name, $quote,',', @Sequence,',', $quote, $isSortable,$quote,',',$quote, $isFrozenAllowed,$quote,',',$quote,$formName,$quote,',',$quote,$columnCount,$quote, ')' )"/>
          </xsl:if>
        </xsl:when>
        <xsl:when test="string-length(@Url) > 0">
          <xsl:value-of select="@Url"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <!--[[Nitin Goel: For safety Stock Review Workflow-->
    <xsl:variable name="no-wrap">
      <xsl:choose>
        <xsl:when test="$header = 'yes'">
          <xsl:value-of select="'no'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'yes'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <td nowrap="{$no-wrap}" align="{$align}">
      <xsl:if test="$freezable='yes'">
        <xsl:attribute name="width"><xsl:value-of select="'100%'"/></xsl:attribute>
      </xsl:if>
      <nobr>
        <!--//]NG-->
        <xsl:choose>
          <xsl:when test="string-length($onclick) > 0">
            <a onmouseover="{$onmouseover}" href="{$onclick}">
              <xsl:if test="string-length(@Target) > 0  and string-length($onmouseover) = 0">
                <xsl:attribute name="target"><xsl:value-of select="@Target"/></xsl:attribute>
              </xsl:if>
              <!-- i18n logic for data(clickable). For header i18n logic is part of cnd file -->
              <xsl:choose>
                <xsl:when test="@I18Nize='true' and not($header = 'yes')">
                  <i18n:text>
                    <xsl:value-of select="@Value"/>
                  </i18n:text>
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
                <!-- i18n logic for data(clickable). For header i18n logic is part of cnd file -->
                <xsl:choose>
                  <xsl:when test="@I18Nize='true' and not($header = 'yes')">
                    <i18n:text>
                      <xsl:value-of select="@Value"/>
                    </i18n:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="@Value"/>
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
        <xsl:if test=" $validate='yes' and @Required = 'yes' and $header='yes' ">
          <xsl:call-template name="display_alert_mark"/>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="/RESPONSES/RESPONSE/MULTI_SORT_ENABLED/@Value ='yes' or /RESPONSES/RESPONSE/SEARCH/MULTI_SORT_ENABLED/@Value ='yes'">
            <xsl:choose>
              <xsl:when test="@Multisortorder and string-length(@Multisortorder)>0 ">
                <xsl:if test="@Multisortorder ='Descending'">                                                              
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
              <xsl:choose>
                <xsl:when test="/RESPONSES/RESPONSE//*/SEARCH/REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_ORDER']/@Value = 'Descending'">
                        &#xA0;&#xA0;&#xA0;<i2:img src="/descending_table_column.gif"/>
                </xsl:when>
                <xsl:otherwise>                      
                        &#xA0;&#xA0;&#xA0;&#xA0;<i2:img src="/ascending_table_column.gif"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        <!--xsl:if test="@Sortable ='yes' and $header='yes' and $sortBy = @Name">      
        <b>
          <xsl:value-of select="$sortImage"/>
        </b>
      </xsl:if-->
      </nobr>
    </td>
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
      <xsl:choose>
        <xsl:when test="$validate='yes' and @Required = 'yes' ">
          <input fieldtype="text" name="{@Name}" value="{@Value}" required="true" tabIndex="" type="field" class="inputfieldIE" size="8"/>
        </xsl:when>
        <xsl:otherwise>
          <input fieldtype="text" name="{@Name}" value="{@Value}" tabIndex="" type="field" class="inputfieldIE" size="8"/>
        </xsl:otherwise>
      </xsl:choose>
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
      <xsl:choose>
        <xsl:when test="$validate='yes' and @Required = 'yes' ">
          <input fieldtype="text" name="{@Name}" value="{@Value}" required="true" tabIndex="" onkeyup="javascript:onlyInteger()" type="field" class="inputfieldIE" size="10"/>
        </xsl:when>
        <xsl:otherwise>
          <input fieldtype="text" name="{@Name}" value="{@Value}" tabIndex="" onkeyup="javascript:onlyInteger()" type="field" class="inputfieldIE" size="10"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$validate='yes' and @Required = 'yes' ">
        <xsl:call-template name="display_alert_image">
          <xsl:with-param name="fieldName" select="@Name"/>
        </xsl:call-template>
      </xsl:if>
    </td>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Number') and (@Editable) and (@MaxLength)]" mode="content">
    <xsl:param name="validate"/>
    <xsl:variable name="valueOfCell">
      <i18n:number>
        <xsl:value-of select="@Value"/>
      </i18n:number>
    </xsl:variable>
    <xsl:variable name="decimalName">
      <xsl:value-of select="concat(@Name, '_N4')"/>
      <!--xsl:choose>
                <xsl:when test="@Decimals">
                    <xsl:value-of select="concat(@Name, '_N4')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(@Name, '_N0')"/>
                </xsl:otherwise>
            </xsl:choose-->
    </xsl:variable>
    <td align="left" nowrap="yes">
      <xsl:choose>
        <xsl:when test="$validate='yes' and @Required = 'yes' ">
          <input fieldtype="text" name="{$decimalName}" value="{$valueOfCell}" required="true" tabIndex="" onkeyup="javascript:onlyValidCharacters(/[0123456789.,\u0020\u00A0]/)" type="field" class="inputfieldIE" size="10" maxlength="{@MaxLength}"/>
        </xsl:when>
        <xsl:otherwise>
          <input fieldtype="text" name="{$decimalName}" value="{$valueOfCell}" tabIndex="" onkeyup="javascript:onlyValidCharacters(/[0123456789.,\u0020\u00A0]/)" type="field" class="inputfieldIE" size="10" maxlength="{@MaxLength}"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$validate='yes' and @Required = 'yes' ">
        <xsl:call-template name="display_alert_image">
          <xsl:with-param name="fieldName" select="$decimalName"/>
        </xsl:call-template>
      </xsl:if>
    </td>
  </xsl:template>
  <!-- Inline Editable - Number -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Number') and (@Editable = 'Inline')]" mode="content">
    <xsl:param name="validate"/>
    <!-- Nikhil on Feb 16, 2004: Making the value displayed i18n compliant -->
    <xsl:variable name="valueOfCell">
      <xsl:call-template name="i18nize">
        <xsl:with-param name="pData" select="@Value"/>
        <xsl:with-param name="pNoData" select="' '"/>
        <xsl:with-param name="pType" select="@Type"/>
        <xsl:with-param name="pFormat" select="@Format"/>
        <xsl:with-param name="pDecimals" select="@Decimals"/>
      </xsl:call-template>
    </xsl:variable>
    <td align="left" nowrap="yes">
      <xsl:choose>
        <xsl:when test="$validate='yes' and @Required = 'yes' ">
          <!-- BEGIN:  Changes by Nitin Goel to support inline editing -->
          <!--
          <input fieldtype="text" name="{@Name}" value="{@Value}" required="true" tabIndex="" onkeyup="javascript:onlyInteger();" type="field" class="inputfieldIE" size="10" style=" display:none"/>
          <input fieldtype="text" name="{@Name}_old" value="{@Value}" required="true" tabIndex="" type="field" class="inputfieldIE" size="10" style="border:none; background-color:transparent" readonly="readonly"/>
-->
          <input fieldtype="text" name="{@Name}" value="{$valueOfCell}" required="true" tabIndex="" onkeyup="javascript:onlyInteger();" type="field" class="inputfieldIE" size="18" style="display:none"/>
          <input fieldtype="text" name="{@Name}_old" value="{$valueOfCell}" required="true" tabIndex="" type="field" class="inputfieldIE" size="18" style="border:none; background-color:transparent" readonly="readonly"/>
        </xsl:when>
        <xsl:otherwise>
          <!--
          <input fieldtype="text" name="{@Name}" value="{@Value}" tabIndex="" onkeyup="javascript:onlyInteger();" type="field" class="inputfieldIE" size="10" style=" display:none"/>
          <input fieldtype="text" name="{@Name}_old" value="{@Value}" tabIndex="" type="field" class="inputfieldIE" size="10" style="border:none; background-color:transparent" readonly="readonly"/>
-->
          <input fieldtype="text" name="{@Name}" value="{$valueOfCell}" tabIndex="" onkeyup="javascript:onlyInteger();" type="field" class="inputfieldIE" size="18" style=" display:none"/>
          <input fieldtype="text" name="{@Name}_old" value="{$valueOfCell}" tabIndex="" type="field" class="inputfieldIE" size="18" style="border:none; background-color:transparent" readonly="readonly"/>
          <!-- END:  Changes by Nitin Goel to support inline editing -->
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$validate='yes' and @Required = 'yes' ">
        <xsl:call-template name="display_alert_image">
          <xsl:with-param name="fieldName" select="@Name"/>
        </xsl:call-template>
      </xsl:if>
    </td>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Text') and (@Editable) and (../@Filter)]" mode="content">
    <xsl:param name="formName"/>
    <xsl:variable name="quote">'</xsl:variable>
    <xsl:variable name="searchtooltip">
      <i18n:text>Search</i18n:text>
    </xsl:variable>
    <xsl:variable name="clearfilter_tooltip">
      <i18n:text>Clear Filter</i18n:text>
    </xsl:variable>
    <td align="left" nowrap="yes" style="padding:3px;">
      <table>
        <tr>
          <td align="bottom" nowrap="yes" style="padding:0px;">
            <xsl:if test="@Filter='yes'">
              <xsl:variable name="elementName">
                <xsl:value-of select="@Name"/>
              </xsl:variable>
              <!--[Nitin Goel: for safety stock review-->
              <xsl:choose>
                <xsl:when test="@Size">
                  <xsl:choose>
                    <xsl:when test=" string-length(./@Value) > 0">
                      <A HREF="javascript:clearMe(document.forms.{$formName},  '{$elementName}');">
                        <i2:img src="/clearfilter.gif" border="0" width="16" height="16" align="bottom" alt="{$clearfilter_tooltip}"/>
                      </A>
                      <input fieldtype="text" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="{@Size}"/>
                    </xsl:when>
                    <xsl:when test=" string-length(./@Value)= 0">
                      <!--i2:img src="/clearfilter_disabled.gif" border="0" width="16" height="16" align="bottom" alt="Clear Filter"/-->
                      <input fieldtype="text" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="{@Size}"/>
                    </xsl:when>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test=" string-length(./@Value) > 0">
                      <A HREF="javascript:clearMe(document.forms.{$formName},  '{$elementName}');">
                        <i2:img src="/clearfilter.gif" border="0" width="16" height="16" align="bottom" alt="{$clearfilter_tooltip}"/>
                      </A>
                      <input fieldtype="text" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="8"/>
                    </xsl:when>
                    <xsl:when test=" string-length(./@Value)= 0">
                      <!--i2:img src="/clearfilter_disabled.gif" border="0" width="16" height="16" align="bottom" alt="Clear Filter"/-->
                      <input fieldtype="text" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="8"/>
                    </xsl:when>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
              <!--A HREF="javascript:dispatchSearch();">
                <i2:img src="/srch_actv.gif" border="0" width="16" height="16" align="bottom" alt="{$searchtooltip}"/>
              </A-->
              <!--  //]Nitin Goel -->
            </xsl:if>
          </td>
        </tr>
      </table>
    </td>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Number') and (@Editable) and (../@Filter)]" mode="content">
    <td align="left" nowrap="yes">
      <xsl:if test="@Filter='yes'">
        <input fieldtype="text" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="8"/>
      </xsl:if>
    </td>
  </xsl:template>
  <!-- Editable - Hidden -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Hidden' or @Type = 'None') and (@Editable)]" mode="content">
    <input name="{@Name}" value="{@Value}" type="hidden"/>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Hidden') and (@Header)]" mode="content">
    <input name="{@Name}" value="{@Value}" type="hidden"/>
  </xsl:template>
  <!-- Editable - Select -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Select') and (@Editable)]" mode="content">
    <td nowrap="yes" align="left" style="padding:3px;">
      <select class="pulldown" name="{@Name}" onchange="{@OnChange}">
        <xsl:if test=" @Disabled='yes' ">
          <xsl:attribute name="disabled">yes</xsl:attribute>
        </xsl:if>
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
  <xsl:template match="TD[ (@Type = 'Select') and (@Filter = 'yes')]" mode="content">
    <xsl:param name="formName"/>
    <xsl:variable name="searchtooltip">
      <i18n:text>Search</i18n:text>
    </xsl:variable>
    <xsl:variable name="clearfilter_tooltip">
      <i18n:text>Clear Filter</i18n:text>
    </xsl:variable>
    <td nowrap="yes" align="left" style="padding:3px;">
      <Table border="0">
        <tr>
          <td style="padding:0px;">
            <xsl:if test=" string-length(./@Value) > 0">
              <A HREF="javascript:clearNumberFields(document.forms.{$formName},  '{@Name}' , '' );">
                <i2:img src="/clearfilter.gif" border="0" width="16" height="16" align="bottom" alt="{$clearfilter_tooltip}"/>
              </A>
            </xsl:if>
            <select class="pulldown" name="{@Name}" onchange="{@OnChange}">
              <xsl:if test=" @Disabled='yes' ">
                <xsl:attribute name="disabled">yes</xsl:attribute>
              </xsl:if>
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
    <xsl:param name="noOfRows"/>
    <xsl:param name="formName"/>
    <xsl:param name="rowNo"/>
    <xsl:param name="validate"/>
    <xsl:variable name="value">
      <i18n:date format="common">
        <xsl:value-of select="@Value"/>
      </i18n:date>
    </xsl:variable>
    <xsl:variable name="dateName">
      <xsl:choose>
        <xsl:when test="contains(@Name , '.')">
          <xsl:value-of select="concat(substring-before(@Name,'.'), '_', substring-after(@Name, '.'), '_', $rowNo, '_DC')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(@Name , '_' , $rowNo, '_DC')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <td align="left" nowrap="yes">
      <!-- input field -->
      <xsl:choose>
        <xsl:when test="$validate='yes' and @Required = 'yes' ">
          <input fieldtype="text" name="{$dateName}" required="true" value="{$value}" type="field" class="inputfieldIE" size="10"/>&#xA0;
        </xsl:when>
        <xsl:otherwise>
          <input fieldtype="text" name="{$dateName}" value="{$value}" type="field" class="inputfieldIE" size="10"/>&#xA0;
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <!-- If there > 1 rows -->
        <xsl:when test="$noOfRows > 1">
          <A HREF="javascript:setDateField(document.{$formName}.{$dateName});" onclick="setDateField(document.{$formName}.{$dateName});">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/>
          </A>
        </xsl:when>
        <!-- If 1 row -->
        <xsl:otherwise>
          <A HREF="javascript:doNothing()" onclick="setDateField(document.{$formName}.{$dateName});">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/>
          </A>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$validate='yes' and @Required = 'yes' ">
        <xsl:call-template name="display_alert_image">
          <xsl:with-param name="fieldName" select="$dateName"/>
        </xsl:call-template>
      </xsl:if>
      <!-- Calendar - End. -->
    </td>
  </xsl:template>
  <xsl:template match="TD[@Sequence = '-100' and not(@Type)]" mode="content">
    <td nowrap="yes" class="checkboxColumn" id="_rowselector_filter"/>
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
    <xsl:param name="noOfColumns"/>
    <xsl:param name="noOfRows"/>
    <xsl:param name="totalRecordCount"/>
    <xsl:param name="startAtRow"/>
    <xsl:param name="maxRows"/>
    <xsl:if test="count(BUTTONS) > 0 or count(PAGINATION) > 0">
      <!--  Footer -->
      <!--i2:footer-->
      <i2:container id="button_container" scrollable="yes" editable="no">
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
          <tr>
            <!-- Pagination -->
            <td>
              <xsl:apply-templates select="PAGINATION">
                <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
                <xsl:with-param name="noOfRows" select="$noOfRows"/>
                <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                <xsl:with-param name="startAtRow" select="$startAtRow"/>
                <xsl:with-param name="maxRows" select="$maxRows"/>
                <xsl:with-param name="formName" select="$formName"/>
              </xsl:apply-templates>
            </td>
            <!-- Buttons  -->
            <td align="right">
              <xsl:apply-templates select="BUTTONS">
                <xsl:with-param name="noOfRows" select="$totalRecordCount"/>
              </xsl:apply-templates>
            </td>
          </tr>
          <!-- Hidden fields for pagination -->
          <xsl:if test="count(PAGINATION) > 0 ">
            <input type="hidden" name="RECORD_COUNT" value="{$totalRecordCount}"/>
            <input type="hidden" name="START_COUNT" value="{$startAtRow}"/>
            <input type="hidden" name="MAX_ROWS" value="{$maxRows}"/>
          </xsl:if>
        </table>
        <!--/i2:footer-->
      </i2:container>
    </xsl:if>
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
    <xsl:param name="noOfRows"/>
    <xsl:param name="formName"/>
    <xsl:param name="rowNo"/>
    <xsl:param name="validate"/>
    <!--xsl:variable name="value">
    <i18n:date format="common"><xsl:value-of select="@Value"/></i18n:date>
  </xsl:variable-->
    <xsl:variable name="searchtooltip">
      <i18n:text>Search</i18n:text>
    </xsl:variable>
    <xsl:variable name="clearfilter_tooltip">
      <i18n:text>Clear Filter</i18n:text>
    </xsl:variable>
    <xsl:variable name="quote">'</xsl:variable>
    <td align="center" nowrap="yes">
      <table>
        <tr>
          <td align="bottom" nowrap="yes">
            <xsl:variable name="dateName">
              <xsl:choose>
                <xsl:when test="contains(@Name , '.')">
                  <xsl:value-of select="concat(substring-before(@Name,'.'), '_', substring-after(@Name, '.'))"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@Name"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:variable name="date1" select="concat($dateName , '_DS')"/>
            <xsl:variable name="date2" select="concat($dateName , '_DE')"/>
            <xsl:variable name="i18ndate1">
              <i18n:date>
                <xsl:value-of select="/RESPONSES/RESPONSE/*[name() = $date1 ]/@Value"/>
              </i18n:date>
            </xsl:variable>
            <xsl:variable name="i18ndate2">
              <i18n:date>
                <xsl:value-of select="/RESPONSES/RESPONSE/*[name() = $date2 ]/@Value"/>
              </i18n:date>
            </xsl:variable>
            <xsl:variable name="elementName1" select="concat($date1,'_DC')"/>
            <xsl:variable name="elementName2" select="concat($date2,'_DC')"/>
            <xsl:choose>
              <xsl:when test="string-length(/RESPONSES/RESPONSE/*[name() = $date1 ]/@Value) > 0">
                <A HREF="{concat('javascript:clearDateFields(document.forms.', $formName, '.' , $date1 , '_DC' , '.value=', $quote , $quote , ');javascript:clearDateFields(document.forms.', $formName, '.' , $date2 , '_DC' , '.value=', $quote , $quote , ');javascript:dispatchSearch();')}">
                  <i2:img src="/clearfilter.gif" border="0" width="16" height="16" align="bottom" alt="{$clearfilter_tooltip}"/>
                </A>
              </xsl:when>
              <!--xsl:when test="string-length(/RESPONSES/RESPONSE/*[name() = $date1 ]/@Value) = 0">
                <i2:img src="/clearfilter_disabled.gif" border="0" width="16" height="16" align="bottom" alt="Clear Filter"/>
              </xsl:when-->
              <xsl:otherwise/>
            </xsl:choose>
            <!-- start date input field -->
            <input fieldtype="text" name="{$dateName}_DS_DC" value="{$i18ndate1}" type="field" class="inputfieldIE" size="10"/>
            <!--A HREF="javascript:setDateField(document.{$formName}.{@Name}_DS);" onclick="setDateField(document.{$formName}.{@Name}_DS);"-->
            <A HREF="javascript:doNothing()" onclick="showCalendar(document.{$formName}.{$dateName}_DS_DC);">
              <i2:img src="/cal_icon.gif" border="0" align="bottom"/>
            </A>
            <!-- end date input field -->
            <input fieldtype="text" name="{$dateName}_DE_DC" value="{$i18ndate2}" type="field" class="inputfieldIE" size="10"/>
            <A HREF="javascript:doNothing()" onclick="showCalendar(document.{$formName}.{$dateName}_DE_DC);">
              <i2:img src="/cal_icon.gif" border="0" align="bottom"/>
            </A>
            <!--A HREF="javascript:dispatchSearch();">
              <i2:img src="/srch_actv.gif" border="0" width="16" height="16" align="bottom" alt="{$searchtooltip}"/>
            </A-->
          </td>
        </tr>
      </table>
      <!-- Calendar - End. -->
    </td>
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="TD[(@Type = 'NumberFilter')  and (@Filter = 'yes')]" mode="content">
    <xsl:param name="noOfRows"/>
    <xsl:param name="formName"/>
    <xsl:param name="rowNo"/>
    <xsl:param name="validate"/>
    <xsl:variable name="searchtooltip">
      <i18n:text>Search</i18n:text>
    </xsl:variable>
    <xsl:variable name="clearfilter_tooltip">
      <i18n:text>Clear Filter</i18n:text>
    </xsl:variable>
    <xsl:variable name="quote">'</xsl:variable>
    <xsl:variable name="elementName">
      <xsl:value-of select="@Name"/>
    </xsl:variable>
    <xsl:variable name="elementName1" select="concat($elementName,'_OPERATOR')"/>
    <xsl:variable name="name" select=" concat(@Name, '_OPERATOR') "/>
    <xsl:variable name="operatorValue" select="/RESPONSES/RESPONSE/*[name() = $name]/@Value"/>
    <td align="bottom" nowrap="yes">
      <table>
        <tr>
          <td>
            <xsl:choose>
              <xsl:when test=" string-length(./@Value) > 0">
                <A HREF="javascript:clearNumberFields(document.forms.{$formName},  ' {$elementName}','{$elementName1}' );">
                  <i2:img src="/clearfilter.gif" border="0" width="16" height="16" align="bottom" alt="{$clearfilter_tooltip}"/>
                </A>
              </xsl:when>
              <!--xsl:when test=" string-length(./@Value)= 0">
                <i2:img src="/clearfilter_disabled.gif" border="0" width="16" height="16" align="bottom" alt="Clear Filter"/>
              </xsl:when-->
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
          <td>
            <input fieldtype="text" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="8"/>
            <!--A HREF="javascript:dispatchSearch();">
              <i2:img src="/srch_actv.gif" border="0" width="16" height="16" align="bottom" alt="{$searchtooltip}"/>
            </A-->
          </td>
        </tr>
      </table>
    </td>
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
  <!-- Field - CheckBox2 editable -->
  <xsl:template match="TD[@Type = 'CheckBox2']" mode="content">
    <xsl:param name="header" select="../@Header"/>
    <xsl:param name="formName"/>
    <xsl:param name="onclick"/>
    <xsl:param name="onmouseover"/>
    <xsl:param name="target"/>
    <xsl:variable name="onclick">
      <!--xsl:choose>
        <xsl:when test="@OnClick">
          <xsl:value-of select="@OnClick"/>
        </xsl:when>
        <xsl:when test="$header = 'yes'">
          <xsl:variable name="quote">'</xsl:variable>
          <xsl:variable name="currentTDPosition">
            <xsl:value-of select="position()"/>
          </xsl:variable>
          <xsl:variable name="controlledCheckBoxName">
            <xsl:value-of select="../../TR[position() != 1]/TD[position() = $currentTDPosition]/@Name"/>
          </xsl:variable>
          <xsl:value-of select="concat('javascript:toggleCheckboxes(document.forms.', $formName, ',' , 'document.forms.', $formName, '.', $controlledCheckBoxName, ',document.forms.', $formName, '.', @Name, ')' )"/>
        </xsl:when>
      </xsl:choose-->
    </xsl:variable>
    <!-- Todo use class="checkboxColumn" only if first column -->
    <td nowrap="yes" align="center">
      <input type="checkbox" name="{@Name}" value="{@Value}" onclick="{$onclick}">
        <xsl:if test="@Value = 'checked'">
          <xsl:attribute name="checked">true</xsl:attribute>
        </xsl:if>
        <xsl:if test="./@Disabled = 'true'">
          <xsl:attribute name="disabled">yes</xsl:attribute>
        </xsl:if>
      </input>
    </td>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
</xsl:stylesheet>

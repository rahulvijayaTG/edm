<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:import href="page.xsl"/>
  <xsl:import href="page_header.xsl"/>
  <xsl:import href="form.xsl"/>
  <xsl:import href="grid.xsl"/>
  <xsl:import href="search.xsl"/>
  <xsl:import href="container.xsl"/>
  <xsl:import href="wizard.xsl"/>
  <xsl:import href="tabs.xsl"/>
  <xsl:import href="step.xsl"/>
  <xsl:import href="table.xsl"/>
  <xsl:import href="fields.xsl"/>

  <xsl:import href="links.xsl"/>

  <xsl:import href="header.xsl"/>
  <xsl:import href="footer.xsl"/>

  <xsl:import href="buttons.xsl"/>

  <xsl:import href="validation.xsl"/>
  <xsl:import href="error.xsl"/>

  <xsl:import href="chart.xsl"/>

  <xsl:import href="pivot.xsl"/>
  <xsl:import href="excel_pivot.xsl"/>
  <xsl:import href="horizontalTree.xsl"/>
  <xsl:import href="verticalTree.xsl"/>
  <xsl:import href="workbook.xsl"/>
  <xsl:import href="repeator.xsl"/>

  <!--xsl:import href="keyTapping.xsl"/-->

  <xsl:output method="html" encoding="utf-8"/>

  <xsl:variable name="target"/>

  <!-- Page Content -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:call-template name="include_javascript_for_scrolling"/>
    <!--xsl:call-template name="include_javascript_key_tapping"/-->
    <xsl:apply-templates select="RESPONSE" mode="top"/>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="top">
    <form enctype="{@enctype}" name="{@formName}" method="POST" action="{@action}">
    <xsl:if test="@sysid">
      <input type="hidden" name="SAVE_PARAMS" value="{@saveParams}"/>
      <input type="hidden" name="SYS_ID" value="{@sysid}"/>
    </xsl:if>
      <xsl:apply-templates select="CONTAINER|GRID|REPORT|script" mode="top"/>
      <xsl:call-template name="layout_hidden_fields"/>
    </form>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="script" mode="top">
      <xsl:apply-templates select="."/>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="script" mode="layout">
    <xsl:apply-templates select="."/>
  </xsl:template>

  <!--  Horizontal Ruler -->
  <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template match="HORIZONTAL_RULER " mode="layout">
     <hr></hr>
   </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FREEZE_TABLE" mode="layout">

    <xsl:variable name="noOfColsToFreeze" select="@FreezeCols"/>
    <xsl:variable name="totalNoOfCols" select="count(TABLE/TR[@Header = 'yes']/T_FIELD_HR) + count(TABLE/TR[@Header = 'yes']/ROW_SELECTOR)"/>

    <xsl:variable name="checkboxName" select="TABLE/TR[not(@Header)]/ROW_SELECTOR/@Name"/>
    <xsl:variable name="formName" select="'form'"/>
    <xsl:variable name="allowExpInFilter" select="TABLE/@AllowExpressionInFilter"/>

    <table cellspacing="0" cellpadding="0" border="0">
      <xsl:attribute name="width">
        <xsl:choose>
          <xsl:when test="string-length(TABLE/@Width) &gt; 0">
            <xsl:value-of select="TABLE/@Width"/>
          </xsl:when>
          <xsl:otherwise>100%</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <tr>
        <td>
    <!-- Freeze Tables Container -->
    <i2:container id = "{TABLE/@containerId}" inner="yes" scrollable="yes" collapsable="{@Collapsable}">

      <!-- Title -->
      <i2:attribute name="title">
        <xsl:apply-templates select="TABLE" mode="title"/>
      </i2:attribute>

      <!-- Header -->
      <xsl:apply-templates select="TABLE" mode="header">
        <xsl:with-param name="tableId" select="TABLE/@Id"/>
      </xsl:apply-templates>

      <xsl:apply-templates select="TABLE/VALIDATION" mode="validation_area"/>

      <!-- Tables -->
      <xsl:if test="TABLE/@NoOfRows > 0">

        <xsl:choose>
          <xsl:when test="$totalNoOfCols > $noOfColsToFreeze">
            <table width="100%" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top">
                  <!-- Slave (frozen) Table -->
                  <i2:table id="{TABLE/@Id}" scrollablerows="hidden" scrollablecolumns="yes">
                    <!-- Header Row -->
                    <xsl:for-each select="TABLE/TR[@Header]">
                      <i2:tr header="yes">
                        <xsl:apply-templates select="ROW_SELECTOR" mode="content"/>

                        <xsl:apply-templates select="T_FIELD_HR[position() &lt; $noOfColsToFreeze + 1]" mode="content">
                          <xsl:with-param name="header" select="'yes'"/>
                        </xsl:apply-templates>
                      </i2:tr>
                    </xsl:for-each>
                    <!-- Filter Row -->
                    <xsl:for-each select="TABLE/FILTER_ROW">
                      <i2:tr>
                        <xsl:apply-templates select="ROW_SELECTOR" mode="content"/>
                        <xsl:apply-templates select="*[position() &lt; $noOfColsToFreeze + 1]" mode="filter_column">
                          <xsl:with-param name="formName" select="$formName"/>
                          <xsl:with-param name="allowExpression" select="$allowExpInFilter"/>
                        </xsl:apply-templates>
                      </i2:tr>
                    </xsl:for-each>
                    <!-- Mass Entry Row -->
                    <xsl:for-each select="TABLE/MASS_ENTRY_ROW">
                      <i2:tr>
                        <xsl:apply-templates select="*[position() &lt; $noOfColsToFreeze + 2]" mode="mass_entry_row">
                          <xsl:with-param name="formName" select="$formName"/>
                          <xsl:with-param name="checkboxName" select="$checkboxName"/>
                        </xsl:apply-templates>
                      </i2:tr>
                    </xsl:for-each>
                    <!-- All Rows -->
                    <xsl:for-each select="TABLE/TR[not(@Header)]">
                      <i2:tr>
                        <xsl:apply-templates select="ROW_SELECTOR" mode="content"/>
                        <xsl:for-each select="*[(name() != 'T_FIELD_HIDDEN') and (name() != 'ROW_SELECTOR') and (name() != '_ERRORS')]">
                          <xsl:if test="position() &lt; $noOfColsToFreeze + 1">
                            <xsl:apply-templates select="." mode="content">
                              <xsl:with-param name="inTable" select="true()"/>
                            </xsl:apply-templates>
                          </xsl:if>
                        </xsl:for-each>
                      </i2:tr>
                    </xsl:for-each>
                  </i2:table>
                  <!-- Header Hidden Fields -->
                  <xsl:apply-templates select="TABLE/TR[@Header = 'yes']/T_FIELD_HIDDEN" mode="content"/>
                </td>
                <td valign="top" width="100%">
                  <!-- Master (scrollable) Table -->
                  <i2:table id="freeze_syncmaster" scrollablerows="yes" scrollablecolumns="yes" scrollablesyncedtable="{TABLE/@Id}">
                    <!-- Header Row -->
                    <xsl:for-each select="TABLE/TR[@Header]">
                      <i2:tr header="yes">
                        <xsl:apply-templates select="T_FIELD_HR[position() &gt; $noOfColsToFreeze]" mode="content">
                          <xsl:with-param name="header" select="'yes'"/>
                        </xsl:apply-templates>
                      </i2:tr>
                    </xsl:for-each>
                    <!-- Filter Row -->
                    <xsl:for-each select="TABLE/FILTER_ROW">
                      <i2:tr>
                        <xsl:apply-templates select="*[position() &gt; $noOfColsToFreeze]" mode="filter_column">
                          <xsl:with-param name="formName" select="$formName"/>
                          <xsl:with-param name="allowExpression" select="$allowExpInFilter"/>
                        </xsl:apply-templates>
                      </i2:tr>
                    </xsl:for-each>
                    <!-- Mass Entry Row -->
                    <xsl:for-each select="TABLE/MASS_ENTRY_ROW">
                      <i2:tr>
                        <xsl:apply-templates select="*[position() &gt; $noOfColsToFreeze + 1]" mode="mass_entry_row">
                          <xsl:with-param name="formName" select="$formName"/>
                          <xsl:with-param name="checkboxName" select="$checkboxName"/>
                        </xsl:apply-templates>
                      </i2:tr>
                    </xsl:for-each>
                    <!-- All Rows -->
                    <xsl:for-each select="TABLE/TR[not(@Header)]">
                      <i2:tr>
                        <xsl:for-each select="*[(name() != 'T_FIELD_HIDDEN') and (name() != 'ROW_SELECTOR') and (name() != '_ERRORS')]">
                          <xsl:if test="position() &gt; $noOfColsToFreeze">
                            <xsl:apply-templates select="." mode="content">
                              <xsl:with-param name="inTable" select="true()"/>
                            </xsl:apply-templates>
                          </xsl:if>
                        </xsl:for-each>
                      </i2:tr>
                    </xsl:for-each>
                  </i2:table>
                  <!-- Row Hidden Fields -->
                  <xsl:apply-templates select="TABLE/TR[not(@Header)]/T_FIELD_HIDDEN" mode="content"/>
                </td>
              </tr>
            </table>
          </xsl:when>
          <xsl:otherwise>
            <table width="100%" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top">
                  <i2:table>
                    <!-- Header Row -->
                    <xsl:for-each select="TABLE/TR[@Header]">
                      <i2:tr header="yes">
                        <xsl:apply-templates select="ROW_SELECTOR" mode="content"/>
                        <xsl:apply-templates select="T_FIELD_HR" mode="content">
                          <xsl:with-param name="header" select="'yes'"/>
                        </xsl:apply-templates>
                      </i2:tr>
                    </xsl:for-each>
                    <!-- Filter Row -->
                    <xsl:for-each select="TABLE/FILTER_ROW">
                      <i2:tr>
                        <xsl:apply-templates select="*" mode="filter_column">
                          <xsl:with-param name="formName" select="$formName"/>
                          <xsl:with-param name="allowExpression" select="$allowExpInFilter"/>
                        </xsl:apply-templates>
                      </i2:tr>
                    </xsl:for-each>
                    <!-- Mass Entry Row -->
                    <xsl:for-each select="TABLE/MASS_ENTRY_ROW">
                      <i2:tr>
                        <xsl:apply-templates select="*" mode="mass_entry_row">
                          <xsl:with-param name="formName" select="$formName"/>
                          <xsl:with-param name="checkboxName" select="$checkboxName"/>
                        </xsl:apply-templates>
                      </i2:tr>
                    </xsl:for-each>
                    <!-- All Rows -->
                    <xsl:for-each select="TABLE/TR[not(@Header)]">
                      <i2:tr>
                        <xsl:apply-templates select="ROW_SELECTOR" mode="content"/>
                        <xsl:for-each select="*[(name() != 'T_FIELD_HIDDEN') and (name() != 'ROW_SELECTOR') and (name() != '_ERRORS')]">
                          <xsl:apply-templates select="." mode="content">
                            <xsl:with-param name="inTable" select="true()"/>
                          </xsl:apply-templates>
                        </xsl:for-each>
                      </i2:tr>
                    </xsl:for-each>
                  </i2:table>
                  <!-- Header Hidden Fields -->
                  <xsl:apply-templates select="TABLE/TR[@Header = 'yes']/T_FIELD_HIDDEN" mode="content"/>
                </td>
              </tr>
            </table>
          </xsl:otherwise>
        </xsl:choose>
        
      </xsl:if>

      <!-- Footer -->
      <xsl:apply-templates select="TABLE" mode="footer"/>

    </i2:container>

    <xsl:apply-templates select="TABLE/script"/>
        </td>
      </tr>
    </table>
    <script>
    var freezeTableId = "<xsl:value-of select="TABLE/@Id"/>";
    </script>
    <script>
    <![CDATA[
    var slave2_width = 300;
    function generatedScrollHelper()
    {
      var totalAvailWidth = document.body.offsetWidth - 40; //scrollbars, frame border and padding width subtracted from the total allowed width
      var totalAvailHeight = document.body.offsetHeight - 240; //scrollbars, header, frame border, tabs and padding height is subtracted

      //i2uiCollapseTreeTable(freezeTableId,10,null,0);
      i2uiResizeScrollableArea(freezeTableId,totalAvailHeight,slave2_width,null,20);

      i2uiResizeScrollableArea('freeze_syncmaster',totalAvailHeight,totalAvailWidth - slave2_width,freezeTableId,56);
      //i2uiManageTreeTableUserFunction = 'handletreeaction';
    }
    ]]>
    </script>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="FREEZE_TABLE[@Draggable = 'true' and @FreezeCols > 1]" mode="layout">

    <xsl:variable name="tableId" select="TABLE/@Id"/>
    <xsl:variable name="idLen" select="string-length($tableId)"/>
    
    <xsl:variable name="noOfColsToFreeze" select="@FreezeCols"/>
    <xsl:variable name="totalNoOfCols" select="count(TABLE/TR[@Header = 'yes']/T_FIELD_HR) + count(TABLE/TR[@Header = 'yes']/ROW_SELECTOR)"/>

    <xsl:variable name="checkboxName" select="'SELECTED_ITEM'"/>
    <xsl:variable name="formName" select="'form'"/>
    <xsl:variable name="allowExpInFilter" select="TABLE/@AllowExpressionInFilter"/>

    <table cellspacing="0" cellpadding="0" border="0">
      <xsl:attribute name="width">
        <xsl:choose>
          <xsl:when test="string-length(TABLE/@Width) &gt; 0">
            <xsl:value-of select="TABLE/@Width"/>
          </xsl:when>
          <xsl:otherwise>100%</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <tr>
        <td>
          <!-- Freeze Tables Container -->
          <i2:container id = "{TABLE/@containerId}" inner="yes" collapsable="{@Collapsable}">

            <!-- Title -->
            <i2:attribute name="title">
              <xsl:apply-templates select="TABLE" mode="title"/>
            </i2:attribute>

            <!-- Header -->
            <xsl:apply-templates select="TABLE" mode="header">
              <xsl:with-param name="tableId" select="TABLE/@Id"/>
            </xsl:apply-templates>

            <xsl:apply-templates select="TABLE/VALIDATION" mode="validation_area"/>

            <!-- Tables -->
            <xsl:if test="TABLE/@NoOfRows > 0">
            
              <xsl:choose>
                <xsl:when test="$totalNoOfCols > $noOfColsToFreeze + 1">
                  <table width="100%" cellspacing="0" cellpadding="0">
                    <tr>
                      <td valign="top">
                        <!-- Slave (frozen) Table -->
                        <i2:table id="{$tableId}" scrollablecolumns="yes" scrollablerows="hidden">
                          <!-- Header Row -->
                          <xsl:for-each select="TABLE/TR[@Header]">
                            <i2:tr header="yes">
                              <xsl:apply-templates select="ROW_SELECTOR" mode="content"/>

                              <xsl:apply-templates select="T_FIELD_HR[position() &lt; $noOfColsToFreeze + 1]" mode="content">
                                <xsl:with-param name="header" select="'yes'"/>
                              </xsl:apply-templates>
                            </i2:tr>
                          </xsl:for-each>
                          <!-- Filter Row -->
                          <xsl:for-each select="TABLE/FILTER_ROW">
                            <i2:tr>
                              <xsl:apply-templates select="ROW_SELECTOR" mode="content"/>
                              <xsl:apply-templates select="*[position() &lt; $noOfColsToFreeze + 1]" mode="filter_column">
                                <xsl:with-param name="formName" select="$formName"/>
                                <xsl:with-param name="allowExpression" select="$allowExpInFilter"/>
                              </xsl:apply-templates>
                            </i2:tr>
                          </xsl:for-each>
                          <!-- Mass Entry Row -->
                          <xsl:for-each select="TABLE/MASS_ENTRY_ROW">
                            <i2:tr>
                              <xsl:apply-templates select="*[position() &lt; $noOfColsToFreeze + 2]" mode="mass_entry_row">
                                <xsl:with-param name="formName" select="$formName"/>
                                <xsl:with-param name="checkboxName" select="$checkboxName"/>
                              </xsl:apply-templates>
                            </i2:tr>
                          </xsl:for-each>
                          <!-- All Rows -->
                          <xsl:for-each select="TABLE/TR[not(@Header)]">
                            <i2:tr>
                              <xsl:apply-templates select="ROW_SELECTOR" mode="content"/>
                              <xsl:for-each select="*[(name() != 'T_FIELD_HIDDEN') and (name() != 'ROW_SELECTOR') and (name() != '_ERRORS')]">
                                <xsl:if test="position() &lt; $noOfColsToFreeze + 1">
                                  <xsl:apply-templates select="." mode="content">
                                    <xsl:with-param name="inTable" select="true()"/>
                                  </xsl:apply-templates>
                                </xsl:if>
                              </xsl:for-each>
                            </i2:tr>
                          </xsl:for-each>
                        </i2:table>
                        <!-- Header Hidden Fields -->
                        <xsl:apply-templates select="TABLE/TR[@Header = 'yes']/T_FIELD_HIDDEN" mode="content"/>
                      </td>
                      <td valign="top">
                        <!-- Drag Table -->
                        <i2:table id="{substring($tableId, 1, $idLen - 1)}" scrollablerows="hidden">
                          <!-- Header Row -->
                          <i2:tr header="yes">
                            <td nowrap="yes" align="center">
                              <i2:img id="TABLERESIZE_slave2_width" src="/slider_icon.gif"/><br/>
                              <xsl:value-of select="TABLE/TR[@Header]/T_FIELD_HR[$noOfColsToFreeze + 1]/@Value"/>
                            </td>
                          </i2:tr>
                          <!-- Filter Row -->
                          <xsl:for-each select="TABLE/FILTER_ROW">
                            <i2:tr>
                              <xsl:apply-templates select="*[$noOfColsToFreeze + 1]" mode="filter_column">
                                <xsl:with-param name="formName" select="$formName"/>
                                <xsl:with-param name="allowExpression" select="$allowExpInFilter"/>
                              </xsl:apply-templates>
                            </i2:tr>
                          </xsl:for-each>
                          <!-- Mass Entry Row -->
                          <xsl:for-each select="TABLE/MASS_ENTRY_ROW">
                            <i2:tr>
                              <xsl:apply-templates select="*[$noOfColsToFreeze + 2]" mode="mass_entry_row">
                                <xsl:with-param name="formName" select="$formName"/>
                                <xsl:with-param name="checkboxName" select="$checkboxName"/>
                              </xsl:apply-templates>
                            </i2:tr>
                          </xsl:for-each>
                          <!-- All Rows -->
                          <xsl:for-each select="TABLE/TR[not(@Header)]">
                            <i2:tr>
                              <xsl:for-each select="*[(name() != 'T_FIELD_HIDDEN') and (name() != 'ROW_SELECTOR') and (name() != '_ERRORS')]">
                                <xsl:if test="position() = $noOfColsToFreeze + 1">
                                  <xsl:apply-templates select="." mode="content">
                                    <xsl:with-param name="inTable" select="true()"/>
                                  </xsl:apply-templates>
                                </xsl:if>
                              </xsl:for-each>
                            </i2:tr>
                          </xsl:for-each>
                        </i2:table>
                      </td>
                      <td valign="top" width="100%">
                        <!-- Master (scrollable) Table -->
                        <i2:table id="resizabledualsyncmaster" scrollablerows="yes" scrollablecolumns="yes" scrollablesyncedtable="{substring($tableId, 1, $idLen - 1)}">
                          <!-- Header Row -->
                          <xsl:for-each select="TABLE/TR[@Header]">
                            <i2:tr header="yes">
                              <xsl:apply-templates select="T_FIELD_HR[position() &gt; $noOfColsToFreeze + 1]" mode="content">
                                <xsl:with-param name="header" select="'yes'"/>
                              </xsl:apply-templates>
                            </i2:tr>
                          </xsl:for-each>
                          <!-- Filter Row -->
                          <xsl:for-each select="TABLE/FILTER_ROW">
                            <i2:tr>
                              <xsl:apply-templates select="*[position() &gt; $noOfColsToFreeze + 1]" mode="filter_column">
                                <xsl:with-param name="formName" select="$formName"/>
                                <xsl:with-param name="allowExpression" select="$allowExpInFilter"/>
                              </xsl:apply-templates>
                            </i2:tr>
                          </xsl:for-each>
                          <!-- Mass Entry Row -->
                          <xsl:for-each select="TABLE/MASS_ENTRY_ROW">
                            <i2:tr>
                              <xsl:apply-templates select="*[position() &gt; $noOfColsToFreeze + 2]" mode="mass_entry_row">
                                <xsl:with-param name="formName" select="$formName"/>
                                <xsl:with-param name="checkboxName" select="$checkboxName"/>
                              </xsl:apply-templates>
                            </i2:tr>
                          </xsl:for-each>
                          <!-- All Rows -->
                          <xsl:for-each select="TABLE/TR[not(@Header)]">
                            <i2:tr>
                              <xsl:for-each select="*[(name() != 'T_FIELD_HIDDEN') and (name() != 'ROW_SELECTOR') and (name() != '_ERRORS')]">
                                <xsl:if test="position() &gt; $noOfColsToFreeze + 1">
                                  <xsl:apply-templates select="." mode="content">
                                    <xsl:with-param name="inTable" select="true()"/>
                                  </xsl:apply-templates>
                                </xsl:if>
                              </xsl:for-each>
                            </i2:tr>
                          </xsl:for-each>
                        </i2:table>
                        <!-- Row Hidden Fields -->
                        <xsl:apply-templates select="TABLE/TR[not(@Header)]/T_FIELD_HIDDEN" mode="content"/>
                      </td>
                    </tr>
                  </table>
                </xsl:when>
                <xsl:otherwise>
                  <table width="100%" cellspacing="0" cellpadding="0">
                    <tr>
                      <td valign="top">
                        <i2:table id="{$tableId}">
                          <!-- Header Row -->
                          <xsl:for-each select="TABLE/TR[@Header]">
                            <i2:tr header="yes">
                              <xsl:apply-templates select="ROW_SELECTOR" mode="content"/>

                              <xsl:apply-templates select="T_FIELD_HR" mode="content">
                                <xsl:with-param name="header" select="'yes'"/>
                              </xsl:apply-templates>
                            </i2:tr>
                          </xsl:for-each>
                          <!-- Filter Row -->
                          <xsl:for-each select="TABLE/FILTER_ROW">
                            <i2:tr>
                              <xsl:apply-templates select="*" mode="filter_column">
                                <xsl:with-param name="formName" select="$formName"/>
                                <xsl:with-param name="allowExpression" select="$allowExpInFilter"/>
                              </xsl:apply-templates>
                            </i2:tr>
                          </xsl:for-each>
                          <!-- Mass Entry Row -->
                          <xsl:for-each select="TABLE/MASS_ENTRY_ROW">
                            <i2:tr>
                              <xsl:apply-templates select="*" mode="mass_entry_row">
                                <xsl:with-param name="formName" select="$formName"/>
                                <xsl:with-param name="checkboxName" select="$checkboxName"/>
                              </xsl:apply-templates>
                            </i2:tr>
                          </xsl:for-each>
                          <!-- All Rows -->
                          <xsl:for-each select="TABLE/TR[not(@Header)]">
                            <i2:tr>
                              <xsl:apply-templates select="ROW_SELECTOR" mode="content"/>
                              <xsl:for-each select="*[(name() != 'T_FIELD_HIDDEN') and (name() != 'ROW_SELECTOR') and (name() != '_ERRORS')]">
                                <xsl:apply-templates select="." mode="content">
                                  <xsl:with-param name="inTable" select="true()"/>
                                </xsl:apply-templates>
                              </xsl:for-each>
                            </i2:tr>
                          </xsl:for-each>
                        </i2:table>
                        <!-- Header Hidden Fields -->
                        <xsl:apply-templates select="TABLE/TR[@Header = 'yes']/T_FIELD_HIDDEN" mode="content"/>
                      </td>
                    </tr>
                  </table>
                </xsl:otherwise>
              </xsl:choose>


            </xsl:if>

            <!-- Footer -->
            <xsl:apply-templates select="TABLE" mode="footer"/>

          </i2:container>

          <xsl:apply-templates select="TABLE/script"/>
        </td>
      </tr>
    </table>
    <script>
    var freezeTableId = "<xsl:value-of select="$tableId"/>";
    var dragTableId = "<xsl:value-of select="substring($tableId, 1, $idLen - 1)"/>";
    </script>
    <script>
    <![CDATA[
    var slave2_width = 250;
    function generatedScrollHelper()
    {
      var totalAvailWidth = document.body.offsetWidth - 30; //scrollbars, frame border and padding width subtracted from the total allowed width
      var totalAvailHeight = document.body.offsetHeight - 240; //scrollbars, header, frame border, tabs and padding height is subtracted
      
      i2uiResizeScrollableArea(freezeTableId,totalAvailHeight,slave2_width);
      i2uiResizeScrollableArea('resizabledualsyncmaster',totalAvailHeight,20,dragTableId,20,slave2_width);

      i2uiResizableSlave('slave2_width','resizabledualsyncmaster',dragTableId,freezeTableId,20);
    }
    ]]>
    </script>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="HORIZONTAL_TABLE" mode="layout">
    <table cellspacing="0" cellpadding="0" border="0">
      <xsl:attribute name="width">
        <xsl:choose>
          <xsl:when test="string-length(TABLE/@Width) &gt; 0">
            <xsl:value-of select="TABLE/@Width"/>
          </xsl:when>
          <xsl:otherwise>100%</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <tr>
        <td>
          <i2:container id="{TABLE/@containerId}" inner="yes" scrollable="{TABLE/@Scrollable}" collapsable="{TABLE/@Collapsable}">

            <!-- Title -->
            <i2:attribute name="title">
              <xsl:apply-templates select="TABLE" mode="title"/>
            </i2:attribute>

            <!-- Header -->
            <xsl:apply-templates select="TABLE" mode="header">
              <xsl:with-param name="tableId" select="TABLE/@containerId"/>
              <xsl:with-param name="horizontal" select="'true'"/>
            </xsl:apply-templates>

            <xsl:apply-templates select="TABLE/VALIDATION" mode="validation_area"/>
            
            <xsl:variable name="hasRowSelector" select="count(TABLE/TR/ROW_SELECTOR)"/>

            <!-- Tables -->
            <xsl:variable name="scrollable" select="TABLE/@Scrollable"/>
            <xsl:if test="TABLE/@NoOfRows > 0">

              <table width="100%" cellspacing="0" cellpadding="0">
                <tr>
                  <td valign="top">
                    <i2:table>
                      <i2:attribute name="id"><xsl:value-of select="concat(TABLE/@containerId,'_syncslave')"/></i2:attribute>
                      <i2:attribute name="scrollablerows">hidden</i2:attribute>
                      
                      <!-- TODO ::  Row Selector :: Need to come up with a column selector -->
                      <xsl:if test="$hasRowSelector > 0">
                        <i2:tr header="yes" class="tableColumnHeadings">
                          <td>&#xA0;</td>
                        </i2:tr>
                      </xsl:if>
                      <xsl:variable name="containerId" select="TABLE/@containerId"/>

                      <xsl:for-each select="TABLE/TR[@Header = 'yes' and count(T_FIELD_HIDDEN) = 0 and count(ROW_SELECTOR) = 0]">
                        <xsl:variable name="rowPos" select="position()"/>
                        <i2:tr class="tableColumnHeadings">
                          <xsl:if test="position() = 1 and $hasRowSelector = 0">
                            <i2:attribute name="header">yes</i2:attribute>
                          </xsl:if>
                          <xsl:for-each select="T_FIELD_HR">
                            <xsl:choose>
                              <xsl:when test="string-length(./@Value) = 0">
                                <xsl:choose>
                                  <xsl:when test="@CollapsableRow='true'">
                                    <xsl:apply-templates select="." mode="content">
                                      <xsl:with-param name="header" select="./@Header"/>
                                      <xsl:with-param name="pos" select="$rowPos"/>
                                      <xsl:with-param name="containerId" select="$containerId"/>
                                    </xsl:apply-templates>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <td>
                                      <xsl:apply-templates select="." mode="decorate_cell">
				        <xsl:with-param name="rowSpan" select="@RowSpan"/>
				        <xsl:with-param name="colSpan" select="@ColSpan"/>
				      </xsl:apply-templates>&#xA0;
                                    </td>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:apply-templates select="." mode="content">
                                  <xsl:with-param name="header" select="./@Header"/>
                                  <xsl:with-param name="pos" select="$rowPos"/>
                                  <xsl:with-param name="containerId" select="$containerId"/>
                                </xsl:apply-templates>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:for-each>
                        </i2:tr>
                      </xsl:for-each>
                    </i2:table>
                    <!-- Header Hidden Fields -->
                    <xsl:apply-templates select="TABLE/TR[@Header = 'yes']/T_FIELD_HIDDEN" mode="content"/>
                  </td>
                  <td valign="top" width="100%">
                    <xsl:variable name="resultRows" select="TABLE/TR[not(@Header)]"/>
                    <i2:table>
                      <i2:attribute name="id"><xsl:value-of select="concat(TABLE/@containerId,'_syncmaster')"/></i2:attribute>
                      <i2:attribute name="scrollablerows">yes</i2:attribute>
                      <i2:attribute name="scrollablecolumns">yes</i2:attribute>
                      <i2:attribute name="scrollablesyncedtable"><xsl:value-of select="concat(TABLE/@containerId,'_syncslave')"/></i2:attribute>

                      <xsl:if test="$hasRowSelector > 0">
                        <i2:tr header="yes" class="tableColumnHeadings">
                          <xsl:for-each select="TABLE/TR[not(@Header) and ROW_SELECTOR]">
                            <td>
                              <xsl:choose>
                                <xsl:when test="ROW_SELECTOR/@Select = 'multi'">
                                  <input type="checkbox" name="{ROW_SELECTOR/@Name}" value="{ROW_SELECTOR/@Value}"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  <input type="radio" name="{ROW_SELECTOR/@Name}" value="{ROW_SELECTOR/@Value}"/>
                                </xsl:otherwise>
                              </xsl:choose>
                            </td>
                          </xsl:for-each>
                        </i2:tr>
                      </xsl:if>

                      <xsl:for-each select="TABLE/TR[@Header = 'yes' and count(T_FIELD_HIDDEN) = 0 and count(ROW_SELECTOR) = 0]">
                        <xsl:variable name="rowname" select="./@Name"/>
                        <i2:tr>
                          <xsl:if test="position() = 1 and $hasRowSelector = 0">
                            <i2:attribute name="header">yes</i2:attribute>
                          </xsl:if>
                          <xsl:apply-templates select="$resultRows/*[@Name = $rowname and name() != 'T_FIELD_HIDDEN']" mode="content">
                            <xsl:with-param name="header" select="@Header"/>
                          </xsl:apply-templates>
                        </i2:tr>
                      </xsl:for-each>
                    </i2:table>
                    <!-- Row Hidden Fields -->
                    <xsl:apply-templates select="$resultRows/*[name() = 'T_FIELD_HIDDEN']" mode="content"/>
                  </td>
                </tr>
              </table>

            </xsl:if>

            <!-- Footer -->
            <xsl:apply-templates select="TABLE" mode="footer"/>

          </i2:container>


          <xsl:apply-templates select="TABLE/script"/>
        </td>
      </tr>

      <!-- Hidden Rows -->
      <xsl:apply-templates select="TABLE" mode="hidden_rows">
      </xsl:apply-templates>
    </table>
    <script>
    var slaveTableId = "<xsl:value-of select="concat(TABLE/@containerId,'_syncslave')"/>";
    var masterTableId = "<xsl:value-of select="concat(TABLE/@containerId,'_syncmaster')"/>";
    </script>
    <script>
    <![CDATA[
    function generatedScrollHelper()
    {
      var totalAvailWidth = document.body.offsetWidth - 30; //scrollbars, frame border and padding width subtracted from the total allowed width
      var totalAvailHeight = document.body.offsetHeight - 220; //scrollbars, header, frame border, tabs and padding height is subtracted
      
      i2uiResizeScrollableArea( masterTableId, totalAvailHeight, 20, slaveTableId, 40 );
    }
    ]]>
    </script>
    <xsl:variable name="containerId" select="TABLE/@containerId"/>
    <!-- MAB: auto-collapsed rows -->
    <xsl:if test="count(TABLE/TR[@Header='yes']/T_FIELD_HR[@CollapsableRow='true' and @Collapsed='true']) > 0">    
    <script language="javascript">
      function autoCollapseRows()
      {
            <xsl:for-each select="TABLE/TR[@Header='yes']">	      
	      <xsl:for-each select="T_FIELD_HR[@CollapsableRow='true' and @Collapsed='true']">                        
	        <xsl:variable name="startRow" select="@CollapseStartRow"/>
		toggleCollapsableRows('<xsl:value-of select="$containerId"/>','<xsl:value-of select="@Id"/>', <xsl:value-of select="$startRow"/>,<xsl:value-of select="@RowCollapseSize"/>)
	      </xsl:for-each>
	    </xsl:for-each>                         
      }
    </script>    
    </xsl:if>
  </xsl:template>

  <!-- **********************************************************************
    *********************************************************************** -->
  <xsl:template match="DYNAMIC_TABLE" mode="layout">
    <xsl:apply-templates  mode="layout"/>
  </xsl:template>

  <!-- **********************************************************************
    *********************************************************************** -->
    <xsl:template name="layout_hidden_fields">
      <input type="hidden" name="BUTTON_ID" value="BUTTON_ID"></input>
      <input type="hidden" name="PAGE_NAME" value="{@name}"></input>
      <input type="hidden" name="SUBMIT_AS_XML" value="false"></input>
      <!-- Used by save search functionality. Need to use either page_name or this one.
    To be decided when doing favorites. -->
       <input type="hidden" name="PAGE" value="{@name}"></input>

    </xsl:template>

  <!-- **********************************************************************
    *********************************************************************** -->
    <xsl:template name="include_javascript_for_scrolling">
      <i2:javascript path="/page.js"></i2:javascript>
    </xsl:template>

  <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template name="include_javascript_onLoad">
     <script>
       <![CDATA[
           i2uiManageTreeTableUserFunction = 'onClickNorgie';
          i2uiToggleContentUserFunction = 'onClickNorgie';

          function onClickNorgie(item, delta)
          {
            onResize();
          }

       function onLoad()
       {
         onLoadSuper();
         scrollHelper();
         autoCollapseRows();
         }
       ]]>
   </script>
   </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
    <xsl:template name="include_javascript_onResize">
      <script>
        function onResize()
        {
        onResizeSuper();
        scrollHelper();
        }
      </script>
    </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match= "/" mode="page_title">
  <xsl:choose>
    <xsl:when test="RESPONSES/RESPONSE/HEADER/BREADCRUMBS/BREADCRUMB">
      <xsl:value-of select="RESPONSES/RESPONSE/HEADER/BREADCRUMBS/BREADCRUMB[position() = last()]/DISPLAY_TEXT/@Value"/>
    </xsl:when>
    <xsl:when test="RESPONSES/RESPONSE/CONTAINER[1]/STEP[1]">
      <xsl:value-of select="RESPONSES/RESPONSE/CONTAINER[1]/STEP[1]/@DisplayText"/>
    </xsl:when>
    <xsl:when test="RESPONSES/RESPONSE/GRID/ROW/CELL/CONTAINER[1]/STEP[1]">
      <xsl:value-of select="RESPONSES/RESPONSE/GRID/ROW/CELL/CONTAINER[1]/STEP[1]/@DisplayText"/>
    </xsl:when>
    <xsl:when test="RESPONSES/RESPONSE/REPORT">
      <xsl:value-of select="RESPONSES/RESPONSE/REPORT[1]/TABLE/@Title"/>
    </xsl:when>
    <xsl:when test="RESPONSES/RESPONSE/GRID/ROW/CELL/SEARCH[1]">
      <xsl:value-of select="RESPONSES/RESPONSE/GRID/ROW/CELL/SEARCH[1]/@DisplayText"/>
    </xsl:when>
    <xsl:when test="RESPONSES/RESPONSE/GRID/ROW/CELL/REPORT[1]">
      <xsl:value-of select="RESPONSES/RESPONSE/GRID/ROW/CELL/REPORT[1]/@DisplayText"/>
    </xsl:when>
    <xsl:otherwise>layout.xsl-NoTitle</xsl:otherwise>
  </xsl:choose>
  </xsl:template>


  <!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

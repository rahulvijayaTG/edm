<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:variable name="noOfPivotTables" select="count(//PIVOT)"/>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="PIVOT" mode="top">
    <xsl:apply-templates select="." mode="layout"/>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="PIVOT" mode="layout">
    <xsl:variable name="noOfColsToFreeze" select="count(TABLE/TR[@Header = 'yes']/T_FIELD_HR[@Axis = 'row' or @Axis = 'data']) + count(TABLE/TR[@Header = 'yes']/ROW_SELECTOR)"/>
    <xsl:variable name="totalNoOfCols" select="count(TABLE/TR[@Header = 'yes']/*)"/>
    <xsl:variable name="totalNoOfColPivots" select="count(TABLE/TR[@Header = 'yes']/PIVOT_FIELDS[1]/PIVOT_FIELD)"/>

    <xsl:variable name="slave2TableId">
     <xsl:choose>    
      <xsl:when test="$noOfPivotTables > 1"><xsl:value-of select="concat(TABLE/@Id,'syncslave2')"/></xsl:when>
      <xsl:otherwise>resizabledualsyncslave2</xsl:otherwise>
     </xsl:choose>
    </xsl:variable>

    <xsl:variable name="slaveTableId">
     <xsl:choose>    
      <xsl:when test="$noOfPivotTables > 1"><xsl:value-of select="concat(TABLE/@Id,'syncslave')"/></xsl:when>
      <xsl:otherwise>resizabledualsyncslave</xsl:otherwise>
     </xsl:choose>
    </xsl:variable>

    <xsl:variable name="slaveDragIconId">
     <xsl:choose>    
      <xsl:when test="$noOfPivotTables > 1"><xsl:value-of select="concat(TABLE/@Id,'_width')"/></xsl:when>
      <xsl:otherwise>slave2_width</xsl:otherwise>
     </xsl:choose>
    </xsl:variable>

    <xsl:variable name="masterTableId">
     <xsl:choose>    
      <xsl:when test="$noOfPivotTables > 1"><xsl:value-of select="concat(TABLE/@Id,'syncmaster')"/></xsl:when>
      <xsl:otherwise>resizabledualsyncmaster</xsl:otherwise>
     </xsl:choose>
    </xsl:variable>

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
					<i2:container id="{TABLE/@containerId}" inner="yes" scrollable="yes" collapsable="{@Collapsable}">

						<!-- Title -->
						<i2:attribute name="title">
							<xsl:apply-templates select="TABLE" mode="title"/>
						</i2:attribute>

						<!-- Header -->
						<xsl:apply-templates select="TABLE" mode="header">
							<xsl:with-param name="tableId" select="TABLE/@Id"/>
							<xsl:with-param name="horizontal" select="'true'"/>
						</xsl:apply-templates>    

						<xsl:apply-templates select="TABLE/VALIDATION" mode="validation_area"/>

						<!-- Tables -->
						<xsl:if test="TABLE/@NoOfRows > 0">

							<table width="100%" cellspacing="0" cellpadding="0">
								<tr>
									<td valign="top">
										<!-- Slave (frozen) Table -->
          <i2:table id="{$slave2TableId}" scrollablecolumns="yes" scrollablerows="hidden" width="{TABLE/@PivotWidth}">
											<!-- Header Row -->
											<xsl:for-each select="TABLE/TR[@Header]">
												<i2:tr header="yes">
													<xsl:apply-templates select="*[position() &lt; $noOfColsToFreeze]" mode="pivot_header">
														<xsl:with-param name="header" select="'yes'"/>
													</xsl:apply-templates>
												</i2:tr>
											</xsl:for-each>
											<!-- All Rows -->
											<xsl:for-each select="TABLE/TR[not(@Header)]">
												<i2:tr>
													<xsl:apply-templates select="*[position() &lt; $noOfColsToFreeze]" mode="content"/>
												</i2:tr>
											</xsl:for-each>
										</i2:table>
									</td>
									<td valign="top">
										<!-- Drag Table -->
          <i2:table id="{$slaveTableId}" scrollablerows="hidden">
											<!-- Header Row -->
											<i2:tr header="yes">
												<td nowrap="yes" align="center">
             <i2:img id="TABLERESIZE_{$slaveDragIconId}" src="/slider_icon.gif"/>
												</td>
											</i2:tr>
											<!-- All Rows -->
											<xsl:for-each select="TABLE/TR[not(@Header)]">
												<i2:tr>
													<xsl:apply-templates select="*[position() = $noOfColsToFreeze]" mode="content"/>
												</i2:tr>
											</xsl:for-each>
										</i2:table>
									</td>
									<td valign="top" width="100%">
										<!-- Master (scrollable) Table -->
          <i2:table id="{$masterTableId}" scrollablerows="yes" scrollablecolumns="yes" scrollablesyncedtable="{$slaveTableId}">
											<xsl:for-each select="TABLE/TR[@Header]">
												<xsl:variable name="colSpan" select="PIVOT_FIELDS/PIVOT_FIELD[1]/@ColSpan"/>
												<i2:tr header="yes">
													<xsl:choose>
														<xsl:when test="$colSpan &gt; 0 and $totalNoOfColPivots &gt; 1">
															<xsl:apply-templates select="PIVOT_FIELDS[(position() mod $colSpan) = 1]/PIVOT_FIELD[1]" mode="content"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:apply-templates select="PIVOT_FIELDS/PIVOT_FIELD[1]" mode="content"/>
														</xsl:otherwise>
													</xsl:choose>
												</i2:tr>
												<xsl:if test="$totalNoOfColPivots = 2">
												<i2:tr header="yes">
													<xsl:apply-templates select="PIVOT_FIELDS/PIVOT_FIELD[2]" mode="content"/>
												</i2:tr>
												</xsl:if>
											</xsl:for-each>
											<!-- All Rows -->
											<xsl:for-each select="TABLE/TR[not(@Header)]">
												<i2:tr>
													<xsl:apply-templates select="*[position() &gt; $noOfColsToFreeze]" mode="content"/>
												</i2:tr>
											</xsl:for-each>
										</i2:table>
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
    </table>
    <script>
    var <xsl:value-of select="$slaveDragIconId"/> = 300;
    var noOfPivots = '<xsl:value-of select="$noOfPivotTables"/>';
    var masterTableId = '<xsl:value-of select="$masterTableId"/>';
    var slave2TableId = '<xsl:value-of select="$slave2TableId"/>';
    var slaveTableId = '<xsl:value-of select="$slaveTableId"/>';
    var slaveDragIconId = '<xsl:value-of select="$slaveDragIconId"/>';
    
    function generatedScrollHelper()
    {
     var totalAvailWidth = document.body.offsetWidth - 30; //scrollbars, frame border and padding width subtracted from the total allowed width
     var totalAvailHeight = document.body.offsetHeight - 220; //scrollbars, header, frame border, tabs and padding height is subtracted

     i2uiResizeScrollableArea(slave2TableId,totalAvailHeight,<xsl:value-of select="$slaveDragIconId"/>);
     i2uiResizeScrollableArea(masterTableId,totalAvailHeight,20,slaveTableId,30,<xsl:value-of select="$slaveDragIconId"/>);

     i2uiResizableSlave(slaveDragIconId,masterTableId,slaveTableId,slave2TableId,30);
    }
    </script>
	</xsl:template>

  <!-- Pivot Field -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="PIVOT_FIELD" mode="content">
    <xsl:param name="rowSpan" select="@RowSpan"/>
    <xsl:param name="colSpan" select="@ColSpan"/>

    <td nowrap="yes" colspan="{$colSpan}" style="{@Style}">
      <xsl:attribute name="align">
        <xsl:choose>
          <xsl:when test="string-length(@Align) > 0"><xsl:value-of select="@Align"/></xsl:when>
          <xsl:otherwise>center</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

			<xsl:choose>
				<xsl:when test="@Selectable = 'All'">
					<input name="{@Name}" value="{@Value}" type="checkbox">
						<xsl:if test="string-length(@OnClick) > 0">
							<xsl:attribute name="onclick"><xsl:value-of select="@OnClick"/></xsl:attribute>
						</xsl:if>
					</input>
				</xsl:when>
				<xsl:when test="@Selectable = 'Single'">
					<input name="{@Name}" value="{@Value}" type="radio">
						<xsl:if test="string-length(@OnClick) > 0">
							<xsl:attribute name="onclick"><xsl:value-of select="@OnClick"/></xsl:attribute>
						</xsl:if>
					</input>
				</xsl:when>
      </xsl:choose>
			
      <xsl:choose>
        <xsl:when test="@HeaderLink">
          <a href="{@HeaderLink}"><xsl:value-of select="@Value"/></a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@Value"/>
        </xsl:otherwise>
      </xsl:choose>
    </td>
  </xsl:template>

  <!-- Pivot Header -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="T_FIELD_HR" mode="pivot_header">
    <xsl:param name="rowSpan" select="@RowSpan"/>
    <xsl:param name="colSpan" select="@ColSpan"/>

    <td nowrap="yes" id="{@Id}">
      <xsl:attribute name="align">
        <xsl:choose>
          <xsl:when test="string-length(@Align) > 0"><xsl:value-of select="@Align"/></xsl:when>
          <xsl:otherwise>left</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="decorate_cell">
        <xsl:with-param name="rowSpan" select="$rowSpan"/>
        <xsl:with-param name="colSpan" select="$colSpan"/>
      </xsl:apply-templates>

      <xsl:choose>
        <xsl:when test="@HeaderLink">
          <a href="{@HeaderLink}"><xsl:value-of select="@Value"/></a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@Value"/>
          <xsl:if test="@Uom and @Value">
            &#xA0;(<xsl:value-of select="@Uom"/>)
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </td>
    
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="ROW_SELECTOR" mode="pivot_header">
    
    <xsl:choose>
      <xsl:when test="@Value or @Name = 'SELECT_ALL'">
        <i2:rowselector checked="{@Checked}" select="{@Select}" name="{@Name}" value="{@Value}" global="{@Header}">
          <xsl:if test="string-length(@RowSpan) > 0">
            <i2:attribute name="rowSpan"><xsl:value-of select="@RowSpan"/></i2:attribute>
          </xsl:if>
          <xsl:if test="string-length(@ColSpan) > 0">
            <i2:attribute name="colSpan"><xsl:value-of select="@ColSpan"/></i2:attribute>
          </xsl:if>
        </i2:rowselector>
      </xsl:when>
      <xsl:when test="@Header and @Select='single'">
        <td nowrap="yes">
          <xsl:apply-templates select="." mode="decorate_cell"/>
          <xsl:value-of select="@DisplayText"/>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <th nowrap="yes" class="tableColumnHeadings"/>
      </xsl:otherwise>
    </xsl:choose>    

  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->

</xsl:stylesheet>

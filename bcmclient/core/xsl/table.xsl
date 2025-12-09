<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
   <xsl:include href="table_field.xsl"/>

  <!-- Table -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match = "TABLE">

    <xsl:variable name="formName">
      <xsl:choose>
        <xsl:when test="string-length(@FormName) > 0">
          <xsl:value-of select="@FormName"/>
        </xsl:when>
        <xsl:otherwise>result_form</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>  
    <xsl:variable name="tableId"><xsl:value-of select="concat($formName,'_table')"/></xsl:variable>  
    <xsl:variable name="tableContainerId"><xsl:value-of select="concat($formName,'_container')"/></xsl:variable>  

    <!-- html form -->    
    <table  width="100%"   cellspacing="0" cellpadding="0" border="0">
      <form name="{$formName}">
        <xsl:attribute name="method">
          <xsl:choose>
            <xsl:when test="@Method">
              <xsl:value-of select="@Method"/>
            </xsl:when>
            <xsl:otherwise>POST</xsl:otherwise>
          </xsl:choose>  
        </xsl:attribute>
        <tr>
          <td>
          
            <!-- Hidden Fields -->
            <xsl:for-each select = "FIELD[@Type='Hidden']">
              <input name="{@Name}" type="hidden" value="{@Value}"/>
            </xsl:for-each>
            <!--
            <xsl:for-each select="TR[@Header = 'yes']/T_FIELD_HN">
              <input name="{@Name}" type="hidden" value="{@Value}"/>
            </xsl:for-each>
         -->
            <!-- Container -->  
            <i2:container id = "{$tableContainerId}" inner="yes" scrollable="yes" collapsable="{@Collapsable}">
              
              <!-- Title -->
              <i2:attribute name="title">
                <xsl:apply-templates select="." mode="title"/> 
              </i2:attribute> 
              
              <!-- Header -->
              <xsl:apply-templates select="." mode="header">
                <xsl:with-param name="tableId" select="$tableId"/>
             </xsl:apply-templates>    
            
              <!-- Table -->
              <xsl:if test="@NoOfRows > 0">
                <i2:table> 
                  <i2:attribute name="id"><xsl:value-of select="$tableId"/></i2:attribute>
                  <xsl:if test="@Scrollable = 'true' or @Scrollable = 'yes'">
                    <i2:attribute name="scrollablerows">yes</i2:attribute> 
                    <i2:attribute name="scrollablecolumns">auto</i2:attribute>
                   
                 </xsl:if>

  
                    <!-- Header Row -->  
                    <xsl:apply-templates select="." mode="header_row">
                      <xsl:with-param name="formName" select="$formName"/>
                      <xsl:with-param name="sortBy" select="@SortBy"/>
                      <xsl:with-param name="sortOrder" select="@SortOrder"/>
                    </xsl:apply-templates>
                    <!-- All Rows -->
                    <xsl:apply-templates select="." mode="rows">
                      <xsl:with-param name="formName" select="$formName"/>
                    </xsl:apply-templates>
                </i2:table> 
              </xsl:if>  
              
              <!-- Footer -->
              <xsl:apply-templates select="." mode="footer"/>
          
            </i2:container> 
            
          </td>
        </tr>
        
        <!-- Hidden Rows -->        
         <xsl:apply-templates select="." mode="hidden_rows">
        </xsl:apply-templates>
      </form>                  
    </table>
      
  </xsl:template>


 
    <!-- Table -->
      <!-- **********************************************************************
      *********************************************************************** -->
      <xsl:template match = "TABLE" mode="no_forms">

        <xsl:variable name="formName">
          <xsl:choose>
            <xsl:when test="string-length(@FormName) > 0">
              <xsl:value-of select="@FormName"/>
            </xsl:when>
            <xsl:otherwise>result_form</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="tableId"><xsl:value-of select="concat($formName,'_table')"/></xsl:variable>
        <xsl:variable name="tableContainerId"><xsl:value-of select="concat($formName,'_container')"/></xsl:variable>

        <!-- html form -->
        <table  width="100%"   cellspacing="0" cellpadding="0" border="0">
            <xsl:attribute name="method">
              <xsl:choose>
                <xsl:when test="@Method">
                  <xsl:value-of select="@Method"/>
                </xsl:when>
                <xsl:otherwise>POST</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
              <tr>
              <td>

                <!-- Hidden Fields -->
                <xsl:for-each select = "FIELD[@Type='Hidden']">
                  <input name="{@Name}" type="hidden" value="{@Value}"/>
                </xsl:for-each>

                <!-- Container -->
                <i2:container id = "{$tableContainerId}" inner="yes" scrollable="yes" collapsable="{@Collapsable}">

                  <!-- Title -->
                  <i2:attribute name="title">
                    <xsl:apply-templates select="." mode="title"/>
                  </i2:attribute>

                  <!-- Header -->
                  <xsl:apply-templates select="." mode="header">
                    <xsl:with-param name="tableId" select="$tableId"/>
                 </xsl:apply-templates>    

                  
                  <!-- Table -->
                  <xsl:if test="@NoOfRows > 0">
                    <i2:table>
                      <i2:attribute name="id"><xsl:value-of select="$tableId"/></i2:attribute>
                      <xsl:if test="@Scrollable = 'yes'">
                        <i2:attribute name="scrollablerows">yes</i2:attribute>
                        <i2:attribute name="scrollablecolumns">auto</i2:attribute></xsl:if>

                        <!-- Header Row -->
                        <xsl:apply-templates select="." mode="header_row">
                          <xsl:with-param name="formName" select="$formName"/>
                          <xsl:with-param name="sortBy" select="@SortBy"/>
                          <xsl:with-param name="sortOrder" select="@SortOrder"/>
                        </xsl:apply-templates>
                        <!-- All Rows -->
                        <xsl:apply-templates select="." mode="rows">
                          <xsl:with-param name="formName" select="$formName"/>
                        </xsl:apply-templates>
                    </i2:table>
                  </xsl:if>

                  <!-- Footer -->
                  <xsl:apply-templates select="." mode="footer"/>

                </i2:container>

              </td>
            </tr>

            <!-- Hidden Rows -->
             <xsl:apply-templates select="." mode="hidden_rows">
            </xsl:apply-templates>
        </table>

      </xsl:template>


  <!-- Table Title -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match= "TABLE" mode="title">
    <b><xsl:apply-templates select="." mode="regular_title"/></b>
    <xsl:apply-templates select="." mode="paging_title"/>
    <xsl:apply-templates select="." mode="no_rows_title"/>
  </xsl:template>


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
  <xsl:template match= "TABLE[(@NoOfRows > 0 ) and (string-length(@PagingTitle)= 0 or @PagingTitle != 'no')]" mode="paging_title">

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
  <xsl:template match= "TABLE[@NoOfRows = 0 and (@DoSearch = 'Yes' or @DoSearch='yes' or @DoSearch='true')]" mode="no_rows_title">
    <xsl:choose>
      <!-- Custom title -->
      <xsl:when test="string-length(@NoRecordsTitle) > 0">
        :&#xA0;<i18n:text><xsl:value-of select="@NoRecordsTitle"/></i18n:text>
      </xsl:when>
      <!-- NO_DOC_TYPE_FOUND -->
      <xsl:when test="string-length(@Document) > 0">
        <i18n:text><xsl:value-of select="concat('NO_',@Document,'_FOUND')"/></i18n:text>
      </xsl:when>
      <!-- No Records Found -->
      <xsl:otherwise>:&#xA0;<i18n:text>No records found</i18n:text>.</xsl:otherwise>                  
    </xsl:choose>                  
  </xsl:template>
  
<!-- Header -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="TABLE" mode="header">
    <xsl:param name="tableId"/>
    <i2:header>
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td align="right">
            <table border="0" cellpadding="0" cellspacing="0" align="right">
              <tr>
                <xsl:if test="@Configurable = 'true' and @NoOfRows > 0">
                  <td>&#xA0;</td>
                  <td>
                    <a class="text" href="javascript:onLink();" onclick="javascript:ui_configureTable('{@ConfigTableId}')">
                      <i2:img src="/cstmz_actv.gif" width="16" height="16" border="0">
                        <i2:attribute name="alt">
                          <i18n:text>Customize Table</i18n:text>
                        </i2:attribute>
                      </i2:img>
                    </a>
                    <script>
                     function ui_configureTable(src)
                     {
                      popUpWindow(omxContextPath + '/core/configure.jsp?TABLE_ID=' + src,'configurePopup');
                     }
                    </script>
                  </td>
                  <td>&#xA0;</td>
                </xsl:if>
  
                <xsl:if test="@Downloadable = 'true' and @NoOfRows > 0">
                  <xsl:call-template name="table_download">  
                      <xsl:with-param name="tableId" select="$tableId"/>
                    </xsl:call-template>
                </xsl:if>
  
                <xsl:apply-templates select="HELP"/>
  
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
    
    <xsl:if test="BUTTONS or PAGINATION">
      <!--  Footer -->
      <i2:footer>
        <table cellspacing="0" cellpadding="0" width="100%"  border="0">
          <tr>  
            <!-- Pagination -->
            <td>
              <xsl:if test="PAGINATION">
                <i2:pagingcontrol currentPage="{ceiling((number(@StartAtRow)+1) div number(@MaxRows))}" recordsPerPage="{number(@MaxRows)}" totalRecords="{number(@TotalRowCount)}"/>
              </xsl:if>
            </td>  
            
            <!-- Buttons  -->
            <td  align="right"> 
              <xsl:apply-templates select="BUTTONS"/>
            </td>  
          </tr>
          
          <!-- Hidden fields for pagination -->
          <xsl:if test="PAGINATION">
            <input type="hidden" name="RECORD_COUNT" value="{number(@TotalRowCount)}"/>
            <input type="hidden" name="START_COUNT" value="{number(@StartAtRow)}"/>
            <input type="hidden" name="MAX_ROWS" value="{number(@MaxRows)}"/>

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

    </xsl:apply-templates>
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

      <i2:tr><xsl:if test="string-length(@Header) > 0"> <i2:attribute name="header">yes</i2:attribute> </xsl:if>
       <xsl:apply-templates select="*" mode="content">
          <xsl:with-param  name="rowNo" select="position()-2"/>  
          <xsl:with-param name="header" select="@Header"/>
          <xsl:with-param  name="noOfRows" select="$noOfRows"/>  
          <xsl:with-param  name="formName" select="$formName"/>  
          <xsl:with-param name="sortBy" select="$sortBy"/>
          <xsl:with-param name="sortOrder" select="$sortOrder"/>
        </xsl:apply-templates>  
      </i2:tr>
  </xsl:template>

  <!-- All Row -->
  <!-- ********************************************************************** 
       *********************************************************************** -->  
  <xsl:template match = "TR[not(@Header)]">
     <xsl:param  name="noOfRows"/>  
     <xsl:param  name="formName"/>  
      <i2:tr>

        <xsl:if test="@Class">
        <i2:attribute name="class">
            <xsl:value-of select="@Class"/>
        </i2:attribute>
        </xsl:if>

       <xsl:apply-templates select="*" mode="content">
          <xsl:with-param  name="rowNo" select="position()-2"/>  
          <xsl:with-param name="header" select="@Header"/>
          <xsl:with-param  name="noOfRows" select="$noOfRows"/>  
          <xsl:with-param  name="formName" select="$formName"/>  
        </xsl:apply-templates>  
      </i2:tr>
  </xsl:template>

  <!-- Hidden Rows -->
  <!-- ********************************************************************** 
     *********************************************************************** -->
  <xsl:template match = "TABLE" mode="hidden_rows">
    <xsl:apply-templates select="TR_HIDDEN">
    </xsl:apply-templates>
    <xsl:if test="@NoOfRows = 0">
      <xsl:apply-templates select="TR[@Header = 'yes']/T_FIELD_HN" mode="content">
      </xsl:apply-templates>
    </xsl:if>

  </xsl:template>

  <!-- ********************************************************************** 
       *********************************************************************** -->  
  <xsl:template match = "TR_HIDDEN"> 
    <xsl:apply-templates select="T_FIELD_HN" mode="content">
    </xsl:apply-templates>  
  </xsl:template>
  
  <!-- ********************************************************************** 
       *********************************************************************** -->  
  <xsl:template name = "table_download"> 
    <xsl:param name="tableId"/>
  
                  <td>&#xA0;</td>
                  <td>
                    <input type="hidden" name="CORE_SAVE_REPORT"/>
                    <a class="text" href="javascript:onLink();" onclick="javascript:ui_extractTable('{$tableId}')">
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

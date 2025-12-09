<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../../queryform/xsl/searchformfilter.xsl"/>
  <xsl:output method="html"/>
<!--****************************************************************
  ********************************************************************--> 
 <xsl:template match="RESPONSES" mode="content">
    <xsl:if test="count(RESPONSE/HEADER_CONTEXT/*) > 0 ">
      <xsl:apply-templates select="RESPONSE/HEADER_CONTEXT"/>
    </xsl:if>
  <!--****************************************************************
  ********************************************************************-->
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <table>
      <tr>
        <td>
         &#xA0;&#xA0;
       </td>
      </tr>
    </table>
    <xsl:call-template name="include_javascript_table"/>
    <xsl:call-template name="include_javascript_table_resize"/> 
  </xsl:template>
  <!--****************************************************************
  ********************************************************************-->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <table id="resource_table" width="100%">
      <xsl:if test="count(SUCCESS_MESSAGE) &gt; 0">
        <tr>
          <td>
            <!-- Location save success message -->
            <xsl:apply-templates select="SUCCESS_MESSAGE"/>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="count(ERROR_MESSAGE) &gt; 0">
        <tr>
          <td>
            <!-- Location save error message -->
            <xsl:apply-templates select="ERROR_MESSAGE"/>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td>
          <!-- Location search -->
          <xsl:apply-templates select="SEARCH">
            <xsl:with-param name="formName" select="'result_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!--****************************************************************
  ********************************************************************-->
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
    <i2:img src="/alert_static.gif" border="0" align="middle">
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
    <script>
    function onUpdate(checked){
      document.result_form.target = "appFrame";
      document.result_form.MARKED.value = checked;
      document.result_form.action = '../data_validation_error_details/dataValidationErrorDetailView/updateRecord.cmd';
      document.result_form.submit();
    }

    function onDelete()
    {
      var confirmMesg = "<i18n:text>Are you sure you would like to remove the record(s)?</i18n:text>"
      if (checkifAnySelected(document.result_form))
      {
              if( core_confirm( confirmMesg ) == 'yes' )
                {
                document.result_form.target="appFrame";
                document.result_form.START_COUNT.value = 0 ;
                document.result_form.action="../data_validation_error_details/dataValidationErrorDetailView/deleteRecord.cmd";
                document.result_form.submit();
                }
         }
      	 else
         {
             core_alert("<i18n:text>LOC_DEL</i18n:text>");
         }
      }

      function onClear()
      {
        document.result_form.target="appFrame";
        document.result_form.PAGE.value="dataValidationErrorDetail";
        document.result_form.action="../framework/filter/controller/clearFilter.cmd";
        document.result_form.submit();
      }
            
      function onExportToExcel(fileName,fileFormat)
      {
				exportAll = 'YES';
        document.result_form.target="appFrame";
				document.result_form.action=omxContextPath+ "/bcm/framework/util/exportToExcel.cmd?EXPORT_ALL="+exportAll+"&amp;FILE_NAME="+fileName+"&amp;FILE_FORMAT="+fileFormat;
				document.result_form.submit();
      }
      
      function myMethod(selectedID){
        //alert("selectedID"+selectedID);
        var selected_ID = selectedID.split("#");
        var primaryKey  = selected_ID[1];
        var surrKey     = selected_ID[2].split("=");
        var tableName   = selected_ID[3].split("=");
        //alert(primaryKey);
        //alert(tableName[1]);
        //alert(surrKey[1]);
        document.result_form.target="appFrame";
        //document.result_form.ERROR_DATA.value=primaryKey[2]+'#'+primaryKey[3];
        //alert(document.result_form.ERROR_DATA.value);
        document.result_form.action="../data_validation_error_details/dataValidationErrorDetailView/getSearchPage.cmd?PRIMARY_KEY="+primaryKey+"&amp;TABLE_NAME="+tableName[1]+"&amp;SURR_KEY="+surrKey[1];
        document.result_form.submit();
      }
      
    </script>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
  <!-- Javascript -->
  <xsl:template name="include_javascript_table_resize">
    <script>
    <![CDATA[
      function resize_Containers(){
    	var table_id = 'result_form_table';
    	var width = document.body.offsetWidth -5 ;
    	var height = document.body.scrollHeight;
    	// resize table   approx
    	i2uiResizeColumns(table_id);
    	i2uiResizeScrollableArea(table_id, height-200, width-30, null, null, null,null, null);
    	i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight-100, null, document.body.offsetWidth - 20, true, 'yes');
      }
    ]]>
    </script>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template match="TD[ (not (@Type) or @Type = 'Text' or @Type = 'Date'  or @Type = 'Currency' or @Type = 'Number' or @Type='Select') and not(@Editable)]" mode="content">
    <xsl:param name="header" select="../@Header"/>
    <xsl:param name="validate"/>
    <xsl:param name="formName"/>
    <xsl:param name="totalRecordCount"/>
    <xsl:param name="frozenSequence"/>
    <xsl:param name="freezable"/>
    <xsl:param name="overridden"/>
    <xsl:param name="columnCount"/>
    
    <xsl:variable name="onmouseover">
    <xsl:choose>
        <xsl:when test="@OnMouseOver">
          <xsl:value-of select="@OnMouseOver"/>
        </xsl:when>
        <!--xsl:when test="@Sortable='yes' and $header = 'yes'">javascript:i2uiSetMenuCoords(this,event)</xsl:when-->
        <xsl:when test="$overridden='no' and $formName='result_form' and $header = 'yes'">javascript:i2uiSetMenuCoords(this,event)</xsl:when>
        
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
         <xsl:variable name="currentSequence"><xsl:value-of select="@Sequence"/></xsl:variable>
          <xsl:variable name="isFrozenAllowed">
            <xsl:choose>
                <!--xsl:when test="count(../TD[@Type != 'Hidden' and $currentSequence > @Sequence  ]) &lt; 5 and $freezable='yes'">yes</xsl:when-->
                <xsl:when test="$freezable='yes'">yes</xsl:when>
                <xsl:otherwise>no</xsl:otherwise>
           </xsl:choose>
          </xsl:variable>
          <xsl:variable name="isSortable">
              <xsl:choose>
                <xsl:when test="$totalRecordCount = 1">
                    <xsl:value-of select="'no'"/>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="@Sortable"/></xsl:otherwise>
              </xsl:choose>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="@Name = 'LOG_ERROR_DATA.MARKED'">
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat('javascript:sort(', $quote, @Name, $quote,',', @Sequence,',', $quote, $isSortable,$quote,',',$quote, $isFrozenAllowed,$quote,',',$quote,$formName,$quote,',',$quote,$columnCount,$quote, ')' )"/>
            </xsl:otherwise>
          </xsl:choose>
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
    <td nowrap="{$no-wrap}" align="{$align}" >
    <xsl:if test="$freezable='yes'">
          <xsl:attribute name="width">
            <xsl:value-of select="'100%'"/>
          </xsl:attribute>
    </xsl:if>
    
    <nobr>
      <!--//]NG-->
      <xsl:choose>
        <xsl:when test="string-length($onclick) > 0">
          <a onmouseover="{$onmouseover}" href="{$onclick}" >
            <xsl:if test="string-length(@Target) > 0  and string-length($onmouseover) = 0">
              <xsl:attribute name="target">
                <xsl:value-of select="@Target"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="@Value"/>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="not(@Value) or string-length(@Value) = 0 or @Type='Text' or @Type='Select'">
              <xsl:choose>
                <xsl:when test=" @Name = 'LOG_ERROR_DATA.MARKED'">
		  <xsl:if test=" @Value = 'True'">
                    <i2:img src="/mark_checked.gif" border="0" alt="Checked"/>
	          </xsl:if>
		  <xsl:if test=" @Value = 'False'">
	          </xsl:if>
	        </xsl:when>
	        <xsl:otherwise>
                  <xsl:value-of select="@Value"/>
	        </xsl:otherwise>
              </xsl:choose>
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
      <xsl:if test="@Sortable ='yes' and $header='yes' and $sortBy = @Name">
        <!--b>
          <xsl:value-of select="$sortImage"/>
        </b-->
      </xsl:if>
    </nobr>
    </td>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
      
</xsl:stylesheet>

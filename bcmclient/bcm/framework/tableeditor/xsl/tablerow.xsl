<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">
  <!-- Core -->
  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../../core/xsl/error.xsl"/>
  <xsl:import href="../../xsl/required_field.xsl"/>
  <!-- Errors -->
  <xsl:output method="html"/>
  <xsl:variable name="operation" select="/RESPONSES/RESPONSE/TABLE_ROW_OPERATION/@Value"/>
  <xsl:variable name="date-format" select="/RESPONSES/RESPONSE/FORMAT/@Date"/>
  <xsl:variable name="datetime-format" select="/RESPONSES/RESPONSE/DATETIMEFORMAT/@Date"/>
  <xsl:variable name="surrogateKey" select="/RESPONSES/RESPONSE/SurrogateKey/@Value"/>
  <xsl:variable name="service" select="/RESPONSES/RESPONSE/SERVICE[1]/@Value"/>
  <xsl:variable name="textAreaCol">26</xsl:variable>
  <xsl:variable name="textAreaRow">5</xsl:variable>
  <xsl:variable name="textAreaHeight">69</xsl:variable>
  <xsl:variable name="textHeight">23</xsl:variable>
  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <script>
      <xsl:call-template name="include_javascript_row"/>
    </script>
    <xsl:call-template name="include_javascript_table_resize"/>
    <xsl:call-template name="include_javascript_calendar"/>
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- **********************************************************************
    *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">
    <!-- Body -->
    <!-- EQ 521502 -->
    <xsl:call-template name="display_instruction_area"/>
    <table cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td width="100%">
          <i2:container id="table_row_container" width="100%" inner="yes" collapsable="no" scrollable="yes">
            <xsl:apply-templates select="ROWS"/>
          </i2:container>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="ROWS">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <form name="input_form" method="POST" Target="appFrame">
        <!-- hiddden fields -->
        <input type="hidden" name="TABLE_NAME" value="{/RESPONSES/RESPONSE/TABLE_NAME[1]/@Value}"/>
        <input type="hidden" name="SERVICE" value="{/RESPONSES/RESPONSE/SERVICE[1]/@Value}"/>
        <input type="hidden" name="DATE_FORMAT" value="{$date-format}"/>
        <input type="hidden" name="TABLE_ROW_OPERATION" value="{$operation}"/>
        <input type="hidden" name="UPDATE_ALL" value="{/RESPONSES/RESPONSE/UPDATE_ALL/@Value}"/>
        <!--    TODO REMOVE THIS PAGE variable if it is not used       -->
        <input type="hidden" name="PAGE" value="tablerow"/>
        <input type="hidden" name="FROM_TABLE" value="{/RESPONSES/RESPONSE/TABLE_NAME/@Value}"/>
        <input type="hidden" name="FROM_COLUMN"/>
        <input type="hidden" name="REFERRED_TABLE"/>
        <input type="hidden" name="REFERRED_COLUMN"/>
        <input type="hidden" name="ACTIVITY_ID" value="{/RESPONSES/RESPONSE/ACTIVITY_ID[1]/@Value}"/>
        <!--input type="hidden" name="FAV_ID" value="{/RESPONSES/RESPONSE/FAV_ID[1]/@Value}"/-->

        <!-- for back button-->
        <xsl:choose>
          <xsl:when test="string-length(/RESPONSES/RESPONSE/DIRECTORY/@Value) > 0 ">
            <input type="hidden" name="DIRECTORY" value="{/RESPONSES/RESPONSE/DIRECTORY/@Value}"/>
          </xsl:when>
          <xsl:otherwise>
            <input type="hidden" name="DIRECTORY" value="bcm.framework.tableeditor"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="string-length(/RESPONSES/RESPONSE/FILE/@Value) > 0 ">
            <input type="hidden" name="FILE" value="{/RESPONSES/RESPONSE/FILE/@Value}"/>
          </xsl:when>
          <xsl:otherwise>
            <input type="hidden" name="FILE" value="TableEditorView"/>
          </xsl:otherwise>
        </xsl:choose>
        <input type="hidden" name="DO_SEARCH" value="Yes"/>
        <input type="hidden" name="START_COUNT" value="{/RESPONSES/RESPONSE/START_COUNT/@Value}"/>
        <!-- Errors -->
        <xsl:if test="$operation = 'GROUP_EDIT' ">
          <input type="hidden" name="TOTAL_RECORD_COUNT" value="{/RESPONSES/RESPONSE/TOTAL_RECORD_COUNT/@Value}"/>
        </xsl:if>
        <xsl:apply-templates select="/RESPONSES/RESPONSE/_ERROR" mode="result_level"/>
        <tr>
          <td>
            <!-- EQ 521502 -->
            <!--xsl:call-template name="display_instruction_area"/-->
            <table id="row_table" border="0" width="100%" cellpadding="0" cellspacing="0">
              <xsl:choose>
                <xsl:when test="$operation = 'EDIT'">
                  <xsl:variable name="totalRecordCount">
                    <xsl:value-of select="count(./ROW)"/>
                  </xsl:variable>
                  <tr header="yes">
                    <td nowrap="yes" width="10" align="center" class="checkboxColumn">
                      <xsl:if test="$totalRecordCount > 1">
                        <input type="checkbox" name="SELECT_ALL" value="checked" onclick="javascript:selectAll();" checked="true"/>
                      </xsl:if>
                    </td>
                    <xsl:for-each select="/RESPONSES/RESPONSE/SELECTED_ID">
                      <td width="10" nowrap="yes" class="checkboxColumn">
                        <xsl:choose>
                          <xsl:when test="$totalRecordCount > 1">
                            <input type="hidden" name="SELECTED_ID" value="{./@Value}"/>
                            <input type="checkbox" name="SEQUENCE" value="{position()}" checked="true"/>
                          </xsl:when>
                          <xsl:when test="$totalRecordCount = 1">
                            <input type="hidden" name="SELECTED_ID" value="{./@Value}"/>
                            <input type="hidden" name="SEQUENCE" value="1"/>
                          </xsl:when>
                        </xsl:choose>
                      </td>
                    </xsl:for-each>
                  </tr>
                  <tr>
                    <xsl:apply-templates select="ROW[1]" mode="column_name"/>
                    <xsl:apply-templates select="ROW"/>
                  </tr>
                </xsl:when>
                <xsl:when test="$operation = 'GROUP_EDIT'">
                  <tr header="yes">
                    <td nowrap="yes">
                      &#xA0;&#xA0;<input type="checkbox" name="SELECT_ALL" value="checked" onclick="javascript:selectAllOnGroupEdit();"/>
                    </td>
                    <td nowrap="yes">&#xA0;</td>
                    <xsl:for-each select="/RESPONSES/RESPONSE/SELECTED_ID">
                      <input type="hidden" name="SELECTED_ID" value="{./@Value}"/>
                    </xsl:for-each>
                  </tr>
                  <tr>
                    <xsl:apply-templates select="ROW[1]" mode="column_name"/>
                    <xsl:apply-templates select="ROW[1]"/>
                  </tr>
                </xsl:when>
                <xsl:otherwise>
                  <tr>
                    <xsl:apply-templates select="ROW[1]" mode="column_name"/>
                    <xsl:apply-templates select="ROW[1]"/>
                  </tr>
                </xsl:otherwise>
              </xsl:choose>
            </table>
          </td>
        </tr>
      </form>
    </table>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="VALID_VALUE">
    <xsl:param name="selectedId"/>
    <xsl:choose>
      <xsl:when test="./@Value = $selectedId">
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
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="ROW" mode="column_name">
     <td>
      <i2:table>
        <xsl:choose>
          <xsl:when test="$operation = 'EDIT'">
            <xsl:for-each select="FIELD">            
              <xsl:sort select="@Sequence[count(@Sequence) > 0]" data-type="number" order="ascending"/>           
              <xsl:variable name="name" select="./@Name"/>
              <xsl:variable name="displayName" select="./@DisplayName"/>
              <xsl:if test="@Hidden = 'no' ">
                <i2:tr>
                  <xsl:choose>
                    <xsl:when test="./@DisplayType ='textarea'">
                      <td nowrap="nowrap" height="{$textAreaHeight}">
                       &#xA0;
                    <i18n:text>
                          <xsl:value-of select="$displayName"/>
                        </i18n:text>
                        <xsl:if test="./@PrimaryKey and  ./@PrimaryKey='yes'">
                          <i2:img src="/primary_key.gif" border="0" alt="Primary Key"/>
                        </xsl:if>
                        <xsl:text>:</xsl:text>
                        <xsl:if test="@Required and  @Required='yes' ">
                          <xsl:call-template name="display_alert_mark"/>
                        </xsl:if>
                      </td>
                    </xsl:when>
                    <xsl:otherwise>
                      <td nowrap="nowrap" height="{$textHeight}">
                 &#xA0;
                    <i18n:text>
                          <xsl:value-of select="$displayName"/>
                        </i18n:text>
                        <xsl:if test="./@PrimaryKey and  ./@PrimaryKey='yes'">
                          <i2:img src="/primary_key.gif" border="0" alt="Primary Key"/>
                        </xsl:if>
                        <xsl:text>:</xsl:text>
                        <xsl:if test="@Required and  @Required='yes' ">
                          <xsl:call-template name="display_alert_mark"/>
                        </xsl:if>
                      </td>
                    </xsl:otherwise>
                  </xsl:choose>
                </i2:tr>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="$operation = 'GROUP_EDIT' ">
            <xsl:for-each select="FIELD[ @Hidden = 'no' and @Editable = 'yes' and not(@PrimaryKey and @PrimaryKey='yes')]">
              <xsl:sort select="@Sequence[count(@Sequence) > 0]" data-type="number" order="ascending"/>
              <xsl:variable name="name" select="./@Name"/>
              <xsl:variable name="singleQuote">'</xsl:variable>
              <xsl:variable name="displayName" select="./@DisplayName"/>
              <xsl:if test="@Hidden = 'no' ">
                <i2:tr>
                  <xsl:choose>
                    <xsl:when test="./@DisplayType ='textarea'">
                      <td nowrap="nowrap" height="{$textAreaHeight}">
                        <xsl:variable name="fieldName">
                          <xsl:value-of select="$name"/>
                        </xsl:variable>
                        <xsl:choose>
                          <xsl:when test="count(/RESPONSES/RESPONSE/SELECTED_COLUMN[@Value=$name])>0">
                            <input type="checkbox" name="SELECTED_COLUMN" onclick="javascript:unSelectAll()" fieldName="{$fieldName}" value="{$name}" checked="true"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <input type="checkbox" name="SELECTED_COLUMN" onclick="javascript:unSelectAll()" fieldName="{$fieldName}" value="{$name}"/>
                          </xsl:otherwise>
                        </xsl:choose>
                    &#xA0;
                    <i18n:text>
                          <xsl:value-of select="$displayName"/>
                        </i18n:text>
                        <xsl:text>:</xsl:text>
                       <!-- <xsl:if test="@Required and  @Required='yes' and not(@PrimaryKey  and @PrimaryKey='yes')">
                          <xsl:call-template name="display_alert_mark"/>
                        </xsl:if>-->
                      </td>
                    </xsl:when>
                    <xsl:otherwise>
                      <td nowrap="nowrap" height="{$textHeight}">
                        <xsl:variable name="fieldName">
                          <xsl:choose>
                            <xsl:when test="@DisplayType = 'Date'">
                              <xsl:value-of select="concat($name, '_DC')"/>
                            </xsl:when>
                            <xsl:when test="@DisplayType = 'DateTime'">
                              <xsl:value-of select="concat($name, '_DC')"/>
                            </xsl:when>
                            <xsl:when test="@DisplayType = 'Number'">
                              <xsl:value-of select="concat($name, '_OPERATOR_VALUE','_N4')"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="$name"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:variable>
                        <!--input type="checkbox" name="SELECTED_COLUMN" onclick="javascript:unSelectAll()" fieldName="{$fieldName}" value="{$name}" checked="true"/-->
                        <xsl:choose>
                          <xsl:when test="count(/RESPONSES/RESPONSE/SELECTED_COLUMN[@Value=$name])>0">
                            <input type="checkbox" name="SELECTED_COLUMN" onclick="javascript:unSelectAll()" fieldName="{$fieldName}" value="{$name}" checked="true"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <input type="checkbox" name="SELECTED_COLUMN" onclick="javascript:unSelectAll()" fieldName="{$fieldName}" value="{$name}"/>
                          </xsl:otherwise>
                        </xsl:choose>
                    &#xA0;
                    <i18n:text>
                          <xsl:value-of select="$displayName"/>
                        </i18n:text>
                        <xsl:text>:</xsl:text>
                        <!--<xsl:if test="@Required and  @Required='yes' and not(@PrimaryKey  and @PrimaryKey='yes')">
                          <xsl:call-template name="display_alert_mark"/>
                        </xsl:if>-->
                      </td>
                    </xsl:otherwise>
                  </xsl:choose>
                </i2:tr>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="$operation = 'ADD' or $operation = 'COPY'">
            <xsl:for-each select="FIELD[@Hidden = 'no' and (@Editable = 'yes' or (@PrimaryKey and @PrimaryKey='yes')) ]">
              <xsl:sort select="@Sequence[count(@Sequence) > 0]" data-type="number" order="ascending"/>
              <xsl:variable name="name" select="./@Name"/>
              <xsl:variable name="displayName" select="./@DisplayName"/>
              <xsl:choose>
                <xsl:when test="($operation = 'ADD' or $operation = 'COPY') and  (@PrimaryKey and @PrimaryKey='yes') and ($surrogateKey = 'yes' and $service != 'BCMINService') "/>
                <xsl:otherwise>
                  <i2:tr>
                    <xsl:choose>
                      <xsl:when test="./@DisplayType ='textarea'">
                                              <td nowrap="nowrap" height="{$textAreaHeight}">
       &#xA0;
                    <i18n:text>
                            <xsl:value-of select="$displayName"/>
                          </i18n:text>
                          <xsl:if test="./@PrimaryKey and  ./@PrimaryKey='yes'">
                            <i2:img src="/primary_key.gif" border="0" alt="Primary Key"/>
                          </xsl:if>
                          <xsl:text>:</xsl:text>
                          <xsl:if test="@Required and  @Required='yes' ">
                            <xsl:call-template name="display_alert_mark"/>
                          </xsl:if>
                        </td>
                      </xsl:when>
                      <xsl:otherwise>
                        <td nowrap="nowrap" height="{$textHeight}">
                  &#xA0;
                  <i18n:text>
                            <xsl:value-of select="$displayName"/>
                          </i18n:text>
                          <xsl:if test="./@PrimaryKey  and ./@PrimaryKey='yes' ">
                            <i2:img src="/primary_key.gif" border="0" alt="Primary Key"/>
                          </xsl:if>
                          <xsl:text>:</xsl:text>
                          <xsl:if test="(@Required and  @Required='yes') or (./@PrimaryKey  and ./@PrimaryKey='yes')">
                            <xsl:call-template name="display_alert_mark"/>
                          </xsl:if>
                        </td>
                      </xsl:otherwise>
                    </xsl:choose>
                  </i2:tr>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:when>
        </xsl:choose>
      </i2:table>
    </td>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="ROW">
    <td>
      <i2:table>
        <xsl:choose>
          <xsl:when test="$operation = 'EDIT' ">
            <xsl:apply-templates select="FIELD[@Hidden = 'no']">
              <xsl:with-param name="index" select="position()"/>
              <xsl:sort select="@Sequence[count(@Sequence) > 0]" data-type="number" order="ascending"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$operation = 'GROUP_EDIT' ">
            <xsl:apply-templates select="FIELD[ @Hidden = 'no' and @Editable = 'yes' and not(@PrimaryKey  and @PrimaryKey='yes')]">
              <xsl:sort select="@Sequence[count(@Sequence) > 0]" data-type="number" order="ascending"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="FIELD[@Hidden = 'no' and (@Editable = 'yes' or (@PrimaryKey  and @PrimaryKey='yes')) ]">
              <xsl:sort select="@Sequence[count(@Sequence) > 0]" data-type="number" order="ascending"/>
            </xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
      </i2:table>
      <xsl:if test="$operation = 'EDIT'">
        <!-- put all hidden fields -->
        <xsl:for-each select="FIELD[@Hidden = 'yes']">
          <input type="hidden" name="{@Name}" value="{./@Value}"/>
        </xsl:for-each>
      </xsl:if>
    </td>
  </xsl:template>
  
  
  <!-- Javascript -->
  <xsl:template match="FIELD">
    <xsl:param name="index"/>
    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="$operation = 'EDIT' ">
          <xsl:value-of select="concat(@Name,'_',$index)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@Name"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--xsl:variable name="displayName" select="./@DisplayName"/-->
    <xsl:variable name="displayName">
      <i18n:text>
        <xsl:value-of select="./@DisplayName"/>
      </i18n:text>
    </xsl:variable>
    <xsl:variable name="val">
      <xsl:choose>
        <xsl:when test="./@DisplayType = 'Number'">
          <xsl:variable name="concat_name">
            <xsl:value-of select="concat($name, '_OPERATOR_VALUE')"/>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="$operation = 'GROUP_EDIT' ">
              <xsl:value-of select="/RESPONSES/RESPONSE/*[name() = $concat_name]/@Value"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="string-length(/RESPONSES/RESPONSE/*[name() = $name]/@Value) > 0">
                  <xsl:value-of select="/RESPONSES/RESPONSE/*[name() = $name]/@Value"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@Value"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
         <!--   This is commented as per issue no :543270 to allow default values in Mass Update
              <xsl:choose>
      	        <xsl:when test="$operation = 'GROUP_EDIT' ">
      	          <xsl:value-of select="/RESPONSES/RESPONSE/*[name() = $name]/@Value"/>
      	        </xsl:when>
      	        <xsl:otherwise>
      	          <xsl:choose>
      	            <xsl:when test="string-length(/RESPONSES/RESPONSE/*[name() = $name]/@Value) > 0">
      	              <xsl:value-of select="/RESPONSES/RESPONSE/*[name() = $name]/@Value"/>
      	            </xsl:when>
      	            <xsl:otherwise>
      	                <xsl:value-of select="@Value"/>
      	            </xsl:otherwise>
      	          </xsl:choose>
      	        </xsl:otherwise>
            </xsl:choose>
        -->
    	  <xsl:choose>
    	    <xsl:when test="string-length(/RESPONSES/RESPONSE/*[name() = $name]/@Value) > 0">
    	      <xsl:value-of select="/RESPONSES/RESPONSE/*[name() = $name]/@Value"/>
    	    </xsl:when>
    	    <xsl:otherwise>
    		<xsl:value-of select="@Value"/>
    	    </xsl:otherwise>
    	  </xsl:choose>


        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="($operation = 'ADD' or $operation = 'COPY') and  (@PrimaryKey and @PrimaryKey='yes') and ($surrogateKey = 'yes' and $service != 'BCMINService') ">
        <!--do not show the row if it is  a surrogate primary key-->
        <input type="hidden" name="{$name}" value="{$val}"/>
      </xsl:when>
      <xsl:otherwise>
        <i2:tr>
          <xsl:choose>
            <xsl:when test="@DisplayType ='textarea'">
              <xsl:choose>
                <xsl:when test="$operation = 'EDIT' and ((@PrimaryKey and @PrimaryKey='yes') or @Editable = 'no') ">
                  <td nowrap="nowrap" height="{$textHeight}">

                &#xA0;&#xA0;&#xA0;&#xA0;<xsl:value-of select="$val"/>
                    <input type="hidden" name="{$name}" value="{$val}"/>
                  </td>
                </xsl:when>
                <xsl:otherwise>
                  <td>
                               &#xA0;
                               <!--
                               <TEXTAREA NAME="comments" COLS="40" ROWS="6"></TEXTAREA>
                              -->
                                  <TEXTAREA displayName="{$displayName}" fieldtype="TEXTAREA" type="TEXTAREA" id="{$name}" name="{$name}" tabIndex="" class="inputfieldIE" COLS="{$textAreaCol}" ROWS="{$textAreaRow}">
                      <xsl:value-of select="$val"/>
                      <xsl:if test="@Required and  @Required='yes'">
                        <xsl:attribute name="required"><xsl:value-of select="'true'"/></xsl:attribute>
                      </xsl:if>
                    </TEXTAREA>
                    <xsl:if test="@Required and  @Required='yes'">
                      <xsl:call-template name="display_alert_image">
                        <xsl:with-param name="fieldName" select="$name"/>
                      </xsl:call-template>
                    </xsl:if>
                  </td>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <td nowrap="nowrap" height="{$textHeight}">
                <xsl:choose>
                  <xsl:when test="@DisplayType = 'Text' ">
                    <xsl:choose>
                      <!--xsl:when test="$operation = 'ADD' and  (@PrimaryKey and @PrimaryKey='yes') and ($surrogateKey = 'yes' and $service != 'BCMINService') ">
                 &#xA0;&#xA0;<xsl:value-of select="$val"/>
                 <input type="hidden" name="{$name}" value="{$val}"/>
              </xsl:when-->
                      <xsl:when test="$operation = 'EDIT' and ((@PrimaryKey and @PrimaryKey='yes') or @Editable = 'no') ">
                &#xA0;&#xA0;&#xA0;&#xA0;<xsl:value-of select="$val"/>
                        <input type="hidden" name="{$name}" value="{$val}"/>
                      </xsl:when>
                      <xsl:otherwise>
                &#xA0;

                    <input displayName="{$displayName}" fieldtype="Text" type="field" id="{$name}" name="{$name}" value="{$val}" tabIndex="" class="inputfieldIE" maxlength="{@MaxLength}" size="27">
                          <xsl:if test="@Required and  @Required='yes'">
                            <xsl:attribute name="required"><xsl:value-of select="'true'"/></xsl:attribute>
                          </xsl:if>
                        </input>
                        <xsl:if test="@Required and  @Required='yes'">
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="$name"/>
                          </xsl:call-template>
                        </xsl:if>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <!-- Modified for the funtionality of Min and Max contraints-->
                  <xsl:when test=" @DisplayType = 'Number' ">
                    <xsl:variable name="formattedVal">
                      <i18n:number>
                        <xsl:value-of select="$val"/>
                      </i18n:number>
                    </xsl:variable>
                    <xsl:variable name="decimalName">
                      <xsl:choose>
                        <xsl:when test="@Decimals">
                          <xsl:value-of select="concat($name, '_N4')"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="concat($name, '_N0')"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:variable>
                    <xsl:choose>
                      <xsl:when test="$operation = 'EDIT' and  ((@PrimaryKey and @PrimaryKey='yes') or @Editable = 'no') ">
                &#xA0;&#xA0;&#xA0;&#xA0;<xsl:value-of select="$formattedVal"/>
                        <input type="hidden" name="{$decimalName}" id="{$decimalName}" value="{$formattedVal}" onkeyup="javascript:onlyCurrency()"/>
                      </xsl:when>
                      <xsl:when test="$operation = 'ADD' and  (@PrimaryKey and @PrimaryKey='yes') and ($surrogateKey = 'yes' and $service != 'BCMINService') ">
                &#xA0;&#xA0;&#xA0;&#xA0;<xsl:value-of select="$formattedVal"/>
                        <input type="hidden" name="{$decimalName}" id="{$decimalName}" value="{$formattedVal}" onkeyup="javascript:onlyCurrency()"/>
                      </xsl:when>
                      <xsl:when test="$operation = 'ADD' or $operation = 'EDIT' or $operation = 'COPY'">
                 &#xA0;&#xA0;<input displayName="{$displayName}" fieldtype="Number" minValue="{@MinValue}" maxValue="{@MaxValue}" type="field" id="{$decimalName}" name="{$decimalName}" value="{$formattedVal}" tabIndex="" class="inputfieldIE" maxlength="{@MaxLength}" size="27" onkeyup="javascript:onlyCurrency()">
                          <xsl:if test="@Required and  @Required='yes' ">
                            <xsl:attribute name="required"><xsl:value-of select="'true'"/></xsl:attribute>
                          </xsl:if>
                        </input>
                        <xsl:if test="@Required and  @Required='yes' ">
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="$decimalName"/>
                          </xsl:call-template>
                        </xsl:if>
                      </xsl:when>
                      <xsl:otherwise>
                  &#xA0;&#xA0;
                <select name="{concat($name, '_OPERATOR')}" class="pulldownIE">
                  <option value="SET"><i18n:text name="SET">Set Value</i18n:text></option>
                  <option value="INCREMENT"><i18n:text name="INCREMENT">Increment by</i18n:text></option>
                  <option value="DECREMENT"><i18n:text name="DECREMENT">Decrement by</i18n:text></option>
                  <option value="INFLATE"><i18n:text name="INFLATE">Inflate</i18n:text></option>
                  <option value="DEFLATE"><i18n:text name="DEFLATE">Deflate</i18n:text></option>
                </select>&#xA0;&#xA0;
                <input fieldtype="Number" type="field" id="{concat($name, '_OPERATOR_VALUE')}_N4" value="{$val}" name="{concat($name, '_OPERATOR_VALUE')}_N4" class="inputfieldIE" size="10" onkeyup="javascript:onlyCurrency()">
                          <xsl:if test="@Required and  @Required='yes' ">
                            <xsl:attribute name="required"><xsl:value-of select="'true'"/></xsl:attribute>
                          </xsl:if>
                        </input>
                        <xsl:if test="@Required and  @Required='yes' ">
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="concat($name, '_OPERATOR_VALUE','_N4')"/>
                          </xsl:call-template>
                        </xsl:if>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:when test=" @DisplayType = 'Date' or  @DisplayType = 'DateTime' ">
                    <xsl:choose>
                      <xsl:when test="$operation = 'ADD' and  (@PrimaryKey and @PrimaryKey='yes') and ($surrogateKey = 'yes' and $service != 'BCMINService') ">
                 &#xA0;&#xA0;&#xA0;&#xA0;
                 <i18n:date format="common">
                          <xsl:value-of select="$val"/>
                        </i18n:date>
                        <xsl:if test="@PrimaryKey= 'yes'">
                          <input type="hidden" name="{$name}_DC" value="{$val}"/>
                        </xsl:if>
                      </xsl:when>
                      <xsl:when test="$operation = 'EDIT' and  ((@PrimaryKey  and @PrimaryKey='yes') or @Editable = 'no')">
                 &#xA0;&#xA0;&#xA0;&#xA0;
                 <i18n:date format="common">
                          <xsl:value-of select="$val"/>
                        </i18n:date>
                        <xsl:if test="@PrimaryKey= 'yes'">
                          <input type="hidden" name="{$name}_DC" value="{$val}"/>
                        </xsl:if>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:variable name="value">
                          <i18n:date format="common">
                            <xsl:value-of select="$val"/>
                          </i18n:date>
                        </xsl:variable>
                &#xA0;
                <input displayName="{$displayName}" fieldtype="Date" type="field" id="{$name}_DC" name="{$name}_DC" value="{$value}" tabIndex="" class="inputfieldIE" maxlength="10" size="27">
                          <xsl:if test="@Required and  @Required='yes' ">
                            <xsl:attribute name="required"><xsl:value-of select="'true'"/></xsl:attribute>
                          </xsl:if>
                        </input>
                        <A HREF="javascript:doNothing()" onclick="showCalendar(document.input_form.{$name}_DC);">
                          <i2:img src="/cal_icon.gif" border="0" align="bottom"/>
                        </A>
                        <xsl:if test="@Required and  @Required='yes' ">
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="concat($name , '_DC' )"/>
                          </xsl:call-template>
                        </xsl:if>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:when test=" @DisplayType = 'Select' ">
            &#xA0;
            <select class="pulldown" name="{$name}" id="{$name}" required="true" onchange="{@OnChange}">
                      <xsl:if test="@Editable = 'no'">
                        <xsl:attribute name="disabled">true</xsl:attribute>
                      </xsl:if>
                      <xsl:choose>
                        <xsl:when test="@Required and  @Required='yes' "/>
                        <xsl:otherwise>
                          <option value="">
                            <xsl:value-of select="'Select'"/>
                          </option>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:variable name="truncatedName">
                        <xsl:choose>
                          <xsl:when test="$operation = 'EDIT' ">
                            <xsl:choose>
                              <xsl:when test="contains($name,'_0') ">
                                <xsl:value-of select="substring-before($name,'_0')"/>
                              </xsl:when>
                              <xsl:when test="contains($name,'_1') ">
                                <xsl:value-of select="substring-before($name,'_1')"/>
                              </xsl:when>
                              <xsl:when test="contains($name,'_2') ">
                                <xsl:value-of select="substring-before($name,'_2')"/>
                              </xsl:when>
                              <xsl:when test="contains($name,'_3') ">
                                <xsl:value-of select="substring-before($name,'_3')"/>
                              </xsl:when>
                              <xsl:when test="contains($name,'_4') ">
                                <xsl:value-of select="substring-before($name,'_4')"/>
                              </xsl:when>
                              <xsl:when test="contains($name,'_5') ">
                                <xsl:value-of select="substring-before($name,'_5')"/>
                              </xsl:when>
                              <xsl:when test="contains($name,'_6') ">
                                <xsl:value-of select="substring-before($name,'_6')"/>
                              </xsl:when>
                              <xsl:when test="contains($name,'_7') ">
                                <xsl:value-of select="substring-before($name,'_7')"/>
                              </xsl:when>
                              <xsl:when test="contains($name,'_8') ">
                                <xsl:value-of select="substring-before($name,'_8')"/>
                              </xsl:when>
                              <xsl:when test="contains($name,'_9') ">
                                <xsl:value-of select="substring-before($name,'_9')"/>
                              </xsl:when>
                              <xsl:when test="contains($name,'_10') ">
                                <xsl:value-of select="substring-before($name,'_10')"/>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="$name"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:variable>
                      <xsl:apply-templates select="/RESPONSES/RESPONSE/OPTION_TYPES/PROPERTY[@Name = $truncatedName]/VALID_VALUE">
                        <xsl:with-param name="selectedId" select="$val"/>
                      </xsl:apply-templates>
                    </select>
                    <xsl:if test="@Required and  @Required='yes' ">
                      <xsl:call-template name="display_alert_image">
                        <xsl:with-param name="fieldName" select="$name"/>
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:choose>
                      <xsl:when test="$operation = 'EDIT' and  ((@PrimaryKey and @PrimaryKey='yes') or @Editable = 'no')">
                  &#xA0;&#xA0;&#xA0;&#xA0;
                  <i18n:date format="common">
                          <xsl:value-of select="$val"/>
                        </i18n:date>
                        <input type="hidden" name="{$name}" value="{$val}"/>
                      </xsl:when>
                      <xsl:otherwise>
                &#xA0;
                <input displayName="{$displayName}" type="field" id="{$name}" name="{$name}" value="{$val}" required="true" tabIndex="" class="inputfieldIE" maxlength="{@MaxLength}" size="27"/>
                        <xsl:if test="@Required and  @Required='yes' ">
                          <xsl:call-template name="display_alert_image">
                            <xsl:with-param name="fieldName" select="$name"/>
                          </xsl:call-template>
                        </xsl:if>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:variable name="single_quote">'</xsl:variable>
                <xsl:choose>
                  <xsl:when test="$operation = 'ADD' or $operation = 'COPY' ">
                    <xsl:if test="@ReferredTable">
                      <A HREF="{concat('javascript:onGotoSelectForeignKey(', $single_quote, $name, $single_quote, ',', $single_quote, @ReferredTable, $single_quote,  ',',$single_quote, @ReferredColumn, $single_quote, ');')} ">
                        <i2:img src="/pop_up_window.gif" border="0" align="bottom"/>
                      </A>
                    </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:if test="@ReferredTable and not(@PrimaryKey and @PrimaryKey='yes' ) and @Editable='yes'">
                      <A HREF="{concat('javascript:onGotoSelectForeignKey(', $single_quote, $name, $single_quote, ',', $single_quote, @ReferredTable, $single_quote,  ',',$single_quote, @ReferredColumn, $single_quote, ');')} ">
                        <i2:img src="/pop_up_window.gif" border="0" align="bottom"/>
                      </A>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
            </xsl:otherwise>
          </xsl:choose>
          <td nowrap="yes">
							<xsl:choose>
								<xsl:when test="@DisplayType = 'Number'">
					&#xA0;[
					<i18n:text>number</i18n:text>
									<xsl:if test="string-length(@MinValue) > 0 ">
						 &#xA0;<i18n:text>min</i18n:text>:<xsl:value-of select="@MinValue"/>
									</xsl:if>
									<xsl:if test="string-length(@MaxValue) > 0 ">
						 &#xA0;<i18n:text>max</i18n:text>:<xsl:value-of select="@MaxValue"/>
									</xsl:if>
					]&#xA0;
							</xsl:when>
								<xsl:when test="@DisplayType = 'Date' or @DisplayType = 'DateTime'">&#xA0;[<i18n:text>date</i18n:text>]&#xA0;[<i18n:text><xsl:value-of select="$date-format"/></i18n:text>]&#xA0;</xsl:when>
								<xsl:otherwise>&#xA0;[<i18n:text>text</i18n:text>]&#xA0;</xsl:otherwise>
							</xsl:choose>
          </td>
        </i2:tr>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_row">


  var msg_valid_date="EFFECTIVE_DATE_INVALID_FORMAT";
  var msg_min_value= "<i18n:text>{0} should be more than {1}</i18n:text>";
  var msg_max_value = "<i18n:text>{0} should be less than {1}</i18n:text>";
  var msg_valid_number = "<i18n:text>{0} should be valid number</i18n:text>";

   function checkRequiredFieldProperty()
    {
        var formElements = document.input_form.elements;
        for (i = 0; i &lt; formElements.length; i++)
        {
              if (formElements[i].type == 'checkbox' &amp;&amp; formElements[i].fieldName)
               {
                      // made by anish ..  its a hack ..needs to change the field name (if its class) in database
                       //if(formElements[i].fieldName != 'class' )
                       // {

                                  //var field =  eval("document.input_form." + formElements[i].fieldName);
                                  var field =  document.getElementById(formElements[i].fieldName);
                                  if (field.required) {
                                           if (formElements[i].checked) {
                                            field.required = 'true';
                                           } else {
                                            field.required = 'false';
                                           }
                                   }
                       // }
                }
         }
      }

      function onSaveAndReturn(returnPageExists)
      {
          error = "false";
          error = validate() ;

          if (error)
          {

        error = "false";
        error = groupEditValidate() ;
        if (error)
        {
           if(returnPageExists) {
              document.input_form.action="TableEditorController/addDBRow.cmd?RETURN=true";
           } else {
              document.input_form.action="TableEditorController/addDBRow.cmd?RETURN=false";
           }
           document.input_form.target="appFrame";
           displayBusyBox();
           document.input_form.submit();
         }
     }

      }
      function onEditCommitAll()
      {
          if ( validate() )
          {
                if ( checkifAnySelected(input_form) == true )
                {
                    error = "false";
            error = groupEditValidate() ;
            if (error)
                    {
                     document.input_form.action="TableEditorController/updateDBRows.cmd";
                    document.input_form.target="appFrame";
                    displayBusyBox();
                    document.input_form.submit();
                    }

                }
                else
                {
                  core_alert("<i18n:text>You must select at least one row</i18n:text>");
                }
           }
      }
      function onEditCommitOne()
      {
          if ( validate() )
          {
                    error = "false";
                    error = groupEditValidate() ;
                    if (error)
                    {
                    document.input_form.action="TableEditorController/updateDBRows.cmd";
                    document.input_form.target="appFrame";
                    displayBusyBox();
                    document.input_form.submit();
                    }
           }
      }

      function onGroupEditCommit()
      {

      checkRequiredFieldProperty();
      error = "false";
      error = validate() ;

      if (error)
      {
                if ( checkifAnySelected(input_form) == true )
                {
                    error = "false";
                    error = groupEditValidate() ;
                    if (error)
                    {
                    document.input_form.action="TableEditorController/commit.cmd";
                    displayBusyBox();
                    document.input_form.submit();
                    }
                }
                else
                {
                  core_alert("<i18n:text>You must select at least one row</i18n:text>");
                }
      }
      }
      function onGroupEditCommitAll()
      {
          checkRequiredFieldProperty();
          error = "false";
          error = validate() ;

          if (error)
          {
                    if ( checkifAnySelected(input_form) == true )
                    {
                        error = "false";
                        error = groupEditValidate() ;
                        if (error)
                        {
                        document.input_form.action="TableEditorController/commitAll.cmd";
                        displayBusyBox();
                        document.input_form.submit();
                        }
                    }
                    else
                    {
                      core_alert("<i18n:text>You must select at least one row</i18n:text>");
                    }
           }
      }
      function validate()
      {


        error = "false";
        error = requiredFieldCheck();

        if ( error == 'true' )
          return false;


          var count;
          var elementsLen = document.input_form.elements.length;
          var dateFormat = document.input_form.DATE_FORMAT.value
          var success = true;
          var foundFilledField = false;

          var msg = "";
    <![CDATA[

          //Validate fields
          for(count = 0; count < elementsLen; count++)
              {
                  var name = document.input_form.elements[count].displayName;


                  if( document.input_form.elements[count].fieldtype == "Number" &&
                      document.input_form.elements[count].value != "" )
                      {
                          /*
                          if ( isNaN(document.input_form.elements[count].value) )
                              {
                                  msg += name + " " +  msg_valid_number;
                                  core_alert(msg);
                                  success = false;
                                  break;
                              }
                             */
                      }
                  if( ((document.input_form.elements[count].fieldtype == "DateRange") || (document.input_form.elements[count].fieldtype == "Date") || (document.input_form.elements[count].fieldtype == "DateTime")) &&
                      document.input_form.elements[count].value != "" && dateFormat != "")
                      {
                          if ( isDate(document.input_form.elements[count].value, dateFormat) == false )
                              {
                                  core_alert(msg_valid_date, name, dateFormat);
                                  success = false;
                                  break;
                              }
                      }
              }

          return success;
      }

      function groupEditValidate()
      {
          var count;
          var elementsLen = document.input_form.elements.length;
          var dateFormat = document.input_form.DATE_FORMAT.value
          var success = true;
          var foundFilledField = false;
          var msg = "";

          //Validate fields
          for(count = 0; count < elementsLen; count++)
              {
                 var id = document.input_form.elements[count].id;
                 var  i =  id.indexOf('_') ;
                 var name = id.substring(0,i);
                 if( document.input_form.elements[count].fieldtype == "Number")
         {
           if ( document.input_form.elements[count].value == "")
           {
              for(i=0; i< elementsLen; i++)
                      {
                if (document.input_form.elements[i].fieldName == document.input_form.elements[count].name && document.input_form.elements[i].checked == true
                    && document.input_form.elements[count-1].selectedIndex != 0)
             {
                core_alert(msg_valid_number, name);
                success = false;
                break;
              }
                       }
                       if (success == false)
                       break;
               }
                   <!-- For the functionality of Min and Max constraints-->
                   else
                 {
                if(document.input_form.elements[count].minValue != '' && (document.input_form.elements[count].value - document.input_form.elements[count].minValue) < 0)
                {

                    success = false;
                    core_alert(msg_min_value, name, document.input_form.elements[count].minValue);
                    break;

                }

                if(document.input_form.elements[count].maxValue != '' && (document.input_form.elements[count].value - document.input_form.elements[count].maxValue) > 0)
                {
                    success = false;
                    core_alert(msg_max_value, name, document.input_form.elements[count].maxValue);
                    break;


                }
                 }
                      }
                  if( ((document.input_form.elements[count].fieldtype == "DateRange") || (document.input_form.elements[count].fieldtype == "Date") || (document.input_form.elements[count].fieldtype == "DateTime")) &&
                      document.input_form.elements[count].value != "" && dateFormat != "")
                      {
                          if ( isDate(document.input_form.elements[count].value, dateFormat) == false )
                              {
                                  core_alert(msg_valid_date, name, dateFormat);
                                  success = false;
                                  break;
                              }
                      }
              }

          return success;
      }
      function onTableEditor()
      {
          document.input_form.action="TableEditorController/refresh.cmd";
          document.input_form.submit();
      }

      function onGotoSelectForeignKey(fromColumn, referredTable, referredColumn)
      {
          document.input_form.target="appFrame";
          document.input_form.FROM_COLUMN.value= fromColumn;
          document.input_form.REFERRED_TABLE.value= referredTable;
          document.input_form.REFERRED_COLUMN.value= referredColumn;
          document.input_form.action="TableEditorController/gotoSelectForeignKey.cmd";
          document.input_form.submit();
      }

    ]]></xsl:template>
  <!-- page.xsl Javascript -->
  <!-- Javascript -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template name="include_javascript_calendar">
    <i2:javascript path="/calendar.js"/>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
    requiredFieldCheck('onLoad');
    resize_Containers();
    }
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onResize_js">
    function onResize()
    {
    <xsl:call-template name="javascript_onResize_page"/>
    resize_Containers();
    }
  </xsl:template>
  <!-- Javascript -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_table_resize">
    <script><![CDATA[
  // Resizing All containers
    function resize_Containers()
    {
     // resize top level container
     i2uiResizeScrollableContainer('container',document.body.offsetHeight - 90, null, document.body.offsetWidth -20, true, 'yes');
     // EQ 521502
     // resize inner level container
     i2uiResizeScrollableContainer('table_row_container',document.body.offsetHeight - 120, null, document.body.offsetWidth -20, true, 'yes');
  }
    function checkifAnySelected(form)
    {
        var count;
        var elementsLen = form.elements.length;
        var foundChecked = false;

        for(count = 0; count < elementsLen; count++)
            {
                if(
                   form.elements[count].type == "checkbox" &&
                   form.elements[count].checked == true  &&
                   form.elements[count].name != "SELECT_ALL"
                   )
                    {
                        foundChecked = true;break;
                    }
            }
        return foundChecked;
    }

    function unSelectAll()
    {
      document.input_form.SELECT_ALL.checked=false;
    }

      function selectAll()
      {
        javascript:toggleCheckboxes(document.input_form, document.input_form.SEQUENCE,document.input_form.SELECT_ALL);
      }
     function selectAllOnGroupEdit()
      {
        javascript:toggleCheckboxes(document.input_form, document.input_form.SELECTED_COLUMN,document.input_form.SELECT_ALL);
      }
  ]]>
  // issue 478041
   function SetfocusSubmit(element)
    {
      //alert("action = "+document.input_form.TABLE_ROW_OPERATION.value);
      //alert("edit action ="+ document.input_form.UPDATE_ALL.value);
      var action = document.input_form.TABLE_ROW_OPERATION.value;
      var multipleRows = document.input_form.UPDATE_ALL.value;

      if( action == 'EDIT')
      {
        <xsl:choose>
        <xsl:when test="count(/RESPONSES/RESPONSE/SELECTED_ID) &gt; 1">
          //alert("onEditCommitAll");
          onEditCommitAll();
        </xsl:when>
        <xsl:otherwise>
          //alert("onEditCommitOne");
          onEditCommitOne();
        </xsl:otherwise>
      </xsl:choose>
      }
      else if(action == 'GROUP_EDIT')
      {
        if(multipleRows == 'NO')
        {
          //alert("onGroupEditCommit");
          onGroupEditCommit();
        }
        else
        {
          //alert("onGroupEditCommitAll");
          onGroupEditCommitAll();
        }
      }
      else
      {
        //alert("onSaveAndReturn(true)");
        onSaveAndReturn(true)
      }
    }
    //end issue 478041
  </script>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
</xsl:stylesheet>

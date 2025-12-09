<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:lxslt="http://xml.apache.org/xslt"
xmlns:xalan="http://xml.apache.org/xalan"
xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
extension-element-prefixes="i2 i18n"
exclude-result-prefixes="xalan"
version="1.0">


  <!-- Core -->
  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../xsl/buttons.xsl"/>
  <xsl:output method="html"/>

  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">

     <xsl:call-template name="include_javascript_tableeditor_filter"/>
     <xsl:call-template name="include_javascript_calendar"/>

     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>

  </xsl:template>

   <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">


      <!-- Body -->
      <table id="top_table" border="0" cellpadding="0" cellspacing="0"  width="100%">
          <td width="30%" height="100%">
            <xsl:apply-templates select="FILTER_COLUMNS"/>
          </td>
          <td width="40%" >
            <xsl:call-template name="FILTER_DESCRIPTION_TABLE"/>
          </td>
          <td width="30%" >
            <xsl:call-template name="FILTER_EXPRESSION"/>
           </td>
      </table>

  </xsl:template>

    <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="FILTER_COLUMNS">
    <xsl:variable name="title">
      <b><i18n:text>Properties of the table</i18n:text></b>
    </xsl:variable>
    <xsl:variable name="tableDisplayName">
      <xsl:value-of select="@TableDisplayName"/>
    </xsl:variable>
    <xsl:variable name="tableName">
      <xsl:value-of select="@TableName"/>
    </xsl:variable>
    <xsl:variable name="tableNamei18n">
    <i18n:text>
          <xsl:value-of select="@TableName"/>
    </i18n:text>
    </xsl:variable>
    <xsl:variable name="tableEditor">
      <xsl:choose>
        <xsl:when test="@TableEditor">true</xsl:when>
        <xsl:otherwise>false</xsl:otherwise>
      </xsl:choose>
     </xsl:variable>
    <xsl:variable name="singleDot">.</xsl:variable>
    <xsl:variable name="separator">|</xsl:variable>
    <xsl:variable name="showAllFields">
        <xsl:choose>
            <xsl:when test="/RESPONSES/RESPONSE/SHOW_ALL_FIELDS/@Value='yes'">yes</xsl:when>
            <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <FORM name="filter_columns_form" method="POST">
    <input type="hidden" name="SHOW_ALL_FIELDS" value="{$showAllFields}"/>

    <i2:container id="filter_container"  title="{$title}"  inner="yes"  stretch="yes">
       <table id="filter_tab" >
         <tr>
         <td>
                <!-- Simple Search Toggle link -->
                <xsl:choose>
                <xsl:when test="$showAllFields='yes'">
                    <tr>
                      <td colspan="2" nowrap="true">
                        <a class="text" href="javascript:showSearchProperties();">
                          <i18n:text>Show Search Properties</i18n:text>
                        </a>
                      </td>
                    </tr>
                </xsl:when>
                <xsl:otherwise>
                    <tr>
                      <td colspan="2" nowrap="true">
                        <a class="text" href="javascript:showAllProperties();">
                          <i18n:text>Show All Properties</i18n:text>
                        </a>
                      </td>
                    </tr>
                </xsl:otherwise>
                </xsl:choose>
         </td>
         </tr>

         <tr>
                <td nowrap="nowrap"  width="100%">

                  <select id ="properties" onchange="javascript:populate_field_properties(this);" class="pulldownIE" name="prop"  tabIndex="" size="10">
                    <xsl:for-each select="PROPERTY|SEARCH_PROPERTY">
            <xsl:variable name="displayNamei18n">
                    <i18n:text>
                          <xsl:value-of select="@DisplayName"/>
                    </i18n:text>
            </xsl:variable>

            <xsl:variable name="Namei18n">
                    <i18n:text>
                          <xsl:value-of select="@Name"/>
                    </i18n:text>
            </xsl:variable>
                    <xsl:variable name="displayNamei18n">
                <i18n:text>
                      <xsl:value-of select="@DisplayName"/>
                </i18n:text>
            </xsl:variable>

            <xsl:variable name="Namei18n">
                <i18n:text>
                      <xsl:value-of select="@Name"/>
                </i18n:text>
            </xsl:variable>
                      <xsl:variable name="type">
                            <xsl:choose>
                                <xsl:when test="$tableEditor = 'true' ">
                                    <xsl:choose>
                                        <xsl:when test="contains(@Type, 'string') ">string</xsl:when>
                                        <xsl:when test="contains(@Type, 'int') ">int</xsl:when>
                                        <xsl:when test="contains(@Type, 'float') ">double</xsl:when>
                                        <xsl:when test="contains(@Type, 'double') ">double</xsl:when>
                                        <xsl:when test="contains(@Type, 'datetime') ">datetime</xsl:when>
                                        <xsl:when test="contains(@Type, 'date') ">date</xsl:when>
                                        <xsl:when test="contains(@Type, 'boolean') ">boolean</xsl:when>
                                        <xsl:otherwise>string</xsl:otherwise>
                                      </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="contains(@DataType, 'string') ">string</xsl:when>
                                        <xsl:when test="contains(@DataType, 'int') ">int</xsl:when>
                                        <xsl:when test="contains(@DataType, 'float') ">double</xsl:when>
                                        <xsl:when test="contains(@DataType, 'double') ">double</xsl:when>
                                        <xsl:when test="contains(@DataType, 'datetime') ">datetime</xsl:when>
                                        <xsl:when test="contains(@Type, 'date') ">date</xsl:when>
                                        <xsl:when test="contains(@DataType, 'boolean') ">boolean</xsl:when>
                                        <xsl:otherwise>string</xsl:otherwise>
                                      </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                      </xsl:variable>

                      <xsl:variable name="i18nType">
                            <xsl:choose>
                                <xsl:when test="$tableEditor = 'true' ">
                                    <xsl:choose>
                                        <xsl:when test="contains(@Type, 'string') "><i18n:text>string</i18n:text></xsl:when>
                                        <xsl:when test="contains(@Type, 'int') "><i18n:text>int</i18n:text></xsl:when>
                                        <xsl:when test="contains(@Type, 'float') "><i18n:text>double</i18n:text></xsl:when>
                                        <xsl:when test="contains(@Type, 'double') "><i18n:text>double</i18n:text></xsl:when>
                                        <xsl:when test="contains(@Type, 'datetime') "><i18n:text>datetime</i18n:text></xsl:when>
                                        <xsl:when test="contains(@Type, 'date') ">date</xsl:when>
                                        <xsl:when test="contains(@Type, 'boolean') ">boolean</xsl:when>
                                        <xsl:otherwise><i18n:text>string</i18n:text></xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="contains(@DataType, 'string') "><i18n:text>string</i18n:text></xsl:when>
                                        <xsl:when test="contains(@DataType, 'int') "><i18n:text>int</i18n:text></xsl:when>
                                        <xsl:when test="contains(@DataType, 'float') "><i18n:text>double</i18n:text></xsl:when>
                                        <xsl:when test="contains(@DataType, 'double') "><i18n:text>double</i18n:text></xsl:when>
                                        <xsl:when test="contains(@DataType, 'datetime') "><i18n:text>datetime</i18n:text></xsl:when>
                                        <xsl:when test="contains(@Type, 'date') ">date</xsl:when>
                                        <xsl:when test="contains(@DataType, 'boolean') ">boolean</xsl:when>
                                        <xsl:otherwise><i18n:text>string</i18n:text></xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                      </xsl:variable>

                      <xsl:variable name="name">
                        <xsl:choose>
                          <xsl:when test="$tableEditor = 'true' ">
                             <xsl:value-of select="concat( $tableName , $singleDot ,  ./@Name)"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="concat( ./@Document , $singleDot ,  ./@Property)"/>
                          </xsl:otherwise>
                        </xsl:choose>
                       </xsl:variable>

                       <xsl:variable name="displayName">
               <xsl:choose>
             <xsl:when test="$tableEditor = 'true' ">
                 <xsl:choose>
                 <xsl:when test="./@DisplayName">
                   <xsl:value-of select="concat( $tableNamei18n , $singleDot , $displayNamei18n)"/>
                 </xsl:when>
                 <xsl:otherwise>
                   <xsl:value-of select="concat( $tableNamei18n , $singleDot ,  $Namei18n)"/>
                 </xsl:otherwise>
               </xsl:choose>
             </xsl:when>
             <xsl:otherwise>
               <xsl:choose>
                 <xsl:when test="./@DisplayName">
                   <xsl:value-of select="concat( ./@Document , $singleDot ,  ./@DisplayName)"/>
                 </xsl:when>
                 <xsl:otherwise>
                   <xsl:value-of select="concat( ./@Document , $singleDot ,  ./@Name)"/>
                 </xsl:otherwise>
               </xsl:choose>
             </xsl:otherwise>
               </xsl:choose>
                       </xsl:variable>
                       <!-- added by Mithun for 3M-->
                       <xsl:variable name="validvalue">
                   <xsl:for-each select="OPTIONS/VALID_VALUE">
                    <xsl:value-of select="concat(./@Value,$separator)"/>
                   </xsl:for-each>
               </xsl:variable>
            <!-- added by Mithun for 3M-->
                      <option type="{$type}" value="{$name}" i18nType="{$i18nType}" validValues="{$validvalue}">
                        <i18n:text>
                            <xsl:value-of select="$displayName"/>
                        </i18n:text>
              </option>
                    </xsl:for-each>

                  </select>
                </td>
             </tr>
       </table>
      <table>
        <tr>
       <td><i2:button onclick="javascript:group_operation('AND');">&#xA0;&#xA0;<i18n:text>AND_BUTTON</i18n:text>&#xA0;&#xA0;</i2:button></td>
       <td><i2:button onclick="javascript:group_operation('OR');">&#xA0;&#xA0;<i18n:text>OR_BUTTON</i18n:text>&#xA0;&#xA0;</i2:button></td>
       <td><i2:button onclick="javascript:group_operation('(');">&#xA0;&#xA0;(&#xA0;&#xA0;</i2:button></td>
       <td><i2:button onclick="javascript:group_operation(')');">&#xA0;&#xA0;)&#xA0;&#xA0;</i2:button></td>
       </tr>
        <tr><td>&#xA0;</td></tr>
      </table>
    </i2:container>
    </FORM>
  </xsl:template>


      <!--**************************************************
  *********************************************************************** -->
  <xsl:template name="FILTER_DESCRIPTION_TABLE">
    <xsl:variable name="title">
      <b><i18n:text>Filter Description</i18n:text></b>
    </xsl:variable>
    <i2:container id="description_container"  inner="yes"  title="{$title}" stretch="yes">
       <table >
              <tr>
                <td nowrap="true">
                  <FORM name="field_desc_form" onsubmit="filter_value_okay(); return false;">
                    <TABLE  id="desc_table" border="0" cellpadding="0" cellspacing="0">
                       <TR>
                      <TD nowrap="yes"><i18n:text>Field Name</i18n:text> &#xA0;<xsl:text>:</xsl:text>&#xA0;</TD>
                      <TD nowrap="yes" align="left" class="displayFieldIE">
                        <input type="hidden" name="field_name_display" value=""/>
                        <input type="text" disabled="yes" class="inputFieldIE" name="field_sel_by_name" value=""/>
                      </TD>
                      <TD width="100%"></TD>
                       </TR>
                       <TR>
                      <TD nowrap="yes"><i18n:text>Format</i18n:text> &#xA0;<xsl:text>:</xsl:text>&#xA0;</TD>
                      <TD nowrap="yes" align="left" class="displayFieldIE"><input type="text"  disabled="yes" class="inputFieldIE" name="field_sel_data_type" value=""/></TD>
                        <input type="hidden" name="field_orig_type" value=""/>
                       </TR>
                       <TR>
                      <TD class="formLabel" nowrap="yes" align="right"><i18n:text>Operation</i18n:text> &#xA0;<xsl:text>:</xsl:text>&#xA0;</TD>
                      <TD style="padding-left:0px">
                           <SELECT id="operation" name="operation" class="pulldownIE" style="margin-left:0px" onchange="javascript:showHideFilterValueBox(this)">
                              <option value="=">=</option>
                              <option value="&lt;&gt;">&lt;&gt;</option>
                              <option value="&lt;">&lt;</option>
                              <option value="&gt;">&gt;</option>
                              <option value="&lt;=">&lt;=</option>
                              <option value="&gt;=">&gt;=</option>
                              <option value="like"><i18n:text>like</i18n:text></option>
                              <option value="is null"><i18n:text>is null</i18n:text></option>
                              <option value="is not null"><i18n:text>is not null</i18n:text></option>
                              <option value="in"><i18n:text>in</i18n:text></option>
                              <option value="not in"><i18n:text>not in</i18n:text></option>
                            </SELECT>
                      </TD>
                      </TR>
                   </TABLE>
                    <table border="0" id="string_table" cellpadding="0" cellspacing="0">
                      <tr>
                        <TD nowrap="yes"><i18n:text>Filter Value</i18n:text> &#xA0;<xsl:text>:</xsl:text>&#xA0;</TD>
                        <TD nowrap="yes" align="left" ><INPUT type="text" value="" class="inputFieldIE" name="value_box_str" size="28"/></TD>
                        <TD width="100%"></TD>
                      </tr>
                    </table>
                    <table border="0" id="number_table" cellpadding="0" cellspacing="0">
                      <tr>
                        <TD nowrap="yes"><i18n:text>Filter Value</i18n:text> &#xA0;<xsl:text>:</xsl:text>&#xA0;</TD>
                        <TD nowrap="yes" align="left"><INPUT type="text" class="inputFieldIE" name="value_box_num" size="28"/></TD>
                        <TD width="100%"></TD>
                      </tr>
                    </table>
                    <!--added by Mithun For 3M-->
                    <table border="0" id="valid_value_table" cellpadding="0" cellspacing="0">
               <tr>
            <TD class="formLabel" nowrap="yes" align="right"><i18n:text>Filter Value </i18n:text> &#xA0;<xsl:text>:</xsl:text>&#xA0;</TD>
                <TD style="padding-left:0px">
               <SELECT id="valid_value" name="validvalue" class="pulldownIE" style="margin-left:0px">
               </SELECT>
                      </TD>
               </tr>
                    </table>
                    <!--added by Mithun For 3M-->
                    <table border="0" id="date_table" cellpadding="0" cellspacing="0">
                           <TR>
                             <TD nowrap="yes" ><i18n:text>Filter Value</i18n:text> &#xA0;<xsl:text>:</xsl:text>&#xA0;</TD>
                            <TD nowrap="yes">
                              <!--
                              <INPUT type="radio" name="date_format"  onclick="correct_form_element_field_desc = this.form.date_format; field_desc_on_focus();"/>
                               Start Date   &#xA0;<xsl:text>:</xsl:text>&#xA0;
                              -->
                            </TD>
                            <TD nowrap="yes">
                            <INPUT type="text" class="inputFieldIE" name="value_box_date_DC" size="35" onfocus="field_desc_on_focus()"/>
                            </TD>
                            <TD>
                              <A HREF="javascript:doNothing()" onclick="showCalendar(document.field_desc_form.value_box_date_DC);">
                                <i2:img src="/cal_icon.gif" border="0" align="bottom"/>
                             </A>
                            </TD>
                         </TR>
                         <!--TR>
                            <TD nowrap="yes">
                              <INPUT type="radio" name="date_format"  onclick="correct_form_element_field_desc = this.form.value_box_DE; field_desc_on_focus();"/>
                               End Date &#xA0;<xsl:text>:</xsl:text>&#xA0;
                            </TD>
                            <TD nowrap="yes">
                            <INPUT type="text" class="inputFieldIE" name="value_box_DE" size="14" onfocus="field_desc_on_focus()"/>
                            </TD>
                            <TD>
                              <A href="javascript:openCalendar('field_desc_form.value_box')">
                              <i2:img valign="bottom" border="0" style="height:17px; margin-bottom:1px" src="/calendar.gif"/>
                              </A>
                            </TD>
                         </TR-->
                    </table>
                    <table border="0" id="blank_table" cellpadding="0" cellspacing="4">
                    <TR>
                      <TD/>
                    </TR>
                    </table>
                    <table border="0" id="button_table" cellpadding="0" cellspacing="4">
                    <TR>
                      <TD colspan="2" align="right"/>
                      <TD colspan="2" align="right"/>
                      <TD style="margin-right:4px">
                        <i2:button onclick="javascript:filter_value_okay();">&#xA0;&#xA0;<i18n:text>OK</i18n:text>&#xA0;&#xA0;</i2:button>
                        </TD>
                    </TR>
                    </table>
                    <script>
                          i2uiToggleItemVisibility('string_table', 'hide');
                          i2uiToggleItemVisibility('number_table', 'hide');
                          i2uiToggleItemVisibility('date_table', 'hide');
                          i2uiToggleItemVisibility('valid_value_table', 'hide');
                    </script>
                  </FORM>
                  </td>
            </tr>
       </table>
    </i2:container>
  </xsl:template>
    <!--**************************************************
  *********************************************************************** -->
  <xsl:template name="FILTER_EXPRESSION">
    <xsl:variable name="title">
      <b><i18n:text>Expression Editor</i18n:text></b>
    </xsl:variable>

    <i2:container id="expression_container" inner="yes"  title="{$title}" stretch="yes" >
      <FORM name="filter_value_form" method="POST">
        <!-- hidden fields -->
        <input type="hidden" name="XML_STRING_FILTER" value=""/>
        <xsl:variable name="showAllFields">
            <xsl:choose>
                <xsl:when test="/RESPONSES/RESPONSE/SHOW_ALL_FIELDS/@Value='yes'">yes</xsl:when>
                <xsl:otherwise>no</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>


        <input type="hidden" name="SHOW_ALL_FIELDS" value="{$showAllFields}"/>
        <input type="hidden" name="ACTIVITY_ID" value="{/RESPONSES/RESPONSE/ACTIVITY_ID[1]/@Value}"/>
        <xsl:choose>
          <xsl:when test="/RESPONSES/RESPONSE/PAGE and string-length(/RESPONSES/RESPONSE/PAGE/@Value) > 0 ">
                <input type="hidden" name="FILTER_TEXT" value="{/RESPONSES/RESPONSE/FILTER_TEXT/@Value}"/>
                <input type="hidden" name="FILTER_NAME" value="{/RESPONSES/RESPONSE/FILTER_NAME/@Value}"/>
                <input type="hidden" name="FILTER_MODE" value="{/RESPONSES/RESPONSE/FILTER_MODE/@Value}"/>
                <input type="hidden" name="FILTER_ID" value="{/RESPONSES/RESPONSE/FILTER_ID/@Value}"/>
                <input type="hidden" name="PAGE" value="{/RESPONSES/RESPONSE/PAGE/@Value}"/>
                <input type="hidden" name="FORM_NAME" value="{/RESPONSES/RESPONSE/FORM_NAME/@Value}"/>
                <input type="hidden" name="SERVICE" value="{/RESPONSES/RESPONSE/SERVICE[1]/@Value}"/>
                <input type="hidden" name="FROM_PAGE_FORM_NAME" value="{/RESPONSES/RESPONSE/FORM_NAME/@Value}"/>
                <input type="hidden" name="DO_SEARCH" value="Yes"/>
          </xsl:when>
          <xsl:otherwise>
                <input type="hidden" name="FILTER_TEXT" value=""/>
                <input type="hidden" name="FILTER_NAME" value="{/RESPONSES/RESPONSE/FILTER_NAME/@Value}"/>
                <input type="hidden" name="FILTER_MODE" value="{/RESPONSES/RESPONSE/FILTER_MODE/@Value}"/>
                <input type="hidden" name="FILTER_ID" value="{/RESPONSES/RESPONSE/FILTER_ID/@Value}"/>
                <input type="hidden" name="TABLE_NAME" value="{/RESPONSES/RESPONSE/TABLE_NAME[1]/@Value}"/>
                <input type="hidden" name="SERVICE" value="{/RESPONSES/RESPONSE/SERVICE[1]/@Value}"/>
                <input type="hidden" name="DIRECTORY" value="{/RESPONSES/RESPONSE/DIRECTORY[1]/@Value}"/>
                <input type="hidden" name="FILE" value="{/RESPONSES/RESPONSE/FILE[1]/@Value}"/>
                <input type="hidden" name="DO_SEARCH" value="Yes"/>
          </xsl:otherwise>
        </xsl:choose>


       <table id="expression_table">
              <tr>
                <td nowrap="yes" width="100%">
                 <TEXTAREA name="filter_string" tabIndex="" class="noneditable" disabled="yes" maxlength="550" size="50" cols="50" rows="20">
                                <xsl:value-of select="DESCRIPTION/@Value"/>
                 </TEXTAREA>
                </td>
            </tr>
       </table>
        <table border="0" id="button_table" cellpadding="0" cellspacing="4">
          <TR>
            <TD colspan="2" align="right"/>
            <TD style="margin-right:4px"><i2:button onclick="javascript:filter_value_undo();">&#xA0;&#xA0;<i18n:text>Undo</i18n:text>&#xA0;&#xA0;</i2:button></TD>
            <TD colspan="2" align="right"/>
            <TD style="margin-right:4px"><i2:button onclick="javascript:filter_value_clear();">&#xA0;&#xA0;<i18n:text>Clear</i18n:text>&#xA0;&#xA0;</i2:button></TD>
           </TR>
        </table>
      </FORM>
    </i2:container>
  </xsl:template>
  <!-- page.xsl Javascript -->
    <!-- **********************************************************************
    *********************************************************************** -->
    <xsl:template name="onLoad_js">
          function onLoad()
          {
    
           hide_all();
    
          var xmlFilterPresent =   '<xsl:choose>
          <xsl:when test="/RESPONSES/RESPONSE/FILTER_DETAILS">true</xsl:when>
          <xsl:otherwise>false</xsl:otherwise>
         </xsl:choose>'  ;
    
          //alert("xmlFilterPresent="+xmlFilterPresent);
    
          if(xmlFilterPresent == 'true')
              {
                  var xmlDisplayString =
                  "<xsl:for-each select="/RESPONSES/RESPONSE/FILTER_DETAILS/DISPLAY/STEP">
                      <xsl:value-of select="@Value "/><xsl:text>#</xsl:text>
                  </xsl:for-each>";
                 //alert("xmlDisplayString=" + xmlDisplayString);
                 
                 var xmlLogicalString =
                  "<xsl:for-each select="/RESPONSES/RESPONSE/FILTER_DETAILS/LOGICAL/STEP">
                      <xsl:value-of select="@Value"/><!--xsl:text>#</xsl:text-->
                  </xsl:for-each>";
                //alert("xmlLogicalString=" + xmlLogicalString);
    
                //alert(filter_by_name + filter_by_name.length);
                //alert(filter_by_title + filter_by_title.length);
                // replace the less than letter
                <![CDATA[
                xmlDisplayString = xmlDisplayString.replace("^lt;","<" );
                xmlLogicalString = xmlLogicalString.replace("^lt;","<" );
                 ]]>
                //alert("xmlDisplayString=" + xmlDisplayString);
    
                populate_array(filter_by_title ,  xmlDisplayString , 0);
                //populate_array(filter_by_name ,  xmlLogicalString, 0);
                filter_by_name.push(xmlLogicalString)
    
                //alert(filter_by_name + "    size=" + filter_by_name.length);
                //alert(filter_by_title + "   size="  + filter_by_title.length);
    
                display_filter();
                AND_OR_valid = true;
                //alert("inside xmlString="+ AND_OR_valid);
                field_box_valid=false;
                bracket_open_valid=false;
                bracket_close_valid=false;
              }
           i2uiResizeScrollableContainer('container',document.body.offsetHeight - 100, null, document.body.offsetWidth - 15, true, 'yes');
          }
    </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
 <!-- Calendar Javascript -->
  <xsl:template name="include_javascript_calendar">
     <i2:javascript path="/calendar.js"></i2:javascript>
  </xsl:template>
  <!-- Javascript -->
 <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="include_javascript_tableeditor_filter">
    <script>
     <![CDATA[
  
        var filter_by_name = new Array();
        var filter_by_title = new Array();
  
        Array.prototype.pop = pop;
        Array.prototype.push = push;
  
        var correct_form_element_field_desc = null;
        var action ;
  
        var unmatched_braces = 0;
        var AND_OR_valid = false;
        var bracket_open_valid = true;
        var bracket_close_valid = false;
  
        //var field_desc_pane_valid = false;
        var field_box_valid = true
  
       function pop()
         {
           if ( this.length < 1 ){ core_alert("Assertion failed!!!"); return null;}
           return this[--this.length];
         }
  
         function push(elem)
         {
           //alert("pushing it = " +    elem );
           this[this.length] = elem;
         }
  
         function populate_array(array, str , index)
         {
  
            var  i =  str.indexOf('#') ;
            if(i  > 0)
            {
              //alert("pusing array_elem=" + str.substring(0, i ));
              //alert("array_index="+ index);
              array[index]   = str.substring(0, i );
              //alert("now string is="+ str.substring(i+1 , str.length ));
              populate_array(array, str.substring(i+1 , str.length ) , ++index);
            }
  
         }
  
         function invalidate_all()
         {
           //field_desc_pane_valid = false;
           field_box_valid = false;
           AND_OR_valid = false;
           bracket_open_valid = false;
           bracket_close_valid = false;
         }
       function field_desc_on_focus()
     {
       //correct_form_element_field_desc.focus();
      //alert("field_desc_on_focus called");
     }
     function filter_value_clear()
       {
        // is_data_dirty_p = true;
           unmatched_braces = 0;
           filter_by_name = new Array();
           filter_by_title = new Array();
           display_filter();
           invalidate_all();
           field_box_valid = true;
           bracket_open_valid = true;
           //update_field_desc_pane(clearText);
       }
  
      function populate_field_properties ( columnSelector ) {
         //alert("populate_field_properties=" +    columnSelector );
       if (!field_box_valid)
       {
          core_alert("Please select a group operation first");
          columnSelector.selectedIndex = -1;
          return;
       }
           var validvalueList  = document.field_desc_form.valid_value;
       var len = validvalueList.options.length;
       for(var i = (len-1); i >= 0; i--)
       {
          validvalueList.options[i] = null;
       }
  
         var selected_column_name = columnSelector[columnSelector.selectedIndex].value;
         var selected_column_displayname = columnSelector[columnSelector.selectedIndex].text;
         var selected_column_type = columnSelector[columnSelector.selectedIndex].type;
         <!-- change made for issue 538330 -->
         var selected_column_i18ntype = columnSelector[columnSelector.selectedIndex].type;
         var selected_column_validvalues = columnSelector[columnSelector.selectedIndex].validValues;
         <!-- change made for issue 538330 -->
  
         if ( selected_column_name!="" )
          {
                i2uiToggleItemVisibility('desc_table', 'show');
                i2uiToggleItemVisibility('button_table', 'show');
  
            //set the operation value to default '='
                document.field_desc_form.operation.value='=';
                // set the disabled text fields with values
                document.field_desc_form.field_sel_by_name.value =   selected_column_name;
                document.field_desc_form.field_name_display.value =   selected_column_displayname;
                document.field_desc_form.field_sel_data_type.value =   selected_column_i18ntype;
                document.field_desc_form.field_orig_type.value =   selected_column_type;
                //var valid_value_no = customSplit(selected_column_validvalues,"|","NewArray");
                //valid_value_string = arraySplit(selected_column_validvalues,"|","NewArray");
                var valid_value_string = selected_column_validvalues.split("|");
            for(i=0;i<(valid_value_string.length-1);i++)
                {
                  document.field_desc_form.valid_value.options[i] = new Option(valid_value_string[i],valid_value_string[i]);
                }
  
                if (selected_column_validvalues !='' && (selected_column_type== 'string' || selected_column_type== 'boolean'))
            {
  
           i2uiToggleItemVisibility('string_table', 'hide');
           i2uiToggleItemVisibility('number_table', 'hide');
           i2uiToggleItemVisibility('date_table', 'hide');
           i2uiToggleItemVisibility('valid_value_table', 'show');
  
                }
                else if(selected_column_validvalues !='' && selected_column_type== 'int')
          {
  
        i2uiToggleItemVisibility('string_table', 'hide');
        i2uiToggleItemVisibility('number_table', 'hide');
        i2uiToggleItemVisibility('date_table', 'hide');
        i2uiToggleItemVisibility('valid_value_table', 'show');
                }
                else if(selected_column_type== 'string')
                {
                   i2uiToggleItemVisibility('string_table', 'show');
                   i2uiToggleItemVisibility('number_table', 'hide');
                   i2uiToggleItemVisibility('date_table', 'hide');
                   i2uiToggleItemVisibility('valid_value_table', 'hide');
                   document.field_desc_form.value_box_str.value='';
                   document.field_desc_form.value_box_str.focus();
  
                }
                else if (selected_column_type== 'date' || selected_column_type== 'datetime')
                {
  
                   i2uiToggleItemVisibility('string_table', 'hide');
                   i2uiToggleItemVisibility('number_table', 'hide');
                   i2uiToggleItemVisibility('date_table', 'show');
                   i2uiToggleItemVisibility('valid_value_table', 'hide');
                   document.field_desc_form.value_box_date_DC.value='';
                   document.field_desc_form.value_box_date_DC.focus();
  
                }
  
                else if (selected_column_type== 'int' || selected_column_type== 'double' )
                {
                   i2uiToggleItemVisibility('string_table', 'hide');
                   i2uiToggleItemVisibility('number_table', 'show');
                   i2uiToggleItemVisibility('date_table', 'hide');
  
                   i2uiToggleItemVisibility('valid_value_table', 'hide');
                   document.field_desc_form.value_box_num.value='';
                   document.field_desc_form.value_box_num.focus();
                }
  
  
  
          }
       //field_desc_pane_valid = true;
       field_box_valid = true;
  
       //bracket_open_valid = true;
      }
  
  
      function hide_all()
       {
  
         i2uiToggleItemVisibility('desc_table', 'hide');
         i2uiToggleItemVisibility('button_table', 'hide');
         i2uiToggleItemVisibility('string_table', 'hide');
         i2uiToggleItemVisibility('number_table', 'hide');
         i2uiToggleItemVisibility('date_table', 'hide');
         i2uiToggleItemVisibility('valid_value_table', 'hide');
  
  
       }
       function resetFlagOnCancel()
       {
             //reset the flag on basis of previous step
             if( filter_by_name.length  >  0 )
               {
                 //alert( filter_by_name[ filter_by_name.length - 1 ] );
                  if ( filter_by_name[ filter_by_name.length - 1 ] == "(" )
                   {
                       //alert( ' previous op ( ' ) ;
                       unmatched_braces--;
                       invalidate_all();
                       bracket_open_valid = true;
                       if(unmatched_braces == 0 )
                          bracket_close_valid = false;
                       else
                          bracket_close_valid = true;
                       field_box_valid = true;
                       //field_desc_pane_valid = true;
                   }
                  else if ( filter_by_name[ filter_by_name.length - 1 ] == ")" )
                  {
                    //alert( ' previous op ) ' ) ;
                    unmatched_braces++;
                    invalidate_all();
                    if(unmatched_braces == 0 )
                       bracket_close_valid = false;
                    else
                      bracket_close_valid = true;
                    AND_OR_valid = true;
                  }
                  else if (  filter_by_name[ filter_by_name.length - 1 ] == "AND" ||  filter_by_name[ filter_by_name.length - 1 ] == "OR"   )
                  {
                    //alert( ' previous op and/or' ) ;
                     invalidate_all()
                     field_box_valid = false;
                     //field_desc_pane_valid = false;
                     bracket_open_valid = false;
                     // anish added
                     AND_OR_valid = true;
                  }
                  else
                  {
                    //alert ( "previous text field filter");
                    field_box_valid = true;
                    if(unmatched_braces == 0 )
                       bracket_open_valid = true;
                    else
                      bracket_close_valid = true;
                    AND_OR_valid = false;
                    //field_desc_pane_valid = true;
  
                  }
           }//end of if
  
       }//end of function
  
        function filter_value_undo()
       {
         //update_field_desc_pane(clearText);
         //field_desc_pane_valid = false;
  
          if(filter_by_name.length > 0 )
           {
  
               //alert (filter_by_name[filter_by_name.length -1 ]) ;
               //reset the flags on basis of previous operation
               resetFlagOnCancel();
               filter_by_name.pop();
               filter_by_title.pop();
           }
  
          display_filter();
       }
  
      function filter_value_okay()
      {
        //alert("calling filter_value_okay" );
        //if (!field_desc_pane_valid) return;
        if (!field_box_valid)
       {
          core_alert("Please select a group operation first");
          return;
       }
        var whitespace = " ";
        var filter_value = "";
        var val ;
        var dataType =  document.field_desc_form.field_orig_type.value ;
         var operation = document.field_desc_form.operation[field_desc_form.operation.selectedIndex].value;
        //alert(document.field_desc_form.valid_value.options.length);
        if(document.field_desc_form.valid_value.options.length > 0)
        {
          var str = document.field_desc_form.valid_value.value;
          val = str;
          //alert(val);
        }
        else if(dataType  == 'string' )
          {
                var str = document.field_desc_form.value_box_str.value;
                //alert(str);
                if(str == "")
                {
                  core_alert("Please enter  filter text");
                  return;
                }
                if(!checkQuote(str))
                  {
                      core_alert("Double quote not allowed.");
                      return;
                  }
                val = str;
          }
  
       else if (dataType  == 'int'  || dataType  == 'double' )
         {
                var numValue = document.field_desc_form.value_box_num.value;
               if(numValue == "")
                {
                  core_alert("Please enter  filter text");
                  return;
                }
                if (operation!='in' && operation!='not in')
            {
             if(isNaN(numValue))
              {
                core_alert("Please enter numeric filter text");
                return;
              }
        }
  
           val = numValue;
      }
      else if (dataType  == 'date' || dataType== 'datetime')
       {
             var dateValue = document.field_desc_form.value_box_date_DC.value;
             if(dateValue == "")
             {
                core_alert("Please enter  filter text");
                return;
              }
           if(!(dateValue.indexOf('/') > -1))
       {
         core_alert("Please enter a valid date(mm/dd/yyyy) in the filter text.");
         return;
            }
           val = trimString(dateValue);
     }
  
         //alert("val=" + val);
  
         var operation_text = document.field_desc_form.operation[field_desc_form.operation.selectedIndex].text;
         filter_value +=   val ;
  
  
          // POPULATE THE ARRAY FOR DISPLAY AND FOR ACTUAL QUERY
          var by_name;
          var by_title;
  
          if (operation=='in' || operation=='not in')
          {
            //alert("operation"+operation);
            filter_list = "";
            var pos = -1;
            var filterstring ="";
            var tempfilter=trimString(filter_value);
            while (tempfilter.indexOf(',')>-1) {
              pos= tempfilter.indexOf(',');
              filterstring = "#[" + trimString(tempfilter.substring(0, pos))+ "]#,";
              tempfilter = trimString(tempfilter.substring(pos+1, tempfilter.length));
              //alert("tempfilter-"+tempfilter);
              filter_list = filter_list + filterstring;
              //alert("filter_list-"+filter_list);
            }
            filter_list = filter_list +"#[" +tempfilter+ "]#";
            by_name =   whitespace + "#|" + document.field_desc_form.field_sel_by_name.value  +"|#"+ whitespace +  operation + whitespace + "(" + filter_list + ")" + whitespace ;
          }
          else if(operation=='is not null' || operation=='is null')
          {
            by_name =  whitespace + "#|" + document.field_desc_form.field_sel_by_name.value  + "|#"+ whitespace +  operation + whitespace +  filter_value + whitespace;
            by_title =   document.field_desc_form.field_name_display.value +  whitespace +   operation_text + whitespace  ;
  
          }
          else
          {
            by_name =  whitespace + "#|" + document.field_desc_form.field_sel_by_name.value  + "|#"+ whitespace +  operation + whitespace + "#[" +  filter_value + "^"+document.field_desc_form.field_orig_type.value+"]#" + whitespace  ;
            by_title =   document.field_desc_form.field_name_display.value +  whitespace +   operation_text + whitespace +  filter_value  ;
          }
  
            //alert( by_name) ;
            var by_title = "";
          if (operation=='in' || operation=='not in')
          {
  
            by_title =   whitespace + document.field_desc_form.field_name_display.value +  whitespace +   operation + whitespace + "("+ filter_value +")" ;
            }
            else
            {
            by_title =   whitespace + document.field_desc_form.field_name_display.value +  whitespace +   operation + whitespace +  filter_value  ;
            }
            //alert( by_title) ;
            filter_by_name.push( by_name );
            filter_by_title.push( by_title );
  
        display_filter();
  
        invalidate_all();
  
        if(unmatched_braces == 0 )
           bracket_close_valid = false;
        else
          bracket_close_valid = true;
        AND_OR_valid = true;
  
        //is_data_dirty_p = true;
        //alert("DONE");
  
      }
  
      function group_operation(selection)
       {
               if (selection == "(")
               {
                 if (bracket_open_valid)
                 {
                    filter_by_name.push(selection);
                    filter_by_title.push(selection);
  
                    unmatched_braces++;
                    invalidate_all();
                     bracket_open_valid = true;
                     bracket_close_valid = true;
                     field_box_valid = true;
                     //field_desc_pane_valid = true;
                 }
               }
               else if ( selection == ")")
               {
                 if ( bracket_close_valid  )
                 {
                  if (filter_by_name[ filter_by_name.length - 1 ] == "(")
                  {
                      core_alert("Please add some filter expression first");
                      return;
                  }
  
                  filter_by_name.push(selection);
                  filter_by_title.push(selection);
  
                  unmatched_braces--;
                  invalidate_all();
                  if(unmatched_braces == 0 )
                     bracket_close_valid = false;
                  else
                    bracket_close_valid = true;
                  AND_OR_valid = true;
                 }
               }
               else if(AND_OR_valid)
               {
                 filter_by_name.push(selection);
                 filter_by_title.push(selection);
  
                 invalidate_all()
                 field_box_valid = true;
                 //field_desc_pane_valid = true;
                 bracket_open_valid = true;
                 // anish added
                 AND_OR_valid = false;
               }
               display_filter();
  
  
       }
  
      function display_filter ( )
      {
  
         var str = "";
         for( i = 0 ; i < filter_by_title.length ; i++)
           str += filter_by_title[i] + " " ;
  
         //alert("filter_by_title str = " + str) ;
  
         document.filter_value_form.filter_string.value = str ;
         document.filter_value_form.FILTER_TEXT.value = str ;
  
      }
      function  display_filter_by_name ( )
      {
  
         var str = "";
         for( i = 0 ; i < filter_by_name.length ; i++)
           str += filter_by_name[i] + " " ;
  
         //alert("filter_by_name str = " + str) ;
  
         return str ;
  
      }
      function replaceChars(entry) {
            var out = "*"; // replace this
            var add = "%"; // with this
            var temp = "" + entry; // temporary holder
  
            while (temp.indexOf(out)>-1) {
              var pos= temp.indexOf(out);
              temp = "" + (temp.substring(0, pos) + add + temp.substring((pos + out.length), temp.length));
            }
            return temp;
        }
       function  onApplyAndReturn ( )
      {
          if (unmatched_braces != 0)
          {
          core_alert("Please complete the open braces.");
          return;
          }
          if (! AND_OR_valid)
          {
          core_alert("Please complete the expression.");
          return;
          }
         var whitespace = " ";
         var xml_string = "";
         xml_string += "<FILTER_DETAILS><DISPLAY>";
  
         for( i = 0 ; i < filter_by_title.length ; i++)
           xml_string += "<STEP Value=\"" +  filter_by_title[i].replace("<","^lt;" ) + "\"" + whitespace + "Sequence=\"" + i  + "\"" + whitespace  + "/>" ;
  
         xml_string += "</DISPLAY>";
  
         //alert("xml_filter_by_title str = " + xml_string) ;
  
         xml_string += "<LOGICAL>";
  
         for( i = 0 ; i < filter_by_name.length ; i++)
         {
          xml_string += "<STEP Value=\"" +  replaceChars( filter_by_name[i].replace("<","^lt;" ) ) + "\"" + whitespace + "Sequence=\"" + i  + "\"" + whitespace  + "/>" ;
         }
  
         xml_string += "</LOGICAL></FILTER_DETAILS>";
  
         //alert("xml_filter_by_name str = " + xml_string) ;
  
  
  
         document.filter_value_form.XML_STRING_FILTER.value = xml_string ;
  
         document.filter_value_form.target="appFrame";
         document.filter_value_form.action="controller/applyFilter.cmd";
         displayBusyBox();
         document.filter_value_form.submit();
      }
  
  function checkQuote(filterValue)
  {
      var nStringLen = filterValue.length;
  
      for(var i = 0; i < nStringLen; i++)
      {
        var cChar = filterValue.charAt(i);
        if(cChar == '"')
        {
        return false;
        }
     }
     return true;
  }
      function makeArray(IntarrSize) {
  
        for (var n = 0; n < IntarrSize; n++)
          this[n] = "";
  
        return this;
  
      }
  
  //  Split the argument string into an array of strings.-Mithun
  //  To get the number of string in an argument String
      function customSplit(strvalue, separator, arrayName)
      {
        var n = 0;
        if (separator.length != 0)
        {
          while (strvalue.indexOf(separator) != -1)
          {
            eval("arr"+n+" = strvalue.substring(0, strvalue.indexOf(separator));");
            strvalue = strvalue.substring(strvalue.indexOf(separator)+separator.length,
            strvalue.length+1);
            n++;
          }
          eval("arr" + n + " = strvalue;");
          arraySize = n+1;
        }
        else
        {
          for (var x = 0; x < strvalue.length; x++)
          {
            eval("arr"+n+" = \"" + strvalue.substring(x, x+1) + "\";");
            n++;
          }
          arraySize = n;
        }
        eval(arrayName + " = new makeArray(arraySize);");
        for (var i = 0; i < arraySize; i++)
        eval(arrayName + "[" + i + "] = arr" + i + ";");
  
        return arraySize;
      }
  
  //  To get the strings in an argument String
      function arraySplit(strvalue, separator, arrayName)
      {
        var n = 0;
        if (separator.length != 0)
        {
          while (strvalue.indexOf(separator) != -1)
          {
            eval("arr"+n+" = strvalue.substring(0, strvalue.indexOf(separator));");
            strvalue = strvalue.substring(strvalue.indexOf(separator)+separator.length,
            strvalue.length+1);
            n++;
          }
          eval("arr" + n + " = strvalue;");
          arraySize = n+1;
        }
        else
        {
          for (var x = 0; x < strvalue.length; x++)
          {
            eval("arr"+n+" = \"" + strvalue.substring(x, x+1) + "\";");
            n++;
          }
          arraySize = n;
        }
  
        eval(arrayName + " = new makeArray(arraySize);");
        for (var i = 0; i < arraySize; i++)
        eval(arrayName + "[" + i + "] = arr" + i + ";");
        return arrayName;
      }
  
      function showHideFilterValueBox(operation)
      {
        var parent_object = operation.options;
        var selected_property_type = document.field_desc_form.field_sel_data_type.value;
        var valid_value_type = "false";
        if(document.field_desc_form.valid_value.length > 1)
        {
               var valid_value_type = "true";
        }
        //alert(valid_value_type);
        if ( (parent_object[parent_object.selectedIndex].value == "is not null") || parent_object[parent_object.selectedIndex].value == "is null")
        {
          i2uiToggleItemVisibility('string_table', 'hide');
          i2uiToggleItemVisibility('number_table', 'hide');
          i2uiToggleItemVisibility('date_table', 'hide');
          i2uiToggleItemVisibility('valid_value_table','hide');
          document.field_desc_form.value_box_str.value = " ";
          document.field_desc_form.value_box_num.value = " ";
          document.field_desc_form.value_box_date_DC.value = " ";
        }
        else if(valid_value_type == "true")
        {
          i2uiToggleItemVisibility('string_table', 'hide');
      i2uiToggleItemVisibility('number_table', 'hide');
      i2uiToggleItemVisibility('date_table', 'hide');
          i2uiToggleItemVisibility('valid_value_table', 'show');
        }
        else {
          if(valid_value_type == "true" && selected_property_type == 'string')
       {
         i2uiToggleItemVisibility('string_table', 'hide');
         i2uiToggleItemVisibility('number_table', 'hide');
         i2uiToggleItemVisibility('date_table', 'hide');
         i2uiToggleItemVisibility('valid_value_table', 'show');
         //document.field_desc_form.value_box_str.value='';
         //document.field_desc_form.value_box_str.focus();
        }
          else if(selected_property_type == 'string')
           {
             i2uiToggleItemVisibility('string_table', 'show');
             i2uiToggleItemVisibility('number_table', 'hide');
             i2uiToggleItemVisibility('date_table', 'hide');
             i2uiToggleItemVisibility('valid_value_table', 'hide');
             document.field_desc_form.value_box_str.value='';
             document.field_desc_form.value_box_str.focus();
            }
          else if (selected_property_type == 'date' || selected_property_type == 'datetime')
            {
               i2uiToggleItemVisibility('string_table', 'hide');
               i2uiToggleItemVisibility('number_table', 'hide');
               i2uiToggleItemVisibility('date_table', 'show');
               i2uiToggleItemVisibility('valid_value_table', 'hide');
              document.field_desc_form.value_box_date_DC.value='';
              document.field_desc_form.value_box_date_DC.focus();
            }
          else if (selected_property_type == 'int' || selected_property_type == 'double' )
            {
             i2uiToggleItemVisibility('string_table', 'hide');
             i2uiToggleItemVisibility('number_table', 'show');
             i2uiToggleItemVisibility('date_table', 'hide');
             i2uiToggleItemVisibility('valid_value_table', 'hide');
             document.field_desc_form.value_box_num.value='';
             document.field_desc_form.value_box_num.focus();
            }
  
        }
  
      }
  
      function showAllProperties()
      {
         document.filter_value_form.SHOW_ALL_FIELDS.value="yes";
         document.filter_value_form.target="appFrame";
         document.filter_value_form.action="controller/display.cmd";
         document.filter_value_form.submit();
  
      }
  
      function showSearchProperties()
      {
         document.filter_value_form.SHOW_ALL_FIELDS.value="no";
         document.filter_value_form.target="appFrame";
         document.filter_value_form.action="controller/display.cmd";
         document.filter_value_form.submit();
      }
  
      function back()
      {
        document.filter_value_form.target="appFrame";
        document.filter_value_form.action=omxContextPath+ "/bcm/framework/breadcrumb/controller/back.cmd";
        document.filter_value_form.submit();
      }
  
      function onResize()
      {
        i2uiResizeScrollableContainer('container',document.body.offsetHeight - 100, null, document.body.offsetWidth - 15, true, 'yes');
      }
  
  
    ]]>
  
    </script>
</xsl:template>

<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>


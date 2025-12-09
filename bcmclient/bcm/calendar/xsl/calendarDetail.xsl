<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../framework/queryform/xsl/searchformfilter.xsl"/>
  <xsl:import href="../../framework/xsl/code_master.xsl"/>
  <xsl:import href="../../context/xsl/context_header.xsl"/>
  <xsl:output method="html"/>
  <!-- Page Content -->    
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:variable name="flag">
    <xsl:choose>
      <xsl:when test=" /RESPONSES/RESPONSE/CALENDAR_HEADER/MODE/@Value = 'EDIT'
                                  or /RESPONSES/RESPONSE/HEADER_CONTEXT/CALENDAR/MODE/@Value = 'EDIT'
                                 or /RESPONSES/RESPONSE/HEADER_CONTEXT/LOCATION/MODE/@Value = 'EDIT'
                                 or /RESPONSES/RESPONSE/HEADER_CONTEXT/RESOURCE/MODE/@Value = 'EDIT'
                                 or /RESPONSES/RESPONSE/HEADER_CONTEXT/LOCATION/assignMode/@Value = 'EDIT'
                                 or /RESPONSES/RESPONSE/HEADER_CONTEXT/RESOURCE/assignMode/@Value = 'EDIT'
                                  or /RESPONSES/RESPONSE/HEADER_CONTEXT/DL/MODE/@Value = 'EDIT'">
        <xsl:value-of select="'TRUE'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'FALSE'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test=" /RESPONSES/RESPONSE/CALENDAR_HEADER/class/@Value = 'Generic'
                                  or /RESPONSES/RESPONSE/HEADER_CONTEXT/CALENDAR/class/@Value = 'Generic'
                                 or /RESPONSES/RESPONSE/HEADER_CONTEXT/LOCATION/class/@Value = 'Generic'
                                  or /RESPONSES/RESPONSE/HEADER_CONTEXT/DL/class/@Value = 'Generic'
                                  or string-length(/RESPONSES/RESPONSE/HEADER_CONTEXT//class/@Value) = 0"
                                  >
        <xsl:value-of select="'Generic'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="/RESPONSES/RESPONSE/HEADER_CONTEXT//class/@Value"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:template match="RESPONSES" mode="content">
    <xsl:if test="RESPONSE/HEADER_CONTEXT/RESOURCE or RESPONSE/HEADER_CONTEXT/LOCATION or RESPONSE/HEADER_CONTEXT/DL ">
      <xsl:apply-templates select="RESPONSE/HEADER_CONTEXT"/>
    </xsl:if>
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_calendar_detail"/>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <!-- Body -->
    <table id="top_table" border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td width="30%">
          <xsl:apply-templates select="CALENDAR_HEADER"/>
        </td>
      </tr>
      <tr>
        <td>
          <xsl:if test="$flag='TRUE' and ($class='Generic' or string-length($class)=0)">
            <xsl:apply-templates select="SEARCH">
              <xsl:with-param name="formName" select="'result_form'"/>
            </xsl:apply-templates>
          </xsl:if>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="CALENDAR_HEADER">
    <xsl:call-template name="display_instruction_area"/>
    <form name="cal_header_form" action="POST">
      <input name="calendarID" type="hidden" value="{calendarID/@Value}"/>
      <input name="RETURN" type="hidden" value=""/>
      <input name="SERVICE" type="hidden" value=""/>
      <input name="DO_SEARCH" type="hidden" value=""/>
      <input name="FORM_NAME" type="hidden" value=""/>
      <xsl:if test="$flag='TRUE'">
        <input type="hidden" name="calendarTypeID" value="{calendarTypeID/@Value}"/>
      </xsl:if>
      <table id="context_table">
        <tr>
          <td nowrap="nowrap">
        &#xA0;
        <i18n:text>Calendar Name
        </i18n:text>
            <xsl:text>:</xsl:text>
            <xsl:call-template name="display_alert_mark"/>
          </td>
          <td nowrap="nowrap">
             &#xA0;
            <input type="field" name="name" value="{name/@Value}" required="true" class="inputfieldIE" maxlength="32" size="20"/>
            <xsl:call-template name="display_alert_image">
              <xsl:with-param name="fieldName" select="'name'"/>
            </xsl:call-template>
          </td>
          <td nowrap="nowrap">
        &#xA0; 
        <i18n:text>Description
        </i18n:text>
            <xsl:text>:</xsl:text>
          </td>
          <td nowrap="nowrap">
           &#xA0;<input type="field" name="description" value="{description/@Value}" class="inputfieldIE" maxlength="32" size="20"/>
          </td>
        </tr>
        <tr>
          <td nowrap="nowrap">
        &#xA0;
        <i18n:text>Category
        </i18n:text>
            <xsl:text>:</xsl:text>
          </td>
          <td nowrap="nowrap">
           &#xA0;
          <input type="field" name="category" value="{category/@Value}" class="inputfieldIE" maxlength="32" size="20"/>
          </td>
          <td nowrap="nowrap">
        &#xA0; 
        <i18n:text>Availability UOM
        </i18n:text>
            <xsl:text>:</xsl:text>
            <!--xsl:call-template name="display_alert_mark"/-->
          </td>
          <td align="left">
           &#xA0;
          <select class="inputfieldIE" name="UOM" required="true" tabIndex="">
              <option value="">
                <i18n:text>Select...</i18n:text>
              </option>
              <xsl:choose>
                <xsl:when test="string-length(UOM/@Value) &gt; 0">
                  <xsl:apply-templates select="UOMS/CODE_MASTER_VALUE" mode="pulldown_value_id">
                    <xsl:with-param name="selectedId" select="UOM/@Value"/>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="UOMS/CODE_MASTER_VALUE" mode="pulldown_value_id"/>
                </xsl:otherwise>
              </xsl:choose>
            </select>
            <!--xsl:call-template name="display_alert_image">
              <xsl:with-param name="fieldName" select="'UOM'"/>
            </xsl:call-template-->
          </td>
        </tr>
        <tr>
          <td nowrap="nowrap">
        &#xA0;
        <i18n:text>Sub Category
        </i18n:text>
            <xsl:text>:</xsl:text>
          </td>
          <td nowrap="nowrap">
           &#xA0;
          <input type="field" name="subCategory" value="{subCategory/@Value}" class="inputfieldIE" maxlength="32" size="20"/>
          </td>
          <td nowrap="nowrap">
        &#xA0; 
        <i18n:text>Calendar Type
        </i18n:text>
            <xsl:text>:</xsl:text>
            <xsl:call-template name="display_alert_mark"/>
          </td>
          <td align="left">
           &#xA0;
            <select class="pulldown" name="calendarTypeID" required="true" tabIndex="">
              <xsl:if test="$flag='TRUE'">
                <xsl:attribute name="disabled">true</xsl:attribute>
              </xsl:if>
              <option value="">
                <i18n:text>Select...</i18n:text>
              </option>
              <xsl:apply-templates select="OPTIONS/PROPERTY/VALID_VALUE">
                <xsl:with-param name="calendarTypeID" select="calendarTypeID/@Value"/>
              </xsl:apply-templates>
            </select>
            <xsl:call-template name="display_alert_image">
              <xsl:with-param name="fieldName" select="'calendarTypeID'"/>
            </xsl:call-template>
          </td>
        </tr>
    <tr>
      <td>&#xA0;
      </td>
    </tr>
      </table>
        <xsl:if test="($flag='FALSE' or ($flag='TRUE' and $class!='Generic' and string-length($class)>0))">
        <table width="100%" cellpadding="0" cellspacing="0">
          <tr>
            <td>
              <table>
                <tr>
                  <td>&#xA0;
                  </td>
                </tr>
                <tr>
                <tr>
                  <td>&#xA0;
                  </td>
                </tr>
                  
          <td nowrap="nowrap">
        &#xA0;
        <i18n:text>GENERIC
        </i18n:text>
            <xsl:text>:</xsl:text>
          </td>
                </tr>

                <tr>
                  
                <td nowrap="nowrap">
        &#xA0;
                  <input type="radio" name="CalendarType" value="Generic">
           <xsl:if test="$class='Generic' or string-length($class)=0">
             <xsl:attribute name="checked">true</xsl:attribute>
           </xsl:if>
          <xsl:if test="$flag='TRUE' and $class!='Generic'">
            <xsl:attribute name="disabled">true</xsl:attribute>
          </xsl:if>
           
         User specified start, end and available quantity
         </input>
        </td>
                </tr>
                <tr>
                  <td>&#xA0;
                  </td>
                </tr>                
                <tr>
                  <td>&#xA0;
                  </td>
                </tr>
                <tr>
                  
           <td nowrap="nowrap">
           &#xA0;
            <i18n:text>SPECIALIZED CALENDARS
            </i18n:text>
            <xsl:text>:</xsl:text>
          </td>
                </tr>
                <tr>
        <td nowrap="nowrap">
        &#xA0;
                 <input type="radio" name="CalendarType" value="SpecialWeekly">
                    <xsl:if test="$class='SpecialWeekly'">
                      <xsl:attribute name="checked">true</xsl:attribute>
                    </xsl:if>
          <xsl:if test="$flag='TRUE' and $class!='SpecialWeekly'">
            <xsl:attribute name="disabled">true</xsl:attribute>
          </xsl:if>
                    
         Fixed Weekly Bucket
         </input>
        </td>
        <td>
        &#xA0; &#xA0;&#xA0;
           <i18n:text>Reference Horizon
           </i18n:text>
            <xsl:text>:</xsl:text>
        </td>
        <td align="left" width="20%">
           &#xA0;
            <xsl:choose>
                <xsl:when test="$flag='TRUE' and $class='SpecialWeekly'">
                    <select class="pulldown" name="refHorizonID" required="true" tabIndex="">
                      <option value="{/RESPONSES/RESPONSE/CALENDAR_HEADER/horizonID/@Value}">
                        <i18n:text><xsl:value-of select="/RESPONSES/RESPONSE/CALENDAR_HEADER/horizonID/@Value"/></i18n:text>
                      </option>  
                    </select>
                </xsl:when>
                <xsl:otherwise>
                    <select class="pulldown" name="refHorizonID" required="true" tabIndex="">
                      <option value="">
                    <i18n:text></i18n:text>
                      </option>
                       <xsl:apply-templates select="WeeklyHorizonData/RESPONSES/RESPONSE/HorizonMaster">
                       </xsl:apply-templates>
                    </select>
                </xsl:otherwise>
            </xsl:choose>    
        </td>
             </tr>
             <tr>
        <td nowrap="nowrap">
        &#xA0;
                <input type="radio" name="CalendarType" value="SpecialMonthly">
                    <xsl:if test="$class='SpecialMonthly'">
                      <xsl:attribute name="checked">true</xsl:attribute>
                    </xsl:if>
          <xsl:if test="$flag='TRUE' and $class!='SpecialMonthly'">
            <xsl:attribute name="disabled">true</xsl:attribute>
          </xsl:if>
                    
         Fixed Monthly Bucket
         </input>
        </td>
        <td>
         &#xA0; &#xA0;&#xA0;
          <i18n:text>Reference Horizon
          </i18n:text>
          <xsl:text>:</xsl:text>
        </td>
        <td align="left" width="20%">
           &#xA0;
            <xsl:choose>
                <xsl:when test="$flag='TRUE' and $class='SpecialMonthly'">
                    <select class="pulldown" name="refHorizonIDM" required="true" tabIndex="">
                      <option value="{/RESPONSES/RESPONSE/CALENDAR_HEADER/horizonID/@Value}">
                        <i18n:text><xsl:value-of select="/RESPONSES/RESPONSE/CALENDAR_HEADER/horizonID/@Value"/></i18n:text>
                      </option>  
                    </select>
                </xsl:when>
                <xsl:otherwise>
                    <select class="pulldown" name="refHorizonIDM" required="true" tabIndex="">
                      <option value="">
                    <i18n:text></i18n:text>
                      </option>
                       <xsl:apply-templates select="MonthlyHorizonData/RESPONSES/RESPONSE/HorizonMaster">
                       </xsl:apply-templates>
                    </select>
                </xsl:otherwise>
            </xsl:choose>      
            
        </td>
                </tr>
                <tr>
                  <td>&#xA0;
                  </td>
                </tr>
                <tr>
                  <td>&#xA0;
                  </td>
                </tr>
                <tr>
                  <td>&#xA0;
                  </td>
                </tr>

              </table>
     </td>
          </tr>
  
        </table>
        </xsl:if>
    </form>
  </xsl:template>

    <xsl:template match="HorizonMaster">
      <option value="{horizonID/@Value}">
      <i18n:text>
        <xsl:value-of select="horizonID/@Value"/>
      </i18n:text>
    </option>
  </xsl:template>
  
  <!-- Editable Select Option -->
  <!-- **********************************************************************
    *********************************************************************** -->
  <xsl:template match="VALID_VALUE">
    <xsl:param name="calendarTypeID"/>
    <xsl:choose>
      <xsl:when test="./@Description and ./@Value">
        <xsl:choose>
          <xsl:when test="./@Value = $calendarTypeID ">
            <option selected="yes" value="{./@Value}">
              <i18n:text>
                <xsl:value-of select="./@Description"/>
              </i18n:text>
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option value="{./@Value}">
              <i18n:text>
                <xsl:value-of select="./@Description"/>
              </i18n:text>
            </option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
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
  <xsl:template name="onResize_js">
     function onResize()
     {
       resize_Containers();
     }
   </xsl:template>
   
   
   <!-- overridden template for making pattern name as i18n -->
   <!-- Issue No : 532028 -->
      
      <xsl:template match="TD[ (not (@Type) or @Type = 'Text' or @Type = 'Date' or @Type = 'DateTime'  or @Type = 'Currency' or @Type = 'Number' or @Type='Select') and not(@Editable)]" mode="content">
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
                <xsl:value-of select="concat('javascript:sort(', $quote, @Name, $quote,',', @Sequence,',', $quote, $isSortable,$quote,',',$quote, $isFrozenAllowed,$quote,',',$quote,$formName,$quote,',',$quote,$columnCount,$quote, ')' )"/>
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
                  
                  <!-- Issue No 532028 for i18nize -->
                  <xsl:choose>
                  <xsl:when test="@Name='patternName'">
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
             <xsl:value-of select="@Value"/>          
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
            <xsl:if test="@Sortable ='yes' and $header='yes' and $sortBy = @Name">
              <!--b>
                <xsl:value-of select="$sortImage"/>
              </b-->
            </xsl:if>
          </nobr>
          </td>
     </xsl:template>
   
  <!-- custom javascript -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_calendar_detail">
    <script>
    function onDelete()
      {
        <!-- ISSUE : 532025 -->
        var confirmMesg = "CAL_ENTRY_REMOVE"

           if ( checkifAnySelected(result_form) == true )
            {
              if( core_confirm( confirmMesg ) == 'yes' )
                  {
                    document.result_form.action="detail/controller/deleteCalendarEntry.cmd";
                    document.result_form.submit();
                  }
            }
            else
           {
            <!-- ISSUE : 532026 -->
                core_alert("SEL_ONE_CAL");
            }
      }
     function onEdit()
      {
          if ( checkifAnySelected(result_form) == true )
            {
              if(checkifOneSelected (result_form))
               {
                document.result_form.action="detail/controller/editEntry.cmd";
                document.result_form.submit();
               }
               else
                 core_alert("<i18n:text>SEL_ONE_CAL</i18n:text>");
           }
          else
           {
                core_alert("<i18n:text>SEL_ONE_CAL</i18n:text>");
            }
      }
   function onCalendarTypeSelect()
   {
   alert("alert");
   }
    function resize_Containers()
    {
    
        <xsl:if test="$flag='TRUE' and $class='Generic'">         
            resizeScrollableTables();
        </xsl:if>    
    }
   
   <![CDATA[

   function onCancel()

      {       
                document.cal_header_form.DO_SEARCH.value ="Yes";
                document.cal_header_form.FORM_NAME.value = "CALENDAR_SRCH_FORM";
                document.cal_header_form.SERVICE.value = "BCMMasterService";
                document.cal_header_form.action="calendarSearch.jsp";
                document.cal_header_form.submit();
      }
      
   function onFixedCalCancel()
   {
       document.cal_header_form.action="FixedDetail/controller/showFixedCalDetails.cmd";
       document.cal_header_form.submit();

   }
   function onNext()
      {       
          error = "false";
          error = requiredFieldCheck();
          if ( error == 'false' )
          {
      var radioVal;
      var elementsLen = document.cal_header_form.elements.length;
          for(count = 0; count < elementsLen; count++)
          {      
               if( document.cal_header_form.elements[count].type == "radio"){

               radioVal = document.cal_header_form.elements[count].value;
               if((document.cal_header_form.elements[count].checked == true) && (radioVal=="Generic"))
                {
                document.cal_header_form.action="detail/controller/saveCalendarHeader.cmd";
                document.cal_header_form.submit();
                }
                else if((document.cal_header_form.elements[count].checked == true) && (radioVal=="SpecialWeekly" || radioVal=="SpecialMonthly"))
                {
                    if ((radioVal=="SpecialWeekly" && document.cal_header_form.refHorizonID.value != "") ||(radioVal=="SpecialMonthly" && document.cal_header_form.refHorizonIDM.value != ""))
                    {
            document.cal_header_form.action="detail/controller/saveCalendarHeader.cmd";
                    document.cal_header_form.submit();
                    }
                    else
                    {
                                 var elementsLen = document.cal_header_form.elements.length;
                    core_alert("Reference horizon not specified.Only Generic calendars can be created");

                              for(count = 0; count < elementsLen; count++)
                              {      
                               if( document.cal_header_form.elements[count].type == "radio"){
                                   document.cal_header_form.elements[count].value="Generic";
                                         }
                                      }
                        document.cal_header_form.action="detail/controller/saveCalendarHeader.cmd";
                    document.cal_header_form.submit();

                    }
                }
               }   
          }
          }
      }
     function onReturnToContext()

      {
                document.cal_header_form.action="search/controller/returnToContext.cmd";
                document.cal_header_form.submit();
      }
     function onSave()
      {
          error = "false";
          error = requiredFieldCheck();
          if ( error == 'false' )
          {
                document.cal_header_form.action="detail/controller/saveCalendarHeader.cmd";
                document.cal_header_form.submit();
          }
      }
      function onSaveAndReturn()
      {
          error = "false";
          error = requiredFieldCheck();
          if ( error == 'false' )
          {
                document.cal_header_form.RETURN.value="YES";
                document.cal_header_form.action="detail/controller/saveCalendarHeader.cmd";
                document.cal_header_form.submit();
          }
      }
      function onNewEntry()
      {
          error = "false";
          error = requiredFieldCheck();
          if ( error == 'false' )
          {
                document.cal_header_form.action="detail/controller/createNewEntry.cmd";
                document.cal_header_form.submit();
          }

      }

    function checkifOneSelected(form)
  {
    var count;
    var elementsLen = form.elements.length;
    var foundChecked = false;
    var index = 0;

    for(count = 0; count < elementsLen; count++)
        {
            if(
               form.elements[count].type == "checkbox" &&
               form.elements[count].checked == true  &&
               form.elements[count].name != "SELECT_ALL"
               )
                {
                    foundChecked = true;
                    index++;
                }
        }
      if( index == 1)
         return foundChecked;
     else
      {
         return false;
       }
    }
  function SetfocusSubmit(element)
  {
    onSaveAndReturn();
  }

  ]]></script>
  </xsl:template>
</xsl:stylesheet>

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
                                  or /RESPONSES/RESPONSE/HEADER_CONTEXT/DL/MODE/@Value = 'EDIT'">
        <xsl:value-of select="'TRUE'"/>
      </xsl:when>
      <xsl:otherwise>  
        <xsl:value-of select="'FALSE'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="dateFormat">
    <xsl:value-of select="/RESPONSES/RESPONSE/DateFormat/@Value"/>
  </xsl:variable>
  <xsl:variable name="startDtVal">
                <i18n:date format="common">
                  <xsl:value-of select="/RESPONSES/RESPONSE/cal_startDate/@Value"/>
                </i18n:date>
    </xsl:variable>
  
  <xsl:template match="RESPONSES" mode="content">
    <table id="top_table" border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td >
          <xsl:apply-templates select="RESPONSE/CALENDAR_HEADER"/>
        </td>
      </tr>
    <tr>
       <td >
          <xsl:call-template name="MASS_UPDATE"/>
       </td>
    </tr>
    <tr>
       <td >
    <xsl:if test="RESPONSE/HEADER_CONTEXT/RESOURCE or RESPONSE/HEADER_CONTEXT/LOCATION or RESPONSE/HEADER_CONTEXT/DL ">
      <xsl:apply-templates select="RESPONSE/HEADER_CONTEXT"/>
    </xsl:if>
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
     </td>
    </tr>
    </table>
    <xsl:call-template name="include_javascript_calendar_detail"/>
    <xsl:call-template name="include_javascript_resize"/>

  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <!-- Body -->
    <table cellspacing="0" id="topmosttable" cellpadding="0" border="0" width="100%">
      <tr>
        <td>
        <table id="cal_start_table" border="0" cellpadding="0" cellspacing="0" width="100%">
        <form name="cal_search_form" action="POST">
            <tr>
              <td  style="padding:4px;" width="30%" border="0" nowrap="yes">
                <i18n:text>Calendar Start Date</i18n:text>
                <xsl:text>:</xsl:text>
 
                 <input fieldtype="Date" name="cal_startDate_DC" class="inputfieldIE" size="15"  value="{$startDtVal}"/>&#xA0;
                 <A HREF="javascript:doNothing()" onclick="javascript:showCalendar(document.cal_search_form.cal_startDate_DC);">
                 <i2:img src="/cal_icon.gif" border="0" align="middle"/>
                 </A>
              </td>
              <td  style="padding:2px;" border="0">
                    <i2:button onclick="javascript:onApply()"><i18n:text>Apply</i18n:text></i2:button>
              </td>
             </tr>
            </form>
            </table>       
            
        </td>
        </tr>
        <tr>
        <td width="100%">
          <xsl:if test="$flag='TRUE'">
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
    
    <i2:container title="Calendar Details" indentcontent="no" scrollable="yes">
     <i2:header>
         <A HREF="javascript:onHelp()">
		     <i2:img src="/help_avail.gif" border="0" align="middle"/>
		     </A>
		    </i2:header>
		  

      <table  cellspacing="0" cellpadding="0" border="0" width="100%"> 
      <tr>
        <td nowrap="yes" width="100%">
          <xsl:call-template name="display_instruction_area"/>
          </td>
      </tr>
      <tr>
      <td>
      <table id="context_table" cellspacing="0" cellpadding="2" border="0">
          <form name="cal_header_form" action="POST">
            <input type="hidden" name="calendarTypeID" value="{./calendarTypeID/@Value}"/>
            <input type="hidden" name="CalendarType" value="{./class/@Value}"/>
            <input type="hidden" name="horizonID" value="{./horizonID/@Value}"/>
            <input name="RETURN" type="hidden" value=""/>
            <input name="SERVICE" type="hidden" value=""/>
            <input name="DO_SEARCH" type="hidden" value=""/>
            <input name="FORM_NAME" type="hidden" value=""/>
            <input type="hidden" name="cal_startDate" value="{$startDtVal}"/>
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
            <input type="field" name="name" value="{name/@Value}" required="true" class="inputfieldIE" maxlength="32" size="27" />
            <xsl:call-template name="display_alert_image">
              <xsl:with-param name="fieldName" select="'name'"/>
            </xsl:call-template>
          </td>
          <td nowrap="nowrap">
        &#xA0; &#xA0;&#xA0;
        <i18n:text>Description
        </i18n:text>
            <xsl:text>:</xsl:text>
          </td>
          <td nowrap="nowrap">
           &#xA0;&#xA0;<input type="field" name="description" value="{description/@Value}" class="inputfieldIE" maxlength="32" size="27"/>
          </td>
        </tr>
        <tr>
<!--
          <td nowrap="nowrap">
        &#xA0;
        <i18n:text>Category
        </i18n:text>
            <xsl:text>:</xsl:text>
          </td>
          <td nowrap="nowrap">
           &#xA0;
          <input type="field" name="category" value="{category/@Value}" class="inputfieldIE" maxlength="32" size="27"/>
          </td>
-->
          <td nowrap="nowrap">
        &#xA0; 
        <i18n:text>Calendar Type
        </i18n:text>
            <xsl:text>:</xsl:text>
            <xsl:call-template name="display_alert_mark"/>
          </td>
          <td align="left">
           &#xA0;
            <select class="pulldown" name="pd_calendarTypeID" required="true" tabIndex="">
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
              <xsl:with-param name="fieldName" select="'pd_calendarTypeID'"/>
            </xsl:call-template>
          </td>
<!--
          <td nowrap="nowrap">
           <i2:button onclick="javascript:onUpdate()">&#xA0;<i18n:text>Update</i18n:text>&#xA0;</i2:button>
         </td> -->

          <td nowrap="nowrap">
        &#xA0; &#xA0;&#xA0;
        <i18n:text>Availability UOM
        </i18n:text>
            <xsl:text>:</xsl:text>
            <!--xsl:call-template name="display_alert_mark"/-->
          </td>
          <td align="left">&#xA0;
          <select class="inputfieldIE" name="UOM" required="true" tabIndex="">
              <!--xsl:if test="$flag='TRUE'">
                <xsl:attribute name="disabled">true</xsl:attribute>
              </xsl:if-->
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
        <i18n:text>Category
        </i18n:text>
            <xsl:text>:</xsl:text>
          </td>
          <td nowrap="nowrap">
           &#xA0;
          <input type="field" name="category" value="{category/@Value}" class="inputfieldIE" maxlength="32" size="20"/>
          </td>
          <td nowrap="nowrap">
        &#xA0;&#xA0; &#xA0;
        <i18n:text>Sub Category
        </i18n:text>
            <xsl:text>:</xsl:text>
          </td>
          <td nowrap="nowrap" >
           &#xA0;&#xA0;
          <input type="field" name="subCategory" value="{subCategory/@Value}" class="inputfieldIE" maxlength="32" size="27"/>
          </td>
          </tr>
    </form>
     </table>
     </td>
     </tr>
     </table>
      <i2:footer>   
          <i2:buttonbar>
             <i2:button onclick="javascript:onSaveHeader()">
             &#xA0;Save&#xA0;&#xA0;</i2:button>
          </i2:buttonbar>
      </i2:footer>
    
    </i2:container>
  </xsl:template>
  
  <!--**************************************************
  *********************************************************************** -->
  <xsl:template name="MASS_UPDATE">
          <i2:container title="Mass Edit" inner="yes" indentcontent="no" scrollable="yes">
          <table id="mass_table" cellspacing="0" cellpadding="2" border="0">
              <form name="mass_update_form" action="POST">
              <input type="hidden" name="cal_startDate" value="{$startDtVal}"/>
            <tr>
              <td nowrap="nowrap">
                &#xA0;
            <i18n:text>Start Date</i18n:text>
            <xsl:text>:</xsl:text>
          </td>
          <td>
             &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;
             <input fieldtype="Date" name="startDate_DC" class="inputfieldIE" size="15" />&#xA0;
             <A HREF="javascript:doNothing()" onclick="javascript:showCalendar(document.mass_update_form.startDate_DC);">
             <i2:img src="/cal_icon.gif" border="0" align="middle"/>
             </A>
              </td>
              <td nowrap="nowrap">
                &#xA0; &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;
            <i18n:text>End Date</i18n:text>
            <xsl:text>:</xsl:text>
          </td>
          <td>
          &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;
             <input fieldtype="Date" name="endDate_DC" class="inputfieldIE" size="15" />&#xA0;
            <A HREF="javascript:doNothing()" onclick="javascript:showCalendar(document.mass_update_form.endDate_DC);">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/>
            </A>
          </td>
            </tr>
            <tr>
              <td nowrap="nowrap">
                &#xA0;
                <i18n:text>Entry Attribute
                </i18n:text>
                <xsl:text>:</xsl:text>
              </td>
          <td align="left">
            &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;
            <select class="pulldown" name="entryAtt" required="true" tabIndex="">
              <option value="">
            <i18n:text></i18n:text>
              </option>
               <xsl:apply-templates select="RESPONSE/calBasedAttforCalTypes/calendarEntryAttributeID">
               </xsl:apply-templates>
            </select>
    
         </td>
             <td nowrap="nowrap">
                 &#xA0;&#xA0; &#xA0; &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;
                <i18n:text>Entry Value
                </i18n:text>
                <xsl:text>:</xsl:text>
                
              </td>
              <xsl:choose>
	         <xsl:when test="/RESPONSES/RESPONSE/CALENDAR_HEADER/calendarTypeID/@Value = 'DL'">
	           <td align="left">
                   &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;     
	            <select class="pulldown" name="entryValue" required="true" tabIndex="">
             		 <option value="">
			      <i18n:text>Select</i18n:text>
            		  </option>
             		 <option value="1">
           		    <i18n:text>True</i18n:text>
            		  </option>
            		 <option value="0">
			    <i18n:text>False</i18n:text>
            		 </option> 
	            </select>
	             </td>
	        </xsl:when>
	        <xsl:otherwise>
                    <td align="left">
                   &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;
                   <input type="field" name="entryValue" class="inputfieldIE" maxlength="10" size="10"/>
                    </td>
              </xsl:otherwise>
              </xsl:choose>
             
            </tr>
          </form>
          </table>
          <i2:footer>
          <i2:buttonbar>
         <i2:button onclick="javascript:onMassUpdate()">
         &#xA0;Mass Update&#xA0;&#xA0;</i2:button>
          </i2:buttonbar>
          </i2:footer>
          </i2:container>
  </xsl:template>
  
    <xsl:template match="calendarEntryAttributeID">
       <option value="{./@Value}">
         <i18n:text>
           <xsl:value-of select="./@Value"/>
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
  
  
  <xsl:template match="FIELD">
    <xsl:if test="@Type != 'Hidden'">
      <td nowrap="yes">
        <!-- Date field -->
        <xsl:if test="@Type = 'DateRange'">

          <xsl:variable name="fromDate">
            <i18n:date format="common"><xsl:value-of select="@Value1"/></i18n:date>
          </xsl:variable>

          <table cellspacing="6" cellpadding="0" border="0">
          <tr><td nowrap="yes">
         <input fieldtype="{@Type}" type="field" class="inputFieldIE" size="10" name="{@Name}" value="{$fromDate}" required="{@Required}"/>
          </td><td nowrap="yes" >
             <A HREF="javascript:doNothing()" onclick="showCalendar(document.search_form.{@Name}_FIRST_DC);">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/></A>
          </td>
          <td nowrap="nowrap">
           <i2:button onclick="javascript:onApply()">&#xA0;<i18n:text>Apply</i18n:text>&#xA0;</i2:button>
         </td></tr></table>
        </xsl:if>

      </td>
    </xsl:if>

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
   
   
   
  
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Text') and (@Editable)]" mode="content">
	    <xsl:param name="validate"/>
	    <td align="left" nowrap="yes">
	      <xsl:choose>
	        <xsl:when test="$validate='yes' and @Required = 'yes' ">
	          <input fieldtype="text" name="{@Name}" value="{@Value}" required="true" tabIndex="" type="field" class="inputfieldIE" size="10"/>
	        </xsl:when>
	        <xsl:otherwise>
	          <input fieldtype="text" name="{@Name}" value="{@Value}" tabIndex="" type="field" class="inputfieldIE" size="10"/>
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
              <i18n:text>Select&#xA0;</i18n:text>
            </option>
		     <xsl:choose>
		     <xsl:when test="@Value='1' ">
		       <option selected="yes" value="1">
			<i18n:text>True</i18n:text>
		       </option>
		       <option value="0">
			      <i18n:text>False</i18n:text>
		       </option>
		     </xsl:when>
		     <xsl:otherwise>
				     <xsl:choose>
				     <xsl:when test="@Value='0' ">
				      <option  value="1">
					<i18n:text>True</i18n:text>
				      </option>
				      <option selected="yes" value="0">
					      <i18n:text>False</i18n:text>
				      </option>
				    </xsl:when>
				    <xsl:otherwise>
				      <option  value="1">
					<i18n:text>True</i18n:text>
				      </option>
				      <option value="0">
					      <i18n:text>False</i18n:text>
				      </option>	    
				    </xsl:otherwise>
				    </xsl:choose>
		  </xsl:otherwise>
		  </xsl:choose>
	 </xsl:otherwise>	  
        </xsl:choose>
        <xsl:apply-templates select="OPTION"/>
      </select>
    </td>
  </xsl:template>      
   
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
  <!-- custom javascript -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_resize">
  <script>

  <![CDATA[
  // Resizing All containers
      function resize_Containers()
     {
        //resizeScrollableTables(-240);     
          //alert("sdf");  
          var height = document.body.offsetHeight/3 - 30;
          var width = document.body.offsetWidth - 50;
          
          var table_id = 'result_form_table';
          i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null);
          i2uiResizeScrollableContainer('table_id',height, null, width, true, 'yes');
          //i2uiResizeScrollableContainer('button_container',40, null, width + 15, true, 'yes');
          //i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight - 300 , null, width, true, 'yes');
        
        
          i2uiResizeScrollableArea('toptable', height, width, null, null, null,null, null);
          i2uiResizeScrollableContainer('toptable',document.body.offsetHeight - 20 , null, width + 15, true, 'yes');
        }

  ]]>
  </script>

</xsl:template>


  <xsl:template name="include_javascript_calendar_detail">
    <script>
    var dateFormat = '<xsl:value-of select="$dateFormat"/>';
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
   <![CDATA[

   function onCancel()

      {       
                document.cal_header_form.DO_SEARCH.value ="Yes";
                document.cal_header_form.FORM_NAME.value = "CALENDAR_SRCH_FORM";
                document.cal_header_form.SERVICE.value = "BCMMasterService";
                document.cal_header_form.action="calendarSearch.jsp";
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
               }   
          }
          }
      }
     function  onCalSetup()
     {
        
                document.cal_header_form.action="FixedDetail/controller/showCalendarSetup.cmd";
                document.cal_header_form.submit();
     
     }
          
     function onReturnToContext()

      {
                document.cal_header_form.action="search/controller/returnToContext.cmd";
                document.cal_header_form.submit();
      }
     function onSaveHeader()
     {
          error = "false";
          error = requiredFieldCheck();
          if ( error == 'false' )
          {
                document.cal_header_form.action="detail/controller/saveCalendarHeader.cmd";
                document.cal_header_form.submit();
          }
     }
      
     function onSave()
      {
          error = "false";
          error = requiredFieldCheck();
          if ( error == 'false' )
          {
                document.result_form.action="FixedDetail/controller/saveFixedCalDetails.cmd";
                document.result_form.submit();
          }
      }
     function onApply()
      {
          error = "false";
          error = requiredFieldCheck();
          
          var startDtstr = document.cal_search_form.cal_startDate_DC.value;
          var currdate = new Date();
          var stDt = getDateFromFormat(startDtstr,dateFormat);
          
           if (stDt == 0)
           {
                core_alert("FIXED_CAL_DATE_IS_NULL_OR_INVALID");
                error='true';
           }
          if ( error == 'false' )
          {
                document.cal_search_form.action="FixedDetail/controller/showFixedCalDetails.cmd";
                document.cal_search_form.submit();
          }
      }

    function onMassUpdate()
    {
        if (trimString(document.mass_update_form.startDate_DC.value) == '') {
            core_alert("FIXED_CAL_START_DATE_CANNOT_BE_NULL");
        }
        else if (trimString(document.mass_update_form.endDate_DC.value) == '') {
            core_alert("FIXED_CAL_END_DATE_CANNOT_BE_NULL");
        }
        else if (trimString(document.mass_update_form.entryAtt.value) == '') {
            core_alert("FIXED_CAL_MUST_SELECT_CALENDAR_ATTRIBUTE");
        }
        else if (trimString(document.mass_update_form.entryValue.value) == '') {
            core_alert("FIXED_CAL_ENTRY_VALUE_CANNOT_BE_NULL");
        }
        else
        {
            document.mass_update_form.action="FixedDetail/controller/massUpdateFixedCalAttribute.cmd";
            document.mass_update_form.submit();
        }
    }


      function dateCompare(form)
      {
         var dateNotEqual = true;
         currdate = new Date();
                 
         var srcStartDate = form.EFF_SOURCE_MSR_ST_DATE_DC.value;
         var srcEndDate     = form.EFF_SOURCE_MSR_EN_DATE_DC.value;
         var tgtStartDate = form.EFF_TGT_MSR_ST_DATE_DC.value;
         
         var srStDt = getDateFromFormat(srcStartDate,dateFormat);
         var srEnDt = getDateFromFormat(srcEndDate,dateFormat);
         var tgStDt = getDateFromFormat(tgtStartDate,dateFormat);
         var crDt       = getDateFromFormat(currdate,dateFormat);
         
         
         var msg = "";
         if(srStDt < srEnDt && srStDt < tgStDt)
         {
                dateNotEqual=true;
         }
         else 
         {
                        if(srStDt == 0  && ( srEnDt != 0 || tgStDt != 0 ))
                        {
                                dateNotEqual=false;
                                msg +=  "Please enter SrcMeasureStartDate";
                                core_alert(msg);
                        }
                        else if(srStDt != 0 && srEnDt != 0 && srStDt >= srEnDt)
                        {
                            dateNotEqual=false;
                            msg +=  "SrcMeasureEndDate should be greater than SrcMeasureStartDate ";
                            core_alert(msg);
                        }
                        else if(srStDt != 0 && tgStDt != 0 && srStDt >= tgStDt)
                        {
                            dateNotEqual=false;
                            msg +=  "TargetMeasureStartDate should be greater than SrcMeasureStartDate";
                            core_alert(msg);
                        }
                        else if(tgStDt != 0 && srEnDt == 0  && srStDt == 0)
                        {
                            dateNotEqual=false;
                            msg +=  "Please enter SrcMeasureStartDate and SrcMeasureEndDate ";
                            core_alert(msg);
                        }
                    
         }
         return dateNotEqual;
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
	function onHelp()
	{
		popUpWindow( '../help/calendar_detail_help.htm', 'popUp4')
 }
  ]]></script>
  </xsl:template>
</xsl:stylesheet>

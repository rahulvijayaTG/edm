<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">
  <xsl:import href="pageLayout.xsl"/>
  <xsl:import href="../../xsl/required_field.xsl"/>
  <xsl:output method="html"/>
  <xsl:variable name="single_quote">'</xsl:variable>
  <xsl:variable name="submittedData" select="/RESPONSES/RESPONSE/PAGE/SUBMITTED_DATA"/>
  <xsl:variable name="mode" select="/RESPONSES/RESPONSE/PAGE/SUBMITTED_DATA/UPDATE_MODE/@Value"/>
  <xsl:variable name="date-format" select="/RESPONSES/RESPONSE/FORMAT/@Date"/>
  <xsl:template match="PRESENTATION/HTML_TABLE" mode="customTemplate">
    <xsl:if test="count(/RESPONSES/RESPONSE/PAGE/PRESENTATION/HTML_TABLE/PROPERTY/@Required) > 0 or /RESPONSES/RESPONSE/ERROR_MESSAGE">
      <xsl:call-template name="display_instruction_area"/>
    </xsl:if>
    <table id="group_edit_table">
      <tr>
        <td>
          <table cellpadding="5" cellspacing="5">
            <tr>
              <td>
                <input type="checkbox" name="SELECT_ALL" onclick="javascript:onSelectAll()"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          <xsl:call-template name="doFlowLayout">
            <xsl:with-param name="element" select="."/>
            <xsl:with-param name="elementMetaData" select="."/>
            <xsl:with-param name="cellpadding" select="5"/>
            <xsl:with-param name="cellspacing" select="5"/>
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>
  <xsl:template match="*[starts-with(name(), 'F_') or name() = 'SELECTED_ID']" mode="customTemplate">
    <input type="hidden" name="{name()}" value="{@Value}"/>
  </xsl:template>
  <xsl:template name="renderRowWithMetaData">
    <xsl:param name="element"/>
    <!-- hidden fields-->
    <input type="hidden" name="DATE_FORMAT" value="{$date-format}"/>
    <xsl:variable name="currentProperty" select="."/>
    <!-- Variables set-field and set-op are required to set values of integer/float fields
        when user performs a fk look-up from massupdate page-->
    <xsl:variable name="currentPropertyName">
      <!--xsl:choose>
        <xsl:when test="$currentProperty/@Type = 'date' or $currentProperty/@Type = 'datetime'">
          <xsl:value-of select="concat(substring-before(@Name,'.'), '_', substring-after(@Name, '.'))"/>
        </xsl:when>
        <xsl:otherwise-->
          <xsl:value-of select="$currentProperty/@Name"/>
        <!--/xsl:otherwise>
      </xsl:choose-->
      </xsl:variable>
    <xsl:variable name="displayName">
      <i18n:text>
        <xsl:value-of select="$currentProperty/@DisplayName"/>
      </i18n:text>
    </xsl:variable>
    <xsl:variable name="fieldName">
      <xsl:choose>
        <xsl:when test="$currentProperty/@Type = 'date' or $currentProperty/@Type = 'datetime' ">
          <xsl:value-of select="concat($currentPropertyName, '_DC')"/>
        </xsl:when>
        <xsl:when test="$currentProperty/@Type = 'int' or $currentProperty/@Type = 'float'">
          <!--<xsl:value-of select="concat($currentPropertyName, '_OPERATOR_VALUE','_N4')"/>-->
          <xsl:value-of select="concat($currentPropertyName, '_OPERATOR_VALUE','_N4')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$currentPropertyName"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="set-field">
         <xsl:choose>
           <xsl:when test="$currentProperty/@Type = 'int' or $currentProperty/@Type = 'float'">
                <xsl:value-of select="concat($currentPropertyName, '_OPERATOR_VALUE')"/>
           </xsl:when>
           <xsl:otherwise>
                <xsl:value-of select="$currentPropertyName"/>
           </xsl:otherwise>
         </xsl:choose>
        </xsl:variable>
        <xsl:variable name="set-op">
           <xsl:if test="$currentProperty/@Type = 'int' or $currentProperty/@Type = 'float'">
              <xsl:value-of select="$submittedData/*[name() = concat($currentPropertyName, '_OPERATOR')]/@Value"/>
           </xsl:if>
        </xsl:variable>
        <xsl:variable name="val">
          <xsl:choose>
            <xsl:when test="string-length($submittedData/*[name() = $currentProperty/@Name]/@Value) > 0">
    	      <xsl:value-of select="$submittedData/*[name() = $currentProperty/@Name]/@Value"/>
    	   </xsl:when>
    	   <!--Added for setting int/float text fields-->
    	   <xsl:when test="string-length($submittedData/*[name() = $set-field]/@Value) > 0">
    	     <xsl:value-of select="$submittedData/*[name() = $set-field]/@Value"/>
    	   </xsl:when>
    	   <xsl:otherwise>
    	      <xsl:value-of select="$currentProperty/@Value"/>
           </xsl:otherwise>
         </xsl:choose>
       </xsl:variable>
    <td width="1%">
    <!-- EQ: 512378 -->
      <xsl:choose>
        <xsl:when test="$currentProperty/@Type = 'date' or $currentProperty/@Type = 'datetime' ">
          <input type="checkbox" name="{concat($currentPropertyName, '_cb')}" onclick="javascript:unSelectAll({concat($currentPropertyName, '_DC')})" fieldName="{$fieldName}"/>
        </xsl:when>
        <xsl:when test="$currentProperty/@Type = 'int' or $currentProperty/@Type = 'float'">
          <!--<input type="checkbox" name="{concat($currentPropertyName, '_cb')}" onclick="javascript:unSelectAll({concat($currentPropertyName, '_OPERATOR_VALUE')})" fieldName="{$fieldName}"/>-->
          <input type="checkbox" name="{concat($currentPropertyName, '_cb')}" onclick="javascript:unSelectAll({concat($currentPropertyName, '_OPERATOR_VALUE','_N4')})" fieldName="{$fieldName}">
             <xsl:if test="string-length($val) != 0">
	       <xsl:attribute name="checked"><xsl:value-of select="'true'"/></xsl:attribute>
	     </xsl:if>
          </input>
        </xsl:when>
        <xsl:otherwise>
          <input type="checkbox" name="{concat($currentPropertyName, '_cb')}" onclick="javascript:unSelectAll('{$currentPropertyName}')" fieldName="{$fieldName}">
              <xsl:if test="string-length($val) != 0">
	  	       <xsl:attribute name="checked"><xsl:value-of select="'true'"/></xsl:attribute>
	     </xsl:if>
	  </input>
        </xsl:otherwise>
      </xsl:choose>
      <!-- End of EQ: 512378 -->
    </td>
    <td nowrap="yes" width="10%">
      <xsl:value-of select="$displayName"/>
      <xsl:text>:</xsl:text>
      <xsl:if test="string-length(@Required) > 0 ">
        <xsl:call-template name="display_alert_mark"/>
      </xsl:if>
    </td>
    <xsl:choose>
      <xsl:when test="$currentProperty/@Type = 'int' or $currentProperty/@Type = 'float' ">
        <td nowrap="yes"  width="10%">
          <select name="{concat($currentProperty/@Name, '_OPERATOR')}" class="pulldownIE">

            <option value="SET">
              <xsl:if test="$set-op = 'SET'">
	         <xsl:attribute name="selected">yes</xsl:attribute>
              </xsl:if>
            <i18n:text name="SET">Set Value</i18n:text></option>
            <option value="INCREMENT">
            <xsl:if test="$set-op = 'INCREMENT'">
	         <xsl:attribute name="selected">yes</xsl:attribute>
              </xsl:if>
              <i18n:text name="INCREMENT">Increment by</i18n:text></option>
            <option value="DECREMENT">
            <xsl:if test="$set-op = 'DECREMENT'">
	         <xsl:attribute name="selected">yes</xsl:attribute>
              </xsl:if>
              <i18n:text name="DECREMENT">Decrement by</i18n:text></option>
            <option value="INFLATE">
            <xsl:if test="$set-op = 'INFLATE'">
	         <xsl:attribute name="selected">yes</xsl:attribute>
              </xsl:if>
              <i18n:text name="INFLATE">Inflate</i18n:text></option>
            <option value="DEFLATE">
            <xsl:if test="$set-op = 'DEFLATE'">
	         <xsl:attribute name="selected">yes</xsl:attribute>
              </xsl:if>
              <i18n:text name="DEFLATE">Deflate</i18n:text></option>
          </select>&#xA0;
        <xsl:if test="$mode = 'MULTIPLE' and  count($submittedData/SELECTED_ID) = 1">
          <!--td width="10%"-->
            <xsl:value-of select="$val"/>
          <!--/td-->
        </xsl:if>
          &#xA0;
        </td>
        <td nowrap="yes">
          <xsl:choose>
            <xsl:when test="$currentProperty/@DisplayType = 'dropdown'">
              <select name="{$currentProperty/@Name}" class="pulldownIE">
                <xsl:for-each select="$currentProperty/VALID_VALUE">
                  <option value="./@Value">
                  <xsl:if test="./@Value = $val">
                   <xsl:attribute name="selected">yes</xsl:attribute>
                  </xsl:if>
                    <i18n:text>
                      <xsl:value-of select="./@Value"/>
                    </i18n:text>
                  </option>
                </xsl:for-each>
              </select>
            </xsl:when>
            <xsl:otherwise>
              <input fieldtype="Number" type="field" displayName="{$displayName}" min="{$currentProperty/@MinValue}" max="{$currentProperty/@MaxValue}" name="{concat($currentProperty/@Name, '_OPERATOR_VALUE')}_N4" class="inputfieldIE" size="17" Value="{$val}" onkeyup="javascript:onlyCurrency()">
                  <xsl:if test="string-length(@Required) > 0 ">
                    <xsl:attribute name="required">true</xsl:attribute>
                  </xsl:if>
                </input>
                <xsl:if test="string-length(@Required) > 0 ">
                  <xsl:call-template name="display_alert_image">
                    <xsl:with-param name="fieldName" select="concat($currentProperty/@Name, '_OPERATOR_VALUE','_N4')"/>
                  </xsl:call-template>
                </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <td nowrap="yes">
               [<i18n:text>Number</i18n:text>]
               <xsl:if test="string-length($currentProperty/@MinValue) > 0 ">
                 &#xA0;<i18n:text>min</i18n:text>:&#xA0;<xsl:value-of select="$currentProperty/@MinValue"/>
               </xsl:if>
               <xsl:if test="string-length($currentProperty/@MaxValue) > 0 ">
                 &#xA0;<i18n:text>max</i18n:text>:&#xA0;<xsl:value-of select="$currentProperty/@MaxValue"/>
               </xsl:if>
        </td>
      </xsl:when>
      <xsl:when test="$currentProperty/@Type = 'date' or $currentProperty/@Type = 'datetime' ">
      <xsl:variable name="dateName">
      <xsl:choose>
        <xsl:when test="contains(@Name , '.')">
          <xsl:value-of select="concat(substring-before(@Name,'.'), '_', substring-after(@Name, '.'), '_DC')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(@Name , '_DC')"/>
        </xsl:otherwise>
      </xsl:choose>
      </xsl:variable>
        <xsl:if test="$mode = 'EDIT' ">
          <td width="10%"/>
          <td width="10%"/>
        </xsl:if>
        <!--xsl:if test = "$mode = 'GROUP_EDIT' or $mode = 'MASS_UPDATE' ">
          <td width="10%"/>
        </xsl:if!-->
        <td nowrap="yes">
          <xsl:variable name="dateVal">
             <i18n:date format="common">
             <xsl:value-of select="$val"/>
             </i18n:date>
          </xsl:variable>
          <input fieldtype="text" name="{$dateName}" value="{$dateVal}" type="field" class="inputfieldIE" size="17"/>
        </td>
       <td>
        <A HREF="javascript:setDateField(document.main_form.{$dateName});" onclick="setDateField(document.main_form.{$dateName});">
          <i2:img src="/calendar.gif" border="0" align="middle"/>
        </A>
      </td>
      <td>
           [<i18n:text>Date</i18n:text>]&#xA0;[<xsl:value-of select="$date-format"/>]
      </td>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$mode = 'EDIT' ">
          <td width="10%"/>
          <td width="10%"/>
        </xsl:if>
        <!--xsl:if test = "$mode = 'GROUP_EDIT' or $mode = 'MASS_UPDATE' ">
          <td width="10%"/>
        </xsl:if-->
        <td nowrap="yes">
          <xsl:choose>
            <xsl:when test="$currentProperty/@DisplayType = 'dropdown'">
              <select name="{$currentProperty/@Name}" class="pulldownIE">
                  <xsl:if test="string-length(@Required) > 0 ">
                    <xsl:attribute name="required">true</xsl:attribute>
                  </xsl:if>
                <option value="">
		    <i18n:text>Select</i18n:text>
                </option>
                <xsl:for-each select="$currentProperty/VALID_VALUE">

			<xsl:choose>
				<xsl:when test="string-length($currentProperty/@DefaultValue) > 0">
				<!--Issue 560476-->
					<xsl:choose>
						<xsl:when test="./@Value = $currentProperty/@DefaultValue">
					  	<option value="{$currentProperty/@DefaultValue}">
					  		<xsl:if test="./@Value = $currentProperty/@DefaultValue">
									<xsl:attribute name="selected">yes</xsl:attribute>
								</xsl:if>
								<i18n:text>
									<xsl:value-of select="./@Value"/>
								</i18n:text>
					  	</option>
					  </xsl:when>
						<xsl:otherwise>
							<option value="{./@Value}">
								<xsl:if test="./@Value = $currentProperty/@DefaultValue">
									<xsl:attribute name="selected">yes</xsl:attribute>
								</xsl:if>
								<i18n:text>
									<xsl:value-of select="./@Value"/>
								</i18n:text>
					  	</option>
						</xsl:otherwise>
					</xsl:choose>
				<!--Issue 560476-->
					  		<!--xsl:if test="./@Value = $currentProperty/@DefaultValue">
					   			<xsl:attribute name="selected">yes</xsl:attribute>
					  		</xsl:if>
					    	<i18n:text>
					      <xsl:value-of select="./@Value"/>
					    </i18n:text>
					  </option-->
				</xsl:when>
				<xsl:otherwise>
					  <option value="{./@Value}">
					  <xsl:if test="./@Value = $val">
					   <xsl:attribute name="selected">yes</xsl:attribute>
					  </xsl:if>
					    <i18n:text>
					      <xsl:value-of select="./@Value"/>
					    </i18n:text>
					  </option>
				</xsl:otherwise>
			</xsl:choose>
                </xsl:for-each>
              </select>
              <xsl:if test="string-length(@Required) > 0 ">
                <xsl:call-template name="display_alert_image">
                  <xsl:with-param name="fieldName" select="$currentProperty/@Name"/>
                </xsl:call-template>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <input fieldtype="text" name="{$currentProperty/@Name}" displayName="{$displayName}" value="{$val}" type="field" class="inputfieldIE" size="17">
                  <xsl:if test="string-length(@Required) > 0 ">
                    <xsl:attribute name="required">true</xsl:attribute>
                  </xsl:if>
                </input>
                <xsl:if test="string-length(@Required) > 0 ">
                  <xsl:call-template name="display_alert_image">
                    <xsl:with-param name="fieldName" select="$currentProperty/@Name"/>
                  </xsl:call-template>
                </xsl:if>
            </xsl:otherwise>
          </xsl:choose>&#xA0;
          <!-- Merging from ti code for fk look-up in mass edit page.
	    The result property in the queryform must have Refers & ReferredColumn  attributes -->
	  <xsl:if test="$currentProperty/@Refers">
	    <A HREF="{concat('javascript:onGotoSelectForeignKey(', $single_quote, $currentProperty/@Name, $single_quote, ',', $single_quote, $currentProperty/@Refers, $single_quote,  ',',$single_quote, $currentProperty/@ReferredColumn, $single_quote, ');')} ">
		<i2:img src="/pop_up_window.gif" border="0" align="bottom"/>
	    </A>
	  </xsl:if>
        </td>

          <td nowrap="yes">[<i18n:text>Text</i18n:text>] </td>

      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="string-length($currentProperty/@Hyperlink) > 0 ">
      <td>
        <A HREF="{$currentProperty/@Hyperlink}">
          <i2:img src="/pop_up_window.gif" border="0" align="middle"/>
        </A>
      </td>
    </xsl:if>
  </xsl:template>
  <xsl:template name="includeOverrideJavascript">
    function onSave() {

       if( checkIfAnySelected(document.main_form) == false)
       {
        core_alert("Please select properties to update.");
          return;
       }
          var error = "false";

          <xsl:if test="count(/RESPONSES/RESPONSE/PAGE/PRESENTATION/HTML_TABLE/PROPERTY/@Required) > 0">
            checkRequiredFieldProperty(document.main_form);
            error = requiredFieldCheck();
          </xsl:if>


        if ( error == 'true' )
          return;

        if ( error = 'false')
        {

          //alert("validating=" + groupEditValidate(document.main_form));
          if(groupEditValidate(document.main_form))
          {
          disableUncheckedProperties(document.main_form);
          //document.main_form.action = document.main_form.UPDATE_ACTION.value;
          document.main_form.action = omxContextPath+ "/bcm/framework/forms/formController/updateFormProperties.cmd";
          document.main_form.UPDATE_ACTION.disabled = true;
          document.main_form.submit();
          }
       }

    }


   function checkRequiredFieldProperty(form)
    {
        var formElements = form.elements;
        for (i = 0; i &lt; formElements.length; i++)
        {
              if (formElements[i].type == 'checkbox' &amp;&amp; formElements[i].fieldName)
               {

                                  var field =  document.getElementById(formElements[i].fieldName);
                                  if (field.required) {
                                           if (formElements[i].checked) {
                                            field.required = 'true';
                                           } else {
                                            field.required = 'false';
                                           }
                                   }
                }
         }
      }

    /*
    function checkRequiredFieldProperty(form)
     {
         var formElements = form.elements;
         for (i = 0; i &lt; formElements.length; i++)
         {
               if (formElements[i].type == 'checkbox' &amp;&amp; formElements[i].fieldName)
                {
                       // made by anish ..  its a hack ..needs to change the field name (if its class) in database
                       //alert("formElements[i].fieldName= " +  formElements[i].fieldName);
                        if(formElements[i].fieldName != 'class' )
                         {

                                   var field =  eval("form." + formElements[i].fieldName);
                                   //alert(formElements[i].fieldName);

                                   if (field.required) {
                                           //alert(field.required);
                                            if (formElements[i].checked) {
                                             field.required = 'true';
                                            } else {
                                             field.required = 'false';
                                            }
                                    }
                         }
                 }
          }
       }
      */

   function checkIfAnySelected(form)
   {
        var count;
        var elementsLen = form.elements.length;
        var foundChecked = false;

        for(count = 0; count &lt; elementsLen; count++)
        {
          if( form.elements[count].type == "checkbox" &amp;&amp; form.elements[count].checked == true  &amp;&amp;
             form.elements[count].name != "SELECT_ALL"  ){
              foundChecked = true;
              break;
           }
        }
        return foundChecked;
   }

    function onCancel() {

      history.back();
    }

    function SetfocusSubmit(element) {
      onSave();
    }

  var msg_valid_date="<i18n:text>{0} should be a valid date. The date format must be {1}</i18n:text>";
  var msg_min_value= "<i18n:text>{0} should be more than {1}</i18n:text>";
  var msg_max_value = "<i18n:text>{0} should be less than {1}</i18n:text>";
  var service = '<xsl:value-of select="$submittedData/SERVICE/@Value"/>';

     <![CDATA[


      function groupEditValidate(form)
      {
          var count;
          var elementsLen = form.elements.length;
          var dateFormat = form.DATE_FORMAT.value
          var success = true;
          var foundFilledField = false;
          var msg = "";

          //Validate fields
          for(count = 0; count < elementsLen; count++)
              {
                  var name = form.elements[count].displayName;


                  if( form.elements[count].fieldtype == "Number" &&
                      form.elements[count].value != "" )
                      {
                          if ( isNaN(form.elements[count].value) )
                              {
                                  msg += name + " should be a valid number";
                                            core_alert(msg);
                                  success = false;
                                  break;
                              }
                         <!-- For the functionality of Min and Max constraints-->
                   else
                 {
          //alert("form.elements[count].min=" +form.elements[count].min);
          //alert("form.elements[count].max=" +form.elements[count].max);

                if(form.elements[count].min != '' && form.elements[count].value -  form.elements[count].min < 0)
                {

                    success = false;
                    core_alert(msg_min_value, name, form.elements[count].min);
                    break;

                }

                if(form.elements[count].max != '' && form.elements[count].value-form.elements[count].max > 0)
                {

                    core_alert(msg_max_value, name, form.elements[count].max);
                    success = false;
                    break;


                }
                 }
                      }
                  if( ((form.elements[count].fieldtype == "DateRange") || (form.elements[count].fieldtype == "Date")) &&
                      form.elements[count].value != "" && dateFormat != "")
                      {
                          if ( isDate(form.elements[count].value, dateFormat) == false )
                              {
                                  core_alert(msg_valid_date, name, dateFormat);
                                  success = false;
                                  break;
                              }
                      }
              }

          return success;
      }

       function disableUncheckedProperties(form)
       {
            var count;
            var count2;
            var count3;
            var elementsLen = form.elements.length;
            var cbName;
            var fieldName;
            var elemName;
            var elemName2;
            var elemValue;
            var fieldName3;

            for(count = 0; count < elementsLen; count++)
            {
              cbName = "";
              fieldName = "";
              if( form.elements[count].type == "checkbox" && form.elements[count].name != "SELECT_ALL")
              {
                if (form.elements[count].checked != true)
                {
                  elemName = form.elements[count].name;
                  cbName = elemName.substring(0, elemName.length-3);

                  for(count2 = 0; count2 < elementsLen; count2++)
                  {
                    if( form.elements[count2].type != "checkbox")
                    {
                        elemName2 = form.elements[count2].name;
                        // If it is a string type propertys dropdown ...
                        if (cbName == elemName2)
                        {
                          form.elements[count2].disabled = true;
                          continue;
                        }
                        fieldName = elemName2.substring(0, elemName2.indexOf("_OPERATOR_VALUE"));
                        if (cbName == fieldName)
                        {
                          form.elements[count2].disabled = true;
                          continue;
                        }
                        fieldName = elemName2.substring(0, elemName2.indexOf("_OPERATOR"));
                        if (cbName == fieldName)
                        {
                          form.elements[count2].disabled = true;
                          continue;
                        }
                    }
                  }
                }

                // disable the value field if checkbox is selected and value field is null, when operator is not of SET type
                if (form.elements[count].checked == true)
                {
                  elemName = form.elements[count].name;
                  cbName = elemName.substring(0, elemName.length-3);

                  for(count2 = 0; count2 < elementsLen; count2++)
                  {
                    if( form.elements[count2].type != "checkbox")
                    {
                        elemName2 = form.elements[count2].name;
                        fieldName = elemName2.substring(0, elemName2.indexOf("_OPERATOR_VALUE"));
                        elemValue = form.elements[count2].value.trim();

                        if ((cbName == fieldName) && (elemValue == null || elemValue == ""))
                        {
                          fieldName3 = elemName2.substring(0, elemName2.indexOf("_OPERATOR"));
                          if (cbName == fieldName3)
                          {
                            for(count3 = 0; count3 < elementsLen; count3++)
                            {
                              if( form.elements[count3].type == "select-one")
                              {
                                var operations = form.elements[count3];
                                var selectedValue = operations[operations.selectedIndex].value;
                                if ( selectedValue != "SET" )
                                {
                                  var name2 = form.elements[count2].name;
                                  var name3 = form.elements[count3].name;
                                  if (name2.substring(0, name2.indexOf("_OPERATOR_VALUE")) == name3.substring(0, name3.indexOf("_OPERATOR")))
                                  {
                                    // disable both OPERATOR and OPERATOR_VALUE fields ...
                                    form.elements[count3].disabled = true;
                                    form.elements[count2].disabled = true;
                                    form.elements[count].disabled = true;
                                  }
                                }
                              }
                            }
                          }
                        }

                    }
                  }
                }

              }
            }
       }


       function enableAllProperties(form)
       {
            var count;
            var elementsLen = form.elements.length;

            for(count = 0; count < elementsLen; count++)
            {
              form.elements[count].disabled = false;
            }
       }
      function unSelectAll(obj)
      {
         document.main_form.SELECT_ALL.checked=false;
         var count;
         var form = document.main_form;
         var elementsLen = form.elements.length;
         if (!(obj.name)){
            for(count = 0; count < elementsLen; count++)
            {
              if (form.elements[count].name == obj){
              obj = form.elements[count];
              }
            }
         }
         <!-- EQ: 512378 -->
         obj.focus();
         <!-- End of EQ: 512378 -->
       }

      function onSelectAll()
      {
        var count;
        var elementsLen = document.main_form.elements.length;

        for(count = 0; count < elementsLen; count++)
        {
          if( document.main_form.elements[count].type == "checkbox" )
          {
            document.main_form.elements[count].checked = document.main_form.SELECT_ALL.checked;
          }
        }
      }
      //added for fk look-ups from query form-mass update page (merge from ti)
     function onGotoSelectForeignKey(fromColumn, referredTable, referredColumn)
      {

	    document.main_form.target="appFrame";
	    document.main_form.FROM_COLUMN.value= fromColumn;
	    document.main_form.REFERRED_TABLE.value= referredTable;
	    document.main_form.REFERRED_COLUMN.value= referredColumn;
	    document.main_form.FROM_TABLE.value= 'SESSION_DATA';
	    document.main_form.TABLE_NAME.value= 'SESSION_DATA';
	    document.main_form.SERVICE.value= service;
	    document.main_form.PAGE1.value= 'groupEditForm';
	    document.main_form.method="POST";
	    document.main_form.action=omxContextPath+ "/bcm/npi/controller/getParentLevelMembers.cmd";
	    document.main_form.submit();
      }

      ]]></xsl:template>
</xsl:stylesheet>

<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:import href="validation.xsl"/>
  <xsl:import href="links.xsl"/>

  <xsl:output method="html"/>

<!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FORM">

    <!-- Javascript -->
    <i2:javascript path="/calendar.js"></i2:javascript>
    <xsl:call-template name="include_javascript_validation">
    </xsl:call-template>

    <xsl:variable name="cellspacing">
      <xsl:choose>
        <xsl:when test="@Type= 'Hidden'">0</xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="label">
      <xsl:choose>
        <xsl:when test="string-length(@DisplayText) > 0">
          <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="scrollable">
      <xsl:choose>
        <xsl:when test="@Scrollable = 'no' or @Scrollable = 'No' or @Scrollable = 'NO'">no</xsl:when>
        <xsl:otherwise>yes</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Form -->
    <table  width="100%"   cellspacing="{$cellspacing}" cellpadding="0" border="0">
      <form name="{@Name}" method="{@method}" action="{@Action}" target="{@Target}">
        <tr>
          <td>
            <xsl:choose>
              <xsl:when test="@Type= 'Hidden'">
              </xsl:when>
              <xsl:otherwise>
              <i2:container collapsable="{@Collapsable}" title="{$label}" inner="yes"  scrollable="{$scrollable}" id="search_form_container">

              <table border="0" cellpadding="0" cellspacing="0" width="100%">
              <tr>
                <td><xsl:apply-templates select="." mode="instruction_area"/></td>
              </tr>
              <tr>
                <td>
              <!-- Fields  -->
              <table border="0" cellpadding="5" cellspacing="0" width="100%">

              <!-- render the uneditable form -->
              <xsl:if test=" count(FIELD[@Type != 'Hidden' ]) = count(FIELD[ @Editable = 'False' ]) ">
                <xsl:attribute name="class">tableRow1</xsl:attribute>
              </xsl:if>

                <xsl:variable name="pNoOfCol">
                  <xsl:choose>
                    <xsl:when test="@NoOfCols">
                        <xsl:value-of select="@NoOfCols"></xsl:value-of>
                    </xsl:when>
                    <xsl:otherwise>2</xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>

                <!-- Simple Fields -->
                <xsl:apply-templates select="FIELD[@Visibility = 'Simple' or string-length(@Visibility) =  0]">
                  <xsl:with-param name="pNoOfCol" select="$pNoOfCol"/>
                  <xsl:with-param name="pFormName" select="@Name"/>

                </xsl:apply-templates>

                <!-- Advanced Fields -->
                <xsl:if test="FIELD[@Name = 'SEARCH_TYPE']/@Value = 'Advanced'">
                  <xsl:apply-templates select="FIELD[@Visibility = 'Advanced']">
                    <xsl:with-param name="pNoOfCol" select="$pNoOfCol"/>
                    <xsl:with-param name="pFormName" select="@Name"/>

                  </xsl:apply-templates>

                </xsl:if>

                <!-- Simple Search Toggle link -->
                <xsl:if test="count(FIELD[@Visibility = 'Simple' or string-length(@Visibility) =  0 ]) > 0">
                  <xsl:if test="FIELD[@Name = 'SEARCH_TYPE']/@Value != 'Simple' and string-length(FIELD[@Name = 'SEARCH_TYPE']/@Value)>0 ">
                    <tr>
                      <td colspan="2" nowrap="true">
                        <a class="text" href="javascript:onSimpleSearch();">
                          <i18n:text>Simple Search</i18n:text>
                        </a>
                      </td>
                    </tr>
                  </xsl:if>
                </xsl:if>

                <!-- Advanced Search Toggle link -->
                 <xsl:if test="count(FIELD[@Visibility = 'Advanced']) > 0">
                  <xsl:if test="FIELD[@Name = 'SEARCH_TYPE']/@Value != 'Advanced'">
                    <tr>
                      <td colspan="2" nowrap="true">
                        <a class="text" href="javascript:onAdvancedSearch();">
                          <i18n:text>Advanced Search</i18n:text>
                        </a>
                      </td>
                    </tr>
                  </xsl:if>
                </xsl:if>

              </table>
              </td></tr>

              <!-- Form Footer Message -->
              <xsl:if test="@Status = 'true'">
                <table border="0" cellpadding="0" cellspacing="1" width="100%" class="tableRow1">
                  <tr>
                    <xsl:choose>
                       <xsl:when test="STATUS/@Type = 'Success'">
                        <td align="right" width="100%">
                          <font color="green">
                          <i18n:text><xsl:value-of select="STATUS/@DisplayText"/> </i18n:text>
                          </font>
                        </td>
                      </xsl:when>
                      <xsl:when test="STATUS/@Type != 'Success'">
                        <td align="right" width="100%">
                          <font color="red">
                          <i18n:text><xsl:value-of select="STATUS/@DisplayText"/> </i18n:text>
                          </font>
                        </td>
                      </xsl:when>

                    </xsl:choose>
                  </tr>
                </table>
              </xsl:if>

              </table>

              <!-- Footer -->
              <i2:footer>
                <xsl:apply-templates select="BUTTONS"/>

              </i2:footer>

            </i2:container>
              </xsl:otherwise>
            </xsl:choose>
            <!-- Container -->


            <!-- Hidden Fields -->
            <xsl:choose>
              <xsl:when  test="FIELD[@Name = 'SEARCH_TYPE']/@Value = 'Advanced'">
                <xsl:for-each select = "FIELD[@Type='Hidden' and (@Visibility = 'Advanced' or @Visibility = 'Simple' or string-length(@Visibility) =  0 or @Visibility = 'AdvancedOnly' )]">
                  <input name="{@Name}" type="hidden" value="{@Value}"/>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select = "FIELD[@Type='Hidden' and (@Visibility = 'Simple' or string-length(@Visibility) =  0 or @Visibility = 'SimpleOnly' )]">
                  <input name="{@Name}" type="hidden" value="{@Value}"/>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>

          </td>
        </tr>
      </form>
    </table>

  </xsl:template>


<!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FORM" mode="instruction_area">
    <!-- Form  Header Message -->
      <xsl:call-template name="display_validation_area">
        <xsl:with-param name="pFormName" select="'search_form'"/>
        <xsl:with-param name="pAnyFieldIsRequired" select="count(FIELD[@Required = 'true']) > 0"/>
        <xsl:with-param name="pInstructionMessage" select="INSTRUCTION/@DisplayText"/>
        <xsl:with-param name="pAnyFieldHasErrors" select="count(FIELD/_ERRORS) > 0"/>
      </xsl:call-template>
        <xsl:if test="not (@Validation) and  count(INSTRUCTION) = 0 and count(FIELD/_ERRORS) = 0">
        <script>
            i2uiToggleItemVisibility('instruction_area', 'hide');
        </script>
        </xsl:if>
  </xsl:template>


  <!--  Field -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD">
    <xsl:param name="pNoOfCol" select="'2'"/>
    <xsl:param name="pFormName"/>

    <xsl:if test="@Type != 'Hidden' and @Type !='None'">

      <xsl:if test="position() mod $pNoOfCol = 1">
        <xsl:text disable-output-escaping="yes">&lt;tr&gt;</xsl:text>
      </xsl:if>


      <xsl:if test="@Type != 'Links'">

      <!-- Field Label -->
      <td nowrap="yes" width="10%">
         <xsl:if test="(@Type = 'Select' or @Type = 'MultiSelect') and @Size > 1">
            <xsl:attribute name="valign">top</xsl:attribute>
         </xsl:if>

         <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
          <xsl:if test="@Type = 'DateRange'">
            &#xA0;<i18n:text>From</i18n:text>
          </xsl:if>
        <xsl:if test="string-length(@DisplayText) > 0">
            <xsl:value-of select="':'"/>
        </xsl:if>

        <!-- Required Field * -->
        <xsl:if test="@Required = 'true'">
          <font color="red">*</font>
       </xsl:if>
      </td>
       </xsl:if>

      <td nowrap="yes" width="40%">
        <!-- Empty field -->
        <xsl:if test="@Type = 'Empty'">
        </xsl:if>


        <xsl:if test="@Type = 'SelectText'">
         <input  autocomplete="off"
                disabled_ONKEYUP="matchFieldSelect(this, document.{$pFormName}.{@Name}_DISABLED)"
                fieldtype="{@Type}"
           id="{@Name}"

           value="{@Value}"
           type="field"
           class="inputfieldIE"
           size="17"
           required="{@Required}"
           ondblclick="javascript:textToSelect('{@Name}')"
           >

           <xsl:if test="(OPTION)">
            <xsl:attribute name="style">
               <xsl:value-of select="'display:none'"/>
            </xsl:attribute>
             <xsl:attribute name="disabled">true</xsl:attribute>

            <xsl:attribute name="name">
                <xsl:value-of select="concat(@Name,'_DISABLED')"/>
             </xsl:attribute>
           </xsl:if>
           <xsl:if test="not (OPTION)">
            <xsl:attribute name="name">
                <xsl:value-of select="(@Name)"/>
             </xsl:attribute>
           </xsl:if>
         </input>

          <SELECT  ondblclick="javascript:selectToText({@Name})" class="pulldown"   id="{@Name}_select" ONCHANGE="document.{$pFormName}.{@Name}.value = this.options[this.selectedIndex].text;{@OnChange}">
            <xsl:if test="not(OPTION)">
            <xsl:attribute name="style">
               <xsl:value-of select="'width:116px; display:none'"/>
            </xsl:attribute>
              <xsl:attribute name="disabled">true</xsl:attribute>
              <xsl:attribute name="name">
                  <xsl:value-of select="concat(@Name,'_DISABLED')"/>
               </xsl:attribute>
            </xsl:if>
            <xsl:if test="(OPTION)">
              <xsl:attribute name="style">
                 <xsl:value-of select="'width:116px;'"/>
              </xsl:attribute>

              <xsl:attribute name="name">
                  <xsl:value-of select="(@Name)"/>
               </xsl:attribute>
            </xsl:if>
            <xsl:if test="@SelectAll='true'">
            <option value=""><i18n:text>Select All</i18n:text></option>
            </xsl:if>
            <option id="EDIT" value="Edit..."><i18n:text>Edit...</i18n:text></option>

            <xsl:apply-templates select="OPTION"/>
            <xsl:if test="@SelectMore='true'">
              <option id ="MORE" value="More..."><i18n:text>More...</i18n:text></option>
            </xsl:if>


          </SELECT>
         <!-- &#xA0;
          <A HREF="javascript:doNothing()" onclick="javascript:selectToText('{@Name}');">
            <i2:img src="/cstmz_dropdown.gif" border="0" align="middle"/>
          </A>-->

          <xsl:apply-templates select="." mode="children"/>

        </xsl:if>

        <xsl:if test="@Type = 'TextSelect'">
         <input  autocomplete="off"
                ONKEYUP="matchFieldSelect(this, document.{$pFormName}.{@Name}_select)"
                fieldtype="{@Type}"
           id="{@Name}"

           value="{@Value}"
           type="field"
           class="inputfieldIE"
           size="17"
           required="{@Required}"
           ondblclick="javascript:textToSelect2('{@Name}')"
           >

            <xsl:attribute name="name">
                <xsl:value-of select="(@Name)"/>
             </xsl:attribute>
         </input>

          <SELECT
            onblur="javascript:selectToText2('{@Name}')"
            class="pulldown"   id="{@Name}_select" ONCHANGE="document.{$pFormName}.{@Name}.value = this.options[this.selectedIndex].text;">
            <xsl:attribute name="style">
               <xsl:value-of select="'width:116px;display:none'"/>
            </xsl:attribute>
              <xsl:attribute name="disabled">true</xsl:attribute>
              <xsl:attribute name="name">
                  <xsl:value-of select="concat(@Name,'_select')"/>
               </xsl:attribute>

            <xsl:apply-templates select="OPTION"/>

          </SELECT>
          <xsl:apply-templates select="." mode="children"/>

        </xsl:if>

        <!-- Text field -->
        <xsl:if test="@Type = 'Text'">
          <xsl:choose>
            <xsl:when test=" @Editable = 'False' or @Editable = 'false'">
              <input type="hidden" name="{@Name}" value="{@Value}"/>
              <i18n:text><xsl:value-of select="@Value"/></i18n:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="@Disable = 'Yes'">
                <input fieldtype="{@Type}" name="{@Name}" disabled="{@Disable}" value="{@Value}" type="field" class="inputfieldIE" size="17" required="{@Required}">
                  <xsl:apply-templates select="." mode="children"/>
                </input>          
              </xsl:if>
              <xsl:if test="not(@Disable)">
                <input fieldtype="{@Type}" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="17" required="{@Required}">
                   <xsl:apply-templates select="." mode="children"/>
                </input>          
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <!-- Date field -->
       <xsl:if test="@Type = 'Date'">
          <xsl:variable name="value">
            <i18n:date format="{@Format}"><xsl:value-of select="@Value"/></i18n:date>
          </xsl:variable>

          <input fieldtype="{@Type}" name="{@Name}" value="{$value}" type="field" class="inputfieldIE" size="17" required="{@Required}" onblur="{@OnBlur}">
             <xsl:apply-templates select="." mode="children"/>
          </input>  &#xA0;
          <i2:img onclick="javascript:core_alert('Invalid Date')" id="{@Name}_ERR" src="/alert_static_small.gif" border="0" align="middle" alt="Invalid Date" hidden="yes"/>
         &#xA0;<A HREF="javascript:doNothing()" onclick="showCalendar(document.search_form.{@Name});">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/></A>
           &#xA0;
        </xsl:if>


        <!-- Text field with Link --><!-- Deprecated -->
        <xsl:if test="@Type = 'LinkedText'">
          <input fieldtype="{@Type}" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="30" maxlength="60">
           <xsl:apply-templates select="." mode="children"/>
          </input>
          <a href="{@Link}" target="{@TargetName}"><xsl:value-of select="@LinkName"/></a>
        </xsl:if>


        <!-- Text Area field -->
        <xsl:if test="@Type = 'TextArea'">
          <textarea cols="{@Cols}" rows="{@Rows}" name="{@Name}" required="{@Required}">
            <xsl:value-of select="@Value"/>
          </textarea>
          <xsl:apply-templates select="." mode="children"/>
        </xsl:if>

         <xsl:if test="@Type = 'Phone'">
          (<input fieldtype="{@Type}" name="{concat(@Name,'_AREA_CODE')}" value="{@Value1}" type="field" class="inputfieldIE" maxlength="3" size="3"/>)&#xA0;<input fieldtype="{@Type}" name="{concat(@Name,'_LOCAL_NUM_1')}" value="{@Value2}" type="field" class="inputfieldIE" maxlength="3" size="3"/>&#xA0;-&#xA0;<input fieldtype="{@Type}" name="{concat(@Name,'_LOCAL_NUM_2')}" value="{@Value3}" type="field" class="inputfieldIE" maxlength="4" size="4">
             <xsl:apply-templates select="." mode="children"/>
          </input>
        </xsl:if>



        <!-- Links -->
        <xsl:if test="@Type = 'Links'"><xsl:attribute name="colspan">2</xsl:attribute>
          <table border="0" cellpadding="0" cellspacing="15">
            <tr>

             <td align="left" nowrap="yes" valign="bottom"><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>:</td>

               <!-- Links -->
              <xsl:for-each select="LINKS/LINK">
                <td>
                  <xsl:variable name="title"><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text></xsl:variable>


                  <xsl:variable name="onclick">
                    <xsl:choose>
                      <xsl:when test="@Type = 'popup'">javascript:popUpWindow('<xsl:value-of select="@OnClick"/>','<xsl:value-of select="@PopupName"/>')</xsl:when>
                      <xsl:otherwise><xsl:value-of select="@OnClick"/></xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>

                  <a href="{$onclick}" title="{$title}">
                    <i18n:text><xsl:value-of select="$title"/></i18n:text>&#xA0;
                      <xsl:if test="IMAGE/@Src">
                        <i2:img src="{IMAGE/@Src}" width="16" height="16" border="0"/>
                      </xsl:if>
                  </a>

                </td>
              </xsl:for-each>
            </tr>
          </table>
        </xsl:if>

        <!-- Label  field -->
        <xsl:if test="@Type = 'Label'">
          <a class="text" href="{@OnClick}">
            <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
          </a>
        </xsl:if>

        <!-- Check box -->
        <xsl:if test="@Type = 'CheckBox'">
          <xsl:choose>
            <xsl:when test="@Value = @CheckedValue">
              <input name="{@Name}" value="{@CheckedValue}" checked="true" type="checkbox">
                 <xsl:apply-templates select="." mode="children"/>
               </input>
            </xsl:when>
            <xsl:otherwise>
              <input name="{@Name}" value="{@CheckedValue}" type="checkbox">
                <xsl:apply-templates select="." mode="children"/>
              </input>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <!-- Number field -->
        <xsl:if test="@Type = 'Number'">
          <table cellspacing="0" cellpadding="0" border="0">
          <tr><td  nowrap="yes" valign="center">
          <select class="pulldown" name="{@Name}_MATCH_BY">
            <xsl:choose>
              <xsl:when test="@MatchBy = 'GREATER_EQUAL'">
                <option value="EQUAL">=</option>
                <option value="LESS_EQUAL">&lt;=</option>
                <option selected="true" value="GREATER_EQUAL">&gt;=</option>
              </xsl:when>
              <xsl:when test="@MatchBy = 'LESS_EQUAL'">
                <option value="EQUAL">=</option>
                <option selected="true" value="LESS_EQUAL">&lt;=</option>
                <option value="GREATER_EQUAL">&gt;=</option>
              </xsl:when>
              <xsl:otherwise>
                <option selected="true" value="EQUAL">=</option>
                <option value="LESS_EQUAL">&lt;=</option>
                <option value="GREATER_EQUAL">&gt;=</option>
              </xsl:otherwise>
            </xsl:choose>
            <!-- Required Field ! -->
            <xsl:if test="@Required = 'true'">
              <xsl:call-template name="display_alert_image">
                <xsl:with-param name="fieldName" select="@Name"/>
              </xsl:call-template>
           </xsl:if>

          </select>&#xA0;

          </td><td  nowrap="yes">
          <input fieldtype="{@Type}" name="{@Name}" value="{@Value}" type="field" class="inputfieldIE" size="17" required="{@Required}">
            <xsl:apply-templates select="." mode="children"/>
          </input>

          </td></tr></table>
        </xsl:if>

        <!-- Date field -->
        <xsl:if test="@Type = 'DateRange'">
        <xsl:attribute name="colspan">4</xsl:attribute>
          <xsl:variable name="fromDate">
            <i18n:date format="common"><xsl:value-of select="@Value1"/></i18n:date>
          </xsl:variable>

          <xsl:variable name="toDate">
           <i18n:date format="common"><xsl:value-of select="@Value2"/></i18n:date>
          </xsl:variable>
          <table cellspacing="4" cellpadding="0" border="0">
          <tr><td  nowrap="yes">
          <input fieldtype="{@Type}" type="field" class="inputFieldIE" size="10" name="{@Name}_FIRST_DC" value="{$fromDate}" required="{@Required}">
            <xsl:apply-templates select="." mode="children"/>
          </input>
            &#xA0;<i2:img onclick="javascript:core_alert('Invalid Date')" id="{@Name}_FIRST_DC_ERR" src="/alert_static_small.gif" border="0" align="middle" alt="Invalid Date" hidden="yes"/>

          </td><td  nowrap="yes">
          <A HREF="javascript:doNothing()" onclick="showCalendar(document.search_form.{@Name}_FIRST_DC);">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/></A>
          &#xA0;
          </td><td  nowrap="yes">
          <i18n:text>To</i18n:text>:
          <input fieldtype="{@Type}" type="field" class="inputFieldIE" size="10" name="{@Name}_LAST_DC" value="{$toDate}" required="{@Required}">
            <xsl:apply-templates select="." mode="children"/>
          </input>
           &#xA0;<i2:img onclick="javascript:core_alert('Invalid Date')" id="{@Name}_LAST_DC_ERR" src="/alert_static_small.gif" border="0" align="middle" alt="Invalid Date" hidden="yes"/>

          </td><td  nowrap="yes">
          <A HREF="javascript:doNothing()" onclick="showCalendar(document.search_form.{@Name}_LAST_DC);">
            <i2:img src="/cal_icon.gif" border="0" align="middle"/></A>
            <!-- Error Icon (!) -->
            <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>

          </td></tr></table>

        </xsl:if>

        <!-- Select field-->
        <xsl:if test="@Type = 'Select'">
          <select  class="pulldown" name="{@Name}" onchange="{@OnChange}">
            <xsl:if test="@Size">
              <xsl:attribute name="size"><xsl:value-of select="@Size"/></xsl:attribute>
            </xsl:if>

            <xsl:choose><xsl:when test="@SelectAll = 'false' or @SelectAll = 'No' or @SelectAll = 'no'"></xsl:when>
              <xsl:otherwise>
                <option value=""><i18n:text>Select All</i18n:text></option>
              </xsl:otherwise></xsl:choose>
            <xsl:apply-templates select="OPTION"/>
            <xsl:apply-templates select="." mode="children"/>
          </select>

        </xsl:if>
        <!-- Multi-Select field-->
        <xsl:if test="@Type = 'MultiSelect'">
          <select class="pulldown" MULTIPLE="yes" name="{@Name}" onchange="{@OnChange}">
            <xsl:if test="@Size">
              <xsl:attribute name="size"><xsl:value-of select="@Size"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="OPTION"/>
          </select>
        </xsl:if>
  <xsl:if test="@Type !='Links' and LINKS/LINK">
             &#xA0;<xsl:apply-templates select="LINKS/LINK" mode="content"/>
      </xsl:if>

      </td>

      <xsl:if test="position() mod $pNoOfCol != 0">
        <td width="5%"></td>
      </xsl:if>

      <xsl:if test="position() mod $pNoOfCol = 0 or position() = last()">
        <xsl:text disable-output-escaping="yes">&lt;/tr&gt;</xsl:text>
      </xsl:if>

    </xsl:if>


  </xsl:template>


  <!-- Children -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD" mode="children">

    <!-- Required Field ! -->
    <xsl:if test="@Required = 'true'">
      <xsl:call-template name="display_alert_image">
        <xsl:with-param name="fieldName" select="@Name"/>
      </xsl:call-template>
    </xsl:if>

    <!-- Error Icon (!) -->
    <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>



  </xsl:template>


  <!-- Option -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="OPTION">

    <xsl:choose>
      <xsl:when test="./@Id and ./@Value" >
        <xsl:choose>
          <xsl:when test="../@Value = ./@Id">
            <option selected="yes" value="{./@Id}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
          </xsl:when>
          <xsl:otherwise>
            <option  value="{./@Id}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
     <xsl:when test="./@Id and string-length(./@Value) = 0" >
        <xsl:choose>
          <xsl:when test="../@Value = ./@Id">
            <option selected="yes" value="{./@Id}"><i18n:text><xsl:value-of select="./@Id"/></i18n:text></option>
          </xsl:when>
          <xsl:otherwise>
            <option  value="{./@Id}"><i18n:text><xsl:value-of select="./@Id"/></i18n:text></option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
     <xsl:when test="./@Value and string-length(./@Id) = 0" >
        <xsl:choose>
          <xsl:when test="../@Value = ./@Value">
            <option selected="yes" value="{./@Value}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
          </xsl:when>
          <xsl:otherwise>
            <option value="{./@Value}"><i18n:text><xsl:value-of select="./@Value"/></i18n:text></option>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>
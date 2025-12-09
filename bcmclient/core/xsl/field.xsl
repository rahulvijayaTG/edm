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


   <xsl:import href="i18n.xsl"/>

                <!-- Please do not use this as it is being developed -->






















  <!-- Templates which do not require FIELD node  - Start::-->
  <!-- ********************************************************************************************************************************************* -->

  <!--  Content-->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="*" mode="field_content">
    <xsl:param name="pPageEditable" select="'true'"/>
    <xsl:param name="pFieldEditable" select="'true'"/>
    <xsl:param name="pEditable"/>

    <xsl:param name="pName" select="name()"/>
    <xsl:param name="pValue" select="@Value"/>
    <xsl:param name="pNoValue"/>
    <xsl:param name="pOldValue" select="@OldValue"/>
    <xsl:param name="pChanged" select="@Changed"/>

    <xsl:param name="pFormat" select="'common'"/>
    <xsl:param name="pDecimals" select="'0'"/>

    <xsl:param name="pRequired"/>
    <xsl:param name="pHidden"/>

    <xsl:param name="pType"/>
    <xsl:param name="pSize"/>
    <xsl:param name="pMaxLen"/>

    <!-- Date Only -->
    <xsl:param name="pNoOfRows" />
    <xsl:param name="pCurrentRow"/>
    <xsl:param name="pFormName"/>

    <xsl:param name="pOnkeyup"/>
    <xsl:param name="pOnChange"/>

    <xsl:variable name="editable">
      <xsl:choose>
        <xsl:when test="string-length($pEditable) > 0">
          <xsl:value-of select="$pEditable"/>
        </xsl:when>
        <xsl:when test="(@Editable = 'yes' or @Editable='true' or not(@Editable)) and $pPageEditable = 'true' and $pFieldEditable = 'true'">
          <xsl:text>true</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>false</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

      <xsl:call-template name="field_content">
        <xsl:with-param name="pName" select="$pName"/>
        <xsl:with-param name="pValue" select="$pValue"/>
        <xsl:with-param name="pNoValue" select="$pNoValue"/>

        <xsl:with-param name="pOldValue" select="$pOldValue"/>
        <xsl:with-param name="pChanged" select="$pChanged"/>

        <xsl:with-param name="pFormat" select="$pFormat"/>
        <xsl:with-param name="pDecimals" select="$pDecimals"/>

        <xsl:with-param name="pErrors" select="_ERRORS"/>

        <xsl:with-param name="pEditable" select="$editable"/>

        <xsl:with-param name="pRequired" select="$pRequired"/>
        <xsl:with-param name="pHidden" select="$pHidden"/>

        <xsl:with-param name="pType" select="$pType"/>
        <xsl:with-param name="pSize" select="$pSize"/>
        <xsl:with-param name="pMaxLen" select="$pMaxLen"/>

        <!-- Date Only -->
        <xsl:with-param name="pNoOfRows"  select="$pNoOfRows"/>
        <xsl:with-param name="pCurrentRow" select="$pCurrentRow"/>
        <xsl:with-param name="pFormName" select="$pFormName"/>

        <xsl:with-param name="pOnkeyup" select="$pOnkeyup"/>
        <xsl:with-param name="pOnChange" select="$pOnChange"/>

    </xsl:call-template>

  </xsl:template>
  <!-- Templates which do not require FIELD node  - End.-->
  <!-- ********************************************************************************************************************************************* -->


  <!-- Named Templates - Start::-->
  <!-- ********************************************************************************************************************************************* -->

  <!-- Content-->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="field_content">
    <xsl:param name="pEditable" select="'true'"/>

    <xsl:param name="pName"/>
    <xsl:param name="pValue"/>
    <xsl:param name="pNoValue"/>
    <xsl:param name="pOldValue"/>
    <xsl:param name="pChanged"/>

   <xsl:param name="pFormat" select="'common'"/>
   <xsl:param name="pDecimals" select="'0'"/>

    <xsl:param name="pErrors" select="NONE"/>

    <xsl:param name="pRequired" select="'false'"/>
    <xsl:param name="pHidden" select="'false'"/>

    <xsl:param name="pType" select="'Text'"/>
    <xsl:param name="pSize" select="'10'"/>
    <xsl:param name="pMaxLen" select="'10'"/>

    <!-- Date Only -->
    <xsl:param name="pNoOfRows" />
    <xsl:param name="pCurrentRow"/>
    <xsl:param name="pFormName"/>


    <xsl:param name="pOnkeyup"/>
    <xsl:param name="pOnChange"/>

    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="$pType = 'Number'">
          <xsl:value-of select="concat($pName,'_N0')"/>
        </xsl:when>
        <xsl:when test="$pType = 'Date'">
          <xsl:value-of select="concat($pName,'_DC')"/>
        </xsl:when>
        <xsl:when test="$pType = 'Currency'">
          <xsl:value-of select="concat($pName,'_CY')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$pName"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <xsl:variable name="value">
      <xsl:choose>
        <xsl:when test="$pEditable = 'true'">
          <xsl:call-template name="i18nize">
            <xsl:with-param name="pNoData" select="'NO_DEFAULT'"/>
            <xsl:with-param name="pData" select="$pValue"/>
            <xsl:with-param name="pType" select="$pType"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="i18nize">
            <xsl:with-param name="pData" select="$pValue"/>
            <xsl:with-param name="pType" select="$pType"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:variable>

    <table border="0" cellpadding="0" cellspacing="0" >
     <tr>
           <!-- Input -->
            <td  nowrap="yes">

              <xsl:if test="$pChanged = 'true' or $pChanged='yes'">
                <xsl:attribute name="BGCOLOR">
                <xsl:text>#00ffff</xsl:text>
                </xsl:attribute>
              </xsl:if>

              <xsl:choose>
                <!-- Value (UnEditable) -->
                <xsl:when test="$pEditable = 'false'">
                  <xsl:value-of select="$value"/>
                  <xsl:if test="$pHidden = 'true'">
                    <input type="hidden" name="{$name}" value="{$value}"/>
                  </xsl:if>

                 <xsl:apply-templates select="." mode="field_children">
                  <xsl:with-param name="pName" select="$pName"/>
                  <xsl:with-param name="pEditable" select="$pEditable"/>

                 </xsl:apply-templates>

                  <!-- Error Icon (!) -->
                  <xsl:apply-templates select="$pErrors" mode="icon_tip"/>

                </xsl:when>
                <xsl:otherwise>

                  <!--  Control (Editable) -->
                  <input fieldtype="{$pType}" type="field" class="inputfieldIE" name="{$name}" value="{$value}" size="{$pSize}" maxlength="{$pMaxLen}" align="right">

                    <xsl:if test="$pRequired = 'true'">
                      <xsl:attribute name="required">
                        <xsl:value-of select="'true'"/>
                      </xsl:attribute>
                    </xsl:if>

                    <xsl:if test="$pType = 'Number'">
                      <xsl:attribute name="onkeyup">
                        <xsl:value-of select="'javascript:onlyInteger();'"/>
                      </xsl:attribute>
                    </xsl:if>

                    <xsl:if test=" string-length($pOnChange) &gt; 0 ">
                      <xsl:attribute name="onchange">
                        <xsl:value-of select="$pOnChange"/>
                      </xsl:attribute>
                    </xsl:if>

                    <xsl:if test="$pType = 'Currency'">
                      <xsl:attribute name="onkeyup">
                        <xsl:value-of select="'javascript:onlyCurrency();'"/>
                      </xsl:attribute>
                    </xsl:if>

<!--                     <xsl:call-template name="field_get_align">
                      <xsl:with-param name="pType" select="$pType"/>
                    </xsl:call-template>
 -->
                    <xsl:if test="count($pErrors)">
                      <xsl:attribute name="validationmsg">
                        <xsl:value-of select="'error'"/>
                      </xsl:attribute>
                    </xsl:if>
                  </input>


                  <xsl:if test="$pType = 'Date'">
                    <xsl:call-template name="field_calendar">
                      <xsl:with-param name="pNoOfRows"  select="$pNoOfRows"/>
                      <xsl:with-param name="pFormName"  select="$pFormName"/>
                      <xsl:with-param name="pCurrentRow" select="$pCurrentRow"/>
                      <xsl:with-param name="pName" select="$name"/>
                    </xsl:call-template>
                  </xsl:if>

                 <xsl:apply-templates select="." mode="field_children">
                  <xsl:with-param name="pName" select="$pName"/>
                  <xsl:with-param name="pEditable" select="$pEditable"/>

                 </xsl:apply-templates>

                  <!-- Error Icon (!) -->
                  <xsl:apply-templates select="$pErrors" mode="icon_tip"/>
                  &#xA0;<i2:img onclick="javascript:core_alert(this.alt)" id="{$name}_ERR" src="/alert_static_small.gif" border="0" align="middle" alt="Error" hidden="yes"/>

                    <!--  Required Icon (!) -->
                    <xsl:variable name="alt">
                      <i18n:text>Required</i18n:text>
                    </xsl:variable>

                    <xsl:if test="$pRequired = 'true' and $pEditable='true'">
                       &#xA0;<i2:img id="{$name}_REQ" src="/alert_static_small.gif" border="0" align="middle" alt="{$alt}" hidden="yes"/>
                    </xsl:if>

                </xsl:otherwise>
              </xsl:choose>


              <xsl:if test="($pChanged = 'true' or $pChanged = 'yes')">
                (
                <xsl:call-template name="i18nize">
                  <xsl:with-param name="pData" select="$pOldValue"/>
                  <xsl:with-param name="pNoData" select="$pNoValue"/>
                  <xsl:with-param name="pType" select="$pType"/>
                  <xsl:with-param name="pFormat" select="$pFormat"/>
                  <xsl:with-param name="pDecimals" select="$pDecimals"/>
                </xsl:call-template>
                )
              </xsl:if>

            </td>

          </tr>
        </table>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="field_get_align">
    <xsl:param name="pType"/>
      <xsl:attribute name="align">
        <xsl:choose>

          <!-- Text -->
          <xsl:when test="$pType='Text'">left</xsl:when>

          <!-- Currency -->
          <xsl:when test="$pType='Currency'">right</xsl:when>

          <!-- Number -->
          <xsl:when test="$pType='Number'">right</xsl:when>

          <!-- Date -->
          <xsl:when test="$pType='Date'">right</xsl:when>

          <xsl:otherwise>left</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

  </xsl:template>


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="field_calendar">
    <xsl:param name="pNoOfRows"/>
    <xsl:param name="pFormName"/>
    <xsl:param name="pCurrentRow"/>
    <xsl:param name="pName"/>

    <!-- Calendar - Start::-->
    <xsl:choose>
      <xsl:when test="$pNoOfRows > 1">
        &#xA0;<A  HREF="javascript:showCalendar(document.{$pFormName}.{$pName}[{$pCurrentRow}]);" onclick="javascript:showCalendar(document.{$pFormName}.{$pName}[{$pCurrentRow}]);">
          <i2:img src="/cal_icon.gif" border="0" align="middle"/>
        </A>
      </xsl:when>
      <xsl:otherwise>
        &#xA0;<A HREF="javascript:showCalendar(document.{$pFormName}.{$pName});" onclick="javascript:showCalendar(document.{$pFormName}.{$pName});">
          <i2:img src="/cal_icon.gif" border="0" align="middle" />
        </A>
      </xsl:otherwise>
    </xsl:choose>
    <!-- Calendar - End.-->
  </xsl:template>

  <!-- Named Templates - End.-->
  <!-- ********************************************************************************************************************************************* -->



  <!-- Layout - Start::-->
  <!-- ********************************************************************************************************************************************* -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="FIELDS" mode="layout">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
      <tr>
        <xsl:apply-templates select="." mode="layout_columns">
          <xsl:with-param name="currentColumn" select="'1'"/>
        </xsl:apply-templates>
      </tr>
    </table>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELDS" mode="layout_columns">
    <xsl:param name="currentColumn"/>
    <xsl:param name="columnsPerRow" select="@Rows"/>
    <xsl:param name="pEndPosition" select="$currentColumn * @Rows"/>
    <xsl:param name="pStartPosition" select="$pEndPosition - @Rows"/>

      <xsl:if test="$currentColumn &lt;= @Columns">
        <!-- Layout Column#1 -->
        <td  width="{100 mod @Columns}" height="100%" valign="top">
          <xsl:apply-templates select="." mode="layout_column">
            <xsl:with-param name="fields" select="FIELD[position() &gt; $pStartPosition  and position() &lt;= $pEndPosition]"/>
          </xsl:apply-templates>
        </td>

        <!-- Layout column#2,3,4 -->
        <xsl:apply-templates select="." mode="layout_columns">
         <xsl:with-param name="currentColumn" select="$currentColumn + 1"/>
        </xsl:apply-templates>

      </xsl:if>

  </xsl:template>


  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELDS" mode="layout_column">
    <xsl:param name="fields"/>
      <table>
        <xsl:apply-templates select="$fields" mode="content_form"/>
      </table>
  </xsl:template>

  <!-- Layout - end -->
  <!-- ********************************************************************************************************************************************* -->


  <!-- Content - Form -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD" mode="content_form">
    <tr>
      <xsl:apply-templates select="." mode="label_form"/>
      <xsl:apply-templates select="." mode="content"/>
      <td width="5%"></td>
    </tr>
  </xsl:template>
<!-- Content - Form -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD[@Type = 'Hidden']" mode="content_form">
    <input name="{@Name}" type="hidden" value="{@Value}"/>
  </xsl:template>

  <!--  Label - form-->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD" mode="label_form">
    <td nowrap="yes">
      <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text><xsl:if test="string-length(@DisplayText) > 0">:</xsl:if>
      <xsl:if test="@Required = 'true' and @Editable='true'">
        <xsl:call-template name="display_required_field_indicator"/>
      </xsl:if>
    </td>
  </xsl:template>

  <xsl:template match="FIELD[@Type='DateRange']" mode="label_form">
    <td nowrap="yes"><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
     &#xA0;<i18n:text>From</i18n:text>:
      <xsl:if test="@Required = 'true' and @Editable='true'">
        <xsl:call-template name="display_required_field_indicator"/>
      </xsl:if>
    </td>
  </xsl:template>

  <!-- Content - table -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD" mode="content_table">
    <xsl:apply-templates select="." mode="content"/>
 </xsl:template>

  <!--  Label - table -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD" mode="label_table">
    <td nowrap="yes"><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
      <xsl:if test="@Required = 'true' and @Editable='true'">
        <xsl:call-template name="display_required_field_indicator"/>
      </xsl:if>
    </td>
  </xsl:template>

  <!-- Date - Start:: -->
  <!--  unEditable - Content-->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD[@Type = 'Date' and (not(@Editable) or @Editable='false')]" mode="content">
    <td nowrap="yes" align="left">
      <table border="0" cellpadding="0" cellspacing="0" >
        <tr>
          <td  align="right" nowrap="yes">
            <xsl:if test="@Changed ='yes'">
              <xsl:attribute name="BGCOLOR">#00ffff</xsl:attribute>
            </xsl:if>
            <i18n:date format="{@Format}"><xsl:value-of select="@Value"/></i18n:date>
            <xsl:apply-templates select="." mode="children"/>
          </td>
        </tr>
      </table>
    </td>
  </xsl:template>
<!-- Date - End -->

  <!-- Text - Start:: -->
  <!-- ********************************************************************************************************************************************* -->

  <!--  unEditable - Content-->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD[@Type = 'Text' and (not(@Editable) or @Editable='false')]" mode="content">
    <td nowrap="yes" align="left">
      <table border="0" cellpadding="0" cellspacing="0" >
        <tr>
          <td  align="right" nowrap="yes">
            <xsl:if test="@Changed ='yes'">
              <xsl:attribute name="BGCOLOR">#00ffff</xsl:attribute>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="string-length(@Value) > 0">
                <i18n:text><xsl:value-of select="@Value"/></i18n:text>
              </xsl:when>
              <xsl:otherwise>
                <i18n:text>None</i18n:text>
              </xsl:otherwise>
            </xsl:choose>

            <xsl:apply-templates select="." mode="children"/>

          </td>
        </tr>
      </table>
    </td>
  </xsl:template>

    <xsl:template match="FIELD[@Type = 'Text' and @OnClick and  (not(@Editable) or @Editable='false')]" mode="content">
    <td nowrap="yes" align="left">
      <table border="0" cellpadding="0" cellspacing="0" >
        <tr>
          <td  align="right" nowrap="yes">

            <xsl:variable name="onclick">
                <xsl:choose>
                  <xsl:when test="@Target = '_new'">javascript:popUpWindow('<xsl:value-of select="@OnClick"/>','<xsl:value-of select="@PopupName"/>')</xsl:when>
                  <xsl:when test="@OnClickType = 'popup'">javascript:popUpWindow('<xsl:value-of select="@OnClick"/>','<xsl:value-of select="@PopupName"/>')</xsl:when>
                  <xsl:otherwise><xsl:value-of select="@OnClick"/>&amp;RET_PAGE=<xsl:value-of select="$currentUrl"/></xsl:otherwise>
                </xsl:choose>
             </xsl:variable>
             <a class="text" href="{$onclick}">

            <xsl:if test="@Changed ='yes'">
              <xsl:attribute name="BGCOLOR">#00ffff</xsl:attribute>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="string-length(@Value) > 0">
                <i18n:text><xsl:value-of select="@Value"/></i18n:text>
              </xsl:when>
              <xsl:otherwise>
                <i18n:text>None</i18n:text>
              </xsl:otherwise>
            </xsl:choose>
            </a>
            <xsl:apply-templates select="." mode="children"/>

          </td>
        </tr>
      </table>
    </td>
  </xsl:template>


  <!--  Editable - Content-->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD[@Type = 'Text' and (@Editable='true')]" mode="content">
    <td nowrap="yes" align="left">
      <table border="0" cellpadding="0" cellspacing="0" >
        <tr>
          <td  align="right" nowrap="yes">
            <xsl:variable name="value">
              <i18n:text><xsl:value-of select="@Value"/></i18n:text>
            </xsl:variable>

            <input fieldtype="Text" name="{@Name}"  value="{$value}" type="field" class="inputfieldIE" size="{@Size}" maxlength="{@MaxLength}">
              <xsl:if test="@Required = 'true'">
                <xsl:attribute name="required">
                  <xsl:value-of select="'true'"/>
                </xsl:attribute>
              </xsl:if>

              <xsl:if test="_ERRORS">
                <xsl:attribute name="validationmsg">
                  <xsl:value-of select="'error'"/>
                </xsl:attribute>
              </xsl:if>
            </input>

            <!-- Required Icon ! -->
            <xsl:if test="@Required = 'true'">
              <xsl:call-template name="display_alert_image">
                <xsl:with-param name="fieldName" select="@Name"/>
              </xsl:call-template>
            </xsl:if>

            <!-- Link Icons -->
            <xsl:apply-templates select="LINKS/LINK" mode="field_link"/>

            <!-- Error Icon (!) -->
            <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>

            <xsl:apply-templates select="." mode="children"/>
          </td>
        </tr>
      </table>
    </td>
  </xsl:template>

  <!-- Text - End -->
  <!-- ********************************************************************************************************************************************* -->



  <!-- Number - Start:: -->
  <!-- ********************************************************************************************************************************************* -->

  <!--  unEditable - Content-->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD[@Type = 'Number' and (not(@Editable) or @Editable='false')]" mode="content">
    <td nowrap="yes" align="left">
      <table border="0" cellpadding="0" cellspacing="0" >
        <tr>
          <td  align="right" nowrap="yes">
              <xsl:attribute name="BGCOLOR">
              <xsl:choose>
                <xsl:when test="@BGColor">
                  <xsl:value-of select="@BGColor"/>
                </xsl:when>
                <xsl:when test="@Changed ='yes'">
                  <xsl:value-of select="'#00ffff'"/>
                </xsl:when>
                <xsl:otherwise>
                </xsl:otherwise>
              </xsl:choose>
              </xsl:attribute>

            <xsl:choose>
              <xsl:when test="string-length(@Value) > 0">
                <i18n:number><xsl:value-of select="@Value"/></i18n:number>
              </xsl:when>
              <xsl:otherwise>
                <i18n:text>N/A</i18n:text>
              </xsl:otherwise>
            </xsl:choose>


            <xsl:if test="string-length(@Uom) > 0">
              &#xA0;<i18n:text><xsl:value-of select="@Uom"/></i18n:text>
            </xsl:if>

            <!-- Link Icons -->
            <xsl:apply-templates select="LINKS/LINK" mode="field_link"/>

            <xsl:apply-templates select="." mode="children"/>

          </td>
        </tr>
      </table>
    </td>
  </xsl:template>

  <!-- Editable -->
  <!-- C -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="FIELD[@Type = 'Number' and @Editable='true'] | TD[@Type = 'Number' and @Editable='true']" mode="content">

    <xsl:variable name="value">
      <i18n:number><xsl:value-of select="@Value"/></i18n:number>
    </xsl:variable>

    <td nowrap="yes" align="left">
      <input name="{@Name}_N0"  value="{$value}" fieldtype="{@Type}" size="{@Size}" maxlength="{@MaxLength}" type="field" class="inputfieldIE">

        <!-- isRequired -->
        <xsl:if test="@Required = 'true'">
          <xsl:attribute name="required">
            <xsl:value-of select="'true'"/>
          </xsl:attribute>
        </xsl:if>

        <!-- hasErrors -->
        <xsl:if test="_ERRORS">
          <xsl:attribute name="validationmsg">
            <xsl:value-of select="'error'"/>
          </xsl:attribute>
        </xsl:if>
      </input>

      <!-- Required Icon ! -->
      <xsl:if test="@Required = 'true'">
        <xsl:call-template name="display_alert_image">
          <xsl:with-param name="fieldName" select="concat(@Name,'_N0')"/>
        </xsl:call-template>
      </xsl:if>

      <!-- Numberic Validation Error-->
       &#xA0;<i2:img onclick="javascript:core_alert('Invalid Number')" id="{@Name}_N0_ERR" src="/alert_static_small.gif" border="0" align="middle" alt="Invalid Number" hidden="yes"/>

      <!-- Link Icons -->
      <xsl:apply-templates select="LINKS/LINK" mode="field_link"/>

      <!-- Error Icon (!) -->
      <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>

      <xsl:apply-templates select="." mode="my_children"/>

     </td>
  </xsl:template>

  <!-- Editable -->
  <!-- C -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="FIELD[@Type = 'Select' and @Editable='true']" mode="content">

    <td nowrap="yes" align="left">

      <select  class="pulldown" name="{@Name}" onchange="{@OnChange}">
        <!-- isRequired -->
        <xsl:if test="@Required = 'true'">
          <xsl:attribute name="required">
            <xsl:value-of select="'true'"/>
          </xsl:attribute>
        </xsl:if>

        <!-- hasErrors -->
        <xsl:if test="_ERRORS">
          <xsl:attribute name="validationmsg">
            <xsl:value-of select="'error'"/>
          </xsl:attribute>
        </xsl:if>

        <xsl:choose>
          <xsl:when test="@SelectOne = 'true'">
            <option value=""><i18n:text>Select...</i18n:text></option>
          </xsl:when>
          <xsl:when test="@SelectAll = 'No'"></xsl:when>
          <xsl:otherwise>
            <option value=""><i18n:text>Select All</i18n:text></option>
          </xsl:otherwise></xsl:choose>

         <xsl:apply-templates select="OPTION"/>
         <xsl:apply-templates select="*/CODE_MASTER_VALUE" mode="pulldown">
           <xsl:with-param name="selectedId" select="@Value"/>
          </xsl:apply-templates>



      </select>

        <xsl:if test="@Required = 'true'">
          <xsl:call-template name="display_alert_image">
            <xsl:with-param name="fieldName" select="@Name"/>
          </xsl:call-template>
        </xsl:if>

        <!-- Error Icon (!) -->
        <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>

        <xsl:apply-templates select="." mode="my_children"/>

    </td>
  </xsl:template>



<!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="LINK" mode="field_link">
      &#xA0;<xsl:apply-templates select="." mode="content"/>
  </xsl:template>
  <!-- Number - End. -->
  <!-- ********************************************************************************************************************************************* -->


  <!-- DateRange - Start:: -->
  <!-- ********************************************************************************************************************************************* -->

  <!--  unEditable - Content-->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD[@Type = 'DateRange' and (not(@Editable) or @Editable='false')]" mode="content">
    <td nowrap="yes" align="right">
          <table cellspacing="4" cellpadding="0" border="0">
          <tr><td  nowrap="yes">
            <i18n:date format="common"><xsl:value-of select="@Value1"/></i18n:date>
          </td>
          <td  nowrap="yes">
            &#xA0;&#xA0;&#xA0;<i18n:text>To</i18n:text>:
           <i18n:date format="common"><xsl:value-of select="@Value2"/></i18n:date>
          </td><td  nowrap="yes">
          </td></tr></table>
  </td>
  </xsl:template>


<!-- TextArea - Start:: -->
  <!-- ********************************************************************************************************************************************* -->
  <!--  unEditable - Content-->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD[@Type = 'TextArea' and (not(@Editable) or @Editable='false')]" mode="content">

    <td nowrap="yes" align="right">
  		<textarea cols="{@Cols}" rows="{@Rows}" class="textArea" onFocus="this.blur();"><xsl:value-of select="@Value"/></textarea>
    </td>
  </xsl:template>


    <xsl:template match="FIELD[@Type = 'TextArea' and (@Editable='true')]" mode="content">

        <td nowrap="yes" align="right">
              <textarea name="{@Name}" cols="{@Cols}" rows="{@Rows}" class="textArea" ><xsl:value-of select="@Value"/></textarea>
        </td>
      </xsl:template>

  <!-- CURRENCY - START. -->
  <!-- ********************************************************************************************************************************************* -->

  <!--  UnEditable - Content-->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD[@Type = 'Currency' and (not(@Editable) or @Editable='false')]" mode="content">
    <td nowrap="yes" align="right">
      <table border="0" cellpadding="0" cellspacing="0" >
        <tr>
          <td  align="right" nowrap="yes">
            <xsl:if test="@Changed ='yes'">
              <xsl:attribute name="BGCOLOR">#00ffff</xsl:attribute>
            </xsl:if>

             <xsl:choose>
              <xsl:when test="string-length(@Value) > 0">
                <i18n:currency><xsl:value-of select="@Value"/></i18n:currency>
              </xsl:when>
              <xsl:otherwise>
                <i18n:text>N/A</i18n:text>
              </xsl:otherwise>
            </xsl:choose>

            <xsl:apply-templates select="." mode="children"/>

          </td>
        </tr>
      </table>
    </td>
  </xsl:template>


  <!--  Editable - Content-->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD[@Type = 'Currency' and (@Editable='true')]" mode="content">
    <td nowrap="yes" align="right">
      <table border="0" cellpadding="0" cellspacing="0" >
        <tr>
          <td  align="right" nowrap="yes">
            <xsl:variable name="value">
              <i18n:currency><xsl:value-of select="@Value"/></i18n:currency>
            </xsl:variable>

            <input fieldtype="Currency" name="{@Name}_CY" value="{$value}" type="field" class="inputfieldIE" size="8" maxlength="17">
              <xsl:if test="@Required = 'true'">
                <xsl:attribute name="required">
                  <xsl:value-of select="'true'"/>
                </xsl:attribute>
              </xsl:if>

              <xsl:attribute name="onkeyup">
                <xsl:value-of select="'javascript:onlyCurrency();'"/>
              </xsl:attribute>

              <xsl:if test="_ERRORS">
                <xsl:attribute name="validationmsg">
                  <xsl:value-of select="'error'"/>
                </xsl:attribute>
              </xsl:if>
            </input>
            <xsl:apply-templates select="." mode="children"/>
          </td>
        </tr>
      </table>
    </td>
  </xsl:template>



  <!-- Children -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FIELD[@Type = 'Currency']" mode="children">

    <xsl:if test="@Hide = 'true'">
      <input type="hidden" name="{@Name}_CY" value="{@Value}"/>
    </xsl:if>

    <!-- Required Field ! -->
    <xsl:if test="@Required = 'true' and @Editable='true'">
      <xsl:call-template name="display_alert_image">
        <xsl:with-param name="fieldName" select="concat(@Name,'_CY')"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:apply-templates select="LINKS"/>

    <!-- Error Icon (!) -->
    <xsl:apply-templates select="_ERRORS" mode="icon_tip"/>

  </xsl:template>

<!-- CURRENCY - End. -->
<!-- ********************************************************************************************************************************************* -->

<!-- Children - Start:: -->
<!-- ********************************************************************************************************************************************* -->

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="_ERRORS" mode="icon_tip">
    <xsl:for-each select="_ERROR">
      <xsl:variable name="alt">
        <i18n:text><xsl:value-of select="./@Value"/></i18n:text>
      </xsl:variable>
      &#xA0;<i2:img onclick="javascript:core_alert('{$alt}')" src="/alert_static_small.gif" alt="{$alt}" border="0" align="middle"/>
    </xsl:for-each>
  </xsl:template>

<!-- Children - End. -->
<!-- ********************************************************************************************************************************************* -->


<!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="highlight_if_changed">
    <xsl:param name="field"/>
    <xsl:if test="$field/@Changed ='yes' or $field/CHANGE_TYPE/@Value = 'CHANGE'">
      <xsl:attribute name="BGCOLOR">
      <xsl:text>#00ffff</xsl:text>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="$field/CHANGE_TYPE/@Value = 'CANCEL'">
      <xsl:attribute name="BGCOLOR">
      <xsl:text>#ff00ff</xsl:text>
      </xsl:attribute>
    </xsl:if>
	 <xsl:if test="$field/CHANGE_TYPE/@Value = 'ADD'">
      <xsl:attribute name="BGCOLOR">
      <xsl:text>#00ff00</xsl:text>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>


	<!-- New -->
	  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template name="print_change_type_table_cell">
    <xsl:param name="changeType"/>

    <xsl:if test="string-length($changeType) ='0'">
      <td nowrap="true">
        -
      </td>
    </xsl:if>

    <xsl:if test="$changeType ='NONE'">
      <td nowrap="true">
        <i18n:text>None</i18n:text>
      </td>
    </xsl:if>

    <xsl:if test="$changeType ='ADD'">
      <td nowrap="true">
        <xsl:attribute name="BGCOLOR">#00ff00</xsl:attribute>
        <i18n:text>Added</i18n:text>
      </td>
    </xsl:if>


    <xsl:if test="$changeType ='CANCEL'">
      <td nowrap="true" >
        <xsl:attribute name="BGCOLOR">#ff00ff</xsl:attribute>
        <i18n:text>Cancelled</i18n:text>
      </td>
    </xsl:if>

    <xsl:if test="$changeType ='Yes'">
      <td nowrap="true">
        <xsl:attribute name="BGCOLOR">#00ffff</xsl:attribute>
        <i18n:text>Modified</i18n:text>
      </td>
    </xsl:if>

    <xsl:if test="$changeType ='CHANGE'">
      <td nowrap="true">
        <xsl:attribute name="BGCOLOR">#00ffff</xsl:attribute>
        <i18n:text>Modified</i18n:text>
      </td>
    </xsl:if>
  </xsl:template>


  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="field_get_show_changes">true</xsl:template>
  <xsl:variable name="field_show_changes"><xsl:call-template name="field_get_show_changes"/></xsl:variable>


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="field_content_text_area">
    <xsl:param name="pEditable" select="'true'"/>

    <xsl:param name="pName"/>
    <xsl:param name="pValue"/>
    <xsl:param name="pNoValue"/>
    <xsl:param name="pOldValue"/>
    <xsl:param name="pChanged"/>
    <xsl:param name="pNoWrap" select="'true'"/>

    <xsl:param name="pErrors" select="NONE"/>

    <xsl:param name="pRequired" select="'false'"/>
    <xsl:param name="pHidden" select="'false'"/>

    <xsl:param name="pCols" select="'15'"/>
    <xsl:param name="pRows" select="'4'"/>

    <xsl:param name="pOnkeyup"/>
    <xsl:param name="pOnChange"/>

    <table border="0" cellpadding="0" cellspacing="0" >
     <tr>
           <!-- Input -->
            <td  >
              <xsl:if test="$pNoWrap = 'true'">
                <xsl:attribute name="nowrap">yes</xsl:attribute>
              </xsl:if>
              <xsl:if test="$pChanged = 'true' or $pChanged='yes' and $field_show_changes = 'true'">
                <xsl:attribute name="BGCOLOR">
                <xsl:text>#00ffff</xsl:text>
                </xsl:attribute>
              </xsl:if>

              <xsl:choose>
                <!-- Value (UnEditable) -->
                <xsl:when test="$pEditable = 'false'">
   								<textarea cols="{$pCols}" rows="{$pRows}" class="textArea" onFocus="this.blur();"><xsl:value-of select="$pValue"/></textarea>

                  <xsl:if test="$pHidden = 'true'">
                    <input type="hidden" name="{$pName}" value="{$pValue}"/>
                  </xsl:if>

                 <xsl:apply-templates select="." mode="field_children">
                  <xsl:with-param name="pName" select="$pName"/>
                  <xsl:with-param name="pEditable" select="$pEditable"/>

                 </xsl:apply-templates>

                  <!-- Error Icon (!) -->
                  <xsl:apply-templates select="$pErrors" mode="icon_tip"/>

                </xsl:when>
                <xsl:otherwise>

                  <!--  Control (Editable) -->
   								<textarea cols="{$pCols}" rows="{$pRows}" class="textArea" ><xsl:value-of select="$pValue"/>

                    <xsl:if test="$pRequired = 'true'">
                      <xsl:attribute name="required">
                        <xsl:value-of select="'true'"/>
                      </xsl:attribute>
                    </xsl:if>

                    <xsl:if test=" string-length($pOnChange) &gt; 0 ">
                      <xsl:attribute name="onchange">
                        <xsl:value-of select="$pOnChange"/>
                      </xsl:attribute>
                    </xsl:if>


<!--                     <xsl:call-template name="field_get_align">
                      <xsl:with-param name="pType" select="$pType"/>
                    </xsl:call-template>
 -->
                    <xsl:if test="count($pErrors)">
                      <xsl:attribute name="validationmsg">
                        <xsl:value-of select="'error'"/>
                      </xsl:attribute>
                    </xsl:if>
									</textarea>

                 <xsl:apply-templates select="." mode="field_children">
                  <xsl:with-param name="pName" select="$pName"/>
                  <xsl:with-param name="pEditable" select="$pEditable"/>
                 </xsl:apply-templates>

                  <!-- Error Icon (!) -->
                  <xsl:apply-templates select="$pErrors" mode="icon_tip"/>
                  &#xA0;<i2:img onclick="javascript:core_alert(this.alt)" id="{$pName}_ERR" src="/alert_static_small.gif" border="0" align="middle" alt="Error" hidden="yes"/>

                    <!--  Required Icon (!) -->
                    <xsl:variable name="alt">
                      <i18n:text>Required</i18n:text>
                    </xsl:variable>

                    <xsl:if test="$pRequired = 'true' and $pEditable='true'">
                       &#xA0;<i2:img id="{$pName}_REQ" src="/alert_static_small.gif" border="0" align="middle" alt="{$alt}" hidden="yes"/>
                    </xsl:if>

                </xsl:otherwise>
              </xsl:choose>


              <xsl:if test="($pChanged = 'true' or $pChanged = 'yes') and $field_show_changes = 'true'">
                (<textarea cols="{$pCols}" rows="{$pRows}" class="textArea" onFocus="this.blur();"><xsl:value-of select="$pOldValue"/></textarea>)
              </xsl:if>

            </td>

          </tr>
        </table>
  </xsl:template>





<!-- Content-->
<!-- **********************************************************************
*********************************************************************** -->
<xsl:template name="field_content_select">
  <xsl:param name="pEditable" select="'true'"/>
  <xsl:param name="pId"/>
  <xsl:param name="pName"/>
  <xsl:param name="pValue"/>
  <xsl:param name="pNoValue"/>
  <xsl:param name="pOldValue"/>
  <xsl:param name="pChanged"/>

  <xsl:param name="pFormat" select="'common'"/>
  <xsl:param name="pDecimals" select="'0'"/>

  <xsl:param name="pErrors" select="NONE"/>

  <xsl:param name="pRequired" select="'false'"/>
  <xsl:param name="pHidden" select="'false'"/>

  <xsl:param name="pType" select="'Text'"/>

  <xsl:param name="pOnkeyup"/>
  <xsl:param name="pOnChange"/>

  <xsl:variable name="name">
    <xsl:choose>
      <xsl:when test="$pType = 'Number'">
        <xsl:value-of select="concat($pName,'_N0')"/>
      </xsl:when>
      <xsl:when test="$pType = 'Date'">
        <xsl:value-of select="concat($pName,'_DC')"/>
      </xsl:when>
      <xsl:when test="$pType = 'Currency'">
        <xsl:value-of select="concat($pName,'_CY')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$pName"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>


  <xsl:variable name="value">
    <xsl:choose>
      <xsl:when test="$pEditable = 'true'">
        <xsl:call-template name="i18nize">
          <xsl:with-param name="pNoData" select="'NO_DEFAULT'"/>
          <xsl:with-param name="pData" select="$pValue"/>
          <xsl:with-param name="pType" select="$pType"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="i18nize">
          <xsl:with-param name="pData" select="$pValue"/>
          <xsl:with-param name="pType" select="$pType"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:variable>


  <xsl:if test="$pChanged = 'true' or $pChanged='yes'">
    <xsl:attribute name="BGCOLOR">
    <xsl:text>#fff6a6</xsl:text>
    </xsl:attribute>
  </xsl:if>

  <xsl:choose>
    <!-- Value (UnEditable) -->
    <xsl:when test="$pEditable = 'false'">
      <xsl:value-of select="$value"/>
      <xsl:if test="$pHidden = 'true'">
        <input type="hidden" name="{$name}" value="{$pId}"/>
      </xsl:if>

      <xsl:apply-templates select="." mode="field_children">
        <xsl:with-param name="pName" select="$pName"/>
        <xsl:with-param name="pEditable" select="$pEditable"/>

      </xsl:apply-templates>

      <!-- Error Icon (!) -->
      <xsl:apply-templates select="$pErrors" mode="icon_tip"/>

    </xsl:when>
    <xsl:otherwise>

      <!--  Control (Editable) -->
      <select name="{$pName}" class="inputfieldIE">
        <xsl:if test="$pRequired = 'true'">
          <xsl:attribute name="required">
          <xsl:value-of select="'true'"/>
          </xsl:attribute>
        </xsl:if>
        <option value="">
          <i18n:text>Select...</i18n:text>
        </option>
        <xsl:apply-templates select="." mode="field_options">
           <xsl:with-param name="pName" select="$pName"/>
        </xsl:apply-templates>

        <xsl:if test=" string-length($pOnChange) &gt; 0 ">
          <xsl:attribute name="onchange">
          <xsl:value-of select="$pOnChange"/>
          </xsl:attribute>
        </xsl:if>

        <xsl:if test="count($pErrors)">
          <xsl:attribute name="validationmsg">
          <xsl:value-of select="'error'"/>
          </xsl:attribute>
        </xsl:if>
      </select>

      <xsl:apply-templates select="." mode="field_children">
        <xsl:with-param name="pName" select="$pName"/>
        <xsl:with-param name="pEditable" select="$pEditable"/>
      </xsl:apply-templates>

      <!-- Error Icon (!) -->
      <xsl:apply-templates select="$pErrors" mode="icon_tip"/>
      &#xA0;
      <i2:img onclick="javascript:core_alert(this.alt)" id="{$name}_ERR" src="/alert_static_small.gif" border="0" align="middle" alt="Error" hidden="yes"/>

      <!--  Required Icon (!) -->
      <xsl:variable name="alt">
        <i18n:text>Required</i18n:text>
      </xsl:variable>

      <xsl:if test="$pRequired = 'true' and $pEditable='true'">
        &#xA0;
        <i2:img id="{$name}_REQ" src="/alert_static_small.gif" border="0" align="middle" alt="{$alt}" hidden="yes"/>
      </xsl:if>

    </xsl:otherwise>
  </xsl:choose>


  <xsl:if test="($pChanged = 'true' or $pChanged = 'yes')">
    (
    <xsl:call-template name="i18nize">
      <xsl:with-param name="pData" select="$pOldValue"/>
      <xsl:with-param name="pNoData" select="$pNoValue"/>
      <xsl:with-param name="pType" select="$pType"/>
      <xsl:with-param name="pFormat" select="$pFormat"/>
      <xsl:with-param name="pDecimals" select="$pDecimals"/>
    </xsl:call-template>
    )
  </xsl:if>

</xsl:template>




</xsl:stylesheet>
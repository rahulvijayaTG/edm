<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="VALIDATION" mode="validation_area">
 

    <xsl:call-template name="display_validation_messages">
    </xsl:call-template>

  </xsl:template>


  <!-- Validation Messages -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="display_validation_messages">
    <xsl:param name="pFormName" select="@containerId"/>
    <xsl:param name="pInstructionMessage" select="@InstructionMessage"/>
    <xsl:param name="pSuccessMessage" select="@SuccessMessage"/>
    <xsl:param name="pErrorMessage" select="@ErrorMessage"/>
    <xsl:param name="pFieldErrorMessage" select="@FieldErrorMessage"/>
    <xsl:param name="pAnyFieldIsRequired" select="@AnyFieldIsRequired"/>
    <xsl:param name="pAnyFieldHasErrors" select="@AnyFieldHasErrors"/>
    <xsl:param name="pAnyFieldHasInformation" select="@AnyFieldHasInformation"/>


    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="instructionsArea" id="instruction_area_{$pFormName}">


      <xsl:if test="string-length($pInstructionMessage) > 0">
        <xsl:call-template name="display_form_instruction_message">
          <xsl:with-param name="pFormName" select="$pFormName"/>
          <xsl:with-param name="pMessage" select="$pInstructionMessage"/>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$pAnyFieldHasInformation = 'true'">
        <xsl:call-template name="display_field_information_message">
          <xsl:with-param name="pFormName" select="$pFormName"/>
        </xsl:call-template>
      </xsl:if>


      <xsl:if test="$pAnyFieldIsRequired = 'true'">
        <xsl:call-template name="display_field_required_message">
          <xsl:with-param name="pFormName" select="$pFormName"/>
        </xsl:call-template>
      </xsl:if>


      <xsl:call-template name="display_field_error_message">
        <xsl:with-param name="pFormName" select="$pFormName"/>
        <xsl:with-param name="pMessage" select="$pFieldErrorMessage"/>
        <xsl:with-param name="pAnyFieldHasErrors" select="$pAnyFieldHasErrors"/>
      </xsl:call-template>

      <xsl:call-template name="display_field_missing_message">
        <xsl:with-param name="pFormName" select="$pFormName"/>
      </xsl:call-template>

      <xsl:if test="string-length($pSuccessMessage) > 0">
        <xsl:call-template name="display_form_success_message">
          <xsl:with-param name="pFormName" select="$pFormName"/>
          <xsl:with-param name="pMessage" select="$pSuccessMessage"/>
        </xsl:call-template>
      </xsl:if>

        <xsl:call-template name="display_form_error_message">
          <xsl:with-param name="pFormName" select="$pFormName"/>
          <xsl:with-param name="pMessage" select="$pErrorMessage"/>
        </xsl:call-template>

    </table>

    <script>
      <xsl:value-of select="concat('validation_areas_add(', $quote , @containerId, $quote , ',', $quote , 'this', $quote ,');')"/>
    </script>

  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="display_field_required_message">
    <xsl:param name="pFormName"/>
    <tr instructionType="denotes_required_field">
      <td align="center">
        <font color="red">*</font>
      </td>
      <td width="100%">
        <i18n:text>denotes required field</i18n:text>
      </td>
    </tr>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="display_field_missing_message">
    <xsl:param name="pFormName"/>

    <tr instructionType="required_field_missing" style="display:none">
      <td align="center">
        <i2:img src="/alert_static_small.gif" border="0" align="middle">
          <i2:attribute name="alt">
            <i18n:text>alert</i18n:text>
          </i2:attribute>
        </i2:img>
      </td>
      <td width="100%">
        <i18n:text>Please fill in all required fields before proceeding...</i18n:text>
      </td>
    </tr>

  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="display_field_error_message">
    <xsl:param name="pFormName"/>
    <xsl:param name="pMessage"/>
    <xsl:param name="pAnyFieldHasErrors" select="'false'"/>

    <tr instructionType="field_error_message">
      <xsl:choose>
        <xsl:when test="$pAnyFieldHasErrors = 'true'">
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="style">display:none</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <td align="center">
        <i2:img src="/alert_static_small.gif" alt="Error" border="0" align="middle"/>
      </td>
      <td width="100%">
        <xsl:choose>
          <xsl:when test="string-length($pMessage) >0">
            <i18n:text>
              <xsl:value-of select="$pMessage"/>
            </i18n:text>
          </xsl:when>
          <xsl:otherwise>
            <i18n:text>Information is invalid. Please correct and submit again.</i18n:text>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>

  </xsl:template>


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="display_field_information_message">
    <xsl:param name="pFormName"/>
    <tr instructionType="field_information_message">
      <td align="center">
        <i2:img src="/information_sml.gif" border="0">
          <i2:attribute name="alt">
            <i18n:text>Information</i18n:text>
          </i2:attribute>
        </i2:img>
      </td>
      <td width="100%">
        <i18n:text>For more details about a control click information icon.</i18n:text>
      </td>
    </tr>

  </xsl:template>



  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="display_form_success_message">
    <xsl:param name="pFormName"/>
    <xsl:param name="pMessage" select="/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value"/>

    <tr instructionType="success_message" id="success_message{$pFormName}">
      <td align="center">
        <i2:img src="/alert_green_static.gif" border="0" align="middle">
          <i2:attribute name="alt">
            <i18n:text>Success</i18n:text>
          </i2:attribute>
        </i2:img>
      </td>
      <td width="100%">
        <i18n:text>
          <xsl:value-of select="$pMessage"/>
        </i18n:text>
      </td>
    </tr>

  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="display_form_instruction_message">
    <xsl:param name="pFormName"/>
    <xsl:param name="pMessage"/>

    <tr instructionType="instruction_message" id="instruction_message{$pFormName}">
      <td colspan="2">
        <i18n:text>
          <xsl:value-of select="$pMessage"/>
        </i18n:text>
      </td>
    </tr>
  </xsl:template>


  <!-- **********************************************************************
        *********************************************************************** -->
  <xsl:template name="display_form_error_message">
    <xsl:param name="pFormName"/>

    <xsl:for-each select="_ERRORS/_ERROR">
      <tr instructionType="error_message"  id="error_message{$pFormName}">
        <td align="center">
          <i2:img src="/alert_static_small.gif" border="0" align="middle">
            <i2:attribute name="alt">
              <i18n:text>Error</i18n:text>
            </i2:attribute>
          </i2:img>
        </td>
        <td width="100%">
          <xsl:if test="@Description">
            <i18n:text>
              <xsl:value-of select="@Description"/>
            </i18n:text>&#xA0;
          </xsl:if>

          <i18n:text>
            <xsl:value-of select="@Value"/>
          </i18n:text>
        </td>
      </tr>
    </xsl:for-each>

  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
</xsl:stylesheet>
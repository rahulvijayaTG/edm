<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
   <!-- Target -->
  <xsl:import href="../../../core/xsl/buttons.xsl"/>
  <xsl:import href="../../../core/xsl/mdm_buttons.xsl"/>

  <!-- Overriding the BUTTON template of core. -->

  <xsl:template match="BUTTON">

    <xsl:variable name="actionType" select="@ActionType"/>

    <xsl:variable name="isMutatingAction">
      <xsl:choose>
        <xsl:when test=" ($actionType = '_ADD_' ) or ($actionType = '_EDIT_' ) or ($actionType = '_COPY_' ) or ($actionType = '_DELETE_' ) or ($actionType = '_SAVE_' )">Yes</xsl:when>
        <xsl:otherwise>No</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="isMutationAllowed">
      <xsl:choose>
        <xsl:when test=" string-length(./@isMutationAllowed) &gt; 0 ">
          <xsl:value-of select="./@isMutationAllowed"/>
        </xsl:when>
        <xsl:otherwise>Yes</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <xsl:variable name="toDisableButton">
      <xsl:choose>
        <xsl:when test=" ($isMutationAllowed = 'No' or $isMutationAllowed = 'no') and $isMutatingAction = 'Yes' ">Yes</xsl:when>
        <xsl:otherwise>No</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>



      <!-- Text -->
      <xsl:variable name="text">
         <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
      </xsl:variable>
    <!-- enable tooltip flag-->
      <xsl:variable name="enableTooltip">
        <xsl:choose>
          <xsl:when test="string-length($text) > $maxlen">yes</xsl:when>
          <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
     <!-- truncated test-->
      <xsl:variable name="truncatedText">
        <xsl:choose>
          <xsl:when test="$enableTooltip='yes'">
            <xsl:value-of select="concat(substring($text,0,$maxlen -2), '...')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$text"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>




      <i2:button id="{./@Id}" name="{./@Name}"  emphasized="{./@Emphasized}" target="{./@Target}">
        <i2:attribute name="onclick">
          <xsl:value-of select="./@OnClick"/>
        </i2:attribute>


        <!-- Disabled Attribute -->
        <xsl:choose>
          <!-- Check if button needs to be disabled  -->
          <xsl:when test="$toDisableButton = 'Yes'">
            <i2:attribute name="disabled">yes</i2:attribute>
          </xsl:when>
          <xsl:otherwise>
            <!--  Button need not be diasbled then go ahead check for 'noOfRows' or user preference  -->
            <xsl:choose>
              <!-- If the button is to be disabled depending on records -->
              <xsl:when test="./@Disabled = 'report'">
                <xsl:if test="$noOfRows = 0">
                  <i2:attribute name="disabled">yes</i2:attribute>
                </xsl:if>
              </xsl:when>
              <!-- otherwise -->
              <xsl:otherwise>
                  <!-- user preference -->
                <i2:attribute name="disabled"><xsl:value-of select="./@Disabled"/></i2:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>

     <!-- tooltip-->
      <xsl:if test="$enableTooltip='yes'">
        <i2:attribute name="tooltip"><xsl:value-of select="$text"/></i2:attribute>
      </xsl:if>

      <!-- Display Text -->
      &#xA0;<xsl:value-of select="$truncatedText"/>&#xA0;
<!--
        ima = <xsl:value-of select="$isMutationAllowed"/> and tdb = <xsl:value-of select="$toDisableButton"/>
-->

      </i2:button>
      <xsl:if test="@Id and  @DisableOnClick = 'true' and (not(@Disabled) or @Disabled !='yes')">
      <i2:button hidden="yes" id="{./@Id}_disabled" name="{./@Name}" onclick="{./@OnClick}" emphasized="{./@Emphasized}" target="{./@Target}">
       <i2:attribute name="disabled">yes</i2:attribute>
     <!-- tooltip-->
      <xsl:if test="$enableTooltip='yes'">
        <i2:attribute name="tooltip"><xsl:value-of select="$text"/></i2:attribute>
      </xsl:if>

      <!-- Display Text -->
      &#xA0;<xsl:value-of select="$truncatedText"/>&#xA0;
        </i2:button>
      </xsl:if>


  </xsl:template>

</xsl:stylesheet>

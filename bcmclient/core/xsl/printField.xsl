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


  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template match="*" mode="printField">
    <xsl:param name="pFieldName" select="name(.)"/>
    <xsl:param name="pTitle" select="concat(name(.),'.LABEL')"/>
    <xsl:param name="pPrepend"/>

    <xsl:param name="pValue" select="@Value"/>
    <xsl:param name="pOldValue" select="@OldValue"/>

    <xsl:param name="pNoValue"/>
    <xsl:param name="pValueLink"/>
    <xsl:param name="pChanged" select="@Changed"/>

    <xsl:param name="pType"/>
    <xsl:param name="pFormat"/>
    <xsl:param name="pDecimals"/>
    <xsl:param name="pAlign"/>

    <xsl:call-template name="printField">

      <xsl:with-param name="pFieldName" select="$pFieldName"/>
      <xsl:with-param name="pTitle" select="$pTitle"/>
      <xsl:with-param name="pPrepend" select="$pPrepend"/>


      <xsl:with-param name="pValue" select="$pValue"/>
      <xsl:with-param name="pOldValue" select="$pOldValue"/>

      <xsl:with-param name="pNoData" select="$pNoValue"/>
      <xsl:with-param name="pValueLink" select="$pValueLink"/>
      <xsl:with-param name="pChanged" select="$pChanged"/>

      <xsl:with-param name="pType" select="$pType"/>
      <xsl:with-param name="pFormat" select="$pFormat"/>
      <xsl:with-param name="pDecimals" select="$pDecimals"/>
      <xsl:with-param name="pAlign" select="$pAlign"/>

    </xsl:call-template>

  </xsl:template>


  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="printField">

    <xsl:param name="pFieldName"/>
    <xsl:param name="pTitle"/>
    <xsl:param name="pPrepend"/>

    <xsl:param name="pValue"/>
    <xsl:param name="pOldValue"/>
    <xsl:param name="pNoValue"/>
    <xsl:param name="pValueLink"/>
    <xsl:param name="pChanged"/>

    <xsl:param name="pType"/>
    <xsl:param name="pFormat"/>
    <xsl:param name="pDecimals"/>
    <xsl:param name="pAlign"/>

    <tr>
      <xsl:call-template name="printTitle">
        <xsl:with-param name="pFieldName" select="$pFieldName"/>
        <xsl:with-param name="pValue" select="$pTitle"/>
      </xsl:call-template>

      <xsl:call-template name="printValue">
        <xsl:with-param name="pFieldName" select="$pFieldName"/>
        <xsl:with-param name="pPrepend" select="$pPrepend"/>

        <xsl:with-param name="pValue" select="$pValue"/>
        <xsl:with-param name="pOldValue" select="$pOldValue"/>
        <xsl:with-param name="pNoData" select="$pNoValue"/>
        <xsl:with-param name="pValueLink" select="$pValueLink"/>
        <xsl:with-param name="pChanged" select="$pChanged"/>

        <xsl:with-param name="pType" select="$pType"/>
        <xsl:with-param name="pFormat" select="$pFormat"/>
        <xsl:with-param name="pDecimals" select="$pDecimals"/>
        <xsl:with-param name="pAlign" select="$pAlign"/>

      </xsl:call-template>
    </tr>
  </xsl:template>

  <!-- ********************************************************************** 
*********************************************************************** -->
  <xsl:template name="printTitle">
    <xsl:param name="pValue"/>
    <xsl:param name="pNoData"/>
    <xsl:param name="pType"/>
    <xsl:param name="pFormat"/>

    <td nowrap="true">
      <xsl:call-template name="i18nize">
        <xsl:with-param name="pData" select="$pValue"/>
        <xsl:with-param name="pNoData" select="$pNoData"/>
        <xsl:with-param name="pType" select="$pType"/>
        <xsl:with-param name="pFormat" select="$pFormat"/>

      </xsl:call-template>
      :
    </td>
  </xsl:template>


  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="printValue">
    <xsl:param name="pFieldName"/>

    <xsl:param name="pValue"/>
    <xsl:param name="pOldValue"/>
    <xsl:param name="pChanged" select="'false'"/>
    <xsl:param name="pValueLink"/>
    <xsl:param name="pNoData"/>

    <xsl:param name="pType"/>
    <xsl:param name="pFormat"/>
    <xsl:param name="pDecimals"/>
    <xsl:param name="pAlign" select="'left'"/>
    <xsl:param name="pPrepend" select="'false'"/>

    <xsl:variable name="value">
      <xsl:choose>
        <!-- If need to prepend -->
        <xsl:when test="$pPrepend = 'true'">
          <!-- If field has a value -->
          <xsl:if test="string-length($pValue) > 0">
            <!-- Prepend field name to value -->
            <xsl:value-of select="concat($pFieldName,'.',$pValue)"/>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$pValue"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <td nowrap="true" align="{$pAlign}">
      <xsl:if test="$pChanged = 'true' or $pChanged='yes'">
        <xsl:attribute name="BGCOLOR">
        <xsl:text>#fff6a6</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="string-length($pValueLink) > 0 and string-length($value) > 0 ">
          <a target="appFrame" href="{$pValueLink}">
            <xsl:call-template name="i18nize">
              <xsl:with-param name="pData" select="$value"/>
              <xsl:with-param name="pNoData" select="$pNoData"/>
              <xsl:with-param name="pType" select="$pType"/>
              <xsl:with-param name="pFormat" select="$pFormat"/>
              <xsl:with-param name="pDecimals" select="$pDecimals"/>
            </xsl:call-template>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="i18nize">
            <xsl:with-param name="pData" select="$value"/>
            <xsl:with-param name="pNoData" select="$pNoData"/>
            <xsl:with-param name="pType" select="$pType"/>
            <xsl:with-param name="pFormat" select="$pFormat"/>
            <xsl:with-param name="pDecimals" select="$pDecimals"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:if test="($pChanged = 'true' or $pChanged = 'yes')">
        (
        <xsl:call-template name="i18nize">
          <xsl:with-param name="pData" select="$pOldValue"/>
          <xsl:with-param name="pNoData" select="$pNoData"/>
          <xsl:with-param name="pType" select="$pType"/>
          <xsl:with-param name="pFormat" select="$pFormat"/>
          <xsl:with-param name="pDecimals" select="$pDecimals"/>
        </xsl:call-template>
        )
      </xsl:if>
    </td>
  </xsl:template>






  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="highlight_if_changed">
    <xsl:param name="field"/>
    <xsl:if test="$field/@Changed ='yes'">
      <xsl:attribute name="BGCOLOR">
      <xsl:text>#fff6a6</xsl:text>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>



  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="print_change_type">
    <xsl:param name="changeType"/>

    <xsl:if test="$changeType ='ADD'">
      <td>
        <xsl:attribute name="BGCOLOR">
        <xsl:text>#fff6a6</xsl:text>
        </xsl:attribute>
        <i18n:text>Change</i18n:text>
        :
      </td>
      <td nowrap="true">
        <xsl:attribute name="BGCOLOR">
        <xsl:text>#fff6a6</xsl:text>
        </xsl:attribute>
        <I>
          &#xA0;
          <i18n:text>Added</i18n:text>
        </I>
      </td>
      <td >
        &#xA0;&#xA0;&#xA0;
      </td>
    </xsl:if>
    <xsl:if test="$changeType ='CANCEL'">
      <td>
        <xsl:attribute name="BGCOLOR">
        <xsl:text>#fff6a6</xsl:text>
        </xsl:attribute>
        <i18n:text>Change</i18n:text>
        :
      </td>
      <td nowrap="true">
        <xsl:attribute name="BGCOLOR">
        <xsl:text>#fff6a6</xsl:text>
        </xsl:attribute>
        <I>
          &#xA0;
          <i18n:text>Cancelled</i18n:text>
        </I>
      </td>
      <td >
        &#xA0;&#xA0;&#xA0;
      </td>
    </xsl:if>

    <xsl:if test="$changeType ='Yes'">
      <td>
        <xsl:attribute name="BGCOLOR">
        <xsl:text>#fff6a6</xsl:text>
        </xsl:attribute>
        <i18n:text>Change</i18n:text>
        :
      </td>
      <td nowrap="true">
        <xsl:attribute name="BGCOLOR">
        <xsl:text>#fff6a6</xsl:text>
        </xsl:attribute>
        <I>
          &#xA0;
          <i18n:text>Modified</i18n:text>
        </I>
      </td>
      <td>
        &#xA0;&#xA0;&#xA0;
      </td>
    </xsl:if>

    <xsl:if test="$changeType ='CHANGED'">
      <td>
        <xsl:attribute name="BGCOLOR">
        <xsl:text>#fff6a6</xsl:text>
        </xsl:attribute>
        <i18n:text>Change</i18n:text>
        :
      </td>
      <td nowrap="true">
        <xsl:attribute name="BGCOLOR">
        <xsl:text>#fff6a6</xsl:text>
        </xsl:attribute>
        <I>
          &#xA0;
          <i18n:text>Modified</i18n:text>
        </I>
      </td>
      <td >
        &#xA0;&#xA0;&#xA0;
      </td>
    </xsl:if>

  </xsl:template>



  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template match="*" mode="printCell">
    <xsl:param name="pPrepend"/>

    <xsl:param name="pValue" select="@Value"/>
    <xsl:param name="pOldValue" select="@OldValue"/>

    <xsl:param name="pNoValue"/>
    <xsl:param name="pValueLink"/>
    <xsl:param name="pChanged" select="@Changed"/>

    <xsl:param name="pType"/>
    <xsl:param name="pFormat"/>
    <xsl:param name="pDecimals"/>
    <xsl:param name="pAlign"/>

    <xsl:call-template name="printCell">
      <xsl:with-param name="pPrepend" select="$pPrepend"/>
      <xsl:with-param name="pValue" select="$pValue"/>
      <xsl:with-param name="pOldValue" select="$pOldValue"/>
      <xsl:with-param name="pNoData" select="$pNoValue"/>
      <xsl:with-param name="pValueLink" select="$pValueLink"/>
      <xsl:with-param name="pChanged" select="$pChanged"/>

      <xsl:with-param name="pType" select="$pType"/>
      <xsl:with-param name="pFormat" select="$pFormat"/>
      <xsl:with-param name="pDecimals" select="$pDecimals"/>
      <xsl:with-param name="pAlign" select="$pAlign"/>

    </xsl:call-template>

  </xsl:template>


  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="printCell">

    <xsl:param name="pValue" select="@Value"/>
    <xsl:param name="pOldValue" select="@OldValue"/>
    <xsl:param name="pNoValue"/>
    <xsl:param name="pValueLink"/>
    <xsl:param name="pChanged" select="@Changed"/>

    <xsl:param name="pType"/>
    <xsl:param name="pFormat"/>
    <xsl:param name="pDecimals"/>
    <xsl:param name="pAlign"/>
    <xsl:param name="pPrepend"/>

    <xsl:call-template name="printCellValue">
      <xsl:with-param name="pPrepend" select="$pPrepend"/>

      <xsl:with-param name="pValue" select="$pValue"/>
      <xsl:with-param name="pOldValue" select="$pOldValue"/>
      <xsl:with-param name="pNoData" select="$pNoValue"/>
      <xsl:with-param name="pValueLink" select="$pValueLink"/>
      <xsl:with-param name="pChanged" select="$pChanged"/>

      <xsl:with-param name="pType" select="$pType"/>
      <xsl:with-param name="pFormat" select="$pFormat"/>
      <xsl:with-param name="pDecimals" select="$pDecimals"/>
      <xsl:with-param name="pAlign" select="$pAlign"/>

    </xsl:call-template>
  </xsl:template>


  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="printCellValue">
    <xsl:param name="pValue"/>
    <xsl:param name="pOldValue"/>
    <xsl:param name="pChanged" select="'false'"/>
    <xsl:param name="pValueLink"/>
    <xsl:param name="pNoData"/>
    <xsl:param name="pFieldName"/>

    <xsl:param name="pType"/>
    <xsl:param name="pFormat"/>
    <xsl:param name="pDecimals"/>
    <xsl:param name="pAlign" select="'left'"/>
    <xsl:param name="pPrepend" select="'false'"/>


    <xsl:variable name="value">
      <xsl:choose>
        <!-- If need to prepend -->
        <xsl:when test="$pPrepend = 'true'">
          <!-- If field has a value -->
          <xsl:if test="string-length($pValue) > 0">
            <!-- Prepend field name to value -->
            <xsl:value-of select="concat($pFieldName,'.',$pValue)"/>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$pValue"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="align">
      <xsl:choose>
        <xsl:when test="$pAlign != ''">
          <xsl:value-of select="$pAlign"/>
        </xsl:when>
        <xsl:when test="$pType = 'Number'">
          <xsl:text>right</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>left</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


      <xsl:if test="$pChanged = 'true' or $pChanged='yes'">
        <xsl:attribute name="BGCOLOR">
        <xsl:text>#fff6a6</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <table border="0" cellpadding="0" cellspacing="0" align="{$align}">
        <tr>
          <td nowrap="true" valign="top">

            <xsl:choose>
              <xsl:when test="string-length($pValueLink) > 0 and string-length($value) > 0 ">
                <a target="appFrame" href="{$pValueLink}">
                  <xsl:call-template name="i18nize">
                    <xsl:with-param name="pData" select="$value"/>
                    <xsl:with-param name="pNoData" select="$pNoData"/>
                    <xsl:with-param name="pType" select="$pType"/>
                    <xsl:with-param name="pFormat" select="$pFormat"/>
                    <xsl:with-param name="pDecimals" select="$pDecimals"/>
                  </xsl:call-template>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="i18nize">
                  <xsl:with-param name="pData" select="$value"/>
                  <xsl:with-param name="pNoData" select="$pNoData"/>
                  <xsl:with-param name="pType" select="$pType"/>
                  <xsl:with-param name="pFormat" select="$pFormat"/>
                  <xsl:with-param name="pDecimals" select="$pDecimals"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>

          </td>

        </tr>
        <tr>

          <xsl:if test="($pChanged = 'true' or $pChanged = 'yes') and $pOldValue != ' '">
            <td nowrap="true" valign="top">
              <xsl:text>(</xsl:text>
              <xsl:call-template name="i18nize">
                <xsl:with-param name="pData" select="$pOldValue"/>
                <xsl:with-param name="pNoData" select="$pNoData"/>
                <xsl:with-param name="pType" select="$pType"/>
                <xsl:with-param name="pFormat" select="$pFormat"/>
                <xsl:with-param name="pDecimals" select="$pDecimals"/>
              </xsl:call-template>
              <xsl:text>)</xsl:text>
            </td>

          </xsl:if>
        </tr>
      </table>
  </xsl:template>



  <!-- Version -->

  <!-- ********************************************************************** 
       *********************************************************************** -->
</xsl:stylesheet>






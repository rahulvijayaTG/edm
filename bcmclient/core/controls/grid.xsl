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
  <xsl:template match="GRID" mode="layout">
    <xsl:apply-templates select="."/>
  </xsl:template>
 

<!-- **********************************************************************
    *********************************************************************** -->
 <xsl:template match="GRID" mode="top">
   <xsl:apply-templates select="."/>

 </xsl:template>



<!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="GRID">
    <table width="100%" border="0" cellPadding="0" cellSpacing="{@CellSpacing}" type="grid">
      <xsl:for-each select="ROW">
        <xsl:choose>
          <!-- cell containing only script should not be put in a tr/td as
          cellspacing will be applied. Currently cell having a script will never have any
          visual components.
           -->
        <xsl:when test="CELL/script">
         <xsl:apply-templates select="CELL/script"/>
        </xsl:when>
         <xsl:otherwise>
        <tr>
          <xsl:for-each select="CELL">
            <td>
              <xsl:if test="@Class">
                <xsl:attribute name="class"><xsl:value-of select="@Class"/></xsl:attribute>
              </xsl:if>
              <xsl:if test="@Width">
                <xsl:attribute name="width"><xsl:value-of select="@Width"/></xsl:attribute>
              </xsl:if>
              <xsl:if test="@ColSpan">
                <xsl:attribute name="colspan"><xsl:value-of select="@ColSpan"/></xsl:attribute>
              </xsl:if>
              <xsl:if test="@RowSpan">
                <xsl:attribute name="rowspan"><xsl:value-of select="@RowSpan"/></xsl:attribute>
              </xsl:if>
              <xsl:if test="@VAlign">
                <xsl:attribute name="valign"><xsl:value-of select="@Valign"/></xsl:attribute>
              </xsl:if>
              <xsl:for-each select="CONTAINER|SEARCH|GRID|FIELDS|REPORT|DYNAMIC_PGL|CHART|PIVOT|EXCEL_PIVOT|BUTTONS|T_FIELD_VR">
                <xsl:choose>
                  <xsl:when test="name(.) = 'T_FIELD_VR'">
                    <xsl:apply-templates select="." mode="content"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:apply-templates select="." mode="layout"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:for-each>
            </td>
          </xsl:for-each>
        </tr>

        </xsl:otherwise>

        </xsl:choose>

      </xsl:for-each>
    </table>

  </xsl:template>


  <!-- **********************************************************************
        *********************************************************************** -->
  <xsl:template match="ROW" mode="layout_row">
    <xsl:param name="showDivider" select="'false'"/>
    <tr>
      <xsl:apply-templates mode="layout_row">
        <xsl:with-param name="showDivider" select="$showDivider"/>
      </xsl:apply-templates>
    </tr>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
    <xsl:template match="*" mode="layout_row">
      <xsl:apply-templates select="." mode="label_form"/>
      <xsl:apply-templates select="." mode="content"/>
      <td width="50%"></td>  <!-- 08/19/2004 WJD - Changed to properly space the label and the content -->  
    </xsl:template>


</xsl:stylesheet>

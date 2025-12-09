<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:output method="html"/>
  
  <xsl:variable name="quote">'</xsl:variable>
  <xsl:variable name="maxlen">30</xsl:variable>
  <xsl:variable name="maxlenForToolTip">28</xsl:variable>


  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FOLDER">
    <xsl:param name="service"/>

    <!-- onclick -->
    <xsl:variable name="onclick">
      <xsl:choose>
        <xsl:when test="@Popup = 'true'">
            <xsl:value-of select="concat('javascript:popUpWindow(',$quote, @OnClick, $quote,  ',', $quote, @PopupId, $quote, ');')"/>
         </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@OnClick"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- target -->
    <xsl:variable name="target">
      <xsl:choose>
        <xsl:when test="@Popup = 'true'">
        </xsl:when>
        <xsl:when test="string-length(@Target) > 0">
          <xsl:value-of select="@Target"/>
        </xsl:when>
        <xsl:otherwise>appFrame</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- PadItem -->
    <i2:paditem>

      <!-- Text -->
      <xsl:variable name="text">
        <i18n:text><xsl:value-of select="@Name"/></i18n:text>
      </xsl:variable>

      <!--xsl:variable name="truncatedText">
        <xsl:choose>
          <xsl:when test="string-length($text) > $maxlen">
            <xsl:value-of select="concat(substring($text,0,$maxlen -3), '...')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$text"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <i2:attribute name="text"><xsl:value-of select="$truncatedText"/></i2:attribute-->
      <i2:attribute name="text"><xsl:value-of select="$text"/></i2:attribute>

      <!-- selected -->
      <xsl:if test="string-length(@Selected) > 0">
        <i2:attribute name="selected"><xsl:value-of select="@Selected"/></i2:attribute>
      </xsl:if>

      <!-- target -->
      <xsl:if test="string-length($target) > 0">
        <i2:attribute name="target"><xsl:value-of select="$target"/></i2:attribute>
      </xsl:if>




      <!-- Onclick -->
      <xsl:if test="string-length($onclick) > 0">
        <i2:attribute name="onclick"><xsl:value-of select="$onclick"/></i2:attribute>
      </xsl:if>

      <!-- Tooltip -->
<!--       <xsl:if test="contains($text,'...')"> -->
      <!--xsl:if test="string-length($text) > $maxlenForToolTip">
        <i2:attribute name="tooltip"><xsl:value-of select="$text"/></i2:attribute>
      </xsl:if-->

      <!-- documents -->
      <xsl:apply-templates select="DOCUMENTS/DOCUMENT">
        <xsl:with-param name="service" select="$service"/>
      </xsl:apply-templates>

      <!-- Children -->
      <xsl:apply-templates select="FOLDER">
        <xsl:with-param name="service" select="$service"/>
      </xsl:apply-templates>

    </i2:paditem>

  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->

  <xsl:template match="DOCUMENT">
    <xsl:param name="service"/>
    <!-- onclick -->
    <xsl:variable name="onclick">
      <xsl:choose>
        <xsl:when test="@Popup = 'true'">
            <xsl:value-of select="concat('javascript:popUpWindow(',$quote, @OnClick, $quote,  ',', $quote, @PopupId, $quote, ');')"/>
         </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="concat( 'tableeditor/tableeditor.jsp?DIRECTORY=bcm.framework.tableeditor&amp;FILE=TableEditorView&amp;MODE=START' , '&amp;TABLE_NAME=', @Name , '&amp;SERVICE=', $service,'&amp;Auth_Enabled=true'  ) "/>
          <xsl:value-of select="@OnClick"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- target -->
    <xsl:variable name="target">
      <xsl:choose>
        <xsl:when test="@Popup = 'true'">
        </xsl:when>
        <xsl:when test="string-length(@Target) > 0">
          <xsl:value-of select="@Target"/>
        </xsl:when>
        <xsl:otherwise>appFrame</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- PadItem -->
    <i2:paditem>

      <!-- Text -->
      <xsl:variable name="text">
        <xsl:variable name="isAuditTrail">
            <xsl:value-of select="@AuditTrail"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$isAuditTrail = 'true'">
                <xsl:variable name="tablename">
                  <i18n:text>
                    <xsl:value-of select="substring-before(@Name, '_AT')"/>
                  </i18n:text>
                </xsl:variable>
                 <xsl:variable name="audit">
                      <i18n:text>
                        <xsl:value-of select="'Audit'"/>
                      </i18n:text>
                  </xsl:variable>
                  <xsl:value-of select="concat($tablename,' ',$audit)"/>
            </xsl:when>
            <xsl:otherwise>
                <i18n:text><xsl:value-of select="@DisplayName"/></i18n:text>
            </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <!--xsl:variable name="truncatedText">
        <xsl:choose>
          <xsl:when test="string-length($text) > $maxlen">
            <xsl:value-of select="concat(substring($text,0,$maxlen -3), '...')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$text"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <i2:attribute name="text"><xsl:value-of select="$truncatedText"/></i2:attribute-->
      <i2:attribute name="text"><xsl:value-of select="$text"/></i2:attribute>

      <!-- selected -->
      <xsl:if test="string-length(@Selected) > 0">
        <i2:attribute name="selected"><xsl:value-of select="@Selected"/></i2:attribute>
      </xsl:if>

      <!-- target -->
      <xsl:if test="string-length($target) > 0">
        <i2:attribute name="target"><xsl:value-of select="$target"/></i2:attribute>
      </xsl:if>

      <!-- Onclick -->
      <xsl:if test="string-length($onclick) > 0">
        <i2:attribute name="onclick"><xsl:value-of select="$onclick"/></i2:attribute>
      </xsl:if>

      <!-- Tooltip -->
<!--       <xsl:if test="contains($text,'...')"> -->
      <!--xsl:if test="string-length($text) > $maxlenForToolTip">
        <i2:attribute name="tooltip"><xsl:value-of select="$text"/></i2:attribute>
      </xsl:if-->


    </i2:paditem>

  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->



</xsl:stylesheet>




<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:output method="html"/>

  <xsl:template match="NAVIGATION">
    <body style="background-color:#E6E6E6">
      <table width="100%" height="100%">
        <tr>
          <td width="100%" valign="top" align="center">
            <xsl:apply-templates select="PAD"/>
          </td>
        </tr>
      </table>
    </body>
  </xsl:template>
    
  <xsl:variable name="quote">'</xsl:variable>  
  <xsl:variable name="maxlen">19</xsl:variable>  
  <xsl:variable name="maxlenForToolTip">18</xsl:variable>  
  
  <xsl:template match="PAD">

    <xsl:variable name="full_title_text">
      <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>      
    </xsl:variable>

    <xsl:variable name="title">      
      <xsl:choose>
        <xsl:when test="string-length($full_title_text) > $maxlen">
          <xsl:value-of select="concat(substring($full_title_text,0,$maxlen -3), '...')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$full_title_text"/>
        </xsl:otherwise>
      </xsl:choose>  
    </xsl:variable>
    
    <!-- NavArea -->
    <i2:navarea height="100%">

      <!-- Pad -->
      <i2:pad title="{$title}" tooltip="{$full_title_text}">

        <!-- Name -->        
        <xsl:if test="string-length(@Name) > 0">
          <i2:attribute name="name"><xsl:value-of  select="@Name"/></i2:attribute>
        </xsl:if>
        
        <!-- Scrollable -->
        <xsl:if test="string-length(@Scrollable) > 0">
          <i2:attribute name="scrollable" ><xsl:value-of select="@Scrollable"/></i2:attribute>
        </xsl:if>
        
        <!-- Type -->
        <xsl:if test="string-length(@Type) > 0">
          <i2:attribute name="type"><xsl:value-of select="@Type"/></i2:attribute>
        </xsl:if>
        
        <!-- PadItem/Children -->
        <xsl:apply-templates select="PAD_ITEM">
          <xsl:with-param name="type" select="@Type"/>
        </xsl:apply-templates>
        
      </i2:pad>
      
    </i2:navarea>
    
  </xsl:template>        
  
  
  <xsl:template match="PAD_ITEM">
    <xsl:param name="type"/>
    
    <!-- onclick -->
    <xsl:variable name="onclick">
      <xsl:choose>
        <xsl:when test="@Popup = 'true'">  
            <xsl:value-of select="concat('javascript:popUpWindow(',$quote, @Url, $quote,  ',', $quote, @PopupId, $quote, ');')"/>
         </xsl:when>
        <xsl:otherwise>  
          <xsl:value-of select="@Url"/>
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
        <xsl:when test="$type = 'solution'">navFrame</xsl:when>
        <xsl:otherwise>appFrame</xsl:otherwise>  
      </xsl:choose>
    </xsl:variable>
    
    <!-- PadItem -->
    <i2:paditem>

      <!-- Text -->
      <xsl:variable name="text">
        <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>      
      </xsl:variable>

      <xsl:variable name="truncatedText">      
        <xsl:choose>
          <xsl:when test="string-length($text) > $maxlen">
            <xsl:value-of select="concat(substring($text,0,$maxlen -3), '...')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$text"/>
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:variable>
      
      <i2:attribute name="text"><xsl:value-of select="$truncatedText"/></i2:attribute>

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
      <xsl:if test="string-length($text) > $maxlenForToolTip">
        <i2:attribute name="tooltip"><xsl:value-of select="$text"/></i2:attribute>
      </xsl:if>
      
      <!-- Children -->
      <xsl:apply-templates/>
      
    </i2:paditem>
    
  </xsl:template>
  </xsl:stylesheet>
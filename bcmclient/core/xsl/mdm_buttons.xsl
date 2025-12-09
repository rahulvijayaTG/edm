<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
                

 <xsl:variable name="maxlen">15</xsl:variable>
  <!-- Button -->
  <xsl:template name="mdmButton">
    <xsl:param name="name"/>
    <xsl:param name="id"/>
    <xsl:param name="nopad"/>
    <xsl:param name="onclick"/>
    <xsl:param name="text"/>
    <xsl:param name="disabled"/>
    <xsl:param name="emphasized"/>
    <xsl:param name="target"/>
    
    <!--i2:button id="{./@Id}" name="{./@Name}"  emphasized="{./@Emphasized}" target="{./@Target}"-->
    
    <xsl:variable name="i18ntext">
        <i18n:text>
            <xsl:value-of select="$text"/>
        </i18n:text>
    </xsl:variable>
    <!-- enable tooltip flag-->
      <xsl:variable name="enableTooltip">
        <xsl:choose>
          <xsl:when test="string-length($i18ntext) > $maxlen">yes</xsl:when>
          <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
     <!-- truncated test-->
      <xsl:variable name="truncatedText">
        <xsl:choose>
          <xsl:when test="$enableTooltip='yes'">
            <xsl:value-of select="concat(substring($i18ntext,0,$maxlen -2), '...')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$i18ntext"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
    
    <i2:button>
      <xsl:if test="string-length($id) > 0 "> 
        <i2:attribute name="id"><xsl:value-of select="$id"/></i2:attribute>
      </xsl:if>
      <xsl:if test="string-length($name) > 0 "> 
        <i2:attribute name="name"><xsl:value-of select="$name"/></i2:attribute>
      </xsl:if>
      
      <xsl:if test="string-length($onclick) > 0 "> 
        <i2:attribute name="onclick"><xsl:value-of select="$onclick"/></i2:attribute>
      </xsl:if>
        
      <xsl:if test="string-length($disabled) > 0 "> 
        <i2:attribute name="disabled"><xsl:value-of select="$disabled"/></i2:attribute>
      </xsl:if>
      <xsl:if test="string-length($emphasized) > 0 "> 
        <i2:attribute name="emphasized"><xsl:value-of select="$emphasized"/></i2:attribute>
      </xsl:if>
      <xsl:if test="string-length($target) > 0 "> 
        <i2:attribute name="target"><xsl:value-of select="$target"/></i2:attribute>
      </xsl:if>
      <!-- tooltip-->
      <xsl:if test="$enableTooltip='yes'">
        <i2:attribute name="tooltip"><xsl:value-of select="$i18ntext"/></i2:attribute>
      </xsl:if>

      <!-- Disabled Attribute -->            
      <!--xsl:choose>
        <xsl:when test="$disabled = 'report'">
          <xsl:if test="ancestor::TABLE/@NoOfRows = 0 ">
            <i2:attribute name="disabled">yes</i2:attribute>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <i2:attribute name="disabled"><xsl:value-of select="{$disabled}"/></i2:attribute>
        </xsl:otherwise>
      </xsl:choose--> 

     <!-- Display Text -->
      &#xA0;<xsl:value-of select="$truncatedText"/>&#xA0;
      
    </i2:button>
    
    <!--xsl:if test="@Id and  @DisableOnClick = 'true' and (not(@Disabled) or @Disabled !='yes')">
    <i2:button hidden="yes" id="{./@Id}_disabled" name="{./@Name}" onclick="{./@OnClick}" emphasized="{./@Emphasized}" target="{./@Target}">
     <i2:attribute name="disabled">yes</i2:attribute>
      &#xA0;<i18n:text><xsl:value-of select="./@DisplayText"/></i18n:text>&#xA0;
      
    </i2:button>
    </xsl:if-->
    
  </xsl:template>  

  
</xsl:stylesheet> 

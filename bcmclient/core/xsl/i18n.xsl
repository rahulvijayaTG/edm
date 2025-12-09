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
      

  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="i18nize_new">
    <xsl:param name="pData" />
    <xsl:param name="pNoData" />    
    <xsl:param name="pType" select="'Text'"/>
    <xsl:param name="pFormat" select="'common'"/>    
    <xsl:param name="pDecimals" select="'0'"/>                       
    
    <xsl:choose>
      
      <!-- Text --> 
      <xsl:when test="$pType='Text' or $pType='Select'">
        <xsl:choose>
          <xsl:when test="string-length($pData) > 0">
            <i18n:text><xsl:value-of select="$pData"/></i18n:text>
          </xsl:when>
          <xsl:when test="$pNoData = 'NO_DEFAULT'">
          </xsl:when>            
          <xsl:when test="string-length($pNoData) > 0">
            <i18n:text><xsl:value-of select="$pNoData"/></i18n:text>
          </xsl:when>            
          <xsl:otherwise>
            <i18n:text>None</i18n:text>
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:when>
      
      <!-- Currency -->
      <xsl:when test="$pType='Currency'">
        <xsl:choose>
          <xsl:when test="string-length($pData) > 0">
            <i18n:currency><xsl:value-of select="$pData"/></i18n:currency>
          </xsl:when>
          <xsl:when test="$pNoData = 'NO_DEFAULT'">
          </xsl:when>            
          <xsl:otherwise>
            <i18n:text>N/A</i18n:text>                    
<!--             <i18n:currency>0</i18n:currency> -->
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:when>
      
      <!-- Number -->
      <xsl:when test="$pType='Number'">
        <xsl:choose>
          <xsl:when test="string-length($pData) > 0">
            <i18n:number decimals="{$pDecimals}"><xsl:value-of select="$pData"/></i18n:number>
          </xsl:when>
          <xsl:when test="$pNoData = 'NO_DEFAULT'">
          </xsl:when>            
          <xsl:when test="string-length($pNoData) > 0">
            <i18n:text><xsl:value-of select="$pNoData"/></i18n:text>
          </xsl:when>          
          <xsl:otherwise>
            <i18n:text>N/A</i18n:text>          
<!--             <i18n:number decimals="$decimals">0</i18n:number> -->
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      
      <!-- Date -->
      <xsl:when test="$pType='Date'">
        <xsl:choose>
          <xsl:when test="string-length($pData) > 0">
            <i18n:date format="{$pFormat}"><xsl:value-of select="$pData"/></i18n:date>
          </xsl:when>
          <xsl:when test="$pNoData = 'NO_DEFAULT'">
          </xsl:when>            
          <xsl:when test="string-length($pNoData) > 0">
            <i18n:text><xsl:value-of select="$pNoData"/></i18n:text>
          </xsl:when>          
          <xsl:otherwise>
            <i18n:text>None</i18n:text>
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:when>
    </xsl:choose>
  </xsl:template>  

  
 <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="i18nize">
    <xsl:param name="pData" />
    <xsl:param name="pNoData" />    
    <xsl:param name="pType" />
    <xsl:param name="pFormat" />    
    <xsl:param name="pDecimals"/>                       
    
    <xsl:variable name="type">
      <xsl:choose>
        <xsl:when test="$pType">
          <xsl:value-of select="$pType"/>
        </xsl:when>
        <xsl:otherwise>Text</xsl:otherwise>
      </xsl:choose>  
    </xsl:variable>  

     <xsl:variable name="format">
      <xsl:choose>
        <xsl:when test="$pFormat">
          <xsl:value-of select="$pFormat"/>
        </xsl:when>  
        <xsl:otherwise>common</xsl:otherwise>
      </xsl:choose>  
    </xsl:variable>   

    <xsl:variable name="decimals">
      <xsl:choose>
        <xsl:when test="$pDecimals">
          <xsl:value-of select="$pDecimals"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>  
    </xsl:variable>  

    
    <xsl:choose>
      
      <!-- Text --> 
      <xsl:when test="$type='Text' or $type='Select'">
        <xsl:choose>
          <xsl:when test="string-length($pData) > 0">
            <i18n:text><xsl:value-of select="$pData"/></i18n:text>
          </xsl:when>
          <xsl:when test="$pNoData = 'NO_DEFAULT'">
          </xsl:when>            
          <xsl:when test="string-length($pNoData) > 0">
            <i18n:text><xsl:value-of select="$pNoData"/></i18n:text>
          </xsl:when>            
          <xsl:otherwise>
            <i18n:text>None</i18n:text>
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:when>
      
      <!-- Currency -->
      <xsl:when test="$type='Currency'">
        <xsl:choose>
          <xsl:when test="string-length($pData) > 0">
            <i18n:currency><xsl:value-of select="$pData"/></i18n:currency>
          </xsl:when>
          <xsl:when test="$pNoData = 'NO_DEFAULT'">
          </xsl:when>            
          <xsl:otherwise>
            <i18n:text>N/A</i18n:text>                    
<!--             <i18n:currency>0</i18n:currency> -->
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:when>
      
      <!-- Number -->
      <xsl:when test="$type='Number'">
        <xsl:choose>
          <xsl:when test="string-length($pData) > 0">
            <i18n:number decimals="{$decimals}"><xsl:value-of select="$pData"/></i18n:number>
          </xsl:when>
          <xsl:when test="$pNoData = 'NO_DEFAULT'">
          </xsl:when>            
          <xsl:when test="string-length($pNoData) > 0">
            <i18n:text><xsl:value-of select="$pNoData"/></i18n:text>
          </xsl:when>          
          <xsl:otherwise>
            <i18n:text>N/A</i18n:text>          
<!--             <i18n:number decimals="$decimals">0</i18n:number> -->
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      
      <!-- Date -->
      <xsl:when test="$type='Date'">
        <xsl:choose>
          <xsl:when test="string-length($pData) > 0">
            <i18n:date format="{$format}"><xsl:value-of select="$pData"/></i18n:date>
          </xsl:when>
          <xsl:when test="$pNoData = 'NO_DEFAULT'">
          </xsl:when>            
          <xsl:when test="string-length($pNoData) > 0">
            <i18n:text><xsl:value-of select="$pNoData"/></i18n:text>
          </xsl:when>          
          <xsl:otherwise>
            <i18n:text>None</i18n:text>
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:when>
    </xsl:choose>
  </xsl:template>  



</xsl:stylesheet>
<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:output method="html" indent="no"/>
  
  
    <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:variable name="maxRows" select="''"/>
  <xsl:variable name="totalRecordCount" select="''"/>
  <xsl:variable name="startAtRow" select="''"/>

  
  <xsl:variable name="currentPage"><xsl:value-of select="ceiling(($startAtRow+1) div $maxRows)"/></xsl:variable>
  <xsl:variable name="endPage">
  <xsl:choose>
    <xsl:when test="$totalRecordCount = '1000000000000000'"><i18n:text>UnKnown</i18n:text>
    </xsl:when>
    <xsl:otherwise><xsl:value-of select="ceiling($totalRecordCount div $maxRows)"/></xsl:otherwise>
  </xsl:choose>
  </xsl:variable>
    
  <xsl:variable name="pageXOfY"><i18n:text>Page</i18n:text>&#xA0;<xsl:value-of select="$currentPage"/>&#xA0;<i18n:text>of</i18n:text>&#xA0;<xsl:value-of select="$endPage"/> &#xA0;</xsl:variable>

    
  <xsl:template match="PAGINATION">
    
 
    <xsl:variable name="pRecordCount">
      <xsl:choose>
        <xsl:when test="RECORD_COUNT">
          <xsl:value-of select="number(RECORD_COUNT/@Value)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="number($totalRecordCount)"/>
        </xsl:otherwise>
      </xsl:choose>  
    </xsl:variable> 

    <i2:pagingcontrol currentPage="{$currentPage}" recordsPerPage="{$maxRows}" totalRecords="{$pRecordCount}"/>
    
  </xsl:template>
  
</xsl:stylesheet>

<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  
  <!-- Header -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="STEP" mode="header">
    
    <!-- Header/Help -->
    <i2:header>
      <table border="0" cellpadding="2" cellspacing="0" width="100%">
        <tr>
          <td align="right">
            <table border="0" cellpadding="0" cellspacing="0" align="right">
              <tr>
                
                <xsl:choose>
                  <!-- All tabs header --><!-- Not Used?? -->
                  <xsl:when test = "../HEADER/LINK">
                    <xsl:apply-templates select="../HEADER/LINK"/>
                  </xsl:when>
                </xsl:choose>    
                
                <xsl:choose>
                  <!-- Selected tabs help -->
                  <xsl:when test = "HELP">
                    <xsl:apply-templates select="HELP"/>
                  </xsl:when>
                  <!-- All tabs help -->
                  <xsl:when test = "../HELP">
                    <xsl:apply-templates select="../HELP"/>
                  </xsl:when>
                </xsl:choose>    
                
              </tr>
            </table>
          </td>
        </tr>
      </table>
      
    </i2:header>
    
  </xsl:template>  
  

<!-- ********************************************************************** 
     *********************************************************************** -->  
</xsl:stylesheet>

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
  <xsl:template match="_ERROR"  mode="result_level">
    <table cellspacing="8"><tr><td>
    <font color="red"><xsl:value-of select="@Value"/></font>
    </td></tr></table>    
  </xsl:template> 
                  
                
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="_ERRORS" mode="icon_tip">
    <td>
      <table border="0" id="field_validation" cellpadding="0" cellspacing="4px" width="100%" >
        <tr>
          <xsl:for-each select="_ERROR">
            <xsl:variable name="alt">
              <i18n:text><xsl:value-of select="./@Value"/></i18n:text>
            </xsl:variable>  
            <td align="left" valign="middle">
              <i2:img onclick="javascript:omx_alert('{$alt}')" src="/alert_static_small.gif" alt="{$alt}" border="0" align="middle"/>           
            </td>
          </xsl:for-each>
        </tr>
      </table>    
    </td>            
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
</xsl:stylesheet>
<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="pad.xsl"/>
  <xsl:output method="html"/>

  <xsl:template match="/RESPONSES/RESPONSE">
     <table width="100%" height="100%">
       <tr>
         <td width="100%" valign="top" align="center">
           <xsl:apply-templates select="ACTIVITIES/PAD"/>
           <xsl:apply-templates select="TASKS/PAD"/>
           <xsl:apply-templates select="TOOLS/PAD"/>
           <xsl:apply-templates select="FAVORITES/PAD"/>
         </td>
       </tr>
     </table>
  </xsl:template>
    
</xsl:stylesheet>
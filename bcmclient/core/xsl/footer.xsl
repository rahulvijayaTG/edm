<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="buttons.xsl"/>
  <xsl:import href="pagination.xsl"/>

  <xsl:output method="html"/>
  
  <!-- Footer -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="CONTAINER | STEP" mode="footer">
    
    <xsl:if test="count(BUTTONS/*) > 0 ">
      
      <i2:footer>
        <table cellspacing="0" cellpadding="0" width="100%"  border="0">
            <tr>	
              <td>  
                <xsl:apply-templates select="BUTTONS"/>
              </td>
            </tr>
        </table>
      </i2:footer>
    </xsl:if>
  </xsl:template>

  
  <!-- ********************************************************************** 
  *********************************************************************** -->      
</xsl:stylesheet>

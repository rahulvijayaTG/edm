<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:output method="html"/>

<xsl:template match="TEMPLATE">
  
  <xsl:variable name="template_header">
  	<i18n:text>Upload File Parameters</i18n:text>
  </xsl:variable>      
	
  <!-- Template Property Details -->
  <table width="100%" border="0" cellspacing="0">
      <tr>	
        <td  width="100%" height="100%" valign="top">
          <i2:container title="{$template_header}">
            <table width="100%" class="tableRow1" border="0">
              <tr>
			  <td>
			  	<i2:table>
					<i2:tr header="yes">
						<td align="center"> <i18n:text>Field Name</i18n:text></td>
					</i2:tr>
					<xsl:for-each select="PROPERTY">
						<i2:tr>
							<td><xsl:value-of select="@Name"/></td>
						</i2:tr>
					</xsl:for-each>							
                </i2:table>
			   </td>
			   </tr>
            </table>
          </i2:container>
        </td>
      </tr>
    </table>
</xsl:template>

</xsl:stylesheet>

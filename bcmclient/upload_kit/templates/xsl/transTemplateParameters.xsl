<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:output method="html"/>

<xsl:template match="/">
  
  <xsl:variable name="template_header">
  	<i18n:text>Upload File Format</i18n:text>
  </xsl:variable>  
  <xsl:variable name="lt">
    	<i18n:text>&lt;</i18n:text>
  </xsl:variable>
	
  <!-- Template Property Details -->
  <table width="100%" border="0" cellspacing="0">
      <tr>	
        <td  width="100%" height="100%" valign="top">
          <i2:container title="{$template_header}">
            <i2:header>
            <table border="0" cellpadding="2" cellspacing="0" width="100%">
            <tr>
              <td align="right">
				      <a href="javascript:popUpWindow('../../help/uploadfileformat.html','popUp4')">
                <xsl:variable name="txtAltAttr"><i18n:text>Help</i18n:text></xsl:variable>
                <img src="/i2/images/help_avail.gif" alt="{$txtAltAttr}" border="0"/>
              </a>
              </td>
            </tr>
          </table>
          </i2:header>
          <table width="100%" border="0">
          <tr>
			    <td>
			  	<i2:table>
					<i2:tr header="yes">
					  <td align="left"><i18n:text>File Format</i18n:text></td>
					</i2:tr>
					<i2:tr>
					  <td>
              <i18n:text>The uploaded xml data should be enclosed in a DATAUPLOAD tag like shown below</i18n:text>.
              <br/>
              <i>&lt;DATAUPLOAD&gt;<i18n:text>Put your actual xml here.</i18n:text>&lt;/DATAUPLOAD&gt;</i>
					   </td>
					</i2:tr>
												
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

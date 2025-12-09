<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:output method="html"/>
  
  <xsl:template match="/RESPONSES/RESPONSE">
    <html>
      <head>
      	<title><i18n:text>DOM Error Page</i18n:text></title>
        <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
      	<i2:stylesheet path="/i2uipad.css"></i2:stylesheet>
      	<i2:javascript path="/global_javascript.js"></i2:javascript>
      	<i2:dhtml padsupport="yes"></i2:dhtml>
      </head>
      
      <xsl:variable name="container_title">
        <i18n:text>Unable to process your request</i18n:text>
      </xsl:variable>
  
      <body class="contentFrameBody" onFocus="checkForPopUps()">
        <table width="50%" cellspaing="2" cellpadding="2">
          <tr>
            <td>
              <i2:container title="{$container_title}">
                <table width="100%" cellspaing="5" cellpadding="5" class="containerBodyUneditable">
                  <tr>
                    <td>
                      <i18n:text>Unable to process your request due to one of the following reason(s)</i18n:text>:<br/><br/>
                      &#xA0;&#xA0;-&#xA0;<i18n:text><xsl:value-of select="MSG/@Value"/></i18n:text><br/><br/>
                      <i18n:text>Please contact your system administrator for further assistance.</i18n:text>
                    </td>
                  </tr>
                </table>
                <i2:footer>
                  <i2:buttonbar>
                    <i2:button onclick="javascript:history.back();">&#xA0;<i18n:text>Back</i18n:text>&#xA0;</i2:button>
                  </i2:buttonbar>
                </i2:footer>
              </i2:container>
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
  
</xsl:stylesheet>
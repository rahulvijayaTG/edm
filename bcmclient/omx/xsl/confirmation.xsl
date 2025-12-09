<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">
  
  <xsl:output method="html"/> 
  <xsl:template match="/RESPONSES/RESPONSE/REQUEST_PARAMETERS">
   
      <xsl:variable name="title"><i18n:text><xsl:value-of select="TITLE/@Value"/></i18n:text></xsl:variable>
      <i2:container title="{$title}" width="50%">
        <table class="tableRow1" border="0" cellpadding="0" cellspacing="15" width="100%">
          <tr>
            <td>
              <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                  <td>
                    <i18n:text><xsl:value-of select="MESSAGE/@Value"/></i18n:text>
                  </td>
                </tr>
                <tr>
                  <td height="3px">&#xA0;</td>
                </tr>
                <tr>
                  <td>
                    <i18n:text><xsl:value-of select="DOC_TYPE/@Value"/>ID's are</i18n:text><xsl:text>:</xsl:text>
                  </td>
                </tr>
                <xsl:for-each select="ID">
                  <xsl:variable name="id"><xsl:value-of select="substring-before(@Value,'///')"/></xsl:variable>
                  <xsl:variable name="link"><xsl:value-of select="substring-after(@Value,'///')"/></xsl:variable>
                  <tr>
                    <td height="3px">&#xA0;</td>
                  </tr>
                  <tr>
                    <td>
                      <xsl:choose>
                        <xsl:when test="$link != ''">
                          <b><a target="appFrame" href="{$link}"><xsl:value-of select="$id"/></a></b>
                        </xsl:when>
                        <xsl:otherwise>
                          <b><xsl:value-of select="$id"/></b>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                </xsl:for-each>
              </table>
            </td>
          </tr>
        </table>
        
        <i2:footer>
          <i2:buttonbar>
            <i2:button emphasized="yes" onclick="javascript:parent.location='./home.jsp'">&#xA0;<i18n:text>OK</i18n:text>&#xA0;</i2:button>
          </i2:buttonbar>
        </i2:footer>
      </i2:container>

  </xsl:template>
</xsl:stylesheet>

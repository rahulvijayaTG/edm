<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:output method="html"/>
  
  <xsl:template match="RESPONSES/RESPONSE/HEADER">
    
    <script language="Javascript">
    function onRefresh()
    {
      javascript:parent.history.go(0);
    }
    function onPrint()
    {
     javascript:parent.content.focus();window.print()
    }
    </script>

    <form name="header">
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <!-- Toggle -->
          <td nowrap="yes" align="left">
            <a href="javascript:togglenav('{TOGGLE_NAV/@Value}')"><i2:img id="toggle" alt="Hide Navigation Frame" src="/collapse.gif" border="0"/></a>
          </td>

          <!-- Dom -->
          <td nowrap="yes">
            &#xA0;
            <a href="javascript:goHomeWithFrames('{HOME/@Value}')">
              <font color="#5060B8"><b><i18n:text><xsl:value-of select="APP_NAME/@Value"/></i18n:text>:</b></font>
            </a>&#xA0;
            
            <!-- Bread Crumbs - Start:: -->
            <xsl:choose>
              <xsl:when test="HEADING_LINK">
                <a href="{HEADING_LINK/@Value}" target="appFrame">
                  <font color="#5060B8">
                    <xsl:choose>
                      <xsl:when test="HEADING2">
                        <i18n:text><xsl:value-of select="HEADING/@Value"/></i18n:text>
                      </xsl:when>
                      <xsl:otherwise>
                        <b><i18n:text><xsl:value-of select="HEADING/@Value"/></i18n:text></b>
                      </xsl:otherwise>
                    </xsl:choose>
                  </font>
            		</a>
              </xsl:when>
              <xsl:otherwise>
                <font color="#5060B8"><b><i18n:text><xsl:value-of select="HEADING/@Value"/></i18n:text></b></font>
              </xsl:otherwise>
            </xsl:choose>
            
            <!-- Heading 2 -->
            <xsl:if test="HEADING2">
              &#xA0;<font color="#5060B8">&gt;</font>&#xA0;
              <xsl:choose>
                <xsl:when test="HEADING2_LINK">
                  <a href="{HEADING2_LINK/@Value}" target="appFrame">
                    <font color="#5060B8">
                      <xsl:choose>
                        <xsl:when test="HEADING3">
                          <i18n:text><xsl:value-of select="HEADING2/@Value"/></i18n:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <b><i18n:text><xsl:value-of select="HEADING2/@Value"/></i18n:text></b>
                        </xsl:otherwise>
                      </xsl:choose>
                    </font>
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <font color="#5060B8"><b><i18n:text><xsl:value-of select="HEADING2/@Value"/></i18n:text></b></font>
                </xsl:otherwise>
              </xsl:choose>    
            </xsl:if>
            
            <!-- Heading 3 -->
            <xsl:if test="HEADING3">
              &#xA0;<font color="#5060B8">&gt;</font>&#xA0;
              <xsl:choose>
                <xsl:when test="HEADING3_LINK">
                  <a href="{HEADING3_LINK/@Value}" target="appFrame">
                    <font color="#5060B8"><b><i18n:text><xsl:value-of select="HEADING3/@Value"/></i18n:text></b></font>
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <font color="#5060B8"><b><i18n:text><xsl:value-of select="HEADING3/@Value"/></i18n:text></b></font>
                </xsl:otherwise>
              </xsl:choose>    
            </xsl:if>
            
            <!-- Heading 4 -->
            <xsl:if test="HEADING4">
              <b>:</b>&#xA0;
              <xsl:choose>
                <xsl:when test="HEADING4_LINK">
                  <a href="{HEADING4_LINK/@Value}" target="appFrame">
                    <font color="#5060B8"><b><i18n:text><xsl:value-of select="HEADING4/@Value"/></i18n:text></b></font>
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <font color="#5060B8"><b><i18n:text><xsl:value-of select="HEADING4/@Value"/></i18n:text></b></font>
                </xsl:otherwise>
              </xsl:choose>    
            </xsl:if>  
            
          </td>
          
          <!-- Bread Crumbs - End. -->


         <!-- Links - Start::-->
          
          <td width="100%" nowrap="yes" align="right">

           <!-- Custom -->
           <xsl:for-each select="LINKS/LINK">
             <a href="{URL/@Value}">
               <i2:img src="{IMG_PATH/@Value}" border="0">
                 <i2:attribute name="alt"><i18n:text><xsl:value-of select="DISPLAY_TEXT/@Value"/></i18n:text></i2:attribute>
	             </i2:img>
            </a>&#xA0;
          </xsl:for-each>

          <!-- Refresh -->
          <i2:img onclick = "javascript:onRefresh();" src="/rfrsh_actv.gif" border="0" >
            <i2:attribute name="alt"><i18n:text>Refresh</i18n:text></i2:attribute>
          </i2:img>
          &#xA0;
            
          <!-- Print -->
          <i2:img onclick="javascript:onPrint();" src="/prnt_avail.gif" border="0">
            <i2:attribute name="alt"><i18n:text>Print</i18n:text></i2:attribute>
          </i2:img>&#xA0;
          </td>
          <td>&#xA0;</td>
          
          <!-- Links - End. -->
        </tr>
      </table>
    </form>
  </xsl:template>
  
</xsl:stylesheet>

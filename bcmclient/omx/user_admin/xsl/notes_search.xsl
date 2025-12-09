<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:template name="NOTES_SEARCH">  
    
    <i2:container title="" inner="yes">
      <table border="0" cellpadding="5" cellspacing="0"  > 
        
        <input name="SORT_BY" type="hidden" value=""/> 
        
        <tr>
          <td><i18n:text>Enter Keywords</i18n:text><xsl:text>:</xsl:text></td>
          <td><input name="KEYWORDS" value="{/RESPONSES/RESPONSE/KEYWORDS/@Value}" type="field" class="inputfieldIE" size="17"/></td>
          
          <td> <i18n:text>Search By</i18n:text><xsl:text>:</xsl:text></td>
          <td>
            <select name="SEARCH_BY" class="pulldown">
              <xsl:for-each select="RESPONSE/SEARCH_TYPE">
                <option value="{@Value}">
                  <xsl:if test=" /RESPONSES/RESPONSE/SEARCH_BY/@Value = ./@Value ">
                    <xsl:attribute name="selected">true</xsl:attribute>
                  </xsl:if>
                  <xsl:value-of select="@Description"/>
                </option>
              </xsl:for-each>
            </select>
          </td>
          
          
        </tr>
      </table>
      <i2:footer>
        <i2:buttonbar>
            <xsl:call-template name="mdmButton">
                <xsl:with-param name="onclick" select="'javascript:notesSearchForm.submit();'"/>
                <xsl:with-param name="text" select="'Search'"/>
            </xsl:call-template>
        
          <!--i2:button onclick="javascript:notesSearchForm.submit()">
            &#xA0;<i18n:text>Search</i18n:text>&#xA0;
          </i2:button-->    
        </i2:buttonbar>
      </i2:footer> 
    </i2:container>
    
    
  </xsl:template>  
  
</xsl:stylesheet>



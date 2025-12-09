<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
<!--                 
  <BUTTONS>
        <BUTTON
                  Id="unkit_button"
                  Name="unkit"
                  DisplayText="Remove From Kit"
                  OnClick="javascript:onUnKit()"
                  Emphasized="false"
                  Disabled="false"
                  DisableOnClick="true"
                  />

                <DIVIDER/>

                <BUTTON
                  Id="kit_button"
                  Name="kit"
                  DisplayText="Add To Kit"
                  OnClick="javascript:onKit()"
                  />
</BUTTONS>                  
 -->
                
  <!-- ButtonBar -->  
  <xsl:template match="BUTTONS">
    <script>
      function disableButton(id)
      {
        javascript:i2uiToggleItemVisibility( id, 'hide');javascript:i2uiToggleItemVisibility(id + '_disabled', 'show');
      }
      function enableButton(id)
      {
        javascript:i2uiToggleItemVisibility( id, 'show');javascript:i2uiToggleItemVisibility(id + '_disabled', 'hide');
      }
    </script>

    <i2:buttonbar>
      <xsl:apply-templates/>
    </i2:buttonbar>
  </xsl:template>
  

  <!-- Button -->
  <xsl:template match="BUTTON">
    <i2:button id="{./@Id}" name="{./@Name}"  emphasized="{./@Emphasized}" target="{./@Target}">
      <i2:attribute name="onclick">
        <xsl:value-of select="./@OnClick"/>      
      </i2:attribute>

      <!-- Disabled Attribute -->            
      <xsl:choose>
        <!-- If the button is to be disabled depending on records -->
        <xsl:when test="./@Disabled = 'report'">
          <xsl:if test="ancestor::TABLE/@NoOfRows = 0 ">
            <i2:attribute name="disabled">yes</i2:attribute>
          </xsl:if>
        </xsl:when>
        <!-- otherwise -->
        <xsl:otherwise>
          <i2:attribute name="disabled"><xsl:value-of select="./@Disabled"/></i2:attribute>
        </xsl:otherwise>
      </xsl:choose> 

      <!-- Display Text -->      
      &#xA0;<i18n:text><xsl:value-of select="./@DisplayText"/></i18n:text>&#xA0;
      
    </i2:button>
    
    <xsl:if test="@Id and  @DisableOnClick = 'true' and (not(@Disabled) or @Disabled !='yes')">
    <i2:button hidden="yes" id="{./@Id}_disabled" name="{./@Name}" onclick="{./@OnClick}" emphasized="{./@Emphasized}" target="{./@Target}">
     <i2:attribute name="disabled">yes</i2:attribute>
      <!-- Display Text -->      
      &#xA0;<i18n:text><xsl:value-of select="./@DisplayText"/></i18n:text>&#xA0;
      
    </i2:button>
    </xsl:if>
    

    
  </xsl:template>  

  <!-- Divider -->  
  <xsl:template match="DIVIDER">
    <i2:buttonbardivider/>
  </xsl:template>
  
  
</xsl:stylesheet> 

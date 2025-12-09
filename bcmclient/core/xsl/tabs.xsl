<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="links.xsl"/>      
  
  <xsl:variable name="tabsmaxlen">30</xsl:variable>  

  
  <!-- ********************************************************************** 
     *********************************************************************** -->  
  <xsl:template match="CONTAINER">
    <xsl:param name="content" select="/RESPONSES"/>
    
        
    <xsl:choose>
      <!-- Container -->
      <xsl:when test="(@Hide = 'true')  or (count(STEP) = 1 and( string-length(@Force) = 0  or @Force !='true'))">
        <xsl:apply-templates select="." mode="container">
          <xsl:with-param name="content" select="$content"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- tabs -->
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="tabs">
          <xsl:with-param name="content" select="$content"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  

  <!-- Tabs -->
  <!-- ********************************************************************** 
     *********************************************************************** -->
  <xsl:template match="CONTAINER" mode="tabs">
    <xsl:param name="content" select="/RESPONSES"/>

     <xsl:call-template name="include_javascript_links"/>

    <!-- Scrollable -->
    <xsl:variable name="scrollable">
      <xsl:choose>
        <xsl:when test="string-length(@Scrollable)">
          <xsl:value-of select="@Scrollable"/>
        </xsl:when>
        <xsl:otherwise>yes</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <!-- TabbedContainer -->
    <i2:tabbedcontainer  id="container" scrollable="{$scrollable}">
      
      <!-- Tabs -->
      <i2:tabset id="tabs_container" field="grey">
        <xsl:apply-templates select="STEP" mode="tabs"/>
      </i2:tabset>

      <!-- Header -->      
      <xsl:apply-templates select="STEP[@Selected = 'true' or @Selected = 'yes']" mode="header"/>
      
      <!-- Content -->
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <xsl:if test="STEP[(@Selected = 'true' or @Selected = 'yes') and ( @Editable='false' or @Editable = 'no')] ">
          <xsl:attribute name="class">tableRow1</xsl:attribute>
        </xsl:if>
        <tr>         
          <td valign="top" nowrap="yes" colspan="2">
            <xsl:apply-templates select="$content" mode="container_content"/>  
          </td>
        </tr>
      </table>
      
      <!--  Footer -->
      <xsl:apply-templates select="STEP[@Selected = 'true' or @Selected = 'yes']" mode="footer"/>
      
    </i2:tabbedcontainer>
    
  </xsl:template>

  <!-- Tab --> 
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="STEP" mode="tabs">
  
      <xsl:variable name="text">
        <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>      
      </xsl:variable>

      <xsl:variable name="truncatedText">      
        <xsl:choose>
          <xsl:when test="string-length($text) > $tabsmaxlen">
            <xsl:value-of select="concat(substring($text,0,$tabsmaxlen -3), '...')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$text"/>
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:variable>


    <i2:tab alttext="{@AltText}" onclick="{@OnClick}" selected="{@Selected}" target="{$target}" hotkey="@HotKey">
      <xsl:value-of select="$truncatedText"/>
    </i2:tab>
  </xsl:template>
  

    
  
  
  <!-- Javascript -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="javascript_resizeTabs">  
    i2uiResizeScrollableContainer('container',document.body.offsetHeight - 90, null, document.body.offsetWidth - 20, true, 'yes');
    i2uiResizeScrollableContainer('tabs_container_description',document.body.offsetHeight -105, null, document.body.offsetWidth - 20, true, 'yes');
  </xsl:template>
  

  <!-- Target -->  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:variable name="target">
    <xsl:choose>
      <xsl:when test="string-length(/RESPONSES/RESPONSE/CONTAINER/@Target) > 0"><xsl:value-of select="/RESPONSES/RESPONSE/CONTAINER/@Target"/></xsl:when>
      <xsl:otherwise>appFrame</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

<!-- ********************************************************************** 
     *********************************************************************** -->  
</xsl:stylesheet>
 

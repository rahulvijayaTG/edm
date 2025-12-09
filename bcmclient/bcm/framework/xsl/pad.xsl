<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  <xsl:import href="folder.xsl"/>
<!--
  <xsl:import href="buttons.xsl"/>
-->
  <xsl:output method="html"/>

  <xsl:variable name="quote">'</xsl:variable>  
  <xsl:variable name="maxlenForToolTip">23</xsl:variable>
  
  <xsl:template match="PAD">
    <xsl:variable name="title"><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text></xsl:variable>

    <!-- NavArea -->
    <i2:navarea height="100%">

      <!-- Pad -->
      <i2:pad title="{$title}">

        <!-- Name -->        
        <xsl:if test="string-length(@Name) > 0">
          <i2:attribute name="name"><xsl:value-of  select="@Name"/></i2:attribute>
        </xsl:if>
        <i2:attribute name="tooltip"><xsl:value-of select="''"/></i2:attribute>
        <!-- Scrollable -->
        <xsl:if test="string-length(@Scrollable) > 0">
          <i2:attribute name="scrollable" ><xsl:value-of select="@Scrollable"/></i2:attribute>
        </xsl:if>
        
        <!-- Type -->
        <xsl:if test="string-length(@Type) > 0">
          <i2:attribute name="type"><xsl:value-of select="@Type"/></i2:attribute>
        </xsl:if>
	<xsl:if test="@Name='favorites'">
          <i2:header>
            <a class="text" href="javascript:onManageFavorites();">
              <xsl:variable name="txtManageFav"><i18n:text>Manage Favorites</i18n:text></xsl:variable>
              <i2:img src="/editfav.gif" alt="{$txtManageFav}" border="0" align="middle"/>
            </a>
          </i2:header>
        </xsl:if>

        <!-- ComboItem/Children -->
        <xsl:if test="count(COMBO_ITEM) &gt; 0">
          <select id="combo_instanceID" name="combo_instanceID">
            <xsl:apply-templates select="COMBO_ITEM"/>
          </select>
          <a href="javascript:onSelectInstance()">&#xA0;<i2:img src="/btn_go.gif" border="0"/>&#xA0;</a>
<!--
          <table id="table1">
            <tr>
              <td>
                <select id="combo_instanceID" name="combo_instanceID">
                  <xsl:apply-templates select="COMBO_ITEM"/>
                </select>
              </td>
              <td>
                <i2:button id="Go" name="Go">
                  <i2:attribute name="onclick">javascript:onSelectInstance();</i2:attribute>
                  &#xA0;<i18n:text>Go</i18n:text>&#xA0;
                </i2:button>
              </td>
            </tr>
          </table>
-->
        </xsl:if>
      

        <!-- PadItem/Children -->
        <xsl:if test="count(PAD_ITEM) &gt; 0">
          <xsl:apply-templates select="PAD_ITEM"/>
        </xsl:if>
      
       <!-- this code may be used for pad/pad items level -->
        <!--xsl:apply-templates select="PAD_ITEM">
          <xsl:with-param name="service" select="SERVICE/@Name"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="SERVICE/ALL_FOLDERS/FOLDER">
          <xsl:with-param name="service" select="$service"/>
        </xsl:apply-templates-->
        
  <xsl:apply-templates select="Folder|Favorite"/> 
      </i2:pad>
      
    </i2:navarea>
    
  </xsl:template>        
  
  <xsl:template match="PAD_ITEM">
     <!-- onclick -->
    <xsl:variable name="onclick">
      <xsl:choose>
        <xsl:when test="@Popup = 'true'">  
            <xsl:value-of select="concat('javascript:popUpWindow(',$quote, @OnClick, $quote,  ',', $quote, @PopupId, $quote, ');')"/>
         </xsl:when>
          <xsl:when test="@Other = 'true'">
	               <xsl:value-of select="concat('javascript:solutionLink(',$quote, @OnClick, $quote,');')"/>
	  </xsl:when>
        <xsl:otherwise>
           <xsl:value-of select="@OnClick"/>
        </xsl:otherwise>
         
      </xsl:choose>
    </xsl:variable>
    
    <!-- target -->
    <xsl:variable name="target">
      <xsl:choose>
        <xsl:when test="@Popup = 'true'">  
        </xsl:when>
        <xsl:when test="string-length(@Target) > 0">  
          <xsl:value-of select="@Target"/>
        </xsl:when>
        <xsl:when test="@Other = 'true'">
	  <xsl:value-of select="''"/>
        </xsl:when>
        <xsl:otherwise>appFrame</xsl:otherwise>  
      </xsl:choose>
    </xsl:variable>
    
    <!-- PadItem -->
    <i2:paditem>

      <!-- Text -->
      <xsl:variable name="text">
        <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>      
      </xsl:variable>

      <i2:attribute name="text"><xsl:value-of select="$text"/></i2:attribute>

      <!-- selected -->
      <xsl:if test="string-length(@Selected) > 0">
        <i2:attribute name="selected"><xsl:value-of select="@Selected"/></i2:attribute>
      </xsl:if>
      
      <!-- target -->
      <xsl:if test="string-length($target) > 0">
        <i2:attribute name="target"><xsl:value-of select="$target"/></i2:attribute>
      </xsl:if>
      
      <!-- Onclick -->
      <xsl:if test="string-length($onclick) > 0">
        <i2:attribute name="onclick"><xsl:value-of select="$onclick"/></i2:attribute>
      </xsl:if>

      <!-- Tooltip -->
<!--       <xsl:if test="contains($text,'...')"> -->
      <!--xsl:if test="string-length($text) > $maxlenForToolTip">
        <i2:attribute name="tooltip"><xsl:value-of select="$text"/></i2:attribute>
      </xsl:if-->
      
      <!-- Children -->
      
        <xsl:if test="count(PAD_ITEM) &gt; 0">
          <xsl:apply-templates select="PAD_ITEM"/>
        </xsl:if>
        
        <xsl:apply-templates select="SERVICE/ALL_FOLDERS/FOLDER">
          <xsl:with-param name="service" select="SERVICE/@Name"/>
        </xsl:apply-templates>
      
      
    </i2:paditem>
    
  </xsl:template>
  <!-- *********************************************************************
        ********************************************************************* -->
  <xsl:template match="COMBO_ITEM">
    <option id="{@DisplayText}" value="{@DisplayText}">
      <xsl:if test="@Selected = 'true' ">
        <xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
    </option>
  </xsl:template>
  <!-- *********************************************************************
        ********************************************************************* -->
   
   <xsl:template match="Folder|Favorite">
    <i2:paditem>
      <xsl:variable name="text">
          <i18n:text><xsl:value-of select="@Name"/></i18n:text>
      </xsl:variable>

      <i2:attribute name="text"><xsl:value-of select="$text"/></i2:attribute>
      <xsl:if test="@IsFolder='no'">
        <i2:attribute name="onclick"><xsl:value-of select="@URL"/></i2:attribute>
      </xsl:if>
      <i2:attribute name="target">appFrame</i2:attribute>
      <!-- Onclick -->
      <!--xsl:if test="string-length($onclick) > 0">
        <i2:attribute name="onclick"><xsl:value-of select="$onclick"/></i2:attribute>
      </xsl:if-->
      
        <xsl:apply-templates select="Folder|Favorite"/>
     </i2:paditem>
    
    </xsl:template>

</xsl:stylesheet>

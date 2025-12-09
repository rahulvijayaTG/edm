<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  
<!--  
  <LINK 
        Name="ORDER_VERSIONS"  
        OnClick="{$onclick}" 
        PopupName="popUp2" 
        DisplayText="Order Version" 
        Type="popup">
      <IMAGE Src="/multiple_revisions.gif"/>
  </LINK>
-->

    
   <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:variable name="returnUrl"><xsl:value-of select="/RESPONSES/RESPONSE/LINKS/LINK[@Name='Return']/@EncodedValue"/></xsl:variable>
  <xsl:variable name="returnUrl2"><xsl:value-of select="/RESPONSES/RESPONSE/LINKS/LINK[@Name='Return']/@TwiceEncodedValue"/></xsl:variable>
  <xsl:variable name="returnUrl3"><xsl:value-of select="/RESPONSES/RESPONSE/LINKS/LINK[@Name='Return']/@ThriceEncodedValue"/></xsl:variable>
  <xsl:variable name="returnUrl_unEncoded"><xsl:value-of select="/RESPONSES/RESPONSE/LINKS/LINK[@Name='Return']/@Value"/></xsl:variable>

  <xsl:variable name="currentUrl"><xsl:value-of select="/RESPONSES/RESPONSE/LINKS/LINK[@Name='Current']/@EncodedValue"/></xsl:variable>
  <xsl:variable name="previousUrl"><xsl:value-of select="$currentUrl"/></xsl:variable>
  <xsl:variable name="currentUrl_unEncoded"><xsl:value-of select="/RESPONSES/RESPONSE/LINKS/LINK[@Name='Current']/@Value"/></xsl:variable>


  
  <xsl:variable name="totalRecordCount" select="''"/>
  <xsl:variable name="startAtRow" select="''"/>
  <xsl:variable name="returnRowCount" select="''"/>


    <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="include_javascript_links">
    <script>
        <xsl:if test="string-length($returnUrl_unEncoded) > 0">
        returnUrl = '<xsl:value-of select="$returnUrl_unEncoded"/>';
        </xsl:if>
        function onReturn()
        {
          <xsl:choose>
          <xsl:when test="string-length($returnUrl_unEncoded) = 0">onBack();</xsl:when>
          <xsl:when test="$returnUrl_unEncoded= 'javascript:back();'">onBack();</xsl:when>
          <xsl:otherwise>javascript:document.location.href= returnUrl;void(0);</xsl:otherwise>
        </xsl:choose>
        }
    </script>        
  </xsl:template>

  
      
<!-- ********************************************************************** 
     *********************************************************************** -->
  <xsl:template match="LINK">
    <td>
      <xsl:apply-templates select="." mode="content"/>      
    </td>
    <td>&#xA0;</td>
    
  </xsl:template>

  
  <!-- ********************************************************************** 
     *********************************************************************** -->
  <xsl:template match="LINK" mode="content">
      <xsl:variable name="title"><i18n:text><xsl:value-of select="@DisplayText"/></i18n:text></xsl:variable>
      
      <xsl:variable name="onclick">
        <xsl:choose>
          <xsl:when test="@Type = 'popup'">
            javascript:popUpWindow('<xsl:value-of select="@OnClick"/>','<xsl:value-of select="@PopupName"/>')
          </xsl:when>
          <xsl:when test="starts-with(@OnClick,'javascript')">
            <xsl:value-of select="@OnClick"/>
          </xsl:when>
          <xsl:otherwise>
            javascript:parent.document.location = '<xsl:value-of select="@OnClick"/>&amp;RET_PAGE=<xsl:value-of select="$currentUrl"/>'
          </xsl:otherwise>
        </xsl:choose>
     </xsl:variable>
      
      <xsl:if test="IMAGE/@Src">
        <a class="text" href="javascript:onLink();">
          <xsl:if test="string-length(@OnClick) > 0">
            <xsl:attribute name="onclick">
              <xsl:value-of select="$onclick"/>
            </xsl:attribute>
          </xsl:if>  
          <i2:img src="/{IMAGE/@Src}" width="16" height="16" border="0">
          <i2:attribute name="alt">
            <i18n:text><xsl:value-of select="$title"/></i18n:text>
          </i2:attribute>
        </i2:img>
       </a>
      </xsl:if>
      
  </xsl:template>

<!-- ********************************************************************** 
     *********************************************************************** -->  
  <!-- Help -->
  <xsl:template match="HELP">
    <td>
    <a class="text" href="javascript:onHelp();">
      <xsl:attribute name="onClick">javascript:popUpWindow( '<xsl:value-of select="@Url"/>', 'popUp4')</xsl:attribute>
      <xsl:variable name="txtAltAttr"><i18n:text>Help</i18n:text></xsl:variable>
      <i2:img src="/help_avail.gif" alt="{$txtAltAttr}" border="0" align="middle"/>
    </a>
  </td>
  </xsl:template>

<!-- ********************************************************************** 
     *********************************************************************** -->  
</xsl:stylesheet> 


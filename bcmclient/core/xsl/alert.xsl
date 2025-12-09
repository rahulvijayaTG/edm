<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:output method="html"/>

  <!-- Root Enty Point -->  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="/">
    <html>
      <head>
        <title><i18n:text>Message</i18n:text></title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
        <i2:stylesheet path="/omx_core.css"></i2:stylesheet>
        <i2:stylesheet path="/i2uipad.css"></i2:stylesheet>
        <i2:javascript path="/global_javascript.js"></i2:javascript>
        <i2:dhtml padsupport="yes"></i2:dhtml>
          </head>
      
      <!-- Body -->
      <xsl:apply-templates select="/" mode="body"/>
      
    </html>
    
  </xsl:template>
  
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="/" mode="body">
    
    <!-- Body -->
    <body scroll="auto" class="messageBoxBackground" >
      
    <!-- content-->
    <xsl:apply-templates select="RESPONSES/RESPONSE" mode="content"/>
      
    </body>
    
  </xsl:template>
  
    
  <!-- Page.xsl -->
  <!-- ********************************************************************** 
  *********************************************************************** -->      
  <xsl:template match="RESPONSE" mode="content">
  

    <table class="messageBoxBackground" width="100%" height="100%">
      <tr  height="100%">
      
      <xsl:variable name="img">
          <xsl:choose>
            <xsl:when test="REQUEST_PARAMETERS/TYPE/@Value = 'success'">
              <xsl:value-of select="'/alert_green_static.gif'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'/alert_static.gif'"/>
            </xsl:otherwise>
          </xsl:choose>
          </xsl:variable>
          
        <td  style="padding:8px 16px">
          <i2:img src="{$img}" border="0"/>
        </td>
        
          <xsl:apply-templates select="REQUEST_PARAMETERS/MESSAGE">
            <xsl:with-param name="arg0" select="REQUEST_PARAMETERS/ARG0/@Value"/>
            <xsl:with-param name="arg1" select="REQUEST_PARAMETERS/ARG1/@Value"/>
            <xsl:with-param name="arg2" select="REQUEST_PARAMETERS/ARG2/@Value"/>
            <xsl:with-param name="arg3" select="REQUEST_PARAMETERS/ARG3/@Value"/>
            <xsl:with-param name="arg4" select="REQUEST_PARAMETERS/ARG4/@Value"/>
          </xsl:apply-templates>
      </tr>
      <tr>
        <td colspan="2" style="padding:4px">
          
          <table cellpadding="4">
            <tr>
              <td width="100%">&#160;</td>
              
              <xsl:if test="BUTTONS/BUTTON[@Id = 'cancel_button']">
              <!-- Cancel -->
              <td>
                <div style="border:1px solid #505050">
                  <button 
                          id="buttonRegular" 
                          onclick="javascript:i2uiCloseMessageBox('cancel')">
                    &#160;<i18n:text>Cancel</i18n:text>&#160;
                  </button>
                </div>
              </td>
              </xsl:if>
              <!--         if (interaction.indexOf("NO") != -1) 
              {
            <TD nowrap=\"yes\">
            <IMG src=\""+settings.getImageDirectory()+"/blue_divider.gif\">
            </TD>
              -->        <!-- No -->
              <xsl:if test="BUTTONS/BUTTON[@Id = 'no_button']">

              <td>
                <div style="border:1px solid #505050">
                  <button 
                          id="buttonRegular" 
                          onclick="javascript:i2uiCloseMessageBox('no')">
                    &#160;<i18n:text>No</i18n:text>&#160;
                  </button>
                </div>
              </td>
              </xsl:if>

              <xsl:if test="BUTTONS/BUTTON[@Id = 'yes_button']">

              <!-- yes -->
              <td>
                <div style="border:1px solid #505050">
                  <button 
                          id="buttonRegular" 
                          onclick="javascript:i2uiCloseMessageBox('yes')">
                    &#160;<i18n:text>Yes</i18n:text>&#160;
                  </button>
                </div>
              </td>
                            </xsl:if>

              <xsl:if test="BUTTONS/BUTTON[@Id = 'ok_button']">

              <td>
                <div style="border:1px solid #505050">
                  <button 
                          id="buttonRegular" 
                          onclick="javascript:i2uiCloseMessageBox('ok')">
                    &#160;<i18n:text>Ok</i18n:text>&#160;
                  </button>
                </div>
              </td>
            </xsl:if>

            </tr>
          </table>
          
        </td>
      </tr>
    </table> 
  </xsl:template>  
  

<!-- ********************************************************************** 
     *********************************************************************** -->  
  <xsl:template match="MESSAGE">
    <xsl:param name="arg0" select="''"/>
    <xsl:param name="arg1" select="''"/>
    <xsl:param name="arg2" select="''"/>
    <xsl:param name="arg3" select="''"/>
    <xsl:param name="arg4" select="''"/>
        
    <td width="100%"  style="padding:8px 8px 8px 0px">
      <i18n:text arg0="{$arg0}" arg1="{$arg1}" arg2="{$arg2}" arg3="{$arg3}" arg4="{$arg4}"><xsl:value-of select="./@Value"/></i18n:text>
    </td>
  </xsl:template>

  
  
</xsl:stylesheet>

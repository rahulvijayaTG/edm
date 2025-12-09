<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:output method="html"/>
<!-- ********************************************************************** 
     *********************************************************************** -->  
<xsl:template match="MY_ALERTS">
  <xsl:variable name="caption_title">
    <i18n:text>Alerts</i18n:text>
  </xsl:variable>
  
  <xsl:if test="count(ALERT) > 0">
  <i2:container title="{$caption_title}" width="100%" stretch="yes">
    <i2:header>
      <table border="0" cellpadding="2" cellspacing="0" height="100%" width="100%">
        <tr>
          <td align="right">
            <a class="text" href="#" onClick="popUpWindow( 'help/alerts.htm', 'popUp4')">
              <i2:img border="0" align="middle" src="/help_avail.gif"/>
            </a>
          </td>
        </tr>
      </table>
    </i2:header>
    <table class="tableRow1" height="100%" width="100%" cellpadding="0" cellspacing="2" border="0">
      <tr>
        <td valign="top">
          <table>
            <xsl:for-each select="ALERT">
            <tr>
              <td valign="top" align="left" width="100%">
                  <i2:img border="0" align="middle" src="/bullet.gif"/>&#xA0;
                  <i18n:text><xsl:value-of select="./@title"/></i18n:text>: 
                  <i18n:number decimals="0"><xsl:value-of select="./@count"/></i18n:number>
              </td>
            </tr>
            </xsl:for-each>
          </table>
        </td>
      </tr>
    </table>   
    
    <xsl:apply-templates select="/RESPONSES/RESPONSE/MY_ALERTS" mode="details"/>
    
    <i2:footer>
      <i2:buttonbar/>
    </i2:footer>
  </i2:container>
  
  </xsl:if>
  
</xsl:template>        
  
    
  <!-- Page.xsl -->
  <!-- ********************************************************************** 
  *********************************************************************** -->      
  <xsl:template match="MY_ALERTS" mode="details">
  
dfaadad
        <table cellspacing="01" cellpadding="0" border="0" width="100%">
        <tr><td>
              <i2:table>  
                <i2:tr header="yes">
                  <td align="left"><i18n:text>Item ID</i18n:text></td>
                  <!--td align="left"><i18n:text>Template Name</i18n:text></td-->
                  <!--td align="left"><i18n:text>Service Name</i18n:text></td-->
                  <td align="left"><i18n:text>Document Name</i18n:text></td>
                  <td align="left"><i18n:text>Document Id</i18n:text></td>
                  <td align="left"><i18n:text>Creation Date</i18n:text></td>
                  <td align="left"><i18n:text>Message</i18n:text></td>
                </i2:tr>
                <i2:tr>
                    <td>
                    <a class="text" href="#">
                    <xsl:value-of select="ID/@Value"/>
                    </a>
                    </td>
                    <!--td>
                    <xsl:value-of select="MSG_TEMPLATE_NAME"/>
                    </td>
                    <td>
                    <xsl:value-of select="SERVICE_NAME"/>
                    </td-->
                    <td>
                    <xsl:value-of select="DOCUMENT_NAME/@Value"/>
                    </td>
                    <td>
                    <xsl:value-of select="DOCUMENT_ID/@Value"/>
                    </td>
                    <td>
                    <xsl:value-of select="CREATION_DATE/@Value"/>
                    </td>
                    <td>
                    <xsl:value-of select="MESSAGE/@Value"/>
                    </td>
                </i2:tr>
             </i2:table>        
            </td></tr></table>
      
  </xsl:template>  
  
<!-- ********************************************************************** 
     *********************************************************************** -->  
</xsl:stylesheet>

<!-- ********************************************************************** 
     *********************************************************************** -->  


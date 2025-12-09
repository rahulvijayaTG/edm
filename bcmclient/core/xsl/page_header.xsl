<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:output method="html"/>

  
  <xsl:template match="HEADER" mode="content_header">
    
    <script language="Javascript">
      
      <xsl:call-template name="javascript_onScenarioLog"/>

      <xsl:call-template name="javascript_onRefresh"/>
      
      <xsl:call-template name="javascript_onPrint"/>
      
    </script>
    
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <form name="header">
          <!-- Toggle -->
          <td nowrap="yes" align="left">
            <a href="javascript:togglenav('{TOGGLE_NAV/@Value}')">
              <i2:img id="toggle" src="/collapse.gif" border="0">
                <i2:attribute name="alt">
                  <i18n:text>Hide Navigation Frame</i18n:text>
                </i2:attribute>  
              </i2:img>
            </a>
          </td>

          <!-- Dom -->
          <td nowrap="yes">
            &#xA0;
            <a href="javascript:goHome('{HOME/@Value}')">
              <font color="#5060B8"><b><i18n:text><xsl:value-of select="APP_NAME/@Value"/></i18n:text>:</b></font>
            </a>&#xA0;
            
            <!-- Bread Crumbs - Start:: -->
            <xsl:variable name="breabcrumbsCount" select="count(BREADCRUMBS/BREADCRUMB)"/>
            <xsl:if test="$breabcrumbsCount &gt; 3">
              &#xA0;<font color="#5060B8">&lt;&lt;&lt;</font>&#xA0;
            </xsl:if>
            <!-- Bread Crumbs - Max Length of text shown:: -->
            <xsl:variable name="maxlen">25</xsl:variable>
            <xsl:for-each select="BREADCRUMBS/BREADCRUMB">
              <!-- Text -->
              <xsl:variable name="text">
                <i18n:text><xsl:value-of select="DISPLAY_TEXT/@Value"/></i18n:text>
              </xsl:variable>

              <xsl:variable name="truncatedText">
                <xsl:choose>
                  <xsl:when test="string-length($text) > $maxlen">
                    <xsl:value-of select="concat(substring($text,0,$maxlen -3), '...')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$text"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>

              <xsl:choose>
                <!-- Bold it if this is the current heading -->
                <xsl:when test="position() = last()">
                  <font color="#5060B8">
                    <b><i18n:text><xsl:value-of select="DISPLAY_TEXT/@Value"/></i18n:text></b>
                  </font>
                </xsl:when>
                <!-- Hyperlink it if this is not the current heading. Show only the last three headings -->
                <xsl:when test="position() &gt; $breabcrumbsCount - 3">
                  <a href="{URL/@Value}" target="appFrame">
                    <font color="#5060B8">
                      <i18n:text><xsl:value-of select="$truncatedText"/></i18n:text>
                    </font>
                  </a>
                  &#xA0;<font color="#5060B8">&gt;</font>&#xA0;
                </xsl:when>
              </xsl:choose>
            </xsl:for-each>

            <!-- Heading 1 -->
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
                    <font color="#5060B8"><i18n:text><xsl:value-of select="HEADING3/@Value"/></i18n:text></font>
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
            
            <!-- Scenario Log -->
            <i2:img onclick="javascript:onScenarioLog();" src="/list.gif" border="0">
              <i2:attribute name="alt">
                <i18n:text>Scenario Log</i18n:text>
              </i2:attribute>
            </i2:img>
            &#xA0;

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
        </form>
      </tr>
    </table>
  </xsl:template>
  

<!-- ********************************************************************** 
     *********************************************************************** -->
  <xsl:template name="javascript_onScenarioLog">  
    function onScenarioLog()
    {
      logWindow = popUpNewWindow(omxContextPath + "/bcm/scenario/scenarioLog.jsp",'popUp2');
    }
    
    function popUpNewWindow(url, popUp)
    {
              if ( (window.popUp2 != null) &amp;&amp; (!window.popUp2.closed) )
              { 
                      var windowURL = window.popUp2.location.href.toString();
                      if (windowURL.indexOf(url)>0) 
                      {
                              window.popUp2.focus();
                              return;
                      } 
                      else 
                      {
                              window.popUp2.close();
                      }
              } 
              
                logWindow = window.popUp2 = window.open('',popUp,'height=525, width=820, top=100, left=100');
                logWindow.location.href = url;
  
              for (var i=0; i &lt; 5000; i++) 
                  {
                      if (window.popUp2) 
                          {
                              window.popUp2.location = url;
                              i = 5000;
                          }
                  }
                  
              return logWindow;
    }
  </xsl:template>


<!-- ********************************************************************** 
     *********************************************************************** -->
  <xsl:template name="javascript_onRefresh">  
    function onRefresh()
    {
      javascript:history.go(0);
    }
  </xsl:template>


<!-- ********************************************************************** 
     *********************************************************************** -->
  <xsl:template name="javascript_onPrint">  
     
    function onPrint()
    {
     javascript:window.print();
    }
  </xsl:template>
     
</xsl:stylesheet>



<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

   
  <xsl:template match="HEADER" mode="content_header">

  <xsl:variable name="bandwidth"><i2:getBandwidth/></xsl:variable>

    <script language="Javascript">

      <xsl:call-template name="javascript_onRefresh"/>

      <xsl:call-template name="javascript_onPrint"/>

      function onFavorite(file)
      {
      document.form.target = 'appFrame';
      document.form.action= file + '/controller/save.x2c';
      document.form.submit();
      }
    </script>

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <form name="header">

                <xsl:variable name="toggle_nav_title">
                  <i18n:text>Hide Navigation Frame</i18n:text>
                </xsl:variable>                
                
          <!-- Toggle -->
          <td nowrap="yes" align="left" >
     <xsl:choose>
       <xsl:when test="$bandwidth = 'LOW'">
            <a id="toggle" title="{$toggle_nav_title}" href="javascript:togglenav('{TOGGLE_NAV/@Value}')">&lt;
            </a>              
       </xsl:when>
       <xsl:otherwise>
            <!-- Original   -->
            <a href="javascript:togglenav('{TOGGLE_NAV/@Value}')">
              <i2:img id="toggle" src="/collapse.gif" border="0">              
                <i2:attribute name="alt">
                  <i18n:text>Hide Navigation Frame</i18n:text>
                </i2:attribute>                
              </i2:img>
            </a>
        </xsl:otherwise>
      </xsl:choose>
          </td>

          <!-- Dom -->
          <td nowrap="yes" >

            <p>
              <script language="JavaScript1.2">breadcrumbs=new i2uiBreadcrumbs();</script>
              <table width="50%" border="0" cellspacing="0" cellpadding="0">
                <tbody>
                  <tr>
                    <!-- Home -->
                    <td id="breadcrumbsApp" nowrap="yes" align="left" class="applicationHeader" >

                      <a href="javascript:goHome('{HOME/@Value}')">
                        &#xA0;
                        <font color="#5060B8">
                          <b>
                            <i18n:text>
                              <xsl:value-of select="APP_NAME/@Value"/>
                            </i18n:text>:
                          </b>
                        </font>
                      </a>&#xA0;
                    </td>
                    <!-- Scroller-->
                    <td id="breadcrumbsRight"  style="display:none"  class="breadcrumbsScrollers">
                      <a href="javascript:breadcrumbs.scrollHorizontal(1);">&lt;&lt;&#xA0;</a>
                    </td>
                    <!-- BC-->
                    <td  class="breadcrumbs" nowrap="yes">

                      <div id="breadcrumbsContainer" style="position:relative;width:400;overflow:hidden;border:0px">
                        <div id="breadcrumbsContent" style="position:relative;width:0;left:0;top:0;border:2px">
                          <xsl:for-each select="BREADCRUMBS/BREADCRUMB">
                            <xsl:choose>
                              <!-- Bold it if this is the current heading -->
                              <xsl:when test="position() = last()">
                                <font color="#5060B8">
                                  <b>
                                    <i18n:text>
                                      <xsl:value-of select="DISPLAY_TEXT/@Value"/>
                                    </i18n:text>
                                  </b>
                                </font>
                              </xsl:when>
                              <!-- Hyperlink it if this is not the current heading. Show only the last three headings -->
                              <xsl:when test="'1' = '1'">
                                <a href="{URL/@Value}" target="appFrame">
                                  <font color="#5060B8">
                                    <i18n:text>
                                      <xsl:value-of select="DISPLAY_TEXT/@Value"/>
                                    </i18n:text>
                                  </font>
                                </a>
                                &#xA0;
                                <font color="#5060B8">&gt;</font>&#xA0;
                              </xsl:when>
                            </xsl:choose>
                          </xsl:for-each>

                        </div>
                      </div>


                    </td>
                    <!-- Scroller-->
                    <td id="breadcrumbsLeft"  style="display:none" class="breadcrumbsScrollers" >
                      <a href="javascript:breadcrumbs.scrollHorizontal(0)">&#xA0;&gt;&gt;</a>
                    </td>
                  </tr>
                </tbody>
              </table>
            </p>


          </td>

          <!-- Bread Crumbs - End. -->


          <!-- Links - Start::-->

          <td  id="breadcrumbsImg"  nowrap="yes" align="right" >
              &#xA0; &#xA0; &#xA0;
            <!-- Custom -->

            <!-- Refresh -->
     <xsl:choose>
       <xsl:when test="$bandwidth = 'LOW'">
         <a href="javascript:onRefresh();"><i18n:text>Refresh</i18n:text></a>
       </xsl:when>
       <xsl:otherwise>
            <i2:img onclick="javascript:onRefresh();" src="/rfrsh_actv.gif" border="0">
              <i2:attribute name="alt">
                <i18n:text>Refresh</i18n:text>
              </i2:attribute>
            </i2:img>
       </xsl:otherwise>
     </xsl:choose>
            &#xA0;
    
            <!-- Print -->
     <xsl:choose>
       <xsl:when test="$bandwidth = 'LOW'">
         <a href="javascript:onPrint();"><i18n:text>Print</i18n:text></a>
       </xsl:when>
       <xsl:otherwise>
            <i2:img onclick="javascript:onPrint();" src="/prnt_avail.gif" border="0">
              <i2:attribute name="alt">
                <i18n:text>Print</i18n:text>
              </i2:attribute>
            </i2:img>
       </xsl:otherwise>
     </xsl:choose>
            &#xA0;

            <!-- Favorite-->
            <!--             <i2:img onclick="javascript:onFavorite('review');" src="/bkmrk_actv.gif" border="0">
                          <i2:attribute name="alt"><i18n:text>Add To Favorites</i18n:text></i2:attribute>
                        </i2:img>&#xA0;
             -->
          </td>
          <td>&#xA0;</td>

          <!-- Links - End. -->
          <script language="JavaScript1.2">breadcrumbs.init();initialBreadcrumbsOffset=0;</script>

        </form>
      </tr>
    </table>
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



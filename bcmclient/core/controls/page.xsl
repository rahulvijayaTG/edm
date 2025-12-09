<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <xsl:import href="login.xsl"/>
  <xsl:import href="navigation.xsl"/>
  <xsl:import href="shell.xsl"/>

  <!--  PSR This needs to be defined other wise all children are evaluated-->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match= "/" mode="page_title"/>


  <!-- Root Enty Point -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:apply-templates select="." mode="page_title"/>
        </title>

        <xsl:variable name="bandwidth"><i2:getBandwidth/></xsl:variable>

        <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
        <i2:stylesheet path="/omx_core.css"></i2:stylesheet>
        <i2:stylesheet path="/i2uipad.css"></i2:stylesheet>
        <i2:javascript path="/global_javascript.js"></i2:javascript>
        <i2:javascript path="/date_validation.js"></i2:javascript>
        <i2:javascript path="/date.js"></i2:javascript>
        <i2:javascript path="/calendar.js"></i2:javascript>
        <i2:javascript path="/table.js"></i2:javascript>
        <i2:javascript path="/pgl.js"></i2:javascript>
        <xsl:if test="$bandwidth = 'LOW'">
          <i2:javascript path="/pgl_low_band.js"></i2:javascript>
        </xsl:if>

      </head>

      <xsl:call-template name="dhtml"/>
      <!--xsl:call-template name="include_global_javascript_overrides"/-->
      <xsl:call-template name="include_javascript_page"/>

      <!-- Body -->
      <xsl:choose>
        <xsl:when test="count(RESPONSES/RESPONSE/LOGIN_PAGE) > 0">
          <xsl:apply-templates select="/RESPONSES/RESPONSE/LOGIN_PAGE"/>
        </xsl:when>
        <xsl:when test="count(RESPONSES/RESPONSE/NAVIGATION) > 0">
          <xsl:apply-templates select="/RESPONSES/RESPONSE/NAVIGATION"/>
        </xsl:when>
        <xsl:when test="count(RESPONSES/RESPONSE/SHELL) > 0">
          <xsl:apply-templates select="/RESPONSES/RESPONSE/SHELL"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="/" mode="body"/>
        </xsl:otherwise>
      </xsl:choose>
    </html>

  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="/" mode="body">

    <!-- Body -->
    <body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellContent" onLoad="onLoad();" onResize="page_onResize();">

      <!-- AppFrame -->
      <xsl:apply-templates select="/" mode="appFrame"/>

      <!-- Popup Menus -->
      <xsl:call-template name="hide_i2uiPopupmenu"/>

      <xsl:call-template name="renderBusyBox"/>
    </body>

  </xsl:template>


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="/" mode="appFrame">

    <xsl:variable name="contentClass">
      <xsl:choose>
        <xsl:when test="/RESPONSES/RESPONSE/HEADER">contentFrameBody</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <!-- Content -->
    <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
      <!-- Header -->
      <xsl:if test="/RESPONSES/RESPONSE/HEADER">
        <tr>
          <td height="25px">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
              <tr>
                <td height="25px">
                  <xsl:apply-templates select="/RESPONSES/RESPONSE/HEADER" mode="content_header"/>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </xsl:if>

      <tr>
        <td valign="top" height="100%">
          <xsl:if test="string-length($contentClass) > 0">
            <xsl:attribute name="class">
              <xsl:value-of select="$contentClass"/>
            </xsl:attribute>
          </xsl:if>
          <table border="0" cellpadding="0"  width="100%" height="100%">
            <xsl:attribute name="cellspacing">
              <xsl:choose>
                <xsl:when test="/RESPONSES/RESPONSE/GRID">0</xsl:when>
                <xsl:otherwise>8</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <tr>
              <td valign="top" width="100%" height="100%">
                <xsl:apply-templates mode="content"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>

  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="include_javascript_onLoad">
    <script>
      function onLoad()
      {
        onLoadSuper();
      }

    </script>
  </xsl:template>



  <!-- **********************************************************************
   *********************************************************************** -->
  <xsl:template name="include_javascript_onResize">
    <script>
      function onResize()
      {
        onResizeSuper();
      }
    </script>
  </xsl:template>


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="dhtml">
    <i2:dhtml padsupport="yes" owcsupport="yes"></i2:dhtml>
  </xsl:template>

  <!-- **********************************************************************
    *********************************************************************** -->
  <xsl:template name="hide_i2uiPopupmenu">
  </xsl:template>

  <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template name="include_javascript_page">
     <!--xsl:call-template name="include_javascript_validation"/-->

     <script>
         function i2uiRowSelectionCallback(tableid)
         {
          if (tableid == null) { }
         <xsl:for-each select="//TABLE">
           else if(tableid == <xsl:value-of select="concat($quote,@Id,$quote)"/>)
           {
            try
            {
               hasNoSelections = (i2uiGetSelectedRowNums(tableid).length == 0);
              <xsl:for-each select="BUTTONS/BUTTON[@enabledBySelections = 'true']">
          <xsl:variable name="type">
            <xsl:choose>
              <xsl:when test="@Emphasized = 'true'">Emphasized</xsl:when>
              <xsl:otherwise>Regular</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
               if (hasNoSelections == true)
                   {
                    <xsl:value-of select="concat('i2uiToggleButtonState(',  $quote,@Id, $quote,',', $quote, 'disabled', $quote, ');')"/>
                   }
                   else
                    <xsl:value-of select="concat('i2uiToggleButtonState(',  $quote,@Id, $quote,',', $quote, 'enabled', $quote, ',' , $quote, $type, $quote, ');')"/>
                </xsl:for-each>
           }catch(e){}
          }
         </xsl:for-each>

         }

     </script>

     <script>
       
       function onLoadSuper()
       {
       <xsl:if test="/RESPONSES/RESPONSE/HEADER">
         initFrameToggleGif();
         i2uiSetBreadcrumbsWidth();
       </xsl:if>
       enableButtonsIfRowSelected();
       }

       function onResizeSuper()
       {
          <xsl:if test="/RESPONSES/RESPONSE/HEADER">
           i2uiToggleItemVisibility('breadcrumbsRight','hide')
           i2uiToggleItemVisibility('breadcrumbsLeft','hide')
           i2uiSetBreadcrumbsWidth();
          </xsl:if>
       }

       function enableButtonsIfRowSelected()
       {
         <xsl:for-each select="//TABLE">
         var tableid = <xsl:value-of select="concat($quote,@Id,$quote)"/>;
         var hasNoSelections = (i2uiGetSelectedRowNums(tableid).length == 0);
         <xsl:for-each select="BUTTONS/BUTTON[@enabledBySelections = 'true']">
           <xsl:variable name="type">
             <xsl:choose>
               <xsl:when test="@Emphasized = 'true'">Emphasized</xsl:when>
               <xsl:otherwise>Regular</xsl:otherwise>
             </xsl:choose>
           </xsl:variable>
           if (hasNoSelections == false)
           {
             <xsl:value-of select="concat('i2uiToggleButtonState(',  $quote,@Id, $quote,',', $quote, 'enabled', $quote, ',' , $quote, $type, $quote, ');')"/>
           }
         </xsl:for-each> 
         </xsl:for-each>
       }

       var page_dateFormat = 'M/d/yyyy';
       var page_dateFormat_i18n = 'M/d/yyyy';

       <xsl:if test="/RESPONSES/RESPONSE/LINKS/FORMAT/@Date">
       page_dateFormat = '<xsl:value-of select="/RESPONSES/RESPONSE/LINKS/FORMAT/@Date"/>';
       page_dateFormat_i18n = '<xsl:value-of select="/RESPONSES/RESPONSE/LINKS/FORMAT/@Date"/>';
       </xsl:if>
       var page_timeFormat = '<xsl:value-of select="/RESPONSES/RESPONSE/LINKS/FORMAT/@Time"/>';
       var page_dateTimeFormat = '<xsl:value-of select="/RESPONSES/RESPONSE/LINKS/FORMAT/@DateTime"/>';

       var page_maxRowsExportable = null;
       <xsl:if test="/RESPONSES/RESPONSE/DEFAULTS/MAX_ROWS_EXPORTABLE">
       page_maxRowsExportable = <xsl:value-of select="/RESPONSES/RESPONSE/DEFAULTS/MAX_ROWS_EXPORTABLE/@Value"/>;
       </xsl:if>

       var page_dateCurrent = '<xsl:value-of select="/RESPONSES/RESPONSE/LINKS/CURRENT_DATE/@Value"/>';
       if (page_dateCurrent != '') page_dateCurrent = dateConvert(page_dateCurrent,'MM/dd/yyyy HH:mm:ss', page_dateFormat);

       var gSortOrderElemName = "SORT_ORDER";
       var gStartCountElemName = "START_COUNT";
     </script>

     <xsl:call-template name="include_javascript_onLoad"/>
     <xsl:call-template name="include_javascript_onResize"/>


   </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="script">
    <script language="{@Language}" type="{@Type}">
      <xsl:if test="@Src">
        <xsl:attribute name="src"><xsl:value-of select="@Src"/></xsl:attribute>
      </xsl:if>
      <xsl:value-of select="."/>
    </script>
   </xsl:template>
  
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="renderBusyBox">
    <div id="busy_box" style="position:absolute; left:250px; top:250px; width:200px; height:100px; z-index:1; visibility:hidden">
      <table style="background-color:#fffde6;font-size:10px;border-width:2px;border:2px solid none;border-top:2px solid #999999;border-bottom:2px solid #999999;border-left:2px solid #999999;border-right:2px solid #999999;">
        <tr>
          <td align="center">
            <i2:img src="/alert_green_static.gif" border="0" align="middle">
            </i2:img>
          </td>
        </tr>
        <tr>
          <td align="center" nowrap="yes"><b><i18n:text>Your request is being processed.</i18n:text></b></td>
        </tr>
        <tr>
          <td align="center"><b><i18n:text>Please wait.</i18n:text></b></td>
        </tr>
      </table>
    </div>  
    <script>
      function displayBusyBox( )
      {  
        var busyBox=document.all.busy_box

        busyBox.style.top=document.body.scrollTop+document.body.clientHeight/2-busyBox.offsetHeight/2
        busyBox.style.left=document.body.scrollLeft+document.body.clientWidth/2-busyBox.offsetWidth/2

        busyBox.style.visibility = "visible";
      }
    </script>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
</xsl:stylesheet>



<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:include href="links.xsl"/>
  <xsl:include href="page_header.xsl"/>
  <xsl:include href="mdm_buttons.xsl"/>
  <xsl:output method="html"/>


  <!-- Root Enty Point -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="/">
    <html>
      <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <title><xsl:call-template name="page_title"/></title>

        <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
        <i2:stylesheet path="/omx_core.css"></i2:stylesheet>
        <i2:stylesheet path="/i2uipad.css"></i2:stylesheet>
        <i2:javascript path="/global_javascript.js"></i2:javascript>
        <i2:javascript path="/history.js"></i2:javascript>
        <i2:javascript path="/date_validation.js"></i2:javascript>
        <i2:dhtml padsupport="yes"></i2:dhtml>
        <xsl:call-template name="include_global_javascript_overrides"/>
      </head>

      <xsl:call-template name="include_javascript_page"/>
      <xsl:call-template name="renderBusyBox"/>

      <!-- Body -->
      <xsl:apply-templates select="/" mode="body"/>

    </html>

  </xsl:template>


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="/" mode="body">

    <!-- Body -->
    <body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellContent" onLoad="onLoad();toggleImage();"  onResize="onResize();">

      <!-- AppFrame -->
      <xsl:apply-templates select="/" mode="appFrame"/>

      <!-- Popup Menus -->
      <xsl:call-template name="hide_i2uiPopupmenu"/>

    </body>

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
  <xsl:template match="/" mode="appFrame">

    <!-- TODO Use CONTENT_TYPE for class -->
    <xsl:variable name="contentClass">
      <xsl:choose>
        <xsl:when test="/RESPONSES/RESPONSE/HEADER">contentFrameBody</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <!-- Content -->
    <table border="0" cellpadding="0" cellspacing="0" width="100%"  height="100%" >
      <!-- Header -->
      <xsl:choose>
        <xsl:when test="/RESPONSES/RESPONSE/HEADER/SCM_CONTEXT/@Value = 'TRUE'">
          <script>
           findscmtop();            
           scmtop.globalaction_frame.location = "../../bcm/scenario/mdm_globalaction_frame.jsp";
           scmtop.scmHistory.setSolutionName("Data Management");
           scmtop.scmHistory.clearHistory();

          <xsl:for-each select="/RESPONSES/RESPONSE/HEADER/BREADCRUMBS/BREADCRUMB">
                  scmtop.scmHistory.addHistory('<xsl:value-of select="DISPLAY_TEXT/@Value"/>','<xsl:value-of select="URL/@Value"/>', '<xsl:value-of select="URL/@Value"/>', scmtop.data_frame.appFrame);
          </xsl:for-each>
         </script>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="/RESPONSES/RESPONSE/HEADER">
            <tr>
              <td height="25px" >
                <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                  <tr>
                    <td height="25px">
                      <xsl:apply-templates select="/RESPONSES/RESPONSE/HEADER" mode="content_header"/>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>

      <tr>
        <td valign="top" height="100%">
          <xsl:if test="string-length($contentClass) > 0">
            <xsl:attribute name="class">
              <xsl:value-of select="$contentClass"/>
            </xsl:attribute>
          </xsl:if>
          <table border="0" cellpadding="0" cellspacing="8" width="100%" height="100%">
            <tr>
              <td valign="top" width="100%" height="100%" >
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
  <xsl:template name="hide_i2uiPopupmenu">
  </xsl:template>


  <!-- Current.xsl -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="include_javascript_page">


    <script>
      <xsl:call-template name="onLoad_js"/>
      <xsl:call-template name="onResize_js"/>


      // used by our standard form named 'form"
      function onAction(action)
      {

        if ( document.form != null)
          onActionForm(action, document.form);
        else if (document.input_form != null)
          onActionForm(action, document.input_form);

      }

      // used by other, non-standard forms which allows you to pass the form name manually
      function onActionForm(action, formObj)
      {
      formObj.action=action;
      formObj.target="appFrame";
      formObj.submit();
      }


      function onResizeSuper()
      {

      }

      function onLoadSuper()
      {
        // hide back button
         if (returnUrl == null | returnUrl=='')
         {
           i2uiToggleItemVisibility('back_button', 'hide');
         }

        // init header ???
        <xsl:if test="/RESPONSES/RESPONSE/HEADER">
          initFrameToggleGif();
        </xsl:if>
      }


        var page_dateFormat = '<xsl:value-of select="/RESPONSES/RESPONSE/LINKS/FORMAT/@Date"/>';
        var page_dateFormat_i18n = '<i18n:text><xsl:value-of select="/RESPONSES/RESPONSE/LINKS/FORMAT/@Date"/></i18n:text>';
    </script>

    <xsl:call-template name="include_javascript_links"/>
    <xsl:call-template name="include_javascript_onLoad"/>
    <xsl:call-template name="include_javascript_onResize"/>


  </xsl:template>



  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="include_global_javascript_overrides">
    <script>
      // compute variable scmtop which is the top of the SCM framework
      // scmtop should be used in all references instead of top
<![CDATA[
  var scmtop = top;
    function findscmtop()
    {
    scmtop = top;
        // locate SCM from top down
        if (!scmtop.scm_top)
        {
          // locate SCM from bottom up
          scmtop = window;
          while (scmtop &&
             scmtop != top &&
             !scmtop.scm_top)
          {
            scmtop = scmtop.parent;
          }
        }
   }

      function initFrameToggleGif(path)
      {
        if(window == null ) return;
        if(window.frameElement == null ) return;
        if(window.frameElement.parentNode == null ) return;

            findscmtop();
    //[Nitin Goel - changes to support scmui wrapper
      if (scmtop && scmtop.scm_top)
        frameNode = scmtop.topmost;
      else
        frameNode = window.frameElement.parentNode;

      var frameCol = frameNode.cols;
    //]NG

    /* commenting because of issue in SCM UI. Siraj will look into this
        if ( frameCol.charAt(0) == "0")
        {
          if (document.all)
          {
            document.header.toggle.alt = "Show Navigation Frame";
            document.header.toggle.src = omxContextPath + "/i2/images/expand.gif";
          }
        }
        else
        {
          if (document.all)
          {
            document.header.toggle.alt = "Hide Navigation Frame";
            document.header.toggle.src = omxContextPath + "/i2/images/collapse.gif";
          }
        }
      */
      
      }
      //[Nitin Goel : changes for supporting scmui wrapper
      function togglenav(path)
      {
        
        if(window == null ) return;
        if(window.frameElement == null ) return;
        if(window.frameElement.parentNode == null ) return;

        findscmtop();

        var frameNode;
            if (scmtop && scmtop.scm_top)
                frameNode = scmtop.topmost;
            else
                frameNode = window.frameElement.parentNode;

        var frameCol = frameNode.cols;
        if ( frameCol.charAt(0) == "0")
        {
          if (document.all)
          {
            document.header.toggle.alt = "Hide Navigation Frame";
            document.header.toggle.src = omxContextPath + "/i2/images/collapse.gif";
            frameNode.cols="170,*";
            tabShow = 0;
            return;
          }
        }
        else
        {
          if (document.all)
          {
            document.header.toggle.alt = "Show Navigation Frame";
            document.header.toggle.src = omxContextPath + "/i2/images/expand.gif";
            frameNode.cols="0%,100%";
            tabShow = 1;
          }
        }
       }
       //]Nitin Goel
       
       // issue 477838 : Hide Navigation.
      function toggleImage()
      {
        
        if(window == null ) return;
        if(window.frameElement == null ) return;
        if(window.frameElement.parentNode == null ) return;

        findscmtop();

        var frameNode;
            if (scmtop && scmtop.scm_top)
                frameNode = scmtop.topmost;
            else
                frameNode = window.frameElement.parentNode;

        var frameCol = frameNode.cols;
        if ( frameCol.charAt(0) == "0")
        {
 
          if (document.all && document.header != null )
          {
            document.header.toggle.alt = "Show Navigation Frame";
            document.header.toggle.src = omxContextPath + "/i2/images/expand.gif";            

          }
        }
        else
        {
          if (document.all && document.header != null)
          {

            document.header.toggle.alt = "Hide Navigation Frame";
            document.header.toggle.src = omxContextPath + "/i2/images/collapse.gif";
          }
        }
       }
]]>
    </script>

  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="include_javascript_onLoad">
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
      <xsl:call-template name="javascript_onLoad_page"/>
    }
   </xsl:template>


  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="javascript_onLoad_page">
      onLoadSuper();
      
  </xsl:template>


 <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="include_javascript_onResize">
  </xsl:template>


  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onResize_js">
    function onResize()
    {
       <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>

  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="javascript_onResize_page">
      onResizeSuper();
  </xsl:template>

  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="page_title">
    <i18n:text>Home Page</i18n:text>
  </xsl:template>

    <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="hide_request_parameters">
    <xsl:for-each select="/RESPONSES/RESPONSE/REQUEST_PARAMETERS/*">
      <input type="hidden" name="{name()}" value="{@Value}"/>
    </xsl:for-each>
  </xsl:template>

    <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="include_hidden_page">
      <input type="hidden" name="RET_PAGE" value="{$returnUrl_unEncoded}"/>
      <input type="hidden" name="EDITABLE" value="{/RESPONSES/RESPONSE/EDITABLE/@Value}"/>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
</xsl:stylesheet>



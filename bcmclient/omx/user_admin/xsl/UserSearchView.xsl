<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

<xsl:import href="../../../bcm/framework/queryform/xsl/searchformfilter.xsl"/>
    
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_table_resize"/>
    <xsl:call-template name="include_javascript_form"/>
  </xsl:template>
  
  <!-- **********************************************************************-->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <table id="BOR_table" width="100%">
      <xsl:if test="count(SUCCESS_MESSAGE) &gt; 0">
        <tr>
          <td>
            <xsl:apply-templates select="SUCCESS_MESSAGE"/>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="count(ERROR_MESSAGE) &gt; 0">
        <tr>
          <td>
            <xsl:apply-templates select="ERROR_MESSAGE"/>
          </td>
        </tr>
      </xsl:if>
    </table>
    <table cellpadding="0" width="100%">
      <tr>
        <td>
          <xsl:apply-templates select="SEARCH">
            <xsl:with-param name="formName" select="'result_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>
   
  <!-- **********************************************************************-->
  <xsl:template name="include_javascript_form">
    <script><![CDATA[      
    function onSearch()
    {
        if(document.search_form.F_USER_PROFILE_STATUS.type == 'checkbox')
        {
            if(document.search_form.F_USER_PROFILE_STATUS.checked)
            {
                document.search_form.F_USER_PROFILE_STATUS.value = "true";
            }
            else
            {
                //but this value will not pass to the server            
                document.search_form.F_USER_PROFILE_STATUS.value = "false";
            }
        }
        document.search_form.START_COUNT.value=0;
        document.search_form.DO_SEARCH.value='Yes';        
        document.search_form.submit();
    }
    
    // Enter Key Tapping - Start::
    var browserName = navigator.appName;    
    if (browserName == "Netscape") 
    {
      document.captureEvents(Event.KEYPRESS);
      document.onkeypress=NetEnterKey;
    }
    else
    { 
      if (browserName.indexOf("Explorer") >= 0)
      { 
        document.onkeypress=IEEnterKey;
        document.onkeydown=IEEnterKey;
      }
    }  
    
    function IEEnterKey() 
    { 
      // if enter key
      if(window.event.keyCode == 13)
      { 
        if (window.event.srcElement.onclick != null)
        {
          event.returnValue=true;
        } 
        else
        {
          if ( window.event.srcElement.type != "textarea" )
          {
            SetfocusSubmit(window.event.srcElement)
          }
    
          event.returnValue=false;
        }  
      }  
      // if backspace 
      if (window.event.keyCode==8) 
      {
        if (window.event.srcElement.isTextEdit == false)
          event.returnValue=false;
      }
    }

    function NetEnterKey(e) 
    {
      key = e.which; 
      if(key == 13)
      { 
        SetfocusSubmit( e.target )
        return false;
      }
    }  

    function SetfocusSubmit( target )
    {
      if ( target.form == document.search_form )
      {
        onSearch();
      }
      else if (target.form == document.result_form)
      {
        getRecords('jump');
      }
      else
      {
        onSearch();
      }
    }
   
    // Setting Focus
    function setFocus()
    {
      var elementsLen = document.search_form.elements.length;     
      for(count = 0; count < elementsLen; count++)
      {
        if( 
            document.search_form.elements[count].type != "hidden" 
          )
          {  
            document.search_form.elements[count].focus();
            return;
          }
      }
    }      
        
    function onResetPassword()
    {
        var confirmMesg = "PASSWORD_RESET_CONFIRM";
        if( core_confirm( confirmMesg ) == 'yes' )
        { 
            document.result_form.target="appFrame";
            document.result_form.action= omxContextPath + "/omx/user_admin/users_edit/resetPasswordForUser.cmd";
            document.result_form.submit();
        }
    }

    function viewUsersDone(){
        document.forms.result_form.WHERE.value = 'USER_GROUP_MAIN';
        document.forms.result_form.action = omxContextPath + '/omx/user_admin/user_group_details/goToPage.cmd';
        document.forms.result_form.submit();
    }
    
    function edit()
    {
        document.forms.result_form.WHERE.value = 'USER_DETAILS';
        document.forms.result_form.action = omxContextPath + "/omx/user_admin/user_group_details/goToPage.cmd?fromPage=user_search_view";
        document.forms.result_form.submit();        
    }
    
    function addUsersToGroup(){
        if ( checkifAnySelected(result_form) == true )
        {
            document.forms.result_form.action = omxContextPath + '/omx/user_admin/user_group_details/addUsersToUserGroup.cmd';
            document.forms.result_form.submit();
        } else {
          core_alert("]]><i18n:text>UserSecurity.Select_One_User</i18n:text><![CDATA[.");
        }
    }
    ]]>
    </script>
</xsl:template>

  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="include_javascript_table_resize">
    <script><![CDATA[
    function resize_Containers()
   {
  resizeScrollableTables();
     }
  ]]></script>
  </xsl:template>

  <!--************************************************************************* 
        *********************************************************************** -->
  <xsl:template match="SUCCESS_MESSAGE">
    <i2:img src="/alert_green_static.gif" border="0" align="middle">
      <i2:attribute name="alt">
        <i18n:text>Success</i18n:text>
      </i2:attribute>
    </i2:img>
     &#xA0;
     <i18n:text>
      <xsl:value-of select="@Value"/>
    </i18n:text>
  </xsl:template>

 <!--*************************************************************************
        ************************************************************************* -->
  <xsl:template match="ERROR_MESSAGE">
    <i2:img src="/alert_static.gif" border="0" align="middle">
      <i2:attribute name="alt">
        <i18n:text>Error</i18n:text>
      </i2:attribute>
    </i2:img>
     &#xA0;
     <i18n:text>
      <xsl:value-of select="@Value"/>
    </i18n:text>
  </xsl:template>
<!-- **********************************************************************
     ***********************************************************************-->
</xsl:stylesheet>
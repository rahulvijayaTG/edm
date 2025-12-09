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
        if(document.search_form.F_USER_GRP_PROFILE_STATUS.type == 'checkbox')
        {
            if(document.search_form.F_USER_GRP_PROFILE_STATUS.checked)
            {
                document.search_form.F_USER_GRP_PROFILE_STATUS.value = "true";
            }
            else
            {
                //but this value will not pass to the server            
                document.search_form.F_USER_GRP_PROFILE_STATUS.value = "false";
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
        
    function onAddNewUserGroup()
    {
            document.result_form.target="appFrame";
            document.result_form.method="POST";
            document.result_form.action="user_group_details/getUserGroupDetails.cmd?CREATE_NEW=Yes&ORG_ID=ORG_1";
            document.result_form.submit();
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
    var table_id = 'result_form_table';
    var width = document.body.offsetWidth -5 ;
    var height = document.body.scrollHeight;
    // resize table   approx
    i2uiResizeColumns(table_id);
    i2uiResizeScrollableArea(table_id, height-400, width-30, null, null, null,null, null);
    i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight-100, null, document.body.offsetWidth - 20, true, 'yes');
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
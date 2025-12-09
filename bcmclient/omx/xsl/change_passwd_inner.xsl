<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">
  
  <xsl:import href="../../core/xsl/page.xsl"/>
  <xsl:import href="../../core/xsl/page_header.xsl"/>
  <xsl:import href="../../core/xsl/header.xsl"/>
  <xsl:import href="../../core/xsl/buttons.xsl"/>
  <xsl:import href="code_master.xsl"/>
  
  <xsl:output method="html"/> 
  
  <!-- Page Content -->
  <!-- **********************************************************************-->
  <xsl:template match="RESPONSES" mode="content">   
    <xsl:call-template name="include_javascript_form"/>
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_table_resize"/>
  </xsl:template>

 <!-- **********************************************************************-->  
  <xsl:template match="CONTAINER" mode="container">     
    <xsl:param name="content" select="/RESPONSES"/>    
    <xsl:variable name="label">
      <xsl:choose>
        <xsl:when test="string-length(STEP[@Selected = 'true']/@DisplayText) > 0">
          <i18n:text><xsl:value-of select="STEP[@Selected = 'true']/@DisplayText"/></i18n:text>
        </xsl:when>
        <xsl:otherwise>
          <i18n:text><xsl:value-of select="@DisplayText"/></i18n:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="editable">
      <xsl:choose>
        <xsl:when test="string-length(STEP[@Selected = 'true']/@Editable) > 0">
          <xsl:value-of select="STEP[@Selected = 'true']/@Editable"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@Editable"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
      
    <xsl:variable name="id">
      <xsl:choose>
        <xsl:when test="string-length(STEP[@Selected = 'true']/@Id) > 0">
          <xsl:value-of select="STEP[@Selected = 'true']/@Id"/>
        </xsl:when>
        <xsl:when test="string-length(@Id) > 0">
          <xsl:value-of select="@Id"/>
        </xsl:when>
        <xsl:otherwise>container</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Scrollable -->
    <xsl:variable name="scrollable">
      <xsl:choose>
        <xsl:when test="string-length(@Scrollable)">
          <xsl:value-of select="@Scrollable"/>        
        </xsl:when>
        <xsl:otherwise>yes</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Container -->    
    <i2:container  id="{$id}" title="{$label}" width="100%"  scrollable="{$scrollable}">
      <xsl:if test="string-length($editable) > 0">
        <i2:attribute name="editable">
          <xsl:value-of select="$editable"/>
        </i2:attribute>
      </xsl:if>
        
      <!-- <xsl:call-template name="header"/>  -->
        
     <!-- Content -->      
     <xsl:apply-templates select="$content" mode="container_content"/>     
     
    </i2:container>    
  </xsl:template>

<!-- **********************************************************************-->  
    <xsl:template match="RESPONSE" mode="container_content">
    <form name="{FORM/@Name}" method="{FORM/@method}" action="{FORM/@Action}">
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

    <!--Main content starts from here-->
    <xsl:call-template name="change_passwd_required_field"/>
    
    <xsl:if test="CHANGE_PWD_INFO/ERROR/@Value">
      <table  class="instructionArea" border="0" cellPadding="0" cellSpacing="0" width="100%">
        <tr/>
        <tr>
          <td align="middle" valign="middle" width="5%">
            <i2:img src="/alert_static.gif" alt="Error" border="0" align="middle"/>
          </td>
          <td nowrap="yes" colspan="2">&#xA0;<b>
              <i18n:text>Password change failed</i18n:text>.&#xA0;<i18n:text>Please try again</i18n:text>.</b>
          </td>
          <xsl:if test="CHANGE_PWD_INFO/DESCRIPTION">
            <td width="100%">&#xA0;<b>
                <i18n:text>
                  <xsl:value-of select="CHANGE_PWD_INFO/DESCRIPTION/@Value"/>
                </i18n:text>
              </b>
            </td>
          </xsl:if>
        </tr>
        <tr>
          <td colspan="3"></td>
        </tr>
      </table>
    </xsl:if>

    <xsl:if test="CHANGE_PWD_INFO/SUCCESS/@Value">
      <table  class="instructionArea" border="0" cellPadding="0" cellSpacing="0" width="100%">
        <tr/>
        <tr>
          <td align="middle" valign="middle" width="5%">
            <i2:img src="/alert_green_static.gif" alt="Error" border="0" align="middle"/>
          </td>
          <td nowrap="yes" colspan="2">&#xA0;<b>
              <i18n:text><xsl:value-of select="CHANGE_PWD_INFO/DESCRIPTION/@Value"/></i18n:text>.</b>
          </td>
          <xsl:if test="CHANGE_PWD_INFO/DESCRIPTION">
            <td width="100%">&#xA0;</td>
          </xsl:if>
        </tr>
        <tr>
          <td colspan="3">
          </td>
        </tr>
      </table>
    </xsl:if>
        
    <table border="0" cellPadding="2" cellSpacing="3">
      <tr>
        <td colspan="3">
          <b>
            <i18n:text>Please change your password by entering appropriate values in the following fields.</i18n:text>
          </b>
        </td>
      </tr>
    
      <tr>
        <td colspan="1" width="25%">
            <i18n:text>Old Password</i18n:text>:<xsl:call-template name="display_alert_mark"/>
        </td>
        <td align="left" width="25%">
          <input type="password" class="inputFieldIE" name="{FORM/FIELD[@Name='OLD_PASSWORD']/@Name}" value="" size="27"/>
        </td>
        <td/>
      </tr>
      <tr>
        <td colspan="1" width="25%">
          <i18n:text>New Password</i18n:text>:
          <xsl:call-template name="display_alert_mark"/>
        </td>
        <td width="25%">
          <input type="password" class="inputFieldIE" name="{FORM/FIELD[@Name='NEW_PASSWORD']/@Name}" value="" size="27"/>
        </td>
        <td/>
      </tr>
      <tr>
        <td width="25%">
          <i18n:text>Confirm New Password</i18n:text>:
          <xsl:call-template name="display_alert_mark"/>
        </td>
        <td width="25%">
          <input type="password" class="inputFieldIE" name="{FORM/FIELD[@Name='CONFIRM_PASSWORD']/@Name}" value="" size="27"/>
        </td>
        <td/>
      </tr>
      
      <input type="hidden" name="{FORM/FIELD[@Name='PROMPT_SECRET_QUESTION']/@Name}" value="{FORM/FIELD[@Name='PROMPT_SECRET_QUESTION']/@Value}"/>
      <input type="hidden" name="{FORM/FIELD[@Name='USER_NAME']/@Name}" value="{FORM/FIELD[@Name='USER_NAME']/@Value}"/>
      <input type="hidden" name="{FORM/FIELD[@Name='MY_PROFILE']/@Name}" value="{FORM/FIELD[@Name='MY_PROFILE']/@Value}"/>
      
      <!-- Nikhil: Added to capture secret question and password to assist in login/password recovery -->
      <xsl:if test="FORM/FIELD[@Name='PROMPT_SECRET_QUESTION']/@Value = 'yes'">
        <tr>
          <td>
            <i18n:text>Secret Question</i18n:text>
          <xsl:call-template name="display_alert_mark"/>
          </td>
          <td>
            <select class="inputfieldIE" name="PWD_QUESTION" tabIndex="10">
              <option value="">
                <i18n:text>Select...</i18n:text>
              </option>
              <xsl:choose>
                <xsl:when test="string-length(USER_INFORMATION/PWD_QUESTION/@Value) &gt; 0">
                  <xsl:apply-templates select="/RESPONSES/RESPONSE/PWD_QUESTIONS/CODE_MASTER_VALUE" mode="pulldown">
                    <xsl:sort select="DESCRIPTION/@Value"/>
                    <xsl:with-param name="selectedId" select="USER_INFORMATION/PWD_QUESTION/@Value"/>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="/RESPONSES/RESPONSE/PWD_QUESTIONS/CODE_MASTER_VALUE" mode="pulldown"/>
                </xsl:otherwise>
              </xsl:choose>
            </select>
          </td>
        </tr>
        <tr>
          <td>
            <i18n:text>Secret Answer</i18n:text>
          <xsl:call-template name="display_alert_mark"/>
          </td>
          <td>
            <input type="field" name="PWD_ANSWER" value="{USER_INFORMATION/PWD_ANSWER/@Value}" tabIndex="15" class="inputfieldIE" maxlength="32" size="27"/>
          </td>
        </tr>
      </xsl:if>      
      
    </table>
    
    <!-- Footer -->
     <i2:footer>
        <xsl:apply-templates select="FORM/BUTTONS"/>
     </i2:footer>
    </form>
  </xsl:template>

<!--*************************************************************-->
 <xsl:template name="change_passwd_required_field">
    <table border="0" id="denotes_required_field" cellpadding="0" cellspacing="0" width="100%" class="instructionArea">
      <tr>
        <td align="left" width="100%">
          <font color="red">*</font>&#xA0;
          <i18n:text>denotes required field</i18n:text>
        </td>
      </tr>
    </table>
</xsl:template>
    
<!--*************************************************************** -->
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
  <!--**************************************************
  *********************************************************************** -->
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

  <!--**********************************************************************-->
  <xsl:template name="onLoad_js">
    function onLoad()
    {      
      //resize_Containers();
    }
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onResize_js">
    function onResize()
    {
      <xsl:call-template name="javascript_onResize_page"/>
      resize_Containers();
    }
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_form">
    <script>
    <![CDATA[    
    function IEEnterKey()
    {
	    if( window.event.keyCode == 13 && ((window.event.srcElement.name == "OLD_PASSWORD") || 
					       (window.event.srcElement.name == "NEW_PASSWORD") ||
					       (window.event.srcElement.name == "CONFIRM_PASSWORD")))
	    {
	      changePassword();	      
	      event.returnValue=false;
	    }	
    }
          browserName = navigator.appName;
	  function NetEnterKey(e)
	       {
		  key = e.which;
		  if(key == 13){ 
		    changePassword();
		    return false;
		    }
		}	
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
	          }
   }
        
    ]]>
    function changePassword()
    {
            if (document.forms[1].OLD_PASSWORD.value == "")
            {
                core_alert("Please enter your old Password");
                document.forms[1].OLD_PASSWORD.focus();
                return;
            }

            if (document.forms[1].NEW_PASSWORD.value == "")
            {
                core_alert("Please enter your new Password");
                document.forms[1].OLD_PASSWORD.focus();
                return;
            }

            if (document.forms[1].CONFIRM_PASSWORD.value == "")
            {
                core_alert("Please enter your new Password to confirm");
                document.forms[1].OLD_PASSWORD.focus();
                return;
            }
            if (document.forms[1].NEW_PASSWORD.value != document.forms[1].CONFIRM_PASSWORD.value)
            {
                core_alert("The 'New Password' and 'Confirm New Password' fields must have the same value");
                document.forms[1].CONFIRM_PASSWORD.focus();
                return;
            }

            if (document.forms[1].PROMPT_SECRET_QUESTION.value == "yes")
            {
                if (document.forms[1].PWD_QUESTION.value == "")
                {
                    core_alert("Please select your Password Question");
                    document.forms[1].PWD_QUESTION.focus();
                    return;
                }

                if (document.forms[1].PWD_ANSWER.value == "")
                {
                    core_alert("Please enter your Password Answer");
                    document.forms[1].PWD_ANSWER.focus();
                    return;
                }
            }
            document.forms[1].submit();
   }
        
     function onCancel()
      {
            document.forms[1].action= omxContextPath + "/omx/user_admin/users_edit/view.cmd?VIEW_MODE=PREFERENCE";
            document.forms[1].submit();
      }
  </script>
  </xsl:template>
  
  <!-- **********************************************************************-->
    <xsl:template name="display_alert_mark">
    <font color="red">*</font>
  </xsl:template>
  
  <!-- **********************************************************************-->
  <!-- Javascript -->
  <xsl:template name="include_javascript_table_resize">
    <script>
    <![CDATA[    
    function resize_Containers()
    {
      //alert("Resizinggggggg.....");
      parentContainer_id = 'container';
      parentContainerScroller_id = parentContainer_id + '_scroller';
      parentIsScrolling = false;

      table_id = 'result_form_table';
      table_container_id = 'result_form_container';
      search_form_container_id = 'search_form_container'

      // resize top level container
      i2uiResizeScrollableContainer(parentContainer_id,document.body.offsetHeight - 90, null, document.body.offsetWidth -20, true, 'yes');


      var width = document.body.offsetWidth - 25;
      var height = document.body.scrollHeight - 100;

      // resize table   approx
      i2uiResizeScrollableArea(table_id, height, width-16, null, null, null,null, null)
      i2uiResizeColumns(table_id);


     tablewidth = width-16; // for now

     // resize table
     i2uiResizeScrollableArea(table_id, height, tablewidth, null, null, null,null, null)
     i2uiResizeColumns(table_id);
     // resize the table container
     i2uiResizeScrollableContainer(table_container_id, document.body.offsetHeight - 20, null, width  , true, 'yes');

     // resize top level container
     i2uiResizeScrollableContainer(parentContainer_id,document.body.offsetHeight - 20, null, document.body.offsetWidth -20, true, 'yes');

     // resize the search container
     i2uiResizeScrollableContainer(search_form_container_id,document.body.offsetHeight - 20, null, width  , true, 'yes');

     // resize top level container
     i2uiResizeScrollableContainer(parentContainer_id,document.body.offsetHeight - 90, null, document.body.offsetWidth -20, true, 'yes');
  }
  ]]></script>
  </xsl:template>  
  
  <!-- **********************************************************************-->
  <xsl:template name="page_title">  
    <i18n:text>Home Page</i18n:text>
  </xsl:template>
  
  </xsl:stylesheet>
<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../bcm/framework/queryform/xsl/searchformfilter.xsl"/>  
  <xsl:import href="../../../bcm/framework/xsl/required_field.xsl"/>
  <!-- Errors -->
  <xsl:import href="../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>

  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:call-template name="include_javascript_table_resize"/>
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_table"/>
    <script type="">
    // Overriding onkeypress globally to suppress IEEnterkey() getting called ... doing this to ensure that the 'comments' textarea responds to the enter key.
    document.onkeypress=doNothing;
    /*function doNothing()
    { 
      if(window.event.srcElement.type != 'textarea')
      {
         if(window.event.keyCode == 13)
         {
           SetfocusSubmit(window.event.srcElement);
         }
      }
    }*/
    </script>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <xsl:call-template name="display_instruction_area"/>
    <table id="table2">
      <tr>
        <td/>
      </tr>
      <tr>
        <td>
          <!-- Scenario -->
          <xsl:apply-templates select="SCENARIO_LOGS/SEARCH">
            <xsl:with-param name="formName" select="'result_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
      <tr>
        <td>
          <xsl:call-template name="display_comment_area"/>
        </td>
      </tr>
    </table>
    <i2:footer>
      <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
          <td>
            <i2:buttonbar>
                <xsl:call-template name="mdmButton">
                    <xsl:with-param name="onclick" select="'javascript:onClose();'"/>
                    <xsl:with-param name="text" select="'Close'"/>
                    <xsl:with-param name="id" select="'Close'"/>
                    <xsl:with-param name="name" select="'Close'"/>
                </xsl:call-template>                                    
            
              <!--i2:button id="Close" name="Close" onclick="javascript:onClose();">
                        &#xA0;Close&#xA0;
                      </i2:button-->
              <i2:buttonbardivider/>
                <xsl:call-template name="mdmButton">
                    <xsl:with-param name="onclick" select="'javascript:onSave();'"/>
                    <xsl:with-param name="text" select="'Save'"/>
                    <xsl:with-param name="id" select="'Save'"/>
                    <xsl:with-param name="name" select="'Save'"/>
                </xsl:call-template>                                    
              <!--i2:button id="Save" name="Save" onclick="javascript:onSave();">
                        &#xA0;Save&#xA0;
                      </i2:button-->
            </i2:buttonbar>
          </td>
        </tr>
      </table>
    </i2:footer>
  </xsl:template>
  <!-- custom javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="display_comment_area">
    <form id="result_form1" name="result_form1" method="POST">
      &#xA0;
      <TEXTAREA name="comments" value="" tabIndex="" class="editable" cols="127" rows="8" wrap="physical" onkeypress="return CheckLength(3000);" onpaste="return CheckLength(3000);"/>
    </form>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="display_validation_messages">
    <table border="0" id="success_message" cellpadding="0" cellspacing="0" width="100%" class="instructionArea">
      <tr>
        <td align="middle" valign="middle" width="5%">
          <i2:img src="/alert_green_static.gif" alt="Success" border="0" align="middle"/>
        </td>
        <td align="left" valign="middle" width="100%">
          <i18n:text>
            <xsl:value-of select="/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value"/>
          </i18n:text>
        </td>
      </tr>
    </table>
    <table border="0" id="error_message" cellpadding="0" cellspacing="0" width="100%" class="instructionArea">
      <xsl:apply-templates select="/RESPONSES/RESPONSE/ERROR_MESSAGE"/>
    </table>
  </xsl:template>
  <!--**************************************************
  *********************************************************************** -->
    <xsl:template name="include_javascript_table">
  
    <script>
      function CheckLength(length)
      {
        if (window.event.srcElement.value.length >= length)
        {
            return false;                         
        }
      }

    function onSave()
    {
        if (document.result_form1.comments.value.trim() == "")
        {
          core_alert("ENTER_COMMENTS");
          return;
        }
        if (document.result_form1.comments.value.length > 3000)
        {
          core_alert("COMMENTS_LENGTH");
          return;
        }
        document.result_form1.action="controller/saveComment.cmd";
        document.result_form1.submit();
    }
    function dispatchSearch()
    {
        //document.result_form.target="_self";
        document.result_form.DO_SEARCH.value='Yes';
        document.result_form.START_COUNT.value=0;
        document.result_form.action="scenarioLog.jsp";
        document.result_form.submit();
    }
    function onClear()
    {
      clearFields(document.result_form);
      dispatchSearch();
    }

  </script>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
      document.title = "Scenario Logs";
      document.result_form1.comments.focus();
      requiredFieldCheck('onLoad');
      resize_Containers();
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
  <!-- Javascript -->
  <xsl:template name="include_javascript_table_resize">
       
    <script>
    var MAX_ROW='<xsl:value-of select="/RESPONSES/RESPONSE/MAX_ROWS/@Value"/>';
    <![CDATA[
      function resize_Containers()
    {
      var width = document.body.offsetWidth - 50;
      var height = document.body.scrollHeight - 300;

     var table_id = 'result_form_table';
     i2uiResizeScrollableArea(table_id, 192, width, null, null, null,null, null);
     //i2uiResizeColumns(table_id);
    i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight - 268, null, document.body.offsetWidth - 30, true, 'yes');
  }

   function clearFields(form)
   {
        var count;
        var elementsLen = form.elements.length;
        var foundChecked = false;

        for(count = 0; count < elementsLen; count++)
        {
          if( form.elements[count].type == "checkbox" ){
              form.elements[count].checked = false;
           }
          if( form.elements[count].type == "text" ){
              form.elements[count].value = '';
           }
        }
        dispatchSearch();
   }

  function IEEnterKey()
  {
/*
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
*/
  }
  
  
function SetfocusSubmit( target )
  {

      if (target.name != 'comments')
      {
              dispatchSearch();
      }
      else
      {
//          event.returnValue = false;
      }
  }

    function onFilter()
    {
          document.filter_form.target="appFrame";
          document.filter_form.action="../../../bcm/framework/filter/controller/display.cmd";
          document.filter_form.submit();
    }

     function onSaveFilter()
      {
          if( document.filter_form.FILTER_NAME.value == "" )
          {
            core_alert("Please specify a name for the filter.");
            return;
          }
          document.filter_form.target="appFrame";
          document.filter_form.action="../../../bcm/framework/filter/controller/saveFilter.cmd";
          document.filter_form.submit();
      }


      // Method overridden from searchformfilter.js to solve problem of 'next' button paginating in parent window .. 
      // Methods getRecords() and jumpToPage() combined ..
      function getRecords(actionName, startCount, result_form, page_form)
      {
        
        if(page_form == null)  page_form = document.result_form;
      
          if(result_form == null)  result_form = document.result_form;

          if (startCount == null)
              startCount=page_form.pagenum.value;
            
          var pagenum= parseInt(startCount);  pagenum--;
                
           
          if (actionName == "jump")
          {
              if(( page_form.RECORD_COUNT.value == 0 || page_form.RECORD_COUNT.value > pagenum*MAX_ROW)  && (pagenum+1>0) && (page_form.START_COUNT.value !=pagenum*MAX_ROW))
              {
                result_form.DO_SEARCH.value='yes';
                result_form.START_COUNT.value=pagenum*MAX_ROW;
                result_form.method="POST";
                result_form.submit();
              }
          }
      }
]]></script>
  </xsl:template>
  <!-- ***************************************************************************
  ******************************************************************************* -->
</xsl:stylesheet>

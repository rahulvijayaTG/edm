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
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_table"/>
    <xsl:call-template name="include_javascript_table_resize"/>
    <script>
    function sort(value, sequence, isSortable, isFrozenAllowed, form_name, noOfColumns)
    {
      document.result_form.SELECTED_COLUMN.value=value;
      document.result_form.COLUMN_SEQUENCE.value=sequence;
      document.result_form.COLUMN_COUNT.value=noOfColumns;

        form = document.forms[form_name];
        if (form == null)
            form = document.result_form;
        else
            formName = form_name;

        if (isSortable == 'yes')
        {
           i2uiShowMenu('sortOrder_old');
        }
    }
 </script>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="hide_i2uiPopupmenu">
        <i2:popupmenu name="sortOrder_old">
          <i2:popupmenuoption  url="javascript:form_sortOrder('Ascending')"><i2:attribute name="text"><i18n:text>Ascending</i18n:text></i2:attribute></i2:popupmenuoption>
          <i2:popupmenuoption  url="javascript:form_sortOrder('Descending')"><i2:attribute name="text"><i18n:text>Descending</i18n:text></i2:attribute></i2:popupmenuoption>
        </i2:popupmenu>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <table id="table1" width="100%">
      <tr>
        <td>
          <xsl:call-template name="display_instruction_area"/>
        </td>
      </tr>
      <tr>
        <td>
          <!-- Scenario -->
          <xsl:apply-templates select="SCENARIOS/SEARCH">
            <xsl:with-param name="formName" select="'result_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!-- custom javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
<xsl:template name="display_validation_messages">
    <xsl:variable name="message" select="/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value"/>
    <table border="0" id="success_message" cellpadding="0" cellspacing="0" width="100%" class="instructionArea">
      <tr>
        <td align="middle" valign="middle" width="5%">
          <i2:img src="/alert_green_static.gif" alt="Success" border="0" align="middle"/>
        </td>
        <td align="left" valign="middle" width="100%">
          <i18n:text><xsl:value-of select="$message"/></i18n:text>
        </td>
      </tr>
    </table>

    <table border="0" id="error_message" cellpadding="0" cellspacing="0" width="100%" class="instructionArea">
          <xsl:apply-templates select="/RESPONSES/RESPONSE/ERROR_MESSAGE"/>
    </table>

  </xsl:template>
  <!-- Overriding Radio-button template to get back the disabling functionality; It had gone for a toss after the merge from IO_CR2_BR coz of changes in main branch;
        Picked up this template as-is from IO_CR2_BR.
  -->
  <!-- Field Radio -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[@Type = 'Radio']" mode="content">
    <!-- Todo use class="checkboxColumn" only if first column -->
    <th nowrap="yes" align="center" class="checkboxColumn">
      <input type="radio" name="{@Name}" value="{@Value}" onclick="{@OnClick}">
        <xsl:if test="@Checked">
          <xsl:attribute name="checked"/>
        </xsl:if>
        <xsl:if test="@Disabled">
          <xsl:attribute name="disabled"/>
        </xsl:if>
      </input>
    </th>
  </xsl:template>
  <!--**************************************************
  *********************************************************************** -->
  <xsl:template name="include_javascript_table">
    <script>
    function dispatchSearch()
    {
        document.result_form.DO_SEARCH.value='Yes';
        document.result_form.START_COUNT.value=0;
        document.result_form.action="scenarioSearch.jsp";
        document.result_form.submit();
    }
    function onClear()
    {
      clearFields(document.result_form);
    }
    function onCopy()
    {
        document.result_form.action="controller/copyScenario.cmd";
        document.result_form.submit();
    }

    function onSelect()
    {
        document.result_form.action="controller/selectScenario.cmd";
        document.result_form.submit();
    }

    function onCreate()
    {
        document.result_form.action="controller/createScenario.cmd";
        document.result_form.submit();
    }

    function onDelete()
    {
     var res = core_confirm("Are you sure you want to delete the scenario?") ;
     if (res == 'yes') {
        document.result_form.action="controller/deleteScenario.cmd";
        document.result_form.submit();
    }
    }

    function onSetBaseScenario()
    {
        document.result_form.action="controller/setBaseScenario.cmd";
        document.result_form.submit();
    }

    function onExportToExcel()
    {
        document.result_form.action="controller/exportToExcel.cmd";
        document.result_form.submit();
    }

  </script>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
            var scenarioName = '<xsl:value-of select="/RESPONSES/RESPONSE/scenarioName/@Value"/>';
                var instanceID = '<xsl:value-of select="/RESPONSES/RESPONSE/instanceID/@Value"/>';
            var userName = '<xsl:value-of select="/RESPONSES/RESPONSE/userName/@Value"/>';
            var userString = '<i18n:text>User</i18n:text>';
            var scenarioString = '<i18n:text>Scenario</i18n:text>';
            var instanceString = '<i18n:text>Instance</i18n:text>';
            //alert(scenarioName);
                //alert('instanceID == ' + instanceID);
            //alert(userName);

            if (top.title_frame)  // We are in scmui framesets
            {
                <![CDATA[
                var loc = top.title_frame.location.href;
                var i       = loc.indexOf("&uid=");
                var i       = loc.indexOf('=',i);
                i=i+1;
                var k       = loc.indexOf('&',i);
                ]]>
                <xsl:choose>
                    <xsl:when test="/RESPONSES/RESPONSE/scenarioID/@Value = 0">
                    loc = loc.substring(0, i ) +userName  + loc.substring(k);
                </xsl:when>
                <xsl:otherwise>
                              if (instanceID == '' || instanceID == null)
                              {
                            <![CDATA[
                                       loc = loc.substring(0, i ) + userName + "&nbsp;&nbsp; "+scenarioString+": " + scenarioName + loc.substring(k);
                            ]]>
                              }
                              else
                              {
                                <![CDATA[
                                       loc = loc.substring(0, i ) + userName + "&nbsp;&nbsp; "+instanceString+": " + instanceID + "&nbsp;&nbsp; "+scenarioString+": " + scenarioName + loc.substring(k); 
                                ]]>
                              }
                </xsl:otherwise>
                </xsl:choose>
                top.title_frame.location.href = loc;
            }
            else        // We are in x2 framesetts.
            {
          topDoc = top.i2ui_shell_top.document;
          var shellUsername = topDoc.all.shellUsername.firstChild.nodeValue;
          <xsl:choose>
            <xsl:when test="/RESPONSES/RESPONSE/scenarioID/@Value = 0">
                topDoc.all.shellUsername.firstChild.nodeValue = userString+': ' + userName;
            </xsl:when>
            <xsl:otherwise>
                  if (instanceID == '' || instanceID == null)
                  {
                    <![CDATA[
                      topDoc.all.shellUsername.firstChild.nodeValue = userString +': ' + userName + '     '+scenarioString+': ' + scenarioName;
                    ]]>
                  }
                  else
                  {
                    <![CDATA[
                      topDoc.all.shellUsername.firstChild.nodeValue = userString+': ' + userName + '     '+instanceString+': ' + instanceID + '     '+scenarioString+': ' + scenarioName;
                    ]]>
                  }

            </xsl:otherwise>
          </xsl:choose>
            }
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
    <script><![CDATA[
      function resize_Containers()
    {
      var width = document.body.offsetWidth - 40;
      var height = document.body.scrollHeight - 300;

     var table_id = 'result_form_table';
     i2uiResizeScrollableArea(table_id, 100, width, null, null, null,null, null);
     i2uiResizeColumns(table_id);
    i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight - 280, null, document.body.offsetWidth - 30, true, 'yes');
  }

   function checkifAnySelected(form)
   {
        var count;
        var elementsLen = form.elements.length;
        var foundChecked = false;

        for(count = 0; count < elementsLen; count++)
        {
          if( form.elements[count].type == "checkbox" && form.elements[count].checked == true  &&
             form.elements[count].name != "SELECT_ALL"  ){
              foundChecked = true;
              break;
           }
        }
        return foundChecked;
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
      if(window.event.keyCode == 13)
          {
              SetfocusSubmit(window.event.srcElement)
                  event.returnValue=false;
          }
  }
  function SetfocusSubmit( target )
  {
              dispatchSearch();
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
]]></script>
  </xsl:template>
  <!-- ***************************************************************************
  ******************************************************************************* -->
</xsl:stylesheet>

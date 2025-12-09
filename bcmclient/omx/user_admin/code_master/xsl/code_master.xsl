<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:import href="../../../../bcm/framework/queryform/xsl/searchformfilter.xsl"/>

  <xsl:output method="html"/>


  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">

    <xsl:call-template name="include_javascript_code_master"/>

     <xsl:apply-templates select="RESPONSE/CONTAINER">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>
    <script>
        function onLoad()
        {
          //alert("in search load");
          requiredFieldCheck('onLoad');
          
      var table_id = 'result_form_table';
      var width = document.body.offsetWidth - 30;
      var height = document.body.offsetHeight - 420;
      // resize table   approx
      i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null)
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
            /*
            var js = target.toString();
            eval(js);
            */
          }
        }
    </script>
  </xsl:template>

  <!-- Container Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match = "RESPONSE" mode="container_content">

    <!-- Search -->
    <xsl:apply-templates select="SEARCH">
      <xsl:with-param name="formName" select="'result_form'"/>
    </xsl:apply-templates>

  </xsl:template>

 <!-- Add New Form -->
 <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template name="add_new_form">
   <xsl:variable name="code_type">
   	<xsl:value-of select="FORM/FIELD[@Name = 'TYPE_ID' and position() = 1 ]/@Value"/>
   </xsl:variable>
   
    <xsl:variable name="title">
    <i18n:text>Add New</i18n:text>&#xA0;&#xA0;<i18n:text><xsl:value-of select="$code_type"/></i18n:text>
    </xsl:variable>
    <xsl:call-template name="display_instruction_area"/>
    <table  width="100%" cellspacing="1" cellpadding="0" border="0">
      <form name="add_new_form" method="POST">
        <tr>
          <td>
            <i2:container inner="yes" scrollable="yes" title="{$title}">

            <table cellpadding="0" cellspacing="0" width="100%">
              <tr><td><table widht="100%">
                <input type="hidden" name="TYPE_ID" value="{../TYPE_ID/@Value}"/>
                <tr>
                  <td><i18n:text>Name</i18n:text>:<xsl:call-template name="display_alert_mark"/></td>
                  <td>
                    <input type="Text" name="VALUE_ID" class="inputfieldIE" value="{../ERROR_VALUE_ID/@Value}"/>
                  </td>
                </tr>
                <tr>
                  <td><i18n:text>Description</i18n:text>:<xsl:call-template name="display_alert_mark"/></td>
                  <td>
                    <input type="Text" name="DESCRIPTION" class="inputfieldIE" value="{../ERROR_DESCRIPTION/@Value}"/>
                  </td>
                </tr> 
                <xsl:apply-templates select="FORM/FIELD[@Name = 'PARENT_ID']"/>
              </table></td></tr>
            </table>



              <i2:footer>
                <table cellspacing="0" cellpadding="0" width="100%"  border="0">
                  <tr>
                    <td  align="right">
                        <xsl:call-template name="mdmButton">
                            <xsl:with-param name="onclick" select="'javascript:addCodeMasterValue();'"/>
                            <xsl:with-param name="text" select="'Add'"/>
                            <xsl:with-param name="name" select="'AddNew'"/>
                            <xsl:with-param name="target" select="'appFrame'"/>
                        </xsl:call-template>
                    
                      <!--i2:button ame="AddNew" target="appFrame" onclick="javascript:addCodeMasterValue()">&#xA0;<i18n:text>Add</i18n:text>&#xA0;</i2:button-->
                    </td>
                  </tr>

                </table>

              </i2:footer>
            </i2:container>
          </td>
        </tr>
      </form>
    </table>
  </xsl:template>

 <!-- Form instruction -->
 <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="FORM" mode="instruction_area">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="instructionArea">
          <xsl:choose>
              <xsl:when test="string-length(/RESPONSES/RESPONSE/ERROR_MESSAGE/@Value) > 0">
                      <xsl:for-each select="/RESPONSES/RESPONSE/ERROR_MESSAGE">
                        <tr>
                    <td align="middle" valign="middle" width="5%">
                <i2:img src="/alert_static.gif" alt="Error" border="0" align="middle"/>
              </td>
              <td align="left" width="100%">
                            <i18n:text><xsl:value-of select="@Value"/></i18n:text>
                          </td>
                        </tr>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when test="string-length(/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value) > 0">
                        <tr>
              <td align="middle" valign="middle" width="5%">
                <i2:img src="/alert_green_static.gif" alt="Success" border="0" align="middle"/>
              </td>
              <td align="left" width="100%">
                    <i18n:text><xsl:value-of select="/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value"/></i18n:text>
                        </td>
                        </tr>
                </xsl:when>
                <xsl:when test="/RESPONSES/RESPONSE/IS_EDITABLE = 'true'">
                        <tr>
              <td align="left" width="100%">
                <font color="red">*</font>&#xA0;
                <i18n:text>denotes required field</i18n:text>
              </td>
                        </tr>
                </xsl:when>
            </xsl:choose>
    </table>
  </xsl:template>

  <!-- Current.xsl Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="include_javascript_code_master">
    <i2:javascript path="js/code_master.js"></i2:javascript>
  </xsl:template>

<!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="SEARCH">
    <xsl:param name="formName"/>
    <!-- Search Form -->
    <xsl:apply-templates select="FORM"/>
    <xsl:variable name="noOfColumns">
      <xsl:value-of select="round(REPORT/@NoOfColumns)"/>
    </xsl:variable>
    <xsl:variable name="noOfRows">
      <xsl:value-of select="round(REPORT/@NoOfRows)"/>
    </xsl:variable>
    <xsl:variable name="totalRecordCount">
      <xsl:choose>
        <xsl:when test="REPORT/@TotalRecordCount">
          <xsl:value-of select="round(REPORT/@TotalRecordCount)"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="startAtRow">
      <xsl:value-of select="REPORT/@StartAtRow"/>
    </xsl:variable>
    <xsl:variable name="maxRows">
      <xsl:value-of select="REPORT/@MaxRows"/>
    </xsl:variable>
    <script>
         var resultFormName = "<xsl:value-of select="$formName"/>";
         var max_rows = "<xsl:value-of select="$maxRows"/>";
         
         <!-- ISSUE  450119 -->
        var totalRecordCount;
        var startAtRow;
        var confirmMesg;
     <xsl:choose>
        <xsl:when test="REPORT/@StartAtRow">
        totalRecordCount = "<xsl:value-of select="round(REPORT/@TotalRecordCount)"/>";
        startAtRow = "<xsl:value-of select="REPORT/@StartAtRow"/>";
        confirmMesg = "Do you want to update all searched records ("+<xsl:value-of select="round(REPORT/@TotalRecordCount)"/>+")?";
      </xsl:when>
        <xsl:otherwise>
        totalRecordCount = 0;
        startAtRow = 0;
      </xsl:otherwise>
      </xsl:choose>
     <!-- system properties for mass edit -->
     var updateAll;
     var warnThreshold;
     var exceptionThreshold;
     <xsl:if test="/RESPONSES/RESPONSE/SYSTEM_PROPERTIES/updateAll/@Value">
      updateAll = <xsl:value-of select="/RESPONSES/RESPONSE/SYSTEM_PROPERTIES/updateAll/@Value"/> ;
      </xsl:if>
      <xsl:if test="/RESPONSES/RESPONSE/SYSTEM_PROPERTIES/warnThreshold/@Value">
     warnThreshold = <xsl:value-of select="/RESPONSES/RESPONSE/SYSTEM_PROPERTIES/warnThreshold/@Value"/> ;
     </xsl:if>
     <xsl:if test="/RESPONSES/RESPONSE/SYSTEM_PROPERTIES/exceptionThreshold/@Value">
     exceptionThreshold = <xsl:value-of select="/RESPONSES/RESPONSE/SYSTEM_PROPERTIES/exceptionThreshold/@Value"/> ;
     </xsl:if>
     <!-- END ISSUE  450119 -->
        function unCheckSelectAllRow()
        {
                 document.forms[resultFormName].SELECT_ALL.checked = false;
         }

     <![CDATA[
      function unCheckSelectAllRow()
      {
          document.forms[resultFormName].SELECT_ALL.checked = false;
      }
      function onClearGlobal(form)
      {
            clearFields(form);
            form.target="appFrame";
            form.action=omxContextPath + "/bcm/framework/filter/controller/clearFilter.cmd";
            form.submit();
      }
      function onFilterGlobal()
      {

            //alert("resultFormName=" + resultFormName);
            var numberOfForms = document.forms.length ;
            //alert("Number of forms = " + numberOfForms);
            var resultForm;
            for (formCount=0;formCount<numberOfForms;formCount++)
            {
                var currentForm=document.forms[formCount];
                var currentFormName =  currentForm.name;
                //alert("currentForm=" + currentForm + " and currentFormName=" + currentFormName ) ;
                if ( currentFormName == resultFormName )
                  {
                     //alert("got the result form ");
                     resultForm =   currentForm ;
                     break;
                   }
            }
            resultForm.target="appFrame";
            resultForm.action=omxContextPath + "/bcm/framework/filter/controller/display.cmd";
            resultForm.submit();
      }
    function onSaveFilterGlobal()
      {
            //alert("resultFormName=" + resultFormName);
            var numberOfForms = document.forms.length ;
            //alert("Number of forms = " + numberOfForms);
            var resultForm;
            for (formCount=0;formCount<numberOfForms;formCount++)
            {
                var currentForm=document.forms[formCount];
                var currentFormName =  currentForm.name;
                //alert("currentForm=" + currentForm + " and currentFormName=" + currentFormName ) ;
                if ( currentFormName == resultFormName )
                  {
                     //alert("got the result form ");
                     resultForm =   currentForm ;
                     break;
                   }
            }

            if( document.filter_form.FILTER_NAME.value == "" )
            {
              core_alert("Please specify a name for filter");
              return;
            }

            resultForm.FILTER_NAME.value =  document.filter_form.FILTER_NAME.value;

            if (document.filter_form.FILTER_SCOPE  &&  document.filter_form.FILTER_SCOPE.checked)
              {
                resultForm.FILTER_SCOPE.value =  'GLOBAL';
               }
            else
                resultForm.FILTER_SCOPE.value = 'LOCAL';

            resultForm.target="appFrame";
            resultForm.action=omxContextPath + "/bcm/framework/filter/controller/saveFilter.cmd";
            resultForm.submit();

      }

      function clearDateFields(form){}

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
       }
  //ISSUE  450119
  function dispatchMassUpdate()
  {
    //disableUnUsedFilterElements();
    //var temp =  "document." + resultFormName;
    var formObjects = eval("document." + resultFormName);

    if( ifAllChecked(resultFormName))
    {
        if(updateAll == 'false')
        {
          //document.result_form.UPDATE_ALL.value = 'NO';
          formObjects.UPDATE_ALL.value = 'NO';
          massUpdate();
        }
        else
        {
          if(totalRecordCount >= warnThreshold)
          {
            if(totalRecordCount >= exceptionThreshold)
            {
              core_alert("Total number of selected records exceeding the Exception Threshold! Please narrow down your search criteria.");
              return;
            }
            else
            {
              if(core_confirm(confirmMesg ) == 'yes')
              {
                //document.result_form.UPDATE_ALL.value = 'YES';
                formObjects.UPDATE_ALL.value = 'YES';
                massUpdate();
              }
              else
              {
                //document.result_form.UPDATE_ALL.value = 'NO';
                formObjects.UPDATE_ALL.value = 'NO';
                massUpdate();
              }
            }
          }
          else
          {
            //submit without warning
            //document.result_form.UPDATE_ALL.value = 'YES';
            formObjects.UPDATE_ALL.value = 'YES';
            massUpdate();
          }
        }
      }
      else
      {
        if(checkifAnySelected(formObjects))
        {
          //document.result_form.UPDATE_ALL.value = 'NO';
          formObjects.UPDATE_ALL.value = 'NO';
          massUpdate();
        }
        else
        {
        core_alert("Please select a row to update.");
        }
    }
    return;
  }

  // checks if all check box is selected
function ifAllChecked(form)
{
    var count;
    var numOfChecked = 0;
    var temp =  "document." + form + ".elements.length" ;
    var elementsLen = eval(temp);
    var foundChecked = false;

    for(count = 0; count < elementsLen; count++)
        {
            var type = "document."+ form + ".elements[" + count + "].type";
            type = eval(type);
            var checked = "document."+ form + ".elements[" + count + "].checked";
            checked = eval(checked);
            //alert("type = " + type + " checked = " + checked);
            if(type == "checkbox" && checked == true )
               {
                 numOfChecked++;

               }
        }
        //alert("totalRecordCount = " + totalRecordCount  + " startAtRow = "+startAtRow);
    if(numOfChecked == 11 || numOfChecked >  totalRecordCount - startAtRow)
     foundChecked = true;
    //alert("numOfChecked" + numOfChecked)
    return foundChecked;
}
//END ISSUE  450119

    ]]></script>
    <!--
    noOfColumns=<xsl:value-of select="$noOfColumns"/>+
    noOfRows=<xsl:value-of select="$noOfRows"/>+
    totalRecordCount=<xsl:value-of select="$totalRecordCount"/>+
    startAtRow=<xsl:value-of select="$startAtRow"/>+
    maxRows=<xsl:value-of select="$maxRows"/>+
  -->
    <!-- Javascript -->
    <xsl:call-template name="include_javascript_search"/>
    <xsl:call-template name="include_javascript_search_containers_resize"/>
    <!-- Add New Form -->
    <xsl:if test="(REPORT/TABLE/@DoSearch = 'Yes' or REPORT/TABLE/@DoSearch = 'yes') and (FORM/FIELD[@Name = 'IS_EDITABLE']/@Value = 'true')">
      <xsl:call-template name="add_new_form"/>
    </xsl:if>
    <!-- Search Error -->
    <xsl:apply-templates select="REPORT/_ERROR"/>
    <!-- Table Editor Search Report -->
    <xsl:choose>
      <xsl:when test="REPORT/TABLE/@ShowMoveUpDown">
        <xsl:apply-templates select="REPORT/TABLE" mode="moveupdown">
          <xsl:with-param name="formName" select="$formName"/>
          <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
          <xsl:with-param name="noOfRows" select="$noOfRows"/>
          <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
          <xsl:with-param name="startAtRow" select="$startAtRow"/>
          <xsl:with-param name="maxRows" select="$maxRows"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="REPORT/TABLE">
          <xsl:with-param name="formName" select="$formName"/>
          <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
          <xsl:with-param name="noOfRows" select="$noOfRows"/>
          <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
          <xsl:with-param name="startAtRow" select="$startAtRow"/>
          <xsl:with-param name="maxRows" select="$maxRows"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

   <!-- Editable - Text -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="TD[ (@Type = 'Text') and (@Editable)]" mode="content">
    <xsl:param name="validate"/>
    <xsl:variable name="i18nizeVal"><i18n:text><xsl:value-of select="@Value"/></i18n:text></xsl:variable>
    <td align="left" nowrap="yes">
      <xsl:choose>
        <xsl:when test="$validate='yes' and @Required = 'yes' ">
          <input fieldtype="text" name="{@Name}" value="{$i18nizeVal}" required="true" tabIndex="" type="field" class="inputfieldIE" size="50"/>
        </xsl:when>
        <xsl:otherwise>
          <input fieldtype="text" name="{@Name}" value="{$i18nizeVal}" tabIndex="" type="field" class="inputfieldIE" size="50"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$validate='yes' and @Required = 'yes' ">
        <xsl:call-template name="display_alert_image">
          <xsl:with-param name="fieldName" select="@Name"/>
        </xsl:call-template>
      </xsl:if>
    </td>
  </xsl:template>
 <!-- **********************************************************************
  *********************************************************************** -->
</xsl:stylesheet>
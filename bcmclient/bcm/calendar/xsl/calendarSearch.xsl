<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">  
  
  <xsl:import href="../../framework/queryform/xsl/searchformfilter.xsl"/>
  <xsl:import href="../../context/xsl/context_header.xsl"/>
  <xsl:output method="html"/>
   
  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">
     <xsl:if test="RESPONSE/HEADER_CONTEXT/RESOURCE or RESPONSE/HEADER_CONTEXT/LOCATION or RESPONSE/HEADER_CONTEXT/DL ">
      <xsl:apply-templates select="RESPONSE/HEADER_CONTEXT"/>
     </xsl:if>
     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>
     <xsl:call-template name="include_javascript_calendar"/>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
   <xsl:template match = "RESPONSE" mode="container_content">
     <xsl:if test="string-length(ERROR_MESSAGE/@Value) > 0 or  string-length(SUCCESS_MESSAGE/@Value) > 0 ">
        <xsl:call-template name="display_instruction_area"/>
     </xsl:if>
     <xsl:apply-templates select="SEARCH">
       <xsl:with-param name="formName" select="'result_form'"/>
     </xsl:apply-templates>
  </xsl:template>

<!-- custom javascript -->
 <!-- **********************************************************************
   *********************************************************************** -->
   <xsl:template name="onLoad_js">
     function onLoad()
     {
       resize_Containers();
       <xsl:if test="string-length(/RESPONSES/RESPONSE/ERROR_MESSAGE/@Value) > 0 or  string-length(/RESPONSES/RESPONSE/SUCCESS_MESSAGE/@Value) > 0 ">
           requiredFieldCheck('onLoad');
       </xsl:if>
     }
   </xsl:template>

   <xsl:template name="onResize_js">
     function onResize()
     {
       resize_Containers();
     }
   </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_calendar">
  <script>

      var context =
      "<xsl:choose>
         <xsl:when test="/RESPONSES/RESPONSE/HEADER_CONTEXT/RESOURCE">RESOURCE</xsl:when>
         <xsl:when test="/RESPONSES/RESPONSE/HEADER_CONTEXT/LOCATION">LOCATION</xsl:when>
          <xsl:when test="/RESPONSES/RESPONSE/HEADER_CONTEXT/DL">DL</xsl:when>
      </xsl:choose>";

    function IEEnterKey()
      {
          if(window.event.keyCode == 13)
              {
                  SetfocusSubmit(window.event.srcElement)
                      event.returnValue=false;
              }
      } 
      //issue 468436
      function SetfocusSubmit( target )
      {
            if(  context == 'RESOURCE' )
                onSelectResourceCalendar();
            else if (context == 'LOCATION')
                onSelectLocationCalendar();
            else if (context == 'DL')
              onSelectDLCalendar();
            else if(target.name == 'pagenum')
            {
              getRecords('jump');
            }
            else
              dispatchSearch();
      }
     
      /*
      function SetfocusSubmit( target )
      {
            if(  context == 'RESOURCE' )
                onSelectResourceCalendar();
            else if (context == 'LOCATION')
                onSelectLocationCalendar();
            else if (context == 'DL')
              onSelectDLCalendar();
            else
              dispatchSearch();
      }
      */
       //end issue 468436
     function onReturnToContext()

      {
                document.result_form.action="search/controller/returnToContext.cmd";
                document.result_form.submit();
      }
       function onSelectResourceCalendar()
      {
                //alert("onSelectResourceCalendar");
          if ( checkifAnySelected(result_form) == true )
            {
                document.result_form.target="appFrame";
                document.result_form.method="post";
                document.result_form.action="search/controller/addCalendarToResource.cmd";
                document.result_form.submit();
            }
            else
           {
                core_alert("<i18n:text>SEL_ONE_CAL</i18n:text>");
            }

      }
     function onSelectLocationCalendar()
      {
                //alert("onSelectLocationCalendar");
          if ( checkifAnySelected(result_form) == true )
            {
                document.result_form.target="appFrame";
                document.result_form.method="post";
                document.result_form.action="search/controller/addCalendarToLocation.cmd";
                document.result_form.submit();
            }
            else
           {
                core_alert("<i18n:text>SEL_ONE_CAL</i18n:text>");
            }
      }
       function onSelectDLCalendar()
      {
           if (checkifAnySelected(document.result_form))
            {
                document.result_form.target="appFrame";
                document.result_form.method="post";
                document.result_form.action="search/controller/addCalendarToDL.cmd";
                document.result_form.submit();
                }
            else
           {
                core_alert("<i18n:text>SEL_ONE_CAL</i18n:text>");
            }

      }
      function onClear()
      {

              clearFields(document.forms.result_form);
      }
    function saveReport()
    {
      document.result_form.action='search/controller/exportToExcel.cmd';
      document.result_form.submit();
    }

 <![CDATA[
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
             if( form.elements[count].type == "select-one" ){
                  form.elements[count].selectedIndex = 0;
               }
              if( form.elements[count].type == "text" ){
                  form.elements[count].value = '';
               }
            }
            dispatchSearch();
       } 
        <!--EQ:572762 -->
       function getSelectedRowIndices()
       {
           var checkboxes;
           var selectedIds=[];
           var checkedRowIndex = 0;
           checkboxes = document.getElementsByTagName("INPUT");
           if (checkboxes != null)
           {
              var len = checkboxes.length;
              var rowNum = 0; // Fix for issue - 572762
              for(var i=0; i<len; i++)
              {
                if (checkboxes[i].id.indexOf("_rowselector") >= 0 )
                        {
                            if (checkboxes[i].checked)
                            {
                                selectedIds[checkedRowIndex] = rowNum;
                                checkedRowIndex++;
                            }
                            var rowNum = rowNum + 1;
                        }
              }
           }
        return selectedIds; 
        }
         <!--EQ:572762 -->
       

  ]]>
      function onCreate()
      {
                //alert("Create");
                document.result_form.action="search/controller/createCalendar.cmd";
                document.result_form.submit();
      }
       function onDelete()
      {
        
        <!-- var confirmMesg = "<i18n:text>CAL_REMOVE</i18n:text>" -->
        
        <!-- ISSUE ID : 533404 -->
        var confirmMesg = "CAL_REMOVE"
        <!-- ISSUE ID : 533404 -->

         if ( checkifAnySelected(result_form) == true )
            {
             if( core_confirm( confirmMesg ) == 'yes' )
               {
                document.result_form.START_COUNT.value = 0 ;
                document.result_form.action="search/controller/deleteCalendar.cmd";
                document.result_form.submit();
               }
             }
          else
           {
                
        <!-- core_alert("<i18n:text>SEL_ONE_CAL</i18n:text>"); -->
        
        <!-- ISSUE NO : 533399 -->
             core_alert("SEL_ONE_CAL");
                <!-- ISSUE NO : 533399 -->
            }
      }
       function onChangeCalendarType()
      {
                //alert("onChangeCalendarType");
                dispatchSearch();

      }
    function resize_Containers()
    {

      //i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight - 200, null, document.body.offsetWidth - 20, true, 'yes');
      resizeScrollableTables(); 
    }
    

  </script>
  </xsl:template>
</xsl:stylesheet>

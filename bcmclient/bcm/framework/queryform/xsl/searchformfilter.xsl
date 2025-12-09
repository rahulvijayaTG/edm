<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../xsl/form.xsl"/>
  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../bcm/framework/xsl/core_container_override.xsl"/>
  <xsl:import href="../../xsl/pagingControl2.xsl"/>
  <xsl:import href="dbformfilter.xsl"/>
  <xsl:import href="../../xsl/buttons.xsl"/>
  <xsl:import href="../../../../core/xsl/links.xsl"/>
  <xsl:output method="html"/>
  <!-- **********************************************************************
     *********************************************************************** -->
    <xsl:variable name = "overridden">
          <xsl:choose>
              <xsl:when test="/RESPONSES/RESPONSE//*/REPORT/TABLE/@Overridden">
                <xsl:value-of select="/RESPONSES/RESPONSE//*/REPORT/TABLE/@Overridden"/>
              </xsl:when>
              <xsl:otherwise>yes</xsl:otherwise>
          </xsl:choose>
    </xsl:variable>
    <xsl:variable name = "moveUpDown">
          <xsl:choose>
              <xsl:when test="/RESPONSES/RESPONSE//*/REPORT/TABLE/@ShowMoveUpDown">
                <xsl:value-of select="/RESPONSES/RESPONSE//*/REPORT/TABLE/@ShowMoveUpDown"/>
              </xsl:when>
              <xsl:otherwise>yes</xsl:otherwise>
          </xsl:choose>
    </xsl:variable>

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
        var form;
      
      <xsl:choose>
        <xsl:when test="FORM">
            function form_sortOrder(order)
            {
                form = document.search_form;
                form.SORT_BY.value=form.SELECTED_COLUMN.value;
                form.SORT_ORDER.value=order;
                form.DO_SEARCH.value='yes';
                if (form.START_COUNT)
                 form.START_COUNT.value=0;
                form.submit();
            }
            function form_hideIt()
            {
                var noOfColumns = form.COLUMN_COUNT.value;
                if (parseInt(noOfColumns) &lt; 2)
                {
                    core_alert("CANNOT_HIDE_ONLY_COLUMN");
                    return;
                }

                     form = document.search_form;
                form.HIDDEN_COLUMN.value=form.SELECTED_COLUMN.value;
                form.DO_SEARCH.value='Yes';
                form.submit();
            }
            function form_showAll()
            {
                form = document.search_form;
                form.HIDDEN_COLUMN.value='None';
                form.DO_SEARCH.value='Yes';
                //form.START_COUNT.value=0;
                form.submit();
            } 
            
            function form_freeze()
            {
                form = document.search_form;
                form.FROZEN_COLUMN.value=form.SELECTED_COLUMN.value;
                form.FROZEN_SEQUENCE.value=parseInt(form.COLUMN_SEQUENCE.value)+1;
                form.DO_SEARCH.value='Yes';
                //form.START_COUNT.value=0;
                //form.USE_OLD_FILTER.value='YES';
                form.submit();
            }
            function form_unfreeze()
            {
                form = document.search_form;
                if (form == null)
                 form = document.result_form;
                form.FROZEN_COLUMN.value='None';
                form.FROZEN_SEQUENCE.value=-999;
                form.DO_SEARCH.value='Yes';
                //form.USE_OLD_FILTER.value='YES';
                //form.START_COUNT.value=0;
                form.submit();
            }
            
            function sort(value, sequence, isSortable, isFrozenAllowed, form_name, noOfColumns)
            {
                form = document.search_form;
                form.SELECTED_COLUMN.value=value;
                form.COLUMN_SEQUENCE.value=sequence;
                form.COLUMN_COUNT.value=noOfColumns;    
                if (isSortable == 'yes')
                {
                    if (isFrozenAllowed == 'yes')
                    {
                        i2uiShowMenu('sortOrder');
                    }
                    else
                    {
                        i2uiShowMenu('sortOrder_noFreeze');     
                    }

                }
                else
                {
                    if (isFrozenAllowed == 'yes')
                    {
                        i2uiShowMenu('editorMenu');     

                    }
                    else
                    {
                        i2uiShowMenu('editorMenu_noFreeze');        

                    }

                }
            }
            
            
        </xsl:when>
        <xsl:otherwise>
            function form_sortOrder(order)
            {
                form = document.result_form;
                form.SORT_BY.value=form.SELECTED_COLUMN.value;
                form.SORT_ORDER.value=order;
                form.DO_SEARCH.value='yes';
                if (form.START_COUNT)
                 form.START_COUNT.value=0;
                form.submit();
            }
            function form_hideIt()
            {
                var noOfColumns = form.COLUMN_COUNT.value;
                if (parseInt(noOfColumns) &lt; 2)
                {
                    core_alert("CANNOT_HIDE_ONLY_COLUMN");
                    return;
                }

                     form = document.result_form;
                form.HIDDEN_COLUMN.value=form.SELECTED_COLUMN.value;
                form.DO_SEARCH.value='Yes';
                form.submit();
            }
            function form_showAll()
            {
                form = document.result_form;
                form.HIDDEN_COLUMN.value='None';
                form.DO_SEARCH.value='Yes';
                //form.START_COUNT.value=0;
                form.submit();
            }            
            function form_freeze()
            {
                form = document.result_form;

                form.FROZEN_COLUMN.value=form.SELECTED_COLUMN.value;
                form.FROZEN_SEQUENCE.value=parseInt(form.COLUMN_SEQUENCE.value)+1;
                form.DO_SEARCH.value='Yes';
                //form.START_COUNT.value=0;
                form.USE_OLD_FILTER.value='YES';
                form.submit();
            }
            function form_unfreeze()
            {
                form = document.result_form;
                form.FROZEN_COLUMN.value='None';
                form.FROZEN_SEQUENCE.value=-999;
                form.DO_SEARCH.value='Yes';
                form.USE_OLD_FILTER.value='YES';
                //form.START_COUNT.value=0;
                form.submit();
            }
            function sort(value, sequence, isSortable, isFrozenAllowed, form_name, noOfColumns)
            {
                form = document.result_form;
                form.SELECTED_COLUMN.value=value;
                form.COLUMN_SEQUENCE.value=sequence;
                form.COLUMN_COUNT.value=noOfColumns;    
                if (isSortable == 'yes')
                {
                    if (isFrozenAllowed == 'yes')
                    {
                        i2uiShowMenu('sortOrder');
                    }
                    else
                    {
                        i2uiShowMenu('sortOrder_noFreeze');     
                    }

                }
                else
                {
                    if (isFrozenAllowed == 'yes')
                    {
                        i2uiShowMenu('editorMenu');     

                    }
                    else
                    {
                        i2uiShowMenu('editorMenu_noFreeze');        

                    }

                }
            }
            
        </xsl:otherwise>
      </xsl:choose>
     <xsl:choose>
        <xsl:when test="REPORT/@StartAtRow">
        totalRecordCount = "<xsl:value-of select="round(REPORT/@TotalRecordCount)"/>";
        startAtRow = "<xsl:value-of select="REPORT/@StartAtRow"/>";
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
     var exportToExcelThreshold;
      <xsl:if test="SYSTEM_PROPERTIES/updateAll/@Value">
        updateAll = <xsl:value-of select="SYSTEM_PROPERTIES/updateAll/@Value"/> ;
      </xsl:if>
      <xsl:if test="SYSTEM_PROPERTIES/warnThreshold/@Value">
        warnThreshold = <xsl:value-of select="SYSTEM_PROPERTIES/warnThreshold/@Value"/> ;
     </xsl:if>
      <xsl:if test="SYSTEM_PROPERTIES/exceptionThreshold/@Value">
        exceptionThreshold = <xsl:value-of select="SYSTEM_PROPERTIES/exceptionThreshold/@Value"/> ;
     </xsl:if>
      <xsl:if test="SYSTEM_PROPERTIES/exportToExcelThreshold/@Value">
        exportToExcelThreshold = <xsl:value-of select="SYSTEM_PROPERTIES/exportToExcelThreshold/@Value"/> ;
     </xsl:if>

     var confirmMesg = "ALL_RECS_UPD";
     var exportMesg = "ALL_RECS_EXPORT";
     var exportMesgRadio = "ALL_RECS_SELECTED_UPD";

     
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
       
      function onCustomizeGlobal()
      {
       //alert("hello");
                  var numberOfForms = document.forms.length ;
                 // alert("Number of forms = " + numberOfForms);
                  var resultForm;
                  for (formCount=0;formCount<numberOfForms;formCount++)
                  {
                      var currentForm=document.forms[formCount];
                      var currentFormName =  currentForm.name;
                     // alert("currentForm=" + currentForm + " and currentFormName=" + currentFormName ) ;
                      if ( currentFormName == resultFormName )
                        {
                         //  alert("got the result form ");
                           resultForm =   currentForm ;
                           break;
                         }
                  }
                  resultForm.target="appFrame";
                  resultForm.action=omxContextPath + "/bcm/framework/customize/customize.jsp";
            resultForm.submit();
      
      
      }

      function onCreateFavorite()
      {
              var numberOfForms = document.forms.length ;
              var resultForm;
              for (formCount=0;formCount<numberOfForms;formCount++)
              {
                  var currentForm=document.forms[formCount];
                  var currentFormName =  currentForm.name;
                  if ( currentFormName == resultFormName )
                    {
                       resultForm =   currentForm ;
                       break;
                     }
              }
            result_form.target="appFrame";
            result_form.action=omxContextPath+ "/bcm/framework/favorites/createFavorite.jsp";
            result_form.submit();
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
            ]]>
              core_alert("<i18n:text>FILTER_NAME_ALERT</i18n:text>");
              <![CDATA[
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
     var count = countSelectedRecords(); 
     var formObjects = eval("document." + resultFormName);
    
    	if( ifAllChecked(resultFormName))
 	   {		 
			 if(updateAll == 'false')
			 {
	 		   formObjects.UPDATE_ALL.value = 'NO';
			   groupEditSelected();
			 }
			
			 else if (parseInt(totalRecordCount) <= parseInt(max_rows))
			  {     
			    groupEditSelected ();     
			  }

			  else{
         		          if(core_confirm("Do you want to update all the records ({0}) in the table? If you select 'No', only the records displayed in the current page will be updated.",totalRecordCount,max_rows) == 'yes' )
         		          {
	 				if(parseInt(totalRecordCount) >= parseInt(exceptionThreshold)) 
         				    {
         					   core_alert("EXCEPTION_THRESHOLD_WARNING");
						   return;
         				    }
					   else if(parseInt(totalRecordCount) >= parseInt(warnThreshold))
					   {
						core_alert("WARNING_THRESHOLD_ALERT");
						formObjects.UPDATE_ALL.value = 'YES';
         					groupEditAll();
					   }
					   else
         				    {
	 				        formObjects.UPDATE_ALL.value = 'YES';
         					groupEditAll();
         				    }
         			  }
         			  else
         			  {
         			     formObjects.UPDATE_ALL.value = 'NO';
				     groupEditSelected();
         			  }
			    }
      	 }
       else //if all are not checked
       {
         if(checkifAnySelected(formObjects))
         {
           core_alert("You are going to update ({0}) records",count);
           formObjects.UPDATE_ALL.value = 'NO';
           groupEditSelected();
         }
         else
         {
         ]]>         
         core_alert("<i18n:text>UPDATE_ROW</i18n:text>");
         <![CDATA[
         }
     }
     return;
  }
  
  // checks if all check box is selected
 /* 
function ifAllChecked(form)
{
    var count;
    var numOfChecked = 0;
    var max_recored = max_rows + 1;
    var temp =  "document." + form + ".elements.length" ;
    var elementsLen = eval(temp);
    var foundChecked = false;
 
    for(count = 0; count < elementsLen; count++)
        {
            var type = "document."+ form + ".elements[" + count + "].type";
            type = eval(type);
            var checked = "document."+ form + ".elements[" + count + "].checked";
            checked = eval(checked);
            if(type == "checkbox" && checked == true )
               {
                 numOfChecked++;

               }
        }
   if(numOfChecked == max_recored || numOfChecked >  totalRecordCount - startAtRow)
     foundChecked = true;
    return foundChecked; 
}
*/
//END ISSUE  450119

  // checks if all check box is selected
function ifOneChecked(form)
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
                if(numOfChecked > 1)
                {
                  foundChecked=false;
                  break;
                }
                else
                {
                  foundChecked=true;
                }
               }
        }
    return foundChecked;
}

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
  <xsl:template match="STEP" mode="header">
    <!-- Header/Help -->
    <i2:header>
      <table border="0" cellpadding="2" cellspacing="0" width="100%">
        <tr>
          <td align="right">
            <table border="0" cellpadding="0" cellspacing="0" align="right">
              <tr>
                <xsl:choose>
                  <!-- All tabs header -->
                  <xsl:when test="HEADER/LINK">
                    <xsl:apply-templates select="HEADER/LINK"/>
                  </xsl:when>
                </xsl:choose>
                <xsl:if test="../EXPRESSION_FILTER/@Value = 'yes' ">
                  <td>
                    <table border="0" id="filter_table" cellpadding="0" cellspacing="0">
                      <form name="filter_form" method="post">
                        <input type="hidden" name="FILTER_TEXT" value="{/RESPONSES/RESPONSE/FILTER_TEXT[1]/@Value}"/>
                        <input type="hidden" name="FILTER_ID" value="{/RESPONSES/RESPONSE/FILTER_ID[1]/@Value}"/>
                        <input type="hidden" name="FILTER_MODE" value="{/RESPONSES/RESPONSE/FILTER_MODE[1]/@Value}"/>
                        <input type="hidden" name="PAGE" value="{/RESPONSES/RESPONSE/PAGE[1]/@Value}"/>
                        <xsl:choose>
                          <xsl:when test="/RESPONSES/RESPONSE/HEADER/HEADING3">
                            <input type="hidden" name="PAGE_HEADING" value="{/RESPONSES/RESPONSE/HEADER/HEADING3/@Value}"/>
                          </xsl:when>
                          <xsl:when test="/RESPONSES/RESPONSE/HEADER/HEADING2">
                            <input type="hidden" name="PAGE_HEADING" value="{/RESPONSES/RESPONSE/HEADER/HEADING2/@Value}"/>
                          </xsl:when>
                          <xsl:when test="/RESPONSES/RESPONSE/HEADER/HEADING">
                            <input type="hidden" name="PAGE_HEADING" value="{/RESPONSES/RESPONSE/HEADER/HEADING/@Value}"/>
                          </xsl:when>
                        </xsl:choose>
                        <input type="hidden" name="FORM_NAME" value="{/RESPONSES/RESPONSE/FORM_NAME[1]/@Value}"/>
                        <input type="hidden" name="SERVICE" value="{/RESPONSES/RESPONSE/SERVICE[1]/@Value}"/>
                        <tr>
                          <xsl:choose>
                            <xsl:when test="string-length(/RESPONSES/RESPONSE/FILTER_TEXT[1]/@Value) > 0 ">
                              <xsl:choose>
                                <xsl:when test="/RESPONSES/RESPONSE/FILTER_MODE/@Value = 'EDIT' ">
                                            </xsl:when>
                                <xsl:otherwise>
                                  <TD nowrap="yes">Global&#xA0;<xsl:text>:</xsl:text>&#xA0;
                                                </TD>
                                  <TD nowrap="yes" align="left">
                                    <input type="checkbox" value="GLOBAL" name="FILTER_SCOPE"/>
                                  </TD>
                                </xsl:otherwise>
                              </xsl:choose>
                              <TD nowrap="yes">Filter Name &#xA0;<xsl:text>:</xsl:text>&#xA0;
                                        </TD>
                              <TD nowrap="yes" align="left">
                                <input type="text" value="{/RESPONSES/RESPONSE/FILTER_NAME[1]/@Value}" class="inputFieldIE" required="yes" name="FILTER_NAME" size="10"/>
                              </TD>
                              <TD nowrap="yes">&#xA0;
                                            <a class="text" href="javascript:onSaveFilterGlobal();">
                                  <i2:img src="/btn_saveas_1.gif" border="0" align="middle">
                                    <i2:attribute name="alt">
                                      <i18n:text>Save Filter</i18n:text>
                                    </i2:attribute>
                                  </i2:img>
                                </a>
                              </TD>
                            </xsl:when>
                            <xsl:otherwise>
                              <i2:img src="/btn_saveas_0.gif" border="0" align="middle">
                                <i2:attribute name="alt">
                                  <i18n:text>Save Filter</i18n:text>
                                </i2:attribute>
                              </i2:img>
                            </xsl:otherwise>
                          </xsl:choose>
                        </tr>
                      </form>
                    </table>
                  </td>
                  <td>
                    &#xA0;
                  <a class="text" href="javascript:onFilterGlobal();">
                      <i2:img src="/filter.gif" border="0" align="middle">
                        <i2:attribute name="alt">
                          <i18n:text>Advanced Filter</i18n:text>
                        </i2:attribute>
                      </i2:img>
                    </a>&#xA0;
                </td>
                </xsl:if>
                <xsl:if test="$overridden!='yes'">
                    <td>
                      &#xA0;
                      <a class="text" href="javascript:onCustomizeGlobal();">
                      <xsl:variable name="txtCustomize"><i18n:text>Customize</i18n:text></xsl:variable>
                      <i2:img src="/btn_customize_1.gif" alt="{$txtCustomize}" border="0" align="middle"/>
                      </a>&#xA0;
                    </td>

                    <td>     
                        &#xA0;
                      <a class="text" href="javascript:onCreateFavorite();">
                        <xsl:variable name="txtCreateFav"><i18n:text>Create Favorite</i18n:text></xsl:variable>
                        <i2:img src="/addfav.gif" alt="{$txtCreateFav}" border="0" align="middle"/>
                      </a>&#xA0;
                    </td>  
                </xsl:if>
                <xsl:choose>
                  <!-- Selected tabs help -->
                  <xsl:when test="HELP">
                    <xsl:apply-templates select="HELP"/>
                  </xsl:when>
                  <!-- All tabs help -->
                  <xsl:when test="../HELP">
                    <xsl:apply-templates select="../HELP"/>
                  </xsl:when>
                </xsl:choose>
              </tr>
            </table> 
          </td>
        </tr>
      </table>
    </i2:header>
  </xsl:template>
  <!-- Popup -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="hide_i2uiPopupmenu">
        <i2:popupmenu name="sortOrder">
          <i2:popupmenuoption  url="javascript:form_sortOrder('Ascending')"><i2:attribute name="text"><i18n:text>Ascending</i18n:text></i2:attribute></i2:popupmenuoption>
          <i2:popupmenuoption  url="javascript:form_sortOrder('Descending')"><i2:attribute name="text"><i18n:text>Descending</i18n:text></i2:attribute></i2:popupmenuoption>
          <!--i2:popupmenuoption  url="javascript:form_hideIt()"><i2:attribute name="text"><i18n:text>Hide</i18n:text></i2:attribute></i2:popupmenuoption>
          <i2:popupmenuoption  url="javascript:form_showAll()"><i2:attribute name="text"><i18n:text>Show All</i18n:text></i2:attribute></i2:popupmenuoption-->
          <i2:popupmenuoption  url="javascript:form_unfreeze()"><i2:attribute name="text"><i18n:text>Unfreeze</i18n:text></i2:attribute></i2:popupmenuoption>
          <i2:popupmenuoption  url="javascript:form_freeze()"><i2:attribute name="text"><i18n:text>Freeze</i18n:text></i2:attribute></i2:popupmenuoption>
        </i2:popupmenu>
        <i2:popupmenu name="sortOrder_noFreeze">
          <i2:popupmenuoption  url="javascript:form_sortOrder('Ascending')"><i2:attribute name="text"><i18n:text>Ascending</i18n:text></i2:attribute></i2:popupmenuoption>
          <i2:popupmenuoption  url="javascript:form_sortOrder('Descending')"><i2:attribute name="text"><i18n:text>Descending</i18n:text></i2:attribute></i2:popupmenuoption>
          <!--i2:popupmenuoption  url="javascript:form_hideIt()"><i2:attribute name="text"><i18n:text>Hide</i18n:text></i2:attribute></i2:popupmenuoption>
          <i2:popupmenuoption  url="javascript:form_showAll()"><i2:attribute name="text"><i18n:text>Show All</i18n:text></i2:attribute></i2:popupmenuoption-->
        </i2:popupmenu>
        <i2:popupmenu name="editorMenu">
          <!--i2:popupmenuoption  url="javascript:form_hideIt()"><i2:attribute name="text"><i18n:text>Hide</i18n:text></i2:attribute></i2:popupmenuoption>
          <i2:popupmenuoption  url="javascript:form_showAll()"><i2:attribute name="text"><i18n:text>Show All</i18n:text></i2:attribute></i2:popupmenuoption-->
            <i2:popupmenuoption  url="javascript:form_unfreeze()"><i2:attribute name="text"><i18n:text>Unfreeze</i18n:text></i2:attribute></i2:popupmenuoption>
            <i2:popupmenuoption  url="javascript:form_freeze()"><i2:attribute name="text"><i18n:text>Freeze</i18n:text></i2:attribute></i2:popupmenuoption>
        </i2:popupmenu>
        <i2:popupmenu name="editorMenu_noFreeze">
          <!--i2:popupmenuoption  url="javascript:form_hideIt()"><i2:attribute name="text"><i18n:text>Hide</i18n:text></i2:attribute></i2:popupmenuoption>
          <i2:popupmenuoption  url="javascript:form_showAll()"><i2:attribute name="text"><i18n:text>Show All</i18n:text></i2:attribute></i2:popupmenuoption-->
        </i2:popupmenu>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="dbeditor_i2uiPopupmenu">
    <i2:popupmenu name="editorMenu">
      <!--i2:popupmenuoption url="javascript:hideIt()">
        <i2:attribute name="text">
          <i18n:text>Hide</i18n:text>
        </i2:attribute>
      </i2:popupmenuoption>
      <i2:popupmenuoption url="javascript:showAll()">
        <i2:attribute name="text">
          <i18n:text>Show All</i18n:text>
        </i2:attribute>
      </i2:popupmenuoption-->
    </i2:popupmenu>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_search">
    <script>
         var moveUpDown = "<xsl:value-of select="$moveUpDown"/>";

function jumpToPage(actionName, startCount, result_form, page_form)
{
    //alert("xsl jumpToPage called");
    if (max_rows == null || max_rows == "")
      max_rows = 10;
    var nextCount = parseInt(startCount) + max_rows;
    var prevCount = 0;
    if ( parseInt(startCount) > 0 )
        prevCount = parseInt(startCount) - max_rows;

  if (startCount == null)
      startCount=page_form.pagenum.value;

    var pagenum= parseInt(startCount);  pagenum--;

    if (actionName == "jump")
    {
      if(( page_form.RECORD_COUNT.value == 0 || page_form.RECORD_COUNT.value &gt; pagenum*max_rows)  &amp;&amp; (pagenum+1&gt;0) &amp;&amp; (page_form.START_COUNT.value != pagenum*max_rows))
      {
          //result_form.reset();
          result_form.DO_SEARCH.value='yes';
          result_form.START_COUNT.value=pagenum*max_rows;
          result_form.target="appFrame";
          result_form.method="POST";
          result_form.submit();
        }
        else
  {
    core_alert("PAGINATION_ALERT");
  }
    }
}
  <![CDATA[
  function clearMe(form, elementName)
  {
    var elementsLen = form.elements.length;
    for(count = 0; count < elementsLen; count++)
    {
      if(form.elements[count].name == elementName )
      {
        form.elements[count].value="";
        break;
      }
    }
    dispatchSearch();
}
  function clearNumberFields(form, elementName1, elementName2)
  {
    var elementsLen = form.elements.length;
    for(count = 0; count < elementsLen; count++)
    {
      if(form.elements[count].name.trim() == elementName1.trim() )
      {
        form.elements[count].value="";
      }
      else if (form.elements[count].name.trim() == elementName2.trim() )
      {
      form.elements[count].selectedIndex = -1;
      }
    }
    dispatchSearch();
}


    function trimFilterElements(form)
    {
      if(form == null)
        form = result_form;
      var elements = form.elements;
      var elementCount = elements.length;
      for (var i = 0; i < elementCount; i++) {
        elements[i].value = trimString(elements[i].value);
      }
    }


function clearDateFields(form)
{

}


        function hideIt()
        {
            //alert("hide=" + document.result_form.HIDDEN_COLUMN.value);
            document.result_form.DO_SEARCH.value='no';
            //alert("hide=" + document.result_form.DO_SEARCH.value);
            document.result_form.START_COUNT.value=0;
            document.result_form.submit();
        }
        function showAll()
        {
            document.result_form.HIDDEN_COLUMN.value='None';
            //alert("hide=" + document.result_form.HIDDEN_COLUMN.value);
            document.result_form.DO_SEARCH.value='no';
            //alert("hide=" + document.result_form.DO_SEARCH.value);
            document.result_form.START_COUNT.value=0;
            document.result_form.submit();
        }
        function onSearch()
        {          
          trimFilterElements(search_form);
          document.search_form.DO_SEARCH.value='yes';
          document.search_form.START_COUNT.value=0;
          document.search_form.submit();
        }
      function dispatchSearch()
      {
            //alert("dbformfilter filter it");                        
            trimFilterElements(result_form);
            document.result_form.target="appFrame";
            document.result_form.DO_SEARCH.value='yes';
            document.result_form.START_COUNT.value=0;            
            document.result_form.submit();
      }

    // Scrollable table
    function resizeScrollableTables()
    {
      //This function accepts 2 parameters increaseHeight and increaseWidth. This can be
      //positive or negative number and the height of the tables will be increased or decreased
      //based on that.
      if (!document.layers)
      {
          var arg_val;
          var table_id = 'result_form_table';
          var slave_id = 'result_form_table_slave';
          var width;
          var height;
          var slave_width = 200;
          ]]>
					<xsl:choose>
					<xsl:when test="FORM">
						height = document.body.offsetHeight/3;
					</xsl:when>
					<xsl:otherwise>
						height = (document.body.offsetHeight/2)*3;
					</xsl:otherwise>
					</xsl:choose>
          <![CDATA[
          // resize table   approx
          if (arguments[0] != null && arguments[0] != '')
          {
            height = height + Number(arguments[0]);
            }
            
          if (arguments[1] != null && arguments[1] != '')
          {
            width = width + Number(arguments[1]);
           }
          
          if (moveUpDown == 'yes')  
          {
            width = document.body.offsetWidth - 50;
          }
          else  
          {
            width = document.body.offsetWidth - 35;
          }
          form = document.forms[formName];
          if (form != null)
          {
              if (form.FROZEN_SEQUENCE == null || form.FROZEN_SEQUENCE.value == '' || form.FROZEN_SEQUENCE.value == '-999')
              {
                    i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null);
              }
              else
              {
                      var col = -1;
                      if (form.DISPLAY_COUNT != null && form.DISPLAY_COUNT.value != '' )
                      {
                            col = Number(form.DISPLAY_COUNT.value);
                      }

                      var  seq = Number(form.FROZEN_SEQUENCE.value);

                      if(col!= -1 && seq >= col)
                        {
                                i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null);

                        }
                       else
                       {
                                    i2uiResizeScrollableArea(table_id,height,30,slave_id,20,56,null, null);
                       }

              }
              i2uiResizeScrollableContainer('table_id',40, null, width, true, 'yes');
              i2uiResizeScrollableContainer('button_container',40, null, width + 15, true, 'yes');
              i2uiResizeScrollableContainer('search_form_container',document.body.offsetHeight-50, null, width+15, true, 'yes');      
              i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight - 250 , null, width + 15, true, 'yes');

              var rowselectorobj = document.getElementById("_rowselector_header");
              if (rowselectorobj != null)
                toggleRowSelectionState(rowselectorobj, -1, null, true);
         }      
      }
    }]]>
</script>
  </xsl:template> 
  <!-- Sort Image -->
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:variable name="sortImage">
    <xsl:choose>
      <xsl:when test="/RESPONSES/RESPONSE/SEARCH/REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_ORDER']/@Value = 'Descending'">
        &#xA0;&#xA0;&#xA0;&lt;i2:img src="/ascending_table_column.gif"/&gt;
      </xsl:when>
      <xsl:otherwise>
        &#xA0;&#xA0;&#xA0;&#xA0;&lt;i2:img src="/ascending_table_column.gif"/&gt;
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <!-- Sort By -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:variable name="sortBy">
    <xsl:choose>
      <xsl:when test="string-length(/RESPONSES/RESPONSE//*/SEARCH/REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_BY']/@Value) > 0 ">
        <xsl:value-of select="/RESPONSES/RESPONSE//*/SEARCH/REPORT/TABLE/TR[@Header='yes']/TD[@Name = 'SORT_BY']/@Value"/>
      </xsl:when>
      <xsl:otherwise>ID</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Search Error -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="_ERROR">
    <table width="100%" cellspacing="1" cellpadding="0" border="0">
      <tr>
        <td>
          <!-- Title -->
          <xsl:variable name="title">
            &lt;b&gt;<i18n:text>Search Error</i18n:text>&lt;/b&gt;:&#xA0;&lt;i&gt;<xsl:value-of select="@Description"/>
          </xsl:variable>
          <i2:container inner="yes" title="{$title}">
          </i2:container>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
      //alert("in search load");
      //requiredFieldCheck('onLoad')
      //resize_Containers();
      //setFocus();

      <!--xsl:call-template name="javascript_initTabs"/>
      <xsl:call-template name="javascript_onLoad_page"/-->
      onResize();
    }
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onResize_js">
    function onResize()
    {
      //alert("in search resize");
      resize_Containers();
      <!--xsl:call-template name="javascript_initTabs"/>
      <xsl:call-template name="javascript_onResize_page"/-->
    }
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
  <!-- Javascript -->
  <xsl:template name="include_javascript_search_containers_resize">
    <script><![CDATA[
    function resize_Containers()
    {
     // alert("resize");

      var table_id = 'result_form_table';
      var width = document.body.offsetWidth - 50;
      var height = document.body.scrollHeight - 300;
      // resize table   approx
      i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null);
  }
  ]]></script>
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

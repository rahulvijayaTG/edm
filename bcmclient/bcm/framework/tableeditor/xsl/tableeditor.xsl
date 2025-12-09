<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="searchdb.xsl"/>
   <!-- this will over-ride the core button templete NOTE: keep this import at end -->
  <xsl:import href="../../xsl/core_buttons.xsl"/>
  <xsl:import href="../../xsl/required_field.xsl"/>
  <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
  <xsl:output method="html"/>
  <!-- Page Content -->      
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_variables"/>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <xsl:if test="string-length(ERROR_MESSAGE/@Value) > 0 or string-length(SUCCESS_MESSAGE/@Value) > 0">
      <xsl:call-template name="display_instruction_area"/>
    </xsl:if>
    <xsl:apply-templates select="SEARCH"/>
     <FORM action="newWindow1()" method="post" name="displayMessage" target="newWin">
   <input name="message" type="hidden"/>
</FORM >
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
  <!-- override it for disabling buttons in core.xsl anish-->
  <xsl:variable name="noOfRows">
    <xsl:value-of select="/RESPONSES/RESPONSE/SEARCH/REPORT/@TotalRecordCount"/>
  </xsl:variable>
  <!-- **********************************************************************
     *********************************************************************** -->
  <!-- custom javascript -->
  <xsl:template match="STEP" mode="header">
    <!-- Header/Help -->
    <i2:header>
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
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
                <!-- available for all -->
                <xsl:if test="EXPRESSION_FILTER/@Value = 'yes'">
                  <td>
                    <xsl:choose>
                      <xsl:when test="string-length(/RESPONSES/RESPONSE/FILTER_TEXT/@Value) > 0 ">
                        <table border="0" id="filter_table" cellpadding="0" cellspacing="0">
                          <form name="filter_form" method="post">
                            <tr>
                              <xsl:choose>
                                <xsl:when test="/RESPONSES/RESPONSE/FILTER_MODE/@Value = 'EDIT' "/>
                                <xsl:otherwise>
                                  <TD nowrap="yes">
                                    <i18n:text>Global</i18n:text>&#xA0;<xsl:text>:</xsl:text>&#xA0;
                                                  </TD>
                                  <TD nowrap="yes" align="left">
                                    <input type="checkbox" value="GLOBAL" name="FILTER_SCOPE"/>
                                  </TD>
                                </xsl:otherwise>
                              </xsl:choose>
                              <TD nowrap="yes">
                                <i18n:text>Filter Name</i18n:text> &#xA0;<xsl:text>:</xsl:text>&#xA0;
                                        </TD>
                              <TD nowrap="yes" align="left">
                                <input type="text" value="{/RESPONSES/RESPONSE/FILTER_NAME/@Value}" class="inputFieldIE" name="FILTER_NAME" size="10"/>
                              </TD>
                              <TD nowrap="yes">&#xA0;
                                          <a class="text" href="javascript:onSaveFilter();">
                                  <xsl:variable name="txtSaveFilter">
                                    <i18n:text>Save Filter</i18n:text>
                                  </xsl:variable>
                                  <i2:img src="/btn_saveas_1.gif" alt="{$txtSaveFilter}" border="0" align="middle"/>
                                </a>
                              </TD>
                            </tr>
                          </form>
                        </table>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:variable name="txtSaveFilter">
                          <i18n:text>Save Filter</i18n:text>
                        </xsl:variable>
                        <i2:img src="/btn_saveas_0.gif" alt="{$txtSaveFilter}" border="0" align="middle"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                  <td>
                  &#xA0;
                      <a class="text" href="javascript:onFilter();">
                      	<xsl:variable name="txtAdvFilter">
                      	  <i18n:text>Advanced Filter</i18n:text>
                      	</xsl:variable>
                      <i2:img src="/filter.gif" alt="{$txtAdvFilter}" border="0" align="middle"/>
                    	</a>&#xA0;
                  </td>
                  <td> 
															&#xA0;
															<a class="text" href="javascript:onCustomize();">
																			<xsl:variable name="txtCustomize">
																				<i18n:text>Customize</i18n:text>
																			</xsl:variable>
																			<i2:img src="/btn_customize_1.gif" alt="{$txtCustomize}" border="0" align="middle"/>
																		</a>&#xA0;
                        </td>
                  <td>     
                            &#xA0;
                          <a class="text" href="javascript:onCreateFavorite();">
                      <xsl:variable name="txtCreateFav">
                        <i18n:text>Create Favorite</i18n:text>
                      </xsl:variable>
                      <i2:img src="/addfav.gif" alt="{$txtCreateFav}" border="0" align="middle"/>
                    </a>&#xA0;
                        </td>
                  <!--td>     
                            &#xA0;
                          <a class="text" href="javascript:onManageFavorites();">
                            <xsl:variable name="txtManageFav"><i18n:text>Manage Favorites</i18n:text></xsl:variable>
                            <i2:img src="/editfav.gif" alt="{$txtManageFav}" border="0" align="middle"/>
                          </a>&#xA0;
                        </td-->
                  
                </xsl:if>
                <!-- not available for audit trail tables and tables not having pks -->
                <xsl:if test="WHERE_USED/@Value = 'yes'">
                  <td>
                    <a class="text" href="javascript:findWhereUsed();">
                      <xsl:variable name="txtwhereUsed">
                        <i18n:text>Where Used</i18n:text>
                      </xsl:variable>
                      <i2:img src="/batch_defintion.gif" alt="{$txtwhereUsed}" border="0" align="middle"/>
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
  <xsl:template name="include_javascript_variables">
    <script>

 
    
     document.result_form.pagenum.onkeyup = onlyInteger;
      <!-- system properties for mass edit -->
      var exportToExcelThreshold;
      var updateAll = <xsl:value-of select="/RESPONSES/RESPONSE/SYSTEM_PROPERTIES/updateAll/@Value"/>
      var warnThreshold = <xsl:value-of select="/RESPONSES/RESPONSE/SYSTEM_PROPERTIES/warnThreshold/@Value"/>
      var exceptionThreshold = <xsl:value-of select="/RESPONSES/RESPONSE/SYSTEM_PROPERTIES/exceptionThreshold/@Value"/>
      <xsl:if test="/RESPONSES/RESPONSE/SYSTEM_PROPERTIES/exportToExcelThreshold/@Value">
        exportToExcelThreshold = <xsl:value-of select="/RESPONSES/RESPONSE/SYSTEM_PROPERTIES/exportToExcelThreshold/@Value"/> ;
      </xsl:if>
       
      var totalRecordCount = <xsl:value-of select="$totalRecordCount"/>


      var confirmMesg = "ALL_RECS_UPD"
      var exportMesg = "ALL_RECS_EXPORT"
      var exportMesgRadio = "ALL_RECS_EXPORT"
      
      <!-- for pagination javascript -->
      var maxRows = <xsl:value-of select="$maxRows"/>



 // On Resize
 function onResize()
 {
   resizeScrollableTables();
   setFocus();
 }


 function validateSearchParam()
{
    var count;
    var elementsLen = document.result_form.elements.length;
    var dateFormat = document.result_form.DATE_FORMAT.value
    var success = true;
    var foundFilledField = false;
    var msg = ""; 
    <![CDATA[
    //Validate fields
    for(count = 0; count < elementsLen; count++)
        {
            var name = document.result_form.elements[count].name;

            if( document.result_form.elements[count].fieldtype == "Number" &&
                document.result_form.elements[count].value != "" )
                {
                    //if ( isNaN(document.result_form.elements[count].value) )
                         //{ 
                        ]]>
                    //        msg += name + "<i18n:text> should be a valid number</i18n:text>";
                    //        core_alert(msg);
                      <![CDATA[
                    //        success = false;
                    //        break;
                    //    }
                }  

            if( ((document.result_form.elements[count].fieldtype == "DateRange") ||  (document.result_form.elements[count].fieldtype == "Date")) &&
                document.result_form.elements[count].value != "" && dateFormat != "")
                {
                    if ( isDate(document.result_form.elements[count].value, dateFormat) == false )
                        {]]>
                            var msg_valid_date= "<i18n:text>Date range should be a valid date. The date format must be {0}.</i18n:text> ";
                            core_alert(msg_valid_date, dateFormat);
                            <![CDATA[
                            success = false;
                            break;
                        }
                }
        }

    return success; 
}
  ]]>
function newWindow1()
  {
      window.open("messageAlert.jsp","dlog",'width=150,height=100,modal=yes,scrollbars=yes,resizable=yes,toolbar=no,titlebar=no');
      document.displayMessage.submit();  
     } 
      function showClob(clob)
      {
       document.displayMessage.message.value = clob;
      var	vWinCal = window.open("messageAlert.jsp","dlog", "width=400,height=400,status=no,resizable=no,top=200,left=200,scrollbars=yes,resizable=yes");
	vWinCal.opener = self;		
       }
  </script>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
</xsl:stylesheet>

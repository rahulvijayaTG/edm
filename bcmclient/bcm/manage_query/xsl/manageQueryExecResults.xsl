<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">
  <!-- Core -->
  <!--xsl:import href="../../../core/xsl/page_header.xsl"/>
  <xsl:import href="../../../core/xsl/links.xsl"/-->
  <!--xsl:import href="../../../core/xsl/container.xsl"/-->
  <!--xsl:import href="../../framework/xsl/required_field.xsl"/-->
  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../framework/xsl/core_container_override.xsl"/>
  <xsl:import href="../../framework/queryform/xsl/searchformfilter.xsl"/>
  <!-- Errors -->
  <xsl:import href="../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>
  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:call-template name="include_javascript_manage_query"/>
    <xsl:apply-templates select="RESPONSE" mode="container_content1"/>
  </xsl:template>
 <!--***********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content1">

    <xsl:variable name="totalRecordCount">
      <xsl:value-of select="round(RECORD_COUNT/@Value)"/>
    </xsl:variable>
    <xsl:variable name="noOfRows">
              <xsl:value-of select="round(RECORD_COUNT/@Value)"/>
    </xsl:variable>
    <xsl:variable name="startAtRow">
      <xsl:value-of select="round(START_COUNT/@Value)"/>
    </xsl:variable>
    <xsl:variable name="maxRows">
      <xsl:value-of select="round(MAX_ROWS/@Value)"/>
    </xsl:variable>
    <xsl:variable name="formName">
      <xsl:value-of select="result_form"/>
    </xsl:variable>
    


    <i2:container id="table_container" inner="yes" title="Query Search Results" scrollable="yes" scrollablerows="yes" >
    <!--EQ:573939 To show the number of records and the pages-->
        <i2:table id="search_container_table">
                 <i2:tr header="yes">
                    <td nowrap="nowrap">
                      <xsl:call-template name="TABLE">
                                    <xsl:with-param name="noOfRows" select="$noOfRows"/>
                                    <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                                    <xsl:with-param name="startAtRow" select="$startAtRow"/>
                                          <xsl:with-param name="maxRows" select="$maxRows"/>
                        </xsl:call-template>
                    </td>
                 </i2:tr>
              </i2:table>
        
       <i2:table id="queryHistory_table">
          <i2:tr header="yes">
            <xsl:for-each select="SQL_RESULT[1]/*">
              <td nowrap="nowrap">
                <xsl:value-of select="name()"/>
              </td>
            </xsl:for-each>
          </i2:tr>
          <xsl:for-each select="SQL_RESULT">
            <i2:tr>
              <xsl:for-each select="*">
                <td nowrap="nowrap">
                  <xsl:value-of select="@Value"/>
                </td>
              </xsl:for-each>
            </i2:tr>
          </xsl:for-each>
        </i2:table>


        <!-- Table Footer -->
        <i2:footer>
          <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <form name="result_form" method="POST" action="manageQueryController/execute.cmd" target="appFrame">
              <tr>
              <!-- Pagination -->
                <td>
                  <xsl:apply-templates select="CONTAINER/STEP/PAGINATION">
                    <xsl:with-param name="totalRecordCount" select="$totalRecordCount"/>
                    <xsl:with-param name="startAtRow" select="$startAtRow"/>
                    <xsl:with-param name="maxRows" select="$maxRows"/>
                    <xsl:with-param name="formName" select="$formName"/>
                  </xsl:apply-templates>
                </td>
                <!-- Buttons  -->
                <td align="right">
                  <xsl:apply-templates select="CONTAINER/STEP/BUTTONS">
                    <xsl:with-param name="noOfRows" select="$totalRecordCount"/>
                  </xsl:apply-templates>
                </td>
              </tr>
          <input type="hidden" name="fromPage" value="ResultPage"/>
          <input type="hidden" name="DO_SEARCH"/>

          <!-- Hidden fields for pagination -->
          <xsl:if test="count(CONTAINER/STEP/PAGINATION) > 0 ">
            <input type="hidden" name="RECORD_COUNT" value="{$totalRecordCount}"/>
            <input type="hidden" name="START_COUNT" value="{$startAtRow}"/>
            <input type="hidden" name="MAX_ROWS" value="{$maxRows}"/>
          </xsl:if>
            </form>
          </table>
        </i2:footer>

    </i2:container>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <!-- Javascript -->
  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
      //alert("onload anish");
      resizeAll();
    }
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onResize_js">
    function onResize()
    {
      //alert("hello resizing");
      resizeAll();
    }
  </xsl:template>
  <!-- Javascript -->
  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="include_javascript_manage_query">
    <script>
      var exportMesg = "<i18n:text>Do you want to export all records? If No, only the records displayed in the current page will be exported</i18n:text>"

      function IEEnterKey(){
        if(window.event.keyCode == 13){
          SetfocusSubmit(window.event.srcElement)
          event.returnValue=false;
        }
      }
      
      function SetfocusSubmit( target ){
      }
     <!--EQ:573939 To go back to the Execute page-->
      function onCancel(){
        //alert("hello"+document.result_form);
        //history.back();
        document.result_form.target="appFrame";
        document.result_form.action="manageQueryController/cancelFromExecResult.cmd";
        document.result_form.submit();
      }

      // Resizing All containers
      function resizeAll(){
        var table_id = 'queryHistory_table';
        var width = document.body.offsetWidth -5 ;
        var height = document.body.scrollHeight;
        // resize table   approx
        //i2uiResizeColumns(table_id);
        i2uiResizeScrollableArea(table_id, height-200, width-100, null, null, null,null, null);
        i2uiResizeScrollableContainer('table_container',document.body.offsetHeight-150, null, document.body.offsetWidth - 20, true, 'yes');
      }

      function jumpToPage(actionName, startCount, result_form, page_form){
        var max_rows = "<xsl:value-of select="$maxRows"/>";
        if (max_rows == null || max_rows == "") max_rows = 10;
        var nextCount = parseInt(startCount) + parseInt(max_rows);
        var prevCount = 0;
        if ( parseInt(startCount) > 0 ) prevCount = parseInt(startCount) - max_rows;
        if (startCount == null) startCount=page_form.pagenum.value;
        var pagenum= parseInt(startCount);  pagenum--;
        if (actionName == "jump"){
          if(( page_form.RECORD_COUNT.value == 0 || page_form.RECORD_COUNT.value &gt; pagenum*max_rows)  &amp;&amp; (pagenum+1&gt;0) &amp;&amp; (page_form.START_COUNT.value != pagenum*max_rows)){
            result_form.DO_SEARCH.value='yes';
            result_form.START_COUNT.value=pagenum*max_rows;
            result_form.target="appFrame";
            result_form.method="POST";
            result_form.submit();
          }
          else{
            core_alert("<i18n:text>PAGINATION_ALERT</i18n:text>");
          }
        }
      }
      <![CDATA[
      function onExportToExcel(fileName, fileFormat){
        //var selRows = getSelectedRowIndices();
        var exportAll;
        //alert("exporting ....");
        prevAction = document.result_form.action;
        if (window.parent.parent.push_frame){   //scmui frames
          document.result_form.target = "push_frame";
        }
        else{                   //BCM frames
          document.result_form.target = "i2ui_shell_bottom";
        }
        if (core_confirm( exportMesg ) == 'yes' ){
      exportAll = 'YES';
      document.result_form.action="manageQueryController/exportToExcel.cmd?EXPORT_ALL="+exportAll+"&FILE_NAME="+fileName+"&FILE_FORMAT="+fileFormat;
      document.result_form.submit();
        }
        else{
      exportAll = 'NO';
      document.result_form.action="manageQueryController/exportToExcel.cmd?EXPORT_ALL="+exportAll+"&FILE_NAME="+fileName+"&FILE_FORMAT="+fileFormat;
      document.result_form.submit();
        }
        document.result_form.target = "appFrame";
        document.result_form.action= prevAction;          
      }
    ]]>
    </script>
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
     <!--EQ:573939 To show the number of records and the pages-->
      <xsl:template name= "TABLE">
            <xsl:param name="noOfRows"/>
                    <xsl:param name="totalRecordCount"/>
                    <xsl:param name="startAtRow"/>
                    <xsl:param name="maxRows"/>
                           
    
            <xsl:variable name="currentPage">
                  <xsl:value-of select="ceiling(($startAtRow+1) div $maxRows)"/>
                </xsl:variable>
                <xsl:variable name="endPage">
                  <xsl:choose>
                    <xsl:when test="$totalRecordCount = '1000000000000000'">
                      <i18n:text>UnKnown</i18n:text>
                    </xsl:when>
                    <xsl:when test="$totalRecordCount = '0'">
                      <i18n:number>1</i18n:number>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="ceiling($totalRecordCount div $maxRows)"/>
                    </xsl:otherwise>
                  </xsl:choose>
        </xsl:variable>
           <!-- Title -->
           <xsl:variable name="title">          
             <xsl:choose>
               <xsl:when test="$noOfRows != 0">
                  <b><i18n:text>Search Results</i18n:text></b></xsl:when>
               </xsl:choose>
             </xsl:variable>
         
               <xsl:variable name="pagingTitle">
                   <!-- 1 of 10 -->
                   <xsl:if test="$totalRecordCount > 0">
         
                   <xsl:variable name="endPage_i18n">
                     <xsl:choose>
                       <xsl:when test="$endPage='UnKnown'">
                       </xsl:when>
                       <xsl:otherwise>
                        <i18n:text>of</i18n:text>&#xA0;<i18n:number><xsl:value-of select="$endPage"/></i18n:number>
                       </xsl:otherwise>
                     </xsl:choose>
                   </xsl:variable>
         
                     <xsl:if test="$totalRecordCount > 0">:&#xA0;<i18n:text>Page</i18n:text>&#xA0;<i18n:number><xsl:value-of select="$currentPage"/></i18n:number>&#xA0;<xsl:value-of select="$endPage_i18n"/>
                     </xsl:if>
                   </xsl:if>
               </xsl:variable>
         
               <xsl:variable name="noRowsTitle">
               <!--  no rec found -->
               <xsl:if test="$totalRecordCount = 0">
                 <xsl:variable name="noRowsTitle">
                   <!-- Search Mode -->
                   <xsl:if test="@DoSearch = 'Yes' or @DoSearch='yes' or @DoSearch='true'">
                     <xsl:choose>
                       <!-- Custom title -->
                       <xsl:when test="string-length(@NoRecordsTitle) > 0">
                         &lt;i&gt;<i18n:text><xsl:value-of select="@NoRecordsTitle"/></i18n:text>&lt;/i&gt;
                       </xsl:when>
                       <!-- NO_DOC_TYPE_FOUND -->
                       <xsl:when test="string-length(@Document) > 0">
                         <i18n:text><xsl:value-of select="concat('NO_',@Document,'_FOUND')"/></i18n:text>
                       </xsl:when>
                       <!-- No Records Found -->
                       <xsl:otherwise>
                          :&#xA0;<i18n:text>No records found</i18n:text>.
                       </xsl:otherwise>
                     </xsl:choose>
                   </xsl:if>
                 </xsl:variable>
         
                 <i18n:text><xsl:value-of select="$noRowsTitle"/></i18n:text>
               </xsl:if>
               <xsl:if test="$totalRecordCount &gt; 0">
                 <xsl:variable name="noRowsTitle">
                   <!-- Search Mode -->
                      &#xA0;
                   (<i18n:text>Total records</i18n:text>&#xA0;<i18n:text><xsl:value-of select="$totalRecordCount"/></i18n:text>)
                 </xsl:variable>
                 <i18n:text><xsl:value-of select="$noRowsTitle"/></i18n:text>
               </xsl:if>      
               
               </xsl:variable>
         
             <xsl:variable name="filterTitle">
         
                   <xsl:if test="(string-length(@FilterTitle) > 0 )">
                    &#xA0;:&#xA0;<i18n:text>Filtered </i18n:text>(<xsl:value-of select="@FilterTitle" />)
                   </xsl:if>
         
             </xsl:variable>
         
             <xsl:choose>
               <xsl:when test="string-length($filterTitle) > 0 ">
                  <table border="0" cellpadding="0" cellspacing="0" height="100%">
                   <tr>
                     <td  align="left">
                           <xsl:value-of select="concat($title,$pagingTitle,$noRowsTitle,$filterTitle)"/>
                     </td>
                   </tr>
                 </table>
               </xsl:when>
               <xsl:otherwise>
                 <xsl:value-of select="concat($title,$pagingTitle,$noRowsTitle)"/>
               </xsl:otherwise>
             </xsl:choose>
         
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

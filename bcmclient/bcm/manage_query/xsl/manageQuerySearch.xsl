<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../framework/queryform/xsl/searchformfilter.xsl"/>
  <xsl:import href="../../context/xsl/context_header.xsl"/>
  <xsl:output method="html"/>

  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_table_resize"/>  
    <xsl:call-template name="include_javascript_form"/>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <table cellpadding="0" width="100%">
      <tr>
     	<td>
     	  <table id="resultMessage" width="100%">
     	    <tr>
              <td>
                <xsl:if test="count(SUCCESS_MESSAGE) &gt; 0">
                  <xsl:apply-templates select="SUCCESS_MESSAGE"/>
                </xsl:if>
              </td>
            </tr>
            <tr>
              <td>
                <xsl:if test="count(ERROR_MESSAGE) &gt; 0">
                  <xsl:apply-templates select="ERROR_MESSAGE[1]"/>
                </xsl:if>
              </td>
            </tr>
     	  </table>
     	</td>
      </tr>
      <tr>
        <td>
          <xsl:apply-templates select="SEARCH">
              <xsl:with-param name="formName" select="'result_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>  
  <!--**************************************************
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
  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad(){
      resize_Containers();
    }
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="onResize_js">
    function onResize(){
      resize_Containers();
    }
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_form">
    <script>
      function SetfocusSubmit( target ){
        if ( target.form == document.search_form ){
          onSearch();
        }
        else if (target.form == document.result_form){
          getRecords('jump');
        }
        else{
          onSearch();
          /*
          var js = target.toString();
          eval(js);
          */
        }
      }
      <![CDATA[
      function dispatchClear(){
        document.search_form.target="appFrame";
        document.search_form.action="../framework/filter/controller/clearFilter.cmd";
        document.search_form.submit();
      }
      
      function trimFilterElements(){
        var elements = document.search_form.elements;
        var elementCount = elements.length;
        for (var i = 0; i < elementCount; i++) {
          elements[i].value = trimString(elements[i].value);
        }
      }        
                
      function onCreate(){
        document.result_form.ACTION.value = 'Create';
        document.result_form.target="appFrame";
        document.result_form.action="manageQueryDetail.jsp?MODE=New";
        document.result_form.submit();
      }
        
      function onDelete(){
        var confirmMesg = "Are you sure you want to remove the selected Query/Queries?";
        if (checkifAnySelected(document.result_form)){
          if( core_confirm( confirmMesg ) == 'yes' ){
            document.result_form.target="appFrame";
            document.result_form.START_COUNT.value = 0 ;
            document.result_form.action= "manageQueryController/delQueryMaster.cmd";
            document.result_form.submit();
          }
        }
        else{
          core_alert("Please select at least one Query to Delete.");
        }
      }
      
      function myMethod(selectedID){
        document.result_form.CURRENT_ID.value=selectedID;
        document.result_form.ACTION.value='Edit';
        document.result_form.action="";
        document.result_form.submit();
      }

      ]]>
      function onQueryDetails(){
        //alert("hello..1..");
        if (ifOneChecked(document.result_form.name)){
          document.result_form.target="appFrame";
          document.result_form.action="manageQueryController/getQueryDetail.cmd?MODE=Edit";
          document.result_form.submit();
        }
        else{
          core_alert("Please select one Query to View Details.");
        }
      }

      function onQueryHistory(){
        if (ifOneChecked(document.result_form.name)){
          document.result_form.target="appFrame";
          document.result_form.action="manageQueryController/getQueryHistory.cmd";
          document.result_form.submit();
        }
        else{
          core_alert("Please select one Query to View History.");
        }
      }

      <!--EQ:574795 Removing the confirmation Message -->
     function onExecuteQuery()
     {
      if (ifOneChecked(document.result_form.name))
      {
        document.result_form.target="appFrame";
        document.result_form.action="manageQueryController/executeQuery.cmd";
        document.result_form.submit();
      }
      else
      {
       core_alert("Please select one Query to Execute.");
      }
     }
     <!--EQ:574795-->
    </script>      
  </xsl:template>    
  <!-- **********************************************************************
      *********************************************************************** -->
  <!-- Javascript -->
  <xsl:template name="include_javascript_table_resize">
    <script>
    <![CDATA[
      function resize_Containers(){
    	var table_id = 'result_form_table';
    	var width = document.body.offsetWidth -5 ;
    	var height = document.body.scrollHeight;
    	// resize table   approx
    	i2uiResizeColumns(table_id);
    	i2uiResizeScrollableArea(table_id, height-200, width-30, null, null, null,null, null);
    	i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight-100, null, document.body.offsetWidth - 20, true, 'yes');
      }
    ]]>
    </script>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
</xsl:stylesheet>
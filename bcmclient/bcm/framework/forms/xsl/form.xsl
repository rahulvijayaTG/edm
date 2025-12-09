<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:import href="../../queryform/xsl/searchformfilter.xsl"/>

  <xsl:output method="html"/>

  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">
     
     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>
    <xsl:call-template name="include_javascript_forms"/>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
   <xsl:template match = "RESPONSE" mode="container_content">
    <xsl:if test="SUCCESS_MESSAGE or ERROR_MESSAGE">
      <xsl:call-template name="display_instruction_area"/>
    </xsl:if>
     <xsl:apply-templates select="SEARCH">
       <xsl:with-param name="formName" select="'result_form'"/>
     </xsl:apply-templates>
  </xsl:template>

  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_forms">
  <script>

    var confirmMesg = "<i18n:text>Do you want to update all searched records (</i18n:text>" + totalRecordCount +  "<i18n:text>) stored in the table?</i18n:text>" ;

    function resize_Containers()
    {

      var table_id = 'result_form_table';
      var width = document.body.offsetWidth - 35;
      var height = document.body.offsetHeight - 200;
      // resize table   approx
      i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null);
      i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight - 200, null, document.body.offsetWidth - 20, true, 'yes');
    }

    function onLoad()
    {

    <xsl:if test="/RESPONSES/RESPONSE/SUCCESS_MESSAGE or /RESPONSES/RESPONSE/ERROR_MESSAGE">
      requiredFieldCheck('onLoad');
    </xsl:if>

      setFocus();

      onResize();
    }

      function dispatchSearch()
      {
                                  
            trimFilterElements(result_form); 
            document.result_form.target="appFrame";
            document.result_form.DO_SEARCH.value='yes';
            document.result_form.START_COUNT.value=0;            
            document.result_form.submit();
      }
      
      function onClear()
      {
        onClearGlobal(result_form);
      }


   function onExportToExcel() {
      if (window.parent.parent.push_frame)	//scmui frames
      {
           document.result_form.target = "push_frame";
      }
      else					//BCM frames
      {
    document.result_form.target = "i2ui_shell_bottom";
      }
     document.result_form.action="formController/exportToExcel.cmd";
     document.result_form.submit();
      document.result_form.target = "appFrame";
      document.result_form.action="form.jsp";
   }

    function onGroupEdit() {


	  if(checkifAnySelected(result_form) == true)
	  {

        if( checkifAllSelected('result_form') &amp;&amp; mdm_confirm( confirmMesg ) == 'yes' )
        {
          document.result_form.UPDATE_MODE.value = 'ALL' ;
        }
        else
        {
            document.result_form.UPDATE_MODE.value = 'MULTIPLE' ;
         }
        document.result_form.action="formController/goToGroupEditPage.cmd";
        document.result_form.submit();
      }
      else
        core_alert("PLEASE_SELECT_ATLEAST_ONE_TRANSACTION");
}

  </script>
  </xsl:template>

  <!-- **********************************************************************
       *********************************************************************** -->
</xsl:stylesheet>

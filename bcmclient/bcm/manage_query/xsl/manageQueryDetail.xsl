<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">
  <!-- Core -->
  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../core/xsl/container.xsl"/>
  <xsl:import href="../../framework/xsl/required_field.xsl"/>
  <xsl:import href="../../framework/queryform/xsl/searchformfilter.xsl"/>
  <xsl:import href="../../framework/xsl/code_master.xsl"/>
  <!-- Errors -->
  <xsl:import href="../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>
  <!-- Page Content -->
  <xsl:variable name="userPermissionAddForbcmManageQuery">
     <xsl:value-of select="/RESPONSES/RESPONSE/userPermissionAddForbcmManageQuery/@Value"/>
  </xsl:variable>
  <xsl:variable name="userPermissionUpdateForbcmManageQuery">
       <xsl:value-of select="/RESPONSES/RESPONSE/userPermissionUpdateForbcmManageQuery/@Value"/>
  </xsl:variable>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:call-template name="include_javascript_sc_preview"/>
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">
    <xsl:call-template name="display_instruction_area"/>
    <!-- Body -->
    <table id="top_table" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td colspan="3">
          <xsl:apply-templates select="QUERY_DETAILS"/>
        </td>
      </tr>
      <tr valign="TOP" align="left" width="30%">
        <td align="left" colspan="1">
          <xsl:apply-templates select="PARAMETER_DETAILS"/>
        </td>
        <td align="left" colspan="2" width="70%">
          <xsl:if test="ADD_PARAMETER">
            <xsl:apply-templates select="ADD_PARAMETER"/>
          </xsl:if>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!--***********************************************************************
     *********************************************************************** -->
  <xsl:template match="QUERY_DETAILS">
    <!--i2:container id="bom_container" title="{$title}"-->
      <table id="bom_tab" width="100%">
        <form name="result_form" method="POST" target="appFrame">
          <tr>
            <td>
              <table id="org_res_param_inner_table" border="0" cellpadding="0" cellspacing="9" width="50%">
                <tr>
                  <td nowrap="nowrap" width="50%">
                    <i18n:text>Query Name</i18n:text>
                    <xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <input type="field" name="queryName" value="{queryName/@Value}" tabIndex="" class="inputfieldIE" size="27" required="true" />
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'queryName'"/>
                    </xsl:call-template>
                  </td>
                </tr>
                <tr>
                  <td nowrap="nowrap" width="50%">
                    <i18n:text>Query Detail</i18n:text>
                    <xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <TEXTAREA NAME="queryString" ROWS="15" COLS="60" CLASS="inputfieldIE" required="true">
                      <xsl:value-of select="queryString/@Value"/>
                    </TEXTAREA>
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'queryString'"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </form>
      </table>
    <!--/i2:container-->
  </xsl:template>
  <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="PARAMETER_DETAILS">
    <table id="param_tab" border="0" cellpadding="0" cellspacing="9" width="100%">
      <tr width="100%">
        <td nowrap="nowrap" width="100%">
          <xsl:apply-templates select="SEARCH">
            <xsl:with-param name="formName" select="'param_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="ADD_PARAMETER">
    <table id="param_dtl_tab" border="0" cellpadding="0" cellspacing="9" width="100%" align="left">
      <form id="param_dtl_form" action="" name="param_dtl_form" method="POST">
        <tr align="left">
          <td nowrap="nowrap" align="left">
            <i2:container id="param_dtl_container" inner="yes" align="left">
              <i2:attribute name="title">
                Add Parameter
              </i2:attribute>
	      <table border="0" cellpadding="5" cellspacing="0" align="left" width="100%">
		<tr align="left">
		  <td nowrap="nowrap">Param Name:
		  </td>
		  <td><input type="field" name="paramName" value="" tabIndex="" class="inputfieldIE" size="27"/>
		  </td>
		</tr>
		<tr align="left">
		  <td nowrap="nowrap">Param Description:
		  </td>
		  <td><input type="field" name="paramDesc" value="" tabIndex="" class="inputfieldIE" size="27"/>
		  </td>
		</tr>
		<tr align="left">
		  <td nowrap="nowrap">Param Data Type:
		  </td>
		  <!--td><input type="field" name="paramDataType" value="" tabIndex="" class="inputfieldIE" size="27"/>
		  </td-->
                  <td nowrap="nowrap">
                    <select class="inputfieldIE" name="paramDataType" tabIndex="">
                          <xsl:apply-templates select="/RESPONSES/RESPONSE/ADD_PARAMETER/DATA_TYPES/CODE_MASTER_VALUE" mode="pulldown">
                            <!--xsl:with-param name="selectedId" select="'STRING'"/-->
                          </xsl:apply-templates>
                    </select>
                  </td>
	 	</tr>
	      </table>
              <i2:footer>
		<table cellspacing="0" cellpadding="0" width="100%" border="0">
		  <tr>
		    <td align="right">
		      <i2:buttonbar>
    			<i2:button id="save_param" name="save_param" onclick="javascript:onSaveParam()" emphasized="false" target="appFrame">
     			  &#xA0;Save Param&#xA0;
                 	</i2:button>
		      </i2:buttonbar>
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
  <!-- Javascript -->
  <!-- page.xsl Javascript -->
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
      requiredFieldCheck('onLoad');
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
  <xsl:template name="include_javascript_sc_preview">
    <script>
      function IEEnterKey(){
        if(window.event.keyCode == 13){
          SetfocusSubmit(window.event.srcElement)
          event.returnValue=false;
        }
      }
      
      function SetfocusSubmit( target ){
	<xsl:if test="$userPermissionAddForbcmManageQuery='True' or $userPermissionUpdateForbcmManageQuery='True'">     		      
         <xsl:choose>
           <xsl:when test="/RESPONSES/RESPONSE/HEADER_CONTEXT/MODE/@Value = 'EDIT'">
                  //alert("hello 1");
                 onSaveAndReturnForEdit();
           </xsl:when>
           <xsl:otherwise>
                 //alert("hello 2");
                 onSave();
           </xsl:otherwise>
         </xsl:choose>
	</xsl:if>
      }

      function onSaveAndReturn(){
        error = "false";
        error = requiredFieldCheck();
        if ( error == 'false' ){
          document.result_form.target="appFrame";
          document.result_form.action="manageQueryController/saveQueryAndReturn.cmd";
          document.result_form.submit();
        }
        return;
      }

      function onSave(){
        error = "false";
        error = requiredFieldCheck();
        if ( error == 'false' ){
          document.result_form.target="appFrame";
          document.result_form.action="manageQueryController/saveQuery.cmd?MODE=Save";
          document.result_form.submit();
        }
        return;
      }

      function onCancel(){
        document.result_form.target="appFrame";
        document.result_form.action="manageQueryController/cancel.cmd";
        document.result_form.submit();
      }

      function onAddParam(){
        document.result_form.target="appFrame";
        document.result_form.action="manageQueryController/addParamDetail.cmd?MODE=Edit";
        document.result_form.submit();
      }

      function onSaveParam(){
        document.param_dtl_form.target="appFrame";
        document.param_dtl_form.action="manageQueryController/saveParamDetail.cmd?MODE=Edit";
        document.param_dtl_form.submit();
      }

      function onDelParam(){
        document.param_form.target="appFrame";
        document.param_form.action="manageQueryController/delQueryParam.cmd?MODE=Edit";
        document.param_form.submit();
      }

      function onMoveUp(){
        //alert("UP");
        if ( checkifAnySelected(param_form) == true ){
          document.param_form.target="appFrame";
	  document.param_form.action="manageQueryController/moveUp.cmd?MODE=Edit";
	  document.param_form.submit();
        }
      }

      function onMoveDown(){
        //alert("DOWN");
        if ( checkifAnySelected(param_form) == true ){
          document.param_form.target="appFrame";
	  document.param_form.action="manageQueryController/moveDown.cmd?MODE=Edit";
	  document.param_form.submit();
        }
      }

      // Resizing All containers
      function resizeAll(){
    	var table_id = 'param_tab';
    	var width = document.body.offsetWidth -5 ;
    	var height = document.body.scrollHeight;
    	// resize table   approx
    	//i2uiResizeColumns(table_id);
    	//i2uiResizeScrollableArea(table_id, height-200, width-30, null, null, null,null, null);
    	i2uiResizeScrollableContainer('container',document.body.offsetHeight-100, null, document.body.offsetWidth - 20, true, 'yes');
      }
  </script>
  </xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>

<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../bcm/framework/queryform/xsl/searchformfilter.xsl"/>
  <xsl:import href="../../../bcm/context/xsl/context_header.xsl"/>
  <xsl:import href="../../../bcm/framework/xsl/required_field.xsl"/>
  <xsl:import href="../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>
  
    <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">


    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="tabs">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_table"/>
    <xsl:call-template name="include_javascript_table_resize"/>
  </xsl:template>
  
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
    <table id="role_table" width="100%">
      <tr>
        <td>
          <!-- Show the BOM details -->
          <xsl:apply-templates select="RoleDetails"/>
          <!-- BOM Components details -->
        </td>
      </tr>
      <tr>
        <td>
          <xsl:apply-templates select="ROLE_DETAILS_FORM/SEARCH">
            <xsl:with-param name="formName" select="'result_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>
  
  <!--*************************************************************************
  ***************************************************************************** -->
  <xsl:template match="RoleDetails">
    <form name="header_form" method="POST">
      <input type="hidden" name="ROLE_ID" value="{ROLE_ID/@Value}"/>
      <input type="hidden" name="SELECTED_NODE" value=""/>
      <table border="0" height="15%" width="100%">
        <tr>
          <td colspan="4">
            <xsl:call-template name="display_instruction_area"/>
          </td>
        </tr>
        <tr>
          <td nowrap="nowrap">
              &#xA0;
              <i18n:text>Role Id</i18n:text>
              <xsl:text>:</xsl:text>            
          	  <xsl:if test="//RESPONSES/RESPONSE/CREATE_NEW/@Value = 'Yes' ">
          			<xsl:call-template name="display_alert_mark"/>
          	  </xsl:if>
          </td>
          <td align="left">
          	&#xA0;
				<input type="field" name="ROLE_ID1" value="{ROLE_ID/@Value}" required="true" class="inputfieldIE" maxlength="32" size="32"/>
          </td>
          <td nowrap="nowrap">
              &#xA0;
              <i18n:text>Role Name</i18n:text>
            <xsl:text>:</xsl:text>
            <xsl:call-template name="display_alert_mark"/>
          </td>
          <td nowrap="nowrap">
            &#xA0;<input type="field" name="ROLE_NAME" value="{ROLE_NAME/@Value}" required="true" tabIndex="" class="inputfieldIE" maxlength="32" size="32"/>
          </td>
        </tr>
      </table>
    </form>
  </xsl:template>
  <!-- custom javascript -->
  
  <!--  *********************************************************************** -->
  <xsl:template name="include_javascript_table">
    <script>
    function showTab(ntype)
   	{
   	        document.result_form.START_COUNT.value = "0";
 		document.result_form.SELECTED_TAB.value = ntype;
 		document.result_form.submit();
   	}


	var roleExists = '<xsl:value-of select="//RESPONSES/RESPONSE/ROLE_EXISTS/@Value"/>';
    var createNew = '<xsl:value-of select="//RESPONSES/RESPONSE/CREATE_NEW/@Value"/>';
    var existingRoleName = '<xsl:value-of select="//RESPONSES/RESPONSE/RoleDetails/ROLE_NAME/@Value"/>';    
    <!-- FIX for 532019 -->
    var one_activity_mesg = 'SELECT_ATLEAST_ONE_ACTIVITY';
    
    function onSaveAndReturn()
    {
		if(roleExists == 'true' &amp;&amp; createNew != 'Yes') {
			if(document.header_form.ROLE_ID1.value != document.header_form.ROLE_ID.value) {
				core_alert("Role Id can not be changed while updating an existing role");
				document.header_form.ROLE_ID1.value = document.header_form.ROLE_ID.value;
				return;
			}
		}

        error = "false";
        error = requiredFieldCheck();
        if ( error == 'false' )
        {
            <xsl:if test="//RESPONSES/RESPONSE/CREATE_NEW/@Value = 'Yes' ">         	
	          	document.header_form.ROLE_ID.value = document.header_form.ROLE_ID1.value;
          	</xsl:if>
        	
            var str = "?" ;
            str += "ROLE_ID=" + document.header_form.ROLE_ID.value + "&amp;";
            str += "ROLE_NAME=" + document.header_form.ROLE_NAME.value + "&amp;";
            str += "TO_RETURN=Yes&amp;";
                        
            document.result_form.action= "user_role_details/saveRoleDetails.cmd" + str;
	    document.result_form.action= encodeURI(document.result_form.action);
            document.result_form.submit();
         }                
    }
    
    function onSave()
    {  
    	//while coming from the role search page (editing an role)  	
		if(roleExists == 'true' &amp;&amp; createNew != 'Yes') {
			if(document.header_form.ROLE_ID1.value != document.header_form.ROLE_ID.value) {
				core_alert("Role Id can not be changed while updating an existing role");
				document.header_form.ROLE_ID1.value = document.header_form.ROLE_ID.value;
				return;
			}
		}

        error = "false";
        error = requiredFieldCheck();
        if ( error == 'false' )
        {
       		<xsl:if test="//RESPONSES/RESPONSE/CREATE_NEW/@Value = 'Yes' ">         	
	          	document.header_form.ROLE_ID.value = document.header_form.ROLE_ID1.value;
          	</xsl:if>

            var str = "?" ;
            str += "ROLE_ID=" + document.header_form.ROLE_ID.value + "&amp;";
            str += "ROLE_NAME=" + document.header_form.ROLE_NAME.value + "&amp;";
            str += "TO_RETURN=No&amp;";

            document.result_form.action= "user_role_details/saveRoleDetails.cmd" + str;
	    document.result_form.action= encodeURI(document.result_form.action);
            document.result_form.submit();
         }        
    }

	function onSaveAsNew()
    {
		if(roleExists == 'true' &amp;&amp; createNew != 'Yes') {
			if(document.header_form.ROLE_ID1.value == document.header_form.ROLE_ID.value) {
				core_alert("Please enter a different value for Role Id (Role Id should be unique).");
				return;
			}
			if(document.header_form.ROLE_NAME.value == existingRoleName) {
				core_alert("Please enter a different value for Role Name (Role Name should be unique).");
				return;
			}
		}

        error = "false";
        error = requiredFieldCheck();
        if ( error == 'false' )
        {
          	document.header_form.ROLE_ID.value = document.header_form.ROLE_ID1.value;
            var str = "?" ;
            str += "ROLE_ID=" + document.header_form.ROLE_ID.value + "&amp;";
            str += "ROLE_NAME=" + document.header_form.ROLE_NAME.value + "&amp;";
            str += "TO_RETURN=No&amp;";
            str += "ACTION=SAVE_AS_NEW&amp;";

            document.result_form.action= "user_role_details/saveRoleDetails.cmd" + str;
	    document.result_form.action= encodeURI(document.result_form.action);
            document.result_form.submit();
         }        
    }

    function onCancel()
    {
          document.header_form.ROLE_NAME.value ='';
          document.header_form.ROLE_ID.value ='';
          document.header_form.action="user_role_details/displayRoleSearchPage.cmd?ACTION=INIT";
          document.header_form.submit();
    }

    function onRemove()
    {
          if(checkifAnySelected(document.result_form) == true ){
            var str = "?" 
            			+ "ROLE_ID=" + document.header_form.ROLE_ID.value + "&amp;";
            			+ "ROLE_NAME=" + document.header_form.ROLE_NAME.value + "&amp;";
            document.result_form.action="user_role_details/removeActivities.cmd" + str ;
	    document.result_form.action= encodeURI(document.result_form.action);
            document.result_form.submit();
          }else{
              core_alert(one_activity_mesg);
          }
    }

    function onAdd(){
      <xsl:if test="//RESPONSES/RESPONSE/CREATE_NEW/@Value = 'Yes' ">         	
	      	document.header_form.ROLE_ID.value = document.header_form.ROLE_ID1.value;
      </xsl:if>    	
      var str = "?";
      str += "ROLE_ID=" + document.header_form.ROLE_ID.value + "&amp;";
      str += "ROLE_NAME=" + document.header_form.ROLE_NAME.value + "&amp;";
      document.result_form.action="user_activity_search/getActivitySearchPage.cmd" + str;
      document.result_form.action= encodeURI(document.result_form.action);
      document.result_form.submit();
    }
  </script>
  </xsl:template>
  <!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
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
      /* commented this to fix issue 535591 */
      /* resize_Containers(); */
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
      var height = document.body.offsetHeight - 280;
     var table_id = 'result_form_table';
     //alert("hello");
     i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null);
     i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight - 100, null, document.body.offsetWidth - 25, true, 'yes');

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
       onSaveAndReturn();
    }


   function checkifAnySelected(form)
   {
        var count;
        var elementsLen = form.elements.length;
        var foundChecked = false;

        for(count = 0; count < elementsLen; count++)
        {
          if( form.elements[count].type == "checkbox" && form.elements[count].checked == true  &&
             form.elements[count].name != "SELECT_ALL"  && form.elements[count].name.substring(0,3) != "cb_")
           {
              foundChecked = true;
              break;
           }
        }
        return foundChecked;
   }

   // DO not remove this function code. It is required for Save And return on Enter key pressed.
    function onSearch(){
       onSaveAndReturn();
    }

  ]]></script>
  </xsl:template>
  <!-- ***************************************************************************
  ******************************************************************************* -->
</xsl:stylesheet>
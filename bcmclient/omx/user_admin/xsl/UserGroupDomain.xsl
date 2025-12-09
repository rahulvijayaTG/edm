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

    <xsl:call-template name="include_javascript_table"/>


    <xsl:variable name="caption_title">
      <i18n:text>Domain Details</i18n:text>
    </xsl:variable>

    <i2:container id="container" title="{$caption_title}">     	
		<table id="domain_table" width="100%">
		  <xsl:if test="string-length(RESPONSE/SUCCESS_MESSAGE/@Value) != 0">
			  <tr>
				<td>
				  <xsl:apply-templates select="RESPONSE/SUCCESS_MESSAGE"/>
				</td>
			  </tr>    			  		
		  </xsl:if>
		  <xsl:if test="string-length(RESPONSE/ERROR_MESSAGE/@Value) != 0">
			  <tr>
				<td>
				  <xsl:apply-templates select="RESPONSE/ERROR_MESSAGE"/>
				</td>
			  </tr>    			  		
		  </xsl:if>
		  <xsl:if test="(string-length(RESPONSE/INCLUDE_NOT_ADDED/@Value) &gt; 0) or (string-length(RESPONSE/EXCLUDE_NOT_ADDED/@Value) &gt; 0)">
			  <tr>
				  <td>
						<i2:img src="/alert_green_static.gif" border="0" align="middle">
						  <i2:attribute name="alt">
					  		<i18n:text>UserSecurity.Nodes_Not_Added</i18n:text>:
						  </i2:attribute>
						</i2:img>
						<i18n:text>Warning</i18n:text>:
						<i18n:text>UserSecurity.Nodes_Not_Added</i18n:text>:
				  </td>
			  </tr>	
			  <xsl:if test="string-length(RESPONSE/INCLUDE_NOT_ADDED/@Value) &gt; 0">
				  <tr>
					  <td>
					  		<i18n:text>UserSecurity.Included_Domain_Nodes</i18n:text>:
					  		<xsl:value-of select="RESPONSE/INCLUDE_NOT_ADDED/@Value"/>
					  </td>
				  </tr>												  	
			  </xsl:if>
			  <xsl:if test="string-length(RESPONSE/EXCLUDE_NOT_ADDED/@Value) &gt; 0">
				  <tr>
					  <td>
					  		<i18n:text>UserSecurity.Excluded_Domain_Nodes</i18n:text>:
					  		<xsl:value-of select="RESPONSE/EXCLUDE_NOT_ADDED/@Value"/>
					  </td>
				  </tr>												  	
			  </xsl:if>
		  </xsl:if>

		  <tr>      	
			<td>
			  <xsl:apply-templates select="RESPONSE/USER_GRP_PROFILE"/>
			</td>
		  </tr>    	
		  <tr>
		  	<td>
				<xsl:apply-templates select="RESPONSE/CONTAINER" mode="tabs">
				  <xsl:with-param name="content" select="RESPONSE"/>
				</xsl:apply-templates>
			</td>
		  </tr>	
		</table>
    </i2:container>

    <xsl:call-template name="include_javascript_table_resize"/>
  </xsl:template>
  
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">
    <table id="role_table" width="100%">
      <tr>
        <td>
          <xsl:apply-templates select="DOMAIN_DETAILS_FORM/SEARCH">
            <xsl:with-param name="formName" select="'result_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>
  
  <!--*************************************************************************
  ***************************************************************************** -->
  <xsl:template match="USER_GRP_PROFILE">
      <table border="0" width="50%" cellspacing="0">
        <tr>
          <td nowrap="nowrap" width="35%"><i18n:text>UserSecurity.User_Group_Name</i18n:text> :</td> 
          <td nowrap="nowrap" align="left" width="65%"><xsl:value-of select="GRP_NAME/@Value"/></td>
        </tr>
        <tr>
          <td nowrap="nowrap" width="35%"><i18n:text>UserSecurity.User_Group_Description</i18n:text> :</td> 
          <td nowrap="nowrap" align="left" width="65%"><xsl:value-of select="DESCRIPTION/@Value"/></td>
        </tr>
        <tr>
        	<td colspan="2">&#xA0;</td>
        </tr>	
      </table>
  </xsl:template>
  
  <!--*********************************************************************** 
 	*********************************************************************** -->
  <xsl:template name="include_javascript_table">
    <script>
    var one_node_mesg = '<i18n:text>UserSecurity.Select_One_Node</i18n:text>';
    
    function onSave()
    {
		document.result_form.action= "user_group_domain/saveDomainDetails.cmd?TO_RETURN=NO";
		document.result_form.submit();
    }

    function onSaveAndReturn()
    {
		document.result_form.action= "user_group_domain/saveDomainDetails.cmd?TO_RETURN=YES";
		document.result_form.submit();
    }

    function onCancel()
    {
		document.forms.result_form.WHERE.value = 'ONCANCEL';
		document.forms.result_form.action = omxContextPath + '/omx/user_admin/user_group_domain/goToPage.cmd';
		document.forms.result_form.submit();
    }

    function onAddNodes(){
      document.forms.result_form.WHERE.value = 'DOMAIN_NODES_SEARCH';
      document.forms.result_form.DO_SEARCH.value = 'No';
      document.result_form.action="user_group_domain/goToPage.cmd?ACTION=GET_DIMENSION";
      document.result_form.submit();
    }
    
    function showTab(ntype)
   	{
 		document.result_form.SELECTED_TAB.value = ntype;
 		document.result_form.submit();  		
   	}
   	
   	function onRemoveNodes()
   	{
   		if(checkifAnySelected(document.result_form)) {
            document.result_form.action = "user_group_domain/removeNodes.cmd";
            document.result_form.submit();   			
   		}
   		else {
        	core_alert(one_node_mesg);
        }
   	}
  </script>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
  <!-- Javascript -->
  <xsl:template name="include_javascript_table_resize">
    <script><![CDATA[
    function resize_Containers()
    {
      var width = document.body.offsetWidth - 40;
      var height = document.body.offsetHeight - 300;
      //alert("hello");
     var table_id = 'result_form_table';
     i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null);
     i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight - 250, null, document.body.offsetWidth - 25, true, 'yes');

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
             form.elements[count].name != "SELECT_ALL"  ){
              foundChecked = true;
              break;
           }
        }
        return foundChecked;
   }
  ]]></script>
  </xsl:template>
  
 <!--***********************************************************************
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

 <!--***********************************************************************
  *********************************************************************** -->
  <xsl:template match="ERROR_MESSAGE">
        <i2:img src="/alert_green_static.gif" border="0" align="middle">
          <i2:attribute name="alt">
            <i18n:text>Error</i18n:text>
          </i2:attribute>
        </i2:img>
        &#xA0;
        <i18n:text>
          <xsl:value-of select="@Value"/>
        </i18n:text>
  </xsl:template>
  
  <!-- ***************************************************************************
  ******************************************************************************* -->
</xsl:stylesheet>
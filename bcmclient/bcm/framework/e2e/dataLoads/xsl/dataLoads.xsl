<?xml version="1.0" standalone='no'?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
<xsl:import href="../../../queryform/xsl/searchformfilter.xsl"/>
  <xsl:import href="../../../../context/xsl/context_header.xsl"/>
  <xsl:import href="../../../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>
    
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_dataLoads"/>
  </xsl:template>
  
  
  <!-- **********************************************************************-->
  <!-- Container Content -->
  <xsl:template match="RESPONSE" mode="container_content">
     <table cellpadding="0" width="100%">
        <tr>
	  <table  width="100%" border="1">
			<tr>
				  <td width="50%">
					<xsl:apply-templates select="LOAD_DTLS"/>
				  </td>
				  <td width="50%">
				   <table valign="top" align="left" height="100%">
				  <tr>
				  <td height="100%">
				  <i2:container id="TestLoad" inner="yes" title="" scrollable="yes">
		   		
					<xsl:apply-templates select="LOAD_TAB" />
				  </i2:container>
				  </td>
				</tr>
				</table>
				   
			 </td>
			</tr>
			</table>
        </tr>
    </table>
		
			<xsl:apply-templates select="SEARCH">
			    <xsl:with-param name="formName" select="'result_form'"/>
			</xsl:apply-templates>
	
   
  </xsl:template>
  
  <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template name="onLoad_js">   
          function onLoad()
          {
	  resize_Containers();
	  enableButton('preLoad');
          //i2uiResizeScrollableArea('txns_table',y,x,null,20,null,null,25);
          }
   </xsl:template>
   <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template name="onResize_js">
    function onResize()
    {
      resize_Containers();
    }
  </xsl:template>   
  
    <xsl:template match="SUCCESS_MESSAGE">
       <i2:img src="/alert_green_static.gif" border="0" align="left">
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
       <i2:img src="/alert_static.gif" border="0" align="left">
         <i2:attribute name="alt">
           <i18n:text>Error</i18n:text>
         </i2:attribute>
       </i2:img>
           &#xA0;
           <i18n:text>
         <xsl:value-of select="@Value"/>
       </i18n:text>
     </xsl:template>
  
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_dataLoads">
     <script>
         function resize_Containers()
     {   
	    
		var height = document.body.offsetHeight/3 - 30;
        var width = document.body.offsetWidth - 50;
		//i2uiResizeScrollableArea('TestTbs', 170, 800, null, null, null,null, null); 
              i2uiResizeScrollableContainer('TestConTbs',document.body.offsetHeight - 300 , null, width + 15, true, 'yes');
	          i2uiResizeScrollableContainer('TestLoad',100 , null, 400, true, 'yes');
	
		
		resizeScrollableTables();
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
        }
       }
       
       function prepareDataLoad()
       {
	disableButton('preLoad');
        document.result_form.target="appFrame";

        var comfirmMsg = 'Do you want to start the prepare load process?';
        if( core_confirm( comfirmMsg ) == 'yes' )
        {
            document.result_form.action=omxContextPath+ "/bcm/framework/e2e/dataLoads/view/prepareLoad.cmd";
            document.result_form.submit();
        }
            
       }

	   function startDataLoad()
       {
         disableButton('preLoad');
	 disableButton('startLoad');
        document.result_form.target="appFrame";
        //document.result_form.DO_SEARCH.value='Yes';
        //document.result_form.LOAD_ID.value=0;

        var comfirmMsg = 'Do you want to start the data load process?';
        if( core_confirm( comfirmMsg ) == 'yes' )
        {
            document.result_form.action=omxContextPath+ "/bcm/framework/e2e/dataLoads/view/startDataLoadWf.cmd";
            document.result_form.submit();
        }
          
       }
         
        function disableButton(id)
          {
            javascript:i2uiToggleItemVisibility( id, 'hide');javascript:i2uiToggleItemVisibility(id + '_disabled', 'show');
          }
          
          function enableButton(id)
          {
            javascript:i2uiToggleItemVisibility( id, 'show');javascript:i2uiToggleItemVisibility(id + '_disabled', 'hide');
	  }

function i2uiToggleItemVisibility(id,state)
{
  var item;

  if (document.layers)
  {
    item = document.layers[id];
    if (item != null)
    {
      if (state == null)
      {
        if (item.visibility == 'hide')
        {
          item.visibility = 'show';
        }
        else
        {
          item.visibility = 'hide';
        }
      }
      else
      {
        item.visibility = state;
      }
    }
    return;
  }

  item = document.getElementById(id);
  if (item != null)
  {
    // setting display to none or "" can damage the DOM for
    // Netscape 6.  you may want to consider the visibility
    // attribute instead.
    if (state == null)
    {
      if (item.style.display == "none")
      {
        item.style.display = "";
        item.style.visibility = "visible";
      }
      else
      {
        item.style.display = "none";
      }
    }
    else
    {
      if (state == 'show')
      {
        item.style.display = "";
        item.style.visibility = "visible";
      }
      else
      {
        item.style.display = "none";
      }
    }
  }
}
       
   </script>
  </xsl:template> 
  
	<!--**************************************************-->
<!-- This is the first table-->
	<xsl:template match="LOAD_DTLS">
          <i2:container	id="loadCtrDtls" inner="yes" title="Load Details" editable="false" scrollable="yes">
		<table id="loadDtls" >

			<tr>
				<td>
					<table>
						<tr >
							<td class="tableRow0">
							  <i18n:text>Load Id</i18n:text> :
							</td>
						</tr>

						<tr>
							<td class="tableRow0">
							  <i18n:text>Load Name</i18n:text> : 
							</td>
						</tr>

						<tr>
							<td class="tableRow0">
								<i18n:text>Prepare for Load </i18n:text> : 
							</td>
						</tr>
					
						<tr>
							<td class="tableRow0">
							<i18n:text>Source </i18n:text> : 
							</td>
						</tr>

						<tr>
							<td class="tableRow0">
								<i18n:text>Last Run Status </i18n:text> :
							</td>
						</tr>
					</table>
                </td>
				<td>
					<table>
						<tr>
							<td>
							  <input class="smalldisplayField" type="field" name="LOAD_ID" value="{RESPONSES/RESPONSE/RESPONSE/SYS_DATA_LOAD_INSTANCE/LOAD_ID/@Value}" size="15" disabled="true"/> 
							  <!--<xsl:value-of select="RESPONSES/RESPONSE/RESPONSE/SYS_DATA_LOAD_INSTANCE/LOAD_ID/@Value"/> -->
							</td>
						</tr>
						<tr>
							<td>
							 <input class="smalldisplayField" type="field" name="NAME" value="{RESPONSES/RESPONSE/RESPONSE/SYS_DATA_LOAD_INSTANCE/NAME/@Value}" size="15" disabled="true"/> 
							  <!-- <xsl:value-of select="RESPONSES/RESPONSE/RESPONSE/SYS_DATA_LOAD_INSTANCE/NAME/@Value"/> -->
							</td>
						</tr>

						<tr>
							<td>
								<input class="smalldisplayField" type="field" name="STATUS" value="{RESPONSES/RESPONSE/RESPONSE/LOAD_HISTORY/STATUS/@Value}" size="15" disabled="true"/> 
							  <!-- <xsl:value-of select="RESPONSES/RESPONSE/RESPONSE/LOAD_HISTORY/STATUS/@Value"/> -->
							</td>
						</tr>
					
						<tr>
							<td>
							<input class="smalldisplayField" type="field" name="SOURCE" value="{RESPONSES/RESPONSE/RESPONSE/SYS_DATA_LOAD_INSTANCE/SOURCE/@Value}" size="15" disabled="true"/> 
							  <!-- <xsl:value-of select="RESPONSES/RESPONSE/RESPONSE/SYS_DATA_LOAD_INSTANCE/SOURCE/@Value"/> -->
							</td>
						</tr>

						<tr>
							<td>
								<input class="smalldisplayField" type="field" name="STATUS" value="{RESPONSES/RESPONSE/RESPONSE/WORKFLOW_STATUS/STATUS/@Value}" size="15" disabled="true"/> 
							  <!-- <xsl:value-of select="RESPONSES/RESPONSE/RESPONSE/WORKFLOW_STATUS/STATUS/@Value"/> -->
							</td>
						</tr>
					</table>
                </td>
			</tr>
         </table>
          </i2:container>
     </xsl:template>
 
     <!--**************************************************-->

	<!-- This is the second table-->
     <xsl:template match="LOAD_TAB">
       <i2:container id="loadCtrTbs" inner="yes" title="Tables In Load" scrollable="yes">
		<table id="loadTbs">

		  <xsl:for-each select="RESPONSES/RESPONSE/RESPONSE/SYS_DATA_LOAD_TAB_COLUMNS">
			<tr>
				<td>
				  <xsl:value-of select="TABLE_ID/@Value"/>
                </td>
			</tr>
		  </xsl:for-each>

         </table>
       </i2:container>
     </xsl:template>
 
</xsl:stylesheet>

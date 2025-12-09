<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../core/xsl/container.xsl"/>
  
  <xsl:import href="../../templates/xsl/templateParameters.xsl"/>
  
  <xsl:output method="html"/>
  
  <xsl:variable name="data_type">
  	<xsl:value-of select="//RESPONSES/RESPONSE/DATA_TYPE/@Value" />
  </xsl:variable>
  <xsl:variable name="display_name">
  	<xsl:value-of select="//RESPONSES/RESPONSE/DISPLAY_NAME/@Value" />
  </xsl:variable>

  <!-- Entry Point -->
  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  	<script type="text/javascript">
  	function trimString (str) {
    		str = this != window? this : str;
    		return str.replace(/^\s+/g, '').replace(/\s+$/g, '');
  	}
  	
  	function uploadFile()
  	{	
  		if (document.serverUploadForm.serverFile.value != null &amp; trimString(document.serverUploadForm.serverFile.value) != "")
  		{
  		  document.serverUploadForm.action="server_upload_file_result.jsp";
  		  document.serverUploadForm.submit();
  		}
  		else
  		  core_alert("Please enter the server file path");
  	}
  	</script>
  </xsl:template>

  <!-- ********************************************************************** 
       ********************************************************************** --> 
  <xsl:template match="RESPONSE" mode="container_content">  
    <xsl:variable name="uploadCaption">
      <i18n:text>Upload File for</i18n:text>
      <i18n:text>:</i18n:text>&#xA0;
      <i18n:text><xsl:value-of select="DISPLAY_NAME/@Value"/></i18n:text>
    </xsl:variable>
	
    <!-- Upload File -->
    <table width="100%" border="0" cellpadding="5" cellspacing="0">
      <tr>
        <form name="serverUploadForm" method="POST">
          <input type="hidden" name="TEMPLATE" value="{TEMPLATE_NAME/@Value}"/>
          <input type="hidden" name="DATA_TYPE" value="{DATA_TYPE/@Value}"/>
          <input type="hidden" name="DISPLAY_NAME" value="{DISPLAY_NAME/@Value}"/>
          <td>
            <i2:container title="{$uploadCaption}">
              <i2:table>
                <i2:tr>
                  <td>
                    <table>
                      <tr>
                        <td colspan="3"><b> <i18n:text>Step 1</i18n:text>: </b>  <i18n:text>Enter the</i18n:text>&#xA0; <i18n:text>FILE_TYPE.<xsl:value-of select="$data_type"/></i18n:text>&#xA0;<i18n:text>file you wish to upLoad from the staging server</i18n:text>.</td>
              				</tr>
              				<tr>
              					<td>
              						<input type="field" class="inputfieldIE" name="serverFile" size="40"/>
              					</td>
              				</tr>
              			</table>
              			<table>
              				<tr>
              					<td><b> <i18n:text>Step 2</i18n:text>: </b> 
              					 	<i18n:text>Click the upload button below to upLoad the selected file</i18n:text>.
              					</td>
              				</tr>
              			</table>		
          		    </td>
                </i2:tr>
          		</i2:table>
        	  </i2:container>
        	</td>
      	</form>
    	</tr>
  	</table>
  
  	<!-- Template Details -->
  	<table width="100%" border="0" cellpadding="2" cellspacing="0">
    	<tr>
        <td>
          <xsl:apply-templates select="TEMPLATE"/>
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
    <xsl:call-template name="javascript_onLoad_tab"/>
    <xsl:call-template name="javascript_onLoad_page"/>
    }
  </xsl:template>


  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="onResize_js">

    function onResize()
    {
    <xsl:call-template name="javascript_onResize_tab"/>
    <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>


  <!-- Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="javascript_onLoad_tab">
    <xsl:call-template name="javascript_resizeTabs"/>
  </xsl:template>


  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="javascript_onResize_tab">
    <xsl:call-template name="javascript_resizeTabs"/>
  </xsl:template>
</xsl:stylesheet>

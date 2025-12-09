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
    <xsl:value-of select="/RESPONSES/RESPONSE/DATA_TYPE/@Value" />
  </xsl:variable>
  <xsl:variable name="display_name">
    <xsl:value-of select="/RESPONSES/RESPONSE/DISPLAY_NAME/@Value" />
  </xsl:variable>

  <!-- Entry Point -->
  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <script type="text/javascript">

    function trimString (str) {
        str = this != window? this : str;
        return str.replace(/^\s+/g, '').replace(/\s+$/g, '');
    }

    function uploadFile()
    {
      if (document.localUploadForm.userFile.value != null &amp; trimString(document.localUploadForm.userFile.value) != "")
      {
        var tempName = document.localUploadForm.TEMPLATE.value;
        var fileName = document.localUploadForm.userFile.value;
        var dataType = document.localUploadForm.DATA_TYPE.value;
        var displayName = document.localUploadForm.DISPLAY_NAME.value;
        document.localUploadForm.action="local_upload_file.jsp?TEMPLATE_NAME=" + tempName +"&amp;FILE_PATH=" + fileName + "&amp;DATA_TYPE=" + dataType + "&amp;DISPLAY_NAME=" + displayName;
        document.localUploadForm.submit();
      }
      else
        core_alert("Please enter the file to upload");
    }

    function templateDetails()
    {
      var tempName = document.localUploadForm.TEMPLATE.value;
      document.localUploadForm.action="../templates/template_details.jsp?TEMPLATE_NAME=" + tempName;
      document.localUploadForm.submit();
    }    
    </script>
    <xsl:apply-templates select="RESPONSE/CONTAINER">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- **********************************************************************
       ********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">
    <xsl:variable name="templateCaption">
      <i18n:text>Template Details</i18n:text>
    </xsl:variable>
    <xsl:variable name="uploadCaption">
      <i18n:text>Upload File for</i18n:text>
      <i18n:text>:</i18n:text>&#xA0;
      <i18n:text><xsl:value-of select="DISPLAY_NAME/@Value"/></i18n:text>
    </xsl:variable>

    <!-- Upload File -->
    <table width="100%" border="0" cellpadding="2" cellspacing="0">
      <tr>
        <form name="localUploadForm" enctype="multipart/form-data" method="POST">
          <input type="hidden" name="TEMPLATE" value="{TEMPLATE_NAME/@Value}"/>
          <input type="hidden" name="DATA_TYPE" value="{DATA_TYPE/@Value}"/>
          <input type="hidden" name="DISPLAY_NAME" value="{DISPLAY_NAME/@Value}"/>
          <td>
            <i2:container title="{$uploadCaption}">
              <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableRow1">
                <tr>
                  <xsl:choose>
                    <xsl:when test="ALERTS/MESSAGE/@Value and count(ALERTS/ALERT) > 0">
                      <td align="left" width="100%">
                        <font color="{ALERTS/FONT_COLOR/@Value}">
                          <i18n:text><xsl:value-of select="ALERTS/MESSAGE/@Value"/></i18n:text>
                        </font>
                      </td>
                    </xsl:when>
                  </xsl:choose>
                </tr>
              </table>
              <i2:table>
                <i2:tr>
                  <td>
                    <table>
                      <tr>
                        <td colspan="3"><b> <i18n:text>Step 1</i18n:text>:</b>  <i18n:text>Click Browse... and select the</i18n:text>&#xA0; <i18n:text>FILE_TYPE.<xsl:value-of select="$data_type"/></i18n:text>&#xA0;<i18n:text>file you wish to upLoad</i18n:text>.</td>
                      </tr>
                      <tr>
                        <td>
                          <input type="file" class="inputfieldIE" name="userFile" size="40"/>
                        </td>
                      </tr>
                    </table>
                    <table>
                      <tr>
                        <td><b> <i18n:text>Step 2</i18n:text>:</b>
                            <i18n:text>Click the upload button below to upload the selected file</i18n:text>.
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
    <xsl:choose>
    	    <xsl:when test="./SHOW_TEMPLATE_FIELDS/@Value = 'yes'">
    	    </xsl:when>
    	    <xsl:otherwise>
		    <xsl:if test="$data_type = 'CSV'">
		      <table width="100%" border="0" cellpadding="2" cellspacing="0">
			<tr>
			  <td>
			    <xsl:apply-templates select="TEMPLATE"/>
			  </td>
			</tr>
		      </table>
		    </xsl:if>
    	    </xsl:otherwise>
    </xsl:choose>
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

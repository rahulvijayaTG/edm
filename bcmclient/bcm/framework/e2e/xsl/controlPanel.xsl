<?xml version="1.0" standalone='no'?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

<xsl:import href="../../queryform/xsl/searchformfilter.xsl"/>
  <xsl:import href="../../../context/xsl/context_header.xsl"/>
  <xsl:import href="../../../../core/xsl/error.xsl"/>
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
      <xsl:if test="count(SUCCESS_MESSAGE) &gt; 0">
        <tr>
          <td>
            <xsl:apply-templates select="SUCCESS_MESSAGE"/>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="count(ERROR_MESSAGE) &gt; 0">
        <tr>
          <td>
            <xsl:apply-templates select="ERROR_MESSAGE"/>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td>
        <table>
          <xsl:if test="string-length(/RESPONSES/RESPONSE/WF_START_TIME/@Value) &gt; 0">
          <tr>
            <td style="padding:2px;">
                <i18n:text>Data Load WorkFlow start time</i18n:text>: <i18n:date format='datetime'><xsl:value-of select="/RESPONSES/RESPONSE/WF_START_TIME/@Value"/></i18n:date>
            </td>
          </tr>
          </xsl:if>

         </table>
         </td>
      </tr>
    </table>

    <table cellpadding="0" width="100%">
    <tr>
        <td>
	 <xsl:apply-templates select="SEARCH">
		    <xsl:with-param name="formName" select="'result_form'"/>
	 </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template name="onLoad_js">
          function onLoad()
          {
          resize_Containers();
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

	    function dispatchSearch()
	    {
			document.result_form.DO_SEARCH.value='Yes';
			document.result_form.START_COUNT.value=0;
			document.result_form.action="controlPanel.jsp?PAGE=controlPanel";
			document.result_form.submit();
	   }


		function dispatchClear()
        {
		  document.search_form.F_SYS_DATA_LOAD_INSTANCE_LOAD_ID.value='';
		  document.search_form.F_SYS_DATA_LOAD_INSTANCE_NAME.value='';
		  document.search_form.submit();
        }


   <![CDATA[

    function loadDetails(selectedDoc)
    {
		document.result_form.target="appFrame";
		document.result_form.CURRENT_ID.value = selectedDoc;
        document.result_form.action=omxContextPath+ "/bcm/framework/e2e/dataLoads/view/loadDetails.cmd?MODE=START&PAGE=dataLoads";
        document.result_form.submit();
    }
    ]]>
   </script>
  </xsl:template>

</xsl:stylesheet>

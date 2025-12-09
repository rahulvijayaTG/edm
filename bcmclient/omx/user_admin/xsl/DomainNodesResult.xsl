<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:lxslt="http://xml.apache.org/xslt"
    xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
    xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
    extension-element-prefixes="i2 i18n" version="1.0">

<xsl:import href="../../../bcm/framework/queryform/xsl/searchformfilter.xsl"/>
    
  <xsl:template match="RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
    <xsl:call-template name="include_javascript_table_resize"/>
    <xsl:call-template name="include_javascript_noderesults"/>
  </xsl:template>
  
  <!-- **********************************************************************-->
  <xsl:template match="RESPONSE" mode="container_content">
    <table id="BOR_table" width="100%">
      <xsl:if test="count(ERROR_MESSAGE) &gt; 0">
        <tr>
          <td>
            <xsl:apply-templates select="ERROR_MESSAGE"/>
          </td>
        </tr>
      </xsl:if>
    </table>
    <table cellpadding="0" width="100%">
      <tr>
        <td>
          <xsl:apply-templates select="NODE_RESULT_FORM/SEARCH">
          	<xsl:with-param name="formName" select="'result_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="include_javascript_noderesults">
    <script><![CDATA[
    function onSelectAndReturn()
   	{
		if ( checkifAnySelected(result_form) == true )
        {
        	document.forms.result_form.target = 'appFrame';
        	document.forms.result_form.ACTION.value = 'ADD_NODES';
    		document.forms.result_form.action = omxContextPath + '/omx/user_admin/domain_nodes_search/addDomainNodes.cmd';
    		document.forms.result_form.submit();
    	} else {
							]]>
          core_alert("UserSecurity.Select_One_Node");
        }   		
   	}
   	<![CDATA[
   	function onCancel()
   	{
       	document.forms.result_form.target = 'appFrame';
   		document.forms.result_form.action = omxContextPath + '/omx/user_admin/domain_nodes_search/goToPage.cmd?WHERE=ASSIGN_DOMAIN';		   		
   		document.forms.result_form.submit();
   	}
   	
	function SetfocusSubmit( target )
	{   
		parent.searchFrame.onSearch();
	}     	
    ]]></script>
  </xsl:template>

  <!-- **********************************************************************
      *********************************************************************** -->
  <xsl:template name="include_javascript_table_resize">
    <script><![CDATA[
    function resize_Containers()
   {
    var table_id = 'result_form_table';
    var width = document.body.offsetWidth -5 ;
    var height = document.body.scrollHeight;
    // resize table approx
    i2uiResizeScrollableArea(table_id, height-140, width-40, null, null, null,null, null);
    i2uiResizeScrollableContainer('result_form_container',document.body.offsetHeight-200, null, document.body.offsetWidth - 30, true, 'yes');
   }

	function getRecords(actionName, startCount, result_form, page_form)
	{
		if(page_form == null)  page_form = document.result_form;
		if(result_form == null)  result_form = document.search_form;
		if(result_form == null)  result_form = document.result_form;
		jumpToPage(actionName, startCount, result_form, page_form);
	}

	function jumpToPage(actionName, startCount, result_form, page_form)
	{
		//alert("jumpToPage called");
		var nextCount = parseInt(startCount) + 15;
		var prevCount = 0;
		if ( parseInt(startCount) > 0 )
			prevCount = parseInt(startCount) - 15;

		if (startCount == null)
		  startCount=page_form.pagenum.value;

		var pagenum= parseInt(startCount);  pagenum--;

		if (actionName == "jump")
		{
		  if(( page_form.RECORD_COUNT.value == 0 || page_form.RECORD_COUNT.value > pagenum*15)  && (pagenum+1>0) && (page_form.START_COUNT.value != pagenum*15))
		  {
			  result_form.DO_SEARCH.value='yes';
			  result_form.START_COUNT.value=pagenum*15;
			  result_form.method="POST";
			  result_form.submit();
			}
		}
	}
  ]]></script>
  </xsl:template>

 <!--*************************************************************************
        ************************************************************************* -->
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
<!-- **********************************************************************
	 ***********************************************************************-->
</xsl:stylesheet>
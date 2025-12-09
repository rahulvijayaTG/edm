<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" version="1.0">
  <xsl:import href="../../../bcm/framework/queryform/xsl/searchformfilter.xsl"/>
  <xsl:import href="../../../bcm/context/xsl/context_header.xsl"/>
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
      <xsl:if test="count(SUCCESS_MESSAGE) &gt; 0">
      	<tr>
        	<td>          		
          		<xsl:apply-templates select="SUCCESS_MESSAGE"/>
        	</td>
      	</tr>
      </xsl:if>
            	
      <tr>
        <td>
          <xsl:apply-templates select="SEARCH">
              <xsl:with-param name="formName" select="'result_form'"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>
  
 <!-- ***********************************************************************
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
  
  <!-- page.xsl Javascript -->
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
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template name="include_javascript_form">
    <script>
        <![CDATA[
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
        
        function dispatchClear()
        {
          clearFields(search_form);
          onSearch();
        }
         
        function clearFields(form)
        {
          var count;
          var elementsLen = form.elements.length;
          var foundChecked = false;          
          for(count = 0; count < elementsLen; count++)
          {
            if( form.elements[count].type == "checkbox" )
            {
              form.elements[count].checked = false;
            }
            if( form.elements[count].type == "text" )
            {
              form.elements[count].value = '';
            }
            if(form.elements[count].type == "select-one")
            {
              form.elements[count].selectedIndex = -1;
            }
          }
        }
        
      	function trimFilterElements()
    	{
      		var elements = document.search_form.elements;
      		var elementCount = elements.length;
      		for (var i = 0; i < elementCount; i++) {
        		elements[i].value = trimString(elements[i].value);
      		}
    	}
    	
    	function onCreate()
    	{
      		document.result_form.target="appFrame";
      		document.result_form.method="POST";
      		document.result_form.action="user_role_details/display.cmd?CREATE_NEW=Yes";
      		document.result_form.submit();
    	}    	
       ]]>
  </script>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
  <!-- Javascript -->
  <xsl:template name="include_javascript_table_resize">
    <script><![CDATA[
    function resize_Containers()
   {
   resizeScrollableTables();
      }
  ]]></script>
  </xsl:template>
  <!-- **********************************************************************
      *********************************************************************** -->
</xsl:stylesheet>
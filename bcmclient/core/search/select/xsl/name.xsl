<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../core/xsl/container.xsl"/>
  
  <xsl:output method="html"/>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match = "RESPONSES" mode="content">
    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>

    <xsl:call-template name="include_javascript_current"/>
    <xsl:call-template name="include_javascript_resize"/>

  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match = "RESPONSE" mode="container_content">
    
    <table><tr><td>
          <form name="form"  method="post" target="appFrame" action="name/controller/ok.x2c">

            <xsl:call-template name="hide_request_parameters"/>
            
            <table>
              <tr>
                <td align="RIGHT" nowrap="yes"> &#xA0; <i18n:text>Please specify a name for the Search</i18n:text>:&#xA0;</td>
                <td align="RIGHT">
                  <input type="field" class="inputFieldIE" name="NAME" size="20"/>
                </td>
              </tr>
              <tr>
                <td colspan="2" height="20">
                </td>
              </tr>
            </table>
          </form>
        </td></tr></table> 
    
  </xsl:template>


  <!-- Current.xsl -->
  <!-- ********************************************************************** 
     *********************************************************************** -->  
  <xsl:template name="include_javascript_current">
    <script>
      function onOk()
      {
        document.form.action="name/controller/ok.x2c";
        document.form.target="appFrame";
        document.form.submit();
      }
      function onCancel()
      {
        onBack();
      }

    </script>
  </xsl:template>
  
<!-- page.xsl Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="include_javascript_onLoad">  
    <script>
      function onLoad()
      {
        onLoadSuper();//Page.xsl
        resizeContainers();
        setFocus();
      }
    </script>
  </xsl:template>
  
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template name="include_javascript_onResize">  
    <script>
      function onResize()
      {
        onResizeSuper();//Page.xsl
        resizeContainers();
      }
    </script>
  </xsl:template>
  

  
  <!-- Container.xsl --> 
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="include_javascript_resize">
    <script>
    function resizeContainers()
    {
      height= document.body.offsetHeight - 90;
      width=document.body.offsetWidth -20;
      if (width > 460)   width=460;
      i2uiResizeScrollableContainer('container',height, null, width, true, 'yes'); 
    }
    </script>
  </xsl:template>
  
  
<!-- ********************************************************************** 
     *********************************************************************** -->  
</xsl:stylesheet> 

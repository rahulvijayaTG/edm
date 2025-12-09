<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
 
  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../framework/xsl/core_container_override.xsl"/>

  <xsl:output method="html"/>  
                     
  <!-- Page Content -->     
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">
     <xsl:call-template name="include_javascript_table_resize"/>
     <xsl:call-template name="include_javascript_table"/>
     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>
  </xsl:template>
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <!-- Container Content -->
   <xsl:template match = "RESPONSE" mode="container_content">
      <i2:table id="refresh_table"  scrollable="true" width="100%" height="100%" cellpadding="0" cellspacing="5">
        <i2:tr>
          <td>
            <xsl:if test="not(./MESSAGE/@Value)">
              <i18n:text>The Outbound Staging table synchronization has started.</i18n:text>
            </xsl:if>
            <xsl:apply-templates select="MESSAGE">
            </xsl:apply-templates>
          </td>
        </i2:tr>
      </i2:table>
   </xsl:template>
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template match = "MESSAGE">
     <i18n:text>
       <xsl:value-of select="@Value"/>
     </i18n:text>
   </xsl:template>

  <!-- custom javascript -->  
  <!-- ********************************************************************** 
       *********************************************************************** --> 
       
  <xsl:template name="include_javascript_table">  
  <script>
       <!-- ISSUE 533162 -->
      var confirmMesg = "OUTBOUND_MSG";
      function onCancel()
      {
        document.location.href="../framework/home.jsp";
      }
      function onStartRefresh()
      {
        if( core_confirm( confirmMesg ) == 'yes' )
        { 
          document.location.href="outboundStagingRefreshPage.jsp?REFRESH=yes";
        }
      }
  </script>  
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
      <xsl:call-template name="javascript_onResize_page"/>
      resize_Containers();
    }
  </xsl:template>
 <!-- ********************************************************************** 
      *********************************************************************** -->
  <!-- Javascript -->
  <xsl:template name="include_javascript_table_resize">
  <script>
  
  <![CDATA[
  function resize_Containers()
  {
   var width = document.body.offsetWidth - 25;  
   var height = document.body.scrollHeight;
   i2uiResizeScrollableContainer('containerOuter',height, null, width, true, 'yes');
  }
  
  ]]>
  </script>
</xsl:template>
 <!-- ********************************************************************** 
      *********************************************************************** -->
</xsl:stylesheet>   

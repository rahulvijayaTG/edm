<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../framework/xsl/core_container_override.xsl"/>

  <xsl:output method="html"/>

  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">
     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>

     <xsl:call-template name="include_javascript_table_resize"/>
      <xsl:call-template name="include_javascript_table"/>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <!-- Container Content -->
   <xsl:template match = "RESPONSE" mode="container_content">
     <xsl:if test="string-length(ERROR_MESSAGE/@Value) > 0 ">
         <font color="red"><i18n:text><xsl:value-of select="ERROR_MESSAGE/@Value"/></i18n:text></font>
     </xsl:if>

           <i2:table id="linksTable" border="0" cellpadding="0" cellspacing="0" align="right" scrollablerows="yes" scrollablecolumns="auto">
               <i2:tr header="yes">
                 <td nowrap="yes" ><i18n:text><xsl:value-of select=" 'Linked Document' "/></i18n:text></td>
                 <td nowrap="yes" ><i18n:text><xsl:value-of select=" 'From Property' "/></i18n:text></td>
                 <td nowrap="yes" ><i18n:text><xsl:value-of select=" 'To Property' "/></i18n:text></td>
               </i2:tr>
               <xsl:apply-templates select="DOCUMENTLINK"/>
           </i2:table>

  </xsl:template>

  <xsl:template match="DOCUMENTLINK">
    <xsl:variable name="url">
      <xsl:value-of select="concat('tableeditor.jsp?DO_SEARCH=Yes&amp;TABLE_NAME=',
      @Name,'&amp;SERVICE=',../SERVICE/@Value, '&amp;FROM_COLUMN_LINK=yes' ,@URLSuffix)"/>
    </xsl:variable>
    <i2:tr>

      <xsl:variable name="fromProperty">
        <xsl:choose>
          <xsl:when test="string-length(MAP_PROPERTY/@FromDisplayName) > 0">
            <xsl:value-of select="MAP_PROPERTY/@FromDisplayName"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="MAP_PROPERTY/@From"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="toProperty">
        <xsl:choose>
          <xsl:when test="string-length(MAP_PROPERTY/@ToDisplayName) > 0">
            <xsl:value-of select="MAP_PROPERTY/@ToDisplayName"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="MAP_PROPERTY/@To"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <td nowrap="yes" ><a href="{$url}"><i18n:text><xsl:value-of select="@DisplayName"/></i18n:text></a></td>
      <td nowrap="yes" ><i18n:text><xsl:value-of select="$fromProperty"/></i18n:text></td>
      <td nowrap="yes" ><i18n:text><xsl:value-of select="$toProperty"/></i18n:text></td>

<!--
      <td nowrap="yes" ><xsl:value-of select="MAP_PROPERTY/@From"/></td>
      <td nowrap="yes" ><xsl:value-of select="MAP_PROPERTY/@To"/></td>
-->
    </i2:tr>
  </xsl:template>
<!-- custom javascript -->

  <!-- **********************************************************************
       *********************************************************************** -->
    <xsl:variable name="returnUrl">
      <xsl:value-of select="concat('tableeditor.jsp?DO_SEARCH=Yes&amp;TABLE_NAME=',
      @Name,'&amp;SERVICE=',../SERVICE/@Value, '&amp;', 'F_', MAP_PROPERTY/@To,'=', MAP_PROPERTY/@Value)"/>
    </xsl:variable>
  <xsl:template name="include_javascript_table">
  <script>
   function onBack()
   {
        document.location.href = omxContextPath + "/bcm/framework/breadcrumb/controller/back.cmd" ;

   }
  </script>
  </xsl:template>

  <xsl:template name="onLoad_js">
    function onLoad()
    {
      resize_Containers();
    }
  </xsl:template>

  <xsl:template name="onResize_js">
    function onResize()
    {
      resize_Containers();
    }
  </xsl:template>

  <xsl:template name="include_javascript_table_resize">
  <script>

  <![CDATA[
    function resize_Containers()
    {
      var table_id = 'linksTable';
      var width = document.body.offsetWidth - 35;
      var height = document.body.offsetHeight - 220;
      // resize table   approx
      i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null);
      i2uiResizeScrollableContainer('container',document.body.offsetHeight - 50, null, width + 10, true, 'yes');
  }
  ]]>
  </script>
</xsl:template>


 <!-- **********************************************************************
      *********************************************************************** -->
</xsl:stylesheet>

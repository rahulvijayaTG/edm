<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalan="http://xml.apache.org/xalan"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                exclude-result-prefixes="xalan"
                version="1.0">


  <!-- Core -->
  <xsl:import href="../../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../../../core/xsl/mdm_buttons.xsl"/>
  <xsl:output method="html"/>

  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">

     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>
     <xsl:call-template name="include_javascript_memberHierarchy"/>
    <xsl:call-template name="include_javascript_table_resize"/>  
  </xsl:template>

   <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">

    <form name="HierarchySearchForm" method="GET">
        <input type="hidden" name="DimensionId" value="{/RESPONSES/RESPONSE/selectedDim/@Value}"/>
        <input type="hidden" name="HierarchyId" value=""/>
        <input type="hidden" name="DimensionName" />
        <input type="hidden" name="HierarchyName" />
        <input type="hidden" name="START_MEMBER_HIERARCHY" value=""/>
        <!-- Body -->
        <table>
            <tr>
                <td> <i18n:text>Select a Dimension</i18n:text><xsl:text>:</xsl:text>&#xA0; </td>
                <td nowrap="nowrap">
                    <select class="pulldown" name="selectedDim" tabIndex="">
                        <xsl:apply-templates select="/RESPONSES/RESPONSE/RESPONSE/Dimension"/>
                    </select>
                </td>
                <td>
                    <xsl:variable name="i18ntext"><i18n:text>Show Hierarchy</i18n:text></xsl:variable> 
                    <xsl:call-template name="mdmButton">
                        <xsl:with-param name="onclick" select="'javascript:onSearchHierarchy();'"/>
                        <xsl:with-param name="text" select="$i18ntext"/>
                    </xsl:call-template>
                
                    <!--i2:button id="button1" name="button1" onclick="javascript:onSearchHierarchy()">&#xA0;&#xA0;<i18n:text>Show 
                        Hierarchy</i18n:text>&#xA0;&#xA0;</i2:button-->
                </td>
                <td>&#xA0;&#xA0;&#xA0;</td>
                <xsl:if test="/RESPONSES/RESPONSE/RESPONSE/Hierarchy">
                    <td>
                        <select class="pulldown" name="hierachyList" tabIndex="">
                            <xsl:apply-templates select="/RESPONSES/RESPONSE/RESPONSE/Hierarchy"/>
                        </select>
                    </td>
                    <td>
                        <xsl:variable name="i18ntext"><i18n:text>Manage Member Hierarchy</i18n:text></xsl:variable> 
                        <xsl:call-template name="mdmButton">
                            <xsl:with-param name="onclick" select="'javascript:gotoMemberHierarchy();'"/>
                            <xsl:with-param name="text" select="$i18ntext"/>
                        </xsl:call-template>
                        <!--i2:button id="button1" name="button1" onclick="javascript:gotoMemberHierarchy()">&#xA0;&#xA0;<i18n:text>Manage Member 
                            Hierarchy</i18n:text>&#xA0;&#xA0;</i2:button-->
                    </td>
                </xsl:if>
            </tr>
        </table>
    </form>
  </xsl:template>

    <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="Hierarchy">
              <option name="HierarchyId" id="{Id/@Value}"  Value="{Id/@Value}">
                <i18n:text><xsl:value-of select="Id/@Value"/></i18n:text>:<i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
             </option>
  </xsl:template>
   <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="Dimension">
     <xsl:choose>
         <xsl:when test="/RESPONSES/RESPONSE/selectedDim/@Value = Id/@Value ">
              <option selected="yes" name="DimensionId" Value="{Id/@Value}">
                <i18n:text><xsl:value-of select="Id/@Value"/></i18n:text>:<i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
             </option>
             <script>
                 document.HierarchySearchForm.DimensionName.value = '<i18n:text><xsl:value-of select="Id/@Value"/></i18n:text>:<i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>';
             </script>
         </xsl:when>
         <xsl:otherwise>
              <option name="DimensionId" Value="{Id/@Value}">
                <i18n:text><xsl:value-of select="Id/@Value"/></i18n:text>:<i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
             </option>
         </xsl:otherwise>
     </xsl:choose>
  </xsl:template>
    <!-- **********************************************************************
         *********************************************************************** -->
      <xsl:template name="include_javascript_memberHierarchy">
      <script>

   <![CDATA[

          function onSearchHierarchy(){
            document.HierarchySearchForm.action="searchMemberHierarchy.jsp";
            document.HierarchySearchForm.submit();
          }
          function gotoMemberHierarchy(){
            document.HierarchySearchForm.START_MEMBER_HIERARCHY.value = "YES";

             var len = document.HierarchySearchForm.hierachyList.options.length;

             for( i = 0 ; i < len ; i++) {
                  if(document.HierarchySearchForm.hierachyList.options[i].selected)
                   {
                    document.HierarchySearchForm.HierarchyName.value = document.HierarchySearchForm.hierachyList.options[i].text;
                    document.HierarchySearchForm.HierarchyId.value = document.HierarchySearchForm.hierachyList.options[i].id;
                   }
             }

             /*
             var len = document.HierarchySearchForm.selectedDim.options.length;

             for( i = 0 ; i < len ; i++) {
                  if(document.HierarchySearchForm.selectedDim.options[i].selected)
                   {
                    document.HierarchySearchForm.DimensionName.value = document.HierarchySearchForm.selectedDim.options[i].text;
                    //document.HierarchySearchForm.DimensionId.value = document.HierarchySearchForm.selectedDim.options[i].id;
                   }
             }
             */   
                

            if(document.HierarchySearchForm.HierarchyId.value != null && document.HierarchySearchForm.HierarchyId.value !="")
            {
            document.HierarchySearchForm.action="memberHierarchyController/loadMemberHierarchy.cmd";
            document.HierarchySearchForm.submit();
            }
            
            //alert("HierarchyId=" + document.HierarchySearchForm.HierarchyId.value);
            //alert("HierarchyName=" + document.HierarchySearchForm.HierarchyName.value);            
            //alert("DimensionId=" + document.HierarchySearchForm.DimensionId.value);
            //alert("DimensionName=" + document.HierarchySearchForm.DimensionName.value);            
          }
    ]]>
   </script>
  </xsl:template>
  
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

  <xsl:template name="include_javascript_table_resize">
    <script><![CDATA[
    function resize_Containers()
   {
    var table_id = 'container';
    var width = document.body.offsetWidth -5 ;
    var height = document.body.scrollHeight;
    // resize table   approx
    //i2uiResizeColumns(table_id);
    //i2uiResizeScrollableArea(table_id, height-400, width-30, null, null, null,null, null);
    i2uiResizeScrollableContainer('container',document.body.offsetHeight-100, null, document.body.offsetWidth - 20, true, 'yes');

   }
  ]]></script>
  </xsl:template>
  
<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>


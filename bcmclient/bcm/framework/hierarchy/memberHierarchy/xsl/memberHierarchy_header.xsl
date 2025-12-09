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

  <xsl:output method="html"/>

  <!-- Page Content -->
  <!-- **********************************************************************
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">

     <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>
     
     <xsl:call-template name="include_javascript_memberHierarchy"/>
     
  </xsl:template>

   <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="RESPONSE" mode="container_content">


      <!-- Body -->
      <table id="top_table" border="0" cellpadding="0" cellspacing="0"  width="100%">
          <td>
            <xsl:call-template name="MEMBER_HIEARCHY_HEADER"/>
           </td>
      </table>

  </xsl:template>

    <!--**************************************************
  *********************************************************************** -->
  <xsl:template name="MEMBER_HIEARCHY_HEADER">
        <i2:table width="50%">
            <i2:tr>
                <td>
                    <b>
                        <i18n:text>Dimension</i18n:text>
                        <xsl:text>:</xsl:text>
                    </b>
                </td>
                <td>
                    <xsl:value-of select="/RESPONSES/RESPONSE/DimensionName[1]/@Value"/>
                </td>
            </i2:tr>
            <i2:tr>
                <td>
                    <b>
                        <i18n:text>Hierarchy</i18n:text>
                        <xsl:text>:</xsl:text>
                    </b>
                </td>
                <td>
                    <xsl:value-of select="/RESPONSES/RESPONSE/HierarchyName[1]/@Value"/>
                </td>
            </i2:tr>
            <i2:tr>
                <td>
                    <b>
                        <i18n:text>Current Level</i18n:text>
                        <xsl:text>:</xsl:text>
                    </b>
                </td>
                <td>
                    <xsl:apply-templates select="/RESPONSES/RESPONSE/LevelName[1]/@Value"/>
                </td>
            </i2:tr>
        </i2:table>

        &#xA0;
        
        <xsl:variable name="levelCount" select="count(/RESPONSES/RESPONSE/RESPONSE/LevelHierarchy)"/>
        <xsl:variable name="parentCount" select="count(/RESPONSES/RESPONSE/PARENT_HIERARCHY/PARENT)"/>
        <xsl:variable name="emptyLevels" select="$levelCount - $parentCount - 1"/>
        
       <i2:table id="hierarchy_table" inner="yes" scrollable="yes" >
        <i2:tr>
            <td>
                <b><i18n:text>Level Hierarchy</i18n:text><xsl:text>:</xsl:text></b>
            </td>
            <xsl:apply-templates select="/RESPONSES/RESPONSE/RESPONSE/LevelHierarchy"/>
       </i2:tr>

        <i2:tr>
            <td>
                <b><i18n:text>Parent Hierarchy</i18n:text><xsl:text>:</xsl:text></b>
            </td>
            
            <xsl:apply-templates select="/RESPONSES/RESPONSE/PARENT_HIERARCHY/PARENT"/>
            
            <td nowrap="yes">
                <b><i18n:text>You are here</i18n:text></b>
            </td>
            
            <xsl:call-template name="putTDs">
                <xsl:with-param name="count" select="$emptyLevels"/>
            </xsl:call-template>
       </i2:tr>
      </i2:table>

  </xsl:template>
  
    <xsl:template name="putTDs">
        <xsl:param name="count"/>
        <td></td>
        <xsl:if test="$count &gt; 1">
            <xsl:call-template name="putTDs">
                <xsl:with-param name="count" select="$count - 1 "/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
   <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="LevelHierarchy">
     <td nowrap="yes">
      <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
     <xsl:if test="position() != last()">
     	->
     </xsl:if>
     </td>
  </xsl:template>
   <!--**************************************************
  *********************************************************************** -->
  <xsl:template match="PARENT">
     <td nowrap="yes">
       <i18n:text><xsl:value-of select="PARENT_NAME/@Value"/></i18n:text>
     <xsl:if test="position() != last() + 1">
     	->
     </xsl:if>
     </td>
  </xsl:template>
<!-- **********************************************************************
     *********************************************************************** -->

  <xsl:template name="include_javascript_memberHierarchy"> 
  <script>
  	
  	function onLoad () {
		 i2uiResizeScrollableContainer('container',document.body.offsetHeight - 60, null, document.body.offsetWidth - 20, true, 'yes');
  	}

    function onResize() {
        onLoad();
    }  	
  </script>
  </xsl:template>  	
<!-- **********************************************************************
     *********************************************************************** -->
</xsl:stylesheet>


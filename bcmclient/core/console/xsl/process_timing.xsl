<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
    
<xsl:import href="../../xsl/page.xsl"/>
<xsl:import href="../../xsl/container.xsl"/>
    
<xsl:output method="html"/>

<!-- Entry point -->  
  <!-- ********************************************************************** 
     *********************************************************************** -->  
  <xsl:template match="RESPONSES" mode="content">

    <xsl:call-template name="include_javascript_resize"/>
    
    <xsl:apply-templates select="RESPONSE" mode="container_content"/>
  </xsl:template>   
  
  <xsl:template match="RESPONSE" mode="container_content">
    <xsl:apply-templates/>
  </xsl:template>        
    
  <xsl:template match="TIMER_STATS">  
    <xsl:variable name="title">
      Process Timings @ <xsl:value-of select="RUN_TIME/@Value"/>
    </xsl:variable>
    <i2:container title="{$title}" id="container">
      <i2:table scrollablecolumns="auto" scrollablerows="yes" id="table" width="100%" cols="4">
        <i2:tr header="yes">
          <td nowrap="yes">Name</td>
          <td nowrap="yes">Total/Count</td>
          <td nowrap="yes">Average</td>
          <td nowrap="yes">Max. Time</td>
          <td nowrap="yes">% Parent</td>
          <td nowrap="yes">% Overall</td>
        </i2:tr>
        <xsl:apply-templates select="BLOCK"/>
      </i2:table>
      <i2:footer>
        <table cellspacing="0" cellpadding="0" width="100%"  border="0">
          <tr>
            <td  align="right">
              <i2:buttonbar>
                <i2:button name="clear_button" onclick="process_timing/resetTimers.x2c">
                  <!-- Display Text -->      
                  &#xA0;Clear&#xA0;      
                </i2:button>
                <i2:buttonbardivider/>
                <i2:button name="summary_button" onclick="process_timing/summary.x2c">
                  <!-- Display Text -->      
                  &#xA0;Summary&#xA0;      
                </i2:button>
                <i2:button name="refresh_button" onclick="process_timing/goToProcessTimings.x2c" emphasized="yes">
                  <!-- Display Text -->      
                  &#xA0;Refresh&#xA0;      
                </i2:button>
              </i2:buttonbar>
            </td>
          </tr>
        </table>
      </i2:footer>
    </i2:container>   
  </xsl:template>    
  
  <xsl:template match="BLOCK">
    <xsl:param name="depth" select="'0'"/> 
    <i2:tr>    

    <xsl:variable name="nochild">  
      <xsl:choose>
        <xsl:when test="count(BLOCK) &gt; 0"> 
          <xsl:text>false</xsl:text>
        </xsl:when>
        <xsl:otherwise><xsl:text>true</xsl:text></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

      <i2:treecell depth="{$depth}" nochildren="{$nochild}">
        <xsl:value-of select="NAME/@Value"/>
      </i2:treecell>
      <td nowrap="yes">
        <xsl:value-of select="TOTAL_TIME/@Value"/>/<xsl:value-of select="NUM_RUNS/@Value"/>
      </td>
      <td nowrap="yes">
        <xsl:value-of select="AVG_TIME/@Value"/>
      </td>
      <td nowrap="yes">
        <xsl:value-of select="MAX_TIME/@Value"/>
      </td>
      <td nowrap="yes">
        <xsl:value-of select="PARENT_PERCENTAGE/@Value"/> %
      </td>
      <td nowrap="yes">
        <xsl:value-of select="TOTAL_PERCENTAGE/@Value"/> %
      </td>
    </i2:tr>
    <xsl:apply-templates select="BLOCK">
      <xsl:with-param name="depth" select="$depth+1"/>
    </xsl:apply-templates>
    <xsl:if test="(count(BLOCK) &gt; 0) and (sum(./BLOCK/PARENT_PERCENTAGE/@Value) &lt; 100)">
      <i2:tr>
        <i2:treecell column="0" depth="{$depth+1}" nochildren="true">
          Untimed processes
        </i2:treecell>
        <td nowrap="yes">
        </td>
        <td nowrap="yes">
        </td>
        <td nowrap="yes">
        </td>
        <td nowrap="yes">
          <xsl:value-of select="100-sum(./BLOCK/PARENT_PERCENTAGE/@Value)"/> %
        </td>
        <td nowrap="yes">
        </td>
      </i2:tr>
    </xsl:if>
  </xsl:template>    
  
  
   <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="include_javascript_onLoad">  
    <script>
 function onLoad()
      { 
       i2uiManageTreeTableUserFunction = 'onClickNorgie';
       i2uiToggleContentUserFunction = 'onClickNorgie';      
      i2uiCollapseTreeTable('table', 1, null, 0);
      resizeContainer();
  }      

 function onClickNorgie(item, delta)
    {
      onResize(); 
    }  
   </script>
  </xsl:template>

  
   <!-- ********************************************************************** 
  *********************************************************************** -->
  
  <xsl:template name="include_javascript_onResize">  
    <script>

      function onResize()
      {
      resizeContainer();
      }
      
    </script>
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
 <xsl:template name="include_javascript_resize">  
  <script>
  
  <![CDATA[
  // Resizing All containers 
    function resizeContainer()
    {
      table_id = 'table';
      table_container_id = 'container';
   
      var width = document.body.offsetWidth - 55;  
      var height = document.body.scrollHeight - 120;
    
      // resize table   approx
      i2uiResizeScrollableArea(table_id, height, width, null, null, null,null, null)    
      i2uiResizeColumns(table_id);
   //   i2uiResizeScrollableContainer(table_container_id,document.body.offsetHeight - 20, null, width, true, 'yes');
  }
  ]]>
  </script>
  
  </xsl:template>
</xsl:stylesheet>
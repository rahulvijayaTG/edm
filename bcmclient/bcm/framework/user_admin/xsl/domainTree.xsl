<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">
  <!-- Core -->
  <xsl:import href="../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../../bcm/framework/xsl/required_field.xsl"/>
  <xsl:import href="../../../../bcm/framework/xsl/code_master.xsl"/>
  <!--
  <xsl:import href="buttons.xsl"/>
  -->
  <!-- Errors -->
  <xsl:import href="../../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <!--
    <i2:container id="container" title="Domain Tree"/>
    -->
    <xsl:call-template name="include_javascript_domain_tree"/>
    <form name="result_form" method="POST">
      <xsl:apply-templates select="RESPONSE"/>
      <input name="node" type="hidden" value=""/>
    </form>
    <i2:popupmenu name="authDoc">
      <i2:popupmenuoption url="javascript:addNode()">
        <i2:attribute name="text">
          <i18n:text>Add Node</i18n:text>
        </i2:attribute>
      </i2:popupmenuoption>
      <i2:popupmenuoption url="javascript:removeNode()">
        <i2:attribute name="text">
          <i18n:text>Remove All Nodes</i18n:text>
        </i2:attribute>
      </i2:popupmenuoption>
    </i2:popupmenu>
    <i2:popupmenu name="nonAuthDoc">
      <i2:popupmenuoption url="javascript:removeNode()">
        <i2:attribute name="text">
          <i18n:text>Remove Node(s)</i18n:text>
        </i2:attribute>
      </i2:popupmenuoption>
    </i2:popupmenu>
  </xsl:template>
  <!-- **********************************************************************
       *********************************************************************** -->
  <xsl:template match="RESPONSE">
  <!--
    <xsl:call-template name="display_instruction_area"/>
    -->
    <i2:container id="container" title="Domain Tree" scrollable="no">
      <i2:table id="row_table" scrollable="true" width="100%" height="100%" cellpadding="1" cellspacing="0">
        <xsl:apply-templates select="AUTH_DOCS" mode="tree"/>
      </i2:table>
      <i2:footer>
        <table  id="table1" cellspacing="0" cellpadding="0" width="100%" border="0">
          <tr>
            <td>
              <xsl:apply-templates select="BUTTONS"/>
            </td>
          </tr>
        </table>
      </i2:footer>
    </i2:container>
  </xsl:template>
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="AUTH_DOCS" mode="tree">
    <xsl:apply-templates select="AUTH_DOC" mode="tree"/>
  </xsl:template>
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="AUTH_DOC" mode="tree">
    <xsl:variable name="count" select="0"/>
    <xsl:variable name="isEdit"/>
    <xsl:variable name="authDoc"/>
    <xsl:variable name="quote">'</xsl:variable>
    <xsl:variable name="nodename">
      <xsl:value-of select="./@Name"/>
    </xsl:variable>
    <xsl:variable name="authDoc" select="./@Name"/>
    <xsl:variable name="onRootClick">
      <xsl:value-of select="concat('javascript:onRootPopUp(',$quote,$nodename,$quote,')')"/>
    </xsl:variable>
    <xsl:variable name="onViewClick">
      <xsl:value-of select="concat('javascript:onPopUp(',$quote,$nodename,'#View',$quote,')')"/>
    </xsl:variable>
    <xsl:variable name="onEditClick">
      <xsl:value-of select="concat('javascript:onPopUp(',$quote,$nodename,'#Edit',$quote,')')"/>
    </xsl:variable>
    <xsl:variable name="onMouseOver">javascript:i2uiSetMenuCoords(this,event)</xsl:variable>
    <i2:tr>
      <i2:treecell depth="{$count}">
        <a onmouseover="{$onMouseOver}" href="{$onRootClick}">
          <i18n:text>
            <xsl:value-of select="./@Name"/>
          </i18n:text>
        </a>
      </i2:treecell>
    </i2:tr>
    <xsl:variable name="count" select="$count + 1"/>
    <i2:tr>
      <i2:treecell depth="{$count}">
        <a onmouseover="{$onMouseOver}" href="{$onViewClick}">
          <i18n:text>View</i18n:text>
        </a>
      </i2:treecell>
    </i2:tr>
    <xsl:variable name="childCount" select="count(./AUTH_ID)"/>
    <xsl:apply-templates select="AUTH_ID" mode="tree">
      <xsl:with-param name="isEdit" select="'False'"/>
      <xsl:with-param name="count" select="$count"/>
      <xsl:with-param name="authDoc" select="$authDoc"/>
      <xsl:with-param name="parentNode" select="$nodename"/>
    </xsl:apply-templates>
    <!--
        <xsl:variable name="childCount" select="$count(./AUTH_ID"/>
  -->
    <i2:tr>
      <i2:treecell depth="{$count}">
        <a onmouseover="{$onMouseOver}" href="{$onEditClick}">
          <i18n:text>Edit</i18n:text>
        </a>
      </i2:treecell>
    </i2:tr>
    <xsl:apply-templates select="AUTH_ID" mode="tree">
      <xsl:with-param name="isEdit" select="'True'"/>
      <xsl:with-param name="count" select="$count"/>
      <xsl:with-param name="authDoc" select="$authDoc"/>
      <xsl:with-param name="parentNode" select="$nodename"/>
    </xsl:apply-templates>
  </xsl:template>
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template match="AUTH_ID" mode="tree">
    <xsl:param name="isEdit"/>
    <xsl:param name="count"/>
    <xsl:param name="parentNode"/>
    <xsl:variable name="quote">'</xsl:variable>
    <xsl:variable name="nodename">
      <xsl:value-of select="./descendant::*/@Value"/>
    </xsl:variable>
    <xsl:variable name="onEditClick">
      <xsl:value-of select="concat('javascript:onPopUp(',$quote,$parentNode,'#Edit','#',$nodename,$quote,')')"/>
    </xsl:variable>
    <xsl:variable name="onViewClick">
      <xsl:value-of select="concat('javascript:onPopUp(',$quote,$parentNode,'#View','#',$nodename,$quote,')')"/>
    </xsl:variable>
    <xsl:variable name="onMouseOver">javascript:i2uiSetMenuCoords(this,event)</xsl:variable>
    <xsl:variable name="nochild">
      <xsl:choose>
        <xsl:when test="./*">
          <xsl:text>false</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>true</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="count" select="$count + 1"/>
    <xsl:choose>
      <xsl:when test="$isEdit='False'">
        <i2:tr>
          <i2:treecell depth="{$count}">
            <a onmouseover="{$onMouseOver}" href="{$onViewClick}">
              <i18n:text>
                <xsl:value-of select="./*/@Value"/>
              </i18n:text>
            </a>
          </i2:treecell>
        </i2:tr>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="./*[@Action='_ALL_']">
          <i2:tr>
            <i2:treecell depth="{$count}">
              <a onmouseover="{$onMouseOver}" href="{$onEditClick}">
                <i18n:text>
                  <xsl:value-of select="./*/@Value"/>
                </i18n:text>
              </a>
            </i2:treecell>
          </i2:tr>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="include_javascript_domain_tree">
    <script>
    function onRootPopUp(nodename)
    {
    
       document.result_form.node.value=nodename;
        i2uiShowMenu('authDoc');        
    }
    function addNode()
      {
      document.result_form.target="topFrame";  
      document.result_form.action= "execDomainSearch.jsp";
      document.result_form.method="POST";
      document.result_form.submit();   
      }
    function onPopUp(nodename)
    {
     document.result_form.node.value=nodename;
   
    i2uiShowMenu('nonAuthDoc');
    } 
    function removeNode()
     {
      document.result_form.target="domainFrame";  
       document.result_form.action='assignDomainController/remove.cmd';
      document.result_form.method="POST";
      document.result_form.submit();   
      }
    function onCancel()
   {
   document.result_form.target="appFrame";  
   document.result_form.action='user_admin_groups_new/goToPage.cmd?WHERE=USER_GROUP_MAIN';
   document.result_form.submit();   
   }
   function onSaveAndReturn()
   {
    document.result_form.target="appFrame";  
    document.result_form.action='assignDomainController/save.cmd';
   document.result_form.submit();   

   }
  </script>
  </xsl:template>
</xsl:stylesheet>

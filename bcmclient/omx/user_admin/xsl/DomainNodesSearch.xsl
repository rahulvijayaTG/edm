<?xml version="1.0" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:xalan="http://xml.apache.org/xalan" xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension" xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension" extension-element-prefixes="i2 i18n" exclude-result-prefixes="xalan" version="1.0">
  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../core/xsl/error.xsl"/>
  <xsl:output method="html"/>

 <!-- **********************************************************************
     *********************************************************************** -->  
  <xsl:template match="RESPONSES" mode="content">
      <xsl:call-template name="include_javascript_form"/>       
      <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
        <xsl:with-param name="content" select="RESPONSE"/>
      </xsl:apply-templates>
      <!--<table id="top_table" border="0" cellpadding="0" cellspacing="0"  width="98%">
                <td width="100%">
                  <xsl:apply-templates select="RESPONSE/NODE_SEARCH_FORM"/>
                </td>
      </table>-->      
  </xsl:template>
  
  <xsl:template match="RESPONSE" mode="container_content">
        <!-- Body -->       
        <xsl:apply-templates select="NODE_SEARCH_FORM"/>          
  </xsl:template>
  
 <!-- **********************************************************************
   *********************************************************************** -->
  <xsl:template match="NODE_SEARCH_FORM">
     <xsl:variable name="title">
        <i18n:text>Node Search</i18n:text>
    </xsl:variable>
    <!--<i2:container id="parent_container"  title="{$title}">-->
        <table border="0" cellpadding="0" cellspacing="5" width="100%">
          <form name="node_search_form" method="POST" target="searchFrame" action="DomainNodesSearch.jsp">
            <tr>
              <td>
                  <input type="hidden" name="ACTION" value="{/RESPONSES/RESPONSE/ACTION/@Value}"/>
                  <input type="Hidden" name="PAGE" value="domain_nodes_search"/>
                  <table border="0" bordercolor="red" cellpadding="0" cellspacing="0" width="100%" valign="top">
                    <tr>
                        <td>
                            <i18n:text>Dimension</i18n:text><xsl:text>:</xsl:text>&#xA0;
                        </td>
                        <td nowrap="nowrap">    
                          <select  class="pulldown" name="DIMENSION_ID" onchange="javascript:onDimension();">
                            <option Value="NONE">
                                <i18n:text>Select</i18n:text>
                            </option>                           
                            <xsl:apply-templates select="Dimensions"/>  
                          </select>
                       </td>
                       <td>
                            <i18n:text>Hierarchy</i18n:text><xsl:text>:</xsl:text>&#xA0;
                       </td>
                       <td nowrap="nowrap"> 
                          <select  class="pulldown" name="HIERARCHY_ID" onchange="javascript:onHierarchy();">
                            <option Value="NONE">
                                <i18n:text>Select</i18n:text>
                            </option>                           
                            <xsl:apply-templates select="Hierarchies"/> 
                          </select>
                       </td>
                   </tr>
                   <tr>
                        <td colspan="4">&#xA0;</td>
                   </tr>
                   <tr>
                        <td>
                            <i18n:text>Level</i18n:text><xsl:text>:</xsl:text>&#xA0;
                        </td>
                        <td nowrap="nowrap">    
                          <select  class="pulldown" name="LEVEL_ID">
                            <option Value="NONE">
                                <i18n:text>Select</i18n:text>
                            </option>                           
                            <xsl:apply-templates select="Levels"/>  
                          </select>
                       </td>
                        <td colspan="2"/>
                   </tr>
                  </table>
              </td>
            </tr>
          </form>
        </table>
        <i2:footer>
            <table cellspacing="0" cellpadding="0" width="100%"  border="0">
                <td align="right">
                    <xsl:call-template name="mdmButton">
                        <xsl:with-param name="onclick" select="'javascript:onSearch();'"/>
                        <xsl:with-param name="text" select="'Search'"/>
                        <xsl:with-param name="id" select="'search'"/>
                        <xsl:with-param name="name" select="'Search'"/>
                    </xsl:call-template>
                    <!--i2:button id="search" name="Search" onclick="javascript:onSearch()">&#xA0;<i18n:text>Search</i18n:text>&#xA0;</i2:button-->
                </td>
            </table>
        </i2:footer>
    <!--</i2:container>-->
  </xsl:template>

 <!--*********************************************************************
  *********************************************************************** -->
  <xsl:template match="Dimensions">
    <xsl:for-each select="Dimension">
     <xsl:choose>
         <xsl:when test="/RESPONSES/RESPONSE/NODE_SEARCH_FORM/CurrentValues/DIMENSION_ID/@Value = Id/@Value ">
              <option selected="yes" Value="{Id/@Value}">
                <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
             </option>
         </xsl:when>
         <xsl:otherwise>
              <option Value="{Id/@Value}">
                <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
             </option>
         </xsl:otherwise>
     </xsl:choose>
     </xsl:for-each>
  </xsl:template>

 <!--*********************************************************************
  *********************************************************************** -->
  <xsl:template match="Hierarchies">
    <xsl:for-each select="Hierarchy">
     <xsl:choose>
         <xsl:when test="/RESPONSES/RESPONSE/NODE_SEARCH_FORM/CurrentValues/HIERARCHY_ID/@Value = Id/@Value ">
              <option selected="yes" Value="{Id/@Value}">
                <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
             </option>
         </xsl:when>
         <xsl:otherwise>
              <option Value="{Id/@Value}">
                <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
             </option>
         </xsl:otherwise>
     </xsl:choose>
     </xsl:for-each>
  </xsl:template>
  
 <!--*********************************************************************
  *********************************************************************** -->
  <xsl:template match="Levels">
    <xsl:for-each select="LevelHierarchy">
     <xsl:choose>
         <xsl:when test="/RESPONSES/RESPONSE/NODE_SEARCH_FORM/CurrentValues/LEVEL_ID/@Value = LevelId/@Value ">
              <option selected="yes" Value="{LevelId/@Value}">
                <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
             </option>
         </xsl:when>
         <xsl:otherwise>
              <option Value="{LevelId/@Value}">
                <i18n:text><xsl:value-of select="Name/@Value"/></i18n:text>
             </option>
         </xsl:otherwise>
     </xsl:choose>
     </xsl:for-each>
  </xsl:template>

 <!--**********************************************************************
  **********************************************************************-->
  <xsl:template name="include_javascript_form">
    <script><![CDATA[      
    function onSearch()
    {
    	<!-- iSSUE nO : 531363 -->
        if(document.node_search_form.DIMENSION_ID.selectedIndex == 0) {
	    core_alert("SELECT_ONE_DIMENSION");
	    return;
	 }
	 if(document.node_search_form.HIERARCHY_ID.selectedIndex == 0) {
	    core_alert("SELECT_ONE_HIERARCHY");
	    return;
	 }
	 if(document.node_search_form.LEVEL_ID.selectedIndex == 0) {
	    core_alert("SELECT_ONE_LEVEL");
	    return;
        }       

        parent.resultFrame.document.result_form.DO_SEARCH.value = 'Yes';
        parent.resultFrame.document.result_form.START_COUNT.value = 0;
        parent.resultFrame.document.result_form.RECORD_COUNT.value = 0;

        parent.resultFrame.document.result_form.ACTION.value = 'GET_NODES';     
        parent.resultFrame.document.result_form.DIMENSION_ID.value = document.node_search_form.DIMENSION_ID.options[document.node_search_form.DIMENSION_ID.selectedIndex].value;
        parent.resultFrame.document.result_form.HIERARCHY_ID.value = document.node_search_form.HIERARCHY_ID.options[document.node_search_form.HIERARCHY_ID.selectedIndex].value;
        parent.resultFrame.document.result_form.LEVEL_ID.value = document.node_search_form.LEVEL_ID.options[document.node_search_form.LEVEL_ID.selectedIndex].value;                
        parent.resultFrame.document.result_form.target = 'resultFrame';
        parent.resultFrame.document.result_form.submit();
    }

    function onDimension()
    {
        if(document.node_search_form.DIMENSION_ID.selectedIndex != 0)
        {
            document.node_search_form.ACTION.value = 'GET_HIERARCHY';
            document.node_search_form.submit();
        }
    }
    
    function onHierarchy()
    {
        if(document.node_search_form.DIMENSION_ID.selectedIndex == 0)
        {
            core_alert("SELECT_ONE_DIMENSION");
            return;
        }
        
        if(document.node_search_form.HIERARCHY_ID.selectedIndex != 0)
        {
            document.node_search_form.ACTION.value = 'GET_LEVEL';
            document.node_search_form.submit();
        }
    }

    function onAddNewUserGroup()
    {
            document.result_form.target="appFrame";
            document.result_form.method="POST";
            document.result_form.action="user_group_details/getUserGroupDetails.cmd?CREATE_NEW=Yes&ORG_ID=ORG_1";
            document.result_form.submit();
    }
    
    // Enter Key Tapping - Start::
    var browserName = navigator.appName;    
    if (browserName == "Netscape") 
    {
      document.captureEvents(Event.KEYPRESS);
      document.onkeypress=NetEnterKey;
    }
    else
    { 
      if (browserName.indexOf("Explorer") >= 0)
      { 
        document.onkeypress=IEEnterKey;
        document.onkeydown=IEEnterKey;
      }
    }  
    
    function IEEnterKey() 
    { 
      // if enter key
      if(window.event.keyCode == 13)
      { 
        if (window.event.srcElement.onclick != null)
        {
          event.returnValue=true;
        } 
        else
        {
          if ( window.event.srcElement.type != "textarea" )
          {
            SetfocusSubmit(window.event.srcElement)
          } 
          event.returnValue=false;
        }  
      }  
      // if backspace 
      if (window.event.keyCode==8) 
      {
        if (window.event.srcElement.isTextEdit == false)
          event.returnValue=false;
      }
    }

    function NetEnterKey(e) 
    {
      key = e.which; 
      if(key == 13)
      { 
        SetfocusSubmit( e.target )
        return false;
      }
    }  

    function SetfocusSubmit( target )
    {
      if ( target.form == document.user_search_form )
      {
        onSearch();
      }
    }
   
    // Setting Focus
    function setFocus()
    {
      var elementsLen = document.search_form.elements.length;     
      for(count = 0; count < elementsLen; count++)
      {
        if( 
            document.search_form.elements[count].type != "hidden" 
          )
          {  
            document.search_form.elements[count].focus();
            return;
          }
      }
    }               
    ]]>
    </script>
</xsl:template>

 <!-- **********************************************************************
   *********************************************************************** -->  
</xsl:stylesheet>
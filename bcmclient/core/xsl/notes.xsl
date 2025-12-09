<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="../../core/xsl/page.xsl"/>
  <xsl:import href="../../core/xsl/container.xsl"/>
  <xsl:import href="../../core/xsl/validation.xsl"/>
  <xsl:import href="../../core/search/xsl/search.xsl"/>

  <xsl:output method="html"/>
  
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">
    <script>
      <xsl:call-template name="include_javascript_notes"/>
    </script>

    <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  </xsl:template>
  
   <xsl:template match = "RESPONSE" mode="container_content">
    <xsl:call-template name="display_validation_messages">
      <xsl:with-param name="pErrorMessage" select="ERROR_MESSAGE/@Value"/>
      <xsl:with-param name="pSuccessMessage" select="SUCCESS_MESSAGE/@Value"/>
    <xsl:with-param name="pAnyFieldIsRequired" select="'false'"/>
    </xsl:call-template>
      <table width="100%" cellspacing="2" cellpadding="2">
        <tr>
          <td width="10%" nowrap="true"><i18n:text>Entity Name</i18n:text> :</td>
          <td width="90%" align="left"><xsl:value-of select="ENTITY_NAME/@Value"/></td>
          <!-- <td><i18n:text>Entity ID</i18n:text> :</td>
          <td width="40%"><xsl:value-of select="ENTITY_ID/@Value"/></td> -->
        </tr>
      </table>
    <xsl:apply-templates select="SEARCH"/>
  </xsl:template>

   <!-- current.xsl Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="include_javascript_notes">  
    <![CDATA[
  function onAdd()
  {
    document.search_form.action = "notes/view/add.x2c";
    document.search_form.submit();
  }
  function onDelete()
  {
    if ( ifAnyChecked("result_form") )
    {
      document.result_form.action = "notes/view/delete.x2c";
      document.result_form.submit();
    }
    else
    {
      omx_alert("Select a note to delete.");
    }
  }
  function onEdit()
  {
    if ( ifAnyChecked("result_form") )
    {
      if ( ifMoreThanOneSelected() == "false" )
      {
        if ( isEditable() )
        {
          document.result_form.action = "notes/view/edit.x2c";
          document.result_form.submit();
        }
        else
        {
          omx_alert("Selected note cannot be edited.");
        }
      }
      else
      {
        omx_alert("Select only one note to edit.");
      }
    }
    else
    {
      omx_alert("Select a note to edit.");
    }
  }
  
  function ifMoreThanOneSelected()
  {
    var elemLen = document.result_form.SELECTED_ID.length;
    var selected = "false";
    for( i=0; i < elemLen; i++ )
    {
      if( document.result_form.SELECTED_ID[i].checked == true )
      {
        if ( selected == "true" )
          return selected;
        selected = "true";
      }              
    }
    return "false";
  }
  
 function isEditable()
  {
    var elemLen = document.result_form.SELECTED_ID.length;
    if ( elemLen > 1 )
    {
      for( i=0; i < elemLen; i++ )
      {
        if( document.result_form.SELECTED_ID[i].checked == true )
        {
          if ( document.result_form.IS_EDITABLE[i].value == "false" )
            return false;
          else
          {
          document.result_form.SELECTED_NOTE_ID.value = document.result_form.SELECTED_ID[i].value;
          document.result_form.SELECTED_DESC.value = document.result_form.DESCRIPTION[i].value;

            return true;
          }
        }              
      }
    }
    else
    {
      if ( document.result_form.IS_EDITABLE.value == "false" )
          return false;
        else
        {
          document.result_form.SELECTED_NOTE_ID.value = document.result_form.SELECTED_ID.value;
          document.result_form.SELECTED_DESC.value = document.result_form.DESCRIPTION.value;
          return true;
        }
    }
    return true;
  }  
  

  function onUpdate()
  {
    document.search_form.action = "notes/view/update.x2c";
    document.search_form.submit();
  }
          ]]>
  </xsl:template>

  <!-- page.xsl Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="onLoad_js">  
  function onLoad()
  {
      <xsl:call-template name="javascript_onLoad_search"/>
      <xsl:call-template name="javascript_onLoad_page"/>
  }
  </xsl:template>
  
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template name="onResize_js">  
    function onResize()
    {
      <xsl:call-template name="javascript_onResize_search"/>
      <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>
  

  <!-- Search.xsl Javascript -->  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="javascript_resizeContainers">  

    <xsl:call-template name="javascript_resizeTables"> 
      <xsl:with-param name="pHeight" select="'50'"/>
<!--       <xsl:with-param name="pWidth" select="194 + 5 + 20"/> -->
      <xsl:with-param name="pWidth" select="5 + 20"/><!-- steps + border -->

      <xsl:with-param name="pParentContainerId" select="'container'"/>
   </xsl:call-template>

  </xsl:template>
  
  <!-- ********************************************************************** 
       *********************************************************************** -->
  
</xsl:stylesheet>


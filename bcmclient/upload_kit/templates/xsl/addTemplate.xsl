<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <xsl:import href="../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../core/xsl/container.xsl"/>

  <xsl:output method="html"/>
  
  <xsl:variable name="selected_template_type">
    <xsl:value-of select="/RESPONSES/RESPONSE/SELECTED_TEMPLATE_TYPE/@Value" />
  </xsl:variable>
  
  <xsl:variable name="selected_ref_template">
    <xsl:value-of select="/RESPONSES/RESPONSE/SELECTED_REF_TEMPLATE/@Value" />
  </xsl:variable>
  
  <xsl:variable name="template_group_type">
    <xsl:value-of select="/RESPONSES/RESPONSE/TEMPLATE_GROUP_TYPE/@Value" />
  </xsl:variable>

  <!-- Entry Point -->
  <!-- ********************************************************************** 
      *********************************************************************** -->
  <xsl:template match="RESPONSES" mode="content">
    <script type="text/javascript" src="../uploadkit.js"></script>
    <script type="text/javascript">
      <![CDATA[    
    function addProperty()
      {
      if (document.addTemplateForm.PROPERTY_VALUE.value != null && trimString(document.addTemplateForm.PROPERTY_VALUE.value))
    {
        var whereto = "add_template/addTemplateProperty.x2c?SELECTED_TEMPLATE_TYPE=";
      var selectedType= document.addTemplateForm.TEMPLATE_TYPE.options[document.addTemplateForm.TEMPLATE_TYPE.selectedIndex].value;
      whereto = whereto + selectedType;
      
      whereto = whereto + "&SELECTED_REF_TEMPLATE=";
      var selectedRefTemplate= document.addTemplateForm.REF_TEMPLATE_NAME.options[document.addTemplateForm.REF_TEMPLATE_NAME.selectedIndex].value;
        whereto = whereto + selectedRefTemplate;
    
          document.addTemplateForm.action=whereto;
          document.addTemplateForm.submit();
        }
    else
      omx_alert("Please Enter the property to add");
    }
    
    function addTemplateType()
      {
      if (document.addTemplateForm.ADD_TEMPLATE_TYPE.value != null && trimString(document.addTemplateForm.ADD_TEMPLATE_TYPE.value))
    {
        var whereto = "add_template/addTemplateType.x2c?SELECTED_TEMPLATE_TYPE=";
      var selectedType= document.addTemplateForm.TEMPLATE_TYPE.options[document.addTemplateForm.TEMPLATE_TYPE.selectedIndex].value;
      whereto = whereto + selectedType;
      
      whereto = whereto + "&SELECTED_REF_TEMPLATE=";
      var selectedRefTemplate= document.addTemplateForm.REF_TEMPLATE_NAME.options[document.addTemplateForm.REF_TEMPLATE_NAME.selectedIndex].value;
        whereto = whereto + selectedRefTemplate;
    
          document.addTemplateForm.action=whereto;
          document.addTemplateForm.submit();
        }
    else
      omx_alert("Enter the template type to add");
      }
    
    function deleteProperty()
      {
      var whereto = "add_template/deleteTemplateProperty.x2c?SELECTED_TEMPLATE_TYPE=";
    var selectedType= document.addTemplateForm.TEMPLATE_TYPE.options[document.addTemplateForm.TEMPLATE_TYPE.selectedIndex].value;
    whereto = whereto + selectedType;
      
    whereto = whereto + "&SELECTED_REF_TEMPLATE=";
    var selectedRefTemplate= document.addTemplateForm.REF_TEMPLATE_NAME.options[document.addTemplateForm.REF_TEMPLATE_NAME.selectedIndex].value;
      whereto = whereto + selectedRefTemplate;
    
        document.addTemplateForm.action=whereto;
        document.addTemplateForm.submit();
      }
    
    function updateTemplateTypeSelection() 
    {
    var whereto = "add_template/updateTemplateType.x2c?SELECTED_TEMPLATE_TYPE=";
    var selectedTempType= document.addTemplateForm.TEMPLATE_TYPE.options[document.addTemplateForm.TEMPLATE_TYPE.selectedIndex].value;
    whereto = whereto + selectedTempType;

    whereto = whereto + "&SELECTED_REF_TEMPLATE=";
    var selectedRefTemplate= document.addTemplateForm.REF_TEMPLATE_NAME.options[document.addTemplateForm.REF_TEMPLATE_NAME.selectedIndex].value;
      whereto = whereto + selectedRefTemplate;
  
    document.addTemplateForm.action=whereto;
        document.addTemplateForm.submit();
    }
    
    function addTemplate()
      {
      var whereto = "add_template/addTemplate.x2c?SELECTED_TEMPLATE_TYPE=";
    var selectedType= document.addTemplateForm.TEMPLATE_TYPE.options[document.addTemplateForm.TEMPLATE_TYPE.selectedIndex].value;
    whereto = whereto + selectedType;
      
    whereto = whereto + "&SELECTED_REF_TEMPLATE=";
    var selectedRefTemplate= document.addTemplateForm.REF_TEMPLATE_NAME.options[document.addTemplateForm.REF_TEMPLATE_NAME.selectedIndex].value;
      whereto = whereto + selectedRefTemplate;
    
        document.addTemplateForm.action=whereto;
        document.addTemplateForm.submit();
      }

    ]]>
    </script>
    <xsl:apply-templates select="RESPONSE/CONTAINER">
      <xsl:with-param name="content" select="RESPONSE"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- ********************************************************************** 
       ********************************************************************** --> 
  <xsl:template match="RESPONSE" mode="container_content">  

    <xsl:variable name="templateHeader">
      <i18n:text>Template Details</i18n:text>
    </xsl:variable>      
    
    <!-- Add Template -->
          <table border="0" cellpadding="0" cellspacing="5" width="100%">
      <form name="addTemplateForm" method="POST"> 
        <tr><td>    
              <i2:container title="{$templateHeader}" inner="yes">
                <table border="0" cellpadding="0" cellspacing="5" width="100%">
            <tr>
                <td nowrap="yes" width="15%"><i18n:text>Template Type</i18n:text>:</td> 
            <td align="center">
              <xsl:choose>
                <xsl:when test="normalize-space($template_group_type)='Transaction'">
                <input type="radio" name="TEMPLATE_GROUP_TYPE" value="Static"/>
                <i18n:text>Static</i18n:text>&#xA0;&#xA0;
                <input type="radio" name="TEMPLATE_GROUP_TYPE" value="Transaction" checked="yes"/>
                <i18n:text>Transaction</i18n:text>
              </xsl:when>
              <xsl:otherwise>
                <input type="radio" name="TEMPLATE_GROUP_TYPE" value="Static" checked="yes"/>
                <i18n:text>Static</i18n:text>&#xA0;&#xA0;
                <input type="radio" name="TEMPLATE_GROUP_TYPE" value="Transaction"/>
                <i18n:text>Transaction</i18n:text>
              </xsl:otherwise>
            </xsl:choose>
            </td>
            </tr>
  
                  <tr>
                <td nowrap="yes" width="15%"><i18n:text>Template Group</i18n:text>:</td>
                <td nowrap="yes" width="35%">
            <!--
            <xsl:apply-templates select="ALL_TEMPLATES" />
            -->
              <select name="TEMPLATE_TYPE" class="inputfieldIE" onChange="javascript:updateTemplateTypeSelection();" >
                <option value="SELECTED" selected="yes"><i18n:text>select Template Group</i18n:text></option>
                <xsl:call-template name="templateType">
                <xsl:with-param name="node" select="ALL_TEMPLATES/TEMPLATE_TYPE"/>
              </xsl:call-template>
              <xsl:call-template name="templateType">
                <xsl:with-param name="node" select="TEMPLATE_TYPES/TEMPLATE_TYPE"/>
              </xsl:call-template>
              </select>
              </td>
            <td nowrap="yes" width="15%">
              <!--<xsl:call-template name="addTemplateType"/>-->
              <input type="field" class="inputfieldIE" name="ADD_TEMPLATE_TYPE" size="22" value=""/>
            </td>
            <td nowrap="yes" width="35%">
              <i2:button onclick="javascript:addTemplateType();" name="add">&#xA0;<i18n:text>Add</i18n:text>&#xA0;</i2:button>
            </td>
                  </tr>
            <tr>              
                    <td nowrap="yes" width="15%"><i18n:text>Template Name</i18n:text>:</td>
                    <td nowrap="yes" width="35%">
                <input type="field" class="inputfieldIE" name="TEMPLATE_NAME" size="22" value="{TEMPLATE/@Name}"/>
              </td>
            <td nowrap="yes" width="15%"><i18n:text>Display Name</i18n:text>:</td>
                    <td nowrap="yes" width="35%">
                <input type="field" class="inputfieldIE" name="DISPLAY_NAME" size="22" value="{TEMPLATE/@DisplayName}"/>
              </td>
                  </tr>
                  <tr>
              <td nowrap="yes" width="15%"><i18n:text>Data Type</i18n:text>:</td>
              <td nowrap="yes" width="35%">
                <input type="field" class="inputfieldIE" name="DATA_TYPE" size="15" value="{TEMPLATE/@DataType}"/>
              </td>
            <td nowrap="yes" width="15%"><i18n:text>Service Name</i18n:text>:</td>
                    <td nowrap="yes" width="35%">
                <input type="field" class="inputfieldIE" name="SERVICE_NAME" size="22" value="{TEMPLATE/@ServiceName}"/>
              </td>
            </tr>
            <tr>
                    <td nowrap="yes" width="15%"><i18n:text>Api Name</i18n:text>:</td>
                    <td nowrap="yes" width="35%">
                <input type="field" class="inputfieldIE" name="API_NAME" size="22" value="{TEMPLATE/@ApiName}"/>
              </td>
            <td nowrap="yes" width="15%"><i18n:text>Reference Template</i18n:text>:</td>    
                    <td nowrap="yes" width="35%">
              <select name="REF_TEMPLATE_NAME" class="inputfieldIE">
            <option value="SELECTED" selected="yes"><i18n:text>Top</i18n:text></option>
                <xsl:call-template name="displayName" />
            </select>
              </td>
                  </tr>
          </table>
          </i2:container>
          </td></tr>
          <tr><td>
          <table border="0" cellpadding="0" cellspacing="1" width="100%">
            <xsl:apply-templates select="TEMPLATE_PROPERTIES"/>
         <!--  <xsl:call-template name="templateProperties"/> -->
              </table>
        </td></tr>
      </form>
    </table>
  </xsl:template>
  
  <xsl:template match="TEMPLATE_PROPERTIES">
    <xsl:variable name="property_header">
      <i18n:text>Property Details</i18n:text>
    </xsl:variable>
    <xsl:variable name="propertyName">
      <xsl:value-of select="@Name" />
    </xsl:variable>
    <tr>  
      <td>
        <i2:container title="{$property_header}" inner="yes" stretch="yes">
          <table width="50%" border="0">
            <tr>
              <td nowrap="yes" width="15%">
              <i18n:text>Property</i18n:text>:</td>
                <td nowrap="yes" width="35%">
                <input type="field" class="inputfieldIE" name="PROPERTY_VALUE" size="22" value=""/>
              </td>
              <td nowrap="yes" width="15%">
                <i2:button onclick="javascript:addProperty();" name="add">&#xA0;<i18n:text>Add</i18n:text>&#xA0;</i2:button>
              </td>  
            </tr>
          </table>
          <table  width="100%" cellpadding="0" cellspacing="1" border="0"  scrollablerows="yes" scrollablecolumns="auto">
            <tr>
              <td>
                <xsl:if test="count(TEMPLATE_PROPERTY) > 0">
                  <i2:table id="propertyTable" scrollablerows="no" scrollablecolumns="no">
                    <i2:tr header="yes">
                      <td width="5%" nowrap="yes">
                        <input type="checkbox" name="PROPERTY_CHECKBOX" value="true" onclick="javascript:toggleCheckboxes(document.forms.addTemplateForm, document.forms.addTemplateForm.PROPERTY_NAME, document.forms.addTemplateForm.PROPERTY_CHECKBOX);"/>
                      </td>
                      <td nowrap="yes">
                        <i18n:text>Property Name</i18n:text>
                      </td>
                    </i2:tr>
                    <xsl:for-each select="TEMPLATE_PROPERTY">
                      <i2:tr>   
                        <td width="5%" nowrap="yes">
                          <input type="checkbox" name="PROPERTY_NAME" value="{@Name}">
                          </input>
                        </td>
                        <td nowrap="yes">
                          <xsl:value-of select="@Name"/>
                        </td>
                      </i2:tr>
                    </xsl:for-each>
                  </i2:table>
                </xsl:if>
              </td>
            </tr>
          </table>
          <i2:footer>
            <i2:buttonbar>
                <i2:button onclick="javascript:deleteProperty();" name="delete">&#xA0;<i18n:text>Delete</i18n:text>&#xA0;</i2:button>
            </i2:buttonbar>
          </i2:footer>
        </i2:container>
      </td>
    </tr>      
  </xsl:template>
  
  <xsl:template name="templateType">
    <xsl:param name="node"/>
    <!--<xsl:variable name="uniqueTemplateTypes" select="//RESPONSES/RESPONSE/ALL_TEMPLATES/TEMPLATE_TYPE[not(@Type=preceding-sibling:://RESPONSES/RESPONSE/ALL_TEMPLATES/TEMPLATE_TYPE/@Type)]/@Type"/>
    <xsl:for-each select="$uniqueTemplateTypes">
    -->
    
    <!--<xsl:for-each select="//RESPONSES/RESPONSE/ALL_TEMPLATES/TEMPLATE_TYPE">-->
    <xsl:for-each select="$node">
      <xsl:variable name="tempType">
      <xsl:value-of select="@Value"/>
    </xsl:variable>
      <xsl:choose>
      <xsl:when test="normalize-space($selected_template_type)=normalize-space($tempType)"> 
          <option value="{$tempType}" selected="yes">
        <xsl:value-of select="substring-after($tempType,'.')"/>
          </option>
      </xsl:when>
      <xsl:otherwise>
          <option value="{$tempType}">
        <xsl:value-of select="substring-after($tempType,'.')"/>
          </option>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="addTemplateType">
    <xsl:variable name="add_template_header">
      <i18n:text>Add Template Type</i18n:text>
    </xsl:variable>
    <i2:container title="{$add_template_header}">
      <table width="100%" border="0">
        <tr>
          <td>
            <!--
       <i2:table>
         <i2:tr header="yes">
           <td nowrap="yes" align="center">
          <i18n:text>Template Type</i18n:text>
      </td>
         </i2:tr>
         <i2:tr>
           <td>
          <input type="field" class="inputfieldIE" name="ADD_TEMPLATE_TYPE" size="15" value=""/>
         </td>
          </i2:tr>
        </i2:table>
    -->
        <input type="field" class="inputfieldIE" name="ADD_TEMPLATE_TYPE" size="15" value=""/>
      </td>
    </tr>
    <tr>
      <td>  
       <i2:footer>
         <table border="0" cellpadding="0" cellspacing="3">
           <tr>
         <td width="100%" align="right">&#xA0;</td>
         <td align="right">
           <i2:button onclick="javascript:addTemplateType();" name="add">&#xA0;<i18n:text>Add</i18n:text>&#xA0;</i2:button>
        </td>
      </tr>
        </table>
      </i2:footer>
        </td>
       </tr>
     </table>
    </i2:container>
  </xsl:template>
  
  
  <xsl:template name="displayName">
    <!--
    <xsl:variable name="uniqueDisplayNames" select="//RESPONSES/RESPONSE/ALL_TEMPLATES/TEMPLATE[not(@DisplayName=preceding-sibling:://RESPONSES/RESPONSE/ALL_TEMPLATES/TEMPLATE/@DisplayName)]/@DisplayName"/>
    <xsl:for-each select="$uniqueDisplayNames">
      <xsl:variable name="displayName" select="."/>
    <xsl:choose>
      <xsl:when test="normalize-space($selected_ref_template)=normalize-space($displayName)"> 
          <option value="{$displayName}" selected="yes">
        <xsl:value-of select="$displayName"/>
          </option>
      </xsl:when>
      <xsl:otherwise>
          <option value="{$displayName}">
        <xsl:value-of select="$displayName"/>
          </option>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    -->
    <!--<xsl:for-each select="//RESPONSES/RESPONSE/ALL_TEMPLATES/TEMPLATE_TYPE[@Type=$selected_template_type]/TEMPLATE/@DisplayName"/>-->
    <xsl:for-each select="//RESPONSES/RESPONSE/ALL_TEMPLATES/TEMPLATE_TYPE">
      <xsl:variable name="tempType">
      <xsl:value-of select="@Value"/>
    </xsl:variable>
    <xsl:if test="normalize-space($selected_template_type)=normalize-space($tempType)">
      <xsl:for-each select="TEMPLATE">  
          <xsl:variable name="displayName">
          <xsl:value-of select="@DisplayName"/>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="normalize-space($selected_ref_template)=normalize-space($displayName)"> 
              <option value="{$displayName}" selected="yes">
            <xsl:value-of select="$displayName"/>
              </option>
          </xsl:when>
          <xsl:otherwise>
              <option value="{$displayName}">
            <xsl:value-of select="$displayName"/>
              </option>
          </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!-- page.xsl Javascript -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="onLoad_js">
    function onLoad()
    {
    <xsl:call-template name="javascript_onLoad_tab"/>
    <xsl:call-template name="javascript_onLoad_page"/>
    }
  </xsl:template>


  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="onResize_js">

    function onResize()
    {
    <xsl:call-template name="javascript_onResize_tab"/>
    <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>


  <!-- Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="javascript_onLoad_tab">
    <xsl:call-template name="javascript_resizeTabs"/>
  </xsl:template>


  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="javascript_onResize_tab">
    <xsl:call-template name="javascript_resizeTabs"/>
  </xsl:template>
  
</xsl:stylesheet>

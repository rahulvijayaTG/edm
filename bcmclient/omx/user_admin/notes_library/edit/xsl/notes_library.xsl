<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">

  <xsl:import href="../../../../../core/xsl/page.xsl"/>
  <xsl:import href="../../../../../core/xsl/container.xsl"/>
  <xsl:import href="../../../../xsl/required_field.xsl"/> 
  <xsl:import href="../../../../xsl/code_master.xsl"/> 

  <xsl:output method="html"/>


  <!-- Page Content -->  
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template match = "RESPONSES" mode="content">
    
    <xsl:call-template name="include_javascript_notes_library"/>
    
     <xsl:apply-templates select="RESPONSE/CONTAINER">
       <xsl:with-param name="content" select="RESPONSE"/>
     </xsl:apply-templates>
  </xsl:template>
  
  <!-- Container Content -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template match = "RESPONSE" mode="container_content">

     <xsl:choose>
	   <xsl:when test="IS_EDITABLE/@Value = 'false'">
         <xsl:apply-templates select="NOTE_LIBRARY" mode="non_editable"/>
	   </xsl:when>
	   <xsl:otherwise>
         <xsl:apply-templates select="NOTE_LIBRARY" mode="editable"/>
	   </xsl:otherwise>
	 </xsl:choose>

  </xsl:template>

  <!-- Non Editable Note -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template match="NOTE_LIBRARY" mode="non_editable">

          <form name="note_form" method="POST" target="appFrame">
              <table border="0" cellpadding="0" cellspacing="8">
                <input type="hidden" name="ID" value="{ID/@Value}" class="inputfieldIE"/>
                
                <tr class="text">           
                  <td nowrap="nowrap"><i18n:text>Name</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="nowrap">
                    <xsl:value-of select="NOTE_CODE/@Value"/>               
                  </td>           
                </tr>
                
                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Type</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="nowrap">
                    <xsl:variable name="notetype"><xsl:value-of select="NOTE_TYPE/@Value"/></xsl:variable>
                    <i18n:text><xsl:value-of select="/RESPONSES/RESPONSE/CODE_MASTER_VALUE[VALUE_ID/@Value = $notetype]/DESCRIPTION/@Value"/></i18n:text>
                  </td> 
                </tr>
                
                <tr class="text">           
                  <td nowrap="nowrap"><i18n:text>Change Allowed</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="nowrap">
                    <xsl:choose>
					  <xsl:when test="IS_EDITABLE/@Value = 'true'"><i18n:text>Yes</i18n:text></xsl:when>
					  <xsl:otherwise><i18n:text>No</i18n:text></xsl:otherwise>
					</xsl:choose>
                  </td>           
                </tr>

                <tr class="text">           
                  <td nowrap="nowrap"><i18n:text>Details</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="nowrap">
                    <i18n:text name="{NOTE_CODE/@Value}"><xsl:value-of select="DESCRIPTION/@Value"/></i18n:text>
                  </td>           
                </tr>
                
               </table>
        </form>

  </xsl:template>

  <!-- Editable Note -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template match="NOTE_LIBRARY" mode="editable">

      <form name="note_form" method="POST" target="appFrame">

              <xsl:call-template name="display_instruction_area"/>
              <table border="0" cellpadding="0" cellspacing="5">
                <input type="hidden" name="ID" value="{ID/@Value}" class="inputfieldIE"/>
                
                <tr class="text">           
                  <td nowrap="nowrap"><i18n:text>Name</i18n:text><xsl:text>:</xsl:text>
                    <xsl:if test="ID/@Value = ''">
                      <xsl:call-template name="display_alert_mark"/>
					</xsl:if>
                  </td>
                  <td nowrap="nowrap">
                     <xsl:choose>
                      <xsl:when test="ID/@Value != ''">
                        <xsl:value-of select="NOTE_CODE/@Value"/>
                        <input type="hidden" name="NOTE_CODE" value="{NOTE_CODE/@Value}" class="inputfieldIE"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input type="field" required="true" name="NOTE_CODE" value="{NOTE_CODE/@Value}" class="inputfieldIE" size="17" />
                        <xsl:call-template name="display_alert_image">
                          <xsl:with-param name="fieldName" select="'NOTE_CODE'"/>
                        </xsl:call-template>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>           
                </tr>
                
                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Type</i18n:text><xsl:text>:</xsl:text>
                    <xsl:if test="ID/@Value = ''">
                      <xsl:call-template name="display_alert_mark"/>
					</xsl:if>
                  </td>
                  <xsl:variable name="noteType"><xsl:value-of select="NOTE_TYPE/@Value"/></xsl:variable>
                  <td nowrap="nowrap">
                     <xsl:choose>
                      <xsl:when test="ID/@Value != ''">
                        <xsl:value-of select="NOTE_TYPE/@Value"/>
                        <input type="hidden" name="TYPE_ID" value="{NOTE_TYPE/@Value}" class="inputfieldIE"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <select class="pulldown" name="TYPE_ID" width="17">
                          <xsl:apply-templates select="/RESPONSES/RESPONSE/CODE_MASTER_VALUE" mode="pulldown_value_id">
                            <xsl:with-param name="selectedId">
                              <xsl:value-of select="$noteType"/>
                            </xsl:with-param>
                          </xsl:apply-templates>
                        </select>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td> 
                </tr>
                
                <tr class="text">           
                  <td nowrap="nowrap"><i18n:text>Change Allowed</i18n:text><xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
	                    <select name="IS_EDITABLE" class="inputfieldIE" required="true" type="field">
	                      <option value="false">
						    <xsl:if test="IS_EDITABLE/@Value = 'false'">
							  <xsl:attribute name="selected">selected</xsl:attribute>
						    </xsl:if>
						    No
						  </option>
	                      <option value="true">
						    <xsl:if test="IS_EDITABLE/@Value = 'true'">
							  <xsl:attribute name="selected">selected</xsl:attribute>
						    </xsl:if>
						    Yes
						  </option>
	                    </select>
	                    <xsl:call-template name="display_alert_image">
	                      <xsl:with-param name="fieldName" select="'IS_EDITABLE'"/>
	                    </xsl:call-template>
                  </td>           
                </tr>
                
                <tr class="text">           
                  <td nowrap="nowrap"><i18n:text>Details</i18n:text><xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
	                    <textarea  name="DESCRIPTION" required="true" class="inputfieldIE" rows="5" cols="80">
	                      <xsl:value-of select="DESCRIPTION/@Value"/>
	                    </textarea>
	                    <xsl:call-template name="display_alert_image">
	                      <xsl:with-param name="fieldName" select="'DESCRIPTION'"/>
	                    </xsl:call-template>
                  </td>           
                </tr>
                
              </table>
      </form>   

  </xsl:template>

  <!-- page.xsl Javascript -->
  <!-- ********************************************************************** 
       *********************************************************************** -->
  <xsl:template name="onLoad_js">  
    function onLoad()
    {
      <xsl:if test=" (string-length(/RESPONSES/RESPONSE/IS_EDITABLE/@Value) &gt; 0)  and (/RESPONSES/RESPONSE/IS_EDITABLE/@Value = 'true') ">
        requiredFieldCheck('onLoad');
      </xsl:if>
      <xsl:call-template name="javascript_onLoad_page"/> 
      
    }
  </xsl:template>
  
  <!-- ********************************************************************** 
       *********************************************************************** -->
   <xsl:template name="onResize_js">  
    function onResize()
    {
      <xsl:call-template name="javascript_onResize_page"/>
    }
  </xsl:template>
  

  <!-- Search.xsl Javascript -->  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="javascript_resizeContainers">  

    <xsl:call-template name="javascript_resizeTables"> 
      <xsl:with-param name="pHeight" select="250"/>
      <xsl:with-param name="pWidth" select="5 + 20 +16 +5"/>
      <xsl:with-param name="ptlcWidth" select="40"/>
      <xsl:with-param name="ptlcHeight" select="40"/>
      <xsl:with-param name="pParentContainerId" select="'container'"/>
   </xsl:call-template>

  </xsl:template>


  <!-- Current.xsl Javascript -->
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="include_javascript_notes_library">  
  <script>
	function onDelete()
	{
	    document.note_form.action='controller/deleteNote.cmd';
	    document.note_form.submit();
	}
	
	function onAdd()
	{
      //requiredFieldCheck('onLoad');
	    document.note_form.action='controller/addNote.cmd';
	    document.note_form.submit();
	}
	
	function onUpdate()
	{
      //requiredFieldCheck('onLoad');
	    document.note_form.action='controller/updateNote.cmd';
	    document.note_form.submit();
	}

	function onBack()
	{
      //requiredFieldCheck('onLoad');
	    location.href='../select/notes_library.jsp';
	}
  </script>
  </xsl:template>	  

<!-- ********************************************************************** 
     *********************************************************************** -->
</xsl:stylesheet>   

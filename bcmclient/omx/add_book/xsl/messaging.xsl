<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="../../xsl/code_master.xsl"/>

  <xsl:output method="html"/>
  
  <xsl:template match="MSG_OPTIONS" mode="edit">
	
	<xsl:call-template name="include_javascript_messaging"/>
	
    <xsl:variable name="caption_title"><i18n:text>Messaging Options</i18n:text></xsl:variable>
    <i2:container title="{$caption_title}" stretch="yes" inner="yes">
      <input type="hidden" name="ENTITY_ID" value="{ENTITY_ID/@Value}"/>
      <input type="hidden" name="ENTITY_TYPE" value="{ENTITY_TYPE/@Value}"/>
      
      <table border="0" cellpadding="0" cellspacing="9" width="100%" valign="top">
        <tr>
          <td width="3%">
            <input type="checkbox" name="HTTP_CHECKED" tabindex="" onClick="javascript:checkRequiredField()">
              <xsl:if test="MSG_OPTION[ID/@Value='HTTP']/SELECTED/@Value = 'true'">
                <xsl:attribute name="checked">checked</xsl:attribute>
              </xsl:if>
            </input>
          </td>
          <td nowrap="true" align="left" width="5%">
	    <i18n:text>HTTP</i18n:text>
          </td>

          <td nowrap="true" width="5%">
            <table border="0" id="HTTP_DETAILS_MARK1" cellpadding="0" cellspacing="0">
              <tr>
                <td align="left">
                  <i18n:text>URL</i18n:text><xsl:text>:</xsl:text>
                </td>
              </tr>
            </table>
            <table border="0" id="HTTP_DETAILS_MARK2" cellpadding="0" cellspacing="0">
              <tr>
                <td align="left">
                  <i18n:text>URL</i18n:text><xsl:text>:</xsl:text>
                  <xsl:call-template name="display_alert_mark"/>
                </td>
              </tr>
            </table>
            <script>
              <xsl:choose>
                <xsl:when test="MSG_OPTION[ID/@Value='HTTP']/SELECTED/@Value = 'true'">
                  i2uiToggleItemVisibility('HTTP_DETAILS_MARK1', 'hide');
                </xsl:when>
                <xsl:otherwise>
                  i2uiToggleItemVisibility('HTTP_DETAILS_MARK2', 'hide');
                </xsl:otherwise>
              </xsl:choose>
            </script>
          </td>

	    <td nowrap="true" width="25%">
	      <input type="field" class="inputfieldIE" name="HTTP_DETAILS" value="{MSG_OPTION[ID/@Value='HTTP']/DELIVERY_DETAILS/@Value}" size="35" tabIndex="">
		  <xsl:if test="MSG_OPTION[ID/@Value='HTTP']/SELECTED/@Value = 'true'">
		    <xsl:attribute name="required">true</xsl:attribute>
		  </xsl:if>
	      </input>
		<xsl:call-template name="display_alert_image">
		  <xsl:with-param name="fieldName" select="'HTTP_DETAILS'"/>
		</xsl:call-template>
            <script>
              i2uiToggleItemVisibility('HTTP_DETAILS_REQ', 'hide');
            </script>
          </td>

          <td nowrap="true" width="5%" rowspan="3" valign="top">
            <i18n:text>Contacts:</i18n:text>
          </td>
          <td nowrap="true" width="35%" rowspan="3" colspan="2" valign="top" align="left">
            <xsl:choose>
              <xsl:when test="count( CONTACTS/CONTACT ) > 0">
                <select class="inputfieldIE" name="CONTACTS" tabIndex="" multiple="multiple">
                  <xsl:for-each select="CONTACTS/CONTACT">
                    <option value="{ID/@Value}">
                      <xsl:if test="SELECTED/@Value = 'true'">
                        <xsl:attribute name="selected">selected</xsl:attribute>
                      </xsl:if>
                      <xsl:value-of select="LAST_NAME/@Value"/>, <xsl:value-of select="FIRST_NAME/@Value"/>
                    </option>
                  </xsl:for-each>
                </select>
              </xsl:when>
              <xsl:otherwise>
                <i18n:text>No contacts exist.</i18n:text>
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>

        <tr>
          <td width="3%">
            <input type="checkbox" name="FILE_CHECKED" tabindex="" onClick="javascript:checkRequiredField()">
              <xsl:if test="MSG_OPTION[ID/@Value='FILE']/SELECTED/@Value = 'true'">
                <xsl:attribute name="checked">checked</xsl:attribute>
              </xsl:if>
            </input>
          </td>
          <td nowrap="true" width="5%">
	    <i18n:text>File</i18n:text>
  	    </td>

          <td nowrap="true" width="5%">
            <table border="0" id="FILE_DETAILS_MARK1" cellpadding="0" cellspacing="0">
              <tr>
                <td align="left">
                  <i18n:text>Path</i18n:text><xsl:text>:</xsl:text>
                </td>
              </tr>
            </table>
            <table border="0" id="FILE_DETAILS_MARK2" cellpadding="0" cellspacing="0">
              <tr>
                <td align="left">
                  <i18n:text>Path</i18n:text><xsl:text>:</xsl:text>
                  <xsl:call-template name="display_alert_mark"/>
                </td>
              </tr>
            </table>
            <script>
              <xsl:choose>
                <xsl:when test="MSG_OPTION[ID/@Value='FILE']/SELECTED/@Value = 'true'">
                  i2uiToggleItemVisibility('FILE_DETAILS_MARK1', 'hide');
                </xsl:when>
                <xsl:otherwise>
                  i2uiToggleItemVisibility('FILE_DETAILS_MARK2', 'hide');
                </xsl:otherwise>
              </xsl:choose>
            </script>
          </td>

  	    <td nowrap="true">
	      <input type="field" class="inputfieldIE" name="FILE_DETAILS" value="{MSG_OPTION[ID/@Value='FILE']/DELIVERY_DETAILS/@Value}" size="35" tabIndex="">
		  <xsl:if test="MSG_OPTION[ID/@Value='FILE']/SELECTED/@Value = 'true'">
		    <xsl:attribute name="required">true</xsl:attribute>
		  </xsl:if>
		</input>
		<xsl:call-template name="display_alert_image">
		  <xsl:with-param name="fieldName" select="'FILE_DETAILS'"/>
		</xsl:call-template>
            <script>
              i2uiToggleItemVisibility('FILE_DETAILS_REQ', 'hide');
            </script>
	    </td>
        </tr>
        
        <tr>
          <td width="3%">
            <input type="checkbox" name="EAI_CHECKED" tabindex="">
              <xsl:if test="MSG_OPTION[ID/@Value='EAI']/SELECTED/@Value = 'true'">
                <xsl:attribute name="checked">checked</xsl:attribute>
              </xsl:if>
            </input>
          </td>
          <td nowrap="true" width="5%">
	    <i18n:text>EAI</i18n:text>
	  </td>
        </tr>
        
      </table>

    </i2:container>
    
  </xsl:template>

  <xsl:template match="MSG_OPTIONS" mode="view">
    
    <xsl:variable name="caption_title"><i18n:text>Messaging Options</i18n:text></xsl:variable>
    <i2:container title="{$caption_title}" stretch="yes" inner="yes">

      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0"  class="tableRow1">
        <tr>
          <td valign="top">
            <table border="0" cellpadding="0" cellspacing="5" width="100%">
              <tr>
                 <td nowrap="true" align="left" width="15%">
                  <xsl:choose>
                    <xsl:when test="MSG_OPTION[ID/@Value='HTTP']/SELECTED/@Value = 'true'">
                      <i18n:text>HTTP URL :</i18n:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <i18n:text>HTTP:</i18n:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
                <td nowrap="true" width="40%">
                  <xsl:choose>
                    <xsl:when test="MSG_OPTION[ID/@Value='HTTP']/SELECTED/@Value = 'true' and MSG_OPTION[ID/@Value='HTTP']/DELIVERY_DETAILS/@Value !=' ' ">
                      <xsl:value-of select="MSG_OPTION[ID/@Value='HTTP']/DELIVERY_DETAILS/@Value"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <i18n:text>N/A</i18n:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
                <td nowrap="true" width="15%" rowspan="3" valign="top">
                  <i18n:text>Contacts:</i18n:text>
                </td>
                <td nowrap="true" width="35%" rowspan="3" colspan="2" valign="top" align="left">
                  <xsl:choose>
                    <xsl:when test="count( CONTACTS/CONTACT[SELECTED/@Value = 'true'] ) > 0">
                      <xsl:for-each select="CONTACTS/CONTACT">
                        <xsl:if test="SELECTED/@Value = 'true'">
                          <xsl:value-of select="LAST_NAME/@Value"/>, <xsl:value-of select="FIRST_NAME/@Value"/> <br/>
                        </xsl:if>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="count( CONTACTS/CONTACT ) = 0">
                      <i18n:text>No contacts exist.</i18n:text>
                    </xsl:when>		
                    <xsl:otherwise>
                      <i18n:text>No contacts selected.</i18n:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>

              <tr>
                <td nowrap="true" width="15%">
                  <xsl:choose>
                    <xsl:when test="MSG_OPTION[ID/@Value='FILE']/SELECTED/@Value = 'true'">
                      <i18n:text>File Path:</i18n:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <i18n:text>File:</i18n:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
                <td nowrap="true" width="35%">
                  <xsl:choose>
                    <xsl:when test="MSG_OPTION[ID/@Value='FILE']/SELECTED/@Value = 'true' and MSG_OPTION[ID/@Value='FILE']/DELIVERY_DETAILS/@Value !=' '">
                      <xsl:value-of select="MSG_OPTION[ID/@Value='FILE']/DELIVERY_DETAILS/@Value"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <i18n:text>N/A</i18n:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
              
              <tr>
                <td nowrap="true" width="15%">
                  <i18n:text>EAI:</i18n:text>
                </td>
                <td nowrap="true" width="35%">
                  <xsl:choose>
                    <xsl:when test="MSG_OPTION[ID/@Value='EAI']/SELECTED/@Value = 'true'">
                      <i18n:text>Yes</i18n:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <i18n:text>N/A</i18n:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
            </table>
            
          </td>
        </tr>
      </table>
    </i2:container>
    
  </xsl:template>
  
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="include_javascript_messaging">
    <script type="text/javascript">
	  function checkRequiredField()
	  {
          var httpItem = document.getElementById('HTTP_CHECKED');
          var httpDetails = document.getElementById('HTTP_DETAILS');
          if (httpItem.checked == true)
          {
	      httpDetails.required='true';
            i2uiToggleItemVisibility('HTTP_DETAILS_MARK1', 'hide');
            i2uiToggleItemVisibility('HTTP_DETAILS_MARK2', 'show');
          }
	    else
          {
	      httpDetails.required='';
            i2uiToggleItemVisibility('HTTP_DETAILS_MARK1', 'show');
            i2uiToggleItemVisibility('HTTP_DETAILS_MARK2', 'hide');
            i2uiToggleItemVisibility('HTTP_DETAILS_REQ', 'hide');
          }
		  
          var fileItem = document.getElementById('FILE_CHECKED');
          var fileDetails = document.getElementById('FILE_DETAILS');
	    if (fileItem.checked == true)
          {
	      fileDetails.required='true';
            i2uiToggleItemVisibility('FILE_DETAILS_MARK1', 'hide');
            i2uiToggleItemVisibility('FILE_DETAILS_MARK2', 'show');
          }
	    else
          {
	      fileDetails.required='';
            i2uiToggleItemVisibility('FILE_DETAILS_MARK1', 'show');
            i2uiToggleItemVisibility('FILE_DETAILS_MARK2', 'hide');
            i2uiToggleItemVisibility('FILE_DETAILS_REQ', 'hide');
          }
	  }
    </script>
  </xsl:template>
  
</xsl:stylesheet>





<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
<xsl:import href="../../../../core/xsl/page.xsl"/>
<xsl:import href="../../../../core/xsl/container.xsl"/>
 
<xsl:variable name="currentAssignedRoleTemplateCount" select="count(//RESPONSES/RESPONSE/CONTAINER/ASSINABLE_USER_GRP_ROLE_TEMPLATES/ROLE_TEMPLATES)"/>
<xsl:variable name="returnPageOnDone" select="/RESPONSES/RESPONSE/RET_PAGE/@Value"/>
  <xsl:output method="html"/>
  <xsl:template match="RESPONSES" mode="content">
  <script>
    
    function onDone(){
      var backURL = '<xsl:value-of select="$returnPageOnDone"/>' ;
        document.location.href = backURL;
    } 
  </script>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td>
          <xsl:apply-templates select="RESPONSE/CONTAINER" mode="container">
            <xsl:with-param name="content" select="RESPONSE"/>
          </xsl:apply-templates>
        </td>
      </tr>
    </table>
  </xsl:template>
  
  <xsl:template match="RESPONSE" mode="container_content">
    <!--xsl:call-template name="hide_request_parameters"/-->
    <i2:table border="0">
      <i2:tr>
      <td align="left" valign="top">
          <table border="0" cellpadding="0" cellspacing="5" width="100%">
            <form name="frmSubscribeNotifications">
            <input type="hidden" name="ROLE_TEMPLATE_LIST" value=""/>
            <tr valign="middle">
              <td align="left" valign="middle">
                Available Role Templates
              </td>
              <td align="left" valign="middle"></td>
            </tr>                       
            <tr valign="middle">
              <td rowspan="3" align="center" valign="top">
              <select name="SELECTED_AVAILABLE_ROLE_TEMPLATES" class="pullDown" multiple="multiple">
                    <xsl:for-each select="//RESPONSES/RESPONSE/CONTAINER/ASSIGNABLE_ROLES/ASSIGNABLE_ROLE">
                        <xsl:variable name="roleTemplateID" select="VALUE_ID/@Value"/>
                        <xsl:variable name="displayName" select="DESCRIPTION/@Value"/>
                        <!-- check if this role template has been already assigned to users -->
                        <xsl:if test="not(string-length(//RESPONSES/RESPONSE/CONTAINER/ASSINABLE_USER_GRP_ROLE_TEMPLATES/ROLE_TEMPLATES[./@Value = $roleTemplateID]/@Value) &gt; 0 )" >
                            <option value="{$roleTemplateID}"><i18n:text><xsl:value-of select="$displayName"/></i18n:text></option>                             
                        </xsl:if>
                    </xsl:for-each>         
                </select>
              </td>
            </tr>
            </form>
          </table>
        </td>
        <td align="center">
          <table border="0" cellpadding="0" cellspacing="5" width="100%">
            <tr valign="middle">
              <td align="center" valign="middle">
                  <i2:button onclick="javascript:assignRoleTemplate(frmSubscribeNotifications)" nopadding="yes">&gt;&gt;</i2:button>
              </td>
            </tr>
            <tr valign="middle">
              <td align="center" valign="middle">
                  <i2:button onclick="javascript:unAssignRoleTemplate(frmUnsubscribeNotifications)" nopadding="yes">&lt;&lt;</i2:button>
              </td>
            </tr>
          </table>
        </td>
        <td align="left" valign="top" width="45%">
          <table border="0" cellpadding="0" cellspacing="5" width="100%">
            <form name="frmUnsubscribeNotifications">
                <input type="hidden" name="ROLE_TEMPLATE_LIST" value=""/>
              <tr align="left" valign="middle">
                <td align="left" valign="middle">
                  Current Assignable Role Templates:
                </td>
              </tr>
              <tr align="center" valign="middle">
                <td align="justify" valign="top">
                  <xsl:choose>
                    <xsl:when test="$currentAssignedRoleTemplateCount > 0">
                      <select name="SELECTED_CURRENT_ROLE_TEMPLATES" class="pullDown" MULTIPLE ="multiple">
                        <xsl:for-each select="//RESPONSES/RESPONSE/CONTAINER/ASSINABLE_USER_GRP_ROLE_TEMPLATES/ROLE_TEMPLATES">
                          <xsl:variable name="roleTemplateID" select="./@Value"/>
                          <xsl:variable name="displayName">
                            <i18n:text>
                              <xsl:value-of select="//RESPONSES/RESPONSE/CONTAINER/ASSIGNABLE_ROLES/ASSIGNABLE_ROLE[VALUE_ID/@Value = $roleTemplateID ]/DESCRIPTION/@Value"/>
                            </i18n:text>                                                                            
                          </xsl:variable>
                          <option value="{$roleTemplateID}"><i18n:text><xsl:value-of select="$displayName"/></i18n:text></option>
                        </xsl:for-each>         
                      </select>
                    </xsl:when>
                    <xsl:otherwise>
                      <cite>Currently , You do not have assignable Role Templates.</cite>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
            </form>
          </table>
        </td>
        
        
      </i2:tr>
    </i2:table>
    <i2:footer>
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td colspan="2">
            <i2:buttonbar>
                <xsl:call-template name="mdmButton">
                    <xsl:with-param name="onclick" select="'javascript:onDone();'"/>
                    <xsl:with-param name="text" select="'Done'"/>
                </xsl:call-template>
              <!--i2:button onclick="javascript:onDone()" nopadding="yes">Done</i2:button-->
            </i2:buttonbar>
          </td>
        </tr>
      </table>
    </i2:footer>
  </xsl:template>

</xsl:stylesheet>











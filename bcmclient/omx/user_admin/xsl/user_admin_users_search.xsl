<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="../../xsl/tabs.xsl"/>
  <xsl:import href="../../xsl/search_fields.xsl"/>
  <xsl:import href="../../xsl/buttons.xsl"/>
  
  
  <xsl:output method="html"/>
  
  
  <xsl:variable name="noOfColumns">10</xsl:variable>
  
  <xsl:variable name="noOfRows">
    <xsl:value-of select="count(RESPONSES/RESPONSE/USER_PROFILES/USER_PROFILE)"/>
  </xsl:variable>
  
  <!-- Search_fields -->
  <xsl:template match="RESPONSES">  
    <table cellspacing="1" cellpadding="0" border="0" width="100%" >
      <form name="search_form" action="user_admin_users_search.jsp" method="GET" target="appFrame">
        <tr>
          <td>
            <xsl:apply-templates select="RESPONSE/SEARCH"/>
          </td>
        </tr>
      </form>
    </table>
    
    
    <table cellspacing="1" cellpadding="0" border="0" width="100%" >
      <form name="resultForm" method="POST" action="omx/omx.deployment:exportOrder.cmd">	
        <tr>
          <td>
            <input type="hidden" name="DOC_TYPE" value="{RESPONSE/SEARCH/SIMPLE_SEARCH[FIELD_NAME/@Value= 'DOC_TYPE']/FIELD_VALUE/@Value}"/>  
            <input type="hidden" name="SORT_ORDER" value="{RESPONSE/SEARCH/SIMPLE_SEARCH[FIELD_NAME/@Value= 'SORT_ORDER']/FIELD_VALUE/@Value}"/>  
            <input type="hidden" name="SORT_BY" value="{RESPONSE/SEARCH/SIMPLE_SEARCH[FIELD_NAME/@Value= 'SORT_BY']/FIELD_VALUE/@Value}"/>  
            
            <xsl:if test="$noOfRows = 0">
              <i2:table id="usersTable">
                <i2:tr header="yes">
                  <td colspan="{$noOfColumns}" align="left">
                    &lt;b&gt;<i18n:text>Search Results</i18n:text>&lt;/b&gt;:&#xA0;
                    <i18n:text>No users found</i18n:text>.</td>
                </i2:tr>
              </i2:table>  
            </xsl:if>
            
            <xsl:if test="$noOfRows > 0">
              <i2:table id="usersTable" scrollablerows="yes" scrollablecolumns="auto">
                <i2:tr header="yes">
                  <xsl:if test="$noOfRows > 0">
                    <td colspan="{$noOfColumns}" align="left">
                      &lt;b&gt;<i18n:text>Search Results</i18n:text>&lt;/b&gt;:&#xA0;
                    </td>  
                  </xsl:if> 
                  <xsl:if test="$noOfRows = 0">
                    <td colspan="{$noOfColumns}" align="left">
                      &lt;b&gt;<i18n:text>Search Results</i18n:text>&lt;/b&gt;:&#xA0;
                      <i18n:text>No users found</i18n:text>.</td>
                  </xsl:if> 
                </i2:tr>
                
                <i2:tr header="yes">
                  <td align="center" nowrap="nowrap" class="checkboxColumn">
                    
                    <input type="checkbox" name="SELECT_ALL" value="true" onclick="javascript:toggleCheckboxes(document.forms.resultForm, document.forms.resultForm.EMAIL_ID, document.forms.resultForm.SELECT_ALL);"/>
                  </td>			
                  <td nowrap="nowrap">
                    <a onmouseover="javascript:i2uiSetMenuCoords(this,event)"  href="javascript:sort('LOGIN_NAME')">
                      <i18n:text>Login Name</i18n:text>
                    </a>
                    <xsl:if test="$sortBy = 'LOGIN_NAME'">
                      <b><xsl:value-of select="$sortOrder"/></b> 
                    </xsl:if> 
                  </td>
                  <td nowrap="nowrap"><i18n:text>First Name</i18n:text>
                    <xsl:if test="$sortBy = 'FIRST_NAME'">
                      <b><xsl:value-of select="$sortOrder"/></b>
                    </xsl:if> 
                  </td>
                  <td nowrap="nowrap"><i18n:text>Last Name</i18n:text>
                    <xsl:if test="$sortBy = 'LAST_NAME'">
                      <b><xsl:value-of select="$sortOrder"/></b>
                    </xsl:if>
                  </td>
                  <td nowrap="nowrap"><i18n:text>E-mail ID</i18n:text>
                    <xsl:if test="$sortBy = 'EMAIL_ADDRESS'">
                      <b><xsl:value-of select="$sortOrder"/></b>
                    </xsl:if>
                  </td>
                  <td nowrap="nowrap"><i18n:text>Organization</i18n:text>
                    <xsl:if test="$sortBy = 'ORG_NAME'">
                      <b><xsl:value-of select="$sortOrder"/></b>
                    </xsl:if>
                  </td>
                  
                  <td nowrap="nowrap">
                    <a  onmouseover="javascript:i2uiSetMenuCoords(this,event)" href="javascript:sort('STATUS')">
                      <i18n:text>Status</i18n:text>
                    </a>
                    <xsl:if test="$sortBy = 'STATUS'">
                      <b><xsl:value-of select="$sortOrder"/></b>
                    </xsl:if>
                  </td>
                  <td nowrap="nowrap"><i18n:text>Role</i18n:text></td>
                </i2:tr>
                <xsl:for-each select="RESPONSE/USER_PROFILES/USER_PROFILE">
                <i2:tr class="table2">
                    <xsl:choose>
                      <xsl:when test="normalize-space(EMAIL_ADDRESS/@Value) != ''">
                        <td align="center" nowrap="nowrap" class="checkboxColumn">
                          <input name="EMAIL_ID" type="checkbox" value="{EMAIL_ADDRESS/@Value}">
                          </input>
                        </td>
                      </xsl:when>
                      <xsl:otherwise>
                        <td align="center" nowrap="nowrap" class="checkboxColumn">
                          <input name="NO_EMAIL_ID" type="checkbox" disabled = "yes" value="{EMAIL_ADDRESS/@Value}"></input>
                        </td>
                      </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    <td nowrap="nowrap">
                      <a target="appFrame">
                        <xsl:attribute name="href">users_edit.jsp?USER_ID=<xsl:value-of select="ID/@Value"/>&amp;ROLE_ID=<xsl:value-of select="ROLE_ID/@Value"/></xsl:attribute><xsl:value-of select="LOGIN_NAME/@Value"/></a>
                    </td>
                    <td nowrap="nowrap"><xsl:value-of select="FIRST_NAME/@Value"/></td>
                    <td nowrap="nowrap"><xsl:value-of select="LAST_NAME/@Value"/></td>
                    <td nowrap="nowrap"><xsl:value-of select="EMAIL_ADDRESS/@Value"/></td>
                    <td nowrap="nowrap"><xsl:value-of select="ORG_NAME/@Value"/></td>
                    <td nowrap="nowrap"><xsl:value-of select="STATUS/@Value"/></td>
                    <td nowrap="nowrap">
                      <i18n:text><xsl:value-of select="ROLE_NAME/@Value"/></i18n:text>
                    </td>
                  </i2:tr>
                </xsl:for-each>
              </i2:table>
            </xsl:if>
          </td>
        </tr>
      </form> 
    </table>
    
    
  </xsl:template>
  
</xsl:stylesheet>


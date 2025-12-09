<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  
  <xsl:import href="../../xsl/tabs2.xsl"/>
   <xsl:import href="../../xsl/buttons.xsl"/>
  <xsl:import href="../../../core/xsl/page.xsl"/>
  
  <xsl:output method="html"/>
  
  <!--*****************************************-->

  <xsl:template match="RESPONSES">
    
      <script>
        var returnUrl = '<xsl:value-of select="RESPONSE/RET_PAGE/@Value"/>';
        function backToUserDetails()
        {
           parent.document.location.href= returnUrl;void(0);
        }
      </script>
    
    <xsl:variable name="colWidth" select=" 100 div count( /RESPONSES/RESPONSE/DOMAINS/DOMAIN ) "/>
    
    <xsl:variable name="tableWidth" >
      <xsl:choose>
        <xsl:when test="count( /RESPONSES/RESPONSE/DOMAINS/DOMAIN) = 1 ">
          <xsl:value-of select = "concat(50, '%' )"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select = "concat(100, '%')"/>
        </xsl:otherwise>
      </xsl:choose>
      
    </xsl:variable>
    <table width="{$tableWidth}" cellspacing="5">
      <tr>
        <xsl:apply-templates select="/RESPONSES/RESPONSE/DOMAINS/DOMAIN">
          <xsl:with-param name="colWidth" select="$colWidth"/>
        </xsl:apply-templates>
      </tr>
    </table>
    
  </xsl:template>
  
  <!--*****************************************-->
  
  <xsl:template match="DOMAIN">
    <xsl:param name="colWidth"/>
    
    <td width="{concat( $colWidth, '%' )}" valign="top"  >
      
      <xsl:choose>
        <xsl:when test="EDITING">
      <xsl:apply-templates select="." mode="edit"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="." mode="view"/>
    </xsl:otherwise>      
      </xsl:choose>
      
    </td>
    
</xsl:template>

<!--*****************************************-->
  
  <xsl:template match="DOMAIN" mode="view">
    <table width="100%" cellpadding="0" cellspacing="1" border="0">
      <tr>
        <td>
          <xsl:variable name="caption_title"><i18n:text>Existing <xsl:value-of select="NAME/@Value"/></i18n:text></xsl:variable>
          <i2:container title="{$caption_title}" inner="yes" width="100%">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
              <xsl:if test="count( ENTITIES/ENTITY ) = 0 ">
                <xsl:attribute name="class">tableRow1</xsl:attribute>
              </xsl:if>
              <tr>
                <td>
                  <xsl:choose>
                    <xsl:when test="count( ENTITIES/ENTITY ) > 0">     
                      <i2:table>
                        <xsl:apply-templates select="ENTITIES/ENTITY" mode="view"/>
                      </i2:table>
                    </xsl:when>
                    <xsl:otherwise>
                      <table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableRow1">
                        <tr>
                          <td>
                            <br/><center><i18n:text>No entities are listed in this domain.</i18n:text></center><br/>    
                          </td>
                        </tr>
                      </table>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
            </table>
            
            <xsl:if test="EDITABLE">
              <i2:footer>
                <i2:buttonbar>
                    <xsl:call-template name="mdmButton">
                        <xsl:with-param name="onclick" select="'javascript:parent.location='user_admin_domains.jsp?USER_ID={../USER_ID/@Value}&amp;ROLE_ID={../ROLE_ID/@Value}&amp;EDIT={DOMAIN_TYPE_ID/@Value}'">&#xA0;'"/>
                        <xsl:with-param name="text" select="'Edit'"/>
                    </xsl:call-template>
                  <!--i2:button onclick="javascript:parent.location='user_admin_domains.jsp?USER_ID={../USER_ID/@Value}&amp;ROLE_ID={../ROLE_ID/@Value}&amp;EDIT={DOMAIN_TYPE_ID/@Value}'">&#xA0;<i18n:text>Edit</i18n:text>&#xA0;</i2:button-->
                </i2:buttonbar>  
              </i2:footer>
            </xsl:if>
          </i2:container>
        </td>
      </tr>
    </table>
  </xsl:template>   

<!--*****************************************-->

<xsl:template match="DOMAIN" mode="edit">
    
    <form name="removeEntityForm" action="" method="post" target="appFrame">
      <input type="hidden" name="USER_ID" value="{../USER_ID/@Value}"/>   
      <input type="hidden" name="ROLE_ID" value="{../ROLE_ID/@Value}"/>   
      <input type="hidden" name="DOMAIN_TYPE_ID" value="{DOMAIN_TYPE_ID/@Value}"/>   
      <xsl:variable name="caption_title"><i18n:text>Existing <xsl:value-of select="NAME/@Value"/></i18n:text></xsl:variable>
      <xsl:choose>
        <xsl:when test="count( ENTITIES/ENTITY ) > 0">     
          <i2:container width="100%" title="{$caption_title}"  >
            <i2:table> 
              <i2:tr header="yes">
                <td align="center" class="checkboxColumn">
                  <input type="checkbox" name="SELECT_ALL" value="true" onclick="javascript:toggleCheckboxes(document.forms.removeEntityForm, document.forms.removeEntityForm.ENTITY_ID, document.forms.removeEntityForm.SELECT_ALL);"/>
                        </td>   
                    <td align="left">
                  <!--<a onmouseover="javascript:i2uiSetMenuCoords(this,event)" href="javascript:sort('ID')"> --> 
                  <xsl:value-of select="./NAME/@Value"/> <!--</a> -->
                  <!--<xsl:if test="RESPONSE/SEARCH/SORT_BY/@Value = 'ENTITY_ID'">
                <b><xsl:value-of select="$sortOrder"/></b>
                </xsl:if> -->
                    </td>
              </i2:tr>
              <xsl:apply-templates select="ENTITIES/ENTITY" mode="edit"/>
            </i2:table>
            <i2:footer>
              <i2:buttonbar>
                <xsl:call-template name="mdmButton">
                    <xsl:with-param name="onclick" select="'javascript:removeEntity();'"/>
                    <xsl:with-param name="text" select="'Remove'"/>
                </xsl:call-template>
                <!--i2:button onclick="javascript:removeEntity()">&#xA0;<i18n:text>Remove</i18n:text>&#xA0;</i2:button-->
              </i2:buttonbar>  
            </i2:footer>
          </i2:container>
        </xsl:when>
        <xsl:otherwise>
          <i18n:text>Search and add Entities to this domain.</i18n:text>
        </xsl:otherwise>
      </xsl:choose>
    </form>  
    
<xsl:variable name="caption_title"><i18n:text>Add <xsl:value-of select="NAME/@Value"/></i18n:text></xsl:variable>
    <i2:container title="{$caption_title}" width="100%">
      <table width="100%">
        <form name="entitySearchForm" action="user_admin_domains.jsp" method="get" target="appFrame">
          <tr><td>
              <input type="hidden" name="USER_ID" value="{../USER_ID/@Value}"/>   
              <input type="hidden" name="ROLE_ID" value="{../ROLE_ID/@Value}"/>   
              <input type="hidden" name="DOMAIN_TYPE_ID" value="{DOMAIN_TYPE_ID/@Value}"/>   
              <input type="hidden" name="EDIT" value="{DOMAIN_TYPE_ID/@Value}"/>   
              <table>
                <tr>
                  <td><input type="field" class="inputfieldIE" name="SEARCH_PARAM" size="15"/></td>
                  <td>
                    <xsl:call-template name="mdmButton">
                        <xsl:with-param name="onclick" select="'javascript:document.entitySearchForm.submit();'"/>
                        <xsl:with-param name="text" select="'Search'"/>
                    </xsl:call-template>
                  
                    <!--i2:button onclick="javascript:document.entitySearchForm.submit()">&#xA0;<i18n:text>Search</i18n:text>&#xA0;
                    </i2:button-->
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </form>
      </table>
      <xsl:apply-templates select="SEARCH_RESULTS"/>
      <i2:footer>
        <i2:buttonbar>
          <xsl:if test="count(SEARCH_RESULTS/ENTITIES/ENTITY) > 0">
            <xsl:call-template name="mdmButton">
                <xsl:with-param name="onclick" select="'javascript:addEntity();'"/>
                <xsl:with-param name="text" select="'Add'"/>
            </xsl:call-template>
            <!--i2:button onclick="javascript:addEntity()">&#xA0;<i18n:text>Add</i18n:text>&#xA0;</i2:button-->
          </xsl:if>
        </i2:buttonbar></i2:footer>
    </i2:container>
    
  </xsl:template>   
  
  <!--*****************************************-->
  
  <xsl:template match="SEARCH_RESULTS">
    <table  width="100%">
      <form name="addEntityForm" action="" method="post" target="appFrame">
        <tr><td>
            <input type="hidden" name="USER_ID" value="{../../USER_ID/@Value}"/>   
            <input type="hidden" name="ROLE_ID" value="{../../ROLE_ID/@Value}"/>   
            <input type="hidden" name="DOMAIN_TYPE_ID" value="{../DOMAIN_TYPE_ID/@Value}"/>   
            
            <xsl:choose>
              <xsl:when test="count( ENTITIES/ENTITY ) > 0">
                <i2:table  >
                  <i2:tr header="yes"> 
                    <td align="center" class="checkboxColumn">
                      <input type="checkbox" name="SELECT_ALL" value="true" onclick="javascript:toggleCheckboxes(document.forms.addEntityForm, document.forms.addEntityForm.ENTITY_ID, document.forms.addEntityForm.SELECT_ALL);"/>
                    </td>   
                    
                    <td align="left">
                      <!--<a onmouseover="javascript:i2uiSetMenuCoords(this,event)" href="javascript:sort('ID')"> --> 
                      <xsl:value-of select="../NAME/@Value"/> <!--</a> -->
                      <!--<xsl:if test="RESPONSE/SEARCH/SORT_BY/@Value = 'ENTITY_ID'">
                    <b><xsl:value-of select="$sortOrder"/></b>
                    </xsl:if> -->
                    </td>       
                  </i2:tr>      
                  <xsl:apply-templates select="ENTITIES/ENTITY" mode="edit"/>
                </i2:table>
                
              </xsl:when>
              <xsl:otherwise>
                <i><i18n:text>No entities were found that matched the search criteria.</i18n:text></i>  
              </xsl:otherwise>
            </xsl:choose>
          </td></tr>
      </form>
    </table>
    
  </xsl:template>
  
  <!--*****************************************-->
  
  <xsl:template match="ENTITY" mode="view">
    <i2:tr> 
      <td>
        <xsl:value-of select="NAME/@Value"/>
      </td>
    </i2:tr>
  </xsl:template>    

  <!--*****************************************-->
  
<xsl:template match="ENTITY" mode="edit">
    <i2:tr> 
      <td width="30" align="center" class="checkboxColumn">
        <input type="checkbox" name="ENTITY_ID" value="{ID/@Value}"/>
      </td>   
      <td>
        <xsl:value-of select="NAME/@Value"/>
      </td>
    </i2:tr>
  </xsl:template>    
  
  <!--*****************************************-->

</xsl:stylesheet>



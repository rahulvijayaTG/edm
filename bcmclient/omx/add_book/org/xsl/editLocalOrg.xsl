<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="../../../xsl/code_master.xsl"/>
  
  <xsl:output method="html"/>
  
  <xsl:template match="LOCAL_CUSTOMER" mode="edit">
    
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
      <form name="localOrgForm" action="data/addEditLocalOrganization.cmd" method="POST" target="appFrame">
        <input type="hidden" name="IS_NEW" value="{IS_NEW/@Value}"/>
        <input type="hidden" name="ID" value="{ID/@Value}"/>
        <input type="hidden" name="CUSTOMER_ORG_ID" value="{CUSTOMER_ORG_ID/@Value}"/>
        
        <xsl:variable name="caption_title"><i18n:text>Relationship Details</i18n:text></xsl:variable>
        
        <tr>
          <td height="100%">
            <i2:container title="{$caption_title}" stretch="yes" inner="yes">
              
              <table border="0" cellpadding="0" cellspacing="5" width="100%">
                <tr>
                  <td nowrap="true" width="10%"><i18n:text>Customer Type</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="true">
                    <select class="inputfieldIE" name="CUSTOMER_TYPE" tabIndex="1">
                      <xsl:apply-templates select="/RESPONSES/RESPONSE/CUSTOMER_TYPES/CODE_MASTER_VALUE" mode="pulldown">
                        <xsl:with-param name="selectedId">
                          <xsl:value-of select="CUSTOMER_TYPE/@Value"/>
                        </xsl:with-param>
                      </xsl:apply-templates>
                    </select> *
                  </td>
                  <td nowrap="true" width="25%">&amp;nbsp;</td>
                  <td nowrap="true" width="25%">&amp;nbsp;</td>
                </tr>
                <tr>            
                  <td nowrap="true"><i18n:text>Pricing Template</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="true">
                    <select class="inputfieldIE" name="PRICING_TEMPLATE" tabIndex="3">
                      <xsl:apply-templates select="/RESPONSES/RESPONSE/PRICING_TEMPLATES/CODE_MASTER_VALUE" mode="pulldown">
                        <xsl:with-param name="selectedId">
                          <xsl:value-of select="PRICING_TEMPLATE/@Value"/>
                        </xsl:with-param>
                      </xsl:apply-templates>
                    </select> *
                  </td>
                </tr>
                <tr>            
                  <td nowrap="true"><i18n:text>Status</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="true">
                    <xsl:if test="not(STATUS)">
                      <i18n:text>There are no existing relationships.</i18n:text>
                    </xsl:if>
                    <xsl:if test=" (STATUS/@Value = 'ACTIVE') ">
                      <i18n:text>Active</i18n:text>
                    </xsl:if>
					<xsl:if test=" (STATUS/@Value = 'DORMANT' or STATUS/@Value = 'INACTIVE') ">
                      <i18n:text>Inactive</i18n:text>
                    </xsl:if>
                  </td>
                </tr>
              </table>    
              
              <i2:footer>
               
                <i2:buttonbar>
                  
                  <i2:button onclick="javascript:parent.location='viewOrg.jsp?ORG_ID={CUSTOMER_ORG_ID/@Value}'" tabindex="201">&#xA0;<i18n:text>Reset</i18n:text>&#xA0;</i2:button>
                  <i2:buttonbardivider/>
                  <xsl:choose>
                    <xsl:when test="STATUS/@Value = 'ACTIVE'">
                      <i2:button onclick="javascript:deactivateLocalCustomer();" tabindex="203">&#xA0;<i18n:text>Deactivate</i18n:text>&#xA0;</i2:button>
                    </xsl:when>
                    <xsl:otherwise>
                      <i2:button onclick="javascript:activateLocalCustomer();" tabindex="203">&#xA0;<i18n:text>Activate</i18n:text>&#xA0;</i2:button>
                    </xsl:otherwise>
                  </xsl:choose>
                 
                  <xsl:if test=" (string-length(ID/@Value) &gt; 0) ">
                     <i2:buttonbardivider/>
                    <i2:button emphasized="yes" onclick="javascript:localOrgForm.submit()" tabindex="204">&#xA0;<i18n:text>Update</i18n:text>&#xA0;</i2:button>
                  </xsl:if>
                 
                  <xsl:if test=" (string-length(ID/@Value) = 0) ">
                     <i2:buttonbardivider/>
                    <i2:button emphasized="yes" onclick="javascript:localOrgForm.submit()" tabindex="204">&#xA0;<i18n:text>Save</i18n:text>&#xA0;</i2:button>
                  </xsl:if>
                 </i2:buttonbar>
              </i2:footer>
              
            </i2:container>
          </td>
        </tr>
      </form>
    </table>
    
  </xsl:template>

  <!-- ================================================================+
   | LOCAL SELLER                                                      |
   +===================================================================+ -->
  <xsl:template match="LOCAL_SELLER" mode="edit">
    
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
      <form name="localOrgForm" action="data/addEditLocalOrganization.cmd" method="POST" target="appFrame">
        <input type="hidden" name="IS_NEW" value="{IS_NEW/@Value}"/>
        <input type="hidden" name="SELLER_ORG_ID" value="{SELLING_ORG_ID/@Value}"/>
        
        <xsl:variable name="caption_title"><i18n:text>Relationship Details</i18n:text></xsl:variable>
        
        <tr>
          <td height="100%">
            <i2:container title="{$caption_title}" stretch="yes" inner="yes">
              
              <table border="0" cellpadding="0" cellspacing="5" width="100%">
                <tr>            
                  <td nowrap="true" width="10%"><i18n:text>Status</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="true">
                    <xsl:if test=" not(STATUS/@Value) or STATUS/@Value = 'DORMANT' or STATUS/@Value = 'INACTIVE' ">
                      <i18n:text>There are no existing relationships.</i18n:text>
                    </xsl:if>
                    <xsl:if test=" (STATUS/@Value = 'ACTIVE') ">
                      <i18n:text>Active</i18n:text>
                    </xsl:if>
                  </td>
                  <td nowrap="true" width="25%">&amp;nbsp;</td>
                  <td nowrap="true" width="25%">&amp;nbsp;</td>
                </tr>
              </table>    
              
              <i2:footer>
               
                <i2:buttonbar>
                  
                  <xsl:choose>
                    <xsl:when test="STATUS/@Value = 'ACTIVE'">
                      <i2:button onclick="javascript:deactivateLocalSeller();" tabindex="203">&#xA0;<i18n:text>Deactivate</i18n:text>&#xA0;</i2:button>
                    </xsl:when>
                    <xsl:otherwise>
                      <i2:button onclick="javascript:activateLocalSeller();" tabindex="203">&#xA0;<i18n:text>Activate</i18n:text>&#xA0;</i2:button>
                    </xsl:otherwise>
                  </xsl:choose>
                 
                 </i2:buttonbar>
              </i2:footer>
              
            </i2:container>
          </td>
        </tr>
      </form>
    </table>
    
  </xsl:template>

</xsl:stylesheet>


<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="../../../xsl/code_master.xsl"/>
  <xsl:import href="../../xsl/messaging.xsl"/>
  
  <xsl:output method="html"/>
  
  <xsl:template match="ORGANIZATION" mode="view">
    <script>
      function deactivateCustomer(){
      if( confirm( 'Deactivate this customer?' ) ){
	  parent.location = 'data/removeCustomer.cmd?ORG_ID=<xsl:value-of select="ID/@Value"/>';
	}
      }

      function deactivateSeller(){
      if( confirm( 'Deactivate this seller?' ) ){
	  parent.location = 'data/removeSeller.cmd?ORG_ID=<xsl:value-of select="ID/@Value"/>';
	}
      }
      
    </script>
    
    <table border="0" cellpadding="0" cellspacing="1" width="100%" height="100%">
      
      <xsl:variable name="caption_title"><i18n:text>Organization Details</i18n:text></xsl:variable>
      
      <tr>
        <td height="100%" colspan="3">
          <i2:container title="{$caption_title}" inner="yes">
            <table width="100%" class="tableRow1">
              <tr>
                <td valign="top">
                  <table border="0" cellpadding="0" cellspacing="5" width="100%">
                    <tr>						
                      <td nowrap="true" width="15%"><i18n:text>Full Name</i18n:text>:</td>
                      <td nowrap="true" width="35%"><xsl:value-of select="FULL_NAME/@Value"/></td>
                    </tr>
                    <tr>
                      <td nowrap="true" ><i18n:text>Name</i18n:text>:</td>
                        <xsl:choose>
                          <xsl:when test="NAME/@Value != ''">
                          <td nowrap="true">
                            <xsl:value-of select="NAME/@Value"/>
                          </td>
                          </xsl:when>
                          <xsl:otherwise>
                          <td nowrap="true">N/A</td>
                          </xsl:otherwise>
                      </xsl:choose>			                          
                    </tr>
                    <tr>
                      <td nowrap="true"><i18n:text>Parent Organization</i18n:text>:</td>
                        <xsl:choose>
                          <xsl:when test="PARENT_ORG_LINK and PARENT_ORG_LINK/ORGANIZATION/FULL_NAME/@Value != ''">
                          <td nowrap="true">
                            <a href="viewOrg.jsp?ORG_ID={PARENT_ORG_ID/@Value}" target="appFrame"><xsl:value-of select="PARENT_ORG_LINK/ORGANIZATION/FULL_NAME/@Value"/></a>
                          </td>
                          </xsl:when>
                          <xsl:otherwise>
                          <td nowrap="true">N/A</td>
                          </xsl:otherwise>
                      </xsl:choose>			                          
                    </tr>
                     <tr>
                      <td nowrap="true"><i18n:text>Currency</i18n:text>:</td>
                        <xsl:choose>
                          <xsl:when test="CURRENCY_CODE/@Value != ''">
                          <td nowrap="true">
                            <i18n:text><xsl:value-of select="CURRENCY_CODE/@Value"/></i18n:text>
                          </td>
                          </xsl:when>
                          <xsl:otherwise>
                          <td nowrap="true">N/A</td>
                          </xsl:otherwise>
                        </xsl:choose>			                          
                    </tr>									
<!--
                          <xsl:if test="VERSION/@Value != ''">
                            <tr>
                              <td nowrap="true"><i18n:text>Version</i18n:text>:</td>
                              <td nowrap="true">
                                <i18n:text><xsl:value-of select="VERSION/@Value"/></i18n:text>
                              </td>
                            </tr>
                          </xsl:if>
-->
                  </table>
                  
                </td>
                <td valign="top">
                  <table border="0" cellpadding="0" cellspacing="5" width="100%">
                    <!-- tr>						
                  <td nowrap="true"><i18n:text>Postal Code</i18n:text>:</td>
                  <td nowrap="true"><xsl:value-of select="POSTAL_CODE/@Value"/></td>
                  </tr>
                    <tr>
                  <td nowrap="true" width="10%"><i18n:text>State</i18n:text>:</td>
                  <td nowrap="true" width="25%"><i18n:text><xsl:value-of select="STATE/@Value"/></i18n:text></td>
                    </tr -->
                    <tr>
                      <td nowrap="true" width="15%"><i18n:text>Address</i18n:text>:</td>
                      <td nowrap="true" width="35%"><xsl:value-of select="ADDRESS1/@Value"/></td>
                    </tr>
                    <xsl:if test="ADDRESS2/@Value != ''">
                      <tr>
                        <td nowrap="true"></td>
                        <td nowrap="true"><xsl:value-of select="ADDRESS2/@Value"/></td>
                      </tr>
                    </xsl:if>
                    <xsl:if test="ADDRESS3/@Value != ''">
                      <tr>
                        <td nowrap="true"></td>
                        <td nowrap="true"><xsl:value-of select="ADDRESS3/@Value"/></td>
                      </tr>
                    </xsl:if>
                    <xsl:if test="ADDRESS4/@Value != ''">
                      <tr>
                        <td nowrap="true"></td>
                        <td nowrap="true"><xsl:value-of select="ADDRESS4/@Value"/></td>
                      </tr>
                    </xsl:if>
                    <xsl:if test="ADDRESS5/@Value != ''">
                      <tr>
                        <td nowrap="true"></td>
                        <td nowrap="true"><xsl:value-of select="ADDRESS5/@Value"/></td>
                      </tr>
                    </xsl:if>
                    <xsl:if test="COUNTY/@Value != ''">
                      <tr>
                        <td nowrap="true"><i18n:text>County</i18n:text>:</td>
                        <td nowrap="true"><xsl:value-of select="COUNTY/@Value"/></td>
                      </tr>
                    </xsl:if>
                    <xsl:if test="REGION/@Value != ''">
                      <tr>
                        <td nowrap="true"><i18n:text>Region</i18n:text>:</td>
                        <td nowrap="true"><xsl:value-of select="REGION/@Value"/></td>
                      </tr>
                    </xsl:if>
                     <tr>
                      <td nowrap="true"><i18n:text></i18n:text></td>
                      <td nowrap="true"><xsl:value-of select="CITY/@Value"/>,&#xA0;<xsl:value-of select="STATE/@Value"/>&#xA0;<xsl:value-of select="POSTAL_CODE/@Value"/></td>
                    </tr>
                     <tr>
                      <td nowrap="true"><i18n:text></i18n:text></td>
                      <td nowrap="true"><i18n:text><xsl:value-of select="COUNTRY/@Value"/></i18n:text></td>
                    </tr>
                    
                   							
                  </table>
                </td>
              </tr>
            </table>
          </i2:container>

        </td>
      </tr>
      <tr>
        <td width="100%" height="100%" colspan="3">
          
          <xsl:apply-templates select="/RESPONSES/RESPONSE/MSG_OPTIONS" mode="view"/>
        
        </td>
      </tr>
      <tr>
        <td width="50%" height="100%" colspan="2">
          
          <xsl:variable name="caption_title"><i18n:text>Customer</i18n:text></xsl:variable>
          <i2:container  stretch="yes"  title="{$caption_title}" inner="yes">
            <table width="100%" class="tableRow1" height="100%">
              <tr>	
                <td height="100%" valign="top">	
                  <xsl:choose>
                    <xsl:when test="CUSTOMER_STATUS/@Value = 'NONE' or CUSTOMER_STATUS/@Value = 'DORMANT' ">
                      <br/>
                      <center><i18n:text>This organization is not a customer.</i18n:text></center>
                      <br/>
                    </xsl:when>
                    <xsl:otherwise>
                      <table border="0" cellpadding="0" cellspacing="5" width="100%">
                        <tr>
                          <td nowrap="true" width="15%">
                            <input type="checkbox" name="IS_SINGLE_CORPORATE" value="true" disabled="true">
                              <xsl:if test="IS_SINGLE_CORPORATE/@Value = 'true'">
                                <xsl:attribute name="checked">true</xsl:attribute>
                              </xsl:if>
                              <i18n:text>Use Shared Entities</i18n:text>
                            </input>
                          </td>
                        </tr>
                        <tr>
                          <td nowrap="true"><i18n:text>Status</i18n:text>:</td>
                        <xsl:choose>
                          <xsl:when test="CUSTOMER_STATUS/@Value != ''">
                          <td nowrap="true">
                            <i18n:text><xsl:value-of select="CUSTOMER_STATUS/@Value"/></i18n:text>
                          </td>
                          </xsl:when>
                          <xsl:otherwise>
                          <td nowrap="true">N/A</td>
                          </xsl:otherwise>
                        </xsl:choose>			                          
                       </tr>
                      </table>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
            </table>
            
            <xsl:if test="EDITABLE">
              <i2:footer>
                <table border="0" cellpadding="0" cellspacing="2" width="100%">
                  <tr>
                    <td align="right" width="100%">&#xA0;</td>
                    <xsl:choose>
                      <xsl:when test="CUSTOMER_STATUS/@Value = 'Active'">
                        <td><i2:button onclick="javascript:deactivateCustomer()">&#xA0;<i18n:text>Deactivate</i18n:text>&#xA0;</i2:button></td>
                      </xsl:when>
                      <xsl:when test="CUSTOMER_STATUS/@Value = 'Dormant'">
                        <td><i2:button onclick="javascript:parent.location='data/activateCustomer.cmd?ORG_ID={ID/@Value}'">&#xA0;<i18n:text>Activate</i18n:text>&#xA0;</i2:button></td>
                      </xsl:when>
                    </xsl:choose>
                  </tr>
                </table>
              </i2:footer>
            </xsl:if>
          </i2:container>
          
        </td>
        <td width="50%" height="100%">
          
          
          <xsl:variable name="caption_title"><i18n:text>Seller</i18n:text></xsl:variable>
          <i2:container stretch="yes"  title="{$caption_title}" inner="yes">
            <table width="100%" border="0" class="tableRow1">
              <tr>	
                <td>	
                  <xsl:choose>
                    <xsl:when test="SELLER_STATUS/@Value = 'NONE' or SELLER_STATUS/@Value = 'DORMANT'">
                      <br/>
                      <center><i18n:text>This organization is not a seller.</i18n:text></center>
                      <br/>
                    </xsl:when>
                    <xsl:otherwise>
                      <table border="0" cellpadding="0" cellspacing="5" width="100%" >
                        <tr>				
                          <td nowrap="true" width="15%"><i18n:text>Default ShipFrom</i18n:text>:</td>
                        <xsl:variable name="centerId"><xsl:value-of select="DEFAULT_FC_ID/@Value"/></xsl:variable>
                        <xsl:choose>
                          <xsl:when test="DEFAULT_FC_ID and /RESPONSES/RESPONSE/FULFILLMENT_CENTERS/FULFILLMENT_CENTER[ID/@Value = $centerId]/FULL_NAME/@Value != ''">
                          <td nowrap="true" width="35%">           
                            <xsl:value-of select="/RESPONSES/RESPONSE/FULFILLMENT_CENTERS/FULFILLMENT_CENTER[ID/@Value = $centerId]/FULL_NAME/@Value"/>
                          </td>
                          </xsl:when>
                          <xsl:otherwise>
                          <td nowrap="true" width="35%">N/A</td>
                          </xsl:otherwise>
                        </xsl:choose>			                          
                        </tr>
                        <tr>
                          <td nowrap="true"><i18n:text>Backorders</i18n:text>:</td>
                          <td nowrap="true">
                            <xsl:choose>
                              <xsl:when test="ALLOWS_BACKORDERS/@Value = 'true'"><i18n:text>Yes</i18n:text></xsl:when>
                              <xsl:otherwise><i18n:text>No</i18n:text></xsl:otherwise>
                            </xsl:choose>
                          </td>
                        </tr>
                        <tr>
                          <td nowrap="true"><i18n:text>Transfer Order Billable</i18n:text>:</td>
                          <td nowrap="true">
                            <xsl:choose>
                              <xsl:when test="TRANSFER_ORDERS_BILLABLE/@Value = 'True'"><i18n:text>Yes</i18n:text></xsl:when>
                              <xsl:otherwise><i18n:text>No</i18n:text></xsl:otherwise>
                            </xsl:choose>
                          </td>
                        </tr>
                        <tr>
                          <td nowrap="true"><i18n:text>Tax ID</i18n:text>:</td>
                        <xsl:choose>
                          <xsl:when test="TAX_ID/@Value != ''">
                          <td nowrap="true">           
                            <xsl:value-of select="TAX_ID/@Value"/>
                          </td>
                          </xsl:when>
                          <xsl:otherwise>
                          <td nowrap="true">N/A</td>
                          </xsl:otherwise>
                        </xsl:choose>			                          
                        </tr>
                        <tr>
                          <td nowrap="true"><i18n:text>Tax Code</i18n:text>:</td>
                        <xsl:variable name="taxcode"><xsl:value-of select="TAX_CODE/@Value"/></xsl:variable>
                        <xsl:choose>
                          <xsl:when test="/RESPONSES/RESPONSE/TAX_CODES/CODE_MASTER_VALUE[VALUE_ID/@Value = $taxcode]/DESCRIPTION/@Value != ''">
                          <td nowrap="true">           
                            <i18n:text><xsl:value-of select="/RESPONSES/RESPONSE/TAX_CODES/CODE_MASTER_VALUE[VALUE_ID/@Value = $taxcode]/DESCRIPTION/@Value"/></i18n:text>
                          </td>
                          </xsl:when>
                          <xsl:otherwise>
                          <td nowrap="true">N/A</td>
                          </xsl:otherwise>
                        </xsl:choose>			                          
                        </tr>
                        <tr>
                          <td nowrap="true"><i18n:text>Repair Vendor</i18n:text>:</td>
                          <td nowrap="true">
                            <xsl:choose>
                              <xsl:when test="IS_REPAIR_VENDOR/@Value = 'true'"><i18n:text>Yes</i18n:text></xsl:when>
                              <xsl:otherwise><i18n:text>No</i18n:text></xsl:otherwise>
                            </xsl:choose>
                          </td>
                        </tr>
                        <tr>
                          <td nowrap="true"><i18n:text>VRMA Required</i18n:text>:</td>
                          <td nowrap="true">
                            <xsl:choose>
                              <xsl:when test="IS_VRMA_REQUIRED/@Value = 'true'"><i18n:text>Yes</i18n:text></xsl:when>
                              <xsl:otherwise><i18n:text>No</i18n:text></xsl:otherwise>
                            </xsl:choose>
                          </td>
                        </tr>
                        <tr>
                          <td nowrap="true"><i18n:text>Status</i18n:text>:</td>
                        <xsl:choose>
                          <xsl:when test="SELLER_STATUS/@Value != ''">
                          <td nowrap="true">           
                            <i18n:text>
                              <xsl:value-of select="SELLER_STATUS/@Value"/>
                            </i18n:text>
                          </td>
                          </xsl:when>
                          <xsl:otherwise>
                          <td nowrap="true">N/A</td>
                          </xsl:otherwise>
                        </xsl:choose>			                          
                        </tr>
                      </table>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
            </table>
            <xsl:if test="EDITABLE">
              <i2:footer>
                <table border="0" cellpadding="0" cellspacing="2" width="100%">
                  <tr>
                    <td align="right" width="100%">&#xA0;</td>
                    <xsl:choose>
                      <xsl:when test="SELLER_STATUS/@Value = 'Active'">
                        <td><i2:button onclick="javascript:deactivateSeller()">&#xA0;<i18n:text>Deactivate</i18n:text>&#xA0;</i2:button></td>
                      </xsl:when>
                      <xsl:when test="SELLER_STATUS/@Value = 'Dormant'">
                        <td><i2:button onclick="javascript:parent.location='data/activateSeller.cmd?ORG_ID={ID/@Value}'">&#xA0;<i18n:text>Activate</i18n:text>&#xA0;</i2:button></td>
                      </xsl:when>
                    </xsl:choose>
                  </tr>
                </table>
              </i2:footer>
            </xsl:if>
          </i2:container>
          
          <xsl:if test="EDITABLE">
            <i2:footer>
              <table border="0" cellpadding="0" cellspacing="2" width="100%">
                <tr>
                  <td align="right" width="100%">&#xA0;</td>
                  <td><i2:button emphasized="yes" onclick="javascript:parent.location='editOrg.jsp?ORG_ID={ID/@Value}'"  tabindex="201">&#xA0;<i18n:text>Edit</i18n:text>&#xA0;</i2:button></td>
                </tr>
              </table>
            </i2:footer>
          </xsl:if>
          
        </td>
      </tr>
    </table>
    
    
    
  </xsl:template>

</xsl:stylesheet>

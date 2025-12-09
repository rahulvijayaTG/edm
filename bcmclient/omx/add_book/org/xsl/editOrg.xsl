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
  <xsl:import href="../../../xsl/required_field.xsl"/>
  
  <xsl:output method="html"/>
  
  <xsl:template match="ORGANIZATION" mode="edit">
    
    <table border="0" cellpadding="0" cellspacing="1" width="100%" height="100%">
      
      <form name="orgForm" action="data/addEditOrganization.cmd" method="POST" target="appFrame">
        <input type="hidden" name="IS_NEW" value="{IS_NEW/@Value}"/>
        <input type="hidden" name="CUSTOMER_STATUS" value="{CUSTOMER_STATUS/@Value}"/>
        <input type="hidden" name="SELLER_STATUS" value="{SELLER_STATUS/@Value}"/>
        <input type="hidden" name="ID" value="{ID/@Value}"/>
        <input type="hidden" name="ADDRESS_ID" value="{ADDRESS_ID/@Value}"/>
        <input type="hidden" name="ORG_ID" value="{ID/@Value}"/>
        <input type="hidden" name="PARENT_ORG_ID" value="{PARENT_ORG_ID/@Value}"/>
        <input type="hidden" name="RE_CIR_PARAM_NAME" value="ORG_ID"/>
        <input type="hidden" name="RE_CIR_PARAM_NAME" value="PARENT_ORG_ID"/>
        <input type="hidden" name="PAGE" value="org_edit"/>

        <xsl:variable name="caption_title"><i18n:text>Organization Details</i18n:text></xsl:variable>
        
        <tr>
          <td height="100%" width="100%" colspan="3">

            <i2:container title="{$caption_title}" inner="yes" stretch="yes">

              <xsl:call-template name="display_instruction_area"/>

              <table border="0" cellpadding="0" cellspacing="5" width="100%">
                <tr>
                  <td>
              <table border="0" cellpadding="0" cellspacing="5" width="100%">
                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Full Name</i18n:text><xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <input type="field" name="FULL_NAME" value="{FULL_NAME/@Value}" required="true" tabIndex="" class="inputfieldIE" maxlength="32" size="27"/>
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'FULL_NAME'"/>
                    </xsl:call-template>
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Name</i18n:text><xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <input type="field" name="NAME" value="{NAME/@Value}" required="true" tabIndex="" class="inputfieldIE" maxlength="32" size="27"/>
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'NAME'"/>
                    </xsl:call-template>
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Parent Organization</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="nowrap">
                    <xsl:choose>
                      <xsl:when test="PARENT_ORG_LINK">
                        <xsl:value-of select="PARENT_ORG_LINK/ORGANIZATION/FULL_NAME/@Value"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <i18n:text>N/A</i18n:text>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Address Line 1</i18n:text><xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <input type="field" name="ADDRESS1" value="{ADDRESS1/@Value}" required="true" class="inputfieldIE" maxlength="64" size="27" tabIndex=""/>
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'ADDRESS1'"/>
                    </xsl:call-template>               
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Address Line 2</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="nowrap">
                    <input type="field" name="ADDRESS2" value="{ADDRESS2/@Value}" class="inputfieldIE" maxlength="64" size="27" tabIndex=""/>
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Address Line 3</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="nowrap">
                    <input type="field" name="ADDRESS3" value="{ADDRESS3/@Value}" class="inputfieldIE" maxlength="64" size="27" tabIndex=""/>
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Address Line 4</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="nowrap">
                    <input type="field" name="ADDRESS4" value="{ADDRESS4/@Value}" class="inputfieldIE" maxlength="64" size="27" tabIndex=""/>
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Address Line 5</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="nowrap">
                    <input type="field" name="ADDRESS5" value="{ADDRESS5/@Value}" class="inputfieldIE" maxlength="64" size="27" tabIndex=""/>
                  </td>
                </tr>

              </table>
                  </td>
                  <td>
              <table border="0" cellpadding="0" cellspacing="5" width="100%">
                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Postal Code</i18n:text><xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <input type="field" name="POSTAL_CODE" value="{POSTAL_CODE/@Value}" required="true" class="inputfieldIE" maxlength="32" size="27" tabIndex=""/>
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'POSTAL_CODE'"/>
                    </xsl:call-template>               
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>City</i18n:text><xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <input type="field" name="CITY" value="{CITY/@Value}" required="true" class="inputfieldIE" maxlength="32" size="27" tabIndex=""/>
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'CITY'"/>
                    </xsl:call-template>               
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>County</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="nowrap">
                    <input type="field" name="COUNTY" value="{COUNTY/@Value}" class="inputfieldIE" maxlength="32" size="27" tabIndex=""/>
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>State</i18n:text><xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <select class="inputfieldIE" name="STATE" tabIndex="" required="true">
                      <xsl:apply-templates select="/RESPONSES/RESPONSE/STATES/CODE_MASTER_VALUE" mode="pulldown">
                        <xsl:with-param name="selectedId">
                          <xsl:value-of select="STATE/@Value"/>
                        </xsl:with-param>
                      </xsl:apply-templates>
                    </select> 
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'STATE'"/>
                    </xsl:call-template>               
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Region</i18n:text><xsl:text>:</xsl:text></td>
                  <td nowrap="nowrap">
                    <input type="field" name="REGION" value="{REGION/@Value}" class="inputfieldIE" maxlength="32" size="27" tabIndex=""/>
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Country</i18n:text><xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <select class="inputfieldIE" name="COUNTRY" tabIndex="" required="true" onchange="javascript:changeCountry('orgForm')">
                      <xsl:apply-templates select="/RESPONSES/RESPONSE/COUNTRIES/CODE_MASTER_VALUE" mode="pulldown">
                        <xsl:with-param name="selectedId">
                          <xsl:value-of select="COUNTRY/@Value"/>
                        </xsl:with-param>
                      </xsl:apply-templates>
                    </select>
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'COUNTRY'"/>
                    </xsl:call-template>                
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap"><i18n:text>Currency</i18n:text><xsl:text>:</xsl:text>
                    <xsl:call-template name="display_alert_mark"/>
                  </td>
                  <td nowrap="nowrap">
                    <select class="inputfieldIE" name="CURRENCY_CODE" tabIndex="" required="true">
                      <xsl:apply-templates select="/RESPONSES/RESPONSE/CURRENCY_CODES/CODE_MASTER_VALUE" mode="pulldown_ids">
                        <xsl:sort select="VALUE_ID/@Value"/>
                        <xsl:with-param name="selectedId">
                          <xsl:value-of select="CURRENCY_CODE/@Value"/>
                        </xsl:with-param>
                      </xsl:apply-templates>
                    </select>
                    <xsl:call-template name="display_alert_image">
                      <xsl:with-param name="fieldName" select="'CURRENCY_CODE'"/>
                    </xsl:call-template>               
                  </td>
                </tr>

                <tr class="text">
                  <td nowrap="nowrap">&#xA0;</td>
                </tr>
              </table>
                  </td>
                </tr>
              </table>
              
            </i2:container>
            
          </td>
        </tr>
        
        <tr >
          <td height="100%" colspan="2">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
              <tr>						
                <td>
                  <xsl:apply-templates select="/RESPONSES/RESPONSE/MSG_OPTIONS" mode="edit"/>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        
        <tr>
          <td width="50%" height="100%">
            <xsl:variable name="caption_title"><i18n:text>Customer</i18n:text></xsl:variable>
            <i2:container title="{$caption_title}" stretch="yes" inner="yes">
              <table height="100%"  width="100%" cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td valign="top" height="100%">
                    <xsl:choose>
                      <xsl:when test=" CUSTOMER_STATUS/@Value = 'NONE' or CUSTOMER_STATUS/@Value = 'DORMANT' ">
                        <br/>
                        <center><i18n:text>This organization is not a customer.</i18n:text></center>
                        <br/>
                      </xsl:when>
                      <xsl:otherwise>
                        <table border="0" cellpadding="0" cellspacing="5" width="100%">
                          <tr>
                            <td nowrap="true" width="15%">
                              <input type="checkbox" name="IS_SINGLE_CORPORATE" value="true">
                                <xsl:if test="IS_SINGLE_CORPORATE/@Value = 'true'">
                                  <xsl:attribute name="checked">true</xsl:attribute>
                                </xsl:if>
                                <i18n:text>Use Shared Entities</i18n:text>
                              </input>
                            </td>
                          </tr>
                        </table>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                </tr>
              </table>
              
              <i2:footer>
                <table border="0" cellpadding="0" cellspacing="1" width="100%">
                  <tr>
                    <td align="right" width="100%">&#xA0;</td>
                    <xsl:if test="CUSTOMER_STATUS/@Value = 'NONE' or CUSTOMER_STATUS/@Value = 'DORMANT'">
                      <td><i2:button onclick="javascript:activateCustomer()"  tabindex="">&#xA0;<i18n:text>Activate</i18n:text>&#xA0;</i2:button></td>
                    </xsl:if>
                    <xsl:if test="CUSTOMER_STATUS/@Value = 'ACTIVE'">
                      <td><i2:button onclick="javascript:deactivateCustomer()" small="true" tabindex="">&#xA0;<i18n:text>Deactivate</i18n:text>&#xA0;</i2:button></td>
                    </xsl:if>
                  </tr>
                </table>
              </i2:footer>
            </i2:container>
          </td>
          
          <td width="50%" height="100%">
            <xsl:variable name="caption_title"><i18n:text>Seller</i18n:text></xsl:variable>
            <i2:container title="{$caption_title}" stretch="yes" inner="yes">
              <xsl:choose>
                <xsl:when test=" SELLER_STATUS/@Value = 'NONE' or SELLER_STATUS/@Value = 'DORMANT' ">
                  <br/>
                  <center><i18n:text>This organization is not a seller.</i18n:text></center>
                  <br/>
                </xsl:when>
                <xsl:otherwise>
                  <table border="0" cellpadding="0" cellspacing="5" width="100%">
                    <tr>				
                      <td nowrap="true" width="50%"><i18n:text>Default ShipFrom</i18n:text>:</td>
                      <!--Changes by Rishi For Fulfillment Center in omx/addressbook/Shipping association -->
                      <td nowrap="true" width="50%">
                        <xsl:choose>
                          <xsl:when test="count( /RESPONSES/RESPONSE/FULFILLMENT_CENTERS/FULFILLMENT_CENTER ) > 0">
                            <xsl:variable name="selectedFC"><xcore:value-of select="DEFAULT_FC_ID/@Value"/></xsl:variable>
                            <select class="inputfieldIE" name="DEFAULT_FC_ID">   
                              <xsl:for-each select="/RESPONSES/RESPONSE/FULFILLMENT_CENTERS/FULFILLMENT_CENTER">
                                <option value="{ID/@Value}">
                                  <xsl:if test="ID/@Value = $selectedFC">
                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                  </xsl:if>
                                  <i18n:text><xsl:value-of select="FULL_NAME/@Value"/></i18n:text>
                                </option>
                              </xsl:for-each>
                            </select> 
                          </xsl:when>
                          <xsl:otherwise>
                            <i18n:text>None</i18n:text>
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                    </tr>
                    
                    <tr class="text">
                      <td nowrap="nowrap"><i18n:text>Backorders</i18n:text><xsl:text>:</xsl:text>
                        <xsl:call-template name="display_alert_mark"/>
                      </td>
                      <td nowrap="nowrap">
                        <select class="inputfieldIE" name="ALLOWS_BACKORDERS" tabindex="" required="true">
                          <option value="true">
                            <xsl:if test="ALLOWS_BACKORDERS/@Value = 'true'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                            <i18n:text>Yes</i18n:text>
                          </option>  
                          <option value="false">
                            <xsl:if test="ALLOWS_BACKORDERS/@Value = 'false'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                            <i18n:text>No</i18n:text>
                          </option>  
                        </select>
                        <xsl:call-template name="display_alert_image">
                          <xsl:with-param name="fieldName" select="'ALLOWS_BACKORDERS'"/>
                        </xsl:call-template>               
                      </td>
                    </tr>

                    <tr>
                      <td nowrap="true"><i18n:text>Transfer Order Billable</i18n:text>:</td>
                      <td nowrap="true">
                        <select class="inputfieldIE" name="TRANSFER_ORDERS_BILLABLE" tabindex="">
                          <option value="true">
                            <xsl:if test="TRANSFER_ORDERS_BILLABLE/@Value = 'true'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                            <i18n:text>Yes</i18n:text>
                          </option>  
                          <option value="false">
                            <xsl:if test="TRANSFER_ORDERS_BILLABLE/@Value = 'false'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                            <i18n:text>No</i18n:text>
                          </option>  
                        </select>
                      </td>
                    </tr>

                    <tr class="text">
                      <td nowrap="nowrap"><i18n:text>Tax ID</i18n:text><xsl:text>:</xsl:text>
                        <xsl:call-template name="display_alert_mark"/>
                      </td>
                      <td nowrap="nowrap">
                        <input type="field" class="inputfieldIE" name="TAX_ID" value="{TAX_ID/@Value}" size="27" tabIndex="" required="true"/>
                        <xsl:call-template name="display_alert_image">
                          <xsl:with-param name="fieldName" select="'TAX_ID'"/>
                        </xsl:call-template>               
                      </td>
                    </tr>

                    <tr class="text">
                      <td nowrap="nowrap"><i18n:text>Tax Code</i18n:text><xsl:text>:</xsl:text>
                        <xsl:call-template name="display_alert_mark"/>
                      </td>
                      <td nowrap="nowrap">
                        <select class="inputfieldIE" name="TAX_CODE" tabIndex="" required="true">
                          <xsl:apply-templates select="/RESPONSES/RESPONSE/TAX_CODES/CODE_MASTER_VALUE" mode="pulldown">
                            <xsl:with-param name="selectedId">
                              <xsl:value-of select="TAX_CODE/@Value"/>
                            </xsl:with-param>
                          </xsl:apply-templates>
                        </select>
                        <xsl:call-template name="display_alert_image">
                          <xsl:with-param name="fieldName" select="'TAX_CODE'"/>
                        </xsl:call-template>               
                      </td>
                    </tr>

                    <tr class="text">
                      <td nowrap="nowrap"><i18n:text>Repair Vendor</i18n:text><xsl:text>:</xsl:text>
                        <xsl:call-template name="display_alert_mark"/>
                      </td>
                      <td nowrap="nowrap">
                        <select class="inputfieldIE" name="IS_REPAIR_VENDOR" tabindex="" required="true">
                          <option value="true">
                            <xsl:if test="IS_REPAIR_VENDOR/@Value = 'true'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                            <i18n:text>Yes</i18n:text>
                          </option>  
                          <option value="false">
                            <xsl:if test="IS_REPAIR_VENDOR/@Value = 'false'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                            <i18n:text>No</i18n:text>
                          </option>  
                        </select>
                        <xsl:call-template name="display_alert_image">
                          <xsl:with-param name="fieldName" select="'IS_REPAIR_VENDOR'"/>
                        </xsl:call-template>               
                      </td>
                    </tr>

                    <tr class="text">
                      <td nowrap="nowrap"><i18n:text>VRMA Required</i18n:text><xsl:text>:</xsl:text>
                        <xsl:call-template name="display_alert_mark"/>
                      </td>
                      <td nowrap="nowrap">
                        <select class="inputfieldIE" name="IS_VRMA_REQUIRED" tabindex="" required="true">
                          <option value="true">
                            <xsl:if test="IS_VRMA_REQUIRED/@Value = 'true'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                            <i18n:text>Yes</i18n:text>
                          </option>  
                          <option value="false">
                            <xsl:if test="IS_VRMA_REQUIRED/@Value = 'false'">
                              <xsl:attribute name="selected">selected</xsl:attribute>
                            </xsl:if>
                            <i18n:text>No</i18n:text>
                          </option>  
                        </select>
                        <xsl:call-template name="display_alert_image">
                          <xsl:with-param name="fieldName" select="'IS_VRMA_REQUIRED'"/>
                        </xsl:call-template>               
                      </td>
                    </tr>

                  </table>
                </xsl:otherwise>
              </xsl:choose>
              <i2:footer>
                <table border="0" cellpadding="0" cellspacing="1" width="100%">
                  <tr>
                    <td align="right" width="100%">&#xA0;</td>
                    <xsl:if test="SELLER_STATUS/@Value = 'NONE' or SELLER_STATUS/@Value = 'DORMANT'">
                      <td><i2:button onclick="javascript:activateSeller()"  tabindex="">&#xA0;<i18n:text>Activate</i18n:text>&#xA0;</i2:button></td>
                    </xsl:if>
                    <xsl:if test="SELLER_STATUS/@Value = 'ACTIVE'">
                      <td><i2:button onclick="javascript:deactivateSeller()" small="true" tabindex="">&#xA0;<i18n:text>Deactivate</i18n:text>&#xA0;</i2:button></td>
                    </xsl:if>
                  </tr>
                </table>
              </i2:footer>
            </i2:container>
            
            
          </td>
        </tr>
      </form>
    </table>
    
    <!--i2:footer>
      <table border="0" cellpadding="0" cellspacing="1" width="100%">
        <tr>
          <td align="right" width="100%">&#xA0;</td>
            <xsl:if test=" string-length(IS_NEW/@Value) != 0 and string-length(PARENT_ORG_ID/@Value) != 0 ">
              <td><i2:button onclick="javascript:resetChildOrg();" tabindex="">&#xA0;<i18n:text>Reset</i18n:text>&#xA0;</i2:button></td>
            </xsl:if>
            <xsl:if test=" string-length(IS_NEW/@Value) != 0 and string-length(PARENT_ORG_ID/@Value) = 0 ">
              <td><i2:button onclick="javascript:reset();" tabindex="">&#xA0;<i18n:text>Reset</i18n:text>&#xA0;</i2:button></td>
            </xsl:if>
            <xsl:if test="(UPDATE/@Value = 'true') or string-length(ID/@Value) != 0 ">
							<td><i2:button onclick="javascript:reset();" tabindex="">&#xA0;<i18n:text>Reset</i18n:text>&#xA0;</i2:button></td>
							<td><i2:button onclick="javascript:saveOrg()" tabindex="">&#xA0;<i18n:text>Update</i18n:text>&#xA0;</i2:button></td>
            </xsl:if>
          <td><i2:button onclick="javascript:saveOrgAs();" tabindex="">&#xA0;<i18n:text>Save As New</i18n:text>&#xA0;</i2:button></td>
        </tr>
      </table>
    </i2:footer-->
    
    <script type="text/javascript">
      requiredFieldCheck('onLoad');
    </script>
    
  </xsl:template>
  
</xsl:stylesheet>



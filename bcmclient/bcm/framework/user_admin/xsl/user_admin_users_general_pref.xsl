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
 
<xsl:variable name="currentDefaultOP" select="/RESPONSES/RESPONSE/CURRENT_USER_PREF/USER_ORG_ENTITY_DEFAULTS/DEF_ORDER_POINT_ID/@Value"/>
<xsl:variable name="currentDefaultCarrier" select="/RESPONSES/RESPONSE/CURRENT_USER_PREF/USER_ORG_ENTITY_DEFAULTS/DEF_CARRIER_ID/@Value"/>
<xsl:variable name="currentUserDefaultCount" select="count(/RESPONSES/RESPONSE/CURRENT_USER_PREF/*)"/>
<!-- Addition by ASHISH KAPOOR to fix Issue# 404612 - START -->
<xsl:variable name="currentDefaultCostCenter" select="/RESPONSES/RESPONSE/CURRENT_USER_PREF/USER_ORG_ENTITY_DEFAULTS/DEF_COST_CENTER_CODE/@Value"/>
<!-- Addition by ASHISH KAPOOR to fix Issue# 404612 - END -->
 
  <xsl:output method="html"/>
    <xsl:template match="RESPONSES" mode="content">
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
        <xsl:call-template name="display_general_pref_data">
            <xsl:with-param name="DATA" select="/RESPONSES/RESPONSE"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="display_general_pref_data">
        <xsl:param name="DATA"/>
        <table border="0" cellpadding="0" cellspacing="10">
            <form name="frmUpdateGeneralUserPref">
                <input name="CURRENT_USER_DEFAULT_COUNT" type="hidden" value="{$currentUserDefaultCount}"/>
                <tr align="left" valign="middle">
                    <td align="left" valign="middle" height="100%">
                        Order Point:
                    </td>
                    <td align="left" valign="middle" height="100%">
                        <select class="pulldown" name="ORDER_POINT">
                            <option value="">Select Order Point</option>
                            <xsl:apply-templates select="ORDER_POINTS"/>
                        </select>
                    </td>
                </tr>
                <tr align="left" valign="middle">
                    <td align="left" valign="middle" height="100%">
                        Carrier:
                    </td>
                    <td align="left" valign="middle" height="100%">
                        <select class="pulldown" name="CARRIER">
                            <option value="">Select Carrier</option>
                            <xsl:apply-templates select="ORG_CARRIERS"/>
                        </select>
                    </td>
                </tr>
                <tr align="left" valign="middle">
                    <td align="left" valign="middle" height="100%">
                        Cost Center:
                    </td>
                    <td align="left" valign="middle" height="100%">
                        <select class="pulldown" name="COST_CENTER">
                            <option value="">Select Cost Center</option>
                            <!-- Addition by ASHISH KAPOOR to fix Issue# 404612 - START -->
                            <xsl:apply-templates select="COST_CENTERS"/>
                            <!-- Addition by ASHISH KAPOOR to fix Issue# 404612 - END -->
                        </select>
                    </td>
                </tr>
            </form>
        </table>
            <i2:footer>
                <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <i2:buttonbar aligncontents="right">
                                <xsl:choose>
                                    <xsl:when test="$currentUserDefaultCount = 0">
                                        <xsl:call-template name="mdmButton">
                                            <xsl:with-param name="onclick" select="'javascript:updateGeneralUserPref(frmUpdateGeneralUserPref);'"/>
                                            <xsl:with-param name="text" select="'Add'"/>
                                        </xsl:call-template>
                                        <!--i2:button onclick="javascript:updateGeneralUserPref(frmUpdateGeneralUserPref)" nopadding="yes">Add</i2:button-->
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="mdmButton">
                                            <xsl:with-param name="onclick" select="'updateGeneralUserPref(frmUpdateGeneralUserPref);'"/>
                                            <xsl:with-param name="text" select="'Update'"/>
                                        </xsl:call-template>
                                        <!--i2:button onclick="javascript:updateGeneralUserPref(frmUpdateGeneralUserPref)" nopadding="yes">Update</i2:button-->
                                    </xsl:otherwise>
                                </xsl:choose>
                            </i2:buttonbar>
                        </td>
                    </tr>
            </table>
        </i2:footer>
    </xsl:template>
    
    <xsl:template match="ORDER_POINTS">
        <xsl:apply-templates select="ENABLED_ORDER_POINT"/>
    </xsl:template>
    <xsl:template match="ENABLED_ORDER_POINT">
        <xsl:choose>
            <xsl:when test="ORDER_POINT_ID/@Value = $currentDefaultOP">
                <option value="{ORDER_POINT_ID/@Value}" selected="selected"><xsl:value-of select="NAME/@Value"/></option>
            </xsl:when>
            <xsl:otherwise>
                <option value="{ORDER_POINT_ID/@Value}"><xsl:value-of select="NAME/@Value"/></option>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="ORG_CARRIERS">
        <xsl:apply-templates select="ORG_CARRIER_INFO"/>
    </xsl:template>
    <xsl:template match="ORG_CARRIER_INFO">
        <xsl:variable name="shipVia">
            <xsl:value-of select="SHIP_VIA/@Value"/>
        </xsl:variable>
        <xsl:variable name="shipMode">
            <xsl:value-of select="SHIP_MODE/@Value"/>
        </xsl:variable>
        <xsl:variable name="carrierInfo">
            <xsl:value-of select="concat($shipVia, ':', $shipMode)"/>
        </xsl:variable>
            <xsl:choose>
                <xsl:when test="ID/@Value = $currentDefaultCarrier">
                    <option value="{ID/@Value}" selected="selected"><xsl:value-of select="$carrierInfo"/></option>
                </xsl:when>
                <xsl:otherwise>
                    <option value="{ID/@Value}"><xsl:value-of select="$carrierInfo"/></option>
                </xsl:otherwise>
            </xsl:choose>
    </xsl:template>
    <!-- Addition by ASHISH KAPOOR to fix Issue# 404612 - START -->
    <xsl:template match="COST_CENTERS">
        <xsl:apply-templates select="CODE_MASTER_VALUE"/>
    </xsl:template>
    <xsl:template match="CODE_MASTER_VALUE">
        <xsl:choose>
            <xsl:when test="ID/@Value = $currentDefaultCostCenter">
                <option value="{ID/@Value}" selected="selected"><xsl:value-of select="VALUE_ID/@Value"/></option>
            </xsl:when>
            <xsl:otherwise>
                <option value="{ID/@Value}"><xsl:value-of select="VALUE_ID/@Value"/></option>
            </xsl:otherwise>
        </xsl:choose>   
    </xsl:template>
    <!-- Addition by ASHISH KAPOOR to fix Issue# 404612 - END -->
</xsl:stylesheet>
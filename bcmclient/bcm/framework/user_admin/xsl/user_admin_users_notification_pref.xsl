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
 
<xsl:variable name="currentSubscriptionsCount" select="count(/RESPONSES/RESPONSE/CURRENT_SUBSCRIPTIONS/*)"/>

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
        <xsl:call-template name="display_notification_pref_data">
            <xsl:with-param name="DATA" select="/RESPONSES/RESPONSE"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="display_notification_pref_data">
        <xsl:param name="DATA"/>
        <i2:table >
            <i2:tr>
                <td align="left" valign="top" width="45%">
                    <table border="0" cellpadding="0" cellspacing="5" width="100%">
                        <form name="frmUnsubscribeNotifications">
                            <tr align="left" valign="middle">
                                <td align="left" valign="middle">
                                    Current Subscriptions:
                                </td>
                            </tr>
                            <tr align="center" valign="middle">
                                <td align="justify" valign="top">
                                    <xsl:choose>
                                        <xsl:when test="$currentSubscriptionsCount > 0">
                                            <select name="SELECTED_CURRENT_NOTIFICATION" class="pullDown" multiple="multiple">
                                                <xsl:apply-templates select="CURRENT_SUBSCRIPTIONS"/>
                                            </select>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <cite>You are not subscribed to any notifications currently.</cite>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    
                                </td>
                            </tr>
                        </form>
                    </table>
                </td>
                <td align="left" valign="top">
                    <table border="0" cellpadding="0" cellspacing="5" width="100%">
                        <form name="frmSubscribeNotifications">
                        <tr valign="middle">
                            <td align="left" valign="middle">
                                Available Notifications:
                            </td>
                            <td align="left" valign="middle">
                                Protocols:
                            </td>
                        </tr>
                        <tr valign="middle">
                            <td rowspan="3" align="center" valign="top">
                                <select name="SELECTED_AVAILABLE_NOTIFICATION" class="pullDown" multiple="multiple">
                                    <xsl:apply-templates select="AVAILABLE_SUBSCRIPTIONS"/>
                                </select>
                            </td>
                            <!--td align="center" valign="middle">
                                <input type="checkbox" name="COMM_PROTOCOL" value="HTTP">HTTP</input>
                            </td-->
                        </tr>
                        <!-- Addition by ASHISH KAPOOR to fix Issue# 406036 - START -->
                        <xsl:apply-templates select="COMMUNICATION_PROTOCOLS"/>
                        <!-- Addition by ASHISH KAPOOR to fix Issue# 406036 - END -->
                        
                        <!--tr valign="middle">
                            <td align="center" valign="middle">
                                <input type="checkbox" name="COMM_PROTOCOL" value="EMAIL">Email</input>
                            </td>
                        </tr>
                        <tr valign="middle">
                            <td align="center" valign="middle">
                                <input type="checkbox" name="COMM_PROTOCOL" value="ALERT">Alert</input>
                            </td>
                        </tr-->
                        </form>
                    </table>
                </td>
            </i2:tr>
        </i2:table>
        <i2:footer>
            <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="45%">
                        <i2:buttonbar aligncontents="right">
                            <xsl:call-template name="mdmButton">
                                <xsl:with-param name="onclick" select="'javascript:unsubscribeToNotifications(frmUnsubscribeNotifications);'"/>
                                <xsl:with-param name="text" select="'Unsubscribe'"/>
                            </xsl:call-template>
                            <!--i2:button onclick="javascript:unsubscribeToNotifications(frmUnsubscribeNotifications)" nopadding="yes">Unsubscribe</i2:button-->
                        </i2:buttonbar>
                    </td>
                    <td>
                        <i2:buttonbar aligncontents="right">
                            <xsl:call-template name="mdmButton">
                                <xsl:with-param name="onclick" select="'javascript:subscribeToNotifications(frmSubscribeNotifications);'"/>
                                <xsl:with-param name="text" select="'Subscribe'"/>
                            </xsl:call-template>
                            <!--i2:button onclick="javascript:subscribeToNotifications(frmSubscribeNotifications)" nopadding="yes">Subscribe</i2:button-->
                        </i2:buttonbar>
                    </td>
                </tr>
            </table>
        </i2:footer>
    </xsl:template>
    <xsl:template match="AVAILABLE_SUBSCRIPTIONS">
        <xsl:apply-templates select="MSG_EVENT"/>
    </xsl:template>
    <xsl:template match="MSG_EVENT">
        <xsl:variable name="eventName" select="NAME/@Value"/>
        <xsl:variable name="serviceName" select="SERVICE_NAME/@Value"/>
        <xsl:variable name="msgEventID" select="concat($eventName, '|', $serviceName)"/>
        <option value="{$msgEventID}"><xsl:value-of select="NAME/@Value"/></option>
    </xsl:template>
    <xsl:template match="CURRENT_SUBSCRIPTIONS">
        <xsl:apply-templates select="SUBSCRIPTION_LIST"/>
    </xsl:template>
    <xsl:template match="SUBSCRIPTION_LIST">
        <xsl:variable name="eventName" select="MSG_EVENT_NAME/@Value"/>
        <xsl:variable name="serviceName" select="SERVICE_NAME/@Value"/>
        <xsl:variable name="commProtocol" select="COMM_PROTOCOL/@Value"/>
        <xsl:variable name="subscriptionID" select="concat($eventName, '|', $serviceName,'|', $commProtocol)"/>
        <xsl:variable name="displayName" select="concat($eventName, ': ', $commProtocol)"/>
        <option value="{$subscriptionID}"><xsl:value-of select="$displayName"/></option>
    </xsl:template>
    <!-- Addition by ASHISH KAPOOR to fix Issue# 406036 - START -->
    <xsl:template match="COMMUNICATION_PROTOCOLS">
        <xsl:apply-templates select="PROTOCOL"/>
    </xsl:template>
    <xsl:template match="PROTOCOL">
        <tr valign="middle">
            <td align="left" valign="middle">
                <input type="checkbox" name="COMM_PROTOCOL" value="{ID/@Value}"><xsl:value-of select="NAME/@Value"/></input>
            </td>
        </tr>
    </xsl:template>
    <!-- Addition by ASHISH KAPOOR to fix Issue# 406036 - END -->
</xsl:stylesheet>











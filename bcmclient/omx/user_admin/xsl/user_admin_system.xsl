<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.xapl.i18n.xsl.xalan.XalanXSLExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:import href="../../xsl/tabs.xsl"/>
<xsl:import href="../../xsl/code_master.xsl"/>

<xsl:output method="html"/>

<xsl:template match="RESPONSES/RESPONSE/SYSTEM_CONFIG">  
    <form name="systemForm" method="POST" target="appFrame">
        <xsl:variable name="caption_title"><i18n:text>Edit System Configuration Details</i18n:text></xsl:variable>
        <i2:container inner="yes" title="{$caption_title}">
    	    <table border="0" cellpadding="0" cellspacing="1" width="100%" class="tablebackground">
                <i2:tr>
                    <td nowrap="nowrap" align="left">
                        <b><i18n:text>Mandatory External Order Number</i18n:text></b>
                    </td>
    				<td nowrap="nowrap" align="left">
    					<xsl:choose>
    					<xsl:when test="EXT_ORDER_NO_REQUIRED/@Value = 'YES'">
    						<input name="EXT_ORDER_NO_REQUIRED" value="YES" checked="true" type="checkbox"/>
    					</xsl:when>
    					<xsl:otherwise>
    						<input name="EXT_ORDER_NO_REQUIRED" value="YES" type="checkbox"/>
    					</xsl:otherwise>
    					</xsl:choose>
    				</td>
    				<td nowrap="nowrap" align="left">
                        <b><i18n:text>Currency Source</i18n:text></b>
    				</td>
                    <td nowrap="nowrap" align="left">
                        <select name="CURRENCY_SOURCE" class="inputfieldIE">
                            <xsl:apply-templates select="CURRENCY_SOURCES/CURRENCY_SOURCE" mode="pulldown">
                                <xsl:with-param name="selectedId" select="CURRENCY_SOURCE/@Value"/>
                            </xsl:apply-templates>
                        </select>   
    				</td>
                </i2:tr>
            
            </table>
        </i2:container>
	</form>
</xsl:template>

    <xsl:template match="CURRENCY_SOURCES/CURRENCY_SOURCE" mode="pulldown">
        <xsl:param name="selectedId"/>
        <option value="{@Value}">
            <xsl:if test="$selectedId = @Value">
                <xsl:attribute name="selected">yes</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="DESCRIPTION/@Value"/>
        </option>
    </xsl:template>
                    
                    
                    
</xsl:stylesheet>
<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.xapl.i18n.xsl.xalan.XalanXSLExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:import href="../../../core/xsl/page.xsl"/>
<xsl:import href="../../xsl/tabs.xsl"/>

<xsl:output method="html"/>

<xsl:template match="RESPONSES">  
    <table width="50%" border="0" cellpadding="5" cellspacing="0" align="left" class="tableHeader">
        <tr>
            <td colspan="3"><b>Select Role</b></td>
        </tr>
        <tr>
            <td nowrap="nowrap" width="10%">Role Name</td>
            <td nowrap="nowrap">
                <select class="pulldown" name="ROLE_ID">
                    <option value="select">Select One</option>
                    <option value="administrator">Administrator</option>
                    <option value="user">User</option>
                </select>
            </td>
            <td nowrap="nowrap" width="100%">
                <xsl:call-template name="mdmButton">
                    <xsl:with-param name="onclick" select="'#'"/>
                    <xsl:with-param name="text" select="'Edit'"/>
                    <xsl:with-param name="emphasized" select="yes"/>
                </xsl:call-template>
            <!--i2:button emphasized="yes" onclick="#">Edit</i2:button-->
            
            </td>
        </tr>
    </table>

    <table width="50%" border="0" cellpadding="5" cellspacing="0" class="tableHeader">
        <tr>
            <td colspan="3"><b>Create New Role</b></td>
        </tr>
        <tr>
            <td nowrap="nowrap" width="10%"><b>Role Name:</b></td>
            <td nowrap="nowrap"><input type="field" class="inputfieldIE" name="ROLE_NAME" value="" size="17"/></td>
            <td nowrap="nowrap" width="100%">
                <xsl:call-template name="mdmButton">
                    <xsl:with-param name="onclick" select="'#'"/>
                    <xsl:with-param name="text" select="'Create'"/>
                    <xsl:with-param name="emphasized" select="yes"/>
                </xsl:call-template>
            
            <!--i2:button emphasized="yes" onclick="#">Create</i2:button-->
            </td>
        </tr>
    </table>

    <table border="0" cellpadding="0" cellspacing="3" width="100%">
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr class="tableHeader">
                        <td nowrap="nowrap">Role ID Here</td>
                        <td nowrap="nowrap">Role Name Here</td>
                        <td nowrap="nowrap" align="right" width="60%">Created: 02-02-01</td>
                    </tr>
                </table>
            </td>           
        </tr>
        <tr>
            <td class="tableColumnHeadings"><input type="checkbox"/> Document</td>
        </tr>
        <tr>
            <td>                
                <table border="0" cellpadding="0" cellspacing="5" width="60%">
                    <tr>
                        <td><input type="checkbox"/></td>
                        <td nowrap="nowrap">Action 1</td>
                        <td><input type="checkbox"/></td>
                        <td nowrap="nowrap">Action 1</td>
                        <td><input type="checkbox"/></td>
                        <td nowrap="nowrap">Action 1</td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"/></td>
                        <td nowrap="nowrap">Action 2</td>
                        <td><input type="checkbox"/></td>
                        <td nowrap="nowrap">Action 2</td>
                        <td><input type="checkbox"/></td>
                        <td nowrap="nowrap">Action 2</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</xsl:template>

</xsl:stylesheet>
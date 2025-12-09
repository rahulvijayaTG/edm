<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:output method="html"/>

<xsl:template match="/">
  <xsl:apply-templates select="/RESPONSES/RESPONSE/ORGANIZATIONS"/>
</xsl:template>

<xsl:template match="ORGANIZATIONS">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    <td valign="top">

      <xsl:variable name="title"><i18n:text>Select Organization</i18n:text></xsl:variable>
      <i2:container title="{$title}" collapsable="no">
    <i2:header>
      <table border="0" cellpadding="2" cellspacing="0" width="100%">
        <tr>
          <td align="right">
          <a href="javascript:popUpWindow('../../help/addbooksrch.html','popUp4')">
              <xsl:variable name="txtAltAttr"><i18n:text>Help</i18n:text></xsl:variable>
              <i2:img src="/help_avail.gif" alt="{$txtAltAttr}" border="0"/>
          </a>
          </td>
       </tr>
      </table>
    </i2:header>
  <xsl:variable name="orgSearchUrl"><xsl:call-template name="getOrgSearchUrl"/></xsl:variable>

  <table border="0" width="100%" bgcolor="white">
    <form name="org_form" method="get" action="{$orgSearchUrl}" target="appFrame">
      <tr>
        <td width="90%">
          <table>
            <tr>
              <td nowrap="true"><i18n:text>Organization Name</i18n:text>:</td>
              <td>
                <input type="text" class="inputfieldIE" name="ORG_SEARCH_CRITERIA"/>
              </td>
            </tr>
          </table>
        </td>
        <td align="left"><i2:button onclick="javascript:document.org_form.submit()" >&#xA0;<i18n:text>Search</i18n:text>&#xA0;</i2:button></td>
      </tr>
    </form>
  </table>


  <i2:table>
  <xsl:choose>
    <xsl:when test="count( ORGANIZATION ) > 0">
      <i2:tr header="true">
      <td nowrap="true" align="left">
        <i18n:text>Type</i18n:text>
        </td>
      <td nowrap="true" align="left">
        <i18n:text>Name</i18n:text>
        </td>
        </i2:tr>
      <xsl:apply-templates select="ORGANIZATION"/>
    </xsl:when>

<!--
    <xsl:otherwise>
      <i2:tr><td><i18n:text>No organizations</i18n:text></td></i2:tr>
    </xsl:otherwise>
-->
  </xsl:choose>
  </i2:table>

<xsl:if test="EDITABLE">
  <i2:footer>
    <table border="0" cellpadding="0" cellspacing="2" width="100%">
    <tr>
      <td align="right" width="100%">&#xA0;</td>
          <td><i2:button emphasized="yes" onclick="javascript:parent.location='editOrg.jsp'" tabindex="201">&#xA0;<i18n:text>Add</i18n:text>&#xA0;</i2:button></td>
    </tr>
    </table>
  </i2:footer>

  </xsl:if>

        </i2:container>
      <br/>
    </td>
  </tr>
</table>

</xsl:template>

<xsl:template match="ORGANIZATION">
   <i2:tr>
        <td>
      <xsl:choose>
        <xsl:when test="((CUSTOMER_STATUS/@Value = 'ACTIVE') or (CUSTOMER_STATUS/@Value = 'INACTIVE')) and ((SELLER_STATUS/@Value = 'ACTIVE') or (SELLER_STATUS/@Value = 'INACTIVE'))">
        <i18n:text>Customer/Seller</i18n:text>
      </xsl:when>
        <xsl:when test="((CUSTOMER_STATUS/@Value = 'ACTIVE') or (CUSTOMER_STATUS/@Value = 'INACTIVE'))">
        <i18n:text>Customer</i18n:text>
      </xsl:when>
        <xsl:when test="((SELLER_STATUS/@Value = 'ACTIVE') or (SELLER_STATUS/@Value = 'INACTIVE'))">
        <i18n:text>Seller</i18n:text>
      </xsl:when>
      <xsl:otherwise>
        <i18n:text>None</i18n:text>
      </xsl:otherwise>
      </xsl:choose>
    </td>
    <td align="left"><a target="appFrame">
      <xsl:attribute name="href"><xsl:call-template name="getOrgUrl"/>?ORG_ID=<xsl:value-of select="ID/@Value"/></xsl:attribute>
      <xsl:value-of select="FULL_NAME/@Value"/>
    </a></td>
    </i2:tr>
</xsl:template>

<xsl:template name="getOrgSearchUrl">index.jsp</xsl:template>
<xsl:template name="getOrgUrl">viewOrg.jsp</xsl:template>

</xsl:stylesheet>
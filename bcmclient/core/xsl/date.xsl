<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <xsl:output method="html"/>

  <xsl:template name="date_box_picker">

    <xsl:param name="pName"/>
    <xsl:param name="pValue"/>
    <xsl:param name="pElement"/>
    <xsl:param name="pRequired" select="'false'"/>
    <xsl:param name="pSize" select="'15'"/>

    <table cellspacing="0" border="0">
      <tr>
        <td nowrap="yes">
          <input type="field" class="inputfieldIE" name="{$pName}" value="{$pValue}" size="{$pSize}" tabIndex="">
            <xsl:if test="$pRequired = 'true'">
              <xsl:attribute name="required">true</xsl:attribute>
            </xsl:if>
          </input>
          <xsl:if test="$pRequired = 'true'">
            <xsl:call-template name="display_alert_image">
              <xsl:with-param name="fieldName" select="$pName"/>
            </xsl:call-template>
          </xsl:if>
        </td>
        <td valign="center" nowrap="yes">
          <A HREF="javascript:doNothing()" onclick="showCalendar({$pElement})" target="appFrame">
            <i2:img src="/cal_icon.gif" border="0" align="bottom"/>
          </A>
        </td>
      </tr>
    </table>

  </xsl:template>

</xsl:stylesheet>

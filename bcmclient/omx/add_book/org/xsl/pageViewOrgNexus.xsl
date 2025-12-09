<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:import href="../../../xsl/tabs2.xsl"/>
  <xsl:import href="../../../xsl/buttons.xsl"/>
  
  <xsl:output method="html"/>
  
  <xsl:template match="RESPONSES/RESPONSE">
		<form action="orgNexus/updateNexus.cmd" name="nexusForm" target="appFrame">
      <input type="hidden" name="ORG_ID" value="{/RESPONSES/RESPONSE/ORG_ID/@Value}"/>
      <input type="hidden" name="FEIN" value="{/RESPONSES/RESPONSE/FEIN/@Value}"/>
			<table width="100%" cellspacing="1" cellpadding="0">
				<tr><td width="25%" valign="top">
					<xsl:apply-templates mode="view" select="STATES/CODE_MASTER_VALUE">
						<xsl:sort select="DESCRIPTION/@Value"/>
					</xsl:apply-templates>
				</td></tr>
			</table>
		</form>
  </xsl:template>


  <xsl:template match="CODE_MASTER_VALUE" mode="view">
    <xsl:choose>
      <xsl:when  test="CHECKED/@Value='true'">
          <input type="checkbox" name="STATE" value="{VALUE_ID/@Value}" checked="checked">
            <xsl:if test="/RESPONSES/RESPONSE/EDITABLE/@Value != 'true'">
              <xsl:attribute name="disabled">true</xsl:attribute>
            </xsl:if>
            <i18n:text><xsl:value-of select="DESCRIPTION/@Value"/></i18n:text>
          </input>
		  <br/>
      </xsl:when>
      <xsl:otherwise>
          <input type="checkbox" name="STATE" value="{VALUE_ID/@Value}">
            <xsl:if test="/RESPONSES/RESPONSE/EDITABLE/@Value != 'true'">
              <xsl:attribute name="disabled">true</xsl:attribute>
            </xsl:if>
            <i18n:text><xsl:value-of select="DESCRIPTION/@Value"/></i18n:text>
          </input>
		  <br/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="position() mod 13 = 0">&lt;/td&gt;&lt;td width="25%" valign="top"&gt;</xsl:if>
  </xsl:template>


</xsl:stylesheet>


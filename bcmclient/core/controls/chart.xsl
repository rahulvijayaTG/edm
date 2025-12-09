<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">


  <xsl:import href="svg_graph.xsl"/>

	<!-- **********************************************************************
  *********************************************************************** -->
  <xsl:template match="CHART" mode="layout">
    <xsl:param name="chartName" select="@containerId"/>
    
    <table cellspacing="0" cellpadding="0" border="0" width="{./@ViewportWidth}px">
      <tr width="{./@ViewportWidth}px">
        <td width="100%">
          <i2:container id="{$chartName}" inner="yes" scrollable="false" title="{./@Title}" width="{./@ViewportWidth}">
						<table width="100%" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top">
									<i2:svgembed name="{$chartName}" width="{./@ViewportWidth}" height="{./@ViewportHeight + 25}">
										<xsl:call-template name="display_graph">
											<xsl:with-param name="DATA" select="." />
									    <xsl:with-param name="chartType" select="CHART_TYPE/@Value"/>
									    <xsl:with-param name="override_colors" select="CHART_KEY_COLORS/@Value"/>
									    <xsl:with-param name="key_names" select="CHART_KEY_NAMES/@Value"/>
											<xsl:with-param name="viewportWidth" select="./@ViewportWidth" />
											<xsl:with-param name="viewportHeigth" select="./@ViewportHeight" />
									    <xsl:with-param name="xlabels_width" select="./@XLabelsWidth"/>
									    <xsl:with-param name="yaxis_numticks" select="./@YAxisNumTicks"/>
                      <xsl:with-param name="allowNegatives" select="./@allowNegatives"/>
										  <xsl:with-param name="clickCallback" select="./@CallBackHandler" />
										</xsl:call-template>
									</i2:svgembed>
								</td>
							</tr>
						</table>
						<xsl:if test="BUTTONS">
							<i2:footer>
								<table cellspacing="0" cellpadding="0" width="100%"  border="0">
									<tr>
										<!-- Buttons  -->
										<td  align="right">
											<xsl:apply-templates select="BUTTONS"/>
										</td>
									</tr>
								</table>
							</i2:footer>
						</xsl:if>
          </i2:container>
        </td>
      </tr>
    </table>
    <xsl:apply-templates select="script"/>
  </xsl:template>

  <!-- **********************************************************************
  *********************************************************************** -->
</xsl:stylesheet>

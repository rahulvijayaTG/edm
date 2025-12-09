<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">


  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="EXCEL_PIVOT" mode="top">
    <xsl:apply-templates select="." mode="layout"/>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="EXCEL_PIVOT" mode="layout">
		<i2:pivot id="{@Id}">
			<pivot>
				<xsl:copy-of select="*"/>
			</pivot>
		</i2:pivot>
    <script>
		function scrollHelper()
		{
			var totalAvailWidth = document.body.offsetWidth - 30; //scrollbars, frame border and padding width subtracted from the total allowed width
			var totalAvailHeight = document.body.offsetHeight - 220; //scrollbars, header, frame border, tabs and padding height is subtracted
			
			i2uiInitPivot('<xsl:value-of select="@Id"/>', totalAvailHeight, totalAvailWidth);
		}
    </script>
	</xsl:template>
  <!-- **********************************************************************
     *********************************************************************** -->

</xsl:stylesheet>

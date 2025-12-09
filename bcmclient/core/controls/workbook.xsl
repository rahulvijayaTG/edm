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
  <xsl:template match="EXCEL_WORKBOOK" mode="top">
    <xsl:apply-templates select="." mode="layout"/>
  </xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->
  <xsl:template match="EXCEL_WORKBOOK" mode="layout">
	<i2:spreadsheet name="{@name}" id="{@Id}" width="{@width}" height="{@height}" >
	<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" 
				  xmlns:o="urn:schemas-microsoft-com:office:office" 
				  xmlns:x="urn:schemas-microsoft-com:office:excel"   				  xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" 				 		  xmlns:html="http://www.w3.org/TR/REC-html40">
<Styles>
  <Style ss:ID="unprotected">
   <Protection ss:Protected="0"/>
  </Style>
  <Style ss:ID="protected">
   <Interior ss:Color="#C0C0C0" ss:Pattern="Solid"/>
    <Protection ss:Protected="1"/>
  </Style>
<Style ss:ID="protectedDateType">
<Interior ss:Pattern="Solid" ss:Color="#C0C0C0"/>
<Protection ss:Protected="1"/>
<NumberFormat ss:Format="Short Date"/>
</Style>
<Style ss:ID="DateType">
   <NumberFormat ss:Format="Short Date"/>
</Style>
 </Styles>
			<xsl:apply-templates select="Names" mode="layout"/>
  			<xsl:apply-templates select="EXCEL_SPREADSHEET" mode="layout"/>

		</Workbook>
	</i2:spreadsheet>
	</xsl:template>

 <!-- **********************************************************************
     *********************************************************************** -->


	<xsl:template match="Names" mode="layout">
			<Names>
				<xsl:copy-of select="*"/>
			</Names>
	</xsl:template>

  <!-- **********************************************************************
     *********************************************************************** -->


	<xsl:template match="EXCEL_SPREADSHEET" mode="layout">

   			<Worksheet sheetName="{@sheetName}" sheetProtected="{@protect}">
					<xsl:copy-of select="*"/>
			<WorksheetOptions><FreezePanes/><SplitHorizontal>1</SplitHorizontal>				<TopRowBottomPane>1</TopRowBottomPane>				<LeftColumnRightPane>100</LeftColumnRightPane>				<SplitVertical>100</SplitVertical>			</WorksheetOptions>
			</Worksheet>

	</xsl:template>

</xsl:stylesheet>

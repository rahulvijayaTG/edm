<?xml version="1.0" standalone="no"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:svg="http://www.i2.com" version="1.0">
  
  <xsl:include href="svgChart.xsl"/>
  <xsl:output method="html" encoding="utf-8" media-type="image/svg+xml"/>
  
  <xsl:template name="display_graph"> 
    <xsl:param name="DATA" />
    <xsl:param name="chartType">bbbbbbbbbbbbbb</xsl:param>
    <xsl:param name="viewportWidth">390</xsl:param>
    <xsl:param name="viewportHeigth">200</xsl:param>
    <xsl:param name="xlabels_width">110</xsl:param>
    <xsl:param name="ylabels_width">50</xsl:param>
    <xsl:param name="clickCallback">myClickCallbackHandler</xsl:param>
    <xsl:param name="override_colors">#00ff00,#ffff00,#ff0000,default,default,default,#ff0000,default,default,default,default,default,default,default</xsl:param>
    <xsl:param name="yaxis_numticks">3</xsl:param>
    <xsl:param name="integral_yaxis_labels">true</xsl:param>
    <xsl:param name="yzoomLevel">0</xsl:param>
    <xsl:param name="yzoomIncrement">0</xsl:param>
    <xsl:param name="locale">en</xsl:param>
    <xsl:param name="numticksIsMinMax">true</xsl:param>
    <xsl:param name="allowNegatives">false</xsl:param>

    <xsl:call-template name="svg:svgChart">
      <xsl:with-param name="renderTypes" select="$chartType"/>
      <xsl:with-param name="actions">cccnnnnnnnnnnn</xsl:with-param>
      <xsl:with-param name="clickCallback" select="$clickCallback" />
      <xsl:with-param name="chart_title"></xsl:with-param>
      <xsl:with-param name="chart_title_height" select="'0'" />
      <xsl:with-param name="viewport_width" select="$viewportWidth"/>
      <xsl:with-param name="viewport_heigth" select="$viewportHeigth"/>
      <xsl:with-param name="xaxis_title"></xsl:with-param>
      <xsl:with-param name="xaxis_labels" select="$DATA/CHART_DATA/@Label"/>
      <xsl:with-param name="xlabels_width" select="$xlabels_width" />
      <xsl:with-param name="ylabels_width" select="$ylabels_width" />
      <xsl:with-param name="ylabels_height">22</xsl:with-param>
      <xsl:with-param name="yaxis_title"></xsl:with-param>
      <xsl:with-param name="yaxis_numticks" select="$yaxis_numticks" />
      <xsl:with-param name="integral_yaxis_labels" select="$integral_yaxis_labels" />
      <xsl:with-param name="numticksIsMinMax" select="$numticksIsMinMax"/>
      <xsl:with-param name="bar_width">20</xsl:with-param>
      <xsl:with-param name="insets">004,028,052,076,100,124,148,172,196,220,244,268,292</xsl:with-param>
      <xsl:with-param name="data1" select="$DATA/CHART_DATA/CHART_ITEM[@Number='0']"/>
      <xsl:with-param name="data2" select="$DATA/CHART_DATA/CHART_ITEM[@Number='1']"/>
      <xsl:with-param name="data3" select="$DATA/CHART_DATA/CHART_ITEM[@Number='2']"/>
      <xsl:with-param name="data4" select="$DATA/CHART_DATA/CHART_ITEM[@Number='3']"/>
      <xsl:with-param name="data5" select="$DATA/CHART_DATA/CHART_ITEM[@Number='4']"/>
      <xsl:with-param name="data6" select="$DATA/CHART_DATA/CHART_ITEM[@Number='5']"/>
      <xsl:with-param name="data7" select="$DATA/CHART_DATA/CHART_ITEM[@Number='6']"/>
      <xsl:with-param name="data8" select="$DATA/CHART_DATA/CHART_ITEM[@Number='7']"/>
      <xsl:with-param name="data9" select="$DATA/CHART_DATA/CHART_ITEM[@Number='8']"/>
      <xsl:with-param name="data10" select="$DATA/CHART_DATA/CHART_ITEM[@Number='9']"/>
      <xsl:with-param name="data11" select="$DATA/CHART_DATA/CHART_ITEM[@Number='10']"/>
      <xsl:with-param name="data12" select="$DATA/CHART_DATA/CHART_ITEM[@Number='11']"/>
      <xsl:with-param name="data13" select="$DATA/CHART_DATA/CHART_ITEM[@Number='12']"/>
      <xsl:with-param name="data14" select="$DATA/CHART_DATA/CHART_ITEM[@Number='13']"/>
      
      <xsl:with-param name="key_names">
        <!-- <xsl:value-of select="concat('High',',Medium',',Low')"/> -->
        <xsl:value-of select="$DATA/CHART_KEY_NAMES/@Value" />
      </xsl:with-param>
          <xsl:with-param name="enableDataAttrs">true</xsl:with-param>
      <xsl:with-param name="stacked">0</xsl:with-param>
      <!--
       <xsl:with-param name="enableDataAttrs">true</xsl:with-param>
       <xsl:with-param name="override_bar_widths">def,def,def,def,def,def,036,def,def,def,def,def,def,def</xsl:with-param>
       <xsl:with-param name="override_colors">default,default,default,default,default,default,#ff0000,default,default,default,default,default,default,default</xsl:with-param>
       <xsl:with-param name="override_opacities">def,def,def,def,def,def,def,def,def,def,def,def,def,def</xsl:with-param>
       -->
      <xsl:with-param name="override_colors" select="$override_colors" />
      <xsl:with-param name="yzoomLevel" select="$yzoomLevel" />
      <xsl:with-param name="yzoomIncrement" select="$yzoomIncrement" />
      <!--
      <xsl:with-param name="colorscheme">abecij</xsl:with-param>
       <xsl:with-param name="enableSvgMenu">true</xsl:with-param>
       <xsl:with-param name="enableZoom">true</xsl:with-param>
       -->
      <xsl:with-param name="locale" select="$locale"/>
      <xsl:with-param name="allowNegatives" select="$allowNegatives"/>
    </xsl:call-template>

  </xsl:template>
</xsl:stylesheet>
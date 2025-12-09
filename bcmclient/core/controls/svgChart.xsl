<?xml version="1.0" standalone='no'?>

<!--
  This XSL produces SVG output to display bar, line, or area charts.

  Parameters:
  renderTypes      - the chart type for each dataset; b - bar, l - line, a - area; def: bbbbbbbbbb
  viewport_width   - the width of the viewport the chart will be displayed in; def: none - param is required
  chart_title      - the chart title; def: empty string
  chart_title_height how tall to make the chart title; def: 25
  xaxis_title      - the primary x axis title; def: empty string
  xaxis_title2     - the secondary x axis title; def: empty string
  xaxis_labels     - the nodeset containing the primary x axis labels; def: empty nodeset
  xlabels_width    - how wide to make each x axis label; def: 133
  xlabels_height   - how tall to make each x axis label; def: 25
  xaxis_labels2    - the nodeset containing the secondary x axis labels; def: empty nodeset
  xlabels2_height  - the display height for the secondary x axis labels; def: 0
  xlabels2_span    - flag to enable secondary x label spanning; def: false
  yaxis_title      - the y axis title; def: empty string
  yaxis_numticks   - number of points on the y axis; def: 10
  ylabels_width    - how wide to make each y axis label; def: 150
  ylabels_height   - how tall to make each y axis label; def: 25
  data1            - the nodeset containing the first data point; def: none - param is required
  data2            - the nodeset containing the second data point; def: empty nodeset
  data3            - the nodeset containing the third data point; def: empty nodeset
  data4            - the nodeset containing the fourth data point; def: empty nodeset
  data5            - the nodeset containing the fifth data point; def: empty nodeset
  data6            - the nodeset containing the sixth data point; def: empty nodeset
  data7            - the nodeset containing the seventh data point; def: empty nodeset
  data8            - the nodeset containing the eighth data point; def: empty nodeset
  data9            - the nodeset containing the ninth data point; def: empty nodeset
  data10           - the nodeset containing the tenth data point; def: empty nodeset
  data11           - the nodeset containing the 11th data point; def: empty nodeset
  data12           - the nodeset containing the 12th data point; def: empty nodeset
  data13           - the nodeset containing the 13th data point; def: empty nodeset
  data14           - the nodeset containing the 14th data point; def: empty nodeset
  key_names        - comma separated list of legend names; one for each data point; def: empty string
  bar_width        - default widt of a bar; def: 10
  colorscheme      - the color code for each dataset; def: abcdefghijklmn
  insets           - insets for each bar in an x axis bucket; def: 003,016,029,042,055,068,081,094,107,120,133,146,159,172
  stacked          - index of the first bar to stack; 0-none, 1-all, 2-all but first 1, ...; def: 0
  override_bar_widths - comma separated list of individual bar widths; def: def,def,def,def,def,def,def,def,def,def,def,def,def,def
  override_opacities  - comma separated list of individual dataset opacities; def: def,def,def,def,def,def,def,def,def,def,def,def,def,def
  override_colors     - comma separated list of individual dataset colors; default: default,default,default,default,default,default,default,default,default,default,default,default,default,default
  UserAgent        - the HTTP header value; def: MSIE
  actions          - the action type for each dataset; c - click, d - drag, n - none; def: nnnnnnnnnnnnnn
  enableShowValue  - flag to enable or disable the show value function; def: true
  enableChartTitle - flag to enable or disable the show value function; def: true
  enableScrollbar  - flag to enable or disable the show value function; def: true
  enableLegend     - flag to enable or disable the show value function; def: true
  reverseZOrder    - flag that reverses the rendering order of the data sets; def: false
  integral_yaxis_labels - flag to force y axis labels to be integral; def: false
  numticksIsMinMax - flag specifying yaxis_numticks as the minimum maximum; def: false
  clickCallback    - the JavaScript function called when a graphical element is clicked; def: empty string
  dragCallback     - the JavaScript function called when a graphical element is dragged; def: empty string
  contextData      - a string containing whatever context information the user wants to provide; def: empty string
  enableDataAttrs  - flag to enable capturing the data attributes as userdata; def: false
  enableSvgMenu    - flag to enable the display of the default SVG right-click menu; def: false
  locale           - the locale name used to localize the chart display
  enableZoom       - flag to enable the Zoom functionality
  yzoomLevel       - the initial zoom on the y axis; def: 0 (display complete y axis)
  yzoomIncrement   - the amount zooming increases or decrases the y axis; def: 1.0; 0 disables y zoom
  fontfamily       - the font family specification used to override the default; def: none
  titlefontsize    - the font size used to override the default for title text; def: none
  labelfontsize    - the font size used to override the default for label text; def: none
  allowNegatives   - set true if data may contain negative values and those should be displayed
-->

<!--
  author: larry mason, october 2000
  modified by richard hargrove, december 2000
  - allow the user to specify each data set's rendering type
  - bar positioning now ignores intervening lines
  - add data validation support and operations before rendering a data value
  - encapsulate the data rendering in the renderData template
  rewritten by richard hargrove, february - march 2001
  - conform to the standard (frog) look & feel
  - add bar stacking
  - add click functionality for all graphical elements
  - add drag functionality (value editing) for lines
  - add show value functionality
  modified by richard hargrove, april 2001
  - put all components (title, scrollbar, and legend) back into a single svg image
  - add drag functionality (value editing) for bars
  - implement freeze frame functionality (scrolling only moves xaxis and chart)
  - make title, scrollbar, and legend optional
  - add context data and data attributes as user controlled callback data
  modified by richard hargrove, may 2001
  - numerous bug fixes and small enhancements
  modified by nitin, oct 2001 - feb 2002
  - add i18n/l9n support
  - add y axis zoom functionality
  modified by richard hargrove, feb,mar 2002
  - moved to the i2ui vob
  - put the named templates in the i2 namespace
  - removed the dependence on extension functions (except for formatNumber)
  - streamlined the i18n/l9n
  - modified the extension functions to not contain XSLT processor-specific type definitions
    and placed them in an i2ui extensions file
  - made font family and sizes template parameters
  - replaced zoom interface with icons in chart title; reclaimed legend space
  - added secondary x axis title
  - modified the legend layout algorithm to size each column to the widest cell in the column
  modified by richard hargrove, apr 2002
  - redesigned and reimplemented y axis zooming to incorporate scrolling
  - update documentation
-->

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xt="http://www.jclark.com/xt"
  xmlns:xalan="http://xml.apache.org/xalan"
  xmlns:msxml="urn:schemas-microsoft-com:xslt"
  xmlns:saxon="http://icl.com/saxon"
  xmlns:i2="http://www.i2.com"
  xmlns:ExtXt="http://www.jclark.com/xt/java/i2uiExtensions"
  xmlns:ExtXalan="xalan://i2uiExtensions"
  exclude-result-prefixes="ExtXt ExtXalan"
  version="1.0">

  <xsl:include href="i2uiskindefs.xsl"/>

  <!-- xslt based localization support -->
  <xsl:include href="i2uitranslations.xsl"/>
  <!-- we cannot include this file because XT will not compile it
  <xsl:include href="i2uidecimalformats.xsl"/>
  -->

  <!-- some actual constants -->
  <xsl:variable name="svgtitlefontcolor">#505050</xsl:variable>
  <xsl:variable name="svglabelfontcolor">#505050</xsl:variable>
  <xsl:variable name="margin">5</xsl:variable>
  <xsl:variable name="defaultHeight">25</xsl:variable>
  <xsl:variable name="titleColorBg">#bec5e7</xsl:variable>
  <xsl:variable name="axisTitleColorBg">#d1d6f0</xsl:variable>
  <!--<xsl:variable name="labelColorBg">#d1d6f0</xsl:variable>-->
  <xsl:variable name="labelColorBg">#f7f8fd</xsl:variable>
  <!--<xsl:variable name="axisBorderColor">#909090</xsl:variable>-->
  <xsl:variable name="axisBorderColor">#909090</xsl:variable>
  <xsl:variable name="barBorderColor">#404040</xsl:variable>
  <xsl:variable name="chartBorderColor">#909090</xsl:variable>
  <!--<xsl:variable name="chartColorBg">#f2f4fe</xsl:variable>
  <xsl:variable name="chartColorBgAlt">#f7f8fd</xsl:variable>-->
  <xsl:variable name="chartColorBg">#ffffff</xsl:variable>
  <xsl:variable name="chartColorBgAlt">#ffffff</xsl:variable>
  <xsl:variable name="legendColorBg">#ffffff</xsl:variable>
  <xsl:variable name="legendBoxWidth">23</xsl:variable>
  <xsl:variable name="legendBoxHeight">13</xsl:variable>
  <xsl:variable name="zoomImageWidth">16</xsl:variable>
  <xsl:variable name="zoomImageHeight">16</xsl:variable>
  <!-- placeholder for a possible future parameters -->
  <xsl:variable name="xzoomLevel">0</xsl:variable>
  <xsl:variable name="xzoomIncrement">0.25</xsl:variable>
  <!-- development debug flag -->
  <xsl:variable name="debug" select="false()"/>

  <xsl:variable name="default_colors">#fdc958,#c59ac1,#ffaf02,#b9dd71,#a780a2,#80994e,#caa046,#ccff99,#ffdb8c,#c4cc8d,#ffff00,#ff0000,#fdff58,#00ff00</xsl:variable>

  <xsl:variable name="newline">
    <xsl:text>
    </xsl:text>
  </xsl:variable>

  <xsl:template name="i2:svgChart">
    <xsl:param name="renderTypes">bbbbbbbbbbbbbb</xsl:param>
    <xsl:param name="viewport_width"/>
    <xsl:param name="chart_title"/>
    <xsl:param name="chart_title_height"><xsl:value-of select="$defaultHeight"/></xsl:param>
    <xsl:param name="xaxis_title"/>
    <xsl:param name="xaxis_title2"/>
    <xsl:param name="xaxis_labels" select="/nullData"/>
    <xsl:param name="xlabels_width">133</xsl:param>
    <xsl:param name="xlabels_height"><xsl:value-of select="$defaultHeight"/></xsl:param>
    <xsl:param name="xaxis_labels2" select="/nullData"/>
    <xsl:param name="xlabels2_height">0</xsl:param>
    <xsl:param name="xlabels2_span">false</xsl:param>
    <xsl:param name="yaxis_title"/>
    <xsl:param name="yaxis_numticks">10</xsl:param>
    <xsl:param name="ylabels_width">150</xsl:param>
    <xsl:param name="ylabels_height"><xsl:value-of select="$defaultHeight"/></xsl:param>
    <xsl:param name="data1" select="/nullData"/>
    <xsl:param name="data2" select="/nullData"/>
    <xsl:param name="data3" select="/nullData"/>
    <xsl:param name="data4" select="/nullData"/>
    <xsl:param name="data5" select="/nullData"/>
    <xsl:param name="data6" select="/nullData"/>
    <xsl:param name="data7" select="/nullData"/>
    <xsl:param name="data8" select="/nullData"/>
    <xsl:param name="data9" select="/nullData"/>
    <xsl:param name="data10" select="/nullData"/>
    <xsl:param name="data11" select="/nullData"/>
    <xsl:param name="data12" select="/nullData"/>
    <xsl:param name="data13" select="/nullData"/>
    <xsl:param name="data14" select="/nullData"/>
    <xsl:param name="key_names"/>
    <xsl:param name="bar_width">10</xsl:param>
    <xsl:param name="colorscheme">abcdefghijklmn</xsl:param>
    <xsl:param name="insets">003,016,029,042,055,068,081,094,107,120,133,146,159,172</xsl:param>
    <xsl:param name="stacked">0</xsl:param>
    <xsl:param name="override_bar_widths">def,def,def,def,def,def,def,def,def,def,def,def,def,def</xsl:param>
    <xsl:param name="override_opacities">def,def,def,def,def,def,def,def,def,def,def,def,def,def</xsl:param>
    <xsl:param name="override_colors">default,default,default,default,default,default,default,default,default,default,default,default,default,default</xsl:param>
    <xsl:param name="UserAgent">MSIE</xsl:param>
    <xsl:param name="actions">nnnnnnnnnnnnnn</xsl:param>
    <xsl:param name="enableShowValue">true</xsl:param>
    <xsl:param name="enableChartTitle">true</xsl:param>
    <xsl:param name="enableScrollbar">true</xsl:param>
    <xsl:param name="enableLegend">true</xsl:param>
    <xsl:param name="reverseZOrder">false</xsl:param>
    <xsl:param name="integral_yaxis_labels">false</xsl:param>
    <xsl:param name="numticksIsMinMax">false</xsl:param>
    <xsl:param name="clickCallback"/>
    <xsl:param name="dragCallback"/>
    <xsl:param name="contextData"/>
    <xsl:param name="enableDataAttrs">false</xsl:param>
    <xsl:param name="enableSvgMenu">false</xsl:param>
    <xsl:param name="locale">en</xsl:param>
    <xsl:param name="enableZoom">false</xsl:param>
    <xsl:param name="yzoomLevel">0</xsl:param>
    <xsl:param name="yzoomIncrement">1.0</xsl:param>
    <xsl:param name="fontfamily"/>
    <xsl:param name="titlefontsize"></xsl:param>
    <xsl:param name="labelfontsize"></xsl:param>
    <xsl:param name="allowNegatives">false</xsl:param>

    <!-- merge the default and override colors -->
    <xsl:variable name="colors">
      <xsl:call-template name="merge_colors">
        <xsl:with-param name="defaults" select="$default_colors"/>
        <xsl:with-param name="overrides" select="$override_colors"/>
        <xsl:with-param name="index" select="0"/>
        <xsl:with-param name="max" select="14"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- set up the font properties -->
    <xsl:variable name="fontFamilyVal">
      <xsl:choose>
        <xsl:when test="not($fontfamily)">
          <xsl:choose>
            <xsl:when test="starts-with($locale, 'en')">verdana,arial,helvetica,sans-serif</xsl:when>
            <xsl:when test="starts-with($locale, 'fr')">verdana,arial,helvetica,sans-serif</xsl:when>
            <xsl:when test="starts-with($locale, 'de')">verdana,arial,helvetica,sans-serif</xsl:when>
            <xsl:when test="starts-with($locale, 'ja')">Arial Unicode MS</xsl:when>
            <xsl:when test="starts-with($locale, 'ko')">Arial Unicode MS</xsl:when>
            <xsl:when test="starts-with($locale, 'zh')">Arial Unicode MS</xsl:when>
            <xsl:otherwise>verdana,sans-serif</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$fontfamily"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="smallFontSizeVal">
      <xsl:choose>
        <xsl:when test="starts-with($locale, 'en')">10</xsl:when>
        <xsl:when test="starts-with($locale, 'fr')">10</xsl:when>
        <xsl:when test="starts-with($locale, 'de')">10</xsl:when>
        <xsl:when test="starts-with($locale, 'ja')">12</xsl:when>
        <xsl:when test="starts-with($locale, 'ko')">12</xsl:when>
        <xsl:when test="starts-with($locale, 'zh')">12</xsl:when>
        <xsl:otherwise>11</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="ySmallBaselineOffset" select="round($smallFontSizeVal * 0.8)"/>

    <xsl:variable name="titleFontSizeVal">
      <xsl:choose>
        <xsl:when test="not($titlefontsize)">
          <xsl:choose>
            <xsl:when test="starts-with($locale, 'en')">11</xsl:when>
            <xsl:when test="starts-with($locale, 'fr')">11</xsl:when>
            <xsl:when test="starts-with($locale, 'de')">11</xsl:when>
            <xsl:when test="starts-with($locale, 'ja')">15</xsl:when>
            <xsl:when test="starts-with($locale, 'ko')">15</xsl:when>
            <xsl:when test="starts-with($locale, 'zh')">15</xsl:when>
            <xsl:otherwise>11</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$titlefontsize"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="yTitleBaselineOffset" select="round($titleFontSizeVal * 0.8)"/>

    <xsl:variable name="labelFontSizeVal">
      <xsl:choose>
        <xsl:when test="not($labelfontsize)">
          <xsl:choose>
            <xsl:when test="starts-with($locale, 'en')">11</xsl:when>
            <xsl:when test="starts-with($locale, 'fr')">11</xsl:when>
            <xsl:when test="starts-with($locale, 'de')">11</xsl:when>
            <xsl:when test="starts-with($locale, 'ja')">12</xsl:when>
            <xsl:when test="starts-with($locale, 'ko')">12</xsl:when>
            <xsl:when test="starts-with($locale, 'zh')">12</xsl:when>
            <xsl:otherwise>11</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$labelfontsize"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="yLabelBaselineOffset" select="round($labelFontSizeVal * 0.8)"/>

    <!-- capture the string parameter as a boolean -->
    <xsl:variable name="zOrderReversed" select="$reverseZOrder = 'true'"/>

    <!-- capture the strings used in the zoom icon tooltips -->
    <xsl:variable name="zoomInStr">
      <xsl:call-template name="i2uitranslate">
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="key">zoom in</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="zoomOutStr">
      <xsl:call-template name="i2uitranslate">
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="key">zoom out</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>

    <!-- we have to use the extension function to format numbers so register the locale -->
    <xsl:choose>
      <xsl:when test="function-available('ExtXt:setLocale')">
        <xsl:value-of select="ExtXt:setLocale(string($locale))"/>
      </xsl:when>
      <xsl:when test="function-available('ExtXalan:setLocale')">
        <xsl:value-of select="ExtXalan:setLocale(string($locale))"/>
      </xsl:when>
    </xsl:choose>

    <!-- create result tree fragments containing mapped datasets
         - note that the rtf's lose the attributes associated with the original nodesets -->
    <xsl:variable name="data1_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data1"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data2_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data2"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data3_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data3"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data4_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data4"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data5_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data5"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data6_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data6"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data7_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data7"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data8_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data8"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data9_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data9"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data10_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data10"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data11_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data11"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data12_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data12"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data13_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data13"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="data14_rtf">
      <xsl:call-template name="normalizeData">
        <xsl:with-param name="data" select="$data14"/>
        <xsl:with-param name="locale" select="$locale"/>
      </xsl:call-template>
    </xsl:variable>

<!--
<xsl:comment>
<xsl:text>
data1 = </xsl:text>
<xsl:call-template name="nodesetToList">
  <xsl:with-param name="nodeset" select="$data1"/>
</xsl:call-template>
<xsl:text>
</xsl:text>
<xsl:text>
data1_rtf = </xsl:text>
<xsl:call-template name="nodesetToList">
  <xsl:with-param name="nodeset" select="xalan:nodeset($data1_rtf)/*"/>
</xsl:call-template>
<xsl:text>
</xsl:text>
</xsl:comment><xsl:value-of select="$newline"/>
-->

    <!-- determine max data value -->
    <xsl:variable name="minMax">
      <xsl:choose>
        <xsl:when test="$numticksIsMinMax = 'true'"><xsl:value-of select="$yaxis_numticks"/></xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="origDataMax">
      <xsl:choose>
        <xsl:when test="function-available('xalan:nodeset')">
          <xsl:call-template name="nthmaxstackedvalue">
            <xsl:with-param name="stackedval" select="$stacked"/>
            <xsl:with-param name="minmax" select="$minMax"/>
            <xsl:with-param name="rendertypes" select="$renderTypes"/>
            <xsl:with-param name="data1" select="xalan:nodeset($data1_rtf)/*"/>
            <xsl:with-param name="data2" select="xalan:nodeset($data2_rtf)/*"/>
            <xsl:with-param name="data3" select="xalan:nodeset($data3_rtf)/*"/>
            <xsl:with-param name="data4" select="xalan:nodeset($data4_rtf)/*"/>
            <xsl:with-param name="data5" select="xalan:nodeset($data5_rtf)/*"/>
            <xsl:with-param name="data6" select="xalan:nodeset($data6_rtf)/*"/>
            <xsl:with-param name="data7" select="xalan:nodeset($data7_rtf)/*"/>
            <xsl:with-param name="data8" select="xalan:nodeset($data8_rtf)/*"/>
            <xsl:with-param name="data9" select="xalan:nodeset($data9_rtf)/*"/>
            <xsl:with-param name="data10" select="xalan:nodeset($data10_rtf)/*"/>
            <xsl:with-param name="data11" select="xalan:nodeset($data11_rtf)/*"/>
            <xsl:with-param name="data12" select="xalan:nodeset($data12_rtf)/*"/>
            <xsl:with-param name="data13" select="xalan:nodeset($data13_rtf)/*"/>
            <xsl:with-param name="data14" select="xalan:nodeset($data14_rtf)/*"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="function-available('msxml:node-set')">
          <xsl:call-template name="nthmaxstackedvalue">
            <xsl:with-param name="stackedval" select="$stacked"/>
            <xsl:with-param name="minmax" select="$minMax"/>
            <xsl:with-param name="rendertypes" select="$renderTypes"/>
            <xsl:with-param name="data1" select="msxml:node-set($data1_rtf)/*"/>
            <xsl:with-param name="data2" select="msxml:node-set($data2_rtf)/*"/>
            <xsl:with-param name="data3" select="msxml:node-set($data3_rtf)/*"/>
            <xsl:with-param name="data4" select="msxml:node-set($data4_rtf)/*"/>
            <xsl:with-param name="data5" select="msxml:node-set($data5_rtf)/*"/>
            <xsl:with-param name="data6" select="msxml:node-set($data6_rtf)/*"/>
            <xsl:with-param name="data7" select="msxml:node-set($data7_rtf)/*"/>
            <xsl:with-param name="data8" select="msxml:node-set($data8_rtf)/*"/>
            <xsl:with-param name="data9" select="msxml:node-set($data9_rtf)/*"/>
            <xsl:with-param name="data10" select="msxml:node-set($data10_rtf)/*"/>
            <xsl:with-param name="data11" select="msxml:node-set($data11_rtf)/*"/>
            <xsl:with-param name="data12" select="msxml:node-set($data12_rtf)/*"/>
            <xsl:with-param name="data13" select="msxml:node-set($data13_rtf)/*"/>
            <xsl:with-param name="data14" select="msxml:node-set($data14_rtf)/*"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="function-available('xt:node-set')">
          <xsl:call-template name="nthmaxstackedvalue">
            <xsl:with-param name="stackedval" select="$stacked"/>
            <xsl:with-param name="rendertypes" select="$renderTypes"/>
            <xsl:with-param name="minmax" select="$minMax"/>
            <xsl:with-param name="data1" select="xt:node-set($data1_rtf)/*"/>
            <xsl:with-param name="data2" select="xt:node-set($data2_rtf)/*"/>
            <xsl:with-param name="data3" select="xt:node-set($data3_rtf)/*"/>
            <xsl:with-param name="data4" select="xt:node-set($data4_rtf)/*"/>
            <xsl:with-param name="data5" select="xt:node-set($data5_rtf)/*"/>
            <xsl:with-param name="data6" select="xt:node-set($data6_rtf)/*"/>
            <xsl:with-param name="data7" select="xt:node-set($data7_rtf)/*"/>
            <xsl:with-param name="data8" select="xt:node-set($data8_rtf)/*"/>
            <xsl:with-param name="data9" select="xt:node-set($data9_rtf)/*"/>
            <xsl:with-param name="data10" select="xt:node-set($data10_rtf)/*"/>
            <xsl:with-param name="data11" select="xt:node-set($data11_rtf)/*"/>
            <xsl:with-param name="data12" select="xt:node-set($data12_rtf)/*"/>
            <xsl:with-param name="data13" select="xt:node-set($data13_rtf)/*"/>
            <xsl:with-param name="data14" select="xt:node-set($data14_rtf)/*"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="function-available('saxon:node-set')">
          <xsl:call-template name="nthmaxstackedvalue">
            <xsl:with-param name="stackedval" select="$stacked"/>
            <xsl:with-param name="rendertypes" select="$renderTypes"/>
            <xsl:with-param name="minmax" select="$minMax"/>
            <xsl:with-param name="data1" select="saxon:node-set($data1_rtf)/*"/>
            <xsl:with-param name="data2" select="saxon:node-set($data2_rtf)/*"/>
            <xsl:with-param name="data3" select="saxon:node-set($data3_rtf)/*"/>
            <xsl:with-param name="data4" select="saxon:node-set($data4_rtf)/*"/>
            <xsl:with-param name="data5" select="saxon:node-set($data5_rtf)/*"/>
            <xsl:with-param name="data6" select="saxon:node-set($data6_rtf)/*"/>
            <xsl:with-param name="data7" select="saxon:node-set($data7_rtf)/*"/>
            <xsl:with-param name="data8" select="saxon:node-set($data8_rtf)/*"/>
            <xsl:with-param name="data9" select="saxon:node-set($data9_rtf)/*"/>
            <xsl:with-param name="data10" select="saxon:node-set($data10_rtf)/*"/>
            <xsl:with-param name="data11" select="saxon:node-set($data11_rtf)/*"/>
            <xsl:with-param name="data12" select="saxon:node-set($data12_rtf)/*"/>
            <xsl:with-param name="data13" select="saxon:node-set($data13_rtf)/*"/>
            <xsl:with-param name="data14" select="saxon:node-set($data14_rtf)/*"/>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <!-- Rauli added begin - negatives -->
    <xsl:variable name="dataMin">
      <xsl:choose>
        <xsl:when test="not($allowNegatives='true')">0</xsl:when>
        <xsl:when test="function-available('xalan:nodeset')">
          <xsl:call-template name="nthminstackedvalue">
            <xsl:with-param name="stackedval" select="$stacked"/>
            <xsl:with-param name="minmax" select="$minMax"/>
            <xsl:with-param name="rendertypes" select="$renderTypes"/>
            <xsl:with-param name="data1" select="xalan:nodeset($data1_rtf)/*"/>
            <xsl:with-param name="data2" select="xalan:nodeset($data2_rtf)/*"/>
            <xsl:with-param name="data3" select="xalan:nodeset($data3_rtf)/*"/>
            <xsl:with-param name="data4" select="xalan:nodeset($data4_rtf)/*"/>
            <xsl:with-param name="data5" select="xalan:nodeset($data5_rtf)/*"/>
            <xsl:with-param name="data6" select="xalan:nodeset($data6_rtf)/*"/>
            <xsl:with-param name="data7" select="xalan:nodeset($data7_rtf)/*"/>
            <xsl:with-param name="data8" select="xalan:nodeset($data8_rtf)/*"/>
            <xsl:with-param name="data9" select="xalan:nodeset($data9_rtf)/*"/>
            <xsl:with-param name="data10" select="xalan:nodeset($data10_rtf)/*"/>
            <xsl:with-param name="data11" select="xalan:nodeset($data11_rtf)/*"/>
            <xsl:with-param name="data12" select="xalan:nodeset($data12_rtf)/*"/>
            <xsl:with-param name="data13" select="xalan:nodeset($data13_rtf)/*"/>
            <xsl:with-param name="data14" select="xalan:nodeset($data14_rtf)/*"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="function-available('msxml:node-set')">
          <xsl:call-template name="nthminstackedvalue">
            <xsl:with-param name="stackedval" select="$stacked"/>
            <xsl:with-param name="minmax" select="$minMax"/>
            <xsl:with-param name="rendertypes" select="$renderTypes"/>
            <xsl:with-param name="data1" select="msxml:node-set($data1_rtf)/*"/>
            <xsl:with-param name="data2" select="msxml:node-set($data2_rtf)/*"/>
            <xsl:with-param name="data3" select="msxml:node-set($data3_rtf)/*"/>
            <xsl:with-param name="data4" select="msxml:node-set($data4_rtf)/*"/>
            <xsl:with-param name="data5" select="msxml:node-set($data5_rtf)/*"/>
            <xsl:with-param name="data6" select="msxml:node-set($data6_rtf)/*"/>
            <xsl:with-param name="data7" select="msxml:node-set($data7_rtf)/*"/>
            <xsl:with-param name="data8" select="msxml:node-set($data8_rtf)/*"/>
            <xsl:with-param name="data9" select="msxml:node-set($data9_rtf)/*"/>
            <xsl:with-param name="data10" select="msxml:node-set($data10_rtf)/*"/>
            <xsl:with-param name="data11" select="msxml:node-set($data11_rtf)/*"/>
            <xsl:with-param name="data12" select="msxml:node-set($data12_rtf)/*"/>
            <xsl:with-param name="data13" select="msxml:node-set($data13_rtf)/*"/>
            <xsl:with-param name="data14" select="msxml:node-set($data14_rtf)/*"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="function-available('xt:node-set')">
          <xsl:call-template name="nthminstackedvalue">
            <xsl:with-param name="stackedval" select="$stacked"/>
            <xsl:with-param name="rendertypes" select="$renderTypes"/>
            <xsl:with-param name="minmax" select="$minMax"/>
            <xsl:with-param name="data1" select="xt:node-set($data1_rtf)/*"/>
            <xsl:with-param name="data2" select="xt:node-set($data2_rtf)/*"/>
            <xsl:with-param name="data3" select="xt:node-set($data3_rtf)/*"/>
            <xsl:with-param name="data4" select="xt:node-set($data4_rtf)/*"/>
            <xsl:with-param name="data5" select="xt:node-set($data5_rtf)/*"/>
            <xsl:with-param name="data6" select="xt:node-set($data6_rtf)/*"/>
            <xsl:with-param name="data7" select="xt:node-set($data7_rtf)/*"/>
            <xsl:with-param name="data8" select="xt:node-set($data8_rtf)/*"/>
            <xsl:with-param name="data9" select="xt:node-set($data9_rtf)/*"/>
            <xsl:with-param name="data10" select="xt:node-set($data10_rtf)/*"/>
            <xsl:with-param name="data11" select="xt:node-set($data11_rtf)/*"/>
            <xsl:with-param name="data12" select="xt:node-set($data12_rtf)/*"/>
            <xsl:with-param name="data13" select="xt:node-set($data13_rtf)/*"/>
            <xsl:with-param name="data14" select="xt:node-set($data14_rtf)/*"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="function-available('saxon:node-set')">
          <xsl:call-template name="nthminstackedvalue">
            <xsl:with-param name="stackedval" select="$stacked"/>
            <xsl:with-param name="rendertypes" select="$renderTypes"/>
            <xsl:with-param name="minmax" select="$minMax"/>
            <xsl:with-param name="data1" select="saxon:node-set($data1_rtf)/*"/>
            <xsl:with-param name="data2" select="saxon:node-set($data2_rtf)/*"/>
            <xsl:with-param name="data3" select="saxon:node-set($data3_rtf)/*"/>
            <xsl:with-param name="data4" select="saxon:node-set($data4_rtf)/*"/>
            <xsl:with-param name="data5" select="saxon:node-set($data5_rtf)/*"/>
            <xsl:with-param name="data6" select="saxon:node-set($data6_rtf)/*"/>
            <xsl:with-param name="data7" select="saxon:node-set($data7_rtf)/*"/>
            <xsl:with-param name="data8" select="saxon:node-set($data8_rtf)/*"/>
            <xsl:with-param name="data9" select="saxon:node-set($data9_rtf)/*"/>
            <xsl:with-param name="data10" select="saxon:node-set($data10_rtf)/*"/>
            <xsl:with-param name="data11" select="saxon:node-set($data11_rtf)/*"/>
            <xsl:with-param name="data12" select="saxon:node-set($data12_rtf)/*"/>
            <xsl:with-param name="data13" select="saxon:node-set($data13_rtf)/*"/>
            <xsl:with-param name="data14" select="saxon:node-set($data14_rtf)/*"/>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="dataRange" select="$origDataMax - $dataMin"/>
    <!-- Rauli added end - negatives -->

    <!-- richardh xzoom -->
    <xsl:variable name="xScaleFactor" select="1 + $xzoomLevel * $xzoomIncrement"/>

    <!-- richardh yzoom -->
    <xsl:variable name="yScaleFactor" select="1 + $yzoomLevel * $yzoomIncrement"/>
    <xsl:variable name="yaxis_numlabels" select="$yaxis_numticks * $yScaleFactor"/>
    <xsl:variable name="step_size" select="$dataRange div $yaxis_numlabels"/>
    <!-- Rauli added begin - negatives -->
    <xsl:variable name="adjustToZeroMax" select="$origDataMax div $step_size"/>
    <xsl:variable name="adjustToZeroMaxCeiling" select="ceiling($adjustToZeroMax)"/>
    <xsl:variable name="adjustToZeroMin" select="-$dataMin div $step_size"/>
    <xsl:variable name="adjustToZeroMinCeiling" select="ceiling($adjustToZeroMin)"/>
    <xsl:variable name="dataMax">
      <xsl:choose>
        <xsl:when test="$dataMin = 0 or $origDataMax >= -$dataMin or $adjustToZeroMax = $adjustToZeroMaxCeiling">
          <xsl:value-of select="$origDataMax"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="-$dataMin div ( $yaxis_numlabels div $adjustToZeroMaxCeiling - 1 )"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="offset_y">
      <xsl:choose>
        <xsl:when test="$dataMin = 0 or -$origDataMax >= $dataMin or $adjustToZeroMax = $adjustToZeroMaxCeiling">
          <xsl:value-of select="$dataMin"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="-$dataMax div ( $yaxis_numlabels div $adjustToZeroMinCeiling - 1 )"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="step_size" select="($dataMax - $offset_y) div $yaxis_numlabels"/>
    <xsl:variable name="ratio" select="($ylabels_height * $yaxis_numlabels) div ($dataMax - $offset_y)"/>
    <!-- Rauli added end - negatives -->

    <!-- determine how many decimal digits to format in the y labels -->
    <xsl:variable name="numYDecimalDigits">
      <xsl:choose>
        <xsl:when test="$integral_yaxis_labels = 'true' or $step_size = floor($step_size)">0</xsl:when>
        <xsl:when test="$step_size &lt; 0.00001">6</xsl:when>
        <xsl:when test="$step_size &lt; 0.0001">5</xsl:when>
        <xsl:when test="$step_size &lt; 0.001">4</xsl:when>
        <xsl:when test="$step_size &lt; 0.01">3</xsl:when>
        <xsl:when test="$step_size &lt; 0.1">2</xsl:when>
        <xsl:when test="$step_size &lt; 1">1</xsl:when>
        <xsl:otherwise>2</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- section geometries -->
    <!-- chart title -->
    <xsl:variable name="title_width" select="$viewport_width"/>
    <xsl:variable name="title_height">
      <xsl:choose>
        <xsl:when test="$enableChartTitle = 'true'"><xsl:value-of select="$chart_title_height"/></xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="title_x" select="0"/>
    <xsl:variable name="title_y" select="0"/>
    <xsl:variable name="titleTextOffsetY" select="$yTitleBaselineOffset + floor(($title_height - $titleFontSizeVal) div 2)"/>

    <!-- y axis title and labels -->
    <xsl:variable name="yaxis_width" select="$ylabels_width"/>
    <xsl:variable name="yaxis_height" select="$ylabels_height * ($yaxis_numticks + 2)"/>
    <xsl:variable name="clipped_yaxis_height" select="$ylabels_height * ($yaxis_numticks + 1)"/>
    <xsl:variable name="yaxis_x" select="0"/>
    <xsl:variable name="yaxis_y" select="$title_height"/>
    <xsl:variable name="ylabelsTextOffsetY" select="$yLabelBaselineOffset + floor(($ylabels_height - $labelFontSizeVal) div 2)"/>

    <!-- y axis scrollbar -->
    <xsl:variable name="vscrollbar_width">
      <xsl:choose>
        <xsl:when test="$enableScrollbar = 'true'">15</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="vscrollbar_height" select="$yaxis_height"/>
    <xsl:variable name="vscrollbar_x" select="$viewport_width - $vscrollbar_width"/>
    <xsl:variable name="vscrollbar_y" select="$yaxis_y"/>
    <xsl:variable name="vbutton_height" select="$vscrollbar_width"/>
    <xsl:variable name="vbutton_t_y" select="$vscrollbar_y"/>
    <xsl:variable name="vslider_y" select="$vscrollbar_y + $vbutton_height"/>
    <xsl:variable name="vbutton_b_y" select="$vscrollbar_y + $vscrollbar_height - $vbutton_height"/>
    <xsl:variable name="vtrough_height" select="$vscrollbar_height - 2 * $vbutton_height"/>
    <xsl:variable name="vslider_ratio" select="$vtrough_height div ($yaxis_height - ($ylabels_height * 2))"/>
    <xsl:variable name="vslider_height">
      <xsl:choose>
        <xsl:when test="$vtrough_height div $yScaleFactor &gt; 10"><xsl:value-of select="$vtrough_height div $yScaleFactor"/></xsl:when>
        <xsl:otherwise>10</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- x axis titles and labels -->
    <xsl:variable name="xlabel_count" select="count($xaxis_labels)"/>
    <xsl:variable name="xaxis_width" select="$xlabels_width * $xlabel_count + $yaxis_width"/>
    <xsl:variable name="clipped_xaxis_width" select="$viewport_width - $yaxis_width - $vscrollbar_width"/>
    <xsl:variable name="xaxis_height" select="$xlabels_height + $xlabels2_height"/>
    <xsl:variable name="xaxis_x" select="0"/>
    <xsl:variable name="xaxis_y" select="$title_height + $yaxis_height"/>
    <xsl:variable name="xlabelsTextOffsetY" select="$yLabelBaselineOffset + floor(($xlabels_height - $labelFontSizeVal) div 2)"/>

    <!-- chart body -->
    <xsl:variable name="chart_width" select="$xaxis_width"/>
    <xsl:variable name="clipped_chart_width" select="$clipped_xaxis_width"/>
    <xsl:variable name="chart_height" select="$yaxis_height"/>
    <xsl:variable name="chart_x" select="$ylabels_width"/>
    <xsl:variable name="chart_y" select="$title_height"/>

    <!-- x axis scrollbar -->
    <xsl:variable name="hscrollbar_width" select="$clipped_chart_width"/>
    <xsl:variable name="hscrollbar_height">
      <xsl:choose>
        <xsl:when test="$enableScrollbar = 'true'">15</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="hscrollbar_x" select="$ylabels_width"/>
    <xsl:variable name="hscrollbar_y" select="$title_height + $yaxis_height + $xaxis_height"/>
    <xsl:variable name="hbutton_width" select="$hscrollbar_height"/>
    <xsl:variable name="hbutton_l_x" select="$hscrollbar_x"/>
    <xsl:variable name="hslider_x" select="$hscrollbar_x + $hbutton_width"/>
    <xsl:variable name="hbutton_r_x" select="$hscrollbar_x + $hscrollbar_width - $hbutton_width"/>
    <xsl:variable name="htrough_width" select="$hscrollbar_width - 2 * $hbutton_width"/>
    <xsl:variable name="hslider_ratio">
      <xsl:choose>
        <xsl:when test="$htrough_width div $chart_width &gt; 1">1</xsl:when>
        <xsl:otherwise><xsl:value-of select="$htrough_width div $chart_width"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="hslider_width">
      <xsl:choose>
        <xsl:when test="$htrough_width * $hslider_ratio &gt; 10"><xsl:value-of select="$htrough_width * $hslider_ratio"/></xsl:when>
        <xsl:otherwise>10</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- legend -->
    <xsl:variable name="legend_width" select="$viewport_width"/>
    <xsl:variable name="legend_height">
      <xsl:choose>
        <xsl:when test="$enableLegend = 'true'"><xsl:value-of select="$defaultHeight"/></xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="legend_x" select="0"/>
    <xsl:variable name="legend_y" select="$title_height + $yaxis_height + $xaxis_height + $hscrollbar_height"/>

    <!-- entire chart -->
    <xsl:variable name="overall_width" select="$viewport_width"/>
    <xsl:variable name="overall_height" select="$title_height + $yaxis_height + $xaxis_height + $hscrollbar_height + $legend_height"/>

<!-- debug -->
<xsl:if test="$debug">
<xsl:comment>
colors == <xsl:value-of select="$colors"/>

hscrollbar_width == <xsl:value-of select="$hscrollbar_width"/>
hscrollbar_height == <xsl:value-of select="$hscrollbar_height"/>
hscrollbar_x == <xsl:value-of select="$hscrollbar_x"/>
hscrollbar_y == <xsl:value-of select="$hscrollbar_y"/>
hbutton_width == <xsl:value-of select="$hbutton_width"/>
hbutton_l_x == <xsl:value-of select="$hbutton_l_x"/>
hslider_x == <xsl:value-of select="$hslider_x"/>
hbutton_r_x == <xsl:value-of select="$hbutton_r_x"/>
htrough_width == <xsl:value-of select="$htrough_width"/>
hslider_ratio == <xsl:value-of select="$hslider_ratio"/>
hslider_width == <xsl:value-of select="$hslider_width"/>

vscrollbar_width == <xsl:value-of select="$vscrollbar_width"/>
vscrollbar_height == <xsl:value-of select="$vscrollbar_height"/>
vscrollbar_x == <xsl:value-of select="$vscrollbar_x"/>
vscrollbar_y == <xsl:value-of select="$vscrollbar_y"/>
vbutton_height == <xsl:value-of select="$vbutton_height"/>
vbutton_t_y == <xsl:value-of select="$vbutton_t_y"/>
vslider_y == <xsl:value-of select="$vslider_y"/>
vbutton_b_y == <xsl:value-of select="$vbutton_b_y"/>
vtrough_height == <xsl:value-of select="$vtrough_height"/>
vslider_ratio == <xsl:value-of select="$vslider_ratio"/>
vslider_height == <xsl:value-of select="$vslider_height"/>

dataMax == <xsl:value-of select="$dataMax"/>
yaxis_numticks == <xsl:value-of select="$yaxis_numticks"/>
yaxis_numlabels == <xsl:value-of select="$yaxis_numlabels"/>
xScaleFactor == <xsl:value-of select="$xScaleFactor"/>
yScaleFactor == <xsl:value-of select="$yScaleFactor"/>
step_size == <xsl:value-of select="$step_size"/>
ratio == <xsl:value-of select="$ratio"/>
stacked == <xsl:value-of select="$stacked"/>
<xsl:value-of select="$newline"/>
</xsl:comment><xsl:value-of select="$newline"/>
</xsl:if>

    <!-- start the result document -->
    <svg id="svgImage" onload="init(evt)"
         onmousedown="doOnMouseDown(evt)" onmouseup="doOnMouseUp(evt)" onmouseout="doOnMouseOut(evt)"
         zoomAndPan="disable">
      <xsl:attribute name="width"><xsl:value-of select="$overall_width"/></xsl:attribute>
      <xsl:attribute name="height"><xsl:value-of select="$overall_height"/></xsl:attribute>

      <defs>
        <style type="text/css">
          <!-- render colors -->
          <xsl:call-template name="i2:genColorStyles">
            <xsl:with-param name="index">0</xsl:with-param>
            <xsl:with-param name="identifiers">abcdefghijklmn</xsl:with-param>
            <xsl:with-param name="colors" select="$colors"/>
          </xsl:call-template>

          .TitleBox      { stroke:<xsl:value-of select="$axisBorderColor"/>;
                           stroke-width:1;
                           stroke-opacity:1;
                           fill:<xsl:value-of select="$titleColorBg"/>;
                           fill-opacity:1;
                         }
          .TitleText     { font-size:<xsl:value-of select="$titleFontSizeVal"/>px;
                           font-family:<xsl:value-of select="$fontFamilyVal"/>;
                           font-weight:bold;
                           fill:<xsl:value-of select="$svgtitlefontcolor"/>;
                           fill-opacity:1;
                         }
          .AxisTitleBox  { stroke:<xsl:value-of select="$axisBorderColor"/>;
                           stroke-width:1;
                           stroke-opacity:1;
                           fill:<xsl:value-of select="$axisTitleColorBg"/>;
                           fill-opacity:1;
                         }
          .AxisTitleText { font-size:<xsl:value-of select="$titleFontSizeVal"/>px;
                           font-family:<xsl:value-of select="$fontFamilyVal"/>;
                           font-weight:bold;
                           text-anchor: end;
                           fill:<xsl:value-of select="$svgtitlefontcolor"/>;
                           fill-opacity:1;
                         }
          .AxisLabelBox  { stroke:<xsl:value-of select="$axisBorderColor"/>;
                           stroke-width:1;
                           stroke-opacity:1;
                           fill:<xsl:value-of select="$labelColorBg"/>;
                           fill-opacity:1;
                         }
          .YAxisLabelText { text-anchor:end;
                           font-size:<xsl:value-of select="$labelFontSizeVal"/>px;
                           font-family:<xsl:value-of select="$fontFamilyVal"/>;
                           fill:<xsl:value-of select="$svglabelfontcolor"/>;
                           fill-opacity:1;
                         }
          .XAxisLabelText {
                           font-size:<xsl:value-of select="$labelFontSizeVal"/>px;
                           font-family:<xsl:value-of select="$fontFamilyVal"/>;
                           fill:<xsl:value-of select="$svglabelfontcolor"/>;
                           fill-opacity:1;
                           text-anchor:middle;
                         }
          .ChartBox      { stroke:<xsl:value-of select="$chartBorderColor"/>;
                           stroke-width:1;
                           stroke-opacity:1;
                           stroke-dasharray:1,3;
                           fill:<xsl:value-of select="$chartColorBg"/>;
                           fill-opacity:1;
                         }
          .ChartBoxAlt   { stroke:<xsl:value-of select="$chartBorderColor"/>;
                           stroke-width:1;
                           stroke-opacity:1;
                           stroke-dasharray:1,3;
                           fill:<xsl:value-of select="$chartColorBgAlt"/>;
                           fill-opacity:1;
                         }
          .DragValueText { font-size:<xsl:value-of select="$titleFontSizeVal"/>px;
                           font-family:<xsl:value-of select="$fontFamilyVal"/>;
                           fill:<xsl:value-of select="$svglabelfontcolor"/>;
                           fill-opacity:1;
                           visibility:hidden;
                         }
          .ObjectValueText{ font-size:<xsl:value-of select="$titleFontSizeVal"/>px;
                           font-family:<xsl:value-of select="$fontFamilyVal"/>;
                           fill:<xsl:value-of select="$svglabelfontcolor"/>;
                           fill-opacity:1;
                           visibility:hidden;
                         }
          .TooltipBox    { stroke:#000000;
                           stroke-width:1;
                           stroke-opacity:1;
                           fill:#ffffe1;
                           fill-opacity:1;
                           visibility:hidden;
                         }
          .TooltipText  { font-size:<xsl:value-of select="$smallFontSizeVal"/>px;
                           font-family:<xsl:value-of select="$fontFamilyVal"/>;
                           fill:<xsl:value-of select="$svgtitlefontcolor"/>;
                           fill-opacity:1;
                           text-anchor:middle;
                           visibility:hidden;
                         }
          .ScrollbarBGBox{ stroke:<xsl:value-of select="$axisBorderColor"/>;
                           stroke-width:1;
                           stroke-opacity:1;
                           fill:<xsl:value-of select="$labelColorBg"/>;
                           fill-opacity:1;
                         }
          .ScrollbarFGBox{ stroke:<xsl:value-of select="$axisBorderColor"/>;
                           stroke-width:1;
                           stroke-opacity:1;
                           fill:<xsl:value-of select="$axisTitleColorBg"/>;
                           fill-opacity:1;
                         }
          .ScrollbarArrow{ stroke:#000000;
                           stroke-width:1;
                           stroke-opacity:1;
                           fill:#000000;
                           fill-opacity:1;
                         }
          .LegendBGBox   { stroke:<xsl:value-of select="$chartBorderColor"/>;
                           stroke-width:1;
                           stroke-opacity:1;
                           fill:<xsl:value-of select="$chartColorBg"/>;
                           fill-opacity:1;
                         }
          .LegendBox  { stroke:<xsl:value-of select="$barBorderColor"/>;
                        stroke-width:1;
                        stroke-opacity:1;
                        fill:<xsl:value-of select="$legendColorBg"/>;
                        fill-opacity:1;
                      }
          .LegendText { font-size:<xsl:value-of select="$labelFontSizeVal"/>px;
                        font-family:<xsl:value-of select="$fontFamilyVal"/>;
                        fill:<xsl:value-of select="$svglabelfontcolor"/>;
                        fill-opacity:1;
                      }
          .Canvas     { stroke:<xsl:value-of select="$axisBorderColor"/>;
                        stroke-width:1;
                        stroke-opacity:0;
                        fill: <xsl:value-of select="$titleColorBg"/>;
                        fill-opacity:1;
                      }

        </style>

        <clipPath id="yaxisCP" clipPathUnits="userSpaceOnUse">
          <rect>
            <xsl:attribute name="x"><xsl:value-of select='$yaxis_x'/></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select='$yaxis_y + $ylabels_height'/></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select='$yaxis_width'/></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select='$clipped_yaxis_height'/></xsl:attribute>
          </rect>
        </clipPath>

        <clipPath id="chartCP" clipPathUnits="userSpaceOnUse">
          <rect>
            <xsl:attribute name="x"><xsl:value-of select='$chart_x'/></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select='$chart_y'/></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select='$clipped_chart_width'/></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select='$chart_height'/></xsl:attribute>
          </rect>
        </clipPath>

        <clipPath id="xaxisCP" clipPathUnits="userSpaceOnUse">
          <rect>
            <xsl:attribute name="x"><xsl:value-of select='$xaxis_x + $ylabels_width'/></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select='$xaxis_y'/></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select='$clipped_xaxis_width'/></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select='$xaxis_height'/></xsl:attribute>
          </rect>
        </clipPath>
      </defs>

      <script language="JavaScript">
      var dataAttributes_ = new Object();
      var lineValues = new Object();
      var xLabelValues = new Object();
      </script>

      <xsl:comment> encompassing rectangle containing the chart </xsl:comment>
      <rect onmousemove="doOnMouseMove(evt)" onmouseout="doOnMouseOut(evt)" id="canvas" class="Canvas">
        <xsl:attribute name="x">0</xsl:attribute>
        <xsl:attribute name="y">0</xsl:attribute>
        <xsl:attribute name="width"><xsl:value-of select="$overall_width"/></xsl:attribute>
        <xsl:attribute name="height"><xsl:value-of select="$overall_height"/></xsl:attribute>
      </rect>

      <xsl:comment> chart background (y axis gridlines) </xsl:comment>
      <g id="chartBG" style="clip-path: url(#chartCP)">
        <xsl:call-template name="i2:make_chart_bg">
          <xsl:with-param name="index" select="$yaxis_numlabels + 1"/>
          <xsl:with-param name="countUpIndex" select="0"/>
          <xsl:with-param name="width" select="$clipped_chart_width"/>
          <xsl:with-param name="stripe_height" select="$ylabels_height"/>
          <xsl:with-param name="initial_x" select="$chart_x"/>
          <xsl:with-param name="initial_y" select="$chart_y"/>
        </xsl:call-template>
      </g>

      <xsl:if test="$enableChartTitle = 'true'">
      <xsl:comment> chart title </xsl:comment>
      <g>
        <rect>
          <xsl:attribute name="width"><xsl:value-of select="$title_width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$title_height"/></xsl:attribute>
          <xsl:attribute name="class">TitleBox</xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$title_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$title_y"/></xsl:attribute>
        </rect>
        <text>
          <xsl:attribute name="class">TitleText</xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$title_x + $margin"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$title_y + $titleTextOffsetY"/></xsl:attribute>
          <xsl:value-of select="$chart_title"/>
        </text>
        <xsl:if test="$enableZoom = 'true'">
          <image onclick="yZoomHandler(false)" onmousemove="doOnMouseMove(evt)">
            <xsl:attribute name="x"><xsl:value-of select="$title_x + $title_width - $margin - $zoomImageWidth"/></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select="$title_y + ($title_height - $zoomImageHeight) div 2"/></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$zoomImageWidth"/></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$zoomImageHeight"/></xsl:attribute>
            <xsl:attribute name="xlink:href"><xsl:value-of select="$imageDirectory"/>/zoom_out_graph.gif</xsl:attribute>
            <xsl:attribute name="id">iconZoomOut</xsl:attribute>
            <xsl:attribute name="hastooltip">true</xsl:attribute>
            <xsl:attribute name="tooltiptext"><xsl:value-of select="$zoomOutStr"/></xsl:attribute>
          </image>
          <image onclick="yZoomHandler(true)" onmousemove="doOnMouseMove(evt)">
            <xsl:attribute name="x"><xsl:value-of select="$title_x + $title_width - 2 * $margin - 2 * $zoomImageWidth"/></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select="$title_y + ($title_height - $zoomImageHeight) div 2"/></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$zoomImageWidth"/></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$zoomImageHeight"/></xsl:attribute>
            <xsl:attribute name="xlink:href"><xsl:value-of select="$imageDirectory"/>/zoom_in_chart.gif</xsl:attribute>
            <xsl:attribute name="id">iconZoomIn</xsl:attribute>
            <xsl:attribute name="hastooltip">true</xsl:attribute>
            <xsl:attribute name="tooltiptext"><xsl:value-of select="$zoomInStr"/></xsl:attribute>
          </image>
        </xsl:if>
        <xsl:if test="$debug">
          <image onclick="debug()" onmousemove="doOnMouseMove(evt)">
            <xsl:attribute name="x"><xsl:value-of select="$title_x + $title_width - 3 * $margin - 3 * $zoomImageWidth"/></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select="$title_y + ($title_height - $zoomImageHeight) div 2"/></xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$zoomImageWidth"/></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$zoomImageHeight"/></xsl:attribute>
            <xsl:attribute name="xlink:href"><xsl:value-of select="$imageDirectory"/>/general_alert.gif</xsl:attribute>
            <xsl:attribute name="id">iconDebug</xsl:attribute>
            <xsl:attribute name="hastooltip">true</xsl:attribute>
            <xsl:attribute name="tooltiptext">debug</xsl:attribute>
          </image>
        </xsl:if>
      </g>
      </xsl:if>

      <xsl:comment> y axis title </xsl:comment>
      <g>
        <rect>
          <xsl:attribute name="width"><xsl:value-of select="$yaxis_width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$ylabels_height"/></xsl:attribute>
          <xsl:attribute name="class">AxisTitleBox</xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$yaxis_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$yaxis_y"/></xsl:attribute>
        </rect>
        <text>
          <xsl:attribute name="class">AxisTitleText</xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$yaxis_x + $ylabels_width - $margin"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$yaxis_y + $ylabelsTextOffsetY"/></xsl:attribute>
          <xsl:value-of select="$yaxis_title"/>
        </text>
      </g>

      <xsl:comment> y axis labels </xsl:comment>
      <g id="yaxis" style="clip-path: url(#yaxisCP)">
        <xsl:call-template name="i2:make_yaxis_labels">
          <xsl:with-param name="index" select="$yaxis_numlabels"/>
          <xsl:with-param name="countUpIndex" select="0"/>
          <xsl:with-param name="ylabels_width" select="$ylabels_width"/>
          <xsl:with-param name="ylabels_height" select="$ylabels_height"/>
          <xsl:with-param name="ylabelsTextOffsetY" select="$ylabelsTextOffsetY"/>
          <xsl:with-param name="stepSize" select="$step_size"/>
          <xsl:with-param name="yaxis_x" select="$yaxis_x"/>
          <xsl:with-param name="initial_y" select="$yaxis_y + $ylabels_height"/>
          <xsl:with-param name="locale" select="$locale"/>
          <xsl:with-param name="numYDecimalDigits" select="$numYDecimalDigits"/>
          <xsl:with-param name="offset_y" select="$offset_y"/>
        </xsl:call-template>
      </g>

      <xsl:if test="$enableScrollbar = 'true'">
      <xsl:comment>vertical scrollbar </xsl:comment>
      <g onclick="vscrollbarMouseClick(evt)">
        <!-- background -->
        <rect id="vtrough">
          <xsl:attribute name="class">ScrollbarBGBox</xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$vscrollbar_width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$vscrollbar_height"/></xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$vscrollbar_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$vscrollbar_y"/></xsl:attribute>
        </rect>

        <!-- top button -->
        <rect id="topButton">
          <xsl:attribute name="class">ScrollbarFGBox</xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$vscrollbar_width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$vbutton_height"/></xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$vscrollbar_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$vbutton_t_y"/></xsl:attribute>
        </rect>
        <polyline id="upArrow">
          <xsl:attribute name="class">ScrollbarArrow</xsl:attribute>
          <xsl:attribute name="points">
            <xsl:value-of select="$vscrollbar_x + $vscrollbar_width div 2"/>,<xsl:value-of select="$vbutton_t_y + $vbutton_height div 3"/><xsl:value-of select="' '"/>
            <xsl:value-of select="$vscrollbar_x + $vscrollbar_width div 3"/>,<xsl:value-of select="$vbutton_t_y + 2 * $vbutton_height div 3"/><xsl:value-of select="' '"/>
            <xsl:value-of select="$vscrollbar_x + 2 * $vscrollbar_width div 3"/>,<xsl:value-of select="$vbutton_t_y + 2 * $vbutton_height div 3"/>
          </xsl:attribute>
        </polyline>

        <!-- bottom button -->
        <rect id="bottomButton">
          <xsl:attribute name="class">ScrollbarFGBox</xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$vscrollbar_width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$vbutton_height"/></xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$vscrollbar_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$vbutton_b_y"/></xsl:attribute>
        </rect>
        <polyline id="downArrow">
          <xsl:attribute name="class">ScrollbarArrow</xsl:attribute>
          <xsl:attribute name="points">
            <xsl:value-of select="$vscrollbar_x + $vscrollbar_width div 2"/>,<xsl:value-of select="$vbutton_b_y + 2 * $vbutton_height div 3"/><xsl:value-of select="' '"/>
            <xsl:value-of select="$vscrollbar_x + 2 * $vscrollbar_width div 3"/>,<xsl:value-of select="$vbutton_b_y + $vbutton_height div 3"/><xsl:value-of select="' '"/>
            <xsl:value-of select="$vscrollbar_x + $vscrollbar_width div 3"/>,<xsl:value-of select="$vbutton_b_y + $vbutton_height div 3"/>
          </xsl:attribute>
        </polyline>

        <!-- slider -->
        <rect id="vslider" onmousedown="vsliderMouseDown(evt)" onmouseup="vsliderMouseUp(evt)" onmousemove="vsliderMouseMove(evt)" onmouseout="vsliderMouseOut(evt)">
          <xsl:attribute name="class">ScrollbarFGBox</xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$vscrollbar_width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$vslider_height"/></xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$vscrollbar_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$vslider_y"/></xsl:attribute>
        </rect>

        <!-- space filler box -->
        <!--
        <rect class="Canvas">
          <xsl:attribute name="x"><xsl:value-of select="$vscrollbar_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$vscrollbar_y + $vscrollbar_height"/></xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$vscrollbar_width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$xlabels_height +$xlabels2_height + $hscrollbar_height"/></xsl:attribute>
        </rect>
        -->
      </g>
      </xsl:if>

      <xsl:comment> x axis titles </xsl:comment>
      <g>
        <rect>
          <xsl:attribute name="class">AxisTitleBox</xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$ylabels_width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$xlabels_height"/></xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$xaxis_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$xaxis_y"/></xsl:attribute>
        </rect>
        <text>
          <xsl:attribute name="class">AxisTitleText</xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$xaxis_x + $ylabels_width - $margin"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$xaxis_y + $xlabelsTextOffsetY"/></xsl:attribute>
          <xsl:value-of select="$xaxis_title"/>
        </text>

        <xsl:if test="$xlabels2_height != 0">
          <rect>
            <xsl:attribute name="class">AxisTitleBox</xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$ylabels_width"/></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$xlabels_height"/></xsl:attribute>
            <xsl:attribute name="x"><xsl:value-of select="$xaxis_x"/></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select="$xaxis_y + $xlabels_height"/></xsl:attribute>
          </rect>
          <text>
            <xsl:attribute name="class">AxisTitleText</xsl:attribute>
            <xsl:attribute name="x"><xsl:value-of select="$xaxis_x + $ylabels_width - $margin"/></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select="$xaxis_y + $xlabels_height + $xlabelsTextOffsetY"/></xsl:attribute>
            <xsl:value-of select="$xaxis_title2"/>
          </text>
        </xsl:if>
      </g>

      <!-- group the xaxis objects so they can be systematically retrieved and clipped -->
      <!-- rect and text tags only; no embedded comments in the group - they screw up scrolling -->
      <xsl:comment> x axis labels </xsl:comment>
      <g id="xaxis" style="clip-path: url(#xaxisCP)">
        <!-- primary x axis labels -->
        <xsl:for-each select="$xaxis_labels">
          <rect>
            <xsl:attribute name="class">AxisLabelBox</xsl:attribute>
            <xsl:attribute name="width"><xsl:value-of select="$xlabels_width"/></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$xlabels_height"/></xsl:attribute>
            <xsl:attribute name="x"><xsl:value-of select="$xaxis_x + $ylabels_width + ((position() - 1) * $xlabels_width)"/></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select="$xaxis_y"/></xsl:attribute>
          </rect>

          <text>
            <xsl:attribute name="class">XAxisLabelText</xsl:attribute>
            <xsl:attribute name="x"><xsl:value-of select="$xaxis_x + $ylabels_width + ((position() - 1) * $xlabels_width) + $xlabels_width div 2"/></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select="$xaxis_y + $xlabelsTextOffsetY"/></xsl:attribute>
            <xsl:apply-templates select="."/>
          </text>
        </xsl:for-each>

        <!-- secondary x axis labels -->
        <xsl:if test="$xlabels2_height != 0">
          <!-- first the bounding rects -->
          <xsl:choose>
            <xsl:when test="$xlabels2_span = 'true'">
              <xsl:call-template name="make_secondary_xaxis_rects">
                <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
                <xsl:with-param name="xlabels2_height" select="$xlabels2_height"/>
                <xsl:with-param name="xoffset" select="$xaxis_x + $ylabels_width"/>
                <xsl:with-param name="y" select="$xaxis_y + $xlabels_height"/>
                <xsl:with-param name="xlabels_count" select="$xlabel_count"/>
                <xsl:with-param name="labels" select="$xaxis_labels2"/>
                <xsl:with-param name="position">1</xsl:with-param>
                <xsl:with-param name="span">1</xsl:with-param>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:for-each select="$xaxis_labels2">
                <rect>
                  <xsl:attribute name="class">AxisLabelBox</xsl:attribute>
                  <xsl:attribute name="width"><xsl:value-of select="$xlabels_width"/></xsl:attribute>
                  <xsl:attribute name="height"><xsl:value-of select="$xlabels2_height"/></xsl:attribute>
                  <xsl:attribute name="x"><xsl:value-of select="$xaxis_x + $ylabels_width + ((position() - 1) * $xlabels_width)"/></xsl:attribute>
                  <xsl:attribute name="y"><xsl:value-of select="$xaxis_y + $xlabels_height"/></xsl:attribute>
                </rect>
              </xsl:for-each>
            </xsl:otherwise>
          </xsl:choose>

          <!-- then the text -->
          <xsl:for-each select="$xaxis_labels2">
            <xsl:variable name="xlabel2" select="."/>

            <xsl:if test="$xlabel2 != ''">
              <text>
                <xsl:attribute name="class">XAxisLabelText</xsl:attribute>
                <xsl:attribute name="x"><xsl:value-of select="$xaxis_x + $ylabels_width + ((position() - 1) * $xlabels_width) + $xlabels_width div 2"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="$xaxis_y + $xlabels_height + $xlabelsTextOffsetY"/></xsl:attribute>
                <xsl:value-of select="$xlabel2"/>
              </text>
            </xsl:if>
          </xsl:for-each>
        </xsl:if>
      </g>

      <xsl:comment>capture the labels for use by the event handlers</xsl:comment>
      <script language="JavaScript">
        <!-- put the label text in a CDATA block to protect special characters in the output svg stream -->
        &lt;![CDATA[
        <xsl:for-each select="$xaxis_labels">
          xLabelValues['c<xsl:value-of select="position()"/>'] = '<xsl:value-of select="."/>';
        </xsl:for-each>
        ]]&gt;
      </script>

      <xsl:if test="$enableScrollbar = 'true'">
      <xsl:comment>horizontal scrollbar </xsl:comment>
      <g onclick="hscrollbarMouseClick(evt)">
        <!-- background -->
        <rect id="htrough">
          <xsl:attribute name="class">ScrollbarBGBox</xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$hscrollbar_width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$hscrollbar_height"/></xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$hscrollbar_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$hscrollbar_y"/></xsl:attribute>
        </rect>

        <!-- left button -->
        <rect id="leftButton">
          <xsl:attribute name="class">ScrollbarFGBox</xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$hbutton_width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$hscrollbar_height"/></xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$hbutton_l_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$hscrollbar_y"/></xsl:attribute>
        </rect>
        <polyline id="leftArrow">
          <xsl:attribute name="class">ScrollbarArrow</xsl:attribute>
          <xsl:attribute name="points">
            <xsl:value-of select="$hbutton_l_x + $hbutton_width div 3"/>,<xsl:value-of select="$hscrollbar_y + $hscrollbar_height div 2"/><xsl:value-of select="' '"/>
            <xsl:value-of select="$hbutton_l_x + 2 * $hbutton_width div 3"/>,<xsl:value-of select="$hscrollbar_y + 2 * $hscrollbar_height div 3"/><xsl:value-of select="' '"/>
            <xsl:value-of select="$hbutton_l_x + 2 * $hbutton_width div 3"/>,<xsl:value-of select="$hscrollbar_y + $hscrollbar_height div 3"/>
          </xsl:attribute>
        </polyline>

        <!-- right button -->
        <rect id="rightButton">
          <xsl:attribute name="class">ScrollbarFGBox</xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$hbutton_width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$hscrollbar_height"/></xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$hbutton_r_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$hscrollbar_y"/></xsl:attribute>
        </rect>
        <polyline id="rightArrow">
          <xsl:attribute name="class">ScrollbarArrow</xsl:attribute>
          <xsl:attribute name="points">
            <xsl:value-of select="$hbutton_r_x + 2 * $hbutton_width div 3"/>,<xsl:value-of select="$hscrollbar_y + $hscrollbar_height div 2"/><xsl:value-of select="' '"/>
            <xsl:value-of select="$hbutton_r_x + $hbutton_width div 3"/>,<xsl:value-of select="$hscrollbar_y + 2 * $hscrollbar_height div 3"/><xsl:value-of select="' '"/>
            <xsl:value-of select="$hbutton_r_x + $hbutton_width div 3"/>,<xsl:value-of select="$hscrollbar_y + $hscrollbar_height div 3"/>
          </xsl:attribute>
        </polyline>

        <!-- slider -->
        <rect id="hslider" onmousedown="hsliderMouseDown(evt)" onmouseup="hsliderMouseUp(evt)" onmousemove="hsliderMouseMove(evt)" onmouseout="hsliderMouseOut(evt)">
          <xsl:attribute name="class">ScrollbarFGBox</xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$hslider_width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$hscrollbar_height"/></xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$hslider_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$hscrollbar_y"/></xsl:attribute>
        </rect>
      </g>
      </xsl:if>

      <xsl:if test="$enableLegend = 'true'">
        <xsl:comment> legend </xsl:comment>
        <g id="legendContent">
          <!-- legend background -->
          <rect class="LegendBGBox" id="contentBox">
            <xsl:attribute name="width"><xsl:value-of select="$legend_width"/></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$legend_height"/></xsl:attribute>
            <xsl:attribute name="x"><xsl:value-of select="$legend_x"/></xsl:attribute>
            <xsl:attribute name="y"><xsl:value-of select="$legend_y"/></xsl:attribute>
          </rect>
          <!-- the legend contents are added dynamically in the updateLegend function -->
        </g>
      </xsl:if>

      <!-- group the data objects so they can be systematically retrieved and clipped -->
      <!-- rect, text, and polyline tags only; no embedded comments in the group - they screw up scrolling -->
      <g id="chart" style="clip-path: url(#chartCP)">

      <!-- render each dataset - the render order sets their z order, lowest to highest-->
      <!-- dataset 1 or 14 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>14</xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data1[not($zOrderReversed)] | $data14[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 2 or 13 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>13</xsl:when>
            <xsl:otherwise>2</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data2[not($zOrderReversed)] | $data13[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 3 or 12 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>12</xsl:when>
            <xsl:otherwise>3</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data3[not($zOrderReversed)] | $data11[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 4 or 11 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>11</xsl:when>
            <xsl:otherwise>4</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data4[not($zOrderReversed)] | $data11[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 5 or 10 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>10</xsl:when>
            <xsl:otherwise>5</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data5[not($zOrderReversed)] | $data10[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 6 or 9 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>9</xsl:when>
            <xsl:otherwise>6</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data6[not($zOrderReversed)] | $data9[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 7 or 8 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>8</xsl:when>
            <xsl:otherwise>7</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data7[not($zOrderReversed)] | $data8[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 8 or 7 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>7</xsl:when>
            <xsl:otherwise>8</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data8[not($zOrderReversed)] | $data7[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 9 or 6 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>6</xsl:when>
            <xsl:otherwise>9</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data9[not($zOrderReversed)] | $data6[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 10 or 5 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>5</xsl:when>
            <xsl:otherwise>10</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data10[not($zOrderReversed)] | $data5[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 11 or 4 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>4</xsl:when>
            <xsl:otherwise>11</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data11[not($zOrderReversed)] | $data4[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 12 or 3 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>3</xsl:when>
            <xsl:otherwise>12</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data12[not($zOrderReversed)] | $data3[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 13 or 2 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>2</xsl:when>
            <xsl:otherwise>13</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data13[not($zOrderReversed)] | $data2[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>

      <!-- dataset 14 or 1 -->
      <xsl:call-template name="i2:renderDataset">
        <xsl:with-param name="datasetNum">
          <xsl:choose>
            <xsl:when test='$zOrderReversed'>1</xsl:when>
            <xsl:otherwise>14</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="dataset" select="$data14[not($zOrderReversed)] | $data1[$zOrderReversed]"/>
        <xsl:with-param name="renderTypes" select="$renderTypes"/>
        <xsl:with-param name="colorscheme" select="$colorscheme"/>
        <xsl:with-param name="bar_width" select="$bar_width"/>
        <xsl:with-param name="override_bar_widths" select="$override_bar_widths"/>
        <xsl:with-param name="override_opacities" select="$override_opacities"/>
        <xsl:with-param name="xScaleFactor" select="$xScaleFactor"/>
        <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
        <xsl:with-param name="initial_x" select="$chart_x"/>
        <xsl:with-param name="initial_y" select="($yaxis_numlabels + 2) * $ylabels_height + $title_height"/>
        <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
        <xsl:with-param name="insets" select="$insets"/>
        <xsl:with-param name="ratio" select="$ratio"/>
        <xsl:with-param name="actions" select="$actions"/>
        <xsl:with-param name="xlabel_count" select="$xlabel_count"/>
        <xsl:with-param name="stacked" select="$stacked"/>
        <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
        <xsl:with-param name="enableDataAttrs" select="$enableDataAttrs"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>
      </g>

      <!-- create the text object we'll use to track the changing drag object's value -->
      <text onmousemove="doOnMouseMove(evt)" x="0" y="0" id="dragValue" class="DragValueText">dragValueText</text>

      <!-- create the text object we'll use to display an object's value -->
      <text onmousemove="doOnMouseMove(evt)" x="0" y="0" id="objectValue" class="ObjectValueText">objectValueText</text>

      <!-- create the objects we'll use to display a tooltip -->
      <rect x="0" y="0"  id="tooltipRect" class="TooltipBox" width="300">
        <xsl:attribute name="height"><xsl:value-of select="$smallFontSizeVal + 3"/></xsl:attribute>
      </rect>
      <text x="0" y="0"  id="tooltipText" class="TooltipText">tooltiptext</text>

      <script language="JavaScript">

      <!-- put the initialization in a CDATA block to protect special characters in the output svg stream -->
      &lt;![CDATA[

      // values from the stylesheet
      var insets = '<xsl:value-of select="$insets"/>';
      var ratio = <xsl:value-of select="$ratio"/>;
      var step_size = <xsl:value-of select="$step_size"/>;
      var yScaleFactor = <xsl:value-of select="$yScaleFactor"/>;
      var yaxis_width = <xsl:value-of select="$yaxis_width"/>;
      var yaxis_height = <xsl:value-of select="$yaxis_height"/>;
      var xaxis_y = <xsl:value-of select="$xaxis_y"/>;
      var xlabels_width = <xsl:value-of select="$xlabels_width"/>;
      var stacked = <xsl:value-of select="$stacked"/>;
      var renderTypes = '<xsl:value-of select="$renderTypes"/>';
      var xlabel_count = <xsl:value-of select="$xlabel_count"/>;
      var viewport_width = <xsl:value-of select="$viewport_width"/>;
      var contextData = '<xsl:value-of select="$contextData"/>';
      var enableSvgMenu = <xsl:value-of select="$enableSvgMenu"/>;
      var localeStr = '<xsl:value-of select="$locale"/>';
      var numYDecimalDigits = <xsl:value-of select="$numYDecimalDigits"/>;
      var integral_yaxis_labels = <xsl:value-of select="$integral_yaxis_labels"/>;

      var keyNames = '<xsl:value-of select="$key_names"/>';
      var barBorderColor = '<xsl:value-of select="$barBorderColor"/>';
      var titleColorBg = '<xsl:value-of select="$titleColorBg"/>';
      var svgFontSize = <xsl:value-of select="$labelFontSizeVal"/>;
      var svgFontFamily = '<xsl:value-of select="$fontFamilyVal"/>';
      var margin = <xsl:value-of select="$margin"/>;
      var yTitleBaselineOffset = <xsl:value-of select="$yTitleBaselineOffset"/>;
      var yLabelBaselineOffset = <xsl:value-of select="$yLabelBaselineOffset"/>;
      var ySmallBaselineOffset = <xsl:value-of select="$ySmallBaselineOffset"/>;
      var titleTextOffsetY = <xsl:value-of select="$titleTextOffsetY"/>;
      var ylabelsTextOffsetY = <xsl:value-of select="$ylabelsTextOffsetY"/>;
      var xlabelsTextOffsetY = <xsl:value-of select="$xlabelsTextOffsetY"/>;

      var clickCallback = '<xsl:value-of select="$clickCallback"/>';
      var dragCallback = '<xsl:value-of select="$dragCallback"/>';

      var dataMax = <xsl:value-of select="$dataMax"/>;
      var maxDisplayHeght = <xsl:value-of select="$title_height + $yaxis_height"/>;
      var title_height = <xsl:value-of select="$title_height"/>;
      var ylabels_width = <xsl:value-of select="$ylabels_width"/>;
      var ylabels_height = <xsl:value-of select="$ylabels_height"/>;
      var yaxis_x = <xsl:value-of select="$yaxis_x"/>;
      var yaxis_y = <xsl:value-of select="$yaxis_y"/>;
      var yaxis_numticks = <xsl:value-of select="$yaxis_numticks"/>;
      var yaxis_numlabels = <xsl:value-of select="$yaxis_numlabels"/>;
      var clipped_chart_width = <xsl:value-of select="$clipped_chart_width"/>;
      var chart_x = <xsl:value-of select="$chart_x"/>;
      var chart_y = <xsl:value-of select="$chart_y"/>;
      var enableZoom = <xsl:value-of select="$enableZoom"/>;
      var yZoomLevel = <xsl:value-of select="$yzoomLevel"/>;
      var yZoomIncrement = <xsl:value-of select="$yzoomIncrement"/>;

      var svgDoc_ = null;
      var svgImage_ = null;
      var canvas_ = null;
      var hslider_ = null;
      var vslider_ = null;
      var xaxis_ = null;
      var yaxis_ = null;
      var chart_ = null;
      var chartBG_ = null;

      var overrideOpacitiesStr = '<xsl:value-of select="$override_opacities"/>';
      var overrideOpacities = overrideOpacitiesStr.split(',');
      var colorsStr =
        <xsl:call-template name="i2:buildColorsStr">
          <xsl:with-param name="index">0</xsl:with-param>
          <xsl:with-param name="identifiers" select="$colorscheme"/>
          <xsl:with-param name="colors" select="$colors"/>
        </xsl:call-template>
        "";
      ]]&gt;

      // fudge factor used to format the legend
      var multiplier = 0.48; <!-- <xsl:choose>
        <xsl:when test="starts-with($locale, 'en')">0.48;</xsl:when>
        <xsl:when test="starts-with($locale, 'fr')">0.48;</xsl:when>
        <xsl:when test="starts-with($locale, 'de')">0.48;</xsl:when>
        <xsl:when test="starts-with($locale, 'ja')">0.96;</xsl:when>
        <xsl:when test="starts-with($locale, 'ko')">0.96;</xsl:when>
        <xsl:when test="starts-with($locale, 'zh')">0.96;</xsl:when>
        <xsl:otherwise>0.48;</xsl:otherwise>
      </xsl:choose> -->

      function init(evt)
      {
        svgDoc_ = evt.getTarget().getOwnerDocument();
        svgImage_ = svgDoc_.getElementById("svgImage");
        canvas_ = svgDoc_.getElementById("canvas");
        hslider_ = svgDoc_.getElementById("hslider");
        vslider_ = svgDoc_.getElementById("vslider");
        xaxis_ = svgDoc_.getElementById("xaxis");
        yaxis_ = svgDoc_.getElementById("yaxis");
        chart_ = svgDoc_.getElementById("chart");
        chartBG_ = svgDoc_.getElementById("chartBG");
        //setDefaultAntialias(0);

        // if necessary, stack the bars
        if (stacked != 0)
        {
          stackBars();
        }

<xsl:if test="$enableLegend = 'true'">
        // render the legend
        updateLegend();
</xsl:if>
      }

      function stackBars ()
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        var nextStackedObjName = null;
        var nextStackedObj = null;
        var i = 0;
        var j = 0;

        var offsets = insets.split(",");
        var offsetsIdx = 0;

        var currentY = new Array(xlabel_count); // line 109
        for (i = 0; i < xlabel_count; ++i)
        {
          // duplicate initial_y parameter in renderDataset template calls
          currentY[i] = (yaxis_numlabels + 2) * ylabels_height + title_height;
        }

        if (svgDoc_)
        {
          // iterate across the datasets
          for (i = 1; i <= 14; ++i)
          {
            // skip lines and areas
            if (renderTypes.charAt(i-1) == 'b')
            {
              if (i >= stacked)
              {
                // stack the bars in this dataset
                // iterate across the buckets
                for (j = 1; j <= xlabel_count; ++j)
                {
                  nextStackedObjName = "barr" + i + "c" + j;
                  nextStackedObj = svgDoc_.getElementById(nextStackedObjName);
                  if (nextStackedObj)
                  {
                    // move the bar
                    // this duplicates the logic found in the make_bar template
                    var newX = yaxis_width+((j - 1)*xlabels_width) + Number(offsets[offsetsIdx]);
                    var newY = currentY[j-1]-nextStackedObj.getAttribute('height');
                    nextStackedObj.setAttribute('x', newX);
                    nextStackedObj.setAttribute('y', newY);
                    currentY[j-1] = newY;
                    // make it visible
                    nextStackedObj.getStyle().setProperty("visibility", "inherit");
                  }
                }
              }
              else
              {
                // this should max out at the inset index of the first stacked bar
                ++offsetsIdx;
              }
            }
          }
        }
]]>
]]&gt;
      }

<xsl:if test="$enableLegend = 'true'">

      // map the label list to table [row, col] and grid (x, y)
      var legendLayoutTable_ = null;

      // object used to layout the legend
      function LegendCell (r, c, xparam, yparam, widthparam)
      {
        this.row = r;
        this.col = c;
        this.x = xparam;
        this.y = yparam;
        this.width = widthparam;
      }

<xsl:if test="$debug">
// debug function
LegendCell.prototype.toString = function ()
{
  return "{ ["+this.row+","+this.col+"] ("+this.x+","+this.y+") "+this.width+" }";
}

function displayCells ()
{
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
  var msg = "";
  for (var i = 0; i < legendLayoutTable_.length; ++i)
  {
    msg += "legendLayoutTable_[" + i + "] == " + legendLayoutTable_[i].toString() + "\n";
  }
  alert(msg);
]]>
]]&gt;
}
</xsl:if>

      // return the width of the widest cell in a column
      function colWidth (c)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        var retval = 0;

        for (var i = 0; i < legendLayoutTable_.length; ++i)
        {
          if (legendLayoutTable_[i].col == c && retval < legendLayoutTable_[i].width)
          {
            retval = legendLayoutTable_[i].width;
          }
        }

        return retval;
]]>
]]&gt;
      }

      // set all the cells in a column to the same x
      function alignCol (c, newX)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        for (var i = 0; i < legendLayoutTable_.length; ++i)
        {
          if (legendLayoutTable_[i].col == c)
          {
            legendLayoutTable_[i].x = newX;
          }
        }
]]>
]]&gt;
      }

      // build the legend table to contain the information necessary to layout the legend
      function layoutLegend (labels, legendX, legendY, biasX, biasY, totalWidth)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        legendLayoutTable_ = new Array(labels.length);

        // make the initial allocation of labels to cells
        // -- it will probably be too wide
        var numCols = -1;
        var rowWidth = 0;
        var r = 0;
        var c = 0;
        var x = legendX;
        var y = legendY;
        for (var i = 0; i < labels.length; ++i)
        {
          var len = 0;
          if (labels[i].length > 0)
          {
            len = biasX + labels[i].length * svgFontSize * multiplier + 4 * margin; // super-fudge!!!
          }

          if (rowWidth + len > totalWidth)
          {
            // capture the number of columns
            if (numCols == -1) numCols = c;

            // start the next row
            r++;
            c = 0;
            y += biasY;
            x = legendX;
            rowWidth = 0;
          }
          legendLayoutTable_[i] = new LegendCell(r, c, x, y, len);
          if (labels[i].length > 0) ++c;
          x += len;
          rowWidth += len;
        }

        // proceed only if there is more than one row
        if (numCols != -1)
        {
          // reformat the table to fit inside the total width
          var done = false;
          while (!done)
          {
            rowWidth = 0;
            done = true;

            // walk the columns until they fit
            for (c = 0; c < numCols; ++c)
            {
              var cWidth = colWidth(c);
              if (rowWidth + cWidth <= totalWidth)
              {
                rowWidth += cWidth;
              }
              else
              {
                done = false;
                numCols = c;

                // reassign rows and cols to remaining cells
                var row = 1;
                y = legendY + biasY;
                var col = 0;
                x = legendX;
                for (var i = c; i < legendLayoutTable_.length; ++i)
                {
                  if (col >= numCols)
                  {
                    // next row
                    ++row;
                    y += biasY;
                    col = 0;
                    x = legendX;
                  }
                  legendLayoutTable_[i].row = row;
                  legendLayoutTable_[i].y = y;
                  legendLayoutTable_[i].col = col++;
                  legendLayoutTable_[i].x = x;
                  x += legendLayoutTable_[i].width;
                }
              }
            }
          }

          // walk the columns aligning each column's cell's x's
          var prevWidth = 0;
          var prevX = legendX;
          for (c = 0; c < numCols; ++c)
          {
            alignCol(c, prevX + prevWidth);
            prevWidth = colWidth(c);
            prevX = legendLayoutTable_[c].x
          }
        }
]]>
]]&gt;
      }

      function updateLegend ()
      {
        var legendFrameWidth = <xsl:value-of select="$legend_width"/>;
        var legendX = <xsl:value-of select="$legend_x"/>;
        var legendY = <xsl:value-of select="$legend_y"/>;
        var legendBoxWidth = <xsl:value-of select="$legendBoxWidth"/>;
        var legendBoxHeight = <xsl:value-of select="$legendBoxHeight"/>;

        var keyNamesList = keyNames.split(',');
        var colors = colorsStr.split(',');

        var legendContent = svgDoc_.getElementById("legendContent");
        var contentBox = svgDoc_.getElementById("contentBox");

        // build the legend layout table
        layoutLegend(keyNamesList, legendX+margin, legendY+margin, margin+legendBoxWidth,
                     margin+legendBoxHeight, legendFrameWidth);

<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        // render the legend
        var i;
        for (i = 0; i < keyNamesList.length; ++i)
        {
          if (keyNamesList[i].length > 0)
          {
            // ensure the legend box shows a contrasting color when the
            // entry is deselected
            var targetBox = svgDoc_.createElement("rect");
            targetBox.setAttribute("width", legendBoxWidth);
            targetBox.setAttribute("height", legendBoxHeight);
            targetBox.setAttribute("x", legendLayoutTable_[i].x + margin);
            targetBox.setAttribute("y", legendLayoutTable_[i].y);
            targetBox.setAttribute("class", "ChartBox");
            legendContent.appendChild(targetBox);

            // create the next entry and modify it appropriately
            targetBox = svgDoc_.createElement("rect");
            targetBox.setAttribute("width", legendBoxWidth);
            targetBox.setAttribute("height", legendBoxHeight);
            targetBox.setAttribute("x", legendLayoutTable_[i].x + margin);
            targetBox.setAttribute("y", legendLayoutTable_[i].y);
            targetBox.setAttribute("id", "key"+(i+1));
            targetBox.setAttribute("class", "LegendBox");
            targetBox.setAttribute("onclick", "legendOnClick(evt)");
            targetBox.setAttribute("isVisible", "yes");
            targetBox.getStyle().setProperty("fill", colors[i]);
            if (overrideOpacities[i] != 'def' && overrideOpacities[i] != '1.0')
            {
              targetBox.getStyle().setProperty("fill-opacity", overrideOpacities[i]);
            }
            legendContent.appendChild(targetBox);

            var textNode = svgDoc_.createTextNode(keyNamesList[i]);
            var targetText = svgDoc_.createElement("text");
            targetText.setAttribute("x", legendLayoutTable_[i].x + margin + legendBoxWidth + margin);
            targetText.setAttribute("y", legendLayoutTable_[i].y + yLabelBaselineOffset + 2);
            targetText.setAttribute("class", "LegendText");
            targetText.appendChild(textNode);
            legendContent.appendChild(targetText);
          }
        }

        // calculate the current y extent and resize the contentBox, canvas and svg image
        var overallHeight = legendLayoutTable_[i-1].y + legendBoxHeight + margin;
        contentBox.setAttribute("height", overallHeight - legendY - 1);
        canvas_.setAttribute("height", overallHeight);
        svgImage_.setAttribute("height", overallHeight);
]]>
]]&gt;
      }
</xsl:if>

      function getSVGDocument (node)
      {
        // given any node of the tree, will obtain the SVGDocument node.
        // must be careful: a Document node's ownerDocument is null!
        return (node.getNodeType() != 9) ? node.getOwnerDocument() : node;
      }

      // -------------------------------------------------------------------------------------
      // legend event processing

      function legendOnClick (evt)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        var targetObj = evt.getTarget();
        var id = targetObj.getAttribute("id");
        var idx = id.substring(3);
        var isVisible = targetObj.getAttribute("isVisible");

        // toggle the legend indication
        if (isVisible == "yes")
        {
          targetObj.getStyle().setProperty("fill-opacity", "0");
          targetObj.setAttribute("isVisible", "no");
        }
        else
        {
          if (overrideOpacities[idx-1] != 'def' && overrideOpacities[idx-1] != '1.0')
          {
            targetObj.getStyle().setProperty("fill-opacity", overrideOpacities[idx-1]);
          }
          else
          {
            targetObj.getStyle().setProperty("fill-opacity", "1");
          }
          targetObj.setAttribute("isVisible", "yes");
        }

        setObjectVisibility(isVisible != "yes", id.substring(3));

        // only the legend event handlers should see these events
        evt.stopPropagation();
]]>
]]&gt;
      }

      // modify an object's visibility
      function setObjectVisibility (isVisible, datasetNum)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        var i;
        var j;
        var chartObj = null;
        var renderType = renderTypes.charAt(datasetNum-1);
        var basename = (renderType == 'b') ? "bar" : "line";

        // are we modifying a stacked bar?
        if (stacked == 0 || datasetNum < stacked || renderType != 'b')
        {
          // no, so life is simple
          if (renderType == 'b')
          {
            for (i = 1; i <= xlabel_count; ++i)
            {
              chartObj = svgDoc_.getElementById(basename+'r'+datasetNum+'c'+i);
              if (chartObj != null)
              {
                chartObj.getStyle().setProperty("visibility", isVisible ? "inherit" : "hidden");
              }
            }
          }
          else
          {
            chartObj = svgDoc_.getElementById(basename+datasetNum);
            if (chartObj != null)
            {
              chartObj.getStyle().setProperty("visibility", isVisible ? "inherit" : "hidden");
            }
          }
        }
        else
        {
          // yes, so life is more complicated
          for (j = 1; j <= xlabel_count; ++j)
          {
            var yBias = 0;

            for (i = datasetNum; i <= 14; ++i)
            {
              if (i == datasetNum)
              {
                // set the visibility
                chartObj = svgDoc_.getElementById('barr'+i+'c'+j);
                if (chartObj != null)
                {
                  chartObj.getStyle().setProperty("visibility", isVisible ? "inherit" : "hidden");
                  // set the y bias that will be applied to the next bar
                  yBias = Number(chartObj.getAttribute("height"));

                  if (isVisible)
                  {
                    yBias = -yBias;
                  }
                }
              }
              else
              {
                // move the next bar
                chartObj = svgDoc_.getElementById('barr'+i+'c'+j);
                if (chartObj != null)
                {
                  var curY = chartObj.getAttribute("y");
                  var newY = Number(curY) + yBias;
                  chartObj.setAttribute("y", newY);
                }
              }
            }
          }
        }
]]>
]]&gt;
      }

      // -------------------------------------------------------------------------------------
      // horizontal scrollbar event processing

      var htroughWidth_ = <xsl:value-of select="$htrough_width"/>;
      var htroughX_ = <xsl:value-of select="$hslider_x"/>;
      var hsliderRatio_ = <xsl:value-of select="$hslider_ratio"/>;
      var hsliderWidth_ = <xsl:value-of select="$hslider_width"/>;
      var hsliderX_ = <xsl:value-of select="$hslider_x"/>;
      var hscrollingTarget_ = null;
      var hscrollingOldX_ = 0;

      function hscroll (delta)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        if (delta != 0)
        {
          // compute the move parameters
          var newSliderX = hsliderX_ + delta;
          if (delta < 0)
          {
            if (newSliderX < htroughX_)
            {
              newSliderX = htroughX_;
            }
          }
          else
          {
            if (newSliderX > htroughX_ + htroughWidth_ - hsliderWidth_)
            {
              newSliderX = htroughX_ + htroughWidth_ - hsliderWidth_;
            }
          }

          // move the slider
          hslider_.setAttribute("x", newSliderX);

          // move the chart and axis
          var moveDelta = (hsliderX_ - newSliderX) / hsliderRatio_;
          if (moveDelta != 0)
          {
            var x = 0;

            // move the chart
            var child = chart_.getFirstChild();
            while (child != null)
            {
              var tn = (child.getNodeType() == 1) ? child.getTagName() : null;

              if (tn == 'rect')
              {
                x = child.getAttribute("x");
                child.setAttribute("x", Number(x) + moveDelta);
              }
              else if (tn == 'polyline')
              {
                // extract the points that make up the line
                var points = child.getAttribute("points").split(" ");

                // adjust the x values
                for (var i = 0; i < points.length; ++i)
                {
                  if (points[i] != '')
                  {
                    // decode the next point
                    var tmp = points[i].split(",");

                    tmp[0] = Number(tmp[0]) + moveDelta;
                    points[i] = tmp.join(',');
                  }
                }
                child.setAttribute("points", points.join(" "));
              }
              child = child.getNextSibling();
            }

            // move the x axis
            child = xaxis_.getFirstChild();
            while (child != null)
            {
              if (child.getNodeType() == 1) // Elements only
              {
                x = child.getAttribute("x");
                child.setAttribute("x", Number(x) + moveDelta);
              }
              child = child.getNextSibling();
            }
          }

          // update history
          hsliderX_ = newSliderX;
        }
]]>
]]&gt;
      }

      function hscrollbarMouseClick (evt)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        var targetObj = evt.getTarget();
        var id = targetObj.getAttribute("id");

        if (id == 'leftButton' || id == 'leftArrow')
        {
          hscroll(-xlabels_width * hsliderRatio_);
        }
        else if (id == 'rightButton' || id == 'rightArrow')
        {
          hscroll(xlabels_width * hsliderRatio_);
        }
        else if (id == 'htrough')
        {
          if (evt.getClientX() < hsliderX_)
          {
            hscroll(-hsliderWidth_);
          }
          else if (evt.getClientX() > hsliderX_)
          {
            hscroll(hsliderWidth_);
          }
        }
        // only the scrolling event handlers should see these events
        evt.stopPropagation();
]]>
]]&gt;
      }

      function hsliderMouseDown (evt)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        // disable the mouse right-button menu
        if (!enableSvgMenu && evt.getButton() == 2)
        {
          evt.preventDefault();
        }

        // prepare to drag the slider
        hscrollingTarget_ = evt.getTarget();
        hscrollingOldX_ = evt.getClientX();

        // only the scrolling event handlers should see these events
        evt.stopPropagation();
]]>
]]&gt;
      }

      function hsliderMouseUp (evt)
      {
        if (hscrollingTarget_ != null)
        {
          hscroll(evt.getClientX() - hscrollingOldX_);
          // disable the slider drag
          hscrollingTarget_ = null;
        }
        // only the scrolling event handlers should see these events
        evt.stopPropagation();
      }

      function hsliderMouseMove (evt)
      {
        // scroll only if the mouse button is down
        if (hscrollingTarget_ != null)
        {
          hscroll(evt.getClientX() - hscrollingOldX_);
          hscrollingOldX_ = evt.getClientX();
        }
        // only the scrolling event handlers should see these events
        evt.stopPropagation();
      }

      function hsliderMouseOut (evt)
      {
        // since we cannot do passive focus grabs, if the pointer leaves the slider, the
        // slider drag is over
        hscrollingTarget_ = null;
        // only the scrolling event handlers should see these events
        evt.stopPropagation();
      }

      // -------------------------------------------------------------------------------------
      // vertical scrollbar event processing

      var vscrollbarHeight_ = <xsl:value-of select="$vscrollbar_height"/>;
      var vtroughHeight_ = <xsl:value-of select="$vtrough_height"/>;
      var vtroughY_ = <xsl:value-of select="$vslider_y"/>;
      var vsliderRatio_ = <xsl:value-of select="$vslider_ratio"/>;
      var vsliderHeight_ = <xsl:value-of select="$vslider_height"/>;
      var vsliderY_ = <xsl:value-of select="$vslider_y"/>;
      var vscrollingTarget_ = null;

      // scroll the yaxis - delta is how far the slider should move
      function vscroll (delta)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        if (delta != 0)
        {
          // compute the move parameters
          var newSliderY = vsliderY_ + delta;
          if (delta < 0)
          {
            if (newSliderY < vtroughY_)
            {
              newSliderY = vtroughY_;
            }
          }
          else
          {
            if (newSliderY > vtroughY_ + vtroughHeight_ - vsliderHeight_)
            {
              newSliderY = vtroughY_ + vtroughHeight_ - vsliderHeight_;
            }
          }

          // move the slider
          vslider_.setAttribute("y", newSliderY);

          // move the chart and axis
          var moveDelta = (vsliderY_ - newSliderY) * yScaleFactor / vsliderRatio_;
          if (moveDelta != 0)
          {
            var y = 0;

            // move the chart
            var child = chart_.getFirstChild();
            while (child != null)
            {
              var tn = (child.getNodeType() == 1) ? child.getTagName() : null;

              if (tn == 'rect')
              {
                y = child.getAttribute("y");
                child.setAttribute("y", Number(y) + moveDelta);
              }
              else if (tn == 'polyline')
              {
                // extract the points that make up the line
                var points = child.getAttribute("points").split(" ");

                // adjust the y values
                for (var i = 0; i < points.length; ++i)
                {
                  if (points[i] != '')
                  {
                    // decode the next point
                    var tmp = points[i].split(",");

                    tmp[1] = Number(tmp[1]) + moveDelta;
                    points[i] = tmp.join(',');
                  }
                }
                child.setAttribute("points", points.join(" "));
              }
              child = child.getNextSibling();
            }

            // move the y axis
            child = yaxis_.getFirstChild();
            while (child != null)
            {
              if (child.getNodeType() == 1) // Elements only
              {
                y = child.getAttribute("y");
                child.setAttribute("y", Number(y) + moveDelta);
              }
              child = child.getNextSibling();
            }

            // move the chart background
            child = chartBG_.getFirstChild();
            while (child != null)
            {
              if (child.getNodeType() == 1) // Elements only
              {
                y = child.getAttribute("y");
                child.setAttribute("y", Number(y) + moveDelta);
              }
              child = child.getNextSibling();
            }
          }

          // update history
          vsliderY_ = newSliderY;
        }
]]>
]]&gt;
      }

      function vscrollbarMouseClick (evt)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        var targetObj = evt.getTarget();
        var id = targetObj.getAttribute("id");

        if (id == 'topButton' || id == 'upArrow')
        {
          vscroll(-ylabels_height * vsliderRatio_ / yScaleFactor);
        }
        else if (id == 'bottomButton' || id == 'downArrow')
        {
          vscroll(ylabels_height * vsliderRatio_ / yScaleFactor);
        }
        else if (id == 'vtrough')
        {
          if (evt.getClientY() < vsliderY_)
          {
            vscroll(-vsliderHeight_);
          }
          else if (evt.getClientY() > vsliderY_)
          {
            vscroll(vsliderHeight_);
          }
        }
        // only the scrolling event handlers should see these events
        evt.stopPropagation();
]]>
]]&gt;
      }

      function vsliderMouseDown (evt)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        // disable the mouse right-button menu
        if (!enableSvgMenu && evt.getButton() == 2)
        {
          evt.preventDefault();
        }

        // prepare to drag the slider
        vscrollingTarget_ = evt.getTarget();
        vscrollingOldY_ = evt.getClientY();

        // only the scrolling event handlers should see these events
        evt.stopPropagation();
]]>
]]&gt;
      }

      function vsliderMouseUp (evt)
      {
        if (vscrollingTarget_ != null)
        {
          vscroll(evt.getClientY() - vscrollingOldY_);
          // disable the slider drag
          vscrollingTarget_ = null;
        }
        // only the scrolling event handlers should see these events
        evt.stopPropagation();
      }

      function vsliderMouseMove (evt)
      {
        // scroll only if the mouse button is down
        if (vscrollingTarget_ != null)
        {
          vscroll(evt.getClientY() - vscrollingOldY_);
          vscrollingOldY_ = evt.getClientY();
        }
        // only the scrolling event handlers should see these events
        evt.stopPropagation();
      }

      function vsliderMouseOut (evt)
      {
        // since we cannot do passive focus grabs, if the pointer leaves the slider, the
        // slider drag is over
        vscrollingTarget_ = null;
        // only the scrolling event handlers should see these events
        evt.stopPropagation();
      }

<xsl:if test="$debug">
      // -------------------------------------------------------------------------------------
      // debug function
      function showYScrollableElements()
      {
        var result = null;

        // yaxis label elements
        result = "Y Axis Label elements:\n";
        var child = yaxis_.getFirstChild();
        var tn = null;
        while (child != null)
        {
          if (child.getNodeType() == 1)
          {
            tn = child.getTagName();
            if (tn == "rect")
            {
              result += tn +
              "(" + child.getAttribute("x") + "," + child.getAttribute("y") + ") " +
              "{" + child.getAttribute("width") + "," + child.getAttribute("height") + "}\n";
            }
            else if (tn == "text")
            {
              result += tn +
              "(" + child.getAttribute("x") + "," + child.getAttribute("y") + ")\n";
            }
            else
            {
              result += tn + "\n";
            }
          }
          child = child.getNextSibling();
        }
        alert(result);

        // chart BG elements
        result = "Chart background elements:\n";
        var child = chartBG_.getFirstChild();
        var tn = null;
        while (child != null)
        {
          if (child.getNodeType() == 1)
          {
            tn = child.getTagName();
            if (tn == "rect")
            {
              result += tn +
              "(" + child.getAttribute("x") + "," + child.getAttribute("y") + ") " +
              "{" + child.getAttribute("width") + "," + child.getAttribute("height") + "}\n";
            }
            else
            {
              result += tn + "\n";
            }
          }
          child = child.getNextSibling();
        }
        alert(result);

        // data elements
        result = "Chart elements:\n";
        var child = chart_.getFirstChild();
        var tn = null;
        while (child != null)
        {
          if (child.getNodeType() == 1)
          {
            tn = child.getTagName();
            if (tn == "rect")
            {
              result += tn +
              "(" + child.getAttribute("x") + "," + child.getAttribute("y") + ") " +
              "{" + child.getAttribute("width") + "," + child.getAttribute("height") + "}\n";
            }
            else if (tn == "polyline")
            {
              result += tn +
              "(" + child.getAttribute("x") + "," + child.getAttribute("y") + ") " +
              "{" + child.getAttribute("points") + "}\n";
            }
            else
            {
              result += tn + "\n";
            }
          }
          child = child.getNextSibling();
        }
        alert(result);
      }
</xsl:if>

      // -------------------------------------------------------------------------------------
      // y zoom

      function yZoomHandler(isZoomIn)
      {
        if (isZoomIn)
        {
          ++yZoomLevel;
          yZoom();
        }
        else if (yZoomLevel > 0)
        {
          --yZoomLevel;
          yZoom();
        }
      }

      function yZoom()
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[

        // capture any necessary values prior to recomputing them for the zoom
        var old_yScaleFactor = yScaleFactor;
        var old_yaxis_numlabels = yaxis_numlabels;
        var old_ratio = ratio;

        // adjust the vertical scrollbar
        //
        // adjust the slider height
        vsliderHeight_ = vtroughHeight_ / (1 + yZoomLevel * yZoomIncrement);
        if (vsliderHeight_ < 10) vsliderHeight_ = 10;
        // check the y coordinates for zoom out
        if (vsliderY_ > vtroughY_ + vtroughHeight_ - vsliderHeight_)
        {
          // scroll the chart to the point where the entire slider fits in the trough
          vscroll(vtroughY_ + vtroughHeight_ - vsliderHeight_ - vsliderY_);
        }
        vslider_.setAttribute("height", vsliderHeight_);
        var old_vsliderY = vsliderY_;

        // compute new values for the zoom
        yScaleFactor = 1 + yZoomLevel * yZoomIncrement;
        yaxis_numlabels = yaxis_numticks * yScaleFactor;
        ratio = (ylabels_height * yaxis_numlabels) / dataMax;
        step_size = dataMax / yaxis_numlabels;
        if (integral_yaxis_labels || step_size == Math.floor(step_size))
          numYDecimalDigits = 0;
        else if (step_size < 0.00001)
          numYDecimalDigits = 6;
        else if (step_size < 0.0001)
          numYDecimalDigits = 5;
        else if (step_size < 0.001)
          numYDecimalDigits = 4;
        else if (step_size < 0.01)
          numYDecimalDigits = 3;
        else if (step_size < 0.1)
          numYDecimalDigits = 2;
        else if (step_size < 1)
          numYDecimalDigits = 1;
        else
          numYDecimalDigits = 2;
        var relativeScale = yScaleFactor / old_yScaleFactor;

        // calculate the offsets due to the y axis scrollbar
        // these offsets are the translation amounts used to position the chart elements
        // when the slider is not at the top of the trough
        var old_offset = (vsliderY_ - vtroughY_) * old_yScaleFactor / vsliderRatio_;
        var offset = (vsliderY_ - vtroughY_) * yScaleFactor / vsliderRatio_;

        // zoom the data representations
        //
        var y;
        var old_initial_y = (old_yaxis_numlabels + 2) * ylabels_height + title_height;
        var initial_y = (yaxis_numlabels + 2) * ylabels_height + title_height;
        var child = chart_.getFirstChild();
        while (child != null)
        {
          if (child.getNodeType() == 1) // elements only
          {
            var tn = child.getTagName();
            var datasetNum = child.getAttribute("datasetNum");

            if (tn == 'polyline')
            {
              // extract the points that make up the line
              var points = child.getAttribute("points").split(" ");

              // adjust the y coordinate values
              var value;
              if (renderTypes.charAt(datasetNum-1) == 'l')
              {
                // handle the line data
                for (var i = 0; i < points.length; ++i)
                {
                  if (points[i] != '')
                  {
                    var tmp = points[i].split(",");
                    var key = "r"+datasetNum+"c"+(i+1);
                    value = lineValues[key];
                    tmp[1] =  initial_y - value * ratio - offset;
                    points[i] = tmp.join(',');
                  }
                }
              }
              else
              {
                // handle the area data
                for (var i = 0; i < points.length; ++i)
                {
                  if (points[i] != '')
                  {
                    var tmp = points[i].split(",");
                    if (i == 0 || i >= points.length-2)
                    {
                      tmp[1] = initial_y - offset;
                    }
                    else
                    {
                       var key = "r"+datasetNum+"c"+i;
                       value = lineValues[key];
                       tmp[1] =  initial_y - value * ratio - offset;
                    }
                    points[i] = tmp.join(',');
                  }
                }
              }
              child.setAttribute("points", points.join(" "));
            }
            else if (tn == "rect")
            {
              var height = child.getAttribute("height") * relativeScale;
              if (datasetNum < stacked)
              {
                // handle an unstacked bar
                child.setAttribute("y", initial_y - height - offset);
              }
              else
              {
                // handle a stacked bar
                y = child.getAttribute("y");
                child.setAttribute("y", initial_y - (old_initial_y - y) * relativeScale);
              }
              child.setAttribute("height", height);
            }
          }
          child = child.getNextSibling();
        }

        // adjust the y axis labels
        //
        // relabel the pre-existing text elements
        var textNode = null;
        var valueStr = null;
        var idx = 0;
        child = yaxis_.getFirstChild();
        while (child != null)
        {
          valueStr = formatNum(step_size * (yaxis_numlabels - idx), localeStr, numYDecimalDigits);

          if (child.getNodeType() == 1)
          {
            child.setAttribute("y", child.getAttribute("y") - offset + old_offset);
            if (child.getTagName() == 'text')
            {
              var newTextNode = svgDoc_.createTextNode(valueStr);
              textNode = child.getFirstChild();
              child.replaceChild(newTextNode, textNode);
              ++idx;
            }
          }

          child = child.getNextSibling();
        }

        // create any necessary additional text elements
        initial_y = yaxis_y + ylabels_height;
        for (; idx <= yaxis_numlabels; ++idx)
        {
          valueStr = formatNum(step_size * (yaxis_numlabels - idx), localeStr, numYDecimalDigits);

          var labelBox = svgDoc_.createElement("rect");
          labelBox.setAttribute("width", ylabels_width);
          labelBox.setAttribute("height", ylabels_height);
          labelBox.setAttribute("x", yaxis_x);
          labelBox.setAttribute("y", initial_y + idx * ylabels_height - offset);
          labelBox.setAttribute("class", "AxisLabelBox");
          yaxis_.appendChild(labelBox);

          textNode = svgDoc_.createTextNode(valueStr);
          var labelText = svgDoc_.createElement("text");
          labelText.setAttribute("x", yaxis_x + ylabels_width - margin);
          labelText.setAttribute("y", initial_y + idx * ylabels_height + ylabelsTextOffsetY - offset);
          labelText.setAttribute("class", "YAxisLabelText");
          labelText.appendChild(textNode);
          yaxis_.appendChild(labelText);
        }

        // adjust the chart background
        //
        var idx = 0;
        // handle the pre-existing elements
        child = chartBG_.getFirstChild();
        while (child != null)
        {
          if (child.getNodeType() == 1)
          {
            child.setAttribute("y", child.getAttribute("y") - offset + old_offset);
            ++idx;
          }

          child = child.getNextSibling();
        }

        // create any necessary additional bg rects
        initial_y = yaxis_y;
        for (; idx <= yaxis_numlabels + 1; ++idx)
        {

          var isPrimaryStripe = (yaxis_numlabels + 1 - idx) % 2 == 1;

          // create another background rect
          var bgRect = svgDoc_.createElement("rect");
          bgRect.setAttribute("width", clipped_chart_width);
          bgRect.setAttribute("height", ylabels_height);
          bgRect.setAttribute("x", chart_x);
          bgRect.setAttribute("y", chart_y + idx * ylabels_height - offset);
          bgRect.setAttribute("class", isPrimaryStripe ? "ChartBox" : "ChartBoxAlt");
          chartBG_.appendChild(bgRect);
        }

]]>
]]&gt;
      }

      var radixPoints = new Object();
      radixPoints['en'] = '.';
      radixPoints['de'] = ',';
      radixPoints['fr'] = ',';
      radixPoints['ja'] = '.';
      radixPoints['ko'] = '.';
      radixPoints['zh'] = '.';
      var groupingChars = new Object();
      groupingChars['en'] = ',';
      groupingChars['de'] = '.';
      groupingChars['fr'] = ' ';
      groupingChars['ja'] = ',';
      groupingChars['ko'] = ',';
      groupingChars['zh'] = ',';

      var numericRegExps = new Array(/^-?\d+$/,
                                     /^-?(\d+\.\d+|\.\d+)$/);

      // Encode the specified number as a string with the number of specified decimal places.
      // Error conditions, such as a non-numeric string or a negative decimalPlaces return
      // the original string.
      function formatNum (num, locale, decimalPlaces)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        var retval = num.toString();
        var dotPos;

        // format the string using standard JavaScript formatting
        if (decimalPlaces >= 0)
        {
          if (retval.search(numericRegExps[0]) != -1)
          {
            // handle strings with no decimal point
            if (decimalPlaces > 0)
            {
              retval += '.';
              for (var i = 0; i < decimalPlaces; ++i)
              {
                retval += "0";
              }
            }
          }
          else if (retval.search(numericRegExps[1]) != -1)
          {
            if (decimalPlaces == 0)
            {
              retval = Math.round(num).toString();
            }
            else
            {
              // add or remove digits as necessary
              dotPos = retval.indexOf(".");
              var fracDigits = retval.length - dotPos - 1;
              if (fracDigits < decimalPlaces)
              {
                // add zeroes
                for (var i = fracDigits; i < decimalPlaces; ++i)
                {
                  retval += "0";
                }
              }
              else if (fracDigits > decimalPlaces)
              {
                // round to the specified number of decimal places
                var shiftLeft = Math.pow(10, decimalPlaces);
                num *= shiftLeft;
                num = Math.round(num);
                num /= shiftLeft;
                retval = num.toString();
                // ensure the rounding didn't shorten the number of decimal digits
                if (decimalPlaces > 0)
                {
                  dotPos = retval.indexOf(".");
                  if (dotPos == -1)
                  {
                    retval += '.';
                    dotPos = retval.length - 1;
                  }
                  fracDigits = retval.length - dotPos - 1;
                  if (fracDigits < decimalPlaces)
                  {
                    // add zeroes
                    for (var i = fracDigits; i < decimalPlaces; ++i)
                    {
                      retval += "0";
                    }
                  }
                }
              }
            }
          }
        }

        // localize the formatted string
        // - first the radix point
        locale = (locale != null && locale.length >= 2) ? locale.substr(0, 2) : 'en';
        integralLen = retval.length;
        dotPos = retval.indexOf(".");
        if (dotPos != -1)
        {
          retval = retval.substr(0, dotPos) + radixPoints[locale] +retval.substr(dotPos+1);
          integralLen = dotPos;
        }
        // - then grouping separators
        var numDigitsPerGroup = integralLen % 3;
        if (numDigitsPerGroup == 0) numDigitsPerGroup = 3;
        var tmp = '';
        var numDigits = 0;
        while (numDigits < integralLen - 3)
        {
          tmp += retval.substr(numDigits, numDigitsPerGroup) + groupingChars[locale];
          numDigits += numDigitsPerGroup;
          numDigitsPerGroup = 3;
        }
        retval = tmp + retval.substr(numDigits);

        return retval;
]]>
]]&gt;
      }

      // -------------------------------------------------------------------------------------
      // event processing

      function xToBucketNum (x)
      {
        return Math.round((x - yaxis_width - (xlabels_width/2)) / xlabels_width + 1);
      }

      function bucketNumToX (bucketNum)
      {
        return yaxis_width + ((bucketNum - 1) * xlabels_width) + Math.ceiling(xlabels_width / 2);
      }

      function yToValue (y)
      {
        return Math.round((xaxis_y - y)/ratio);
      }

      function valueToY (value)
      {
        return yaxis_height - Math.ceiling(value * ratio);
      }

      function isBar (id)
      {
        return id.substring(0,3) == 'bar';
      }

      function isLine (id)
      {
        return id.substring(0,4) == 'line';
      }

      function isTooltipObj (obj)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        var hasTooltip = obj.getAttribute("hastooltip");
        return hasTooltip != null && hasTooltip == 'true';
]]>
]]&gt;
      }

      var dragObj_ = null;
      var dragObjType_ = 0; // undefined
      var dragLineKey_ = null;
      var origDatasetNum_ = 0;
      var origBucketNum_ = 0;
      var origValue_ = null;
      var pointsPre_ = null;
      var origPoint_ = null;
      var pointsPost_ = null;
      var origEvtY_ = 0;
      var origObjectY_ = 0;
      var origObjHeight_ = 0;
      var yBias_ = 0;

      var dragValueObj_ = null;
      var objectValueObj_ = null;
      var tooltip_ = null;
      var tooltipRect_ = null;
      var tooltipText_ = null;
      var pointMatchThreshold_ = 15;
      var dragValueOffset_ = 10;
      var objectValueOffset_ = 10;

      var showValueObj_ = null;
      var showValueX_ = -1;
      var showValueY_ = -1;
      var showValueEvt_ = null;
      var showValueThresholdTime_ = 1000; // timeout in millisec.

      // find the point closest to the specified x and y if they are within the threshold radius
      // set pointsPre_ and pointsPost_ as side affects
      function findLineXY (lineObj, x, y)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        var xy = null;
        pointsPre_ = "";
        pointsPost_ = "";

        // extract the points that make up the line
        var pointsList = lineObj.getAttribute("points");
        var points = pointsList.split(" ");

        // find the point
        for (var i = 0; i < points.length; ++i)
        {
          // decode the next point
          var tmp = points[i].split(",");
          var ptX = tmp[0];
          var ptY = tmp[1];

          if (ptX && ptX.length > 0 && ptY && ptY.length > 0)
          {
            if (Math.abs(ptX - x) < pointMatchThreshold_ && Math.abs(ptY - y) < pointMatchThreshold_)
            {
              // capture the match
              xy = new Array(ptX, ptY);
            }
            else if (xy == null)
            {
              // no match yet so accumulate in prelude
              pointsPre_ += points[i] + " ";
            }
            else
            {
              // after the match so accumulate in postlude
              pointsPost_ += points[i] + " ";
            }
          }
        }

        return xy;
]]>
]]&gt;
      }

      function revealDragValue (evt, value)
      {
        if (dragValueObj_ == null)
        {
          dragValueObj_ = svgDoc_.getElementById("dragValue");
        }
        if (dragValueObj_ != null)
        {
          dragValueObj_.setAttribute("x", evt.getClientX());
          dragValueObj_.setAttribute("y", evt.getClientY() - dragValueOffset_);
          // reset the text to blank
          if (dragValueObj_.getFirstChild() != null)
          {
            dragValueObj_.getFirstChild().setData(value);
          }
          else
          {
            dragValueObj_.setData(" ");
          }
          dragValueObj_.getStyle().setProperty("visibility", "inherit");
        }
      }

      function repositionDragValue (evt, ybias)
      {
        if (dragValueObj_ != null)
        {
          dragValueObj_.setAttribute("y", evt.getClientY() - dragValueOffset_);

          // set the text to the value
          if (dragValueObj_.getFirstChild() != null)
          {
            dragValueObj_.getFirstChild().setData(yToValue(evt.getClientY()+ybias));
          }
          else
          {
            dragValueObj_.setData(" ");
          }
        }
      }

      function hideDragValue ()
      {
        if (dragValueObj_ != null)
        {
          dragValueObj_.getStyle().setProperty("visibility", "hidden");
        }
      }

      function revealObjectValue (x, y, value)
      {
        if (objectValueObj_ == null)
        {
          objectValueObj_ = svgDoc_.getElementById("objectValue");
        }
        if (objectValueObj_ != null)
        {
          objectValueObj_.setAttribute("x", x);
          objectValueObj_.setAttribute("y", y - objectValueOffset_);
          // reset the text to blank
          if (objectValueObj_.getFirstChild() != null)
          {
            objectValueObj_.getFirstChild().setData(value);
          }
          else
          {
            objectValueObj_.setData(" ");
          }
          objectValueObj_.getStyle().setProperty("visibility", "inherit");
        }
      }

      function revealTooltip (targetObj)
      {
        var text = targetObj.getAttribute("tooltiptext");
        var targetX = Number(targetObj.getAttribute("x"));
        var targetY = Number(targetObj.getAttribute("y"));
        var targetHeight = Number(targetObj.getAttribute("height"));
        var x = targetX;

        if (tooltipRect_ == null)
        {
          tooltipRect_ = svgDoc_.getElementById("tooltipRect");
          tooltipText_ = svgDoc_.getElementById("tooltipText");
        }
        if (tooltipRect_ != null)
        {
          // set and position the text
          tooltipText_.getFirstChild().setData(text);
          var strlen = Number(tooltipText_.getComputedTextLength());

          if (targetX + strlen + 2 * margin > viewport_width) x = viewport_width - strlen - 2 * margin;

          tooltipText_.setAttribute("x", x + strlen / 2 + margin);
          tooltipText_.setAttribute("y", targetY + 2 * margin + targetHeight + ySmallBaselineOffset + 1);

          // position and size the rect
          tooltipRect_.setAttribute("x", x);
          tooltipRect_.setAttribute("y", targetY + 2 * margin + targetHeight);
          tooltipRect_.setAttribute("width", strlen + 2 * margin);

          tooltipRect_.getStyle().setProperty("visibility", "inherit");
          tooltipText_.getStyle().setProperty("visibility", "inherit");
        }
      }

      function hideObjectValue ()
      {
        if (objectValueObj_ != null)
        {
          objectValueObj_.getStyle().setProperty("visibility", "hidden");
        }
        if (tooltipRect_ != null)
        {
          tooltipRect_.getStyle().setProperty("visibility", "hidden");
          tooltipText_.getStyle().setProperty("visibility", "hidden");
        }

        showValueObj_ = null;
        showValueX_ = -1;
        showValueY_ = -1;
        showValueEvt_ = null;
      }

      function showValue (x, y)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        // if the mouse hasn't moved reveal the object value text
        if (showValueObj_ != null && showValueX_ == x && showValueY_ == y)
        {
          var value = null;

          // retrieve the show object's value
          var id = showValueObj_.getAttribute("id");
          if (isBar(id))
          {
            value = showValueObj_.getAttribute("value");

            // reveal the value
            revealObjectValue(x, y, value);
          }
          else if (isLine(id))
          {
            var datasetNumStr = showValueObj_.getAttribute("datasetNum");
            var bucketNum = xToBucketNum(x);
            //alert('r'+datasetNumStr+'c'+bucketNum);
            value = lineValues['r'+datasetNumStr+'c'+bucketNum];

            // reveal the value
            revealObjectValue(x, y, value);
          }
          else if (isTooltipObj(showValueObj_))
          {
            // reveal the value
            revealTooltip(showValueObj_);
          }
        }
]]>
]]&gt;
      }

      // install the value checker on the containing window
      window.showValue = showValue;

      function dispatchClickCallback (datasetNumStr, bucketNumStr, valueStr, bucketLabel1, bucketLabel2, dataAttrs)
      {
        var cb = clickCallback + "('" + datasetNumStr + "','" + bucketNumStr + "','" + valueStr + "','" + bucketLabel1 + "','" + bucketLabel2 + "','" + contextData + "','" + dataAttrs + "')";
        eval(cb);
      }

      function dispatchDragCallback (datasetNumStr, bucketNumStr, valueStr, newValueStr, bucketLabel1, bucketLabel2, dataAttrs)
      {
        var cb = dragCallback + "('" + datasetNumStr + "','" + bucketNumStr + "','" + valueStr + "','" + newValueStr + "','" + bucketLabel1 + "','" + bucketLabel2 + "','" + contextData + "','" + dataAttrs + "')";
        eval(cb);
      }

      function makeBarInteractable (id, evt)
      {
        dragObjType_ = 2; // bar
        origBucketNum_ = dragObj_.getAttribute("bucketNum");
        origDatasetNum_ = dragObj_.getAttribute("datasetNum");
        origValue_ = dragObj_.getAttribute("value");
        origObjHeight_ = dragObj_.getAttribute("height");
        origObjY_ = dragObj_.getAttribute("y");
        origEvtY_ = evt.getClientY();
        yBias_ = origObjY_ - origEvtY_;

        // change the bar's stroke style to indicate which one was picked
        dragObj_.getStyle().setProperty("stroke-dasharray", "2 4");

        // configure the value tracking text
        revealDragValue(evt, origValue_);
      }

      function makeLineInteractable (id, evt)
      {
        origPoint_ = findLineXY(dragObj_, evt.getClientX(), evt.getClientY());

        if (origPoint_ != null)
        {
          dragObjType_ = 1; // line
          origBucketNum_ = xToBucketNum(origPoint_[0]);
          origDatasetNum_ = id.substring(4);
          dragLineKey_ = "r"+origDatasetNum_+"c"+origBucketNum_;
          origValue_ = lineValues[dragLineKey_];

          // change the line style to indicate which one was picked
          dragObj_.getStyle().setProperty("stroke-dasharray", "2 4");

          // configure the value tracking text
          revealDragValue(evt, origValue_);
        }
        else
        {
          // since we have no match disable drag processing
          dragObj_ = null;
        }
      }

      function doOnMouseOut (evt)
      {
        hideObjectValue();
        showValueObj_ = null;
      }

      function doOnMouseDown (evt)
      {
<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        // disable the mouse right-button menu
        if (!enableSvgMenu && evt.getButton() == 2)
        {
          evt.preventDefault();
        }

        var targetObj = evt.getTarget();
        var id = targetObj.getAttribute("id");

        if (targetObj.getAttribute("drag") == "yes")
        {
          dragObj_ = targetObj;

          if (isBar(id))
          {
            makeBarInteractable(id, evt);
          }
          else if (isLine(id))
          {
            makeLineInteractable(id, evt);
          }

          hideObjectValue();
          showValueObj_ = null;
        }
]]>
]]&gt;
      }

      var mouseMoveX_ = -1;
      var mouseMoveY_ = -1;

      function doOnMouseMove (evt)
      {
        var x = evt.getClientX();
        var y = evt.getClientY();

<!-- guard against the double processing -->
&lt;![CDATA[
<![CDATA[
        if (x != mouseMoveX_ && y != mouseMoveY_) // ensure the mouse has actually moved
        {
          if (dragObj_ != null)
          {
            if (dragObjType_ == 2) // bar
            {
              var delta = origEvtY_ - y;
              dragObj_.setAttribute("y", origObjY_ - delta);
              dragObj_.setAttribute("height", Number(origObjHeight_) + delta);

              // update the value tracking text
              repositionDragValue (evt, yBias_);
            }
            else if (dragObjType_ == 1) // line
            {
              if (origPoint_ != null)
              {
                // insert the new point in the points list
                var newPoint = origPoint_[0] + "," + y + " ";
                var newPointList = pointsPre_ + newPoint + pointsPost_;
                dragObj_.setAttribute("points", newPointList);

                // update the value tracking text
                repositionDragValue (evt, 0);
              }
            }
          }
          else
          {
            hideObjectValue();
            showValueObj_ = evt.getTarget();

            if (showValueObj_.getAttribute("showValue") == "true" ||
                showValueObj_.getAttribute("hastooltip") == "true")
            {
              // capture the values we need
              showValueX_ = x;
              showValueY_ = y;
              showValueEvt_ = evt;
              // schedule the showValue checker
              setTimeout('showValue(' + showValueX_ + ',' + showValueY_ + ');', showValueThresholdTime_);
            }
          }
          mouseMoveX_ = x;
          mouseMoveY_ = y;
        }
]]>
]]&gt;
      }

      function doOnMouseUp (evt)
      {
        var targetObj = evt.getTarget();
        var id = targetObj.getAttribute("id");

        if (dragObj_ != null)
        {
          if (dragObjType_ == 2) // bar
          {
            // capture the new value
            var delta = origEvtY_ - evt.getClientY();
            newValue = yToValue(origObjY_ - delta);

            // restore the bar's appearance
            dragObj_.getStyle().setProperty("stroke-dasharray", "none");

            // update the saved value
            dragObj_.setAttribute("value", newValue);
          }
          else if (dragObjType_ == 1) // line
          {
            // capture the new value
            newValue = yToValue(evt.getClientY());

            // restore the line's appearance
            dragObj_.getStyle().setProperty("stroke-dasharray", "none");

            // update the line values hash
            lineValues[dragLineKey_] = newValue;
          }

          // hide the value tracking text
          hideDragValue();

          // disable drag processing
          dragObj_ = null;
          dragObjType_ = 0; // undefined

          var nextBucketNum = origBucketNum_;
          ++nextBucketNum;
          dispatchDragCallback(origDatasetNum_, origBucketNum_, origValue_, newValue, xLabelValues['c'+origBucketNum_], xLabelValues['c'+nextBucketNum], dataAttributes_['r'+origDatasetNum_+'c'+origBucketNum_]);
        }
      }

      function doOnClick (evt)
      {
        var targetObj = evt.getTarget();
        var id = targetObj.getAttribute("id");
        var datasetNumStr = targetObj.getAttribute("datasetNum");
        var bucketNum;
        var valueStr;
        if (isBar(id))
        {
          bucketNum = Number(targetObj.getAttribute("bucketNum"));
          valueStr = targetObj.getAttribute("value");
          dispatchClickCallback(datasetNumStr, bucketNum, valueStr, xLabelValues['c'+bucketNum], xLabelValues['c'+(bucketNum+1)], dataAttributes_['r'+datasetNumStr+'c'+bucketNum]);
        }
        else if (isLine(id))
        {
          var x = evt.getClientX();
          var y = evt.getClientY();
          var pt = findLineXY(targetObj, x, y);
          if (pt != null)
          {
            bucketNum = xToBucketNum(pt[0]);
            valueStr = lineValues['r'+datasetNumStr+'c'+bucketNum];
            dispatchClickCallback(datasetNumStr, new String(bucketNum), valueStr, xLabelValues['c'+bucketNum], xLabelValues['c'+(bucketNum+1)], dataAttributes_['r'+datasetNumStr+'c'+bucketNum]);
          }
        }
      }

<xsl:if test="$debug">
      // entry function for development debug
      function debug ()
      {
        alert("debug function");
        //showYScrollableElements();
      }
</xsl:if>

      </script>

    </svg>
  </xsl:template>

  <!-- make the chart background - alternating stripes whose horizontal edges align with the y axis labels -->
  <xsl:template name="i2:make_chart_bg">
    <xsl:param name="index"/>
    <xsl:param name="countUpIndex"/>
    <xsl:param name="width"/>
    <xsl:param name="stripe_height"/>
    <xsl:param name="initial_x"/>
    <xsl:param name="initial_y"/>

    <xsl:choose>
      <xsl:when test="$index mod 2">
        <rect>
          <xsl:attribute name="class">ChartBox</xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$stripe_height"/></xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$initial_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$initial_y + $countUpIndex * $stripe_height"/></xsl:attribute>
        </rect>
      </xsl:when>
      <xsl:otherwise>
        <rect>
          <xsl:attribute name="class">ChartBoxAlt</xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$stripe_height"/></xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$initial_x"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$initial_y + $countUpIndex * $stripe_height"/></xsl:attribute>
        </rect>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="$index > 0">
      <xsl:call-template name="i2:make_chart_bg">
        <xsl:with-param name="index" select="$index - 1"/>
        <xsl:with-param name="countUpIndex" select="$countUpIndex + 1"/>
        <xsl:with-param name="width" select="$width"/>
        <xsl:with-param name="stripe_height" select="$stripe_height"/>
        <xsl:with-param name="initial_x" select="$initial_x"/>
        <xsl:with-param name="initial_y" select="$initial_y"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- create the label portion of the y axis -->
  <xsl:template name="i2:make_yaxis_labels">
    <xsl:param name="index"/>
    <xsl:param name="countUpIndex"/>
    <xsl:param name="ylabels_width"/>
    <xsl:param name="ylabels_height"/>
    <xsl:param name="ylabelsTextOffsetY"/>
    <xsl:param name="stepSize"/>
    <xsl:param name="yaxis_x"/>
    <xsl:param name="initial_y"/>
    <xsl:param name="locale"/>
    <xsl:param name="numYDecimalDigits"/>
    <xsl:param name="offset_y"/>

    <rect>
      <xsl:attribute name="width"><xsl:value-of select="$ylabels_width"/></xsl:attribute>
      <xsl:attribute name="height"><xsl:value-of select="$ylabels_height"/></xsl:attribute>
      <xsl:attribute name="class">AxisLabelBox</xsl:attribute>
      <xsl:attribute name="x"><xsl:value-of select="$yaxis_x"/></xsl:attribute>
      <xsl:attribute name="y"><xsl:value-of select="$initial_y + $countUpIndex * $ylabels_height"/></xsl:attribute>
    </rect>
    <text>
      <xsl:attribute name="class">YAxisLabelText</xsl:attribute>
      <xsl:attribute name="x"><xsl:value-of select="$yaxis_x + $ylabels_width - $margin"/></xsl:attribute>
      <xsl:attribute name="y"><xsl:value-of select="$initial_y + $countUpIndex * $ylabels_height + $ylabelsTextOffsetY"/></xsl:attribute>

      <xsl:choose>
        <!-- we have to use the extension function to format numbers -->
        <xsl:when test="function-available('ExtXt:formatNumber')">
          <xsl:value-of select="translate(ExtXt:formatNumber($offset_y + $stepSize * $index, '', true(), number($numYDecimalDigits)), '&#xa0;', ' ')"/>
        </xsl:when>
        <xsl:when test="function-available('ExtXalan:formatNumber')">
          <xsl:value-of select="translate(ExtXalan:formatNumber($offset_y + $stepSize * $index, '', true(), number($numYDecimalDigits)), '&#xa0;', ' ')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="ceiling($offset_y + $stepSize * $index)"/>
        </xsl:otherwise>
      </xsl:choose>
    </text>

    <xsl:if test="$index > 0">
      <xsl:call-template name="i2:make_yaxis_labels">
        <xsl:with-param name="index" select="$index - 1"/>
        <xsl:with-param name="countUpIndex" select="$countUpIndex + 1"/>
        <xsl:with-param name="ylabels_width" select="$ylabels_width"/>
        <xsl:with-param name="ylabels_height" select="$ylabels_height"/>
        <xsl:with-param name="ylabelsTextOffsetY" select="$ylabelsTextOffsetY"/>
        <xsl:with-param name="stepSize" select="$stepSize"/>
        <xsl:with-param name="yaxis_x" select="$yaxis_x"/>
        <xsl:with-param name="initial_y" select="$initial_y"/>
        <xsl:with-param name="locale" select="$locale"/>
        <xsl:with-param name="numYDecimalDigits" select="$numYDecimalDigits"/>
        <xsl:with-param name="offset_y" select="$offset_y"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Create the secondary x axis bounding rects so that they span multiple primary labels when
       a secondary label is blank. We have to use recursive iteration to calculate and save the
       span value.
  -->
  <xsl:template name="make_secondary_xaxis_rects">
    <xsl:param name="xlabels_width"/>
    <xsl:param name="xlabels2_height"/>
    <xsl:param name="xoffset"/>
    <xsl:param name="y"/>
    <xsl:param name="xlabels_count"/>
    <xsl:param name="labels"/>
    <xsl:param name="position"/>
    <xsl:param name="span"/>

    <xsl:choose>
      <xsl:when test="$position &lt;= $xlabels_count">
        <xsl:variable name="xlabel2" select="$labels[$position]"/>

        <xsl:choose>
          <xsl:when test="$xlabel2 != ''">
            <xsl:if test="$position != 1">
              <!-- draw the previous rect -->
              <rect>
                <xsl:attribute name="class">AxisLabelBox</xsl:attribute>
                <xsl:attribute name="width"><xsl:value-of select="$xlabels_width * $span"/></xsl:attribute>
                <xsl:attribute name="height"><xsl:value-of select="$xlabels2_height"/></xsl:attribute>
                <xsl:attribute name="x"><xsl:value-of select="$xoffset + (($position - $span - 1) * $xlabels_width)"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="$y"/></xsl:attribute>
              </rect>
            </xsl:if>

            <!-- recursively iterate, resetting the span value -->
            <xsl:call-template name="make_secondary_xaxis_rects">
              <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
              <xsl:with-param name="xlabels2_height" select="$xlabels2_height"/>
              <xsl:with-param name="xoffset" select="$xoffset"/>
              <xsl:with-param name="y" select="$y"/>
              <xsl:with-param name="xlabels_count" select="$xlabels_count"/>
              <xsl:with-param name="labels" select="$labels"/>
              <xsl:with-param name="position" select="$position + 1"/>
              <xsl:with-param name="span">1</xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <!-- recursively iterate, incrementing the span value -->
            <xsl:call-template name="make_secondary_xaxis_rects">
              <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
              <xsl:with-param name="xlabels2_height" select="$xlabels2_height"/>
              <xsl:with-param name="xoffset" select="$xoffset"/>
              <xsl:with-param name="y" select="$y"/>
              <xsl:with-param name="xlabels_count" select="$xlabels_count"/>
              <xsl:with-param name="labels" select="$labels"/>
              <xsl:with-param name="position" select="$position + 1"/>
              <xsl:with-param name="span" select="$span + 1"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- draw the final rect -->
        <rect>
          <xsl:attribute name="class">AxisLabelBox</xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="$xlabels_width * $span"/></xsl:attribute>
          <xsl:attribute name="height"><xsl:value-of select="$xlabels2_height"/></xsl:attribute>
          <xsl:attribute name="x"><xsl:value-of select="$xoffset + (($position - $span - 1) * $xlabels_width)"/></xsl:attribute>
          <xsl:attribute name="y"><xsl:value-of select="$y"/></xsl:attribute>
        </rect>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- count the number of 'b' characters in the renderTypes string up to the lim index -->
  <xsl:template name="i2:calcInsetIndex">
    <xsl:param name="acc"/>
    <xsl:param name="idx"/>
    <xsl:param name="lim"/>
    <xsl:param name="renderTypes"/>

    <!-- // count the number of 'b' characters in the renderTypes string up to the lim index -->
    <!-- int calcInsetIndex(int acc, int idx, int lim, String renderTypes) -->
    <!-- { -->
    <!--   if (idx <= lim) -->
    <!--   { -->
    <!--     if (renderTypes[idx] == 'b') -->
    <!--     { -->
    <!--       calcInsetIndex(acc++, idx++, lim, renderTypes); -->
    <!--     } -->
    <!--     else -->
    <!--     { -->
    <!--       calcInsetIndex(acc, idx++, lim, renderTypes); -->
    <!--     } -->
    <!--   } -->
    <!--   else -->
    <!--   { -->
    <!--     return acc; -->
    <!--   } -->
    <!-- } -->

    <xsl:choose>
      <xsl:when test="$idx &lt;= $lim">
        <xsl:choose>
          <xsl:when test="substring($renderTypes,$idx,1) = 'b'">
            <xsl:call-template name="i2:calcInsetIndex">
              <xsl:with-param name="acc"><xsl:value-of select="$acc + 1"/></xsl:with-param>
              <xsl:with-param name="idx"><xsl:value-of select="$idx + 1"/></xsl:with-param>
              <xsl:with-param name="lim" select="$lim"/>
              <xsl:with-param name="renderTypes" select="$renderTypes"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="i2:calcInsetIndex">
              <xsl:with-param name="acc" select="$acc"/>
              <xsl:with-param name="idx"><xsl:value-of select="$idx + 1"/></xsl:with-param>
              <xsl:with-param name="lim" select="$lim"/>
              <xsl:with-param name="renderTypes" select="$renderTypes"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$acc"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- render a dataset -->
  <xsl:template name="i2:renderDataset">
    <xsl:param name="datasetNum"/>
    <xsl:param name="renderTypes"/>
    <xsl:param name="dataset"/>
    <xsl:param name="colorscheme"/>
    <xsl:param name="bar_width"/>
    <xsl:param name="override_bar_widths"/>
    <xsl:param name="override_opacities"/>
    <xsl:param name="initial_x"/>
    <xsl:param name="initial_y"/>
    <xsl:param name="xScaleFactor"/>
    <xsl:param name="yScaleFactor"/>
    <xsl:param name="xlabels_width"/>
    <xsl:param name="insets"/>
    <xsl:param name="ratio"/>
    <xsl:param name="actions"/>
    <xsl:param name="xlabel_count"/>
    <xsl:param name="stacked"/>
    <xsl:param name="enableShowValue"/>
    <xsl:param name="enableDataAttrs"/>
    <xsl:param name="locale"/>
    <xsl:param name="offset_y"/>

    <xsl:variable name="override_opacity">
      <xsl:value-of select="substring($override_opacities,($datasetNum - 1) * 4 + 1,3)"/>
    </xsl:variable>

      <!-- capture the user data for use by the event handlers -->
      <xsl:if test="$enableDataAttrs = 'true'">
        <script language="JavaScript">
          <!-- put the attribute text in a CDATA block to protect special characters in the output svg stream -->
          &lt;![CDATA[
          <xsl:for-each select="$dataset">
            dataAttributes_['r<xsl:value-of select="$datasetNum"/>c<xsl:value-of select="position()"/>'] =
            <xsl:for-each select="attribute::*">'<xsl:value-of select="name()"/>="<xsl:value-of select="."/>"' + ' ' + </xsl:for-each>'';
          </xsl:for-each>
          ]]&gt;
        </script>
      </xsl:if>

      <xsl:variable name="renderType"><xsl:value-of select="substring($renderTypes,$datasetNum,1)"/></xsl:variable>
      <xsl:choose>
        <xsl:when test="$renderType = 'b'">

        <xsl:variable name="insetIndexVal">
          <xsl:call-template name="i2:calcInsetIndex">
            <xsl:with-param name="acc" select="0"/>
            <xsl:with-param name="idx" select="1"/>
            <xsl:with-param name="lim" select="$datasetNum"/>
            <xsl:with-param name="renderTypes" select="$renderTypes"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="override_barwidth">
          <xsl:value-of select="substring($override_bar_widths,($datasetNum - 1) * 4 + 1,3)"/>
        </xsl:variable>

        <xsl:variable name="barwidth">
          <xsl:choose>
            <xsl:when test="$override_barwidth = 'def'">
              <xsl:value-of select="$bar_width - (($bar_width div 10) * $xScaleFactor)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$override_barwidth - (($override_barwidth div 10) * $xScaleFactor)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:variable name="fill_opacity">
          <xsl:choose>
            <xsl:when test="$override_opacity = 'def'">1</xsl:when>
            <xsl:otherwise><xsl:value-of select="$override_opacity"/></xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:for-each select="$dataset">
          <xsl:variable name="valu"><xsl:call-template name="normalizeDatum">
              <xsl:with-param name="datum" select="."/>
              <xsl:with-param name="locale" select="$locale"/>
            </xsl:call-template></xsl:variable>
          <xsl:if test="$valu >= $offset_y">
            <xsl:call-template name="i2:make_bar">
              <xsl:with-param name="valu" select="$valu"/>
              <xsl:with-param name="index" select="$datasetNum"/>
              <xsl:with-param name="colorscheme" select="$colorscheme"/>
              <xsl:with-param name="bar_width" select="$barwidth"/>
              <xsl:with-param name="initial_x" select="$initial_x"/>
              <xsl:with-param name="initial_y" select="$initial_y"/>
              <xsl:with-param name="yScaleFactor" select="$yScaleFactor"/>
              <xsl:with-param name="xlabels_width" select="$xlabels_width"/>
              <xsl:with-param name="offset" select="substring($insets,($insetIndexVal - 1) * 4 + 1,3)"/>
              <xsl:with-param name="barBorderColor" select="$barBorderColor"/>
              <xsl:with-param name="fillOpacity" select="$fill_opacity"/>
              <xsl:with-param name="ratio" select="$ratio"/>
              <xsl:with-param name="index2" select="position()"/>
              <xsl:with-param name="actions" select="$actions"/>
              <xsl:with-param name="stacked" select="$stacked"/>
              <xsl:with-param name="enableShowValue" select="$enableShowValue"/>
              <xsl:with-param name="offset_y" select="$offset_y"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:for-each>

      </xsl:when>
      <xsl:when test="$renderType = 'l' or $renderType = 'a'">
          <!-- used by areas only -->
          <xsl:variable name="fill_opacity">
            <xsl:choose>
              <xsl:when test="$override_opacity = 'def'">.25</xsl:when>
              <xsl:otherwise><xsl:value-of select="$override_opacity"/></xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="yoff"><xsl:value-of select="ceiling($offset_y * $ratio)"/></xsl:variable>

          <polyline onmousemove="doOnMouseMove(evt)" onmouseout="doOnMouseOut(evt)">
            <xsl:if test="$renderType = 'l'">
              <xsl:attribute name="style">fill-opacity:0;stroke-width:3;stroke-opacity:1</xsl:attribute>
            </xsl:if>
            <xsl:if test="$renderType = 'a'">
              <xsl:attribute name="style">fill-opacity:<xsl:value-of select="$fill_opacity"/>;stroke-width:3;stroke-opacity:1</xsl:attribute>
            </xsl:if>

            <xsl:if test="substring($actions,$datasetNum,1) = 'd'">
              <xsl:attribute name="drag">yes</xsl:attribute>
            </xsl:if>
            <xsl:if test="substring($actions,$datasetNum,1) = 'c'">
              <xsl:attribute name="onclick">doOnClick(evt)</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="showValue"><xsl:value-of select="$enableShowValue"/></xsl:attribute>
            <xsl:attribute name="datasetNum"><xsl:value-of select="$datasetNum"/></xsl:attribute>
            <xsl:attribute name="id">line<xsl:value-of select="$datasetNum"/></xsl:attribute>
            <xsl:attribute name="class">ColorFront<xsl:value-of select="substring($colorscheme,$datasetNum,1)"/></xsl:attribute>
            <xsl:attribute name="points">
              <xsl:if test="$renderType = 'a'">
                <xsl:value-of select="$initial_x"/>,<xsl:value-of select="$initial_y - $yoff"/><xsl:text> </xsl:text>
              </xsl:if>
              <xsl:for-each select="$dataset">
                <xsl:variable name="valu"><xsl:call-template name="normalizeDatum">
                    <xsl:with-param name="datum" select="."/>
                    <xsl:with-param name="locale" select="$locale"/>
                  </xsl:call-template></xsl:variable>
                <xsl:variable name="index2" select="position()"/>
                <xsl:if test="$valu >= $offset_y">
                  <xsl:value-of select="$initial_x+(($index2 - 1)*$xlabels_width)+($xlabels_width div 2)"/>,<xsl:value-of select="$initial_y - ceiling( ( $valu - $offset_y ) * $ratio)"/><xsl:text> </xsl:text>
                </xsl:if>
              </xsl:for-each>
              <xsl:if test="$renderType = 'a'">
                <xsl:value-of select="$initial_x+($xlabel_count*$xlabels_width)"/>,<xsl:value-of select="$initial_y - $yoff"/><xsl:text> </xsl:text>
                <xsl:value-of select="$initial_x"/>,<xsl:value-of select="$initial_y - $yoff"/>
              </xsl:if>
            </xsl:attribute>
          </polyline>

        <!-- capture the values for use by the event handlers -->
        <script language="JavaScript">
          <xsl:for-each select="$dataset">
            <xsl:variable name="valu"><xsl:call-template name="normalizeDatum">
                <xsl:with-param name="datum" select="."/>
                <xsl:with-param name="locale" select="$locale"/>
              </xsl:call-template></xsl:variable>
          lineValues['r<xsl:value-of select="$datasetNum"/>c<xsl:value-of select="position()"/>'] = '<xsl:value-of select="$valu"/>';
          </xsl:for-each>
        </script>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- emit the rect tag and attributes that render a bar -->
  <xsl:template name="i2:make_bar">
    <xsl:param name="valu"/>
    <xsl:param name="index"/>
    <xsl:param name="colorscheme"/>
    <xsl:param name="bar_width"/>
    <xsl:param name="initial_x"/>
    <xsl:param name="initial_y"/>
    <xsl:param name="yScaleFactor"/>
    <xsl:param name="xlabels_width"/>
    <xsl:param name="offset"/>
    <xsl:param name="barBorderColor"/>
    <xsl:param name="fillOpacity"/>
    <xsl:param name="ratio"/>
    <xsl:param name="index2"/>
    <xsl:param name="actions"/>
    <xsl:param name="stacked"/>
    <xsl:param name="enableShowValue"/>
    <xsl:param name="offset_y"/>

       <xsl:variable name="yval"><xsl:value-of select="ceiling($valu * $ratio)"/></xsl:variable>
       <xsl:variable name="yoff"><xsl:value-of select="ceiling($offset_y * $ratio)"/></xsl:variable>

       <rect onmousemove="doOnMouseMove(evt)" onmouseout="doOnMouseOut(evt)">
        <!-- dragging is enabled for non-stacked bars only -->
        <xsl:if test="substring($actions,$index,1) = 'd' and ($stacked = 0 or $index &lt; $stacked)">
          <xsl:attribute name="drag">yes</xsl:attribute>
        </xsl:if>
        <xsl:if test="substring($actions,$index,1) = 'c'">
          <xsl:attribute name="onclick">doOnClick(evt)</xsl:attribute>
        </xsl:if>
        <xsl:attribute name="showValue"><xsl:value-of select="$enableShowValue"/></xsl:attribute>
        <xsl:attribute name="id">barr<xsl:value-of select="$index"/>c<xsl:value-of select="$index2"/></xsl:attribute>
        <xsl:attribute name="class">ColorFront<xsl:value-of select="substring($colorscheme,$index,1)"/></xsl:attribute>
        <xsl:attribute name="datasetNum"><xsl:value-of select="$index"/></xsl:attribute>
        <xsl:attribute name="bucketNum"><xsl:value-of select="$index2"/></xsl:attribute>
        <xsl:attribute name="value"><xsl:value-of select="$valu"/></xsl:attribute>
        <!-- render the stacked bars invisibly and on the x axis; they'll be moved and made visible in the
             post-render processing -->
        <xsl:choose>
          <xsl:when test="$stacked = 0 or $index &lt; $stacked">
            <xsl:attribute name="style">stroke:<xsl:value-of select="$barBorderColor"/>;stroke-width:1;stroke-opacity:1;fill-opacity:<xsl:value-of select="$fillOpacity"/></xsl:attribute>
            <!--<xsl:attribute name="style">stroke:<xsl:value-of select="$barBorderColor"/>;stroke-width:0;stroke-opacity:0;fill-opacity:<xsl:value-of select="$fillOpacity"/></xsl:attribute>-->
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="style">visibility:hidden;stroke:<xsl:value-of select="$barBorderColor"/>;stroke-width:1;stroke-opacity:1;fill-opacity:<xsl:value-of select="$fillOpacity"/></xsl:attribute>
            <!--<xsl:attribute name="style">visibility:hidden;stroke:<xsl:value-of select="$barBorderColor"/>;stroke-width:0;stroke-opacity:0;fill-opacity:<xsl:value-of select="$fillOpacity"/></xsl:attribute>-->
          </xsl:otherwise>
        </xsl:choose>
        <xsl:attribute name="x"><xsl:value-of select="$initial_x+(($index2 - 1)*$xlabels_width) + $offset"/></xsl:attribute>
        <xsl:attribute name="width"><xsl:value-of select="$bar_width"/></xsl:attribute>
        <xsl:choose>
          <xsl:when test="$valu >= 0">
            <xsl:attribute name="y"><xsl:value-of select="$initial_y - $yval + $yoff"/></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="$yval"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="y"><xsl:value-of select="$initial_y + $yoff"/></xsl:attribute>
            <xsl:attribute name="height"><xsl:value-of select="-$yval"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </rect>

  </xsl:template>

  <!-- map the colorscheme selectors to their rgb values, emitting JavaScript substrings and concatenation operators -->
  <!-- note: only usable as part of a JavaScript expression -->
  <xsl:template name="i2:buildColorsStr">
    <xsl:param name="index"/>
    <xsl:param name="identifiers"/>
    <xsl:param name="colors"/>

    <xsl:if test="$index &lt; string-length($identifiers)">
      <xsl:variable name="identifier">
        <xsl:value-of select="substring($identifiers, $index + 1, 1)"/>
      </xsl:variable>
      <xsl:variable name="colorNum">
        <xsl:choose>
          <xsl:when test='$identifier = "a"'>0</xsl:when>
          <xsl:when test='$identifier = "b"'>1</xsl:when>
          <xsl:when test='$identifier = "c"'>2</xsl:when>
          <xsl:when test='$identifier = "d"'>3</xsl:when>
          <xsl:when test='$identifier = "e"'>4</xsl:when>
          <xsl:when test='$identifier = "f"'>5</xsl:when>
          <xsl:when test='$identifier = "g"'>6</xsl:when>
          <xsl:when test='$identifier = "h"'>7</xsl:when>
          <xsl:when test='$identifier = "i"'>8</xsl:when>
          <xsl:when test='$identifier = "j"'>9</xsl:when>
          <xsl:when test='$identifier = "k"'>10</xsl:when>
          <xsl:when test='$identifier = "l"'>11</xsl:when>
          <xsl:when test='$identifier = "m"'>12</xsl:when>
          <xsl:when test='$identifier = "n"'>13</xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="color">
        <xsl:value-of select="substring($colors, $colorNum * 8 + 1, 7)"/>
      </xsl:variable>

      '<xsl:value-of select="$color"/>,' +

      <xsl:call-template name="i2:buildColorsStr">
        <xsl:with-param name="index" select="$index + 1"/>
        <xsl:with-param name="identifiers" select="$identifiers"/>
        <xsl:with-param name="colors" select="$colors"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Generate the css styles used to color the chart -->
  <xsl:template name="i2:genColorStyles">
    <xsl:param name="index"/>
    <xsl:param name="identifiers"/>
    <xsl:param name="colors"/>

    <xsl:if test="$index &lt; string-length($identifiers)">
      <xsl:variable name="identifier">
        <xsl:value-of select="substring($identifiers, $index + 1, 1)"/>
      </xsl:variable>
      <xsl:variable name="color">
        <xsl:value-of select="substring($colors, $index * 8 + 1, 7)"/>
      </xsl:variable>

      .ColorFront<xsl:value-of select="$identifier"/> { fill:<xsl:value-of select="$color"/>; stroke:<xsl:value-of select="$color"/>; }

      <xsl:call-template name="i2:genColorStyles">
        <xsl:with-param name="index" select="$index + 1"/>
        <xsl:with-param name="identifiers" select="$identifiers"/>
        <xsl:with-param name="colors" select="$colors"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Callable templates for determining a particular maximum value from a collection of data sets. These were
       written to replace the XT extension functions.

       These templates assume the data sets are all the same length. These templates are based on an original
       version written by Larry Mason

       The original version works only with the following XSLT processors: Xalan, msxml, XT, or Saxon.

       Original verion: 08 feb 2002
         author: richard hargrove
  -->

  <!-- Output the larger of either the largest value in the datasets or the specified minimum maximum.

       This template is complicated by the XSLT 1.0 restriction that a result tree fragment cannot
       be implicitly converted to a nodeset. We have to make an explicit call to the XSLT
       processor's unique extension function to perform the conversion.
  -->
  <xsl:template name="nthmaxvalue">
    <xsl:param name="minmax">0</xsl:param>
    <xsl:param name="data1" select="/nullData"/>
    <xsl:param name="data2" select="/nullData"/>
    <xsl:param name="data3" select="/nullData"/>
    <xsl:param name="data4" select="/nullData"/>
    <xsl:param name="data5" select="/nullData"/>
    <xsl:param name="data6" select="/nullData"/>
    <xsl:param name="data7" select="/nullData"/>
    <xsl:param name="data8" select="/nullData"/>
    <xsl:param name="data9" select="/nullData"/>
    <xsl:param name="data10" select="/nullData"/>
    <xsl:param name="data11" select="/nullData"/>
    <xsl:param name="data12" select="/nullData"/>
    <xsl:param name="data13" select="/nullData"/>
    <xsl:param name="data14" select="/nullData"/>

    <!-- build a descending sorted list of values -->
    <xsl:variable name="sortedData">
      <xsl:for-each select="$data1|$data2|$data3|$data4|$data5|$data6|$data7|$data8|$data9|$data10|$data11|$data12|$data13|$data14">
        <xsl:sort order="descending" data-type="number"/>
        <xsl:copy-of select="."/>
      </xsl:for-each>
    </xsl:variable>

    <!-- build a list of unique values -->
    <xsl:variable name="uniqueSortedData">
      <xsl:choose>
        <xsl:when test="function-available('xalan:nodeset')">
          <xsl:for-each select="xalan:nodeset($sortedData)/*">
            <xsl:if test="not(following-sibling::*[1]=.)">
              <xsl:copy-of select="."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="function-available('msxml:node-set')">
          <xsl:for-each select="msxml:node-set($sortedData)/*">
            <xsl:if test="not(following-sibling::*[1]=.)">
              <xsl:copy-of select="."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="function-available('xt:node-set')">
          <xsl:for-each select="xt:node-set($sortedData)/*">
            <xsl:if test="not(following-sibling::*[1]=.)">
              <xsl:copy-of select="."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="function-available('saxon:node-set')">
          <xsl:for-each select="saxon:node-set($sortedData)/*">
            <xsl:if test="not(following-sibling::*[1]=.)">
              <xsl:copy-of select="."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <!-- find nth value of sorted values -->
    <xsl:variable name="retval">
      <xsl:choose>
        <xsl:when test="function-available('xalan:nodeset')">
          <xsl:value-of select="xalan:nodeset($uniqueSortedData)/*[1]"/>
        </xsl:when>
        <xsl:when test="function-available('msxml:node-set')">
          <xsl:value-of select="msxml:node-set($uniqueSortedData)/*[1]"/>
        </xsl:when>
        <xsl:when test="function-available('xt:node-set')">
          <xsl:value-of select="xt:node-set($uniqueSortedData)/*[1]"/>
        </xsl:when>
        <xsl:when test="function-available('saxon:node-set')">
          <xsl:value-of select="saxon:node-set($uniqueSortedData)/*[1]"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$retval &gt; $minmax"><xsl:value-of select="$retval"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$minmax"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Output the larger of either the largest value in the datasets or the specified minimum maximum
       after first coalescing the stacked data sets into a single data set.

       This template is complicated by the XSLT 1.0 restriction that a result tree fragment cannot
       be implicitly converted to a nodeset. We have to make an explicit call to the XSLT
       processor's unique extension function to perform the conversion.
  -->
  <xsl:template name="nthmaxstackedvalue">
    <xsl:param name="stackedval">0</xsl:param>
    <xsl:param name="rendertypes">bbbbbbbbbb</xsl:param>
    <xsl:param name="minmax">0</xsl:param>
    <xsl:param name="data1" select="/nullData"/>
    <xsl:param name="data2" select="/nullData"/>
    <xsl:param name="data3" select="/nullData"/>
    <xsl:param name="data4" select="/nullData"/>
    <xsl:param name="data5" select="/nullData"/>
    <xsl:param name="data6" select="/nullData"/>
    <xsl:param name="data7" select="/nullData"/>
    <xsl:param name="data8" select="/nullData"/>
    <xsl:param name="data9" select="/nullData"/>
    <xsl:param name="data10" select="/nullData"/>
    <xsl:param name="data11" select="/nullData"/>
    <xsl:param name="data12" select="/nullData"/>
    <xsl:param name="data13" select="/nullData"/>
    <xsl:param name="data14" select="/nullData"/>

    <xsl:choose>
      <xsl:when test="$stackedval = 0">
        <xsl:call-template name="nthmaxvalue">
          <xsl:with-param name="minmax" select="$minmax"/>
          <xsl:with-param name="data1" select="$data1"/>
          <xsl:with-param name="data2" select="$data2"/>
          <xsl:with-param name="data3" select="$data3"/>
          <xsl:with-param name="data4" select="$data4"/>
          <xsl:with-param name="data5" select="$data5"/>
          <xsl:with-param name="data6" select="$data6"/>
          <xsl:with-param name="data7" select="$data7"/>
          <xsl:with-param name="data8" select="$data8"/>
          <xsl:with-param name="data9" select="$data9"/>
          <xsl:with-param name="data10" select="$data10"/>
          <xsl:with-param name="data11" select="$data11"/>
          <xsl:with-param name="data12" select="$data12"/>
          <xsl:with-param name="data13" select="$data13"/>
          <xsl:with-param name="data14" select="$data14"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <!-- isolate the standalone data sets -->
        <xsl:variable name="standalone1">
          <xsl:if test="substring($rendertypes,1,1) != 'b' or 1 &lt; $stackedval">
            <xsl:copy-of select="$data1"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone2">
          <xsl:if test="substring($rendertypes,2,1) != 'b' or 2 &lt; $stackedval">
            <xsl:copy-of select="$data2"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone3">
          <xsl:if test="substring($rendertypes,3,1) != 'b' or 3 &lt; $stackedval">
            <xsl:copy-of select="$data3"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone4">
          <xsl:if test="substring($rendertypes,4,1) != 'b' or 4 &lt; $stackedval">
            <xsl:copy-of select="$data4"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone5">
          <xsl:if test="substring($rendertypes,5,1) != 'b' or 5 &lt; $stackedval">
            <xsl:copy-of select="$data5"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone6">
          <xsl:if test="substring($rendertypes,6,1) != 'b' or 6 &lt; $stackedval">
            <xsl:copy-of select="$data6"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone7">
          <xsl:if test="substring($rendertypes,7,1) != 'b' or 7 &lt; $stackedval">
            <xsl:copy-of select="$data7"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone8">
          <xsl:if test="substring($rendertypes,8,1) != 'b' or 8 &lt; $stackedval">
            <xsl:copy-of select="$data8"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone9">
          <xsl:if test="substring($rendertypes,9,1) != 'b' or 9 &lt; $stackedval">
            <xsl:copy-of select="$data9"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone10">
          <xsl:if test="substring($rendertypes,10,1) != 'b' or 10 &lt; $stackedval">
            <xsl:copy-of select="$data10"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone11">
          <xsl:if test="substring($rendertypes,11,1) != 'b' or 11 &lt; $stackedval">
            <xsl:copy-of select="$data11"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone12">
          <xsl:if test="substring($rendertypes,12,1) != 'b' or 12 &lt; $stackedval">
            <xsl:copy-of select="$data12"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone13">
          <xsl:if test="substring($rendertypes,13,1) != 'b' or 13 &lt; $stackedval">
            <xsl:copy-of select="$data13"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone14">
          <xsl:if test="substring($rendertypes,14,1) != 'b' or 14 &lt; $stackedval">
            <xsl:copy-of select="$data14"/>
          </xsl:if>
        </xsl:variable>

        <!-- coalesce the stacked data into a single tree of summed values -->
        <xsl:variable name="stackedData">
          <xsl:for-each select="$data1">
            <xsl:variable name="at" select="position()"/>
            <xsl:element name="stackedsum">
              <xsl:call-template name="addstackedvalues">
                <xsl:with-param name="stackedval" select="$stackedval"/>
                <xsl:with-param name="rendertypes" select="$rendertypes"/>
                <xsl:with-param name="datum1" select="$data1[$at]"/>
                <xsl:with-param name="datum2" select="$data2[$at]"/>
                <xsl:with-param name="datum3" select="$data3[$at]"/>
                <xsl:with-param name="datum4" select="$data4[$at]"/>
                <xsl:with-param name="datum5" select="$data5[$at]"/>
                <xsl:with-param name="datum6" select="$data6[$at]"/>
                <xsl:with-param name="datum7" select="$data7[$at]"/>
                <xsl:with-param name="datum8" select="$data8[$at]"/>
                <xsl:with-param name="datum9" select="$data9[$at]"/>
                <xsl:with-param name="datum10" select="$data10[$at]"/>
                <xsl:with-param name="datum11" select="$data11[$at]"/>
                <xsl:with-param name="datum12" select="$data12[$at]"/>
                <xsl:with-param name="datum13" select="$data13[$at]"/>
                <xsl:with-param name="datum14" select="$data14[$at]"/>
              </xsl:call-template>
            </xsl:element>
          </xsl:for-each>
        </xsl:variable>

<!--
<xsl:text>
stackedData = </xsl:text>
<xsl:call-template name="nodesetToList">
  <xsl:with-param name="nodeset" select="xalan:nodeset($stackedData)/*"/>
</xsl:call-template>
<xsl:text>
</xsl:text>
-->

        <!-- build a descending sorted list of summed stacked and standalone values -->
        <xsl:variable name="sortedData">
          <xsl:choose>
            <xsl:when test="function-available('xalan:nodeset')">
              <xsl:for-each select="xalan:nodeset($stackedData)/*|xalan:nodeset($standalone1)/*|xalan:nodeset($standalone2)/*|xalan:nodeset($standalone3)/*|xalan:nodeset($standalone4)/*|xalan:nodeset($standalone5)/*|xalan:nodeset($standalone6)/*|xalan:nodeset($standalone7)/*|xalan:nodeset($standalone8)/*|xalan:nodeset($standalone9)/*|xalan:nodeset($standalone10)/*|xalan:nodeset($standalone11)/*|xalan:nodeset($standalone12)/*|xalan:nodeset($standalone13)/*|xalan:nodeset($standalone14)/*">
                <xsl:sort order="descending" data-type="number"/>
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="function-available('msxml:node-set')">
              <xsl:for-each select="msxml:node-set($stackedData)/*|msxml:node-set($standalone1)/*|msxml:node-set($standalone2)/*|msxml:node-set($standalone3)/*|msxml:node-set($standalone4)/*|msxml:node-set($standalone5)/*|msxml:node-set($standalone6)/*|msxml:node-set($standalone7)/*|msxml:node-set($standalone8)/*|msxml:node-set($standalone9)/*|msxml:node-set($standalone10)/*|msxml:node-set($standalone11)/*|msxml:node-set($standalone12)/*|msxml:node-set($standalone13)/*|msxml:node-set($standalone14)/*">
                <xsl:sort order="descending" data-type="number"/>
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="function-available('xt:node-set')">
              <xsl:for-each select="xt:node-set($stackedData)/*|xt:node-set($standalone1)/*|xt:node-set($standalone2)/*|xt:node-set($standalone3)/*|xt:node-set($standalone4)/*|xt:node-set($standalone5)/*|xt:node-set($standalone6)/*|xt:node-set($standalone7)/*|xt:node-set($standalone8)/*|xt:node-set($standalone9)/*|xt:node-set($standalone10)/*|xt:node-set($standalone11)/*|xt:node-set($standalone12)/*|xt:node-set($standalone13)/*|xt:node-set($standalone14)/*">
                <xsl:sort order="descending" data-type="number"/>
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="function-available('saxon:node-set')">
              <xsl:for-each select="saxon:node-set($stackedData)/*|saxon:node-set($standalone1)/*|saxon:node-set($standalone2)/*|saxon:node-set($standalone3)/*|saxon:node-set($standalone4)/*|saxon:node-set($standalone5)/*|saxon:node-set($standalone6)/*|saxon:node-set($standalone7)/*|saxon:node-set($standalone8)/*|saxon:node-set($standalone9)/*|saxon:node-set($standalone10)/*|saxon:node-set($standalone11)/*|saxon:node-set($standalone12)/*|saxon:node-set($standalone13)/*|saxon:node-set($standalone14)/*">
                <xsl:sort order="descending" data-type="number"/>
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>

<!--
<xsl:text>
sortedData = </xsl:text>
<xsl:call-template name="nodesetToList">
  <xsl:with-param name="nodeset" select="xalan:nodeset($sortedData)/*"/>
</xsl:call-template>
<xsl:text>
</xsl:text>
-->

        <!-- build a list of unique values from the sorted values-->
        <xsl:variable name="uniqueSortedData">
          <xsl:choose>
            <xsl:when test="function-available('xalan:nodeset')">
              <xsl:for-each select="xalan:nodeset($sortedData)/*">
                <xsl:if test="not(following-sibling::*[1]=.)">
                  <xsl:copy-of select="."/>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="function-available('msxml:node-set')">
              <xsl:for-each select="msxml:node-set($sortedData)/*">
                <xsl:if test="not(following-sibling::*[1]=.)">
                  <xsl:copy-of select="."/>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="function-available('xt:node-set')">
              <xsl:for-each select="xt:node-set($sortedData)/*">
                <xsl:if test="not(following-sibling::*[1]=.)">
                  <xsl:copy-of select="."/>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="function-available('saxon:node-set')">
              <xsl:for-each select="saxon:node-set($sortedData)/*">
                <xsl:if test="not(following-sibling::*[1]=.)">
                  <xsl:copy-of select="."/>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>

<!--
<xsl:text>
uniqueSortedData = </xsl:text>
<xsl:call-template name="nodesetToList">
  <xsl:with-param name="nodeset" select="xalan:nodeset($uniqueSortedData)/*"/>
</xsl:call-template>
<xsl:text>
</xsl:text>
-->

<!--
<xsl:text>
retval = </xsl:text>
<xsl:call-template name="nodesetToList">
  <xsl:with-param name="nodeset" select="xalan:nodeset($uniqueSortedData)/*[1]"/>
</xsl:call-template>
<xsl:text>
</xsl:text>
<xsl:text>
</xsl:text>
-->

        <!-- find nth value of the sorted unique values -->
        <xsl:variable name="retval">
          <xsl:choose>
            <xsl:when test="function-available('xalan:nodeset')">
              <xsl:value-of select="xalan:nodeset($uniqueSortedData)/*[1]"/>
            </xsl:when>
            <xsl:when test="function-available('msxml:node-set')">
              <xsl:value-of select="msxml:node-set($uniqueSortedData)/*[1]"/>
            </xsl:when>
            <xsl:when test="function-available('xt:node-set')">
              <xsl:value-of select="xt:node-set($uniqueSortedData)/*[1]"/>
            </xsl:when>
            <xsl:when test="function-available('saxon:node-set')">
              <xsl:value-of select="saxon:node-set($uniqueSortedData)/*[1]"/>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>

        <xsl:choose>
          <xsl:when test="$retval &gt; $minmax"><xsl:value-of select="$retval"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="$minmax"/></xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Rauli added begin - negatives -->
  <xsl:template name="nthminvalue">
    <xsl:param name="minmax">0</xsl:param>
    <xsl:param name="data1" select="/nullData"/>
    <xsl:param name="data2" select="/nullData"/>
    <xsl:param name="data3" select="/nullData"/>
    <xsl:param name="data4" select="/nullData"/>
    <xsl:param name="data5" select="/nullData"/>
    <xsl:param name="data6" select="/nullData"/>
    <xsl:param name="data7" select="/nullData"/>
    <xsl:param name="data8" select="/nullData"/>
    <xsl:param name="data9" select="/nullData"/>
    <xsl:param name="data10" select="/nullData"/>
    <xsl:param name="data11" select="/nullData"/>
    <xsl:param name="data12" select="/nullData"/>
    <xsl:param name="data13" select="/nullData"/>
    <xsl:param name="data14" select="/nullData"/>

    <!-- build a descending sorted list of values -->
    <xsl:variable name="sortedData">
      <xsl:for-each select="$data1|$data2|$data3|$data4|$data5|$data6|$data7|$data8|$data9|$data10|$data11|$data12|$data13|$data14">
        <xsl:sort order="ascending" data-type="number"/>
        <xsl:copy-of select="."/>
      </xsl:for-each>
    </xsl:variable>

    <!-- build a list of unique values -->
    <xsl:variable name="uniqueSortedData">
      <xsl:choose>
        <xsl:when test="function-available('xalan:nodeset')">
          <xsl:for-each select="xalan:nodeset($sortedData)/*">
            <xsl:if test="not(following-sibling::*[1]=.)">
              <xsl:copy-of select="."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="function-available('msxml:node-set')">
          <xsl:for-each select="msxml:node-set($sortedData)/*">
            <xsl:if test="not(following-sibling::*[1]=.)">
              <xsl:copy-of select="."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="function-available('xt:node-set')">
          <xsl:for-each select="xt:node-set($sortedData)/*">
            <xsl:if test="not(following-sibling::*[1]=.)">
              <xsl:copy-of select="."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="function-available('saxon:node-set')">
          <xsl:for-each select="saxon:node-set($sortedData)/*">
            <xsl:if test="not(following-sibling::*[1]=.)">
              <xsl:copy-of select="."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <!-- find nth value of sorted values -->
    <xsl:variable name="retval">
      <xsl:choose>
        <xsl:when test="function-available('xalan:nodeset')">
          <xsl:value-of select="xalan:nodeset($uniqueSortedData)/*[1]"/>
        </xsl:when>
        <xsl:when test="function-available('msxml:node-set')">
          <xsl:value-of select="msxml:node-set($uniqueSortedData)/*[1]"/>
        </xsl:when>
        <xsl:when test="function-available('xt:node-set')">
          <xsl:value-of select="xt:node-set($uniqueSortedData)/*[1]"/>
        </xsl:when>
        <xsl:when test="function-available('saxon:node-set')">
          <xsl:value-of select="saxon:node-set($uniqueSortedData)/*[1]"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$retval &lt; $minmax"><xsl:value-of select="$retval"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$minmax"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="nthminstackedvalue">
    <xsl:param name="stackedval">0</xsl:param>
    <xsl:param name="rendertypes">bbbbbbbbbb</xsl:param>
    <xsl:param name="minmax">0</xsl:param>
    <xsl:param name="data1" select="/nullData"/>
    <xsl:param name="data2" select="/nullData"/>
    <xsl:param name="data3" select="/nullData"/>
    <xsl:param name="data4" select="/nullData"/>
    <xsl:param name="data5" select="/nullData"/>
    <xsl:param name="data6" select="/nullData"/>
    <xsl:param name="data7" select="/nullData"/>
    <xsl:param name="data8" select="/nullData"/>
    <xsl:param name="data9" select="/nullData"/>
    <xsl:param name="data10" select="/nullData"/>
    <xsl:param name="data11" select="/nullData"/>
    <xsl:param name="data12" select="/nullData"/>
    <xsl:param name="data13" select="/nullData"/>
    <xsl:param name="data14" select="/nullData"/>

    <xsl:choose>
      <xsl:when test="$stackedval = 0">
        <xsl:call-template name="nthminvalue">
          <xsl:with-param name="minmax" select="$minmax"/>
          <xsl:with-param name="data1" select="$data1"/>
          <xsl:with-param name="data2" select="$data2"/>
          <xsl:with-param name="data3" select="$data3"/>
          <xsl:with-param name="data4" select="$data4"/>
          <xsl:with-param name="data5" select="$data5"/>
          <xsl:with-param name="data6" select="$data6"/>
          <xsl:with-param name="data7" select="$data7"/>
          <xsl:with-param name="data8" select="$data8"/>
          <xsl:with-param name="data9" select="$data9"/>
          <xsl:with-param name="data10" select="$data10"/>
          <xsl:with-param name="data11" select="$data11"/>
          <xsl:with-param name="data12" select="$data12"/>
          <xsl:with-param name="data13" select="$data13"/>
          <xsl:with-param name="data14" select="$data14"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <!-- isolate the standalone data sets -->
        <xsl:variable name="standalone1">
          <xsl:if test="substring($rendertypes,1,1) != 'b' or 1 &lt; $stackedval">
            <xsl:copy-of select="$data1"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone2">
          <xsl:if test="substring($rendertypes,2,1) != 'b' or 2 &lt; $stackedval">
            <xsl:copy-of select="$data2"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone3">
          <xsl:if test="substring($rendertypes,3,1) != 'b' or 3 &lt; $stackedval">
            <xsl:copy-of select="$data3"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone4">
          <xsl:if test="substring($rendertypes,4,1) != 'b' or 4 &lt; $stackedval">
            <xsl:copy-of select="$data4"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone5">
          <xsl:if test="substring($rendertypes,5,1) != 'b' or 5 &lt; $stackedval">
            <xsl:copy-of select="$data5"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone6">
          <xsl:if test="substring($rendertypes,6,1) != 'b' or 6 &lt; $stackedval">
            <xsl:copy-of select="$data6"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone7">
          <xsl:if test="substring($rendertypes,7,1) != 'b' or 7 &lt; $stackedval">
            <xsl:copy-of select="$data7"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone8">
          <xsl:if test="substring($rendertypes,8,1) != 'b' or 8 &lt; $stackedval">
            <xsl:copy-of select="$data8"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone9">
          <xsl:if test="substring($rendertypes,9,1) != 'b' or 9 &lt; $stackedval">
            <xsl:copy-of select="$data9"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone10">
          <xsl:if test="substring($rendertypes,10,1) != 'b' or 10 &lt; $stackedval">
            <xsl:copy-of select="$data10"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone11">
          <xsl:if test="substring($rendertypes,11,1) != 'b' or 11 &lt; $stackedval">
            <xsl:copy-of select="$data11"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone12">
          <xsl:if test="substring($rendertypes,12,1) != 'b' or 12 &lt; $stackedval">
            <xsl:copy-of select="$data12"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone13">
          <xsl:if test="substring($rendertypes,13,1) != 'b' or 13 &lt; $stackedval">
            <xsl:copy-of select="$data13"/>
          </xsl:if>
        </xsl:variable>

        <xsl:variable name="standalone14">
          <xsl:if test="substring($rendertypes,14,1) != 'b' or 14 &lt; $stackedval">
            <xsl:copy-of select="$data14"/>
          </xsl:if>
        </xsl:variable>

        <!-- coalesce the stacked data into a single tree of summed values -->
        <xsl:variable name="stackedData">
          <xsl:for-each select="$data1">
            <xsl:variable name="at" select="position()"/>
            <xsl:element name="stackedsum">
              <xsl:call-template name="addstackedvalues">
                <xsl:with-param name="stackedval" select="$stackedval"/>
                <xsl:with-param name="rendertypes" select="$rendertypes"/>
                <xsl:with-param name="datum1" select="$data1[$at]"/>
                <xsl:with-param name="datum2" select="$data2[$at]"/>
                <xsl:with-param name="datum3" select="$data3[$at]"/>
                <xsl:with-param name="datum4" select="$data4[$at]"/>
                <xsl:with-param name="datum5" select="$data5[$at]"/>
                <xsl:with-param name="datum6" select="$data6[$at]"/>
                <xsl:with-param name="datum7" select="$data7[$at]"/>
                <xsl:with-param name="datum8" select="$data8[$at]"/>
                <xsl:with-param name="datum9" select="$data9[$at]"/>
                <xsl:with-param name="datum10" select="$data10[$at]"/>
                <xsl:with-param name="datum11" select="$data11[$at]"/>
                <xsl:with-param name="datum12" select="$data12[$at]"/>
                <xsl:with-param name="datum13" select="$data13[$at]"/>
                <xsl:with-param name="datum14" select="$data14[$at]"/>
              </xsl:call-template>
            </xsl:element>
          </xsl:for-each>
        </xsl:variable>

<!--
<xsl:text>
stackedData = </xsl:text>
<xsl:call-template name="nodesetToList">
  <xsl:with-param name="nodeset" select="xalan:nodeset($stackedData)/*"/>
</xsl:call-template>
<xsl:text>
</xsl:text>
-->

        <!-- build a descending sorted list of summed stacked and standalone values -->
        <xsl:variable name="sortedData">
          <xsl:choose>
            <xsl:when test="function-available('xalan:nodeset')">
              <xsl:for-each select="xalan:nodeset($stackedData)/*|xalan:nodeset($standalone1)/*|xalan:nodeset($standalone2)/*|xalan:nodeset($standalone3)/*|xalan:nodeset($standalone4)/*|xalan:nodeset($standalone5)/*|xalan:nodeset($standalone6)/*|xalan:nodeset($standalone7)/*|xalan:nodeset($standalone8)/*|xalan:nodeset($standalone9)/*|xalan:nodeset($standalone10)/*|xalan:nodeset($standalone11)/*|xalan:nodeset($standalone12)/*|xalan:nodeset($standalone13)/*|xalan:nodeset($standalone14)/*">
                <xsl:sort order="ascending" data-type="number"/>
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="function-available('msxml:node-set')">
              <xsl:for-each select="msxml:node-set($stackedData)/*|msxml:node-set($standalone1)/*|msxml:node-set($standalone2)/*|msxml:node-set($standalone3)/*|msxml:node-set($standalone4)/*|msxml:node-set($standalone5)/*|msxml:node-set($standalone6)/*|msxml:node-set($standalone7)/*|msxml:node-set($standalone8)/*|msxml:node-set($standalone9)/*|msxml:node-set($standalone10)/*|msxml:node-set($standalone11)/*|msxml:node-set($standalone12)/*|msxml:node-set($standalone13)/*|msxml:node-set($standalone14)/*">
                <xsl:sort order="ascending" data-type="number"/>
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="function-available('xt:node-set')">
              <xsl:for-each select="xt:node-set($stackedData)/*|xt:node-set($standalone1)/*|xt:node-set($standalone2)/*|xt:node-set($standalone3)/*|xt:node-set($standalone4)/*|xt:node-set($standalone5)/*|xt:node-set($standalone6)/*|xt:node-set($standalone7)/*|xt:node-set($standalone8)/*|xt:node-set($standalone9)/*|xt:node-set($standalone10)/*|xt:node-set($standalone11)/*|xt:node-set($standalone12)/*|xt:node-set($standalone13)/*|xt:node-set($standalone14)/*">
                <xsl:sort order="ascending" data-type="number"/>
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="function-available('saxon:node-set')">
              <xsl:for-each select="saxon:node-set($stackedData)/*|saxon:node-set($standalone1)/*|saxon:node-set($standalone2)/*|saxon:node-set($standalone3)/*|saxon:node-set($standalone4)/*|saxon:node-set($standalone5)/*|saxon:node-set($standalone6)/*|saxon:node-set($standalone7)/*|saxon:node-set($standalone8)/*|saxon:node-set($standalone9)/*|saxon:node-set($standalone10)/*|saxon:node-set($standalone11)/*|saxon:node-set($standalone12)/*|saxon:node-set($standalone13)/*|saxon:node-set($standalone14)/*">
                <xsl:sort order="ascending" data-type="number"/>
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>

<!--
<xsl:text>
sortedData = </xsl:text>
<xsl:call-template name="nodesetToList">
  <xsl:with-param name="nodeset" select="xalan:nodeset($sortedData)/*"/>
</xsl:call-template>
<xsl:text>
</xsl:text>
-->

        <!-- build a list of unique values from the sorted values-->
        <xsl:variable name="uniqueSortedData">
          <xsl:choose>
            <xsl:when test="function-available('xalan:nodeset')">
              <xsl:for-each select="xalan:nodeset($sortedData)/*">
                <xsl:if test="not(following-sibling::*[1]=.)">
                  <xsl:copy-of select="."/>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="function-available('msxml:node-set')">
              <xsl:for-each select="msxml:node-set($sortedData)/*">
                <xsl:if test="not(following-sibling::*[1]=.)">
                  <xsl:copy-of select="."/>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="function-available('xt:node-set')">
              <xsl:for-each select="xt:node-set($sortedData)/*">
                <xsl:if test="not(following-sibling::*[1]=.)">
                  <xsl:copy-of select="."/>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="function-available('saxon:node-set')">
              <xsl:for-each select="saxon:node-set($sortedData)/*">
                <xsl:if test="not(following-sibling::*[1]=.)">
                  <xsl:copy-of select="."/>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>

<!--
<xsl:text>
uniqueSortedData = </xsl:text>
<xsl:call-template name="nodesetToList">
  <xsl:with-param name="nodeset" select="xalan:nodeset($uniqueSortedData)/*"/>
</xsl:call-template>
<xsl:text>
</xsl:text>
-->

<!--
<xsl:text>
retval = </xsl:text>
<xsl:call-template name="nodesetToList">
  <xsl:with-param name="nodeset" select="xalan:nodeset($uniqueSortedData)/*[1]"/>
</xsl:call-template>
<xsl:text>
</xsl:text>
<xsl:text>
</xsl:text>
-->

        <!-- find nth value of the sorted unique values -->
        <xsl:variable name="retval">
          <xsl:choose>
            <xsl:when test="function-available('xalan:nodeset')">
              <xsl:value-of select="xalan:nodeset($uniqueSortedData)/*[1]"/>
            </xsl:when>
            <xsl:when test="function-available('msxml:node-set')">
              <xsl:value-of select="msxml:node-set($uniqueSortedData)/*[1]"/>
            </xsl:when>
            <xsl:when test="function-available('xt:node-set')">
              <xsl:value-of select="xt:node-set($uniqueSortedData)/*[1]"/>
            </xsl:when>
            <xsl:when test="function-available('saxon:node-set')">
              <xsl:value-of select="saxon:node-set($uniqueSortedData)/*[1]"/>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>

        <xsl:choose>
          <xsl:when test="$retval &lt; $minmax"><xsl:value-of select="$retval"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="$minmax"/></xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- Rauli added end - negatives -->

  <!-- Add the numeric values from the stacked data sets together.
  -->
  <xsl:template name="addstackedvalues">
    <xsl:param name="stackedval"/>
    <xsl:param name="rendertypes"/>
    <xsl:param name="datum1"/>
    <xsl:param name="datum2"/>
    <xsl:param name="datum3"/>
    <xsl:param name="datum4"/>
    <xsl:param name="datum5"/>
    <xsl:param name="datum6"/>
    <xsl:param name="datum7"/>
    <xsl:param name="datum8"/>
    <xsl:param name="datum9"/>
    <xsl:param name="datum10"/>
    <xsl:param name="datum11"/>
    <xsl:param name="datum12"/>
    <xsl:param name="datum13"/>
    <xsl:param name="datum14"/>

    <xsl:variable name="d1">
      <xsl:choose>
        <xsl:when test="not($datum1) or substring($rendertypes,1,1) != 'b' or 1 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum1"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d2">
      <xsl:choose>
        <xsl:when test="not($datum2) or substring($rendertypes,2,1) != 'b' or 2 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum2"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d3">
      <xsl:choose>
        <xsl:when test="not($datum3) or substring($rendertypes,3,1) != 'b' or 3 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum3"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d4">
      <xsl:choose>
        <xsl:when test="not($datum4) or substring($rendertypes,4,1) != 'b' or 4 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum4"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d5">
      <xsl:choose>
        <xsl:when test="not($datum5) or substring($rendertypes,5,1) != 'b' or 5 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum5"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d6">
      <xsl:choose>
        <xsl:when test="not($datum6) or substring($rendertypes,6,1) != 'b' or 6 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum6"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d7">
      <xsl:choose>
        <xsl:when test="not($datum7) or substring($rendertypes,7,1) != 'b' or 7 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum7"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d8">
      <xsl:choose>
        <xsl:when test="not($datum8) or substring($rendertypes,8,1) != 'b' or 8 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum8"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d9">
      <xsl:choose>
        <xsl:when test="not($datum9) or substring($rendertypes,9,1) != 'b' or 9 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum9"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d10">
      <xsl:choose>
        <xsl:when test="not($datum10) or substring($rendertypes,10,1) != 'b' or 10 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum10"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d11">
      <xsl:choose>
        <xsl:when test="not($datum11) or substring($rendertypes,11,1) != 'b' or 11 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum11"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d12">
      <xsl:choose>
        <xsl:when test="not($datum12) or substring($rendertypes,12,1) != 'b' or 12 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum12"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d13">
      <xsl:choose>
        <xsl:when test="not($datum13) or substring($rendertypes,13,1) != 'b' or 13 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum13"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="d14">
      <xsl:choose>
        <xsl:when test="not($datum14) or substring($rendertypes,14,1) != 'b' or 14 &lt; $stackedval">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="$datum14"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:value-of select="$d1 + $d2 + $d3 + $d4 + $d5 +$d6 +$d7 + $d8 + $d9 + $d10 + $d11 + $d12 + $d13 + $d14"/>
  </xsl:template>

  <!-- Determine the y offset of a text element in a box height
  -->
  <xsl:template name="calcTextOffsetY">
    <xsl:param name="height"/>
    <xsl:param name="baseline"/>

    <xsl:value-of select="$baseline + floor(($height - $baseline) * 2 div 3)"/>
  </xsl:template>

  <!-- Map locale dependent formatting characters in numeric strings
       to a standard format that XSLT can decode.
       This template takes an input nodeset and returns a result tree fragment.
  -->
  <xsl:template name="normalizeData">
    <xsl:param name="data"/>
    <xsl:param name="locale"/>

    <!-- strip out any grouping characters and map the radix point to '.' -->
    <xsl:for-each select="$data">
      <xsl:variable name="datum" select="."/>
      <xsl:element name="translatedDatum">
        <xsl:choose>
          <xsl:when test="starts-with($locale, 'de')">
            <xsl:value-of select="number(translate(translate($datum, '.', ''), ',', '.'))"/>
          </xsl:when>
          <xsl:when test="starts-with($locale, 'fr')">
            <xsl:value-of select="number(translate(translate($datum, ' ', ''), ',', '.'))"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="number(translate($datum, ',', ''))"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <!-- Map locale dependent formatting characters in numeric strings
       to a standard format that XSLT can decode.
       This template takes an input data value and returns a string.
  -->
  <xsl:template name="normalizeDatum">
    <xsl:param name="datum"/>
    <xsl:param name="locale"/>

    <!-- strip out any grouping characters and map the radix point to '.' -->
    <xsl:choose>
      <xsl:when test="starts-with($locale, 'de')">
        <xsl:value-of select="number(translate(translate($datum, '.', ''), ',', '.'))"/>
      </xsl:when>
      <xsl:when test="starts-with($locale, 'fr')">
        <xsl:value-of select="number(translate(translate($datum, ' ', ''), ',', '.'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="number(translate($datum, ',', ''))"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- merge the default and override colors -->
  <xsl:template name="merge_colors">
    <xsl:param name="defaults"/>
    <xsl:param name="overrides"/>
    <xsl:param name="index"/>
    <xsl:param name="max"/>

    <xsl:if test="$index &lt; $max">
      <xsl:variable name="default">
        <xsl:value-of select="substring($defaults, $index * 8 + 1, 7)"/>
      </xsl:variable>
      <xsl:variable name="override">
        <xsl:value-of select="substring($overrides, $index * 8 + 1, 7)"/>
      </xsl:variable>
      <xsl:variable name="sep">
        <xsl:choose>
          <xsl:when test="$index = $max - 1"></xsl:when>
          <xsl:otherwise>,</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$override != '' and $override != 'default'"><xsl:value-of select="concat($override,$sep)"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="concat($default,$sep)"/></xsl:otherwise>
      </xsl:choose>

      <xsl:call-template name="merge_colors">
        <xsl:with-param name="defaults" select="$defaults"/>
        <xsl:with-param name="overrides" select="$overrides"/>
        <xsl:with-param name="index" select="$index + 1"/>
        <xsl:with-param name="max" select="$max"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Debug template
  -->
  <xsl:template name="nodesetToList">
    <xsl:param name="nodeset"/>

    <xsl:for-each select="$nodeset">
      <xsl:value-of select="."/>
      <xsl:choose>
        <xsl:when test="position() = last()"/>
        <xsl:otherwise>,</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>

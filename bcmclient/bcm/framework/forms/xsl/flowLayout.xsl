<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output method="html"/>

  <xsl:template name="doFlowLayout">
    <xsl:param name="noOfColumns" select="1"/>
    <xsl:param name="cellpadding" select="0"/>
    <xsl:param name="cellspacing" select="0"/>
    <xsl:param name="element"/>
    <xsl:param name="elementMetaData"/>

    <table width="100%" height="100%" cellspacing="{$cellspacing}" cellpadding="{$cellpadding}" border="0">
      <xsl:call-template name="doLayout">
        <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
        <xsl:with-param name="elementCount" select="count($element/*)"/>
        <xsl:with-param name="element" select="$element"/>
        <xsl:with-param name="elementMetaData" select="$elementMetaData"/>
      </xsl:call-template>
    </table>
  </xsl:template>

  <xsl:template name="doLayout">
    <xsl:param name="startingPosition" select="0"/>
    <xsl:param name="noOfColumns"/>
    <xsl:param name="elementCount"/>
    <xsl:param name="element"/>
    <xsl:param name="elementMetaData"/>

    <tr>
      <xsl:choose>
        <xsl:when test="$elementMetaData">
          <xsl:for-each select="$elementMetaData/PROPERTY[position() &gt; $startingPosition and position() &lt; $startingPosition + $noOfColumns + 1]">
            <xsl:call-template name="renderRowWithMetaData">
              <xsl:with-param name="element" select="$element"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="$element/*[position() &gt; $startingPosition and position() &lt; $startingPosition + $noOfColumns + 1]">
            <xsl:call-template name="renderRowWithoutMetaData">
              <xsl:with-param name="element" select="."/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    </tr>

    <xsl:if test="$startingPosition + $noOfColumns &lt; $elementCount">
      <xsl:call-template name="doLayout">
        <xsl:with-param name="startingPosition" select="$startingPosition + $noOfColumns"/>
        <xsl:with-param name="noOfColumns" select="$noOfColumns"/>
        <xsl:with-param name="elementCount" select="$elementCount"/>
        <xsl:with-param name="element" select="$element"/>
        <xsl:with-param name="elementMetaData" select="$elementMetaData"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="renderRowWithMetaData">
    <xsl:param name="element"/>

    <!-- Since this template is called from within the for loop, the current node
           is visible here -->
    <xsl:variable name="currentProperty" select="."/>

    <td nowrap="yes">
      <xsl:value-of select="$currentProperty/@DisplayName"/>
    </td>

    <td nowrap="yes">
      <xsl:value-of select="$element/*[name() = $currentProperty/@Name]/@Value"/>
    </td>
  </xsl:template>

  <xsl:template name="renderRowWithoutMetaData">
    <xsl:param name="element"/>
  </xsl:template>
  
</xsl:stylesheet>
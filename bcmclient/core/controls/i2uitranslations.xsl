<?xml version="1.0" standalone='no'?>

<!--
  This stylesheet contains the translation tables needed to support localisation of the i2ui xsl tags and,
  through the magic of the document() function, the callable template that looks up a value.

  The translation template will do most-specific locale matching. For example, if a locale of de_DE is specified,
  a translation table keyed to that locale will be searched first. If no matching translations are found at that level,
  the template will strip off the trailing _DE and try to lookup the key using the de locale value.

  If the translation template cannot lookup the key, the key itself is output as the template value.
-->

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i2uilocalisation="i2uilocalisation.uri"
  exclude-result-prefixes="i2uilocalisation"
  version="1.0">

  <!-- constants used by the including stylesheet -->
  <xsl:variable name="TODAY_KEY">Today</xsl:variable>
  <xsl:variable name="CANCEL_KEY">Cancel</xsl:variable>
  <xsl:variable name="OK_KEY">OK</xsl:variable>
  <xsl:variable name="DAYLETTERS_KEY">SMTWTFS</xsl:variable>
  <xsl:variable name="ZOOMIN_KEY">zoom in</xsl:variable>
  <xsl:variable name="ZOOMOUT_KEY">zoom out</xsl:variable>
  <xsl:variable name="YES_KEY">Yes</xsl:variable>
  <xsl:variable name="NO_KEY">No</xsl:variable>

  <!-- translation tables -->
  <i2uilocalisation:locale value="de">
    <i2uilocalisation:key value="Today">Heute</i2uilocalisation:key>
    <i2uilocalisation:key value="Cancel">Abbrechen</i2uilocalisation:key>
    <i2uilocalisation:key value="OK">OK</i2uilocalisation:key>
    <i2uilocalisation:key value="SMTWTFS">SMDMDFS</i2uilocalisation:key>
    <i2uilocalisation:key value="zoom in">zoom in</i2uilocalisation:key>
    <i2uilocalisation:key value="zoom out">zoom aus</i2uilocalisation:key>
    <i2uilocalisation:key value="Yes">Ja</i2uilocalisation:key>
    <i2uilocalisation:key value="No">Nein</i2uilocalisation:key>
  </i2uilocalisation:locale>

  <i2uilocalisation:locale value="fr">
    <i2uilocalisation:key value="Today">Aujourd'hui</i2uilocalisation:key>
    <i2uilocalisation:key value="Cancel">Annuler</i2uilocalisation:key>
    <i2uilocalisation:key value="OK">OK</i2uilocalisation:key>
    <i2uilocalisation:key value="SMTWTFS">DLMMJVS</i2uilocalisation:key>
    <i2uilocalisation:key value="zoom in">zoom dans</i2uilocalisation:key>
    <i2uilocalisation:key value="zoom out">zoom hors de</i2uilocalisation:key>
    <i2uilocalisation:key value="Yes">Oui</i2uilocalisation:key>
    <i2uilocalisation:key value="No">Non</i2uilocalisation:key>
  </i2uilocalisation:locale>

  <i2uilocalisation:locale value="ja">
    <i2uilocalisation:key value="Today">&#x4eca;&#x65e5;</i2uilocalisation:key>
    <i2uilocalisation:key value="Cancel">&#xff77;&#xff6c;&#xff9d;&#xff7e;&#xff99;</i2uilocalisation:key>
    <i2uilocalisation:key value="OK">OK</i2uilocalisation:key>
    <i2uilocalisation:key value="SMTWTFS">&#x65e5;&#x6708;&#x706b;&#x6c34;&#x6728;&#x91d1;&#x571f;</i2uilocalisation:key>
    <i2uilocalisation:key value="zoom in">&#x30ba;&#x30fc;&#x30e0;&#x30ec;&#x30f3;&#x30ba;</i2uilocalisation:key>
    <i2uilocalisation:key value="zoom out">&#x30ba;&#x30fc;&#x30e0;&#x30ec;&#x30f3;&#x30ba;</i2uilocalisation:key>
    <i2uilocalisation:key value="Yes">&#x306f;&#x3044;</i2uilocalisation:key>
    <i2uilocalisation:key value="No">&#x5426;</i2uilocalisation:key>
  </i2uilocalisation:locale>

  <i2uilocalisation:locale value="ko">
    <i2uilocalisation:key value="Today">&#xc624;&#xb298;</i2uilocalisation:key>
    <i2uilocalisation:key value="Cancel">&#xcde8;&#xc18c;</i2uilocalisation:key>
    <i2uilocalisation:key value="OK">&#xd655;&#xc778;</i2uilocalisation:key>
    <i2uilocalisation:key value="SMTWTFS">&#xc77c;&#xc6d4;&#xd654;&#xc218;&#xbaa9;&#xae08;&#xd1a0;</i2uilocalisation:key>
    <i2uilocalisation:key value="zoom in">&#xc548;&#xc73c;&#xb85c;&#xc758; &#xae09;&#xc0c1;&#xc2b9;</i2uilocalisation:key>
    <i2uilocalisation:key value="zoom out">&#xbc16;&#xc73c;&#xb85c;&#xc758; &#xae09;&#xc0c1;&#xc2b9;</i2uilocalisation:key>
    <i2uilocalisation:key value="Yes">&#xadf8;&#xb807;&#xb2e4;</i2uilocalisation:key>
    <i2uilocalisation:key value="No">&#xbd80;&#xc815;</i2uilocalisation:key>
  </i2uilocalisation:locale>

  <!-- the callable template -->
  <xsl:template name="i2uitranslate">
    <xsl:param name="locale"/>
    <xsl:param name="key"/>

    <xsl:if test="$key">
      <xsl:choose>
        <xsl:when test="$locale">
          <!-- attempt to look up the value -->
          <xsl:variable name="value" select="document('')/*/i2uilocalisation:locale[@value=$locale]/i2uilocalisation:key[@value=$key]"/>

          <xsl:choose>
            <xsl:when test="$value">
              <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
              <!-- lookup failed so strip the trailing field from the locale and try again -->
              <!-- Note: this logoc is duplicated in i2uidecimalformats.xsl -->
              <xsl:variable name="prefixlen">
                <xsl:choose>
                  <xsl:when test="string-length($locale) &gt; 5">5</xsl:when>
                  <xsl:when test="string-length($locale) &gt; 2">2</xsl:when>
                  <xsl:otherwise>0</xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:call-template name="i2uitranslate">
                <xsl:with-param name="locale" select="substring($locale, 1, $prefixlen)"/>
                <xsl:with-param name="key" select="$key"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <!-- lookup process failed so emit the key -->
          <xsl:value-of select="$key"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>

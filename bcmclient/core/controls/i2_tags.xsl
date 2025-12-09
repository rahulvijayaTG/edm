<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <!-- Required else some ? show up -->
  <xsl:output method="html"/>

  <!--
  if (!settings.isIE() && onclick != null && disabled == false)
    result.append("<A href=\"" + onclick + "\">");

  result.append( "<img" );

  if ( ( sAttrValue = id ) != null ) {
    result.append( " id=\""+ sAttrValue +"\"" );
  }

  if ( ( sAttrValue = src ) != null ) {

    if (src.startsWith("/"))
      result.append( " src=\""+ contextPath + settings.getImageDirectory() + src +"\"" );
    else
      result.append( " src=\"" + src + "\"" );

  }

  if ( ( sAttrValue = alt ) != null ) {
    result.append( " alt=\""+ sAttrValue +"\"" );
  }

  if ( ( sAttrValue = border ) != null ) {
    result.append( " border=\""+ sAttrValue +"\"" );
  }


  if ( ( sAttrValue = width ) != null ) {
    result.append( " width=\""+ sAttrValue +"\"" );
  }


  if ( ( sAttrValue = height ) != null ) {
    result.append( " height=\""+ sAttrValue +"\"" );
  }

  if ( ( sAttrValue = align ) != null ) {
    result.append( " align=\""+ sAttrValue +"\"" );
  }

  // added by sudhir
  if ( ( sAttrValue = hidden ) != null ) {
    result.append( "  style = 'display:none'" );
  }


  if (settings.isIE() && onclick != null && disabled == false)
    result.append(" onMouseOver=\"javascript:this.style.cursor='hand'\" onclick=\""+onclick+"\" ");

  result.append( ">" );

  if (!settings.isIE() && onclick != null && disabled == false)
    result.append("</A>");

  -->

  <xsl:template name="i2_img">
    <!-- if (!settings.isIE() && onclick != null && disabled == false) -->
  <!--  <A href="{$onclick}"> -->
      <img id="{$id}">

        <xsl:if test="string-length($src) > 0">
          <xsl:choose>
            <xsl:when test="startsWith($src, '/')">
              <xsl:attribute name="src">
                <xsl:value-of select="concat($contextPath, $imgDirectory, $src)"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="src">
                <xsl:value-of select="$src"/>
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

        <xsl:if test="string-length($alt) > 0">
          <xsl:attribute name="alt">
            <xsl:value-of select="$alt"/>
          </xsl:attribute>
        </xsl:if>

        <xsl:if test="string-length($border) > 0">
          <xsl:attribute name="border">
            <xsl:value-of select="$border"/>
          </xsl:attribute>
        </xsl:if>

        <xsl:if test="string-length($width) > 0">
          <xsl:attribute name="width">
            <xsl:value-of select="$width"/>
          </xsl:attribute>
        </xsl:if>

        <xsl:if test="string-length($height) > 0">
          <xsl:attribute name="height">
            <xsl:value-of select="$height"/>
          </xsl:attribute>
        </xsl:if>

        <xsl:if test="string-length($align) > 0">
          <xsl:attribute name="align">
            <xsl:value-of select="align"/>
          </xsl:attribute>
        </xsl:if>

        <xsl:if test="string-length(hidden) > 0">
          <xsl:attribute name="style">display:none</xsl:attribute>
        </xsl:if>

        <!-- if settings.isIE() -->
        <xsl:if test="string-length($onclick) > 0 and $disabled = false">
          <xsl:attribute name="onMouseOver">javascript:this.style.cursor='hand'</xsl:attribute>
          <xsl:attribute name="onclick">
            <xsl:value-of select="$onclick"/>
          </xsl:attribute>
        </xsl:if>

      </img>
  <!--  </A> -->

  </xsl:template>
</xsl:stylesheet>
<?xml version='1.0'?>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i18n="http://www.i2.com/i18n"
>

<xsl:template match="properties">
  <xsl:element name="xsl:stylesheet">
    <xsl:attribute name="version">1.0</xsl:attribute>

    <!-- <xsl:template name="i18n:text"/> -->
    <xsl:element name="xsl:template">
      <xsl:attribute name="name">i18n:text</xsl:attribute>
      <xsl:element name="xsl:param">
        <xsl:attribute name="name">key</xsl:attribute>
      </xsl:element>

      _<xsl:element name="xsl:choose">
         <xsl:for-each select="property">
           <xsl:element name="xsl:when">
             <xsl:attribute name="test">$key = '<xsl:value-of select="@name"/>'</xsl:attribute>
             <xsl:value-of select="."/>
           </xsl:element>
         </xsl:for-each>

         <xsl:element name="xsl:otherwise">
           ?<xsl:element name="xsl:value-of">
              <xsl:attribute name="select">$key</xsl:attribute>
             </xsl:element>?
         </xsl:element>
      </xsl:element>_
    </xsl:element>

    <!-- <xsl:template name="i18n:number"/> -->
    <xsl:element name="xsl:template">
      <xsl:attribute name="name">i18n:number</xsl:attribute>
      <xsl:element name="xsl:param">
        <xsl:attribute name="name">number</xsl:attribute>
      </xsl:element>

      #<xsl:element name="xsl:value-of">
         <xsl:attribute name="select">$number</xsl:attribute>
       </xsl:element>#
    </xsl:element>

    <!-- <xsl:template name="i18n:currency"/> -->
    <xsl:element name="xsl:template">
      <xsl:attribute name="name">i18n:currency</xsl:attribute>
      <xsl:element name="xsl:param">
        <xsl:attribute name="name">currency</xsl:attribute>
      </xsl:element>

      $<xsl:element name="xsl:value-of">
         <xsl:attribute name="select">$currency</xsl:attribute>
       </xsl:element>$
    
    </xsl:element>

    <!-- <xsl:template name="i18n:date"/> -->
    <xsl:element name="xsl:template">
      <xsl:attribute name="name">i18n:date</xsl:attribute>
      <xsl:element name="xsl:param">
        <xsl:attribute name="name">date</xsl:attribute>
      </xsl:element>

      %<xsl:element name="xsl:value-of">
         <xsl:attribute name="select">$date</xsl:attribute>
       </xsl:element>%    
    </xsl:element>

  </xsl:element>
</xsl:template>

</xsl:stylesheet><!-- Stylus Studio meta-information - (c)1998-2002 eXcelon Corp.
<metaInformation>
<scenarios/><MapperInfo srcSchemaPath="" srcSchemaRoot="" srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
</metaInformation>
-->
<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">
  
  <xsl:template match="CODE_MASTER_VALUE" mode="pulldown_desc_id">
    <xsl:param name="selectedId"/>
    <option value="{ID/@Value}">
      <xsl:if test="$selectedId = ID/@Value">
        <xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <i18n:text><xsl:value-of select="DESCRIPTION/@Value"/></i18n:text>
    </option>
  </xsl:template>

  
  <xsl:template match="CODE_MASTER_VALUE" mode="pulldown_id_id">
    <xsl:param name="selectedId"/>
    <option value="{ID/@Value}">
      <xsl:if test="$selectedId = ID/@Value">
        <xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <i18n:text><xsl:value-of select="ID/@Value"/></i18n:text>
    </option>
  </xsl:template>

<xsl:template match="CODE_MASTER_VALUE" mode="pulldown_value_id">
    <xsl:param name="selectedId"/>
    <option value="{VALUE_ID/@Value}">
      <xsl:if test="$selectedId = VALUE_ID/@Value">
        <xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <i18n:text><xsl:value-of select="VALUE_ID/@Value"/></i18n:text>
    </option>
  </xsl:template>

  
  <xsl:template match="CODE_MASTER_VALUE" mode="pulldown">
    <xsl:param name="selectedId"/>
   <option value="{VALUE_ID/@Value}">
      <xsl:if test="$selectedId = VALUE_ID/@Value">
        <xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <i18n:text><xsl:value-of select="DESCRIPTION/@Value"/></i18n:text>
    </option>
  </xsl:template>

  <xsl:template match="SEGMENT" mode="pulldown">
    <xsl:param name="selectedId"/>
   <option value="{TYPE_ID/@Value}">
      <xsl:if test="$selectedId = TYPE_ID/@Value">
        <xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <i18n:text><xsl:value-of select="TYPE_VALUE_ID/@Value"/></i18n:text>
      <i18n:text>: <xsl:value-of select="DESCRIPTION/@Value"/></i18n:text>
    </option>
  </xsl:template>

  <xsl:template match="CODE_MASTER_VALUE" mode="pulldown_ids">
    <xsl:param name="selectedId"/>
    <option value="{VALUE_ID/@Value}">
      <xsl:if test="$selectedId = VALUE_ID/@Value">
        <xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <i18n:text><xsl:value-of select="VALUE_ID/@Value"/></i18n:text>
    </option>
  </xsl:template>


  <xsl:template match="CODE_MASTER_VALUE" mode="pulldown_desc_desc">
    <xsl:param name="selectedId"/>
    <option value="{DESCRIPTION/@Value}">
      <xsl:if test="$selectedId = DESCRIPTION/@Value">
        <xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <i18n:text><xsl:value-of select="DESCRIPTION/@Value"/></i18n:text>
    </option>
  </xsl:template>
  
</xsl:stylesheet>

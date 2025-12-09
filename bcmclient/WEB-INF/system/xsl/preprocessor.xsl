<?xml version="1.0"?>
<xsl:stylesheet  
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:i2="http://www.i2.com/i2" 
  xmlns:i18n="http://www.i2.com/i18n"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  version="1.0">

  <xsl:output method="xml"/>


  <!-- ************************************************ -->
  <!-- Default template                                 -->
  <!-- ************************************************ -->
  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>

      <xsl:choose>
        <xsl:when test="count(*) &gt; 0">
          <xsl:apply-templates select="*"/>
        </xsl:when>
        <xsl:when test="string-length( . ) &gt; 0">
          <xsl:value-of select="."/>
        </xsl:when>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
  
  <!-- ************************************************ -->
  <!-- stylesheet templates                             -->
  <!-- ************************************************ -->
  <xsl:template match="xsl:stylesheet">
    <xsl:copy>
	  <xsl:attribute name="version">1.0</xsl:attribute>
	  <xsl:element name="xsl:import">
	    <xsl:attribute name="href">/omxclient/i18n.xsl</xsl:attribute>
	  </xsl:element>
	  
	  <xsl:apply-templates select="*"/>
	</xsl:copy>
  </xsl:template>
  
  

  <!-- ************************************************ -->
  <!-- i18n templates                                   -->
  <!-- ************************************************ -->

  <xsl:template match="i18n:text">
    <xsl:apply-templates select="." mode="taglib"/>
  </xsl:template>

  <xsl:template match="i18n:text" mode="taglib">
    <xsl:element name="xsl:call-template">
      <xsl:attribute name="name">i18n:text</xsl:attribute>
      <xsl:element name="xsl:with-param">
        <xsl:attribute name="name">key</xsl:attribute>
        <xsl:choose>
          <xsl:when test="string-length( @name ) &gt; 0">
            <xsl:value-of select="@name"/>
          </xsl:when>
          <xsl:when test="string-length( . ) &gt; 0">
            <xsl:value-of select="."/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:copy-of select="*"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template name="i18n:text">
    <xsl:param name="key"/>

    <xsl:element name="xsl:call-template">
      <xsl:attribute name="name">i18n:text</xsl:attribute>
      <xsl:element name="xsl:with-param">
        <xsl:attribute name="name">key</xsl:attribute>
        <xsl:value-of select="$key"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="i18n:number">
    <xsl:apply-templates select="." mode="taglib"/>
  </xsl:template>

  <xsl:template match="i18n:number" mode="taglib">
    <xsl:element name="xsl:call-template">
      <xsl:attribute name="name">i18n:number</xsl:attribute>
      <xsl:if test="count( * ) &gt; 0">
        <xsl:element name="xsl:with-param">
          <xsl:attribute name="name">number</xsl:attribute>
          <xsl:copy-of select="*"/>
        </xsl:element>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="i18n:date">
    <xsl:apply-templates select="." mode="taglib"/>
  </xsl:template>

  <xsl:template match="i18n:date" mode="taglib">
    <xsl:element name="xsl:call-template">
      <xsl:attribute name="name">i18n:date</xsl:attribute>

      <xsl:if test="count( * ) &gt; 0">
        <xsl:element name="xsl:with-param">
          <xsl:attribute name="name">date</xsl:attribute>
          <xsl:copy-of select="*"/>
        </xsl:element>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="i18n:currency">
    <xsl:apply-templates select="." mode="taglib"/>
  </xsl:template>

  <xsl:template match="i18n:currency" mode="taglib">
    <xsl:element name="xsl:call-template">
      <xsl:attribute name="name">i18n:currency</xsl:attribute>
      <xsl:if test="count( * ) &gt; 0">
        <xsl:element name="xsl:with-param">
          <xsl:attribute name="name">currency</xsl:attribute>
          <xsl:copy-of select="*"/>
        </xsl:element>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <!-- ************************************************ -->
  <!-- i2ui seed templates                           -->
  <!-- ************************************************ -->

  <xsl:template match="i2:*">
    <xsl:apply-templates select="." mode="taglib"/>
  </xsl:template>   
  
  <!-- ************************************************ -->
  <!-- i2ui templates                                   -->
  <!-- ************************************************ -->

  <xsl:variable name="newline">
    <xsl:text>
    </xsl:text>
  </xsl:variable>

  <!-- handle TD tags -->
  <xsl:template match="TD | td" mode="taglib">
    <xsl:choose>
      <xsl:when test="string-length()='0' and not(./*)">
        <xsl:call-template name="emptycell"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:call-template name="cellattributes"/>
          <xsl:apply-templates mode="taglib"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="TD | td" mode="taglibNS4">
    <xsl:choose>
      <xsl:when test="string-length()='0' and not(./*)">
        <xsl:call-template name="emptycell"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:call-template name="cellattributes"/>
          <xsl:apply-templates mode="taglibNS4"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="TD | td" mode="taglibNS6">
    <xsl:choose>
      <xsl:when test="string-length()='0' and not(./*)">
        <xsl:call-template name="emptycell"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:call-template name="cellattributes"/>
          <xsl:apply-templates mode="taglibNS6"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- handle empty TD tags -->
  <xsl:template name="emptycell">
    <xsl:copy>
      <xsl:call-template name="cellattributes"/>
      <xsl:text>&#160;</xsl:text>
    </xsl:copy>
  </xsl:template>

  <!-- handle valign and nowrap for TD tags within i2:tr tags -->
  <xsl:template name="cellattributes">
    <xsl:copy-of select="@*"/>
    <xsl:if test="parent::i2:tr">
      <xsl:if test="not(@valign)">
        <xsl:attribute name="valign">
          <xsl:choose>
            <xsl:when test="contains(../@header,'yes')">bottom</xsl:when>
            <xsl:otherwise>top</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="not(@nowrap)">
        <xsl:variable name="headerrowcount">
          <xsl:value-of select="count(preceding::i2:tr[header='yes'])"/>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="contains(../@header,'yes')">
            <xsl:attribute name="nowrap">yes</xsl:attribute>
          </xsl:when>
          <xsl:when test="count(preceding::i2:tr) = $headerrowcount +1 and count(following::i2:tr) &gt; 0">
            <xsl:attribute name="nowrap">yes</xsl:attribute>
          </xsl:when>
        </xsl:choose>
      </xsl:if>
    </xsl:if>
  </xsl:template>


  <!-- handle i2:formclass inside input tag -->
  <xsl:template match="input | INPUT" mode="taglib">
    <xsl:choose>
      <xsl:when test="contains(@class,'&lt;i2:formclass')">
        <input>
          <xsl:copy-of select="@*"/>
          <xsl:attribute name="class">
            <xsl:call-template name="i2:formclass_IE">
              <xsl:with-param name="parm" select="normalize-space(@class)"/>
            </xsl:call-template>
          </xsl:attribute>
        </input>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates mode="taglib"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="input | INPUT" mode="taglibNS4">
    <xsl:choose>
      <xsl:when test="contains(@class,'&lt;i2:formclass')">
        <input>
          <xsl:copy-of select="@*"/>
          <xsl:attribute name="class">
            <xsl:call-template name="i2:formclass_NS4">
              <xsl:with-param name="parm" select="normalize-space(@class)"/>
            </xsl:call-template>
          </xsl:attribute>
        </input>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates mode="taglibNS4"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="input | INPUT" mode="taglibNS6">
    <xsl:choose>
      <xsl:when test="contains(@class,'&lt;i2:formclass')">
        <input>
          <xsl:copy-of select="@*"/>
          <xsl:attribute name="class">
            <xsl:call-template name="i2:formclass_NS6">
              <xsl:with-param name="parm" select="normalize-space(@class)"/>
            </xsl:call-template>
          </xsl:attribute>
        </input>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates mode="taglibNS6"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- handle i2:formclass inside select tag -->
  <xsl:template match="select | SELECT" mode="taglib">
    <xsl:choose>
      <xsl:when test="contains(@class,'&lt;i2:formclass')">
        <select>
          <xsl:copy-of select="@*"/>
          <xsl:attribute name="class">
            <xsl:call-template name="i2:formclass_IE">
              <xsl:with-param name="parm" select="normalize-space(@class)"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:apply-templates mode="taglib"/>
        </select>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates mode="taglib"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="select | SELECT" mode="taglibNS4">
    <xsl:choose>
      <xsl:when test="contains(@class,'&lt;i2:formclass')">
        <select>
          <xsl:copy-of select="@*"/>
          <xsl:attribute name="class">
            <xsl:call-template name="i2:formclass_NS4">
              <xsl:with-param name="parm" select="normalize-space(@class)"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:apply-templates mode="taglibNS4"/>
        </select>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates mode="taglibNS4"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="select | SELECT" mode="taglibNS6">
    <xsl:choose>
      <xsl:when test="contains(@class,'&lt;i2:formclass')">
        <select>
          <xsl:copy-of select="@*"/>
          <xsl:attribute name="class">
            <xsl:call-template name="i2:formclass_NS6">
              <xsl:with-param name="parm" select="normalize-space(@class)"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:apply-templates mode="taglibNS6"/>
        </select>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates mode="taglibNS6"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="*" mode="taglib">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="taglib"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="*" mode="taglibNS4">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="taglibNS4"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="*" mode="taglibNS6">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="taglibNS6"/>
    </xsl:copy>
  </xsl:template>


  <xsl:template match="i2:buttonbar" mode="taglib">
    <TABLE border="0" cellspacing="0" cellpadding="1" width="100%">
      <TR>
        <xsl:if test="contains(@aligncontents,'right')">
          <TD width="100%" nowrap="yes">
            <xsl:text>&#160;</xsl:text>
          </TD>
        </xsl:if>
        <TD nowrap="yes">
          <xsl:apply-templates select="i2:button[1]" mode="taglib"/>
        </TD>
        <xsl:for-each select="i2:button[position() &gt; 1] | i2:buttonbardivider">
          <xsl:choose>
            <xsl:when test="local-name() = 'button' and preceding-sibling::*[1]=''">
              <TD nowrap="yes">
                <xsl:apply-templates select="." mode="taglib"/>
              </TD>
            </xsl:when>
            <xsl:when test="local-name() = 'button'">
              <xsl:if test="not(ancestor::i2:header | ancestor::i2:footer)">
                <TD width="6px" style="font-size:1px" nowrap="yes">
                  <xsl:text>&#160;</xsl:text>
                </TD>
              </xsl:if>
              <TD nowrap="yes">
                <xsl:apply-templates select="." mode="taglib"/>
              </TD>
            </xsl:when>
            <xsl:when test="local-name() = 'buttonbardivider'">
              <TD width="2px" style="font-size:1px" nowrap="yes">
                <xsl:text>&#160;</xsl:text>
              </TD>
              <TD nowrap="yes">
                <xsl:apply-templates select="." mode="taglib"/>
              </TD>
              <TD width="2px" style="font-size:1px" nowrap="yes">
                <xsl:text>&#160;</xsl:text>
              </TD>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
        <xsl:choose>
          <xsl:when test="contains(@nopadding,'yes')">
          </xsl:when>
          <xsl:otherwise>
            <TD width="100%" nowrap="yes">
              <xsl:text>&#160;</xsl:text>
            </TD>
          </xsl:otherwise>
        </xsl:choose>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:buttonbar" mode="taglibNS4">
    <TABLE border="0" cellspacing="0" cellpadding="1" width="100%">
      <TR>
        <TD nowrap="yes">
          <xsl:apply-templates select="i2:button[1]" mode="taglibNS4"/>
        </TD>
        <xsl:for-each select="i2:button[position() &gt; 1] | i2:buttonbardivider">
          <xsl:choose>
            <xsl:when test="local-name() = 'button' and preceding-sibling::*[1]=''">
              <TD nowrap="yes">
                <xsl:apply-templates select="." mode="taglibNS4"/>
              </TD>
            </xsl:when>
            <xsl:when test="local-name() = 'button'">
              <xsl:if test="not(ancestor::i2:header | ancestor::i2:footer)">
                <TD width="6px" style="font-size:1px" nowrap="yes">
                  <xsl:text>&#160;</xsl:text>
                </TD>
              </xsl:if>
              <TD nowrap="yes">
                <xsl:apply-templates select="." mode="taglibNS4"/>
              </TD>
            </xsl:when>
            <xsl:when test="local-name() = 'buttonbardivider'">
              <TD nowrap="yes" style="font-size:2px">
                <xsl:text>&#160;</xsl:text>
                <xsl:apply-templates select="." mode="taglibNS4"/>
                <xsl:text>&#160;</xsl:text>
              </TD>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
        <xsl:choose>
          <xsl:when test="contains(@nopadding,'yes')">
          </xsl:when>
          <xsl:otherwise>
            <TD width="100%" nowrap="yes">
              <xsl:text>&#160;</xsl:text>
            </TD>
          </xsl:otherwise>
        </xsl:choose>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:buttonbar" mode="taglibNS6">
    <TABLE border="0" cellspacing="0" cellpadding="1" width="100%">
      <TR>
        <xsl:if test="contains(@aligncontents,'right')">
          <TD width="100%" nowrap="yes">
            <xsl:text>&#160;</xsl:text>
          </TD>
        </xsl:if>
        <TD nowrap="yes">
          <xsl:apply-templates select="i2:button[1]" mode="taglibNS6"/>
        </TD>
        <xsl:for-each select="i2:button[position() &gt; 1] | i2:buttonbardivider">
          <xsl:choose>
            <xsl:when test="local-name() = 'button' and preceding-sibling::*[1]=''">
              <TD nowrap="yes">
                <xsl:apply-templates select="." mode="taglibNS6"/>
              </TD>
            </xsl:when>
            <xsl:when test="local-name() = 'button'">
              <xsl:if test="not(ancestor::i2:header | ancestor::i2:footer)">
                <TD width="6px" style="font-size:1px" nowrap="yes">
                  <xsl:text>&#160;</xsl:text>
                </TD>
              </xsl:if>
              <TD nowrap="yes">
                <xsl:apply-templates select="." mode="taglibNS6"/>
              </TD>
            </xsl:when>
            <xsl:when test="local-name() = 'buttonbardivider'">
              <TD width="2px" style="font-size:1px" nowrap="yes">
                <xsl:text>&#160;</xsl:text>
              </TD>
              <TD nowrap="yes">
                <xsl:apply-templates select="." mode="taglibNS6"/>
              </TD>
              <TD width="2px" style="font-size:1px" nowrap="yes">
                <xsl:text>&#160;</xsl:text>
              </TD>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
        <xsl:choose>
          <xsl:when test="contains(@nopadding,'yes')">
          </xsl:when>
          <xsl:otherwise>
            <TD width="100%" nowrap="yes">
              <xsl:text>&#160;</xsl:text>
            </TD>
          </xsl:otherwise>
        </xsl:choose>
      </TR>
    </TABLE>
  </xsl:template>

  <xsl:variable name="imageDirectory">/omxclient/i2/javascript</xsl:variable>
  <xsl:variable name="javascriptDirectory">/omxclient/i2/javascript</xsl:variable>
  <xsl:variable name="cssDirectory">/omxclient/i2/css</xsl:variable>

  <xsl:template match="i2:buttonbardivider" mode="taglib">
    <IMG>
      <xsl:attribute name="src">
        <xsl:value-of select="$imageDirectory"/>/blue_divider.gif</xsl:attribute>
    </IMG>
  </xsl:template>
  <xsl:template match="i2:buttonbardivider" mode="taglibNS4">
    <IMG>
      <xsl:attribute name="src">
        <xsl:value-of select="$imageDirectory"/>/blue_divider.gif</xsl:attribute>
    </IMG>
  </xsl:template>
  <xsl:template match="i2:buttonbardivider" mode="taglibNS6">
    <IMG>
      <xsl:attribute name="src">
        <xsl:value-of select="$imageDirectory"/>/blue_divider.gif</xsl:attribute>
    </IMG>
  </xsl:template>


  <xsl:template match="i2:button" mode="taglib">
    <xsl:variable name="borderclass">
      <xsl:choose>
        <xsl:when test="contains(@disabled,'yes')">buttonBorderDisabled</xsl:when>
        <xsl:when test="contains(@emphasized,'yes')">buttonBorderEmphasized</xsl:when>
        <xsl:otherwise>buttonBorder</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="textclass">
      <xsl:choose>
        <xsl:when test="contains(@disabled,'yes')">buttonTextDisabled</xsl:when>
        <xsl:when test="contains(@emphasized,'yes')">buttonTextEmphasized</xsl:when>
        <xsl:otherwise>buttonText</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="textid">
      <xsl:choose>
        <xsl:when test="contains(@small,'yes')">buttonSmall</xsl:when>
        <xsl:otherwise>button</xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="contains(@emphasized,'yes')">Emphasized</xsl:when>
        <xsl:when test="contains(@disabled,'yes')">Disabled</xsl:when>
        <xsl:otherwise>Regular</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE cellspacing="1" cellpadding="0">
      <xsl:attribute name="class">
        <xsl:value-of select="$borderclass"/>
      </xsl:attribute>
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@hidden = 'yes'">
        <xsl:attribute name="style">display:none</xsl:attribute>
      </xsl:if>
      <TR>
        <TD nowrap="yes">
          <xsl:attribute name="id">
            <xsl:value-of select="$textid"/>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:value-of select="$textclass"/>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="contains(@disabled,'yes')">
              <xsl:if test="not(contains(@nopadding,'yes'))">
                <xsl:text>&#160;&#160;</xsl:text>
              </xsl:if>
              <xsl:apply-templates mode="taglib"/>
              <xsl:if test="not(contains(@nopadding,'yes'))">
                <xsl:text>&#160;&#160;</xsl:text>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <A>
                <xsl:attribute name="href">
                  <xsl:value-of select="@onclick"/>
                </xsl:attribute>
                <xsl:if test="@htmlonclick">
                  <xsl:attribute name="onclick">
                    <xsl:value-of select="@htmlonclick"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="@target">
                  <xsl:attribute name="target">
                    <xsl:value-of select="@target"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="not(contains(@nopadding,'yes'))">
                  <xsl:text>&#160;&#160;</xsl:text>
                </xsl:if>
                <xsl:apply-templates mode="taglib"/>
                <xsl:if test="not(contains(@nopadding,'yes'))">
                  <xsl:text>&#160;&#160;</xsl:text>
                </xsl:if>
              </A>
            </xsl:otherwise>
          </xsl:choose>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:button[@id]" mode="taglibNS4">
    <DIV style="position:relative">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:variable name="borderclass">
        <xsl:choose>
          <xsl:when test="contains(@disabled,'yes')">buttonBorderDisabled</xsl:when>
          <xsl:otherwise>buttonBorder</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="textclass">
        <xsl:choose>
          <xsl:when test="contains(@disabled,'yes')">buttonTextDisabled</xsl:when>
          <xsl:otherwise>buttonText</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="textid">
        <xsl:choose>
          <xsl:when test="contains(@small,'yes')">buttonSmall</xsl:when>
          <xsl:otherwise>button</xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="contains(@emphasized,'yes')">Emphasized</xsl:when>
          <xsl:when test="contains(@disabled,'yes')">Disabled</xsl:when>
          <xsl:otherwise>Regular</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <TABLE border="1" cellspacing="0" cellpadding="0">
        <xsl:attribute name="class">
          <xsl:value-of select="$borderclass"/>
        </xsl:attribute>
        <TR>
          <TD nowrap="yes">
            <xsl:attribute name="id">
              <xsl:value-of select="$textid"/>
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="contains(@disabled,'yes')">
                <xsl:if test="not(contains(@nopadding,'yes'))">
                  <xsl:text>&#160;&#160;</xsl:text>
                </xsl:if>
                <xsl:apply-templates mode="taglib"/>
                <xsl:if test="not(contains(@nopadding,'yes'))">
                  <xsl:text>&#160;&#160;</xsl:text>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <A class="buttonText">
                  <xsl:attribute name="href">
                    <xsl:value-of select="@onclick"/>
                  </xsl:attribute>
                  <xsl:if test="@htmlonclick">
                    <xsl:attribute name="onclick">
                      <xsl:value-of select="@htmlonclick"/>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:if test="@target">
                    <xsl:attribute name="target">
                      <xsl:value-of select="@target"/>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:if test="not(contains(@nopadding,'yes'))">
                    <xsl:text>&#160;&#160;</xsl:text>
                  </xsl:if>
                  <xsl:apply-templates mode="taglib"/>
                  <xsl:if test="not(contains(@nopadding,'yes'))">
                    <xsl:text>&#160;&#160;</xsl:text>
                  </xsl:if>
                </A>
              </xsl:otherwise>
            </xsl:choose>
          </TD>
        </TR>
      </TABLE>
    </DIV>
  </xsl:template>
  <xsl:template match="i2:button" mode="taglibNS4">
    <xsl:variable name="borderclass">
      <xsl:choose>
        <xsl:when test="contains(@disabled,'yes')">buttonBorderDisabled</xsl:when>
        <xsl:otherwise>buttonBorder</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="textclass">
      <xsl:choose>
        <xsl:when test="contains(@disabled,'yes')">buttonTextDisabled</xsl:when>
        <xsl:otherwise>buttonText</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="textid">
      <xsl:choose>
        <xsl:when test="contains(@small,'yes')">buttonSmall</xsl:when>
        <xsl:otherwise>button</xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="contains(@emphasized,'yes')">Emphasized</xsl:when>
        <xsl:when test="contains(@disabled,'yes')">Disabled</xsl:when>
        <xsl:otherwise>Regular</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE border="1" cellspacing="0" cellpadding="0">
      <xsl:attribute name="class">
        <xsl:value-of select="$borderclass"/>
      </xsl:attribute>
      <TR>
        <TD nowrap="yes">
          <xsl:attribute name="id">
            <xsl:value-of select="$textid"/>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="contains(@disabled,'yes')">
              <xsl:if test="not(contains(@nopadding,'yes'))">
                <xsl:text>&#160;&#160;</xsl:text>
              </xsl:if>
              <xsl:apply-templates mode="taglib"/>
              <xsl:if test="not(contains(@nopadding,'yes'))">
                <xsl:text>&#160;&#160;</xsl:text>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <A class="buttonText">
                <xsl:attribute name="href">
                  <xsl:value-of select="@onclick"/>
                </xsl:attribute>
                <xsl:if test="@htmlonclick">
                  <xsl:attribute name="onclick">
                    <xsl:value-of select="@htmlonclick"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="@target">
                  <xsl:attribute name="target">
                    <xsl:value-of select="@target"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="not(contains(@nopadding,'yes'))">
                  <xsl:text>&#160;&#160;</xsl:text>
                </xsl:if>
                <xsl:apply-templates mode="taglib"/>
                <xsl:if test="not(contains(@nopadding,'yes'))">
                  <xsl:text>&#160;&#160;</xsl:text>
                </xsl:if>
              </A>
            </xsl:otherwise>
          </xsl:choose>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:button" mode="taglibNS6">
    <xsl:variable name="borderclass">
      <xsl:choose>
        <xsl:when test="contains(@disabled,'yes')">buttonBorderDisabled</xsl:when>
        <xsl:when test="contains(@emphasized,'yes')">buttonBorderEmphasized</xsl:when>
        <xsl:otherwise>buttonBorder</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="textclass">
      <xsl:choose>
        <xsl:when test="contains(@disabled,'yes')">buttonTextDisabled</xsl:when>
        <xsl:when test="contains(@emphasized,'yes')">buttonTextEmphasized</xsl:when>
        <xsl:otherwise>buttonText</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="textid">
      <xsl:choose>
        <xsl:when test="contains(@small,'yes')">buttonSmall</xsl:when>
        <xsl:otherwise>button</xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="contains(@emphasized,'yes')">Emphasized</xsl:when>
        <xsl:when test="contains(@disabled,'yes')">Disabled</xsl:when>
        <xsl:otherwise>Regular</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE cellspacing="1" cellpadding="0" border="0">
      <xsl:attribute name="class">
        <xsl:value-of select="$borderclass"/>
      </xsl:attribute>
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@hidden='yes'">
        <xsl:attribute name="style">display:none</xsl:attribute>
      </xsl:if>
      <TR>
        <TD nowrap="yes">
          <xsl:attribute name="id">
            <xsl:value-of select="$textid"/>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:value-of select="$textclass"/>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="contains(@disabled,'yes')">
              <xsl:if test="not(contains(@nopadding,'yes'))">
                <xsl:text>&#160;&#160;</xsl:text>
              </xsl:if>
              <xsl:apply-templates mode="taglib"/>
              <xsl:if test="not(contains(@nopadding,'yes'))">
                <xsl:text>&#160;&#160;</xsl:text>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <A>
                <xsl:attribute name="href">
                  <xsl:value-of select="@onclick"/>
                </xsl:attribute>
                <xsl:if test="@htmlonclick">
                  <xsl:attribute name="onclick">
                    <xsl:value-of select="@htmlonclick"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="@target">
                  <xsl:attribute name="target">
                    <xsl:value-of select="@target"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="not(contains(@nopadding,'yes'))">
                  <xsl:text>&#160;&#160;</xsl:text>
                </xsl:if>
                <xsl:apply-templates mode="taglib"/>
                <xsl:if test="not(contains(@nopadding,'yes'))">
                  <xsl:text>&#160;&#160;</xsl:text>
                </xsl:if>
              </A>
            </xsl:otherwise>
          </xsl:choose>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>


  <xsl:template match="i2:tabset" mode="taglib">
    <xsl:variable name="fillercolor">
      <xsl:choose>
        <xsl:when test="contains(@field,'grey')">Grey</xsl:when>
        <xsl:otherwise>White</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <TR>
        <TD width="3" class="tabScroller">
          <xsl:attribute name="id">tabPane<xsl:value-of select="$fillercolor"/></xsl:attribute>
          <A>
            <xsl:attribute name="href">javascript:i2uiScrollTabsRight('<xsl:value-of select="@id"/>')</xsl:attribute>
            <IMG border="0" style="display:none">
              <xsl:attribute name="id">
                <xsl:value-of select="@id"/>_tabscrollerleft</xsl:attribute>
              <xsl:attribute name="src">
                <xsl:value-of select="$imageDirectory"/>/arrow_tab_left.gif</xsl:attribute>
            </IMG>
          </A>
        </TD>
        <xsl:for-each select="i2:tab">
          <xsl:apply-templates select="." mode="taglib"/>
          <TD width="3" class="tabGap">
            <xsl:attribute name="id">tabPane<xsl:value-of select="$fillercolor"/></xsl:attribute>
            <xsl:text>&#160;</xsl:text>
          </TD>
        </xsl:for-each>
        <TD width="100%" class="tabScroller">
          <xsl:attribute name="id">tabPane<xsl:value-of select="$fillercolor"/></xsl:attribute>
          <xsl:text>&#160;</xsl:text>
        </TD>
        <TD width="3">
          <xsl:attribute name="class">tabFiller<xsl:value-of select="$fillercolor"/></xsl:attribute>
          <A>
            <xsl:attribute name="href">javascript:i2uiScrollTabsLeft('<xsl:value-of select="@id"/>')</xsl:attribute>
            <IMG border="0" style="display:none">
              <xsl:attribute name="id">
                <xsl:value-of select="@id"/>_tabscrollerright</xsl:attribute>
              <xsl:attribute name="src">
                <xsl:value-of select="$imageDirectory"/>/arrow_tab_right.gif</xsl:attribute>
            </IMG>
          </A>
        </TD>
      </TR>
    </TABLE>
    <SCRIPT>
      var <xsl:value-of select="@id"/>_allowed_width = 0;
    </SCRIPT>
  </xsl:template>
  <xsl:template match="i2:tabset" mode="taglibNS4">
    <xsl:variable name="fillercolor">
      <xsl:choose>
        <xsl:when test="contains(@field,'grey')">Grey</xsl:when>
        <xsl:otherwise>White</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE border="0" cellspacing="0" cellpadding="0">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <TR>
        <xsl:for-each select="i2:tab">
          <xsl:apply-templates select="." mode="taglibNS4"/>
          <TD width="3" class="tabGap">
            <xsl:attribute name="id">tabPane<xsl:value-of select="$fillercolor"/></xsl:attribute>
            <xsl:text>&#160;</xsl:text>
          </TD>
        </xsl:for-each>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:tabset" mode="taglibNS6">
    <xsl:variable name="fillercolor">
      <xsl:choose>
        <xsl:when test="contains(@field,'grey')">Grey</xsl:when>
        <xsl:otherwise>White</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE border="0" cellspacing="0" cellpadding="0">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <TR>
        <TD width="3" class="tabScroller">
          <xsl:attribute name="id">tabPane<xsl:value-of select="$fillercolor"/></xsl:attribute>
          <A>
            <xsl:attribute name="href">javascript:i2uiScrollTabsRight('<xsl:value-of select="@id"/>')</xsl:attribute>
            <IMG border="0" style="display:none">
              <xsl:attribute name="id">
                <xsl:value-of select="@id"/>_tabscrollerleft</xsl:attribute>
              <xsl:attribute name="src">
                <xsl:value-of select="$imageDirectory"/>/arrow_tab_left.gif</xsl:attribute>
            </IMG>
          </A>
        </TD>
        <xsl:for-each select="i2:tab">
          <xsl:apply-templates select="." mode="taglibNS6"/>
          <TD width="3" class="tabGap">
            <xsl:attribute name="id">tabPane<xsl:value-of select="$fillercolor"/></xsl:attribute>
            <xsl:text>&#160;&#160;&#160;</xsl:text>
          </TD>
        </xsl:for-each>
        <TD width="100%" class="tabScroller">
          <xsl:attribute name="id">tabPane<xsl:value-of select="$fillercolor"/></xsl:attribute>
          <xsl:text>&#160;</xsl:text>
        </TD>
        <TD width="3">
          <xsl:attribute name="class">tabFiller<xsl:value-of select="$fillercolor"/></xsl:attribute>
          <A>
            <xsl:attribute name="href">javascript:i2uiScrollTabsLeft('<xsl:value-of select="@id"/>')</xsl:attribute>
            <IMG border="0" style="display:none">
              <xsl:attribute name="id">
                <xsl:value-of select="@id"/>_tabscrollerright</xsl:attribute>
              <xsl:attribute name="src">
                <xsl:value-of select="$imageDirectory"/>/arrow_tab_right.gif</xsl:attribute>
            </IMG>
          </A>
        </TD>
      </TR>
    </TABLE>
    <SCRIPT>
      var <xsl:value-of select="@id"/>_allowed_width = 0;
    </SCRIPT>
  </xsl:template>


  <xsl:template match="i2:tab" mode="taglib">
    <xsl:variable name="gifcolor">
      <xsl:choose>
        <xsl:when test="contains(../@field,'grey')">grey</xsl:when>
        <xsl:otherwise>white</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state">
      <xsl:choose>
        <xsl:when test="contains(@selected,'yes')">tabSelected</xsl:when>
        <xsl:otherwise>tabUnSelected</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TD width="3" class="tabEdgeLeft" valign="top">
      <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/1x1_edge.gif)</xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="$state"/>
      </xsl:attribute>
      <IMG>
        <xsl:attribute name="src">
          <xsl:value-of select="$imageDirectory"/>/tab_corner_left_<xsl:value-of select="$gifcolor"/>.gif</xsl:attribute>
      </IMG>
    </TD>
    <TD class="tabText" nowrap="yes" valign="middle">
      <xsl:attribute name="width">
        <xsl:choose>
          <xsl:when test="../@mintabwidth">
            <xsl:value-of select="../@mintabwidth"/>
          </xsl:when>
          <xsl:otherwise>6%</xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$state"/>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="$state"/>
      </xsl:attribute>
      <A class="tabText">
        <xsl:attribute name="id">
          <xsl:value-of select="$state"/>
        </xsl:attribute>
        <xsl:if test="@target">
          <xsl:attribute name="target">
            <xsl:value-of select="@target"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="../@onclick">
            <xsl:attribute name="onmouseover">javascript:this.style.cursor='hand';</xsl:attribute>
            <xsl:attribute name="onclick">javascript:if (<xsl:value-of select="../@onclick"/>){i2uiToggleTab('<xsl:value-of select="../@id"/>',&quot;<xsl:value-of select="@alttext"/>&quot;,this); <xsl:value-of select="@onclick"/>}</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="href">
              <xsl:value-of select="@onclick"/>
            </xsl:attribute>
            <xsl:attribute name="onclick">javascript:i2uiToggleTab('<xsl:value-of select="../@id"/>',&quot;<xsl:value-of select="@alttext"/>&quot;,this)</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>&#160;</xsl:text>
      </A>
    </TD>
    <TD width="5" class="tabEdgeRight" valign="top" align="right">
      <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/tab_shadow.gif)</xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="$state"/>
      </xsl:attribute>
      <IMG>
        <xsl:attribute name="src">
          <xsl:value-of select="$imageDirectory"/>/tab_corner_right_<xsl:value-of select="$gifcolor"/>.gif</xsl:attribute>
      </IMG>
    </TD>
  </xsl:template>
  <xsl:template match="i2:tab" mode="taglibNS4">
    <xsl:variable name="gifcolor">
      <xsl:choose>
        <xsl:when test="contains(../@field,'grey')">grey</xsl:when>
        <xsl:otherwise>white</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state">
      <xsl:choose>
        <xsl:when test="contains(@selected,'yes')">tabSelected</xsl:when>
        <xsl:otherwise>tabUnSelected</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TD class="tabCorner" width="4" valign="top">
      <xsl:attribute name="id">
        <xsl:value-of select="$state"/>
      </xsl:attribute>
      <IMG width="4" height="4">
        <xsl:attribute name="src">
          <xsl:value-of select="$imageDirectory"/>/tab_corner_left_<xsl:value-of select="$gifcolor"/>_ns.gif</xsl:attribute>
      </IMG>
    </TD>
    <TD class="tabTextNS4" nowrap="yes">
      <xsl:attribute name="id">
        <xsl:value-of select="$state"/>
      </xsl:attribute>
      <A class="tabTextNS4">
        <xsl:attribute name="id">
          <xsl:value-of select="$state"/>
        </xsl:attribute>
        <xsl:if test="@target">
          <xsl:attribute name="target">
            <xsl:value-of select="@target"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="../@onclick">
            <xsl:attribute name="href">javascript:void i2uiToggleTabNoop();</xsl:attribute>
            <xsl:attribute name="onclick">javascript:if (<xsl:value-of select="../@onclick"/>){i2uiToggleTab('<xsl:value-of select="../@id"/>',&quot;<xsl:value-of select="@alttext"/>&quot;,this); <xsl:value-of select="substring-after(@onclick,'javascript:')"/>}</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="href">
              <xsl:value-of select="@onclick"/>
            </xsl:attribute>
            <xsl:attribute name="onclick">javascript:i2uiToggleTab('<xsl:value-of select="../@id"/>',&quot;<xsl:value-of select="@alttext"/>&quot;,this)</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#160;&#160;</xsl:text>
        <xsl:if test="contains(@selected,'yes')">
          <xsl:text>&#160;</xsl:text>
        </xsl:if>
        <xsl:value-of select="."/>
        <xsl:text>&#160;&#160;</xsl:text>
        <xsl:if test="contains(@selected,'yes')">
          <xsl:text>&#160;</xsl:text>
        </xsl:if>
      </A>
    </TD>
    <TD width="4" class="tabCorner" valign="top" align="right">
      <xsl:attribute name="id">
        <xsl:value-of select="$state"/>
      </xsl:attribute>
      <IMG width="4" height="4">
        <xsl:attribute name="src">
          <xsl:value-of select="$imageDirectory"/>/tab_corner_right_<xsl:value-of select="$gifcolor"/>_ns.gif</xsl:attribute>
      </IMG>
    </TD>
  </xsl:template>
  <xsl:template match="i2:tab" mode="taglibNS6">
    <xsl:variable name="gifcolor">
      <xsl:choose>
        <xsl:when test="contains(../@field,'grey')">grey</xsl:when>
        <xsl:otherwise>white</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="state">
      <xsl:choose>
        <xsl:when test="contains(@selected,'yes')">tabSelectedNS6</xsl:when>
        <xsl:otherwise>tabUnSelected</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TD width="3" class="tabEdgeLeft" valign="top">
      <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/1x1_edge.gif)</xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="$state"/>
      </xsl:attribute>
      <IMG>
        <xsl:attribute name="src">
          <xsl:value-of select="$imageDirectory"/>/tab_corner_left_<xsl:value-of select="$gifcolor"/>.gif</xsl:attribute>
      </IMG>
    </TD>
    <TD class="tabTextNS4" nowrap="yes" valign="middle">
      <xsl:attribute name="width">
        <xsl:choose>
          <xsl:when test="../@mintabwidth">
            <xsl:value-of select="../@mintabwidth"/>
          </xsl:when>
          <xsl:otherwise>6%</xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$state"/>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="$state"/>
      </xsl:attribute>
      <A class="tabTextNS4">
        <xsl:if test="@target">
          <xsl:attribute name="target">
            <xsl:value-of select="@target"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="../@onclick">
            <xsl:attribute name="onmouseover">javascript:this.style.cursor='hand';</xsl:attribute>
            <xsl:attribute name="onclick">javascript:if (<xsl:value-of select="../@onclick"/>){i2uiToggleTab('<xsl:value-of select="../@id"/>',&quot;<xsl:value-of select="@alttext"/>&quot;,this); <xsl:value-of select="@onclick"/>}</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="href">
              <xsl:value-of select="@onclick"/>
            </xsl:attribute>
            <xsl:attribute name="onclick">javascript:i2uiToggleTab('<xsl:value-of select="../@id"/>',&quot;<xsl:value-of select="@alttext"/>&quot;,this)</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>&#160;</xsl:text>
      </A>
    </TD>
    <TD class="tabEdgeRight" valign="top" align="right">
      <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/tab_shadow.gif)</xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="$state"/>
      </xsl:attribute>
      <IMG>
        <xsl:attribute name="src">
          <xsl:value-of select="$imageDirectory"/>/tab_corner_right_<xsl:value-of select="$gifcolor"/>.gif</xsl:attribute>
      </IMG>
    </TD>
  </xsl:template>


  <xsl:template match="i2:container[@footer]" mode="taglib">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="headerclass">
      <xsl:choose>
        <xsl:when test="@inner = 'yes'">containerInner</xsl:when>
        <xsl:otherwise>
          <xsl:text>containerOuter</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="0" cellpadding="0" class="shadow">
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <TR>
        <xsl:choose>
          <xsl:when test="./i2:header">
            <TD>
              <TABLE border="0" cellspacing="0" cellpadding="0">
                <TR>
                  <TD width="100%" class="containerHeaderLeft" nowrap="yes">
                    <xsl:attribute name="id">
                      <xsl:value-of select="$headerclass"/>
                    </xsl:attribute>
                    <xsl:if test="contains(@collapsable,'yes')">
                      <xsl:attribute name="style">padding-top:2px;padding-bottom:4px;</xsl:attribute>
                    </xsl:if>
                    <xsl:if test="contains(@collapsable,'yes')">
                      <xsl:text>&#160;&#160;</xsl:text>
                      <IMG onclick="javascript:i2uiToggleContent(this,2)" onMouseOver="javascript:this.style.cursor='hand'">
                        <xsl:attribute name="src">
                          <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                      </IMG>
                    </xsl:if>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
                    <xsl:if test="@titlesuffix">
                      <xsl:text>&#160;</xsl:text>
                      <SPAN style="font-weight:normal">
                        <xsl:value-of select="@titlesuffix"/>
                      </SPAN>
                    </xsl:if>
                  </TD>
                  <TD align="right" class="containerHeaderRight" nowrap="yes">
                    <xsl:attribute name="id">
                      <xsl:value-of select="$headerclass"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="i2:header" mode="complextaglib"/>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </xsl:when>
          <xsl:otherwise>
            <TD width="100%" class="containerHeader" nowrap="yes">
              <xsl:attribute name="id">
                <xsl:value-of select="$headerclass"/>
              </xsl:attribute>
              <xsl:if test="contains(@collapsable,'yes')">
                <xsl:attribute name="style">padding-top:2px;padding-bottom:4px;</xsl:attribute>
              </xsl:if>
              <xsl:if test="contains(@collapsable,'yes')">
                <xsl:text>&#160;&#160;</xsl:text>
                <IMG onclick="javascript:i2uiToggleContent(this,1)" onMouseOver="javascript:this.style.cursor='hand'">
                  <xsl:attribute name="src">
                    <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                </IMG>
              </xsl:if>
              <xsl:text>&#160;</xsl:text>
              <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
              <xsl:if test="@titlesuffix">
                <xsl:text>&#160;</xsl:text>
                <SPAN style="font-weight:normal">
                  <xsl:value-of select="@titlesuffix"/>
                </SPAN>
              </xsl:if>
            </TD>
          </xsl:otherwise>
        </xsl:choose>
      </TR>
      <TBODY id="_containerBody">
        <TR>
          <TD>
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="contains(@indentcontent,'yes') and not(contains(@scrollable,'yes'))">containerBodyIndent</xsl:when>
                <xsl:otherwise>containerBody</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="contains(@scrollable,'yes')">
                <DIV>
                  <xsl:if test="contains(@indentcontent,'yes')">
                    <xsl:attribute name="class">containerBodyIndentScrolling</xsl:attribute>
                  </xsl:if>
                  <xsl:attribute name="style">
                    <xsl:if test="@height">height:<xsl:value-of select="@height"/>;</xsl:if>overflow:auto;</xsl:attribute>
                  <xsl:if test="@id">
                    <xsl:attribute name="id">
                      <xsl:value-of select="@id"/>_scroller</xsl:attribute>
                  </xsl:if>
                  <xsl:apply-templates mode="taglib"/>
                </DIV>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates mode="taglib"/>
              </xsl:otherwise>
            </xsl:choose>
          </TD>
        </TR>
        <TR>
          <TD class="containerFooter">
            <xsl:attribute name="id">
              <xsl:value-of select="$headerclass"/>
            </xsl:attribute>
            <xsl:text>&#160;</xsl:text>
            <xsl:value-of select="@footer"/>
          </TD>
        </TR>
      </TBODY>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:container[@footer]" mode="taglibNS6">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="headerclass">
      <xsl:choose>
        <xsl:when test="@inner = 'yes'">containerInner</xsl:when>
        <xsl:otherwise>
          <xsl:text>containerOuter</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="0" cellpadding="0" class="shadow">
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <TR>
        <xsl:choose>
          <xsl:when test="./i2:header">
            <TD>
              <TABLE border="0" cellspacing="0" cellpadding="0">
                <TR>
                  <TD width="100%" class="containerHeaderLeft" nowrap="yes">
                    <xsl:attribute name="id">
                      <xsl:value-of select="$headerclass"/>
                    </xsl:attribute>
                    <xsl:if test="contains(@collapsable,'yes')">
                      <xsl:attribute name="style">padding-top:2px;padding-bottom:4px;</xsl:attribute>
                    </xsl:if>
                    <xsl:if test="contains(@collapsable,'yes')">
                      <xsl:text>&#160;&#160;</xsl:text>
                      <IMG onclick="javascript:i2uiToggleContent(this,2)" onMouseOver="javascript:this.style.cursor='hand'">
                        <xsl:attribute name="src">
                          <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                      </IMG>
                    </xsl:if>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
                    <xsl:if test="@titlesuffix">
                      <xsl:text>&#160;</xsl:text>
                      <SPAN style="font-weight:normal">
                        <xsl:value-of select="@titlesuffix"/>
                      </SPAN>
                    </xsl:if>
                  </TD>
                  <TD align="right" class="containerHeaderRight" nowrap="yes">
                    <xsl:attribute name="id">
                      <xsl:value-of select="$headerclass"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="i2:header" mode="complextaglibNS6"/>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </xsl:when>
          <xsl:otherwise>
            <TD width="100%" class="containerHeader" nowrap="yes">
              <xsl:attribute name="id">
                <xsl:value-of select="$headerclass"/>
              </xsl:attribute>
              <xsl:if test="contains(@collapsable,'yes')">
                <xsl:attribute name="style">padding-top:2px;padding-bottom:4px;</xsl:attribute>
              </xsl:if>
              <xsl:if test="contains(@collapsable,'yes')">
                <xsl:text>&#160;&#160;</xsl:text>
                <IMG onclick="javascript:i2uiToggleContent(this,1)" onMouseOver="javascript:this.style.cursor='hand'">
                  <xsl:attribute name="src">
                    <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                </IMG>
              </xsl:if>
              <xsl:text>&#160;</xsl:text>
              <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
              <xsl:if test="@titlesuffix">
                <xsl:text>&#160;</xsl:text>
                <SPAN style="font-weight:normal">
                  <xsl:value-of select="@titlesuffix"/>
                </SPAN>
              </xsl:if>
            </TD>
          </xsl:otherwise>
        </xsl:choose>
      </TR>
      <TBODY id="_containerBody">
        <TR>
          <TD>
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="contains(@indentcontent,'yes')">containerBodyIndent</xsl:when>
                <xsl:otherwise>containerBody</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="contains(@scrollable,'yes')">
                <DIV>
                  <xsl:attribute name="style">
                    <xsl:if test="@height">height:<xsl:value-of select="@height"/>;</xsl:if>overflow:auto;</xsl:attribute>
                  <xsl:if test="@id">
                    <xsl:attribute name="id">
                      <xsl:value-of select="@id"/>_scroller</xsl:attribute>
                  </xsl:if>
                  <xsl:apply-templates mode="taglibNS6"/>
                </DIV>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates mode="taglibNS6"/>
              </xsl:otherwise>
            </xsl:choose>
          </TD>
        </TR>
        <TR>
          <TD class="containerFooterNS">
            <xsl:attribute name="id">
              <xsl:value-of select="$headerclass"/>
            </xsl:attribute>
            <xsl:text>&#160;</xsl:text>
            <xsl:value-of select="@footer"/>
          </TD>
        </TR>
      </TBODY>
    </TABLE>
  </xsl:template>


  <xsl:template match="i2:container" mode="taglib">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="headerclass">
      <xsl:choose>
        <xsl:when test="@inner = 'yes'">containerInner</xsl:when>
        <xsl:otherwise>
          <xsl:text>containerOuter</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="0" cellpadding="0" class="shadow">
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <TR>
        <xsl:choose>
          <xsl:when test="./i2:header">
            <TD>
              <TABLE border="0" cellspacing="0" cellpadding="0">
                <TR>
                  <TD width="100%" class="containerHeaderLeft" nowrap="yes">
                    <xsl:attribute name="id">
                      <xsl:value-of select="$headerclass"/>
                    </xsl:attribute>
                    <xsl:if test="contains(@collapsable,'yes')">
                      <xsl:attribute name="style">padding-top:2px;padding-bottom:4px;</xsl:attribute>
                    </xsl:if>
                    <xsl:if test="contains(@collapsable,'yes')">
                      <xsl:text>&#160;&#160;</xsl:text>
                      <IMG onclick="javascript:i2uiToggleContent(this,2)" onMouseOver="javascript:this.style.cursor='hand'">
                        <xsl:attribute name="src">
                          <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                      </IMG>
                    </xsl:if>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
                    <xsl:if test="@titlesuffix">
                      <xsl:text>&#160;</xsl:text>
                      <SPAN style="font-weight:normal">
                        <xsl:value-of select="@titlesuffix"/>
                      </SPAN>
                    </xsl:if>
                  </TD>
                  <TD align="right" class="containerHeaderRight" nowrap="yes">
                    <xsl:attribute name="id">
                      <xsl:value-of select="$headerclass"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="i2:header" mode="complextaglib"/>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="classname">
              <xsl:choose>
                <xsl:when test="contains(@collapsable,'yes') or string-length(@title) &gt; 0">containerHeader</xsl:when>
                <xsl:otherwise>containerHeaderless</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <TD width="100%" nowrap="yes">
              <xsl:attribute name="id">
                <xsl:value-of select="$headerclass"/>
              </xsl:attribute>
              <xsl:attribute name="class">
                <xsl:value-of select="$classname"/>
              </xsl:attribute>
              <xsl:if test="contains(@collapsable,'yes')">
                <xsl:attribute name="style">padding-top:2px;padding-bottom:4px;</xsl:attribute>
              </xsl:if>
              <xsl:if test="contains(@collapsable,'yes')">
                <xsl:text>&#160;&#160;</xsl:text>
                <IMG onclick="javascript:i2uiToggleContent(this,1)" onMouseOver="javascript:this.style.cursor='hand'">
                  <xsl:attribute name="src">
                    <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                </IMG>
              </xsl:if>
              <xsl:text>&#160;</xsl:text>
              <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
              <xsl:if test="@titlesuffix">
                <xsl:text>&#160;</xsl:text>
                <SPAN style="font-weight:normal">
                  <xsl:value-of select="@titlesuffix"/>
                </SPAN>
              </xsl:if>
            </TD>
          </xsl:otherwise>
        </xsl:choose>
      </TR>
      <TBODY id="_containerBody">
        <TR>
          <TD>
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="contains(@indentcontent,'yes') and not(contains(@scrollable,'yes'))">containerBodyIndent</xsl:when>
                <xsl:otherwise>containerBody</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="contains(@scrollable,'yes')">
                <DIV>
                  <xsl:if test="contains(@indentcontent,'yes')">
                    <xsl:attribute name="class">containerBodyIndentScrolling</xsl:attribute>
                  </xsl:if>
                  <xsl:attribute name="style">
                    <xsl:if test="@height">height:<xsl:value-of select="@height"/>;</xsl:if>overflow:auto</xsl:attribute>
                  <xsl:if test="@id">
                    <xsl:attribute name="id">
                      <xsl:value-of select="@id"/>_scroller</xsl:attribute>
                  </xsl:if>
                  <xsl:apply-templates mode="taglib"/>
                </DIV>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates mode="taglib"/>
              </xsl:otherwise>
            </xsl:choose>
          </TD>
        </TR>
        <xsl:choose>
          <xsl:when test="./i2:footer">
            <xsl:apply-templates select="i2:footer" mode="complextaglib"/>
          </xsl:when>
          <xsl:otherwise>
            <TR height="1">
              <TD height="1" class="containerBorder">
              </TD>
            </TR>
          </xsl:otherwise>
        </xsl:choose>
      </TBODY>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:container" mode="taglibNS4">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="colspan">
      <xsl:choose>
        <xsl:when test="./i2:header">2</xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="classname">
      <xsl:choose>
        <xsl:when test="contains(@collapsable,'yes') or string-length(@title) &gt; 0">containerHeader</xsl:when>
        <xsl:otherwise>containerHeaderless</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="headerclass">
      <xsl:choose>
        <xsl:when test="@inner = 'yes'">containerInner</xsl:when>
        <xsl:otherwise>
          <xsl:text>containerOuter</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="0" cellpadding="0" class="containerBorder">
      <TR>
        <xsl:choose>
          <xsl:when test="./i2:header">
            <TD width="100%" class="containerHeaderLeftNS4" nowrap="yes">
              <xsl:attribute name="id">
                <xsl:value-of select="$headerclass"/>
              </xsl:attribute>
              <xsl:text>&#160;</xsl:text>
              <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
              <xsl:if test="@titlesuffix">
                <xsl:text>&#160;</xsl:text>
                <SPAN style="font-weight:normal">
                  <xsl:value-of select="@titlesuffix"/>
                </SPAN>
              </xsl:if>
            </TD>
            <TD align="right" class="containerHeaderRightNS4" nowrap="yes">
              <xsl:attribute name="id">
                <xsl:value-of select="$headerclass"/>
              </xsl:attribute>
              <xsl:apply-templates select="i2:header" mode="complextaglibNS4"/>
            </TD>
          </xsl:when>
          <xsl:otherwise>
            <TD width="100%" nowrap="yes">
              <xsl:attribute name="id">
                <xsl:value-of select="$headerclass"/>
              </xsl:attribute>
              <xsl:attribute name="class">
                <xsl:value-of select="$classname"/>
              </xsl:attribute>
              <xsl:text>&#160;</xsl:text>
              <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
              <xsl:if test="@titlesuffix">
                <xsl:text>&#160;</xsl:text>
                <SPAN style="font-weight:normal">
                  <xsl:value-of select="@titlesuffix"/>
                </SPAN>
              </xsl:if>
            </TD>
          </xsl:otherwise>
        </xsl:choose>
      </TR>
      <TR>
        <TD>
          <xsl:attribute name="colspan">
            <xsl:value-of select="$colspan"/>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>containerBody</xsl:text>
            <xsl:if test="descendant::i2:table">NS4</xsl:if>
          </xsl:attribute>
          <xsl:apply-templates mode="taglibNS4"/>
        </TD>
      </TR>
      <xsl:choose>
        <xsl:when test="@footer">
          <TR>
            <TD class="containerFooterNS">
              <xsl:attribute name="id">
                <xsl:value-of select="$headerclass"/>
              </xsl:attribute>
              <xsl:text>&#160;</xsl:text>
              <xsl:value-of select="@footer"/>
            </TD>
          </TR>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="i2:footer" mode="complextaglibNS4"/>
        </xsl:otherwise>
      </xsl:choose>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:container" mode="taglibNS6">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="headerclass">
      <xsl:choose>
        <xsl:when test="@inner = 'yes'">containerInner</xsl:when>
        <xsl:otherwise>
          <xsl:text>containerOuter</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="0" cellpadding="0" class="shadow">
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <TR>
        <xsl:choose>
          <xsl:when test="./i2:header">
            <TD>
              <TABLE border="0" cellspacing="0" cellpadding="0">
                <TR>
                  <TD width="100%" class="containerHeaderLeft" nowrap="yes">
                    <xsl:attribute name="id">
                      <xsl:value-of select="$headerclass"/>
                    </xsl:attribute>
                    <xsl:if test="contains(@collapsable,'yes')">
                      <xsl:attribute name="style">padding-top:2px;padding-bottom:4px;</xsl:attribute>
                    </xsl:if>
                    <xsl:if test="contains(@collapsable,'yes')">
                      <xsl:text>&#160;&#160;</xsl:text>
                      <IMG onclick="javascript:i2uiToggleContent(this,2)" onMouseOver="javascript:this.style.cursor='hand'">
                        <xsl:attribute name="src">
                          <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                      </IMG>
                    </xsl:if>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
                    <xsl:if test="@titlesuffix">
                      <xsl:text>&#160;</xsl:text>
                      <SPAN style="font-weight:normal">
                        <xsl:value-of select="@titlesuffix"/>
                      </SPAN>
                    </xsl:if>
                  </TD>
                  <TD align="right" class="containerHeaderRight" nowrap="yes">
                    <xsl:attribute name="id">
                      <xsl:value-of select="$headerclass"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="i2:header" mode="complextaglibNS6"/>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="classname">
              <xsl:choose>
                <xsl:when test="contains(@collapsable,'yes') or string-length(@title) &gt; 0">containerHeader</xsl:when>
                <xsl:otherwise>containerHeaderless</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <TD width="100%" nowrap="yes">
              <xsl:attribute name="id">
                <xsl:value-of select="$headerclass"/>
              </xsl:attribute>
              <xsl:attribute name="class">
                <xsl:value-of select="$classname"/>
              </xsl:attribute>
              <xsl:if test="contains(@collapsable,'yes')">
                <xsl:attribute name="style">padding-top:2px;padding-bottom:4px;</xsl:attribute>
              </xsl:if>
              <xsl:if test="contains(@collapsable,'yes')">
                <xsl:text>&#160;&#160;</xsl:text>
                <IMG onclick="javascript:i2uiToggleContent(this,1)" onMouseOver="javascript:this.style.cursor='hand'">
                  <xsl:attribute name="src">
                    <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                </IMG>
              </xsl:if>
              <xsl:text>&#160;</xsl:text>
              <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
              <xsl:if test="@titlesuffix">
                <xsl:text>&#160;</xsl:text>
                <SPAN style="font-weight:normal">
                  <xsl:value-of select="@titlesuffix"/>
                </SPAN>
              </xsl:if>
            </TD>
          </xsl:otherwise>
        </xsl:choose>
      </TR>
      <TBODY id="_containerBody">
        <TR>
          <TD>
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="contains(@indentcontent,'yes')">containerBodyIndent</xsl:when>
                <xsl:otherwise>containerBody</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="contains(@scrollable,'yes')">
                <DIV>
                  <xsl:attribute name="style">
                    <xsl:if test="@height">height:<xsl:value-of select="@height"/>;</xsl:if>overflow:auto</xsl:attribute>
                  <xsl:if test="@id">
                    <xsl:attribute name="id">
                      <xsl:value-of select="@id"/>_scroller</xsl:attribute>
                  </xsl:if>
                  <xsl:apply-templates mode="taglibNS6"/>
                </DIV>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates mode="taglibNS6"/>
              </xsl:otherwise>
            </xsl:choose>
          </TD>
        </TR>
        <xsl:choose>
          <xsl:when test="./i2:footer">
            <xsl:apply-templates select="i2:footer" mode="complextaglibNS6"/>
          </xsl:when>
          <xsl:otherwise>
            <TR height="1">
              <TD height="1" class="containerBorder">
              </TD>
            </TR>
          </xsl:otherwise>
        </xsl:choose>
      </TBODY>
    </TABLE>
  </xsl:template>


  <xsl:template match="i2:footer" mode="taglib">
  </xsl:template>
  <xsl:template match="i2:footer" mode="taglibNS4">
  </xsl:template>
  <xsl:template match="i2:footer" mode="taglibNS6">
  </xsl:template>


  <xsl:template match="i2:footer" mode="complextaglib">
    <TR>
      <TD class="containerFooter">
        <xsl:attribute name="id">
          <xsl:choose>
            <xsl:when test="../@inner = 'yes'">containerInner</xsl:when>
            <xsl:otherwise>
              <xsl:text>containerOuter</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="colspan">
          <xsl:choose>
            <xsl:when test="../i2:header">2</xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:apply-templates mode="taglib"/>
      </TD>
    </TR>
  </xsl:template>
  <xsl:template match="i2:footer" mode="complextaglibNS4">
    <TR>
      <TD class="containerFooterNS">
        <xsl:attribute name="id">
          <xsl:choose>
            <xsl:when test="../@inner = 'yes'">containerInner</xsl:when>
            <xsl:otherwise>
              <xsl:text>containerOuter</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="colspan">
          <xsl:choose>
            <xsl:when test="../i2:header">2</xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:apply-templates mode="taglibNS4"/>
      </TD>
    </TR>
  </xsl:template>
  <xsl:template match="i2:footer" mode="complextaglibNS6">
    <TR>
      <TD class="containerFooterNS">
        <xsl:attribute name="id">
          <xsl:choose>
            <xsl:when test="../@inner = 'yes'">containerInner</xsl:when>
            <xsl:otherwise>
              <xsl:text>containerOuter</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="colspan">
          <xsl:choose>
            <xsl:when test="../i2:header">2</xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:apply-templates mode="taglibNS6"/>
      </TD>
    </TR>
  </xsl:template>


  <xsl:template match="i2:header" mode="taglib">
  </xsl:template>
  <xsl:template match="i2:header" mode="taglibNS4">
  </xsl:template>
  <xsl:template match="i2:header" mode="taglibNS6">
  </xsl:template>


  <xsl:template match="i2:header" mode="complextaglib">
    <xsl:apply-templates mode="taglib"/>
  </xsl:template>
  <xsl:template match="i2:header" mode="complextaglibNS4">
    <xsl:apply-templates mode="taglibNS4"/>
  </xsl:template>
  <xsl:template match="i2:header" mode="complextaglibNS6">
    <xsl:apply-templates mode="taglibNS6"/>
  </xsl:template>


  <xsl:template match="i2:tabbedcontainer" mode="taglib">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="0" cellpadding="0">
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <TR width="100%">
        <TD valign="top">
          <xsl:apply-templates select="i2:tabset" mode="taglib"/>
        </TD>
      </TR>
      <TR>
        <TD id="tabSelected">
          <TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="shadow">
            <TR>
              <xsl:choose>
                <xsl:when test="./i2:header">

                  <TD>
                    <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                      <TR>

                        <TD width="100%" nowrap="yes" class="tabContainerHeaderLeft" id="tabSelected">
                          <xsl:if test="contains(@collapsable,'yes')">
                            <xsl:attribute name="style">padding:2px;</xsl:attribute>
                            <xsl:text>&#160;</xsl:text>
                            <IMG onclick="javascript:i2uiToggleContent(this,2)" onMouseOver="javascript:this.style.cursor='hand'">
                              <xsl:attribute name="src">
                                <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                            </IMG>
                          </xsl:if>
                          <xsl:text>&#160;</xsl:text>
                          <SPAN>
                            <xsl:attribute name="id">
                              <xsl:value-of select="i2:tabset/@id"/>_description</xsl:attribute>
                            <xsl:value-of select="i2:tabset/i2:tab[@selected]/@alttext"/>
                          </SPAN>
                        </TD>
                        <TD align="right" class="tabContainerHeaderRight" id="tabSelected" nowrap="yes">
                          <xsl:apply-templates select="i2:header" mode="complextaglib"/>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                </xsl:when>
                <xsl:otherwise>
                  <TD nowrap="yes" class="tabContainerHeader">
                    <xsl:attribute name="class">
                      <xsl:choose>
                        <xsl:when test="i2:tabset/i2:tab[@alttext] or @collapsable='yes'">tabContainerHeader</xsl:when>
                        <xsl:otherwise>tabContainerHeaderThin</xsl:otherwise>
                      </xsl:choose>
                    </xsl:attribute>
                    <xsl:if test="contains(@collapsable,'yes')">
                      <xsl:attribute name="style">padding:2px</xsl:attribute>
                      <xsl:text>&#160;</xsl:text>
                      <IMG onclick="javascript:i2uiToggleContent(this,1)" onMouseOver="javascript:this.style.cursor='hand'">
                        <xsl:attribute name="src">
                          <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                      </IMG>
                    </xsl:if>
                    <xsl:text>&#160;</xsl:text>
                    <SPAN>
                      <xsl:attribute name="id">
                        <xsl:value-of select="i2:tabset/@id"/>_description</xsl:attribute>
                      <xsl:value-of select="i2:tabset/i2:tab[@selected]/@alttext"/>
                    </SPAN>
                  </TD>
                </xsl:otherwise>
              </xsl:choose>
            </TR>
            <TBODY id="containerbody">
              <TR>
                <TD>
                  <xsl:attribute name="class">
                    <xsl:choose>
                      <xsl:when test="contains(@indentcontent,'yes')">containerBodyIndent</xsl:when>
                      <xsl:otherwise>containerBody</xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
                  <xsl:choose>
                    <xsl:when test="contains(@scrollable,'yes')">
                      <DIV>
                        <xsl:attribute name="style">
                          <xsl:if test="@height">height:<xsl:value-of select="@height"/>;</xsl:if>overflow:auto;</xsl:attribute>
                        <xsl:if test="@id">
                          <xsl:attribute name="id">
                            <xsl:value-of select="@id"/>_scroller</xsl:attribute>
                        </xsl:if>
                        <xsl:apply-templates select="*[not(self::i2:tabset)]" mode="taglib"/>
                      </DIV>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:apply-templates select="*[not(self::i2:tabset)]" mode="taglib"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </TD>
              </TR>
              <xsl:choose>
                <xsl:when test="./i2:footer">
                  <xsl:apply-templates select="i2:footer" mode="complextaglib"/>
                </xsl:when>
                <xsl:otherwise>
                  <TR>
                    <TD class="containerFooterThin">
                      <xsl:text>&#160;</xsl:text>
                    </TD>
                  </TR>
                </xsl:otherwise>
              </xsl:choose>
            </TBODY>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:tabbedcontainer" mode="taglibNS4">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="0" cellpadding="0">
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <TR width="100%">
        <TD valign="top">
          <xsl:apply-templates select="i2:tabset" mode="taglibNS4"/>
        </TD>
      </TR>
      <TR>
        <TD id="tabSelected">
          <TABLE border="0" cellspacing="2" cellpadding="2" width="100%">
            <TR>
              <TD>
                <xsl:attribute name="class">
                  <xsl:choose>
                    <xsl:when test="i2:tabset/i2:tab[@alttext]">tabContainerHeaderNS4</xsl:when>
                    <xsl:otherwise>tabContainerHeaderThinNS4</xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:text>&#160;</xsl:text>
                <xsl:if test="i2:tabset/i2:tab[@alttext]">
                  <ILAYER>
                    <xsl:attribute name="id">
                      <xsl:value-of select="i2:tabset/@id"/>
                    </xsl:attribute>
                    <xsl:value-of select="i2:tabset/i2:tab[@selected]/@alttext"/>
                  </ILAYER>
                </xsl:if>
              </TD>
            </TR>
            <TR>
              <TD>
                <xsl:attribute name="class">
                  <xsl:text>containerBody</xsl:text>
                  <xsl:if test="descendant::i2:table">NS4</xsl:if>
                </xsl:attribute>
                <xsl:apply-templates select="*[not(self::i2:tabset)]" mode="taglibNS4"/>
              </TD>
            </TR>
            <xsl:choose>
              <xsl:when test="./i2:footer">
                <xsl:apply-templates select="i2:footer" mode="complextaglibNS4"/>
              </xsl:when>
              <xsl:otherwise>
                <TR>
                  <TD class="containerFooterThinNS4">
                    <xsl:text>&#160;</xsl:text>
                  </TD>
                </TR>
              </xsl:otherwise>
            </xsl:choose>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:tabbedcontainer" mode="taglibNS6">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="0" cellpadding="0">
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <TR width="100%">
        <TD valign="top">
          <xsl:apply-templates select="i2:tabset" mode="taglibNS6"/>
        </TD>
      </TR>
      <TR>
        <TD id="tabSelected">
          <TABLE border="0" cellspacing="0" cellpadding="2" width="100%" class="shadow">
            <TR>
              <xsl:choose>
                <xsl:when test="./i2:header">

                  <TD>
                    <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
                      <TR>

                        <TD width="100%" nowrap="yes" class="tabContainerHeaderLeft" id="tabSelected">
                          <xsl:if test="contains(@collapsable,'yes')">
                            <xsl:attribute name="style">padding:2px;</xsl:attribute>
                            <xsl:text>&#160;</xsl:text>
                            <IMG onclick="javascript:i2uiToggleContent(this,2)" onMouseOver="javascript:this.style.cursor='hand'">
                              <xsl:attribute name="src">
                                <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                            </IMG>
                          </xsl:if>
                          <xsl:text>&#160;</xsl:text>
                          <SPAN>
                            <xsl:attribute name="id">
                              <xsl:value-of select="i2:tabset/@id"/>_description</xsl:attribute>
                            <xsl:value-of select="i2:tabset/i2:tab[@selected]/@alttext"/>
                          </SPAN>
                        </TD>
                        <TD align="right" class="tabContainerHeaderRight" id="tabSelected" nowrap="yes">
                          <xsl:apply-templates select="i2:header" mode="complextaglibNS6"/>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                </xsl:when>
                <xsl:otherwise>
                  <TD nowrap="yes" class="tabContainerHeader">
                    <xsl:attribute name="class">
                      <xsl:choose>
                        <xsl:when test="i2:tabset/i2:tab[@alttext] or @collapsable='yes'">tabContainerHeaderNS4</xsl:when>
                        <xsl:otherwise>tabContainerHeaderThinNS4</xsl:otherwise>
                      </xsl:choose>
                    </xsl:attribute>
                    <xsl:if test="contains(@collapsable,'yes')">
                      <xsl:attribute name="style">padding:2px</xsl:attribute>
                      <xsl:text>&#160;</xsl:text>
                      <IMG onclick="javascript:i2uiToggleContent(this,1)" onMouseOver="javascript:this.style.cursor='hand'">
                        <xsl:attribute name="src">
                          <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                      </IMG>
                    </xsl:if>
                    <xsl:text>&#160;</xsl:text>
                    <SPAN>
                      <xsl:attribute name="id">
                        <xsl:value-of select="i2:tabset/@id"/>_description</xsl:attribute>
                      <xsl:value-of select="i2:tabset/i2:tab[@selected]/@alttext"/>
                    </SPAN>
                  </TD>
                </xsl:otherwise>
              </xsl:choose>
            </TR>
            <TBODY id="containerbody">
              <TR>
                <TD>
                  <xsl:attribute name="class">
                    <xsl:choose>
                      <xsl:when test="contains(@indentcontent,'yes')">containerBodyIndent</xsl:when>
                      <xsl:otherwise>containerBody</xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
                  <xsl:choose>
                    <xsl:when test="contains(@scrollable,'yes')">
                      <DIV>
                        <xsl:attribute name="style">
                          <xsl:if test="@height">height:<xsl:value-of select="@height"/>;</xsl:if>overflow:auto;</xsl:attribute>
                        <xsl:if test="@id">
                          <xsl:attribute name="id">
                            <xsl:value-of select="@id"/>_scroller</xsl:attribute>
                        </xsl:if>
                        <xsl:apply-templates select="*[not(self::i2:tabset)]" mode="taglibNS6"/>
                      </DIV>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:apply-templates select="*[not(self::i2:tabset)]" mode="taglibNS6"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </TD>
              </TR>
              <xsl:choose>
                <xsl:when test="./i2:footer">
                  <xsl:apply-templates select="i2:footer" mode="complextaglibNS6"/>
                </xsl:when>
                <xsl:otherwise>
                  <TR>
                    <TD class="containerFooterThinNS4">
                      <xsl:text>&#160;</xsl:text>
                    </TD>
                  </TR>
                </xsl:otherwise>
              </xsl:choose>
            </TBODY>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>


  <xsl:template match="i2:table[@title]" mode="taglib">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="0" cellpadding="0">
      <TR>
        <TD class="tableHeader">
          <xsl:text>&#160;</xsl:text>
          <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
        </TD>
      </TR>
      <TR>
        <TD>
          <TABLE width="100%" border="0" cellspacing="1" cellpadding="0" class="tableBorder">
            <xsl:if test="@id">
              <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:for-each select="*">
              <xsl:choose>
                <xsl:when test="name() = 'i2:tr'">
                  <xsl:apply-templates select="." mode="taglib"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="."/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:table[@title]" mode="taglibNS4">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="1" cellpadding="0" class="tableBorder">
      <TR>
        <TD class="tableBorder" nowrap="yes">
          <xsl:if test="@title">
            <TABLE width="100%" border="0" cellspacing="1" cellpadding="0">
              <TR>
                <TD class="tableHeader" nowrap="yes">
                  <xsl:text>&#160;</xsl:text>
                  <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
                </TD>
              </TR>
            </TABLE>
          </xsl:if>
          <TABLE width="100%" border="0" cellspacing="1" cellpadding="2">
            <xsl:if test="@id">
              <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:for-each select="*">
              <xsl:choose>
                <xsl:when test="name() = 'i2:tr'">
                  <xsl:apply-templates select="." mode="taglibNS4"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="."/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:table[@title]" mode="taglibNS6">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="1" cellpadding="0" class="tableBorder">
      <xsl:if test="@title">
        <TR>
          <TD class="tableHeader" nowrap="yes">
            <xsl:text>&#160;</xsl:text>
            <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
          </TD>
        </TR>
      </xsl:if>
      <TR>
        <TD class="tableBorder" nowrap="yes">
          <TABLE width="100%" border="0" cellspacing="1" cellpadding="0">
            <xsl:if test="@id">
              <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:for-each select="*">
              <xsl:choose>
                <xsl:when test="name() = 'i2:tr'">
                  <xsl:apply-templates select="." mode="taglibNS6"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="."/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>


  <xsl:template match="i2:table[@scrollablerows] | i2:table[@scrollablecolumns]" mode="taglib">
    <xsl:variable name="id">
      <xsl:choose>
        <xsl:when test="@id">
          <xsl:value-of select="@id"/>
        </xsl:when>
        <xsl:otherwise>i2table</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="100%" border="0" cellspacing="0" cellpadding="0" class="tableBorder">
      <xsl:attribute name="id">
        <xsl:value-of select="$id"/>
      </xsl:attribute>
      <TR>
        <TD>
          <xsl:choose>
            <xsl:when test="contains(@scrollablecolumns,'yes')">
              <DIV style="overflow-y:hidden;overflow-x:hidden;width:100px">
                <xsl:attribute name="id">
                  <xsl:value-of select="$id"/>_header_scroller</xsl:attribute>
                <TABLE width="100px" cellspacing="1" cellpadding="0">
                  <xsl:attribute name="id">
                    <xsl:value-of select="$id"/>_header</xsl:attribute>

                  <xsl:apply-templates select="i2:tr[@header]" mode="taglib"/>
                </TABLE>
              </DIV>
            </xsl:when>
            <xsl:when test="contains(@scrollablecolumns,'auto')">
              <DIV style="overflow-y:hidden;overflow-x:hidden;width:100px">
                <xsl:attribute name="id">
                  <xsl:value-of select="$id"/>_header_scroller</xsl:attribute>
                <TABLE width="100px" cellspacing="1" cellpadding="0">
                  <xsl:attribute name="id">
                    <xsl:value-of select="$id"/>_header</xsl:attribute>
                  <xsl:apply-templates select="i2:tr[@header]" mode="taglib"/>
                </TABLE>
              </DIV>
            </xsl:when>
            <xsl:otherwise>
              <TABLE width="100%" cellspacing="1" cellpadding="0">
                <xsl:attribute name="id">
                  <xsl:value-of select="$id"/>_header</xsl:attribute>
                <xsl:apply-templates select="i2:tr[@header]" mode="taglib"/>
              </TABLE>
            </xsl:otherwise>
          </xsl:choose>
        </TD>
      </TR>
      <TR>
        <TD>
          <DIV>
            <xsl:attribute name="id">
              <xsl:value-of select="$id"/>_scroller</xsl:attribute>
            <xsl:if test="contains(@scrollablecolumns,'yes')">
              <xsl:attribute name="onscroll">
                i2uiSyncdScroll('<xsl:value-of select="$id"/>');
                <xsl:if test="@scrollablesyncedtable">
                  i2uiSyncdScroll('<xsl:value-of select="$id"/>','<xsl:value-of select="@scrollablesyncedtable"/>');
                  i2uiSyncdScroll('<xsl:value-of select="$id"/>','<xsl:value-of select="@scrollablesyncedtable"/>2');
                </xsl:if></xsl:attribute>
            </xsl:if>
            <xsl:if test="contains(@scrollablecolumns,'auto')">
              <xsl:attribute name="onscroll">
                i2uiSyncdScroll('<xsl:value-of select="$id"/>');
                <xsl:if test="@scrollablesyncedtable">
                  i2uiSyncdScroll('<xsl:value-of select="$id"/>','<xsl:value-of select="@scrollablesyncedtable"/>');
                  i2uiSyncdScroll('<xsl:value-of select="$id"/>','<xsl:value-of select="@scrollablesyncedtable"/>2');
                </xsl:if></xsl:attribute>
            </xsl:if>
            <xsl:attribute name="style">
              <xsl:choose>
                <xsl:when test="contains(@scrollablerows,'yes')">overflow-y:scroll;height:100px;</xsl:when>
                <xsl:when test="contains(@scrollablerows,'auto')">overflow-y:auto;height:100px;</xsl:when>
                <xsl:otherwise>overflow-y:hidden;height:100px;</xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="contains(@scrollablecolumns,'yes')">overflow-x:scroll;width:100px;</xsl:when>
                <xsl:when test="contains(@scrollablecolumns,'auto')">overflow-x:auto;width:100px;</xsl:when>
                <xsl:otherwise>overflow-x:hidden;</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>

            <TABLE cellspacing="1" cellpadding="0">
              <xsl:attribute name="id">
                <xsl:value-of select="$id"/>_data</xsl:attribute>
              <xsl:attribute name="width">
                <xsl:choose>
                  <xsl:when test="contains(@scrollablecolumns,'')">100%</xsl:when>
                  <xsl:when test="contains(@scrollablecolumns,'no')">100%</xsl:when>
                  <xsl:otherwise>100px</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:variable name="headerrowcount">
                <xsl:value-of select="count(i2:tr[@header])"/>
              </xsl:variable>
              <xsl:apply-templates select="i2:tr[position() &gt; $headerrowcount]" mode="taglib"/>
            </TABLE>
          </DIV>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:table[@scrollablerows]" mode="taglibNS6">
    <xsl:variable name="id">
      <xsl:choose>
        <xsl:when test="@id">
          <xsl:value-of select="@id"/>
        </xsl:when>
        <xsl:otherwise>i2table</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="100%" border="0" cellspacing="1" cellpadding="0" class="tableBorder">
      <xsl:attribute name="id">
        <xsl:value-of select="$id"/>
      </xsl:attribute>
      <xsl:apply-templates select="i2:tr[@header]" mode="taglibNS6"/>
      <TBODY style="overflow:auto;height:100px;width:100px;">
        <xsl:attribute name="id">
          <xsl:value-of select="$id"/>_data</xsl:attribute>
        <xsl:variable name="headerrowcount">
          <xsl:value-of select="count(i2:tr[@header])"/>
        </xsl:variable>
        <xsl:apply-templates select="i2:tr[position() &gt; $headerrowcount]" mode="taglibNS6"/>
      </TBODY>
      <TBODY>
        <xsl:attribute name="id">
          <xsl:value-of select="$id"/>_footer</xsl:attribute>
      </TBODY>
    </TABLE>
  </xsl:template>


  <xsl:template match="i2:table" mode="taglib">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="1" cellpadding="2" class="tableBorder">
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:for-each select="*">
        <xsl:choose>
          <xsl:when test="name() = 'i2:tr'">
            <xsl:apply-templates select="." mode="taglib"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="."/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:table" mode="taglibNS4">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="ancestor::i2:container | ancestor::i2:tabbedcontainer">
        <TABLE width="{$width}" border="0" cellspacing="1" cellpadding="0" class="tableBorder">
          <xsl:if test="@id">
            <xsl:attribute name="id">
              <xsl:value-of select="@id"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:for-each select="*">
            <xsl:choose>
              <xsl:when test="name() = 'i2:tr'">
                <xsl:apply-templates select="." mode="taglibNS4"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates select="."/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </TABLE>
      </xsl:when>
      <xsl:otherwise>
        <TABLE width="{$width}" border="0" cellspacing="1" cellpadding="0" class="tableBorder">
          <TR>
            <TD class="tableBorder" nowrap="yes">
              <xsl:if test="@title">
                <TABLE width="100%" border="0" cellspacing="1" cellpadding="0">
                  <TR>
                    <TD class="tableHeader" nowrap="yes">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
                    </TD>
                  </TR>
                </TABLE>
              </xsl:if>
              <TABLE width="100%" border="0" cellspacing="1" cellpadding="2">
                <xsl:if test="@id">
                  <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:for-each select="*">
                  <xsl:choose>
                    <xsl:when test="name() = 'i2:tr'">
                      <xsl:apply-templates select="." mode="taglibNS4"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:apply-templates select="."/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </TABLE>
            </TD>
          </TR>
        </TABLE>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="i2:table" mode="taglibNS6">
    <xsl:variable name="width">
      <xsl:choose>
        <xsl:when test="@width">
          <xsl:value-of select="@width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>100%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE width="{$width}" border="0" cellspacing="1" cellpadding="0" class="tableBorder">
      <xsl:if test="@title">
        <TR>
          <TD class="tableHeader" nowrap="yes">
            <xsl:text>&#160;</xsl:text>
            <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
          </TD>
        </TR>
      </xsl:if>
      <TR>
        <TD class="tableBorder" nowrap="yes">
          <TABLE width="100%" border="0" cellspacing="1" cellpadding="0">
            <xsl:if test="@id">
              <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:for-each select="*">
              <xsl:choose>
                <xsl:when test="name() = 'i2:tr'">
                  <xsl:apply-templates select="." mode="taglibNS6"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="."/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>


  <xsl:template match="i2:tr[@header]" mode="taglib">
    <TR class="tableColumnHeadings">
      <xsl:apply-templates mode="taglib"/>
    </TR>
  </xsl:template>
  <xsl:template match="i2:tr[@header]" mode="taglibNS4">
    <TR class="tableColumnHeadingsNS4">
      <xsl:apply-templates mode="taglibNS4"/>
    </TR>
  </xsl:template>
  <xsl:template match="i2:tr[@header]" mode="taglibNS6">
    <TR class="tableColumnHeadings">
      <xsl:apply-templates mode="taglibNS6"/>
      <xsl:if test="position() = 1">
        <TD id="scrollerspacer" width="4">&#160;
        </TD>
      </xsl:if>
    </TR>
  </xsl:template>


  <xsl:template match="i2:tr" mode="taglib">
    <TR>
      <xsl:element name="xsl:attribute">
        <xsl:attribute name="name">class</xsl:attribute>
        <xsl:choose>
          <xsl:when test="@class">
            <xsl:value-of select="@class"/>
          </xsl:when>
          <xsl:when test="@cssclass">
            <xsl:value-of select="@cssclass"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="xsl:choose">
              <xsl:element name="xsl:when">
                <xsl:attribute name="test">position() mod 2 = 0</xsl:attribute>
              tableRow0
            </xsl:element>
              <xsl:element name="xsl:otherwise">
              tableRow1
            </xsl:element>
            </xsl:element>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <xsl:apply-templates mode="taglib"/>
    </TR>
  </xsl:template>
  <xsl:template match="i2:tr" mode="taglibNS4">
    <xsl:variable name="rowclass">
      <xsl:choose>
        <xsl:when test="@class">
          <xsl:value-of select="@class"/>
        </xsl:when>
        <xsl:when test="@cssclass">
          <xsl:value-of select="@cssclass"/>
        </xsl:when>
        <xsl:when test="position() mod 2 = 0">tableRow0NS4</xsl:when>
        <xsl:otherwise>tableRow1NS4</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TR>
      <xsl:attribute name="class">
        <xsl:value-of select="$rowclass"/>
      </xsl:attribute>
      <xsl:apply-templates mode="taglibNS4"/>
    </TR>
  </xsl:template>
  <xsl:template match="i2:tr" mode="taglibNS6">
    <xsl:variable name="rowclass">
      <xsl:choose>
        <xsl:when test="@class">
          <xsl:value-of select="@class"/>
        </xsl:when>
        <xsl:when test="@cssclass">
          <xsl:value-of select="@cssclass"/>
        </xsl:when>
        <xsl:when test="position() mod 2 = 0">tableRow0</xsl:when>
        <xsl:otherwise>tableRow1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TR>
      <xsl:attribute name="class">
        <xsl:value-of select="$rowclass"/>
      </xsl:attribute>
      <xsl:apply-templates mode="taglibNS6"/>
    </TR>
  </xsl:template>

  <!--
       i2:popupcell templates
    -->
  <xsl:template match="i2:popupcell" mode="taglib">
    <xsl:choose>
      <xsl:when test="@popupname">
        <xsl:variable name="hrefPrefix">
          <xsl:choose>
            <xsl:when test="substring(@onclick, string-length(@onclick), 1) != ';'">javascript:<xsl:value-of select="@onclick"/>;</xsl:when>
            <xsl:otherwise>javascript:<xsl:value-of select="@onclick"/></xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <TD NOWRAP="yes" CLASS="popupCell">
          <xsl:choose>
            <xsl:when test="../@header">
              <SPAN>
                <xsl:apply-templates mode="taglib"/>
              </SPAN>
            </xsl:when>
            <xsl:otherwise>
              <SPAN CLASS="popupLink">
                <xsl:apply-templates mode="taglib"/>
              </SPAN>
            </xsl:otherwise>
          </xsl:choose>
          <A ONMOUSEOVER="i2uiSetMenuCoords(this, event)">
            <xsl:attribute name="HREF">
              <xsl:value-of select="$hrefPrefix"/>i2uiShowMenu('<xsl:value-of select="@popupname"/>')</xsl:attribute>
            <xsl:variable name="iconFile">
              <xsl:choose>
                <xsl:when test="../@header">dropdown.gif</xsl:when>
                <xsl:otherwise>table_cell_pop_indi.gif</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <IMG BORDER="0" ALIGN="right">
              <xsl:attribute name="SRC">
                <xsl:value-of select="$imageDirectory"/>/<xsl:value-of select="$iconFile"/></xsl:attribute>
            </IMG>
          </A>
        </TD>
      </xsl:when>
      <xsl:otherwise>
        <TD NOWRAP="yes" STYLE="background-color: #f03060">
          <xsl:apply-templates mode="taglib"/>
        </TD>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="i2:popupcell" mode="taglibNS4">
    <xsl:choose>
      <xsl:when test="@popupname">
        <xsl:variable name="hrefPrefix">
          <xsl:choose>
            <xsl:when test="substring(@onclick, string-length(@onclick), 1) != ';'">javascript:<xsl:value-of select="@onclick"/>;</xsl:when>
            <xsl:otherwise>javascript:<xsl:value-of select="@onclick"/></xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <TD NOWRAP="yes" CLASS="popupCell">
          <xsl:choose>
            <xsl:when test="../@header">
              <SPAN STYLE="float: left;">
                <!-- inline style required for NS4 -->
                <xsl:apply-templates mode="taglib"/>
              </SPAN>
            </xsl:when>
            <xsl:otherwise>
              <SPAN CLASS="popupLink" STYLE="float: left;">
                <!-- inline style required for NS4 -->
                <xsl:apply-templates mode="taglib"/>
              </SPAN>
            </xsl:otherwise>
          </xsl:choose>
          <A ONMOUSEOVER="i2uiSetMenuCoords(this, event)">
            <xsl:attribute name="HREF">
              <xsl:value-of select="$hrefPrefix"/>i2uiShowMenu('<xsl:value-of select="@popupname"/>')</xsl:attribute>
            <xsl:variable name="iconFile">
              <xsl:choose>
                <xsl:when test="../@header">dropdown.gif</xsl:when>
                <xsl:otherwise>table_cell_pop_indi.gif</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <IMG BORDER="0" ALIGN="right">
              <xsl:attribute name="SRC">
                <xsl:value-of select="$imageDirectory"/>/<xsl:value-of select="$iconFile"/></xsl:attribute>
            </IMG>
          </A>
        </TD>
      </xsl:when>
      <xsl:otherwise>
        <TD NOWRAP="yes" STYLE="background-color: #f03060">
          <xsl:apply-templates mode="taglib"/>
        </TD>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="i2:popupcell" mode="taglibNS6">
    <xsl:choose>
      <xsl:when test="@popupname">
        <xsl:variable name="hrefPrefix">
          <xsl:choose>
            <xsl:when test="substring(@onclick, string-length(@onclick), 1) != ';'">javascript:<xsl:value-of select="@onclick"/>;</xsl:when>
            <xsl:otherwise>javascript:<xsl:value-of select="@onclick"/></xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <TD NOWRAP="yes" CLASS="popupCell">
          <xsl:choose>
            <xsl:when test="../@header">
              <SPAN>
                <xsl:apply-templates mode="taglib"/>
              </SPAN>
            </xsl:when>
            <xsl:otherwise>
              <SPAN CLASS="popupLink">
                <xsl:apply-templates mode="taglib"/>
              </SPAN>
            </xsl:otherwise>
          </xsl:choose>
          <A>
            <!-- ONMOUSEOVER is <A> attribute in other modes -->
            <xsl:attribute name="HREF">
              <xsl:value-of select="$hrefPrefix"/>i2uiShowMenu('<xsl:value-of select="@popupname"/>')</xsl:attribute>
            <xsl:variable name="iconFile">
              <xsl:choose>
                <xsl:when test="../@header">dropdown.gif</xsl:when>
                <xsl:otherwise>table_cell_pop_indi.gif</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <IMG ONMOUSEOVER="i2uiSetMenuCoords(this, event)" BORDER="0" ALIGN="right">
              <xsl:attribute name="SRC">
                <xsl:value-of select="$imageDirectory"/>/<xsl:value-of select="$iconFile"/></xsl:attribute>
            </IMG>
          </A>
        </TD>
      </xsl:when>
      <xsl:otherwise>
        <TD NOWRAP="yes" STYLE="background-color: #f03060">
          <xsl:apply-templates mode="taglib"/>
        </TD>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="i2:treecell" mode="taglib">
    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="string-length(@name)">'<xsl:value-of select="@name"/>'</xsl:when>
        <xsl:otherwise>null</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="relatedtable">
      <xsl:choose>
        <xsl:when test="string-length(../../@relatedtableids)">'<xsl:value-of select="../../@relatedtableids"/>'</xsl:when>
        <xsl:otherwise>null</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="column">
      <xsl:choose>
        <xsl:when test="string-length(@column)">
          <xsl:value-of select="@column"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="depth" select="@depth"/>
    <xsl:variable name="mykey">
      <xsl:choose>
        <xsl:when test="@spanning='yes'">
          <xsl:value-of select="@depth * 10 + 5"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="count(preceding::i2:tr[not(i2:treecell/@spanning='yes')])-1"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@depth * 10"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="count(preceding::i2:tr[not(i2:treecell/@spanning='yes')])"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TD nowrap="yes" valign="top">
      <xsl:attribute name="id">TREECELL_<xsl:value-of select="$mykey"/></xsl:attribute>
      <xsl:choose>
        <xsl:when test="@spanning='yes'">
          <xsl:text>&#160;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="i2:indent">
            <xsl:with-param name="depth" select="@depth"/>
          </xsl:call-template>
          <A>
            <xsl:attribute name="href">javascript:i2uiManageTreeTable('<xsl:value-of select="../../@id"/>','<xsl:value-of select="$mykey"/>',<xsl:value-of select="$column"/>,<xsl:value-of select="$relatedtable"/>,<xsl:value-of select="$name"/>);</xsl:attribute>
            <IMG border="0">
              <xsl:attribute name="src">
                <xsl:choose>
                  <xsl:when test="@loadondemand='yes'">
                    <xsl:value-of select="$imageDirectory"/>/plus_norgie.gif</xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$imageDirectory"/>/minus_norgie.gif</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:attribute name="id">TREECELLIMAGE_<xsl:value-of select="../../@id"/>_<xsl:value-of select="$mykey"/></xsl:attribute>
            </IMG>
          </A>
          <xsl:choose>
            <xsl:when test="@onclick">
              <SPAN>
                <xsl:attribute name="id">
                  <xsl:value-of select="../../@id"/>_<xsl:value-of select="$mykey"/></xsl:attribute>
                <xsl:text>&#160;</xsl:text>
                <A>
                  <xsl:attribute name="href">javascript:i2uiTreeTableAction('<xsl:value-of select="../../@id"/>_<xsl:value-of select="$mykey"/>','<xsl:value-of select="@onclick"/>')</xsl:attribute>
                  <xsl:apply-templates mode="taglib"/>
                </A>
              </SPAN>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>&#160;</xsl:text>
              <xsl:apply-templates mode="taglib"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </TD>
  </xsl:template>
  <xsl:template match="i2:treecell" mode="taglibNS4">
    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="string-length(@name)">'<xsl:value-of select="@name"/>'</xsl:when>
        <xsl:otherwise>null</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="relatedtable">
      <xsl:choose>
        <xsl:when test="string-length(../../@relatedtableids)">'<xsl:value-of select="../../@relatedtableids"/>'</xsl:when>
        <xsl:otherwise>null</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="column">
      <xsl:choose>
        <xsl:when test="string-length(@column)">
          <xsl:value-of select="@column"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="depth" select="@depth"/>
    <xsl:variable name="mykey">
      <xsl:choose>
        <xsl:when test="@spanning='yes'">
          <xsl:value-of select="@depth * 10 + 5"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="count(preceding::i2:tr[not(i2:treecell/@spanning='yes')])-1"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@depth * 10"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="count(preceding::i2:tr[not(i2:treecell/@spanning='yes')])"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TD nowrap="yes" valign="top">
      <xsl:attribute name="id">TREECELL_<xsl:value-of select="$mykey"/></xsl:attribute>
      <xsl:choose>
        <xsl:when test="@spanning='yes'">
          <xsl:text>&#160;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="i2:indent">
            <xsl:with-param name="depth" select="@depth"/>
          </xsl:call-template>
          <IMG border="0">
            <xsl:attribute name="src">
              <xsl:choose>
                <xsl:when test="@loadondemand='yes'">
                  <xsl:value-of select="$imageDirectory"/>/plus_loadondemand.gif</xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$imageDirectory"/>/minus_norgie.gif</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="id">TREECELLIMAGE_<xsl:value-of select="../../@id"/>_<xsl:value-of select="$mykey"/></xsl:attribute>
          </IMG>
          <xsl:choose>
            <xsl:when test="@onclick">
              <ILAYER>
                <xsl:attribute name="id">
                  <xsl:value-of select="../../@id"/>_<xsl:value-of select="$mykey"/></xsl:attribute>
                <xsl:text>&#160;</xsl:text>
                <A>
                  <xsl:attribute name="href">javascript:i2uiTreeTableAction('<xsl:value-of select="../../@id"/>_<xsl:value-of select="$mykey"/>','<xsl:value-of select="@onclick"/>')</xsl:attribute>
                  <xsl:apply-templates mode="taglibNS4"/>
                </A>
              </ILAYER>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>&#160;</xsl:text>
              <xsl:apply-templates mode="taglibNS4"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </TD>
  </xsl:template>
  <xsl:template match="i2:treecell" mode="taglibNS6">
    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="string-length(@name)">'<xsl:value-of select="@name"/>'</xsl:when>
        <xsl:otherwise>null</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="relatedtable">
      <xsl:choose>
        <xsl:when test="string-length(../../@relatedtableids)">'<xsl:value-of select="../../@relatedtableids"/>'</xsl:when>
        <xsl:otherwise>null</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="column">
      <xsl:choose>
        <xsl:when test="string-length(@column)">
          <xsl:value-of select="@column"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="depth" select="@depth"/>
    <xsl:variable name="mykey">
      <xsl:choose>
        <xsl:when test="@spanning='yes'">
          <xsl:value-of select="@depth * 10 + 5"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="count(preceding::i2:tr[not(i2:treecell/@spanning='yes')])-1"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@depth * 10"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="count(preceding::i2:tr[not(i2:treecell/@spanning='yes')])"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TD nowrap="yes" valign="top">
      <xsl:attribute name="id">TREECELL_<xsl:value-of select="$mykey"/></xsl:attribute>
      <xsl:choose>
        <xsl:when test="@spanning='yes'">
          <xsl:text>&#160;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="i2:indent">
            <xsl:with-param name="depth" select="@depth"/>
          </xsl:call-template>
          <A>
            <xsl:attribute name="href">javascript:i2uiManageTreeTable('<xsl:value-of select="../../@id"/>','<xsl:value-of select="$mykey"/>',<xsl:value-of select="$column"/>,<xsl:value-of select="$relatedtable"/>,<xsl:value-of select="$name"/>);</xsl:attribute>
            <IMG border="0">
              <xsl:attribute name="src">
                <xsl:choose>
                  <xsl:when test="@loadondemand='yes'">
                    <xsl:value-of select="$imageDirectory"/>/plus_norgie.gif</xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$imageDirectory"/>/minus_norgie.gif</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:attribute name="id">TREECELLIMAGE_<xsl:value-of select="../../@id"/>_<xsl:value-of select="$mykey"/></xsl:attribute>
            </IMG>
          </A>
          <xsl:choose>
            <xsl:when test="@onclick">
              <SPAN>
                <xsl:attribute name="id">
                  <xsl:value-of select="../../@id"/>_<xsl:value-of select="$mykey"/></xsl:attribute>
                <xsl:text>&#160;</xsl:text>
                <A>
                  <xsl:attribute name="href">javascript:i2uiTreeTableAction('<xsl:value-of select="../../@id"/>_<xsl:value-of select="$mykey"/>','<xsl:value-of select="@onclick"/>')</xsl:attribute>
                  <xsl:apply-templates mode="taglibNS6"/>
                </A>
              </SPAN>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>&#160;</xsl:text>
              <xsl:apply-templates mode="taglibNS6"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </TD>
  </xsl:template>



  <xsl:template match="i2:popupmenu" mode="taglib">
    <DIV style="position:absolute;left:1;top:1;visibility:hidden;">
      <xsl:attribute name="id">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <TABLE border="1" cellspacing="0" cellpadding="0">
        <TR class="menuUnHighlighted">
          <TD class="menuShadow">
            <TABLE border="0" cellspacing="2" cellpadding="0">
              <xsl:apply-templates select="i2:popupmenuoption | i2:popupmenudivider" mode="taglib"/>
              <TR class="menuUnHighlighted">
                <TD colspan="2" style="font-size:1px">
                  <xsl:text>&#160;</xsl:text>
                </TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
    </DIV>
  </xsl:template>
  <xsl:template match="i2:popupmenu" mode="taglibNS4">
    <DIV style="position:absolute;left:1;top:1;visibility:hidden;">
      <xsl:attribute name="id">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <TABLE border="1" cellspacing="0" cellpadding="0">
        <TR class="menuUnHighlighted">
          <TD class="menuShadow">
            <TABLE border="0" cellspacing="2" cellpadding="0">
              <xsl:apply-templates select="i2:popupmenuoption | i2:popupmenudivider" mode="taglibNS4"/>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
    </DIV>
  </xsl:template>
  <xsl:template match="i2:popupmenu" mode="taglibNS6">
    <DIV style="position:absolute;left:1;top:1;visibility:hidden;">
      <xsl:attribute name="id">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <TABLE border="1" cellspacing="0" cellpadding="0">
        <TR class="menuUnHighlighted">
          <TD class="menuShadow">
            <TABLE border="0" cellspacing="2" cellpadding="0">
              <xsl:apply-templates select="i2:popupmenuoption | i2:popupmenudivider" mode="taglib"/>
              <TR class="menuUnHighlighted">
                <TD colspan="2" style="font-size:1px">
                  <xsl:text>&#160;</xsl:text>
                </TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
    </DIV>
  </xsl:template>


  <xsl:template match="i2:popupmenuoption" mode="taglib">
    <xsl:variable name="colspan">
      <xsl:choose>
        <xsl:when test="contains(@url,'i2uiShowSubMenu(')">1</xsl:when>
        <xsl:otherwise>2</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="ownerid">
      <xsl:value-of select="../@name"/>
    </xsl:variable>
    <xsl:variable name="id">
      <xsl:value-of select="$ownerid"/>_<xsl:value-of select="position()"/></xsl:variable>
    <TR class="menuUnhighlighted">
      <TD nowrap="yes" class="menuText">
        <xsl:attribute name="colspan">
          <xsl:value-of select="$colspan"/>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="@disabled='yes'">
            <xsl:text>&#160;&#160;</xsl:text>
            <xsl:value-of select="@text"/>
            <xsl:text>&#160;&#160;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <A>
              <xsl:attribute name="href">
                <xsl:value-of select="@url"/>
              </xsl:attribute>
              <xsl:attribute name="onmouseout">i2uiHighlightMenuOption(this,'Unhighlighted','<xsl:value-of select="$id"/>','<xsl:value-of select="$ownerid"/>')</xsl:attribute>
              <xsl:choose>
                <xsl:when test="not(contains(@url,'i2uiShowSubMenu('))">
                  <xsl:attribute name="onclick">i2uiHideMenu()</xsl:attribute>
                  <xsl:attribute name="onmouseover">i2uiHighlightMenuOption(this,'Highlighted','<xsl:value-of select="$id"/>','<xsl:value-of select="$ownerid"/>')</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="onmouseover">i2uiHighlightMenuOption(this,'Highlighted','<xsl:value-of select="$id"/>','<xsl:value-of select="$ownerid"/>');<xsl:value-of select="substring-after(@url,'javascript:')"/>;</xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:text>&#160;&#160;</xsl:text>
              <xsl:value-of select="@text"/>
              <xsl:text>&#160;&#160;</xsl:text>
            </A>
          </xsl:otherwise>
        </xsl:choose>
      </TD>
      <xsl:if test="contains(@url,'i2uiShowSubMenu(')">
        <TD>
          <IMG>
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/nested_menu.gif</xsl:attribute>
          </IMG>
        </TD>
      </xsl:if>
    </TR>
  </xsl:template>
  <xsl:template match="i2:popupmenuoption" mode="taglibNS4">
    <xsl:variable name="colspan">
      <xsl:choose>
        <xsl:when test="contains(@url,'i2uiShowSubMenu(')">1</xsl:when>
        <xsl:otherwise>2</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="ownerid">
      <xsl:value-of select="../@name"/>
    </xsl:variable>
    <xsl:variable name="id">
      <xsl:value-of select="$ownerid"/>_<xsl:value-of select="position()"/></xsl:variable>
    <TR class="menuUnhighlighted">
      <TD nowrap="yes" class="menuText">
        <xsl:attribute name="colspan">
          <xsl:value-of select="$colspan"/>
        </xsl:attribute>
        <ILAYER width="100%" bgcolor="#f7f8fd" id="{$id}">
          <xsl:choose>
            <xsl:when test="@disabled='yes'">
              <xsl:text>&#160;&#160;</xsl:text>
              <xsl:value-of select="@text"/>
              <xsl:text>&#160;&#160;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <A>
                <xsl:attribute name="href">
                  <xsl:value-of select="@url"/>
                </xsl:attribute>
                <xsl:attribute name="onmouseout">i2uiHighlightMenuOption(this,'Unhighlighted','<xsl:value-of select="$id"/>','<xsl:value-of select="$ownerid"/>')</xsl:attribute>
                <xsl:choose>
                  <xsl:when test="not(contains(@url,'i2uiShowSubMenu('))">
                    <xsl:attribute name="onclick">i2uiHideMenu()</xsl:attribute>
                    <xsl:attribute name="onmouseover">i2uiHighlightMenuOption(this,'Highlighted','<xsl:value-of select="$id"/>','<xsl:value-of select="$ownerid"/>')</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="onmouseover">i2uiHighlightMenuOption(this,'Highlighted','<xsl:value-of select="$id"/>','<xsl:value-of select="$ownerid"/>');<xsl:value-of select="substring-after(@url,'javascript:')"/>;</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text>&#160;&#160;</xsl:text>
                <xsl:value-of select="@text"/>
                <xsl:text>&#160;&#160;</xsl:text>
              </A>
            </xsl:otherwise>
          </xsl:choose>
        </ILAYER>
      </TD>
      <xsl:if test="contains(@url,'i2uiShowSubMenu(')">
        <TD>
          <IMG>
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/nested_menu.gif</xsl:attribute>
          </IMG>
        </TD>
      </xsl:if>
    </TR>
  </xsl:template>
  <xsl:template match="i2:popupmenuoption" mode="taglibNS6">
    <xsl:variable name="colspan">
      <xsl:choose>
        <xsl:when test="contains(@url,'i2uiShowSubMenu(')">1</xsl:when>
        <xsl:otherwise>2</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="ownerid">
      <xsl:value-of select="../@name"/>
    </xsl:variable>
    <xsl:variable name="id">
      <xsl:value-of select="$ownerid"/>_<xsl:value-of select="position()"/></xsl:variable>
    <TR class="menuUnhighlighted">
      <TD nowrap="yes" class="menuText">
        <xsl:attribute name="colspan">
          <xsl:value-of select="$colspan"/>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="@disabled='yes'">
            <xsl:text>&#160;&#160;</xsl:text>
            <xsl:value-of select="@text"/>
            <xsl:text>&#160;&#160;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <A>
              <xsl:attribute name="href">
                <xsl:value-of select="@url"/>
              </xsl:attribute>
              <xsl:attribute name="onmouseout">i2uiHighlightMenuOption(this,'Unhighlighted','<xsl:value-of select="$id"/>','<xsl:value-of select="$ownerid"/>')</xsl:attribute>
              <xsl:choose>
                <xsl:when test="not(contains(@url,'i2uiShowSubMenu('))">
                  <xsl:attribute name="onclick">i2uiHideMenu()</xsl:attribute>
                  <xsl:attribute name="onmouseover">i2uiHighlightMenuOption(this,'Highlighted','<xsl:value-of select="$id"/>','<xsl:value-of select="$ownerid"/>')</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="onmouseover">i2uiHighlightMenuOption(this,'Highlighted','<xsl:value-of select="$id"/>','<xsl:value-of select="$ownerid"/>');<xsl:value-of select="substring-after(@url,'javascript:')"/>;</xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:text>&#160;&#160;</xsl:text>
              <xsl:value-of select="@text"/>
              <xsl:text>&#160;&#160;</xsl:text>
            </A>
          </xsl:otherwise>
        </xsl:choose>
      </TD>
      <xsl:if test="contains(@url,'i2uiShowSubMenu(')">
        <TD>
          <IMG>
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/nested_menu.gif</xsl:attribute>
          </IMG>
        </TD>
      </xsl:if>
    </TR>
  </xsl:template>


  <xsl:template match="i2:popupmenudivider" mode="taglib">
    <TR class="menuUnhighlighted">
      <TD nowrap="yes" class="menuText">
        <IMG width="100%" height="6">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/popup_menu_divider.gif</xsl:attribute>
        </IMG>
      </TD>
    </TR>
  </xsl:template>
  <xsl:template match="i2:popupmenudivider" mode="taglibNS4">
    <TR class="menuUnhighlighted">
      <TD nowrap="yes" class="menuText">
        <IMG width="50" height="6">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/popup_menu_divider.gif</xsl:attribute>
        </IMG>
      </TD>
    </TR>
  </xsl:template>
  <xsl:template match="i2:popupmenudivider" mode="taglibNS6">
    <TR class="menuUnhighlighted">
      <TD nowrap="yes" class="menuText">
        <IMG width="100%" height="6">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/popup_menu_divider.gif</xsl:attribute>
        </IMG>
      </TD>
    </TR>
  </xsl:template>

  <xsl:template match="i2:img" mode="taglib">
    <IMG>
      <xsl:attribute name="src">
        <xsl:if test="substring(@src,1,1)='/'">
          <xsl:value-of select="$imageDirectory"/>
        </xsl:if>
        <xsl:value-of select="@src"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="contains(@disabled,'yes')">
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="@onclick">
            <xsl:attribute name="onMouseOver">javascript:this.style.cursor='hand'</xsl:attribute>
            <xsl:attribute name="onclick">
              <xsl:value-of select="@onclick"/>
            </xsl:attribute>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width">
        <xsl:attribute name="width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height">
        <xsl:attribute name="height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@alt">
        <xsl:attribute name="alt">
          <xsl:value-of select="@alt"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@border">
        <xsl:attribute name="border">
          <xsl:value-of select="@border"/>
        </xsl:attribute>
      </xsl:if>
    </IMG>
  </xsl:template>
  <xsl:template match="i2:img[@onclick][not(@disabled)] | i2:img[@onclick][@disabled='no']" mode="taglibNS4">
    <A>
      <xsl:attribute name="href">
        <xsl:value-of select="@onclick"/>
      </xsl:attribute>
      <IMG>
        <xsl:attribute name="src">
          <xsl:if test="substring(@src,1,1)='/'">
            <xsl:value-of select="$imageDirectory"/>
          </xsl:if>
          <xsl:value-of select="@src"/>
        </xsl:attribute>
        <xsl:if test="@id">
          <xsl:attribute name="id">
            <xsl:value-of select="@id"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@width">
          <xsl:attribute name="width">
            <xsl:value-of select="@width"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@height">
          <xsl:attribute name="height">
            <xsl:value-of select="@height"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@alt">
          <xsl:attribute name="alt">
            <xsl:value-of select="@alt"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:attribute name="border">
          <xsl:choose>
            <xsl:when test="@border">
              <xsl:value-of select="@border"/>
            </xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </IMG>
    </A>
  </xsl:template>
  <xsl:template match="i2:img" mode="taglibNS4">
    <IMG>
      <xsl:attribute name="src">
        <xsl:if test="substring(@src,1,1)='/'">
          <xsl:value-of select="$imageDirectory"/>
        </xsl:if>
        <xsl:value-of select="@src"/>
      </xsl:attribute>
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width">
        <xsl:attribute name="width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height">
        <xsl:attribute name="height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@alt">
        <xsl:attribute name="alt">
          <xsl:value-of select="@alt"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@border">
        <xsl:attribute name="border">
          <xsl:value-of select="@border"/>
        </xsl:attribute>
      </xsl:if>
    </IMG>
  </xsl:template>
  <xsl:template match="i2:img[@onclick][not(@disabled)] | i2:img[@onclick][@disabled='no']" mode="taglibNS6">
    <A>
      <xsl:attribute name="href">
        <xsl:value-of select="@onclick"/>
      </xsl:attribute>
      <IMG>
        <xsl:attribute name="src">
          <xsl:if test="substring(@src,1,1)='/'">
            <xsl:value-of select="$imageDirectory"/>
          </xsl:if>
          <xsl:value-of select="@src"/>
        </xsl:attribute>
        <xsl:if test="@id">
          <xsl:attribute name="id">
            <xsl:value-of select="@id"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@width">
          <xsl:attribute name="width">
            <xsl:value-of select="@width"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@height">
          <xsl:attribute name="height">
            <xsl:value-of select="@height"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@alt">
          <xsl:attribute name="alt">
            <xsl:value-of select="@alt"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:attribute name="border">
          <xsl:choose>
            <xsl:when test="@border">
              <xsl:value-of select="@border"/>
            </xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </IMG>
    </A>
  </xsl:template>
  <xsl:template match="i2:img" mode="taglibNS6">
    <IMG>
      <xsl:attribute name="src">
        <xsl:if test="substring(@src,1,1)='/'">
          <xsl:value-of select="$imageDirectory"/>
        </xsl:if>
        <xsl:value-of select="@src"/>
      </xsl:attribute>
      <xsl:if test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width">
        <xsl:attribute name="width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height">
        <xsl:attribute name="height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@alt">
        <xsl:attribute name="alt">
          <xsl:value-of select="@alt"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@border">
        <xsl:attribute name="border">
          <xsl:value-of select="@border"/>
        </xsl:attribute>
      </xsl:if>
    </IMG>
  </xsl:template>
  

  <!-- i2:dhtml templates -->
  <xsl:template match="i2:dhtml" mode="taglib">
    <script language="javascript" type="text/javascript">
      <xsl:attribute name="src">
        <xsl:value-of select="$javascriptDirectory"/>/i2uitaglib.js</xsl:attribute>
    </script>
    <xsl:if test="@padsupport='yes'">
      <script language="javascript" type="text/javascript">
        <xsl:attribute name="src">
          <xsl:value-of select="$javascriptDirectory"/>/i2uipad.js</xsl:attribute>
      </script>
    </xsl:if>
    <xsl:if test="@datepickersupport='yes'">
      <xsl:choose>
        <xsl:when test="@locale">
          <script language="javascript" type="text/javascript">
            <xsl:attribute name="src">
              <xsl:value-of select="$javascriptDirectory"/>/i2uidatepicker.jsp?locale=<xsl:value-of select="@locale"/></xsl:attribute>
          </script>
        </xsl:when>
        <xsl:otherwise>
          <script language="javascript" type="text/javascript">
            <xsl:attribute name="src">
              <xsl:value-of select="$javascriptDirectory"/>/i2uidatepicker.jsp</xsl:attribute>
          </script>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <script language="javascript">
      i2uiSetImageDirectory('<xsl:value-of select="$imageDirectory"/>');
      i2uiDatePickerSetJspDir('<xsl:value-of select="$javascriptDirectory"/>');
    </script>
  </xsl:template>
  
  <xsl:template match="i2:dhtml" mode="taglibNS4">
    <script language="javascript">
      <xsl:attribute name="src">
        <xsl:value-of select="$javascriptDirectory"/>/i2uitaglib.js</xsl:attribute>
    </script>
    <xsl:if test="@padsupport='yes'">
      <script language="javascript">
        <xsl:attribute name="src">
          <xsl:value-of select="$javascriptDirectory"/>/i2uipad.js</xsl:attribute>
      </script>
      <script language="javascript">
        <xsl:attribute name="src">
          <xsl:value-of select="$cssDirectory"/>/i2uipad.css</xsl:attribute>
      </script>
    </xsl:if>
    <xsl:if test="@datepickersupport='yes'">
      <xsl:choose>
        <xsl:when test="@locale">
          <script language="javascript" type="text/javascript">
            <xsl:attribute name="src">
              <xsl:value-of select="$javascriptDirectory"/>/i2uidatepicker.jsp?locale=<xsl:value-of select="@locale"/></xsl:attribute>
          </script>
        </xsl:when>
        <xsl:otherwise>
          <script language="javascript" type="text/javascript">
            <xsl:attribute name="src">
              <xsl:value-of select="$javascriptDirectory"/>/i2uidatepicker.jsp</xsl:attribute>
          </script>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <script language="javascript">
      i2uiSetImageDirectory('<xsl:value-of select="$imageDirectory"/>');
      i2uiDatePickerSetJspDir('<xsl:value-of select="$javascriptDirectory"/>');
    </script>
  </xsl:template>

  <xsl:template match="i2:dhtml" mode="taglibNS6">
    <script language="javascript">
      <xsl:attribute name="src">
        <xsl:value-of select="$javascriptDirectory"/>/i2uitaglib.js</xsl:attribute>
    </script>
    <xsl:if test="@padsupport='yes'">
      <script language="javascript">
        <xsl:attribute name="src">
          <xsl:value-of select="$javascriptDirectory"/>/i2uipad.js</xsl:attribute>
      </script>
    </xsl:if>
    <xsl:if test="@datepickersupport='yes'">
      <xsl:choose>
        <xsl:when test="@locale">
          <script language="javascript" type="text/javascript">
            <xsl:attribute name="src">
              <xsl:value-of select="$javascriptDirectory"/>/i2uidatepicker.jsp?locale=<xsl:value-of select="@locale"/></xsl:attribute>
          </script>
        </xsl:when>
        <xsl:otherwise>
          <script language="javascript" type="text/javascript">
            <xsl:attribute name="src">
              <xsl:value-of select="$javascriptDirectory"/>/i2uidatepicker.jsp</xsl:attribute>
          </script>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <script language="javascript">
      i2uiSetImageDirectory('<xsl:value-of select="$imageDirectory"/>');
      i2uiDatePickerSetJspDir('<xsl:value-of select="$javascriptDirectory"/>');
    </script>
  </xsl:template>


  <xsl:template match="i2:javascript" mode="taglib">
    <xsl:call-template name="i2:javascript"/>
  </xsl:template>
  <xsl:template match="i2:javascript" mode="taglibNS4">
    <xsl:call-template name="i2:javascript"/>
  </xsl:template>
  <xsl:template match="i2:javascript" mode="taglibNS6">
    <xsl:call-template name="i2:javascript"/>
  </xsl:template>

  <xsl:template name="i2:javascript">
    <SCRIPT type="text/javascript">
      <xsl:attribute name="language">javascript<xsl:value-of select="@version"/></xsl:attribute>
      <xsl:attribute name="src">
        <xsl:if test="not(@absolute = 'yes')">
          <xsl:value-of select="$javascriptDirectory"/>
        </xsl:if>
        <xsl:value-of select="@path"/>
      </xsl:attribute>
    </SCRIPT>
  </xsl:template>


  <xsl:template match="i2:stylesheet" mode="taglib">
    <xsl:call-template name="i2:stylesheet"/>
  </xsl:template>
  <xsl:template match="i2:stylesheet" mode="taglibNS4">
    <xsl:call-template name="i2:stylesheet"/>
  </xsl:template>
  <xsl:template match="i2:stylesheet" mode="taglibNS6">
    <xsl:call-template name="i2:stylesheet"/>
  </xsl:template>

  <xsl:template match="i2:stylesheet[@default]" mode="taglib">
    <xsl:call-template name="i2:stylesheet"/>
  </xsl:template>
  <xsl:template match="i2:stylesheet[@default]" mode="taglibNS4">
    <xsl:call-template name="i2:stylesheet"/>
  </xsl:template>
  <xsl:template match="i2:stylesheet[@default]" mode="taglibNS6">
    <xsl:call-template name="i2:stylesheet"/>
  </xsl:template>

  <xsl:template name="i2:stylesheet">
    <LINK rel="STYLESHEET" type="text/css">
      <xsl:attribute name="href">
        <xsl:if test="not(@absolute = 'yes')">
          <xsl:value-of select="$cssDirectory"/>
        </xsl:if>
        <xsl:value-of select="@path"/>
      </xsl:attribute>
    </LINK>
  </xsl:template>


  <xsl:template name="i2:shell_top_portion_ie">
    <TR height="40">
      <TD nowrap="yes" colspan="3">
        <TABLE cellpadding="0" cellspacing="0">
          <xsl:attribute name="style">background-image:url(<xsl:value-of select="@logo"/>);background-repeat:no-repeat;</xsl:attribute>
          <TR height="40">
            <TD width="100%">
              <xsl:text>&#160;</xsl:text>
            </TD>
            <TD id="shellUsername" class="shellBannerText" nowrap="yes">
              <BR/>
              <xsl:value-of select="@username"/>
            </TD>
            <TD>
              <xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
            </TD>
            <TD id="shellActions" class="shellBannerText" nowrap="yes">
              <BR/>
              <b>
                <xsl:value-of select="@actions"/>
                <xsl:copy-of select="./i2:shellactions/*"/>
              </b>
            </TD>
            <TD>
              <xsl:text>&#160;&#160;&#160;</xsl:text>
            </TD>
          </TR>
        </TABLE>
      </TD>
    </TR>
    <TR style="line-height:6px;">
      <TD height="6" width="12" style="line-height:6px;font-size:5px;">
        <IMG height="6" width="12">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/outerborder_topleft.gif</xsl:attribute>
        </IMG>
      </TD>
      <TD width="100%" class="shellEdgeTop">
        <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/outerborder_topbar.gif)</xsl:attribute>
        <xsl:text>&#160;</xsl:text>
      </TD>
      <TD height="6" width="12" style="line-height:6px;font-size:5px;">
        <IMG height="6" width="12">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/outerborder_topright.gif</xsl:attribute>
        </IMG>
      </TD>
    </TR>
  </xsl:template>
  <xsl:template name="i2:shell_left_portion_ie">
    <TD valign="top" align="right" width="12" class="shellEdgeLeft">
      <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/outerborder_leftbar.gif)</xsl:attribute>
      <xsl:text>&#160;</xsl:text>
    </TD>
  </xsl:template>
  <xsl:template name="i2:shell_right_portion_ie">
    <TD height="100%" width="12" class="shellEdgeRight">
      <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/outerborder_rightbar.gif)</xsl:attribute>
      <xsl:text>&#160;</xsl:text>
    </TD>
  </xsl:template>
  <xsl:template name="i2:shell_bottom_portion_ie">
    <TR>
      <TD valign="top" height="12" width="12">
        <IMG height="12" width="12">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/outerborder_bottomleft.gif</xsl:attribute>
        </IMG>
      </TD>
      <TD valign="top" width="100%" class="shellEdgeBottom">
        <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/outerborder_bottombar.gif)</xsl:attribute>
        <xsl:text>&#160;</xsl:text>
      </TD>
      <TD valign="top" height="12" width="12">
        <IMG height="12" width="12">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/outerborder_bottomright.gif</xsl:attribute>
        </IMG>
      </TD>
    </TR>
  </xsl:template>
  
    <xsl:template match="i2:shell">
	  <xsl:apply-templates select="." mode="taglib"/>
	</xsl:template>
	
  <xsl:template match="i2:shell" mode="taglib">
    <xsl:choose>
      <xsl:when test="@framed='yes'">
        <SCRIPT language="javascript">
          function i2ui_shell_init(action)
          {
            var content;
            //content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><xsl:call-template name="i2:shell_top_portion_ie"/></TABLE></BODY>';
            content='<HTML><xsl:apply-templates select="//i2:stylesheet[@default='yes']" mode="taglibNS6"/><BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><xsl:call-template name="i2:shell_top_portion_ie"/></TABLE></BODY></HTML>';
            i2ui_shell_top.document.open();
            i2ui_shell_top.document.write(content);
            i2ui_shell_top.document.close();
            content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><TR height="100%"><xsl:call-template name="i2:shell_left_portion_ie"/></TR></TABLE></BODY>';
            i2ui_shell_left.document.open();
            i2ui_shell_left.document.write(content);
            i2ui_shell_left.document.close();
            content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><TR height="100%"><xsl:call-template name="i2:shell_right_portion_ie"/></TR></TABLE></BODY>';
            i2ui_shell_right.document.open();
            i2ui_shell_right.document.write(content);
            i2ui_shell_right.document.close();
            content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><xsl:call-template name="i2:shell_bottom_portion_ie"/></TABLE></BODY>';
            i2ui_shell_bottom.document.open();
            i2ui_shell_bottom.document.write(content);
            i2ui_shell_bottom.document.close();
            <xsl:if test="@onload"><xsl:text>if (action == 'load'){</xsl:text><xsl:value-of select="@onload"/>;
              <xsl:text>}</xsl:text></xsl:if><xsl:if test="@onresize"><xsl:text>if (action == 'resize'){</xsl:text><xsl:value-of select="@onresize"/>;
              <xsl:text>}</xsl:text></xsl:if>
          }
        </SCRIPT>
        <frameset rows="46,*,12" marginwidth="0" border="0" frameborder="0" framespacing="0" marginheight="0" onload="i2ui_shell_init('load')" onresize="i2ui_shell_init('resize')">
          <frame name="i2ui_shell_top" scrolling="no" frameborder="no" noresize="yes">
            <xsl:attribute name="src">
              <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:attribute>
          </frame>
          <frameset cols="12,*,12" marginwidth="0" border="0" frameborder="0" framespacing="0" marginheight="0">
            <frame name="i2ui_shell_left" scrolling="no" frameborder="no" noresize="yes">
              <xsl:attribute name="src">
                <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:attribute>
            </frame>
            <frame name="i2ui_shell_content" scrolling="auto" frameborder="no" noresize="yes">
              <xsl:attribute name="src">
                <xsl:choose>
                  <xsl:when test="@contenturl">
                    <xsl:value-of select="@contenturl"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
            </frame>
            <frame name="i2ui_shell_right" scrolling="no" frameborder="no" noresize="yes">
              <xsl:attribute name="src">
                <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:attribute>
            </frame>
          </frameset>
          <frame name="i2ui_shell_bottom" scrolling="no" frameborder="no" noresize="yes">
            <xsl:attribute name="src">
              <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:attribute>
          </frame>
        </frameset>
      </xsl:when>
      <xsl:otherwise>
        <BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody">
          <xsl:if test="@background">
            <xsl:attribute name="background">
              <xsl:value-of select="@background"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="@onload">
            <xsl:if test="not(@framed)">
              <xsl:attribute name="onload">
                <xsl:value-of select="@onload"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@framed='no'">
              <xsl:attribute name="onload">
                <xsl:value-of select="@onload"/>
              </xsl:attribute>
            </xsl:if>
          </xsl:if>
          <xsl:if test="@onresize">
            <xsl:if test="not(@framed)">
              <xsl:attribute name="onresize">
                <xsl:value-of select="@onresize"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@framed='no'">
              <xsl:attribute name="onresize">
                <xsl:value-of select="@onresize"/>
              </xsl:attribute>
            </xsl:if>
          </xsl:if>
          <TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground">
            <xsl:call-template name="i2:shell_top_portion_ie"/>
            <TR height="100%">
              <xsl:call-template name="i2:shell_left_portion_ie"/>
              <TD height="100%" class="shellContent" valign="top">
                <xsl:apply-templates mode="taglib"/>
              </TD>
              <xsl:call-template name="i2:shell_right_portion_ie"/>
            </TR>
            <xsl:call-template name="i2:shell_bottom_portion_ie"/>
          </TABLE>
        </BODY>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="i2:shell_top_portion_ns4">
    <TR height="40">
      <TD height="40" nowrap="yes" align="right" colspan="2">
        <xsl:attribute name="style">background-image:url(<xsl:value-of select="@logo"/>);background-repeat:no-repeat;</xsl:attribute>
        <BR/>
        <DIV style="position:relative" id="shellBanner" class="shellBannerText">
          <xsl:value-of select="@username"/>
          <xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
          <b>
            <xsl:value-of select="@actions"/>
            <xsl:copy-of select="./i2:shellactions/*"/>
            <xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
          </b>
        </DIV>
      </TD>
      <TD>
        <xsl:text>&#160;</xsl:text>
      </TD>
    </TR>
    <TR height="6">
      <TD style="font-size:6px;">
        <DIV style="position:relative;top:3;left:0;line-height:6px;">
          <IMG height="6" width="12">
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/outerborder_topleft.gif</xsl:attribute>
          </IMG>
        </DIV>
      </TD>
      <TD style="font-size:6px;">
        <DIV style="position:relative;top:3;left:0;line-height:6px;">
          <IMG height="6" width="100%">
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/outerborder_topbar.gif</xsl:attribute>
          </IMG>
        </DIV>
      </TD>
      <TD style="font-size:6px;">
        <DIV style="position:relative;top:3;left:0;line-height:6px;">
          <IMG height="6" width="12">
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/outerborder_topright.gif</xsl:attribute>
          </IMG>
        </DIV>
      </TD>
    </TR>
  </xsl:template>
  <xsl:template name="i2:shell_left_portion_ns4">
    <TD valign="top" align="right" width="12" class="shellEdgeLeft">
      <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/outerborder_leftbar.gif)</xsl:attribute>
      <xsl:text>&#160;</xsl:text>
    </TD>
  </xsl:template>
  <xsl:template name="i2:shell_right_portion_ns4">
    <TD height="100%" width="12" class="shellEdgeRight">
      <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/outerborder_rightbar.gif)</xsl:attribute>
      <xsl:text>&#160;</xsl:text>
    </TD>
  </xsl:template>
  <xsl:template name="i2:shell_bottom_portion_ns4">
    <TR style="line-height:12px;">
      <TD valign="top" align="right">
        <IMG height="12" width="12">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/outerborder_bottomleft.gif</xsl:attribute>
        </IMG>
      </TD>
      <TD valign="top">
        <IMG height="12" width="100%">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/outerborder_bottombar.gif</xsl:attribute>
        </IMG>
      </TD>
      <TD valign="top">
        <IMG height="12" width="12">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/outerborder_bottomright.gif</xsl:attribute>
        </IMG>
      </TD>
    </TR>
  </xsl:template>
  <xsl:template match="i2:shell" mode="taglibNS4">
    <xsl:choose>
      <xsl:when test="@framed='yes'">
        <SCRIPT language="javascript">
          function i2ui_shell_init(action)
          {
            var content;
            //content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><TR height="100%"><xsl:call-template name="i2:shell_top_portion_ns4"/></TR></TABLE></BODY>';

            <xsl:apply-templates mode="taglibNS4"/>
            content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><TR height="100%"><xsl:call-template name="i2:shell_top_portion_ns4"/></TR></TABLE></BODY>';
            i2ui_shell_top.document.open();
            i2ui_shell_top.document.write(content);
            i2ui_shell_top.document.close();
            content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><TR height="100%"><xsl:call-template name="i2:shell_left_portion_ns4"/></TR></TABLE></BODY>';
            i2ui_shell_left.document.open();
            i2ui_shell_left.document.write(content);
            i2ui_shell_left.document.close();
            content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><TR height="100%"><xsl:call-template name="i2:shell_right_portion_ns4"/></TR></TABLE></BODY>';
            i2ui_shell_right.document.open();
            i2ui_shell_right.document.write(content);
            i2ui_shell_right.document.close();
            content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><xsl:call-template name="i2:shell_bottom_portion_ns4"/></TABLE></BODY>';
            i2ui_shell_bottom.document.open();
            i2ui_shell_bottom.document.write(content);
            i2ui_shell_bottom.document.close();
            <xsl:if test="@onload"><xsl:text>if (action == 'load'){</xsl:text><xsl:value-of select="@onload"/>;
              <xsl:text>}</xsl:text></xsl:if><xsl:if test="@onresize"><xsl:text>if (action == 'resize'){</xsl:text><xsl:value-of select="@onresize"/>;
              <xsl:text>}</xsl:text></xsl:if>
          }
        </SCRIPT>
        <frameset rows="46,*,12" marginwidth="0" border="0" frameborder="0" framespacing="0" marginheight="0" onload="i2ui_shell_init('load')" onresize="i2ui_shell_init('resize')">
          <frame name="i2ui_shell_top" scrolling="no" frameborder="no" noresize="yes">
            <xsl:attribute name="src">
              <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:attribute>
          </frame>
          <frameset cols="12,*,12" marginwidth="0" border="0" frameborder="0" framespacing="0" marginheight="0">
            <frame name="i2ui_shell_left" scrolling="no" frameborder="no" noresize="yes">
              <xsl:attribute name="src">
                <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:attribute>
            </frame>
            <frame name="i2ui_shell_content" scrolling="auto" frameborder="no" noresize="yes">
              <xsl:attribute name="src">
                <xsl:choose>
                  <xsl:when test="@contenturl">
                    <xsl:value-of select="@contenturl"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
            </frame>
            <frame name="i2ui_shell_right" scrolling="no" frameborder="no" noresize="yes">
              <xsl:attribute name="src">
                <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:attribute>
            </frame>
          </frameset>
          <frame name="i2ui_shell_bottom" scrolling="no" frameborder="no" noresize="yes">
            <xsl:attribute name="src">
              <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:attribute>
          </frame>
        </frameset>
      </xsl:when>
      <xsl:otherwise>
        <BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody">
          <xsl:if test="@background">
            <xsl:attribute name="background">
              <xsl:value-of select="@background"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="@onload">
            <xsl:if test="not(@framed)">
              <xsl:attribute name="onload">
                <xsl:value-of select="@onload"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@framed='no'">
              <xsl:attribute name="onload">
                <xsl:value-of select="@onload"/>
              </xsl:attribute>
            </xsl:if>
          </xsl:if>
          <xsl:if test="@onresize">
            <xsl:if test="not(@framed)">
              <xsl:attribute name="onresize">
                <xsl:value-of select="@onresize"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@framed='no'">
              <xsl:attribute name="onresize">
                <xsl:value-of select="@onresize"/>
              </xsl:attribute>
            </xsl:if>
          </xsl:if>
          <TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground">
            <xsl:call-template name="i2:shell_top_portion_ns4"/>
            <TR height="100%">
              <xsl:call-template name="i2:shell_left_portion_ns4"/>
              <TD height="100%" class="shellContent" valign="top">
                <DIV style="padding-top:2px">
                  <xsl:apply-templates mode="taglibNS4"/>
                </DIV>
              </TD>
              <xsl:call-template name="i2:shell_right_portion_ns4"/>
            </TR>
            <xsl:call-template name="i2:shell_bottom_portion_ns4"/>
          </TABLE>
        </BODY>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="i2:shell_top_portion_ns6">
    <TR height="100%">
      <TD nowrap="yes" colspan="3">
        <TABLE cellpadding="0" cellspacing="0">
          <TR height="40">
            <TD width="100%">
              <xsl:text>&#160;</xsl:text>
            </TD>
            <TD id="shellUsername" class="shellBannerText" nowrap="yes">
              <BR/>
              <xsl:value-of select="@username"/>
            </TD>
            <TD>
              <xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
            </TD>
            <TD id="shellActions" class="shellBannerText" nowrap="yes">
              <BR/>
              <b>
                <xsl:value-of select="@actions"/>
                <xsl:copy-of select="./i2:shellactions/*"/>
              </b>
            </TD>
            <TD>
              <xsl:text>&#160;&#160;&#160;</xsl:text>
            </TD>
          </TR>
        </TABLE>
      </TD>
    </TR>
    <TR>
      <TD valign="bottom" height="6" width="12" style="font-size:5px;">
        <IMG height="6" width="12">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/outerborder_topleft.gif</xsl:attribute>
        </IMG>
      </TD>
      <TD valign="bottom" width="100%">
        <IMG height="6" width="100%">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/outerborder_topbar.gif</xsl:attribute>
        </IMG>
      </TD>
      <TD valign="bottom" height="6" width="12" style="font-size:5px;">
        <IMG height="6" width="12">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/outerborder_topright.gif</xsl:attribute>
        </IMG>
      </TD>
    </TR>
  </xsl:template>
  <xsl:template name="i2:shell_left_portion_ns6">
    <TD valign="top" align="right" width="12" class="shellEdgeLeft">
      <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/outerborder_leftbar.gif)</xsl:attribute>
      <xsl:text>&#160;</xsl:text>
    </TD>
  </xsl:template>
  <xsl:template name="i2:shell_right_portion_ns6">
    <TD height="100%" width="12" class="shellEdgeRight">
      <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/outerborder_rightbar.gif)</xsl:attribute>
      <xsl:text>&#160;</xsl:text>
    </TD>
  </xsl:template>
  <xsl:template name="i2:shell_bottom_portion_ns6">
    <TR>
      <TD valign="top" height="12" width="12">
        <IMG height="12" width="12">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/outerborder_bottomleft.gif</xsl:attribute>
        </IMG>
      </TD>
      <TD valign="top" width="100%" class="shellEdgeBottom">
        <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/outerborder_bottombar.gif)</xsl:attribute>
        <xsl:text>&#160;</xsl:text>
      </TD>
      <TD valign="top" height="12" width="12">
        <IMG height="12" width="12">
          <xsl:attribute name="src">
            <xsl:value-of select="$imageDirectory"/>/outerborder_bottomright.gif</xsl:attribute>
        </IMG>
      </TD>
    </TR>
  </xsl:template>
  <xsl:template match="i2:shell" mode="taglibNS6">
    <xsl:choose>
      <xsl:when test="@framed='yes'">
        <SCRIPT language="javascript">
          function i2ui_shell_init(action)
          {
            var content;
            //content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0"><xsl:attribute name="style">background-image:url(<xsl:value-of select="@logo"/>);background-repeat:no-repeat;</xsl:attribute><xsl:call-template name="i2:shell_top_portion_ns6"/></TABLE></BODY>';
            content='<HTML><xsl:apply-templates select="//i2:stylesheet[@default='yes']" mode="taglibNS6"/><BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><xsl:attribute name="style">background-image:url(<xsl:value-of select="@logo"/>);background-repeat:no-repeat;</xsl:attribute><xsl:call-template name="i2:shell_top_portion_ns6"/></TABLE></BODY></HTML>';
            i2ui_shell_top.document.open();
            i2ui_shell_top.document.write(content);
            i2ui_shell_top.document.close();
            content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><TR height="100%"><xsl:call-template name="i2:shell_left_portion_ns6"/></TR></TABLE></BODY>';
            i2ui_shell_left.document.open();
            i2ui_shell_left.document.write(content);
            i2ui_shell_left.document.close();
            content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><TR height="100%"><xsl:call-template name="i2:shell_right_portion_ns6"/></TR></TABLE></BODY>';
            i2ui_shell_right.document.open();
            i2ui_shell_right.document.write(content);
            i2ui_shell_right.document.close();
            content='<BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody"><xsl:if test="@background"><xsl:attribute name="background"><xsl:value-of select="@background"/></xsl:attribute></xsl:if><TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground"><xsl:call-template name="i2:shell_bottom_portion_ns6"/></TABLE></BODY>';
            i2ui_shell_bottom.document.open();
            i2ui_shell_bottom.document.write(content);
            i2ui_shell_bottom.document.close();
            <xsl:if test="@onload"><xsl:text>if (action == 'load'){</xsl:text><xsl:value-of select="@onload"/>;
              <xsl:text>}</xsl:text></xsl:if><xsl:if test="@onresize"><xsl:text>if (action == 'resize'){</xsl:text><xsl:value-of select="@onresize"/>;
              <xsl:text>}</xsl:text></xsl:if>
          }
        </SCRIPT>
        <frameset rows="46,*,12" marginwidth="0" border="0" frameborder="0" framespacing="0" marginheight="0" onload="i2ui_shell_init('load')" onresize="i2ui_shell_init('resize')">
          <frame name="i2ui_shell_top" scrolling="no" frameborder="no" noresize="yes">
            <xsl:attribute name="src">
              <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:attribute>
          </frame>
          <frameset cols="12,*,12" marginwidth="0" border="0" frameborder="0" framespacing="0" marginheight="0">
            <frame name="i2ui_shell_left" scrolling="no" frameborder="no" noresize="yes">
              <xsl:attribute name="src">
                <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:attribute>
            </frame>
            <frame name="i2ui_shell_content" scrolling="auto" frameborder="no" noresize="yes">
              <xsl:attribute name="src">
                <xsl:choose>
                  <xsl:when test="@contenturl">
                    <xsl:value-of select="@contenturl"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
            </frame>
            <frame name="i2ui_shell_right" scrolling="no" frameborder="no" noresize="yes">
              <xsl:attribute name="src">
                <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:attribute>
            </frame>
          </frameset>
          <frame name="i2ui_shell_bottom" scrolling="no" frameborder="no" noresize="yes">
            <xsl:attribute name="src">
              <xsl:value-of select="$javascriptDirectory"/>/i2uiblank.html</xsl:attribute>
          </frame>
        </frameset>
      </xsl:when>
      <xsl:otherwise>
        <BODY topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" class="shellBody">
          <xsl:if test="@background">
            <xsl:attribute name="background">
              <xsl:value-of select="@background"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="@onload">
            <xsl:if test="not(@framed)">
              <xsl:attribute name="onload">
                <xsl:value-of select="@onload"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@framed='no'">
              <xsl:attribute name="onload">
                <xsl:value-of select="@onload"/>
              </xsl:attribute>
            </xsl:if>
          </xsl:if>
          <xsl:if test="@onresize">
            <xsl:if test="not(@framed)">
              <xsl:attribute name="onresize">
                <xsl:value-of select="@onresize"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="@framed='no'">
              <xsl:attribute name="onresize">
                <xsl:value-of select="@onresize"/>
              </xsl:attribute>
            </xsl:if>
          </xsl:if>
          <TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="shellBackground">
            <xsl:call-template name="i2:shell_top_portion_ns6"/>
            <TR height="100%">
              <xsl:call-template name="i2:shell_left_portion_ns6"/>
              <TD height="100%" class="shellContent" valign="top">
                <xsl:apply-templates mode="taglib"/>
              </TD>
              <xsl:call-template name="i2:shell_right_portion_ns6"/>
            </TR>
            <xsl:call-template name="i2:shell_bottom_portion_ns6"/>
          </TABLE>
        </BODY>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="i2:shellactions" mode="taglib">
  </xsl:template>
  <xsl:template match="i2:shellactions" mode="taglibNS4">
  </xsl:template>
  <xsl:template match="i2:shellactions" mode="taglibNS6">
  </xsl:template>


  <xsl:template match="i2:vr" mode="taglib">
    <TD valign="top" align="center">
      <xsl:if test="@rowspan">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="@rowspan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="width">
        <xsl:choose>
          <xsl:when test="@width">
            <xsl:value-of select="@width"/>
          </xsl:when>
          <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="style">background-repeat:repeat-y;font-size:2px;background-position:center;background-image:url(<xsl:value-of select="$imageDirectory"/>/1x1_grey.gif)</xsl:attribute>
      <xsl:text>&#160;</xsl:text>
    </TD>
  </xsl:template>
  <xsl:template match="i2:vr" mode="taglibNS4">
    <TD width="1" valign="top" align="center" class="shellEdgeLeft">
      <xsl:if test="@rowspan">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="@rowspan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="style">background-image:url(<xsl:value-of select="$imageDirectory"/>/1x1_grey.gif)</xsl:attribute>
      <xsl:text>&#160;</xsl:text>
    </TD>
  </xsl:template>
  <xsl:template match="i2:vr" mode="taglibNS6">
    <TD valign="top" align="center">
      <xsl:if test="@rowspan">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="@rowspan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="width">
        <xsl:choose>
          <xsl:when test="@width">
            <xsl:value-of select="@width"/>
          </xsl:when>
          <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="style">background-repeat:repeat-y;font-size:2px;background-position:center;background-image:url(<xsl:value-of select="$imageDirectory"/>/1x1_grey.gif)</xsl:attribute>
      <xsl:text>&#160;</xsl:text>
    </TD>
  </xsl:template>


  <xsl:template match="i2:navarea" mode="taglib">
    <DIV id="i2uinavarea" style="overflow:auto">
      <xsl:apply-templates select="i2:pad" mode="taglib"/>
    </DIV>
  </xsl:template>
  <xsl:template match="i2:navarea" mode="taglibNS4">
    <xsl:text>&#160;</xsl:text>
    <xsl:apply-templates select="i2:pad" mode="taglibNS4"/>
    <script>i2uiTilePads();</script>
  </xsl:template>
  <xsl:template match="i2:navarea" mode="taglibNS6">
    <DIV id="i2uinavarea" style="overflow:auto">
      <xsl:apply-templates select="i2:pad" mode="taglibNS6"/>
    </DIV>
  </xsl:template>


  <xsl:template match="i2:navareatoggler" mode="taglib">
    <a id="navareatoggler">
      <xsl:attribute name="href">javascript:if (document.getElementById){ var obj = document.getElementById('navareatogglericon'); if (obj.src.indexOf('open') > 0){obj.src='<xsl:value-of select="$imageDirectory"/>/nav_pad_norgie_close.gif';} else{ obj.src='<xsl:value-of select="$imageDirectory"/>/nav_pad_norgie_open.gif';} <xsl:value-of select="@location"/>.i2uiToggleNavarea('<xsl:value-of select="@name"/>');}</xsl:attribute>
      <img id="navareatogglericon" border="0">
        <xsl:attribute name="src">
          <xsl:value-of select="$imageDirectory"/>/nav_pad_norgie_open.gif</xsl:attribute>
      </img>
    </a>
  </xsl:template>
  <xsl:template match="i2:navareatoggler" mode="taglibNS4">
    <xsl:text>&#160;</xsl:text>
  </xsl:template>
  <xsl:template match="i2:navareatoggler" mode="taglibNS6">
    <a id="navareatoggler">
      <xsl:attribute name="href">javascript:if (document.getElementById){ var obj = document.getElementById('navareatogglericon'); if (obj.src.indexOf('open') > 0){obj.src='<xsl:value-of select="$imageDirectory"/>/nav_pad_norgie_open.gif';} else{ obj.src='<xsl:value-of select="$imageDirectory"/>/nav_pad_norgie_close.gif';} <xsl:value-of select="@location"/>.i2uiToggleNavarea('<xsl:value-of select="@name"/>');}</xsl:attribute>
      <img id="navareatogglericon" border="0">
        <xsl:attribute name="src">
          <xsl:value-of select="$imageDirectory"/>/nav_pad_norgie_open.gif</xsl:attribute>
      </img>
    </a>
  </xsl:template>


  <xsl:template match="i2:pad" mode="taglib">
    <xsl:variable name="padtype">
      <xsl:choose>
        <xsl:when test="@type">
          <xsl:value-of select="@type"/>
        </xsl:when>
        <xsl:otherwise>application</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="padwidth">
      <xsl:choose>
        <xsl:when test="$padtype='doclib'">100%</xsl:when>
        <xsl:otherwise>160px</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="classname">
      <xsl:value-of select="$padtype"/>PadTitle</xsl:variable>
    <TABLE width="{$padwidth}" border="0" cellspacing="0" cellpadding="0" class="shadow">
      <xsl:attribute name="id">PAD_<xsl:value-of select="@name"/></xsl:attribute>
      <TR valign="top">
        <TD width="100%" nowrap="yes">
          <xsl:attribute name="class">
            <xsl:value-of select="$classname"/>
          </xsl:attribute>
          <DIV class="{$classname}Border0">
            <DIV class="{$classname}Border1">
              <xsl:choose>
                <xsl:when test="@onedit">
                  <TABLE>
                    <TR>
                      <TD width="100%">
                        <xsl:if test="not($padtype = 'doclib')">
                          <IMG onclick="javascript:i2uiToggleContent(this,2,'i2uiTilePads()')" onMouseOver="javascript:this.style.cursor='hand'">
                            <xsl:attribute name="src">
                              <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                          </IMG>
                        </xsl:if>
                        <xsl:text>&#160;</xsl:text>
                        <B>
                          <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
                        </B>
                      </TD>
                      <TD align="right">
                        <A href="{@onedit}">
                          <IMG border="0">
                            <xsl:attribute name="src">
                              <xsl:value-of select="$imageDirectory"/>/dropdown.gif</xsl:attribute>
                          </IMG>
                        </A>
                      </TD>
                    </TR>
                  </TABLE>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>&#160;</xsl:text>
                  <IMG onclick="javascript:i2uiToggleContent(this,1,'i2uiTilePads()')" onMouseOver="javascript:this.style.cursor='hand'">
                    <xsl:attribute name="src">
                      <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                  </IMG>
                  <xsl:text>&#160;</xsl:text>
                  <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
            </DIV>
          </DIV>
        </TD>
      </TR>
      <TBODY id="_containerBody">
        <TR valign="top">
          <TD class="containerBody">
            <DIV style="width:{$padwidth};overflow:auto">
              <xsl:attribute name="id">
                <xsl:value-of select="@name"/>_scroller</xsl:attribute>
              <TABLE width="100%" border="0" cellspacing="0" cellpadding="1">
                <xsl:attribute name="id">
                  <xsl:value-of select="@name"/>
                </xsl:attribute>
                <xsl:apply-templates mode="taglib"/>
              </TABLE>
            </DIV>
          </TD>
        </TR>
      </TBODY>
    </TABLE>
    <SCRIPT>
      i2uiCollapsePadTree('<xsl:value-of select="@name"/>',1);
      i2uiPad.instances[i2uiPad.count]='<xsl:value-of select="@name"/>';
      i2uiPad.count++;
      i2uiManagePadScroller('<xsl:value-of select="@name"/>');
    </SCRIPT>
  </xsl:template>
  <xsl:template match="i2:pad" mode="taglibNS4">
    <LAYER clip="160,35" top="8" left="8" bgcolor="#999999">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:apply-templates mode="taglibNS4"/>
    </LAYER>
    <xsl:text disable-output-escaping="yes">&lt;SCRIPT&gt;</xsl:text>
      new i2uiPad(document.<xsl:value-of select="@name"/>,'<xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>',"<xsl:value-of select="@onedit"/>");
      i2uiTilePadItems('<xsl:value-of select="@name"/>',0);
    <xsl:text disable-output-escaping="yes">&lt;/SCRIPT&gt;</xsl:text></xsl:template>
  <xsl:template match="i2:pad" mode="taglibNS6">
    <xsl:variable name="padtype">
      <xsl:choose>
        <xsl:when test="@type">
          <xsl:value-of select="@type"/>
        </xsl:when>
        <xsl:otherwise>application</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="padwidth">
      <xsl:choose>
        <xsl:when test="$padtype='doclib'">100%</xsl:when>
        <xsl:otherwise>160px</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="classname">
      <xsl:value-of select="$padtype"/>PadTitle</xsl:variable>
    <TABLE width="{$padwidth}" border="0" cellspacing="0" cellpadding="0" class="shadow">
      <xsl:attribute name="id">PAD_<xsl:value-of select="@name"/></xsl:attribute>
      <TR valign="top">
        <TD width="100%" nowrap="yes">
          <xsl:attribute name="class">
            <xsl:value-of select="$classname"/>
          </xsl:attribute>
          <DIV class="{$classname}Border0">
            <DIV class="{$classname}Border1">
              <xsl:choose>
                <xsl:when test="@onedit">
                  <TABLE>
                    <TR>
                      <TD width="100%">
                        <xsl:if test="not($padtype = 'doclib')">
                          <IMG onclick="javascript:i2uiToggleContent(this,2,'i2uiTilePads()')" onMouseOver="javascript:this.style.cursor='hand'">
                            <xsl:attribute name="src">
                              <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                          </IMG>
                        </xsl:if>
                        <xsl:text>&#160;</xsl:text>
                        <B>
                          <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
                        </B>
                      </TD>
                      <TD align="right">
                        <A href="{@onedit}">
                          <IMG border="0">
                            <xsl:attribute name="src">
                              <xsl:value-of select="$imageDirectory"/>/dropdown.gif</xsl:attribute>
                          </IMG>
                        </A>
                      </TD>
                    </TR>
                  </TABLE>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>&#160;</xsl:text>
                  <IMG onclick="javascript:i2uiToggleContent(this,1,'i2uiTilePads()')" onMouseOver="javascript:this.style.cursor='hand'">
                    <xsl:attribute name="src">
                      <xsl:value-of select="$imageDirectory"/>/container_collapse.gif</xsl:attribute>
                  </IMG>
                  <xsl:text>&#160;</xsl:text>
                  <xsl:call-template name="i18n:text"><xsl:with-param name="key" select="@title"/></xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
            </DIV>
          </DIV>
        </TD>
      </TR>
      <TBODY id="_containerBody">
        <TR valign="top">
          <TD class="containerBody">
            <DIV style="width:{$padwidth};overflow:auto">
              <xsl:attribute name="id">
                <xsl:value-of select="@name"/>_scroller</xsl:attribute>
              <TABLE width="100%" border="0" cellspacing="0" cellpadding="1">
                <xsl:attribute name="id">
                  <xsl:value-of select="@name"/>
                </xsl:attribute>
                <xsl:apply-templates mode="taglibNS6"/>
              </TABLE>
            </DIV>
          </TD>
        </TR>
      </TBODY>
    </TABLE>
    <SCRIPT>
      i2uiCollapsePadTree('<xsl:value-of select="@name"/>',1);
      i2uiPad.instances[i2uiPad.count]='<xsl:value-of select="@name"/>';
      i2uiPad.count++;
      i2uiManagePadScroller('<xsl:value-of select="@name"/>');
    </SCRIPT>
  </xsl:template>


  <xsl:template match="i2:paditem" mode="taglib">
    <xsl:variable name="name">
      <xsl:apply-templates select="parent::*" mode="taglibgeneratekey"/>_<xsl:value-of select="count(preceding-sibling::*)+1"/></xsl:variable>
    <xsl:variable name="depth">
      <xsl:value-of select="count(ancestor::*[name()='i2:paditem'])"/>
    </xsl:variable>
    <xsl:variable name="classname">
      <xsl:choose>
        <xsl:when test="ancestor::i2:pad[@type='solution']">solution</xsl:when>
        <xsl:otherwise>application</xsl:otherwise>
      </xsl:choose>
      <xsl:text>PadContent</xsl:text>
      <xsl:choose>
        <xsl:when test="$depth = 0">0</xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="padname">
      <xsl:value-of select="ancestor::i2:pad/@name"/>
    </xsl:variable>
    <TR>
      <xsl:attribute name="class">
        <xsl:value-of select="$classname"/>
      </xsl:attribute>
      <xsl:if test="@selected='yes'">
        <xsl:attribute name="id">
          <xsl:choose>
            <xsl:when test="ancestor::i2:pad[@type='solution']">solution</xsl:when>
            <xsl:otherwise>application</xsl:otherwise>
          </xsl:choose>
          <xsl:text>HighlightedPadContent</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <TD nowrap="yes">
        <xsl:attribute name="id">TREECELL_<xsl:value-of select="$name"/></xsl:attribute>
        <xsl:call-template name="i2:paditemindent">
          <xsl:with-param name="depth" select="$depth"/>
        </xsl:call-template>
        <xsl:text>&#160;</xsl:text>
        <A>
          <xsl:attribute name="href">javascript:i2uiManagePadTree('<xsl:value-of select="$padname"/>','<xsl:value-of select="$name"/>',0,null,null,null,'i2uiTilePads()')</xsl:attribute>
          <IMG border="0">
            <xsl:attribute name="id">TREECELLIMAGE_<xsl:value-of select="$padname"/>_<xsl:value-of select="$name"/></xsl:attribute>
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/plus_norgie.gif</xsl:attribute>
          </IMG>
        </A>
        <xsl:choose>
          <xsl:when test="@onclick and not(@disabled='yes')">
            <A>
              <xsl:attribute name="href">
                <xsl:value-of select="@onclick"/>
              </xsl:attribute>
              <xsl:if test="@target">
                <xsl:attribute name="target">
                  <xsl:value-of select="@target"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:if test="@tooltip">
                <xsl:attribute name="title">
                  <xsl:value-of select="@tooltip"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:attribute name="onclick">javascript:i2uiHighlightPadItem('TREECELL_<xsl:value-of select="$name"/>')</xsl:attribute>
              <xsl:value-of select="@text"/>
            </A>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="@disabled='yes'">
                <SPAN class="linkDisabled">
                  <xsl:value-of select="@text"/>
                </SPAN>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@text"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </TD>
    </TR>
    <xsl:if test="@selected='yes'">
      <SCRIPT>
        i2uiHighlightPadItem('TREECELL_<xsl:value-of select="$name"/>');
      </SCRIPT>
    </xsl:if>
    <xsl:apply-templates mode="taglib"/>
  </xsl:template>
  <xsl:template match="i2:paditem" mode="taglibNS4">
    <xsl:variable name="name">
      <xsl:apply-templates select="parent::*" mode="taglibgeneratekey"/>_<xsl:value-of select="count(preceding-sibling::*)+1"/></xsl:variable>
    <xsl:variable name="depth">
      <xsl:value-of select="count(ancestor::*[name()='i2:paditem'])"/>
    </xsl:variable>
    <xsl:variable name="textcolor">
      <xsl:choose>
        <xsl:when test="@disabled='yes'">#a0a0a0</xsl:when>
        <xsl:otherwise>#505050</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="bgcolor">
      <xsl:choose>
        <xsl:when test="@selected='yes'">
          <xsl:choose>
            <xsl:when test="ancestor::i2:pad[@type='solution']">#e6e6e6</xsl:when>
            <xsl:otherwise>#fff274</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="ancestor::i2:pad[@type='solution']">#ffffff</xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="$depth = 0">#e4e6f5</xsl:when>
            <xsl:otherwise>#f7f8fd</xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="padname">
      <xsl:value-of select="ancestor::i2:pad/@name"/>
    </xsl:variable>
    <LAYER clip="158,20" left="1">
      <xsl:attribute name="name">
        <xsl:value-of select="$name"/>
      </xsl:attribute>
      <xsl:attribute name="bgcolor">
        <xsl:value-of select="$bgcolor"/>
      </xsl:attribute>
      <xsl:if test="$depth &gt; 0">
        <xsl:attribute name="visibility">hidden</xsl:attribute>
      </xsl:if>
      <NOBR>
        <DIV>
          <xsl:attribute name="style">color:<xsl:value-of select="$textcolor"/>;text-decoration:none;font-family:verdana,sans-serif;font-size:11px;</xsl:attribute>
          <xsl:call-template name="i2:paditemindent">
            <xsl:with-param name="depth" select="$depth"/>
          </xsl:call-template>
          <xsl:text>&#160;</xsl:text>
          <A>
            <xsl:attribute name="href">javascript:i2uiTogglePadItem(this,'<xsl:value-of select="$padname"/>','<xsl:value-of select="$name"/>')</xsl:attribute>
            <IMG border="0" name="toggler">
              <xsl:attribute name="src">
                <xsl:value-of select="$imageDirectory"/>/plus_norgie.gif</xsl:attribute>
            </IMG>
          </A>
          <xsl:text>&#160;</xsl:text>
          <xsl:choose>
            <xsl:when test="@onclick">
              <A style="color:#505050;text-decoration:none;font-family:verdana,sans-serif;font-size:11px;">
                <xsl:attribute name="href">
                  <xsl:value-of select="@onclick"/>
                </xsl:attribute>
                <xsl:if test="@target">
                  <xsl:attribute name="target">
                    <xsl:value-of select="@target"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="@tooltip">
                  <xsl:attribute name="title">
                    <xsl:value-of select="@tooltip"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:attribute name="onclick">javascript:i2uiHighlightPadItem('<xsl:value-of select="$name"/>')</xsl:attribute>
                <xsl:choose>
                  <xsl:when test="@selected='yes' and ancestor::i2:pad[@type='solution']">
                    <b>
                      <xsl:value-of select="@text"/>
                    </b>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="@text"/>
                  </xsl:otherwise>
                </xsl:choose>
              </A>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="@selected='yes' and ancestor::i2:pad[@type='solution']">
                  <b>
                    <xsl:value-of select="@text"/>
                  </b>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@text"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </DIV>
      </NOBR>
      <xsl:apply-templates mode="taglibNS4"/>
    </LAYER>
    <xsl:if test="@selected='yes'">
      <SCRIPT>
        i2uiHighlightPadItem('<xsl:value-of select="$name"/>');
      </SCRIPT>
    </xsl:if>
  </xsl:template>
  <xsl:template match="i2:paditem" mode="taglibNS6">
    <xsl:variable name="name">
      <xsl:apply-templates select="parent::*" mode="taglibgeneratekey"/>_<xsl:value-of select="count(preceding-sibling::*)+1"/></xsl:variable>
    <xsl:variable name="depth">
      <xsl:value-of select="count(ancestor::*[name()='i2:paditem'])"/>
    </xsl:variable>
    <xsl:variable name="classname">
      <xsl:choose>
        <xsl:when test="ancestor::i2:pad[@type='solution']">solution</xsl:when>
        <xsl:otherwise>application</xsl:otherwise>
      </xsl:choose>
      <xsl:text>PadContent</xsl:text>
      <xsl:choose>
        <xsl:when test="$depth = 0">0</xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="padname">
      <xsl:value-of select="ancestor::i2:pad/@name"/>
    </xsl:variable>
    <TR>
      <xsl:attribute name="class">
        <xsl:value-of select="$classname"/>
      </xsl:attribute>
      <xsl:if test="@selected='yes'">
        <xsl:attribute name="id">
          <xsl:choose>
            <xsl:when test="ancestor::i2:pad[@type='solution']">solution</xsl:when>
            <xsl:otherwise>application</xsl:otherwise>
          </xsl:choose>
          <xsl:text>HighlightedPadContent</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <TD nowrap="yes">
        <xsl:attribute name="id">TREECELL_<xsl:value-of select="$name"/></xsl:attribute>
        <xsl:call-template name="i2:paditemindent">
          <xsl:with-param name="depth" select="$depth"/>
        </xsl:call-template>
        <xsl:text>&#160;</xsl:text>
        <A>
          <xsl:attribute name="href">javascript:i2uiManagePadTree('<xsl:value-of select="$padname"/>','<xsl:value-of select="$name"/>',0,null,null,null,'i2uiTilePads()')</xsl:attribute>
          <IMG border="0">
            <xsl:attribute name="id">TREECELLIMAGE_<xsl:value-of select="$padname"/>_<xsl:value-of select="$name"/></xsl:attribute>
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/plus_norgie.gif</xsl:attribute>
          </IMG>
        </A>
        <xsl:choose>
          <xsl:when test="@onclick and not(@disabled='yes')">
            <A>
              <xsl:attribute name="href">
                <xsl:value-of select="@onclick"/>
              </xsl:attribute>
              <xsl:if test="@target">
                <xsl:attribute name="target">
                  <xsl:value-of select="@target"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:if test="@tooltip">
                <xsl:attribute name="title">
                  <xsl:value-of select="@tooltip"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:attribute name="onclick">javascript:i2uiHighlightPadItem('TREECELL_<xsl:value-of select="$name"/>')</xsl:attribute>
              <xsl:value-of select="@text"/>
            </A>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="@disabled='yes'">
                <SPAN class="linkDisabled">
                  <xsl:value-of select="@text"/>
                </SPAN>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@text"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </TD>
    </TR>
    <xsl:if test="@selected='yes'">
      <SCRIPT>
        i2uiHighlightPadItem('TREECELL_<xsl:value-of select="$name"/>');
      </SCRIPT>
    </xsl:if>
    <xsl:apply-templates mode="taglibNS6"/>
  </xsl:template>

  <xsl:template match="i2:paditem" mode="taglibgeneratekey">
    <xsl:apply-templates select="parent::*" mode="taglibgeneratekey"/>
    <xsl:text>_</xsl:text>
    <xsl:value-of select="count(preceding-sibling::*)+1"/>
  </xsl:template>

  <xsl:template match="i2:pad" mode="taglibgeneratekey">
    <xsl:value-of select="@name"/>
  </xsl:template>

  <xsl:template name="i2:paditemindent">
    <xsl:param name="depth">0</xsl:param>
    <xsl:if test="$depth &gt; 0">
      <xsl:text>&#160;&#160;</xsl:text>
      <xsl:call-template name="i2:indent">
        <xsl:with-param name="depth" select="$depth - 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:variable name="CANCEL_KEY">cancel</xsl:variable>
  <xsl:variable name="NO_KEY">no</xsl:variable>
  <xsl:variable name="YES_KEY">yes</xsl:variable>
  <xsl:variable name="OK_KEY">yes</xsl:variable>
  <xsl:variable name="DAYLETTERS_KEY">yes</xsl:variable>
  <xsl:variable name="TODAY_KEY">today</xsl:variable>

  <xsl:template match="i2:messagebox" mode="taglib">
    <xsl:variable name="locale">
      <xsl:choose>
        <xsl:when test="@locale">
          <xsl:value-of select="@locale"/>
        </xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE class="messageBoxBackground" width="100%" height="100%">
      <TR height="100%">
        <TD valign="top" style="padding:8px 16px">
          <IMG>
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/alert_<xsl:if test="not(@icontype='WARN')">green_</xsl:if>static.gif</xsl:attribute>
          </IMG>
        </TD>
        <TD width="100%" valign="top" style="padding:8px 8px 8px 0px">
          <xsl:apply-templates mode="taglib"/>
        </TD>
      </TR>
      <TR>
        <TD colspan="2" style="padding:4px">
          <TABLE cellpadding="4">
            <TR>
              <TD width="100%">&#160;
              </TD>
              <xsl:if test="contains(@interaction,'CANCEL')">
                <TD>
                  <DIV style="border:1px solid #505050">
                    <BUTTON id="buttonRegular" onclick="javascript:i2uiCloseMessageBox('cancel')">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:call-template name="i2uitranslate">
                        <xsl:with-param name="locale" select="$locale"/>
                        <xsl:with-param name="key" select="$CANCEL_KEY"/>
                      </xsl:call-template>
                      <xsl:text>&#160;</xsl:text>
                    </BUTTON>
                  </DIV>
                </TD>
                <xsl:if test="contains(@interaction,'NO')">
                  <TD nowrap="yes">
                    <IMG>
                      <xsl:attribute name="src">
                        <xsl:value-of select="$imageDirectory"/>/blue_divider.gif</xsl:attribute>
                    </IMG>
                  </TD>
                </xsl:if>
              </xsl:if>
              <xsl:if test="contains(@interaction,'NO')">
                <TD>
                  <DIV style="border:1px solid #505050">
                    <BUTTON id="buttonRegular" onclick="javascript:i2uiCloseMessageBox('no')">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:call-template name="i2uitranslate">
                        <xsl:with-param name="locale" select="$locale"/>
                        <xsl:with-param name="key" select="$NO_KEY"/>
                      </xsl:call-template>
                      <xsl:text>&#160;</xsl:text>
                    </BUTTON>
                  </DIV>
                </TD>
              </xsl:if>
              <xsl:if test="contains(@interaction,'YES')">
                <TD>
                  <DIV style="border:1px solid #505050">
                    <BUTTON id="buttonRegular" onclick="javascript:i2uiCloseMessageBox('yes')">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:call-template name="i2uitranslate">
                        <xsl:with-param name="locale" select="$locale"/>
                        <xsl:with-param name="key" select="$YES_KEY"/>
                      </xsl:call-template>
                      <xsl:text>&#160;</xsl:text>
                    </BUTTON>
                  </DIV>
                </TD>
              </xsl:if>
              <xsl:if test="contains(@interaction,'OK')">
                <TD>
                  <DIV style="border:1px solid #505050">
                    <BUTTON id="buttonRegular" onclick="javascript:i2uiCloseMessageBox('ok')">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:call-template name="i2uitranslate">
                        <xsl:with-param name="locale" select="$locale"/>
                        <xsl:with-param name="key" select="$OK_KEY"/>
                      </xsl:call-template>
                      <xsl:text>&#160;</xsl:text>
                    </BUTTON>
                  </DIV>
                </TD>
              </xsl:if>
            </TR>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:messagebox" mode="taglibNS6">
    <xsl:variable name="locale">
      <xsl:choose>
        <xsl:when test="@locale">
          <xsl:value-of select="@locale"/>
        </xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <TABLE class="messageBoxBackground" width="100%" height="100%">
      <TR height="100%">
        <TD valign="top" style="padding:8px 16px">
          <IMG>
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/alert_<xsl:if test="not(@icontype='WARN')">green_</xsl:if>static.gif</xsl:attribute>
          </IMG>
        </TD>
        <TD width="100%" valign="top" style="padding:8px 8px 8px 0px">
          <xsl:apply-templates mode="taglibNS6"/>
        </TD>
      </TR>
      <TR>
        <TD colspan="2" style="padding:4px">
          <TABLE cellpadding="4">
            <TR>
              <TD width="100%">&#160;
              </TD>
              <xsl:if test="contains(@interaction,'CANCEL')">
                <TD>
                  <DIV style="border:1px solid #505050">
                    <BUTTON id="buttonRegular" onclick="javascript:i2uiCloseMessageBox('cancel')">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:call-template name="i2uitranslate">
                        <xsl:with-param name="locale" select="$locale"/>
                        <xsl:with-param name="key" select="$CANCEL_KEY"/>
                      </xsl:call-template>
                      <xsl:text>&#160;</xsl:text>
                    </BUTTON>
                  </DIV>
                </TD>
                <xsl:if test="contains(@interaction,'NO')">
                  <TD nowrap="yes">
                    <IMG>
                      <xsl:attribute name="src">
                        <xsl:value-of select="$imageDirectory"/>/blue_divider.gif</xsl:attribute>
                    </IMG>
                  </TD>
                </xsl:if>
              </xsl:if>
              <xsl:if test="contains(@interaction,'NO')">
                <TD>
                  <DIV style="border:1px solid #505050">
                    <BUTTON id="buttonRegular" onclick="javascript:i2uiCloseMessageBox('no')">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:call-template name="i2uitranslate">
                        <xsl:with-param name="locale" select="$locale"/>
                        <xsl:with-param name="key" select="$NO_KEY"/>
                      </xsl:call-template>
                      <xsl:text>&#160;</xsl:text>
                    </BUTTON>
                  </DIV>
                </TD>
              </xsl:if>
              <xsl:if test="contains(@interaction,'YES')">
                <TD>
                  <DIV style="border:1px solid #505050">
                    <BUTTON id="buttonRegular" onclick="javascript:i2uiCloseMessageBox('yes')">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:call-template name="i2uitranslate">
                        <xsl:with-param name="locale" select="$locale"/>
                        <xsl:with-param name="key" select="$YES_KEY"/>
                      </xsl:call-template>
                      <xsl:text>&#160;</xsl:text>
                    </BUTTON>
                  </DIV>
                </TD>
              </xsl:if>
              <xsl:if test="contains(@interaction,'OK')">
                <TD>
                  <DIV style="border:1px solid #505050">
                    <BUTTON id="buttonRegular" onclick="javascript:i2uiCloseMessageBox('ok')">
                      <xsl:text>&#160;</xsl:text>
                      <xsl:call-template name="i2uitranslate">
                        <xsl:with-param name="locale" select="$locale"/>
                        <xsl:with-param name="key" select="$OK_KEY"/>
                      </xsl:call-template>
                      <xsl:text>&#160;</xsl:text>
                    </BUTTON>
                  </DIV>
                </TD>
              </xsl:if>
            </TR>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>

  <xsl:template match="i2:formlabel" mode="taglib">
    <TD nowrap="yes" class="formLabel">
      <xsl:apply-templates mode="taglib"/>
      <xsl:if test="@required='yes'">
        <SPAN class="requiredIndicator">*</SPAN>
      </xsl:if>
    </TD>
  </xsl:template>
  <xsl:template match="i2:formlabel" mode="taglibNS4">
    <TD nowrap="yes" class="formLabel">
      <xsl:apply-templates mode="taglibNS4"/>
      <xsl:if test="@required='yes'">
        <SPAN class="requiredIndicator">*</SPAN>
      </xsl:if>
    </TD>
  </xsl:template>
  <xsl:template match="i2:formlabel" mode="taglibNS6">
    <TD nowrap="yes" class="formLabel">
      <xsl:apply-templates mode="taglibNS6"/>
      <xsl:if test="@required='yes'">
        <SPAN class="requiredIndicator">*</SPAN>
      </xsl:if>
    </TD>
  </xsl:template>


  <xsl:template match="i2:region" mode="taglib">
    <DIV id="i2uiregion" class="region">
      <xsl:apply-templates mode="taglib"/>
    </DIV>
  </xsl:template>
  <xsl:template match="i2:region" mode="taglibNS4">
    <HR size="1"/>
    <xsl:apply-templates mode="taglibNS4"/>
  </xsl:template>
  <xsl:template match="i2:region" mode="taglibNS6">
    <DIV id="i2uiregion" class="regionNS6">
      <xsl:apply-templates mode="taglibNS6"/>
    </DIV>
  </xsl:template>


  <xsl:template match="i2:instructionsarea" mode="taglib">
    <P class="instructionsArea">
      <xsl:apply-templates mode="taglib"/>
    </P>
  </xsl:template>
  <xsl:template match="i2:instructionsarea" mode="taglibNS4">
    <P class="instructionsArea">
      <xsl:apply-templates mode="taglibNS4"/>
    </P>
  </xsl:template>
  <xsl:template match="i2:instructionsarea" mode="taglibNS6">
    <P class="instructionsArea">
      <xsl:apply-templates mode="taglibNS6"/>
    </P>
  </xsl:template>


  <xsl:template match="i2:panelform" mode="taglib">
    <TABLE border="0" height="100%" width="100%" cellpadding="0" cellspacing="0">
      <TR>
        <TD width="134" valign="top">
          <xsl:attribute name="style">background-repeat:y-report;background-image:url(<xsl:value-of select="$imageDirectory"/>/login_panel_filler.jpg)</xsl:attribute>
          <IMG hspace="0" vspace="0">
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/login_panel_top.jpg</xsl:attribute>
          </IMG>
        </TD>
        <TD rowspan="2" width="20">
          <xsl:text>&#160;</xsl:text>
        </TD>
        <TD valign="top" rowspan="2" width="100%">
          <xsl:apply-templates mode="taglib"/>
        </TD>
      </TR>
      <TR>
        <TD width="134" height="100" valign="bottom">
          <xsl:attribute name="style">background-repeat:y-report;background-image:url(<xsl:value-of select="$imageDirectory"/>/login_panel_filler.jpg)</xsl:attribute>
          <IMG hspace="0" vspace="0">
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/login_panel_bottom.jpg</xsl:attribute>
          </IMG>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:panelform" mode="taglibNS4">
    <TABLE border="0" height="100%" width="100%" cellpadding="0" cellspacing="0">
      <TR>
        <TD width="134" valign="top">
          <xsl:attribute name="style">background-repeat:y-report;background-image:url(<xsl:value-of select="$imageDirectory"/>/login_panel_filler.jpg)</xsl:attribute>
          <IMG hspace="0" vspace="0">
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/login_panel_top.jpg</xsl:attribute>
          </IMG>
        </TD>
        <TD rowspan="2" width="20">
          <xsl:text>&#160;</xsl:text>
        </TD>
        <TD valign="top" rowspan="2" width="100%">
          <xsl:apply-templates mode="taglib"/>
        </TD>
      </TR>
      <TR>
        <TD width="134" height="100" valign="bottom">
          <xsl:attribute name="style">background-repeat:y-report;background-image:url(<xsl:value-of select="$imageDirectory"/>/login_panel_filler.jpg)</xsl:attribute>
          <IMG hspace="0" vspace="0">
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/login_panel_bottom.jpg</xsl:attribute>
          </IMG>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>
  <xsl:template match="i2:panelform" mode="taglibNS6">
    <TABLE border="0" height="100%" width="100%" cellpadding="0" cellspacing="0">
      <TR>
        <TD width="134" valign="top">
          <xsl:attribute name="style">background-repeat:y-report;background-image:url(<xsl:value-of select="$imageDirectory"/>/login_panel_filler.jpg)</xsl:attribute>
          <IMG hspace="0" vspace="0">
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/login_panel_top.jpg</xsl:attribute>
          </IMG>
        </TD>
        <TD rowspan="2" width="20">
          <xsl:text>&#160;</xsl:text>
        </TD>
        <TD valign="top" rowspan="2" width="100%">
          <xsl:apply-templates mode="taglibNS6"/>
        </TD>
      </TR>
      <TR>
        <TD width="134" height="100" valign="bottom">
          <xsl:attribute name="style">background-repeat:y-report;background-image:url(<xsl:value-of select="$imageDirectory"/>/login_panel_filler.jpg)</xsl:attribute>
          <IMG hspace="0" vspace="0">
            <xsl:attribute name="src">
              <xsl:value-of select="$imageDirectory"/>/login_panel_bottom.jpg</xsl:attribute>
          </IMG>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>


  <xsl:template match="i2:formtable" mode="taglib">
    <DIV class="formTable">
      <xsl:if test="@readonly='yes'">
        <xsl:attribute name="id">readOnly</xsl:attribute>
      </xsl:if>
      <TABLE border="0" cellspacing="2" cellpadding="0">
        <xsl:apply-templates mode="taglib"/>
      </TABLE>
    </DIV>
  </xsl:template>
  <xsl:template match="i2:formtable" mode="taglibNS4">
    <DIV class="formTableNS4">
      <xsl:if test="@readonly='yes'">
        <xsl:attribute name="id">readOnly</xsl:attribute>
      </xsl:if>
      <TABLE border="0" cellspacing="2" cellpadding="0">
        <xsl:apply-templates mode="taglibNS4"/>
      </TABLE>
      <BR/>
    </DIV>
  </xsl:template>
  <xsl:template match="i2:formtable" mode="taglibNS6">
    <DIV class="formTable">
      <xsl:if test="@readonly='yes'">
        <xsl:attribute name="id">readOnly</xsl:attribute>
      </xsl:if>
      <TABLE border="0" cellspacing="2" cellpadding="0">
        <xsl:apply-templates mode="taglibNS6"/>
      </TABLE>
    </DIV>
  </xsl:template>


  <xsl:template match="i2:formfieldgap" mode="taglib">
    <TD width="2" style="font-size:1px">
      <xsl:if test="@rowspan">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="@rowspan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:text>&#160;</xsl:text>
    </TD>
  </xsl:template>
  <xsl:template match="i2:formfieldgap" mode="taglibNS4">
  </xsl:template>
  <xsl:template match="i2:formfieldgap" mode="taglibNS6">
    <TD width="2" style="font-size:1px">
      <xsl:if test="@rowspan">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="@rowspan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:text>&#160;</xsl:text>
    </TD>
  </xsl:template>


  <xsl:template name="i2:formclass_IE">
    <xsl:param name="parm">
    </xsl:param>
    <xsl:variable name="lowercase_parm">
      <xsl:value-of select="translate($parm,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
    </xsl:variable>
    <xsl:variable name="key1">type = &apos;</xsl:variable>
    <xsl:variable name="key2">type= &apos;</xsl:variable>
    <xsl:variable name="key3">type =&apos;</xsl:variable>
    <xsl:variable name="key4">type=&apos;</xsl:variable>
    <xsl:variable name="key5">type = &quot;</xsl:variable>
    <xsl:variable name="key6">type= &quot;</xsl:variable>
    <xsl:variable name="key7">type =&quot;</xsl:variable>
    <xsl:variable name="key8">type=&quot;</xsl:variable>
    <xsl:variable name="type">
      <xsl:value-of select="concat(substring-after($lowercase_parm,$key1),substring-after($lowercase_parm,$key2),substring-after($lowercase_parm,$key3),substring-after($lowercase_parm,$key4),substring-after($lowercase_parm,$key5),substring-after($lowercase_parm,$key6),substring-after($lowercase_parm,$key7),substring-after($lowercase_parm,$key8))"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="starts-with($type,'inputfield')">inputField</xsl:when>
      <xsl:when test="starts-with($type,'smallinputfield')">smallinputField</xsl:when>
      <xsl:when test="starts-with($type,'displayfield')">displayField</xsl:when>
      <xsl:when test="starts-with($type,'smalldisplayfield')">smalldisplayField</xsl:when>
      <xsl:when test="starts-with($type,'pulldown')">pulldown</xsl:when>
      <xsl:when test="starts-with($type,'listdisplayfield')">listDisplayField</xsl:when>
      <xsl:otherwise>bodyText</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="i2:formclass_NS4">
    <xsl:param name="parm">
    </xsl:param>
    <xsl:variable name="lowercase_parm">
      <xsl:value-of select="translate($parm,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
    </xsl:variable>
    <xsl:variable name="key1">type = &apos;</xsl:variable>
    <xsl:variable name="key2">type= &apos;</xsl:variable>
    <xsl:variable name="key3">type =&apos;</xsl:variable>
    <xsl:variable name="key4">type=&apos;</xsl:variable>
    <xsl:variable name="key5">type = &quot;</xsl:variable>
    <xsl:variable name="key6">type= &quot;</xsl:variable>
    <xsl:variable name="key7">type =&quot;</xsl:variable>
    <xsl:variable name="key8">type=&quot;</xsl:variable>
    <xsl:variable name="type">
      <xsl:value-of select="concat(substring-after($lowercase_parm,$key1),substring-after($lowercase_parm,$key2),substring-after($lowercase_parm,$key3),substring-after($lowercase_parm,$key4),substring-after($lowercase_parm,$key5),substring-after($lowercase_parm,$key6),substring-after($lowercase_parm,$key7),substring-after($lowercase_parm,$key8))"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="starts-with($type,'inputfield')">inputFieldNS4</xsl:when>
      <xsl:when test="starts-with($type,'smallinputfield')">smallinputFieldNS4</xsl:when>
      <xsl:when test="starts-with($type,'displayfield')">displayFieldNS4</xsl:when>
      <xsl:when test="starts-with($type,'smalldisplayfield')">smalldisplayFieldNS4</xsl:when>
      <xsl:when test="starts-with($type,'pulldown')">pulldownNS4</xsl:when>
      <xsl:when test="starts-with($type,'listdisplayfield')">listDisplayField</xsl:when>
      <xsl:otherwise>bodyText</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="i2:formclass_NS6">
    <xsl:param name="parm">
    </xsl:param>
    <xsl:variable name="lowercase_parm">
      <xsl:value-of select="translate($parm,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
    </xsl:variable>
    <xsl:variable name="key1">type = &apos;</xsl:variable>
    <xsl:variable name="key2">type= &apos;</xsl:variable>
    <xsl:variable name="key3">type =&apos;</xsl:variable>
    <xsl:variable name="key4">type=&apos;</xsl:variable>
    <xsl:variable name="key5">type = &quot;</xsl:variable>
    <xsl:variable name="key6">type= &quot;</xsl:variable>
    <xsl:variable name="key7">type =&quot;</xsl:variable>
    <xsl:variable name="key8">type=&quot;</xsl:variable>
    <xsl:variable name="type">
      <xsl:value-of select="concat(substring-after($lowercase_parm,$key1),substring-after($lowercase_parm,$key2),substring-after($lowercase_parm,$key3),substring-after($lowercase_parm,$key4),substring-after($lowercase_parm,$key5),substring-after($lowercase_parm,$key6),substring-after($lowercase_parm,$key7),substring-after($lowercase_parm,$key8))"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="starts-with($type,'inputfield')">inputField</xsl:when>
      <xsl:when test="starts-with($type,'smallinputfield')">smallinputField</xsl:when>
      <xsl:when test="starts-with($type,'displayfield')">displayField</xsl:when>
      <xsl:when test="starts-with($type,'smalldisplayfield')">smalldisplayField</xsl:when>
      <xsl:when test="starts-with($type,'pulldown')">pulldown</xsl:when>
      <xsl:when test="starts-with($type,'listdisplayfield')">listDisplayField</xsl:when>
      <xsl:otherwise>bodyText</xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="i2:indent">
    <xsl:param name="depth">0</xsl:param>
    <xsl:if test="$depth &gt; 0">
      <xsl:text>&#160;&#160;&#160;</xsl:text>
      <xsl:call-template name="i2:indent">
        <xsl:with-param name="depth" select="$depth - 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--
       i2:datepicker templates
    -->
  <xsl:template match="i2:datepicker" mode="taglibNS6">
    <xsl:apply-templates select=".">
      <xsl:with-param name="browser">NS6</xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="i2:datepicker" mode="taglib">
    <xsl:apply-templates select=".">
      <xsl:with-param name="browser">IE</xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="i2:datepicker">
    <xsl:param name="browser">IE</xsl:param>

    <xsl:if test="@id and @okcallback">
      <xsl:variable name="locale">
        <xsl:choose>
          <xsl:when test="@locale">
            <xsl:value-of select="@locale"/>
          </xsl:when>
          <xsl:otherwise>en</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="embedded">
        <xsl:choose>
          <xsl:when test="@embedded">
            <xsl:value-of select="@embedded"/>
          </xsl:when>
          <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="selectioncallback">
        <xsl:choose>
          <xsl:when test="$embedded = 'yes'">
            <xsl:value-of select="@okcallback"/>
          </xsl:when>
          <xsl:otherwise>null</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <SCRIPT LANGUAGE="JavaScript">var mySelectionCallback = '<xsl:value-of select="$selectioncallback"/>';</SCRIPT>
      <DIV STYLE="position:absolute;left:1;top:1;visibility:hidden">
        <xsl:attribute name="ID">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
        <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" CLASS="tableBorder">

          <TR>
            <!-- *************************************************************************************** -->
            <TD CLASS="datePickerHeaderYr">
              <!-- header table, year -->
              <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="1">
                <TR>
                  <TD NOWRAP="yes" WIDTH="18">
                    <TABLE BORDER="0" CELLSPACING="1" CELLPADDING="0" CLASS="buttonBorder" WIDTH="100%">
                      <TR>
                        <TD NOWRAP="yes" CLASS="datePickerHeaderButton" HEIGHT="14">
                          <A HREF="javascript:void i2uiDatePickerPrevYear()">
                            <!-- the IMG tag must be on its own line or the alignment inside the cell is affected -->
                            <xsl:value-of select="$newline"/>
                            <IMG BORDER="0">
                              <xsl:attribute name="SRC">
                                <xsl:value-of select="$imageDirectory"/>/previous_solid_double.gif</xsl:attribute>
                            </IMG>
                            <xsl:value-of select="$newline"/>
                          </A>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                  <TD NOWRAP="yes" CLASS="datePickerHeaderLabel" ID="datePickerYearHeaderLabel">2001</TD>
                  <TD NOWRAP="yes" WIDTH="18">
                    <TABLE BORDER="0" CELLSPACING="1" CELLPADDING="0" CLASS="buttonBorder" WIDTH="100%">
                      <TR>
                        <TD NOWRAP="yes" CLASS="datePickerHeaderButton" HEIGHT="14">
                          <A HREF="javascript:void i2uiDatePickerNextYear()">
                            <!-- the IMG tag must be on its own line or the alignment inside the cell is affected -->
                            <xsl:value-of select="$newline"/>
                            <IMG BORDER="0">
                              <xsl:attribute name="SRC">
                                <xsl:value-of select="$imageDirectory"/>/forward_double_arrow.gif</xsl:attribute>
                            </IMG>
                            <xsl:value-of select="$newline"/>
                          </A>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <!-- *************************************************************************************** -->
            <TD CLASS="datePickerHeaderMo">
              <!-- header table, month -->
              <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="1">
                <TR>
                  <TD NOWRAP="yes" WIDTH="18">
                    <TABLE BORDER="0" CELLSPACING="1" CELLPADDING="0" CLASS="buttonBorder" WIDTH="100%">
                      <TR>
                        <TD NOWRAP="yes" CLASS="datePickerHeaderButton" HEIGHT="14">
                          <A HREF="javascript:void i2uiDatePickerPrevMonth()">
                            <!-- the IMG tag must be on its own line or the alignment inside the cell is affected -->
                            <xsl:value-of select="$newline"/>
                            <IMG BORDER="0">
                              <xsl:attribute name="SRC">
                                <xsl:value-of select="$imageDirectory"/>/previous_solid.gif</xsl:attribute>
                            </IMG>
                            <xsl:value-of select="$newline"/>
                          </A>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                  <TD NOWRAP="yes" CLASS="datePickerHeaderLabel" ID="datePickerMonthHeaderLabel">August</TD>
                  <TD NOWRAP="yes" WIDTH="18">
                    <TABLE BORDER="0" CELLSPACING="1" CELLPADDING="0" CLASS="buttonBorder" WIDTH="100%">
                      <TR>
                        <TD NOWRAP="yes" CLASS="datePickerHeaderButton" HEIGHT="14">
                          <A HREF="javascript:void i2uiDatePickerNextMonth()">
                            <!-- the IMG tag must be on its own line or the alignment inside the cell is affected -->
                            <xsl:value-of select="$newline"/>
                            <IMG BORDER="0">
                              <xsl:attribute name="SRC">
                                <xsl:value-of select="$imageDirectory"/>/forward_single_arrow.gif</xsl:attribute>
                            </IMG>
                            <xsl:value-of select="$newline"/>
                          </A>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <!-- *************************************************************************************** -->
            <TD CLASS="datePickerCalendar">
              <!-- calendar table -->
              <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                <TR>
                  <TD ALIGN="center">
                    <TABLE BORDER="0" CELLSPACING="1" CELLPADDING="0">
                      <TR>
                        <xsl:variable name="temp">
                          <xsl:call-template name="i2uitranslate">
                            <xsl:with-param name="locale" select="$locale"/>
                            <xsl:with-param name="key" select="$DAYLETTERS_KEY"/>
                          </xsl:call-template>
                        </xsl:variable>
                        <xsl:call-template name="genDatePickerCalendarHeader">
                          <xsl:with-param name="index">1</xsl:with-param>
                          <xsl:with-param name="dayletters" select="$temp"/>
                        </xsl:call-template>
                      </TR>
                    </TABLE>
                  </TD>
                </TR>
                <TR>
                  <TD ALIGN="center">
                    <TABLE BORDER="0" CELLSPACING="1" CELLPADDING="0" CLASS="tableBorder">
                      <xsl:call-template name="genDatePickerCalendarCells">
                        <xsl:with-param name="rowindex">0</xsl:with-param>
                        <xsl:with-param name="browser" select="$browser"/>
                        <xsl:with-param name="selectioncallback" select="$selectioncallback"/>
                      </xsl:call-template>
                    </TABLE>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <!-- *************************************************************************************** -->
            <TD CLASS="datePickerFooter">
              <!-- footer table -->
              <TABLE border="0" cellspacing="0" cellpadding="1" width="100%">
                <TR>
                  <TD nowrap="yes">
                    <TABLE BORDER="0" cellspacing="1" cellpadding="0" class="buttonBorder">
                      <TR>
                        <TD id="buttonRegular" nowrap="yes" class="buttonText">
                          <A href="javascript:void i2uiSetDatePickerToday()">&#160;
                            <xsl:call-template name="i2uitranslate">
                              <xsl:with-param name="locale" select="$locale"/>
                              <xsl:with-param name="key" select="$TODAY_KEY"/>
                            </xsl:call-template>&#160;
                          </A>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                  <xsl:if test="$embedded != 'yes'">
                    <TD nowrap="yes" WIDTH="10" STYLE="text-align:center">
                      <IMG>
                        <xsl:attribute name="SRC">
                          <xsl:value-of select="$imageDirectory"/>/blue_divider.gif</xsl:attribute>
                      </IMG>
                    </TD>
                    <TD nowrap="yes">
                      <TABLE BORDER="0" cellspacing="1" cellpadding="0" class="buttonBorder">
                        <TR>
                          <TD id="buttonRegular" nowrap="yes" class="buttonText">
                            <A>
                              <xsl:attribute name="HREF">javascript:i2uiDatePickerCancel('<xsl:value-of select="@cancelcallback"/>')</xsl:attribute>&#160;
                              <xsl:call-template name="i2uitranslate">
                                <xsl:with-param name="locale" select="$locale"/>
                                <xsl:with-param name="key" select="$CANCEL_KEY"/>
                              </xsl:call-template>&#160;
                            </A>
                          </TD>
                        </TR>
                      </TABLE>
                    </TD>
                    <TD nowrap="yes">
                      <TABLE BORDER="0" cellspacing="1" cellpadding="0" class="buttonBorderEmphasized">
                        <TR>
                          <TD id="buttonEmphasized" nowrap="yes" class="buttonTextEmphasized">
                            <A>
                              <xsl:attribute name="HREF">javascript:i2uiDatePickerOk('<xsl:value-of select="@okcallback"/>')</xsl:attribute>&#160;
                              <xsl:call-template name="i2uitranslate">
                                <xsl:with-param name="locale" select="$locale"/>
                                <xsl:with-param name="key" select="$OK_KEY"/>
                              </xsl:call-template>&#160;
                            </A>
                          </TD>
                        </TR>
                      </TABLE>
                    </TD>
                  </xsl:if>
                </TR>
              </TABLE>
            </TD>
          </TR>
        </TABLE>
      </DIV>
    </xsl:if>
  </xsl:template>

  <xsl:template match="i2:datepicker" mode="taglibNS4">
    <xsl:if test="@id and @okcallback">
      <xsl:variable name="locale">
        <xsl:choose>
          <xsl:when test="@locale">
            <xsl:value-of select="@locale"/>
          </xsl:when>
          <xsl:otherwise>en</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="embedded">
        <xsl:choose>
          <xsl:when test="@embedded">
            <xsl:value-of select="@embedded"/>
          </xsl:when>
          <xsl:otherwise>no</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="selectioncallback">
        <xsl:choose>
          <xsl:when test="$embedded = 'yes'">
            <xsl:value-of select="@okcallback"/>
          </xsl:when>
          <xsl:otherwise>null</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <SCRIPT LANGUAGE="JavaScript">var mySelectionCallback = '<xsl:value-of select="$selectioncallback"/>';</SCRIPT>
      <LAYER VISIBILITY="hide">
        <xsl:attribute name="NAME">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
        <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="1">
          <!-- ********** header table, year ********** -->
          <TR>
            <TD CLASS="tableBorder">
              <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="2">
                <TR CLASS="datePickerHeaderYr">
                  <TD NOWRAP="yes" WIDTH="18">
                    <TABLE BORDER="1" CELLSPACING="0" CELLPADDING="0" WIDTH="100%" CLASS="buttonBorder">
                      <TR>
                        <TD NOWRAP="yes" CLASS="datePickerHeaderButton" HEIGHT="14">
                          <A HREF="javascript:void i2uiDatePickerPrevYear()">
                            <!-- the IMG tag must be on its own line or the alignment inside the cell is affected -->
                            <xsl:value-of select="$newline"/>
                            <IMG BORDER="0">
                              <xsl:attribute name="SRC">
                                <xsl:value-of select="$imageDirectory"/>/previous_solid_double.gif</xsl:attribute>
                            </IMG>
                            <xsl:value-of select="$newline"/>
                          </A>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                  <TD NOWRAP="yes" CLASS="datePickerHeaderLabel">
                    <ILAYER ID="datePickerYearHeaderLabel">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;2001&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</ILAYER>
                  </TD>
                  <TD NOWRAP="yes" WIDTH="18">
                    <TABLE BORDER="1" CELLSPACING="0" CELLPADDING="0" CLASS="buttonBorder" WIDTH="100%">
                      <TR>
                        <TD NOWRAP="yes" CLASS="datePickerHeaderButton" HEIGHT="14">
                          <A HREF="javascript:void i2uiDatePickerNextYear()">
                            <!-- the IMG tag must be on its own line or the alignment inside the cell is affected -->
                            <xsl:value-of select="$newline"/>
                            <IMG BORDER="0">
                              <xsl:attribute name="SRC">
                                <xsl:value-of select="$imageDirectory"/>/forward_double_arrow.gif</xsl:attribute>
                            </IMG>
                            <xsl:value-of select="$newline"/>
                          </A>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD CLASS="tableBorder">
              <!-- ********** header table, month ********** -->
              <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="2">
                <TR CLASS="datePickerHeaderMo">
                  <TD NOWRAP="yes" WIDTH="18">
                    <TABLE BORDER="1" CELLSPACING="0" CELLPADDING="0" WIDTH="100%" CLASS="buttonBorder">
                      <TR>
                        <TD NOWRAP="yes" CLASS="datePickerHeaderButton" HEIGHT="14">
                          <A HREF="javascript:void i2uiDatePickerPrevMonth()">
                            <!-- the IMG tag must be on its own line or the alignment inside the cell is affected -->
                            <xsl:value-of select="$newline"/>
                            <IMG BORDER="0">
                              <xsl:attribute name="SRC">
                                <xsl:value-of select="$imageDirectory"/>/previous_solid.gif</xsl:attribute>
                            </IMG>
                            <xsl:value-of select="$newline"/>
                          </A>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                  <TD NOWRAP="yes" CLASS="datePickerHeaderLabel">
                    <ILAYER ID="datePickerMonthHeaderLabel">&#160;&#160;&#160;&#160;&#160;&#160;&#160;August&#160;&#160;&#160;&#160;&#160;&#160;&#160;</ILAYER>
                  </TD>
                  <TD NOWRAP="yes" WIDTH="18">
                    <TABLE BORDER="1" CELLSPACING="0" CELLPADDING="0" CLASS="buttonBorder" WIDTH="100%">
                      <TR>
                        <TD NOWRAP="yes" CLASS="datePickerHeaderButton" HEIGHT="14">
                          <A HREF="javascript:void i2uiDatePickerNextMonth()">
                            <!-- the IMG tag must be on its own line or the alignment inside the cell is affected -->
                            <xsl:value-of select="$newline"/>
                            <IMG BORDER="0">
                              <xsl:attribute name="SRC">
                                <xsl:value-of select="$imageDirectory"/>/forward_single_arrow.gif</xsl:attribute>
                            </IMG>
                            <xsl:value-of select="$newline"/>
                          </A>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD CLASS="tableBorder">
              <!-- ********** calendar table ********** -->
              <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="1">
                <TR CLASS="datePickerCalendarNS4">
                  <TD ALIGN="center">
                    <TABLE BORDER="0" CELLSPACING="6" CELLPADDING="0">
                      <TR>
                        <TD>
                          <TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1">
                            <TR>
                              <xsl:variable name="temp">
                                <xsl:call-template name="i2uitranslate">
                                  <xsl:with-param name="locale" select="$locale"/>
                                  <xsl:with-param name="key" select="$DAYLETTERS_KEY"/>
                                </xsl:call-template>
                              </xsl:variable>
                              <xsl:call-template name="genDatePickerCalendarHeader">
                                <xsl:with-param name="index">1</xsl:with-param>
                                <xsl:with-param name="dayletters" select="$temp"/>
                              </xsl:call-template>
                            </TR>
                          </TABLE>
                        </TD>
                      </TR>
                      <TR>
                        <TD CLASS="tableBorder">
                          <TABLE BORDER="0" CELLSPACING="1" CELLPADDING="1">
                            <xsl:call-template name="genDatePickerCalendarCells">
                              <xsl:with-param name="rowindex">0</xsl:with-param>
                              <xsl:with-param name="browser">NS4</xsl:with-param>
                              <xsl:with-param name="selectioncallback" select="$selectioncallback"/>
                            </xsl:call-template>
                          </TABLE>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD CLASS="tableBorder">
              <!-- ********** footer table ********** -->
              <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="2">
                <TR CLASS="datePickerFooter">
                  <TD nowrap="yes">
                    <TABLE BORDER="1" cellspacing="0" cellpadding="0" class="buttonBorder">
                      <TR>
                        <TD id="buttonRegular" nowrap="yes" class="buttonText">
                          <A href="javascript:void i2uiSetDatePickerToday()">&#160;
                            <xsl:call-template name="i2uitranslate">
                              <xsl:with-param name="locale" select="$locale"/>
                              <xsl:with-param name="key" select="$TODAY_KEY"/>
                            </xsl:call-template>&#160;
                          </A>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                  <xsl:if test="$embedded != 'yes'">
                    <TD nowrap="yes" WIDTH="10" ALIGN="center">
                      <IMG>
                        <xsl:attribute name="SRC">
                          <xsl:value-of select="$imageDirectory"/>/blue_divider.gif</xsl:attribute>
                      </IMG>
                    </TD>
                    <TD nowrap="yes">
                      <TABLE BORDER="1" cellspacing="0" cellpadding="0" class="buttonBorder">
                        <TR>
                          <TD id="buttonRegular" nowrap="yes" class="buttonText">
                            <A>
                              <xsl:attribute name="HREF">javascript:i2uiDatePickerCancel('<xsl:value-of select="@cancelcallback"/>')</xsl:attribute>&#160;
                              <xsl:call-template name="i2uitranslate">
                                <xsl:with-param name="locale" select="$locale"/>
                                <xsl:with-param name="key" select="$CANCEL_KEY"/>
                              </xsl:call-template>&#160;
                            </A>
                          </TD>
                        </TR>
                      </TABLE>
                    </TD>
                    <TD nowrap="yes">
                      <TABLE BORDER="1" cellspacing="0" cellpadding="0" class="buttonBorderEmphasized">
                        <TR>
                          <TD id="buttonEmphasized" nowrap="yes" class="buttonTextEmphasized">
                            <A>
                              <xsl:attribute name="HREF">javascript:i2uiDatePickerOk('<xsl:value-of select="@okcallback"/>')</xsl:attribute>&#160;
                              <xsl:call-template name="i2uitranslate">
                                <xsl:with-param name="locale" select="$locale"/>
                                <xsl:with-param name="key" select="$OK_KEY"/>
                              </xsl:call-template>&#160;
                            </A>
                          </TD>
                        </TR>
                      </TABLE>
                    </TD>
                  </xsl:if>
                </TR>
              </TABLE>
            </TD>
          </TR>
        </TABLE>
      </LAYER>
    </xsl:if>
  </xsl:template>

  <xsl:template name="genDatePickerCalendarHeader">
    <xsl:param name="index"/>
    <xsl:param name="dayletters"/>

    <xsl:if test="$index &lt;= 7">
      <TD WIDTH="18" HEIGHT="16" CLASS="datePickerDayLetter">
        <xsl:value-of select="substring($dayletters,$index,1)"/>
      </TD>

      <xsl:call-template name="genDatePickerCalendarHeader">
        <xsl:with-param name="index" select="$index + 1"/>
        <xsl:with-param name="dayletters" select="$dayletters"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="genDatePickerCalendarCells">
    <xsl:param name="rowindex"/>
    <xsl:param name="browser"/>
    <xsl:param name="selectioncallback"/>

    <xsl:if test="$rowindex != 6">
      <TR>
        <xsl:call-template name="genDatePickerCalendarRow">
          <xsl:with-param name="rowindex" select="$rowindex"/>
          <xsl:with-param name="colindex">0</xsl:with-param>
          <xsl:with-param name="browser" select="$browser"/>
          <xsl:with-param name="selectioncallback" select="$selectioncallback"/>
        </xsl:call-template>
      </TR>

      <xsl:call-template name="genDatePickerCalendarCells">
        <xsl:with-param name="rowindex" select="$rowindex + 1"/>
        <xsl:with-param name="browser" select="$browser"/>
        <xsl:with-param name="selectioncallback" select="$selectioncallback"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="genDatePickerCalendarRow">
    <xsl:param name="rowindex"/>
    <xsl:param name="colindex"/>
    <xsl:param name="browser"/>
    <xsl:param name="selectioncallback"/>

    <xsl:if test="$colindex != 7">
      <xsl:variable name="id">cell<xsl:value-of select="$rowindex"/><xsl:value-of select="$colindex"/></xsl:variable>

      <xsl:choose>
        <xsl:when test="$browser = 'NS4'">
          <TD WIDTH="18" HEIGHT="18" CLASS="datePickerDay">
            <ILAYER>
              <xsl:attribute name="ID">
                <xsl:value-of select="$id"/>
              </xsl:attribute>
              <A>
                <xsl:attribute name="HREF">javascript:i2uiDatePickerSelect('<xsl:value-of select="$id"/>','<xsl:value-of select="$selectioncallback"/>')</xsl:attribute>
                <xsl:value-of select="$rowindex"/>
              </A>
            </ILAYER>
          </TD>
        </xsl:when>
        <xsl:when test="$browser = 'NS6'">
          <TD WIDTH="18" HEIGHT="18" CLASS="datePickerDay">
            <xsl:attribute name="ID">
              <xsl:value-of select="$id"/>
            </xsl:attribute>
            <A HREF="javascript:void 0">
              <xsl:attribute name="ONCLICK">javascript:i2uiDatePickerSelect('<xsl:value-of select="$id"/>','<xsl:value-of select="$selectioncallback"/>')</xsl:attribute>
              <xsl:value-of select="$rowindex"/>
            </A>
          </TD>
        </xsl:when>
        <xsl:otherwise>
          <TD WIDTH="18" HEIGHT="18" CLASS="datePickerDay">
            <xsl:attribute name="ID">
              <xsl:value-of select="$id"/>
            </xsl:attribute>
            <A ONMOUSEOVER="javascript:this.style.cursor='hand'">
              <xsl:attribute name="ONCLICK">javascript:i2uiDatePickerSelect('<xsl:value-of select="$id"/>','<xsl:value-of select="$selectioncallback"/>')</xsl:attribute>
              <xsl:value-of select="$rowindex"/>
            </A>
          </TD>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:call-template name="genDatePickerCalendarRow">
        <xsl:with-param name="rowindex" select="$rowindex"/>
        <xsl:with-param name="colindex" select="$colindex + 1"/>
        <xsl:with-param name="browser" select="$browser"/>
        <xsl:with-param name="selectioncallback" select="$selectioncallback"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c)1998-2002 eXcelon Corp.
<metaInformation>
<scenarios ><scenario default="yes" name="Precompile" userelativepaths="yes" externalpreview="no" url="..\..\..\omx\xsl\login.xsl" htmlbaseurl="" processortype="xalan" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""/></scenarios><MapperInfo srcSchemaPath="" srcSchemaRoot="" srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
</metaInformation>
-->
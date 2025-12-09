<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                version="1.0">
  
  <xsl:output method="html"/>
  
  
  <xsl:template name="i2:uiduallistboxactionstemplate">
    <xsl:param name="firstbox"></xsl:param>
    <xsl:param name="secondbox"></xsl:param>
    <xsl:param name="id" select="'duallist'"></xsl:param>

    <xsl:variable name="doublerighturl"> 
      javascript:i2uiduallistboxmoveall(<xsl:value-of select="$firstbox"/>,<xsl:value-of select="$secondbox"/>)
    </xsl:variable>      
    <xsl:variable name="singlerighturl"> 
      javascript:i2uiduallistboxmoveit(<xsl:value-of select="$firstbox"/>,<xsl:value-of select="$secondbox"/>)
    </xsl:variable>      
    <xsl:variable name="doublelefturl"> 
      javascript:i2uiduallistboxmoveall(<xsl:value-of select="$secondbox"/>,<xsl:value-of select="$firstbox"/>)
    </xsl:variable>      
    <xsl:variable name="singlelefturl"> 
      javascript:i2uiduallistboxmoveit(<xsl:value-of select="$secondbox"/>,<xsl:value-of select="$firstbox"/>)
    </xsl:variable>      
    
    <!-- The following values can be changed based on some conditions to have some disabled buttons -->
    <xsl:variable name="doublerightdisabled" select="no"/>
    <xsl:variable name="singlerightdisabled" select="no"/>
    <xsl:variable name="doubleleftdisabled" select="no"/>
    <xsl:variable name="singleleftdisabled" select="no"/>

    <!-- The following values will also change to corresponding images of disabled buttons if we
         start supporting disabled buttons -->
        
    <xsl:variable name="doublerightimage">/arrow_double_right.gif</xsl:variable>
    <xsl:variable name="singlerightimage">/arrow_right.gif</xsl:variable>
    <xsl:variable name="doubleleftimage">/arrow_double_left.gif</xsl:variable>
    <xsl:variable name="singleleftimage">/arrow_left.gif</xsl:variable>
<!--
    <xsl:variable name="doublerightimage">/arrow_right_wide_double.gif</xsl:variable>
    <xsl:variable name="singlerightimage">/arrow_right_wide.gif</xsl:variable>
    <xsl:variable name="doubleleftimage">/arrow_left_wide_double.gif</xsl:variable>
    <xsl:variable name="singleleftimage">/arrow_left_wide.gif</xsl:variable>
-->
    <table cellspacing="0" cellpadding="0" border="0" width="16">
      <tr height="22">
        <td nowrap="yes">
          <center>
            <i2:button id="{$id}_doubleright">
              <i2:attribute name="onclick">
                <xsl:value-of select="$doublerighturl"/>
              </i2:attribute>  
              <i2:attribute name="disabled">
                <xsl:value-of select="$doublerightdisabled"/>
              </i2:attribute>  
              <i2:img border="0">
                <i2:attribute name="src">
                  <xsl:value-of select="$doublerightimage"/>
                </i2:attribute>
              </i2:img>  
            </i2:button>
          </center>
        </td>
      </tr>
      <tr height="22">
        <td nowrap="yes">
          <center>
            <i2:button id="{$id}_singleright">
              <i2:attribute name="onclick">
                <xsl:value-of select="$singlerighturl"/>
              </i2:attribute>  
              <i2:attribute name="disabled">
                <xsl:value-of select="$singlerightdisabled"/>
              </i2:attribute>  
              <i2:img border="0">
                <i2:attribute name="src">
                  <xsl:value-of select="$singlerightimage"/>
                </i2:attribute>
<!--                <i2:attribute name="hspace">
                  <xsl:value-of select="1"/>
                </i2:attribute>
-->              </i2:img>  
            </i2:button>
          </center>
        </td>
      </tr>
      <tr height="22">
        <td nowrap="yes">
          <center>
            <i2:button id="{$id}_singleleft">
              <i2:attribute name="onclick">
                <xsl:value-of select="$singlelefturl"/>
              </i2:attribute>  
              <i2:attribute name="disabled">
                <xsl:value-of select="$singleleftdisabled"/>
              </i2:attribute>  
              <i2:img border="0">
                <i2:attribute name="src">
                  <xsl:value-of select="$singleleftimage"/>
                </i2:attribute>
              </i2:img>  
            </i2:button>
          </center>
        </td>
      </tr>

      <tr height="22">
        <td nowrap="yes">
          <center>
            <i2:button id="{$id}_doubleleft">
              <i2:attribute name="onclick">
                <xsl:value-of select="$doublelefturl"/>
              </i2:attribute>  
              <i2:attribute name="disabled">
                <xsl:value-of select="$doubleleftdisabled"/>
              </i2:attribute>  
              <i2:img border="0">
                <i2:attribute name="src">
                  <xsl:value-of select="$doubleleftimage"/>
                </i2:attribute>
              </i2:img>  
            </i2:button>
          </center>
        </td>
      </tr>
    </table>
  </xsl:template>  
  
  
  <xsl:template name="i2:uiduallistboxordertemplate">
    <xsl:param name="list"></xsl:param>
  
    <xsl:variable name="doublerighturl"> 
      javascript:i2uiMoveOptionOrderedList(<xsl:value-of select="$list"/>,0)
    </xsl:variable>      
    <xsl:variable name="singlerighturl"> 
      javascript:i2uiMoveOptionOrderedList(<xsl:value-of select="$list"/>,-1)
    </xsl:variable>      
    <xsl:variable name="doublelefturl"> 
      javascript:i2uiMoveOptionOrderedList(<xsl:value-of select="$list"/>,2)
    </xsl:variable>      
    <xsl:variable name="singlelefturl"> 
      javascript:i2uiMoveOptionOrderedList(<xsl:value-of select="$list"/>,1)
    </xsl:variable>      
    
    <!-- The following values can be changed based on some conditions to have some disabled buttons -->
    <xsl:variable name="doublerightdisabled" select="no"/>
    <xsl:variable name="singlerightdisabled" select="no"/>
    <xsl:variable name="doubleleftdisabled" select="no"/>
    <xsl:variable name="singleleftdisabled" select="no"/>

    <!-- The following values will also change to corresponding images of disabled buttons if we
         start supporting disabled buttons -->
        
    <xsl:variable name="doublerightimage">/arrow_double_up.gif</xsl:variable>
    <xsl:variable name="singlerightimage">/arrow_up.gif</xsl:variable>
    <xsl:variable name="doubleleftimage">/arrow_double_down.gif</xsl:variable>
    <xsl:variable name="singleleftimage">/arrow_down.gif</xsl:variable>
<!--
    <xsl:variable name="doublerightimage">/arrow_right_wide_double.gif</xsl:variable>
    <xsl:variable name="singlerightimage">/arrow_right_wide.gif</xsl:variable>
    <xsl:variable name="doubleleftimage">/arrow_left_wide_double.gif</xsl:variable>
    <xsl:variable name="singleleftimage">/arrow_left_wide.gif</xsl:variable>
-->
    <table cellspacing="0" cellpadding="0" border="0" width="16">
      <tr height="22">
        <td nowrap="yes">
          <center>
            <i2:button>
              <i2:attribute name="onclick">
                <xsl:value-of select="$doublerighturl"/>
              </i2:attribute>  
              <i2:attribute name="disabled">
                <xsl:value-of select="$doublerightdisabled"/>
              </i2:attribute>  
              <i2:img border="0">
                <i2:attribute name="src">
                  <xsl:value-of select="$doublerightimage"/>
                </i2:attribute>
              </i2:img>  
            </i2:button>
          </center>
        </td>
      </tr>
      <tr height="22">
        <td nowrap="yes">
          <center>
            <i2:button>
              <i2:attribute name="onclick">
                <xsl:value-of select="$singlerighturl"/>
              </i2:attribute>  
              <i2:attribute name="disabled">
                <xsl:value-of select="$singlerightdisabled"/>
              </i2:attribute>  
              <i2:img border="0">
                <i2:attribute name="src">
                  <xsl:value-of select="$singlerightimage"/>
                </i2:attribute>
<!--                <i2:attribute name="hspace">
                  <xsl:value-of select="1"/>
                </i2:attribute>
-->              </i2:img>  
            </i2:button>
          </center>
        </td>
      </tr>
      <tr height="22">
        <td nowrap="yes">
          <center>
            <i2:button>
              <i2:attribute name="onclick">
                <xsl:value-of select="$singlelefturl"/>
              </i2:attribute>  
              <i2:attribute name="disabled">
                <xsl:value-of select="$singleleftdisabled"/>
              </i2:attribute>  
              <i2:img border="0">
                <i2:attribute name="src">
                  <xsl:value-of select="$singleleftimage"/>
                </i2:attribute>
              </i2:img>  
            </i2:button>
          </center>
        </td>
      </tr>

      <tr height="22">
        <td nowrap="yes">
          <center>
            <i2:button>
              <i2:attribute name="onclick">
                <xsl:value-of select="$doublelefturl"/>
              </i2:attribute>  
              <i2:attribute name="disabled">
                <xsl:value-of select="$doubleleftdisabled"/>
              </i2:attribute>  
              <i2:img border="0">
                <i2:attribute name="src">
                  <xsl:value-of select="$doubleleftimage"/>
                </i2:attribute>
              </i2:img>  
            </i2:button>
          </center>
        </td>
      </tr>
    </table>
  </xsl:template>

  
</xsl:stylesheet>

<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalan="http://xml.apache.org/xalan"
                xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
                xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
                extension-element-prefixes="i2 i18n"
                exclude-result-prefixes="xalan"
                version="1.0">
      
  <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="printAddress">
    <xsl:param name="place"/>
    <xsl:param name="pChanged"/>
    
      <!-- Name -->
      <tr>
        <td nowrap="true" >
          <xsl:if test="$pChanged = 'true' or $pChanged='yes'">
            <xsl:attribute name="BGCOLOR">
            <xsl:text>#fff6a6</xsl:text>
            </xsl:attribute>
          </xsl:if>

        <i18n:text>Name</i18n:text>:</td>
        <xsl:choose>
          <xsl:when test="string-length($place/FULL_NAME/@Value) > 0">
            <td nowrap="true"><xsl:value-of select="$place/FULL_NAME/@Value"/></td>          
          </xsl:when>
          <xsl:otherwise>
            <td nowrap="true"><xsl:value-of select="$place/NAME/@Value"/></td>
          </xsl:otherwise> 
        </xsl:choose>          
      </tr>
      
      <!-- Address -->
      <tr>
        <td valign="top" nowrap="true" ><i18n:text>Address</i18n:text>:</td>
        <xsl:choose>
          <xsl:when test="string-length($place/ADDRESS_LINK/ADDRESS/ADDRESS1/@Value) > 0">
            <td  valign="top" nowrap="true"><xsl:value-of select="$place/ADDRESS_LINK/ADDRESS/ADDRESS1/@Value"/></td>          
          </xsl:when>
          <xsl:otherwise>
            <td valign="top" nowrap="true"><xsl:value-of select="$place/ADDRESS1/@Value"/></td>     
          </xsl:otherwise>     
        </xsl:choose>                         
      </tr>
      
      <!-- Address2 -->
      <xsl:variable name="hasAddress2" select="$place/ADDRESS2/@Value != ''"/>
      <xsl:if test="$hasAddress2">       
        <tr> 
          <td valign="top" nowrap="true">&#xA0;</td>      
          <xsl:choose>
            <xsl:when test="string-length($place/ADDRESS_LINK/ADDRESS/ADDRESS2/@Value) > 0">
              <td  valign="top" nowrap="true"><xsl:value-of select="$place/ADDRESS_LINK/ADDRESS/ADDRESS2/@Value"/></td>          
            </xsl:when>
            <xsl:otherwise>
              <td valign="top" nowrap="true"><xsl:value-of select="$place/ADDRESS2/@Value"/></td>     
            </xsl:otherwise>     
          </xsl:choose>                         
        </tr>
      </xsl:if>
      
      <!-- Address3 -->
      <xsl:variable name="hasAddress3" select="$place/ADDRESS3/@Value != ''"/>      
      <xsl:if test="hasAddress3">
        <tr>
          <td valign="top" nowrap="true">&#xA0;</td>      
          <xsl:choose>
            <xsl:when test="string-length($place/ADDRESS_LINK/ADDRESS/ADDRESS3/@Value) > 0">
              <td  valign="top" nowrap="true"><xsl:value-of select="$place/ADDRESS_LINK/ADDRESS/ADDRESS3/@Value"/></td>          
            </xsl:when>
            <xsl:otherwise>
              <td valign="top" nowrap="true"><xsl:value-of select="$place/ADDRESS3/@Value"/></td>     
            </xsl:otherwise>     
          </xsl:choose>                         
        </tr>
      </xsl:if>
      
      <!-- City,State,Zip -->
      <tr>
        <td valign="top"  ></td>
          <xsl:choose>
            <xsl:when test="count($place/ADDRESS_LINK/ADDRESS) > 0">
              <td valign="top" ><xsl:value-of select="$place/ADDRESS_LINK/ADDRESS/CITY/@Value"/>, <xsl:value-of select="$place/ADDRESS_LINK/ADDRESS/STATE/@Value"/><xsl:value-of select="' '"/><xsl:value-of select="$place/ADDRESS_LINK/ADDRESS/POSTAL_CODE/@Value"/></td>
            </xsl:when>
            <xsl:otherwise>
              <td valign="top" ><xsl:value-of select="$place/CITY/@Value"/>, <xsl:value-of select="$place/STATE/@Value"/><xsl:value-of select="' '"/><xsl:value-of select="$place/POSTAL_CODE/@Value"/></td>
            </xsl:otherwise>     
          </xsl:choose>                         
      </tr>
      
             

      <!-- Country -->
      <tr>
        <td nowrap="true" ></td>
        <xsl:choose>
          <xsl:when test="count($place/ADDRESS_LINK/ADDRESS) > 0">
            <td nowrap="true"><xsl:value-of select="translate($place/ADDRESS_LINK/ADDRESS/COUNTRY/@Value, 'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/></td>
          </xsl:when>
          <xsl:otherwise>
            <td nowrap="true"><xsl:value-of select="translate($place/COUNTRY/@Value, 'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/></td>
          </xsl:otherwise>     
         </xsl:choose>                         
      </tr>
</xsl:template>   


    <!-- ********************************************************************** 
  *********************************************************************** -->
  <xsl:template name="printAddress_no_label">
    <xsl:param name="place"/>
    <xsl:param name="displayName" select="'false'"/>    
    <xsl:param name="nameLink"/>
    
      <!-- Name -->
      <xsl:if test="$displayName = 'true' and string-length($nameLink) = 0">
      <tr>
        <xsl:choose>
          <xsl:when test="string-length($place/FULL_NAME/@Value) > 0">
            <td nowrap="true"><xsl:value-of select="$place/FULL_NAME/@Value"/></td>          
          </xsl:when>
          <xsl:otherwise>
            <td nowrap="true"><xsl:value-of select="$place/NAME/@Value"/></td>
          </xsl:otherwise> 
        </xsl:choose>          
      </tr>
      </xsl:if>
      
      <!-- Name With Link -->

            <xsl:if test="$displayName = 'true' and string-length($nameLink) > 0">
      <tr>
        <xsl:choose>
          <xsl:when test="string-length($place/FULL_NAME/@Value) > 0">
            <td nowrap="true">
              <a href="{$nameLink}" target="appFrame">
              <xsl:value-of select="$place/FULL_NAME/@Value"/>
              </a>
            </td>          
          </xsl:when>
          <xsl:otherwise>
          
            <td nowrap="true">
              <a href="{$nameLink}" target="appFrame">
                <xsl:value-of select="$place/NAME/@Value"/>
              </a>
            </td>
          </xsl:otherwise> 
        </xsl:choose>          
      </tr>
      </xsl:if>

    
      <!-- Address -->
      <tr>
        <xsl:choose>
          <xsl:when test="string-length($place/ADDRESS_LINK/ADDRESS/ADDRESS1/@Value) > 0">
            <td  valign="top" nowrap="true"><xsl:value-of select="$place/ADDRESS_LINK/ADDRESS/ADDRESS1/@Value"/></td>          
          </xsl:when>
          <xsl:otherwise>
            <td valign="top" nowrap="true"><xsl:value-of select="$place/ADDRESS1/@Value"/></td>     
          </xsl:otherwise>     
        </xsl:choose>                         
      </tr>
      
      <!-- Address2 -->
      <xsl:variable name="hasAddress2" select="$place/ADDRESS2/@Value != ''"/>
      <xsl:if test="$hasAddress2">       
        <tr> 
          <xsl:choose>
            <xsl:when test="string-length($place/ADDRESS_LINK/ADDRESS/ADDRESS2/@Value) > 0">
              <td  valign="top" nowrap="true"><xsl:value-of select="$place/ADDRESS_LINK/ADDRESS/ADDRESS2/@Value"/></td>          
            </xsl:when>
            <xsl:otherwise>
              <td valign="top" nowrap="true"><xsl:value-of select="$place/ADDRESS2/@Value"/></td>     
            </xsl:otherwise>     
          </xsl:choose>                         
        </tr>
      </xsl:if>
      
      <!-- Address3 -->
      <xsl:variable name="hasAddress3" select="$place/ADDRESS3/@Value != ''"/>      
      <xsl:if test="hasAddress3">
        <tr>
          <xsl:choose>
            <xsl:when test="string-length($place/ADDRESS_LINK/ADDRESS/ADDRESS3/@Value) > 0">
              <td  valign="top" nowrap="true"><xsl:value-of select="$place/ADDRESS_LINK/ADDRESS/ADDRESS3/@Value"/></td>          
            </xsl:when>
            <xsl:otherwise>
              <td valign="top" nowrap="true"><xsl:value-of select="$place/ADDRESS3/@Value"/></td>     
            </xsl:otherwise>     
          </xsl:choose>                         
        </tr>
      </xsl:if>
      
      <!-- City,State,Zip -->
      <tr>
          <xsl:choose>
            <xsl:when test="count($place/ADDRESS_LINK/ADDRESS) > 0">
              <td valign="top" ><xsl:value-of select="$place/ADDRESS_LINK/ADDRESS/CITY/@Value"/>, <xsl:value-of select="$place/ADDRESS_LINK/ADDRESS/STATE/@Value"/><xsl:value-of select="' '"/><xsl:value-of select="$place/ADDRESS_LINK/ADDRESS/POSTAL_CODE/@Value"/></td>
            </xsl:when>
            <xsl:otherwise>
              <td valign="top" ><xsl:value-of select="$place/CITY/@Value"/>, <xsl:value-of select="$place/STATE/@Value"/><xsl:value-of select="' '"/><xsl:value-of select="$place/POSTAL_CODE/@Value"/></td>
            </xsl:otherwise>     
          </xsl:choose>                         
      </tr>
      
      <!-- Country -->
      <tr>
        <xsl:choose>
          <xsl:when test="count($place/ADDRESS_LINK/ADDRESS) > 0">
            <td nowrap="true"><xsl:value-of select="translate($place/ADDRESS_LINK/ADDRESS/COUNTRY/@Value, 'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/></td>
          </xsl:when>
          <xsl:otherwise>
            <td nowrap="true"><xsl:value-of select="translate($place/COUNTRY/@Value, 'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/></td>
          </xsl:otherwise>     
         </xsl:choose>                         
      </tr>
</xsl:template>   


<!-- ********************************************************************** 
     *********************************************************************** -->
</xsl:stylesheet>






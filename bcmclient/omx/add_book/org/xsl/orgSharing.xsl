<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <xsl:import href="../../../xsl/tabs2.xsl"/>
  <xsl:import href="../../../xsl/buttons.xsl"/>

  <xsl:output method="html"/>

  <xsl:template match="RESPONSES">
    <xsl:apply-templates select="RESPONSE/SHARED"/>
  </xsl:template>

  <xsl:template match="SHARED">

  <xsl:variable name="caption_title">
    <i18n:text>Organizations in Shared List</i18n:text>
  </xsl:variable>
  <table cellspacing="1" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
      <form name="sharedForm" method="get" target="appFrame">
        <input type="hidden" name="SOURCE_ORG_ID" value="{ORG_ID/@Value}"/>
	    <td>
          <i2:container title="{$caption_title}">
            <table cellspacing="1" cellpadding="0" border="0" width="100%" height="100%">
              <tr>
                <td>
   			      <xsl:choose>
                    <xsl:when test="count( /RESPONSES/RESPONSE/SHARED/ORGANIZATION ) > 0">	
					  <i2:table>
                        <i2:tr header="yes">
	                      <td nowrap="yes" align="center">
	                        <input type="checkbox" name="SHARED_CHECKBOX" value="true" onclick="javascript:toggleCheckboxes(document.forms.sharedForm, document.forms.sharedForm.TARGET_ORG_ID, document.forms.sharedForm.SHARED_CHECKBOX);"/>
	                      </td>
	                      <td nowrap="yes">
	                        <i18n:text>Shared Organizations</i18n:text>
	                      </td>
	                    </i2:tr>   
		                <xsl:apply-templates select="/RESPONSES/RESPONSE/SHARED/ORGANIZATION"/>
					  </i2:table>
	                </xsl:when>
	                <xsl:otherwise>
	                  <i18n:text>Addresses are not shared with any other organizations</i18n:text>.
	                </xsl:otherwise>
	              </xsl:choose>
				</td>
			  </tr>
			</table>
		  </i2:container>
		</td>
      </form>
    </tr>
  </table>
</xsl:template>


  <xsl:template match="ORGANIZATION">
    <i2:tr>	
      <xsl:if test="/RESPONSES/RESPONSE/SHARED/EDITABLE">
	    <td width="30" align="center">
          <input type="checkbox" name="TARGET_ORG_ID" value="{ID/@Value}"/>
	    </td>
	  </xsl:if>
	  <td>
	    <a target="_parent">
		  <xsl:attribute name="href">pages/redirectToManageOrg.cmd?ID=<xsl:value-of select="ID/@Value"/></xsl:attribute>
	  	  <xsl:value-of select="FULL_NAME/@Value"/>
	    </a>
	  </td>
    </i2:tr>
  </xsl:template>    

</xsl:stylesheet>
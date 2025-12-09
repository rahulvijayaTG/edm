<?xml version="1.0" standalone='no'?>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

  <xsl:output method="html"/>

  <xsl:variable name="title"><i18n:text><xsl:value-of select="/RESPONSES/RESPONSE/REQUEST_PARAMETERS/TITLE/@Value"/></i18n:text></xsl:variable>

  <xsl:template match="RESPONSES">
    <html>
      <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <title><i18n:text><xsl:value-of select="$title"/></i18n:text></title>

        <i2:stylesheet path="/style_sheet_core.css"></i2:stylesheet>
        <i2:stylesheet path="/omx_core.css"></i2:stylesheet>
        <i2:javascript path="/global_javascript.js"></i2:javascript>
      </head>

      <!-- Body -->
      <body  class="contentFrameBody" onFocus="checkForPopUps()" onKeyDown="mappedKeyCheck()">
        <xsl:apply-templates select="RESPONSE/REQUEST_PARAMETERS"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="REQUEST_PARAMETERS">
  <xsl:variable name="title_i18n"><i18n:text><xsl:value-of select="TITLE/@Value"/></i18n:text></xsl:variable>
  	 <i2:container title="{$title_i18n}" width="50%">
  		<i2:table width="100%">
  		  <i2:tr>
  	      <td>
  		      <table>
              <tr>
                <td colspan="2" > <i18n:text><xsl:value-of select="MESSAGE/@Value"/></i18n:text></td>
              </tr>
         	    <xsl:if test="ID">
  			        <tr>
                  <td> <i18n:text><xsl:value-of select="DOC_TYPE/@Value"/></i18n:text>&#xA0;<i18n:text>ID is</i18n:text>&#xA0;<b><a target="appFrame" href="{ID_LINK/@Value}"> <xsl:value-of select="ID/@Value"/></a></b></td>
                </tr>
  		        </xsl:if>
         	    <tr>
                <td colspan="2" height="20"></td>
              </tr>
    	      </table>
  		    </td>
  		  </i2:tr>
  		</i2:table>
  	  <i2:footer>
  	    <table border="0" cellpadding="0" cellspacing="2" width="100%">
  			  <tr>
  				  <td align="right" width="100%"></td>
  				  <xsl:if test="CLOSE/@Value ='true'">
  					  <td align="right">
  					    <i2:button onclick="javascript:onClose()">&#xA0;<i18n:text>Close</i18n:text>&#xA0;</i2:button>
  				    </td>
  				  </xsl:if>
            <xsl:if test="RETURN/@Value = 'true'">
  					  <td align="right">
  					    <i2:button onclick="javascript:history.back()">&#xA0;<i18n:text>Back</i18n:text>&#xA0;</i2:button>
  					  </td>
  					</xsl:if>
  					<td align="right" width="100%"></td>
  					<xsl:if test="CANCEL/@Value ='true'">
  					  <td align="right">
  					    <i2:button target="appFrame" onclick="{HOME_PAGE/@Value}">&#xA0;<i18n:text>Cancel</i18n:text>&#xA0;</i2:button>
  						</td>
            </xsl:if>
  			    <xsl:if test="OK/@Value ='true'">
  					  <td align="right">
  					  	<xsl:choose>
  					  		<xsl:when test="string-length(OK_LINK/@Value) &gt; 0">
  					  			<i2:button target="appFrame" onclick="{OK_LINK/@Value}">&#xA0;<i18n:text>Ok</i18n:text>&#xA0;</i2:button>
  					  		</xsl:when>
  					  		<xsl:otherwise>
  					  			<i2:button target="appFrame" onclick="{HOME_PAGE/@Value}">&#xA0;<i18n:text>Ok</i18n:text>&#xA0;</i2:button>
  					  		</xsl:otherwise>
  					  	</xsl:choose>
  					  </td>
  				  </xsl:if>
  			  </tr>
  		  </table>
  	  </i2:footer>
    </i2:container>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:output method="html"/>
  
<xsl:template match="RESPONSE" mode="search"> 
	<xsl:if test="count(SEARCH/OPTION) > 0">
  <xsl:variable name="caption_title">
    <i18n:text>Search</i18n:text>
  </xsl:variable>
  <i2:container title="{$caption_title}" stretch="yes">
		<i2:header>
			<table border="0" cellpadding="2" cellspacing="0" width="100%">
				<tr>
					<td align="right">
            <a class="text" href="#" onClick="popUpWindow( 'help/search.htm', 'popUp4')">
              <i2:img border="0" align="middle" src="/help_avail.gif"/>
            </a>
					</td>
				</tr>
			</table>
		</i2:header>
	  <table border="0" cellpadding="3" cellspacing="10" width="100%">
			<form name="search_form" action="{SEARCH_URL/@Value}" method="post" target="appFrame">
		  <tr>
 				<td nowrap="yes">
 				  <i18n:text>Search By</i18n:text>
 				</td>
 				<td align="left" width="100%">
				<select name="SEARCH_TYPE" class="pulldown">
				  <option value="SELECT_NONE" selected="yes"><i18n:text>Select...</i18n:text></option>                          
				    <xsl:for-each select="SEARCH/OPTION">			  
				      <xsl:sort select="./@Description" order="ascending"/>						
				      <option value="{./@Value}">
					<i18n:text><xsl:value-of select="./@Description"/></i18n:text>			        
				      </option>
				    </xsl:for-each>
				</select>
        </td>
	    </tr>
		  <tr>
		    <td nowrap="yes"><i18n:text>Enter Keyword</i18n:text></td>
		    <td align="left">
			    <input type="field" class="inputFieldIE" name="SEARCH_CRITERIA" value="*" size="17"/>
			  </td>
		  </tr>
		  </form>
			</table>
			<i2:footer>
				<table border="0" cellpadding="0" cellspacing="2" width="100%">
					<tr>
						<td align="right" width="100%">&#xA0;</td>
						<td align="right">
				    	<i2:button onclick="javascript:search_form.submit()">&#xA0;<i18n:text>Search</i18n:text>&#xA0;</i2:button>
						</td>
					</tr>
				</table>
		  </i2:footer>
	</i2:container>
	</xsl:if>
</xsl:template>  		   

</xsl:stylesheet>

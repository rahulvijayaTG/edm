<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.xapl.i18n.xsl.xalan.XalanXSLExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:import href="../../xsl/tabs.xsl"/>

<xsl:output method="html"/>

<xsl:template match="RESPONSES">  
	<form name="termsSearchForm" action="user_admin_terms_search.jsp" method="GET" target="appFrame">
		<table border="0" cellpadding="5" cellspacing="0">
			<tr class="table1">
				<td colspan="6"><i18n:text>Search for an existing Term or fill out the information below to add or modify a Term</i18n:text>.</td>
			</tr>
			<tr class="table1">
				<td><b><i18n:text>Enter Keywords</i18n:text> </b></td>
				<td>
					<input name="KEYWORDS" value="" type="field" class="inputfieldIE" size="17"/>
				</td>
				<td><b><i18n:text>Search By</i18n:text> </b></td>
				<td>
					<select name="SEARCH_BY" class="pulldown">
						<xsl:for-each select="RESPONSE/SEARCH_TYPE">
							<option value="{@Value}"><xsl:value-of select="@Value"/></option>
						</xsl:for-each>
					</select>
				</td>
			</tr>								
			<tr>
				<td>
					<i2:button onclick="javascript:document.termsSearchForm.submit();"><i18n:text>Search</i18n:text></i2:button>
				</td>
				<td>
                    <input name="SORT_BY" type="hidden" value=""/> 
				</td>
			</tr>
		</table>
	

    <xsl:variable name="caption_title">
      <i18n:text>Search Results (by </i18n:text>
      <xsl:value-of select="RESPONSE/SORT_BY/@Value"/>)
    </xsl:variable>
		<i2:container title="{$caption_title}">  
     <i2:table>
			<i2:tr header="yes">
				<td nowrap="nowrap"><a href="javascript:sort('{RESPONSE/KEYWORDS/@Value}', '{RESPONSE/SEARCH_BY/@Value}', 'ID')"><i18n:text>ID</i18n:text></a></td>
				<td nowrap="nowrap"><a href="javascript:sort('{RESPONSE/KEYWORDS/@Value}', '{RESPONSE/SEARCH_BY/@Value}', 'NAME')"><i18n:text>Name</i18n:text></a></td>
				<td nowrap="nowrap"><a href="javascript:sort('{RESPONSE/KEYWORDS/@Value}', '{RESPONSE/SEARCH_BY/@Value}', 'SELLING_ORG_ID')"><i18n:text>Selling Organization</i18n:text></a></td>
				<td nowrap="nowrap"><i18n:text>Details</i18n:text></td>
			</i2:tr>
			<xsl:for-each select="RESPONSE/IN_DISCOUNT">
				<i2:tr class="table2">
					<td nowrap="nowrap">
						<a target="appFrame">
                            <xsl:attribute name="href">
                                user_admin_terms.jsp?ID=<xsl:value-of select="ID/@Value"/>
                            </xsl:attribute>
                        <xsl:value-of select="ID/@Value"/>
                        </a>
					</td>
					<td nowrap="nowrap"><xsl:value-of select="NAME/@Value"/></td>
					<td nowrap="nowrap"><xsl:value-of select="SELLING_ORG_ID/@Value"/></td>
					<td><xsl:value-of select="DESCRIPTION/@Value"/></td>
				</i2:tr>
			</xsl:for-each>
            
		</i2:table>
		</i2:container>
        
	</form>

</xsl:template>

</xsl:stylesheet>
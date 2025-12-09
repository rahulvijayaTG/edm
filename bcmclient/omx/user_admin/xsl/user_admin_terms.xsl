<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.xapl.i18n.xsl.xalan.XalanXSLExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:import href="../../xsl/tabs.xsl"/>
<xsl:import href="../../xsl/code_master.xsl"/> 

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
                <td> </td>
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
	</form>
	
	
	
	<form name="termsForm" method="POST" target="appFrame">
		<table border="0" cellpadding="0" cellspacing="1" width="100%" class="tablebackground">
			<tr class="contenttablecodebody">
				<td>
					<table border="0" cellpadding="0" cellspacing="8" width="100%">
						<tr>
							<td colspan="6">
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr class="tableheader">
										<td><i18n:text>Term Details</i18n:text></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr class="text">
							<td nowrap="nowrap"><b><i18n:text>ID</i18n:text></b></td>
							<td nowrap="nowrap">
                                <xsl:choose>
                                    <xsl:when test="RESPONSE/IN_DISCOUNT/ID/@Value != ''">
                                        <xsl:value-of select="RESPONSE/IN_DISCOUNT/ID/@Value"/>
                                        <input type="hidden" name="ID" value="{RESPONSE/IN_DISCOUNT/ID/@Value}" class="inputfieldIE"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <input type="hidden" name="ID" value="" class="inputfieldIE"/>
                                    </xsl:otherwise>
                                </xsl:choose>

                            </td>
						</tr>

						<tr class="text">						
							<td nowrap="nowrap"><b><i18n:text>Due Days</i18n:text></b></td>
							<td nowrap="nowrap">
                                <input type="field" name="DUE_DAYS" value="{RESPONSE/IN_DISCOUNT/DUE_DAYS/@Value}" class="inputfieldIE" size="17" />
                             </td>						
						</tr>

						<tr class="text">						
							<td nowrap="nowrap"><b><i18n:text>Name</i18n:text></b></td>
							<td nowrap="nowrap">
                                <input type="field" name="NAME" value="{RESPONSE/IN_DISCOUNT/NAME/@Value}" class="inputfieldIE" size="17" />
                             </td>						
						</tr>

						<tr class="text">						
							<td nowrap="nowrap"><b><i18n:text>Selling Organization</i18n:text></b></td>
							<td nowrap="nowrap">
                                <input type="field" name="SELLING_ORG_ID" value="{RESPONSE/IN_DISCOUNT/SELLING_ORG_ID/@Value}" class="inputfieldIE" size="17" />
                             </td>						
						</tr>

						<tr class="text">						
							<td nowrap="nowrap"><b><i18n:text>Discount Percentage</i18n:text></b></td>
							<td nowrap="nowrap">
                                <input type="field" name="DISCOUNT_PERCENT" value="{RESPONSE/IN_DISCOUNT/DISCOUNT_PERCENT/@Value}" class="inputfieldIE" size="17" />
                             </td>						
						</tr>

						<tr class="text">						
							<td nowrap="nowrap"><b><i18n:text>Discount Due Days</i18n:text></b></td>
							<td nowrap="nowrap">
                                <input type="field" name="DISCOUNT_DAYS" value="{RESPONSE/IN_DISCOUNT/DISCOUNT_DAYS/@Value}" class="inputfieldIE" size="17" />
                             </td>						
						</tr>

						<tr class="text">						
							<td nowrap="nowrap"><b><i18n:text>Start Day</i18n:text></b></td>
							<td nowrap="nowrap">
                                <input type="field" name="START_DAY" value="{RESPONSE/IN_DISCOUNT/START_DAY/@Value}" class="inputfieldIE" size="17" />
                             </td>						
						</tr>

						<tr class="text">						
							<td nowrap="nowrap"><b><i18n:text>Details</i18n:text></b></td>
							<td nowrap="nowrap">
                                <textarea  name="DESCRIPTION"  class="inputfieldIE" rows="5" cols="40">
                                    <xsl:value-of select="RESPONSE/IN_DISCOUNT/DESCRIPTION/@Value"/>
                                </textarea>
                            </td>						

                        </tr>
					
                    </table>
				</td>
			</tr>
		</table>
	</form>
	

</xsl:template>

</xsl:stylesheet>
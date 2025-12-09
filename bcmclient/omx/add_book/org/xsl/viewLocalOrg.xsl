<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:import href="../../../xsl/code_master.xsl"/>

<xsl:output method="html"/>

<xsl:template match="LOCAL_CUSTOMER" mode="view">
<script>
  function confirmRemoveLocal(){
    if( confirm( 'Deactivate this organization?' ) ){
	  parent.location = 'data/removeLocalCustomer.cmd?LOCAL_ORG_ID=<xsl:value-of select="ID/@Value"/>&amp;ORG_ID=<xsl:value-of select="CUSTOMER_ORG_ID/@Value"/>';
	}
  }
</script>
  <xsl:variable name="caption_title"><i18n:text>Relationship Details</i18n:text></xsl:variable>
  <i2:container title="{$caption_title}">
<table width="100%" class="tableRow1">
  <tr >	
    <td>	

  <xsl:choose>
    <xsl:when test="IS_NEW/@Value = 'true'">
	  <br/>
	  <center><i18n:text>Relationship information has not been entered for this organization.</i18n:text></center>
	  <br/>
	</xsl:when>
	<xsl:otherwise>
  <table border="0" cellpadding="0" cellspacing="5" width="100%">
    <tr>
	<td nowrap="true" width="5%"><i18n:text>Customer Type</i18n:text>:</td>
	<td nowrap="true" width="45%">
	 <xsl:variable name="type"><xsl:value-of select="CUSTOMER_TYPE/@Value"/></xsl:variable>
	 <i18n:text>
	   <xsl:value-of select="/RESPONSES/RESPONSE/CUSTOMER_TYPES/CODE_MASTER_VALUE[VALUE_ID/@Value = $type]/DESCRIPTION/@Value"/>
	 </i18n:text>
	 </td>
	<td nowrap="true" width="5%"><i18n:text>Status</i18n:text>:</td>
	<td nowrap="true" width="45%">
	  <xsl:if test="not(STATUS)">
	    <i18n:text>There are no existing relationships.</i18n:text>
	  </xsl:if>
	  <xsl:if test=" (STATUS/@Value = 'ACTIVE') ">
	    <i18n:text>Active</i18n:text>
	  </xsl:if>
	  <xsl:if test=" (STATUS/@Value = 'DORMANT' or STATUS/@Value = 'INACTIVE') ">
	    <i18n:text>Inactive</i18n:text>
	  </xsl:if>
	</td>
    </tr>
    <tr>
	<td nowrap="true" width="5%"><i18n:text>Pricing Template</i18n:text>:</td>
     	 <xsl:variable name="type"><xsl:value-of select="PRICING_TEMPLATE/@Value"/></xsl:variable>
                        <xsl:choose>
                          <xsl:when test="/RESPONSES/RESPONSE/PRICING_TEMPLATES/CODE_MASTER_VALUE[VALUE_ID/@Value = $type]/DESCRIPTION/@Value != ''">
                          <td nowrap="true">
                          	 <i18n:text>
	                           <xsl:value-of select="/RESPONSES/RESPONSE/PRICING_TEMPLATES/CODE_MASTER_VALUE[VALUE_ID/@Value = $type]/DESCRIPTION/@Value"/>
	                         </i18n:text>
                          </td>
                          </xsl:when>
                          <xsl:otherwise>
                          <td nowrap="true">N/A</td>
                          </xsl:otherwise>
                      </xsl:choose>			                          
    </tr>
  </table>	  
    </xsl:otherwise>
  </xsl:choose>
</td>
</tr>
</table>
<xsl:if test="EDITABLE">
<i2:footer>
		<table border="0" cellpadding="0" cellspacing="2" width="100%">
		<tr>
			<td align="right" width="100%">&#xA0;</td>
		    <xsl:choose>
			  <xsl:when test="IS_NEW/@Value = 'true'">
			        <td>
					<i2:button emphasized="yes" small="yes" onclick="javascript:parent.location='editLocalOrg.jsp?ORG_ID={CUSTOMER_ORG_ID/@Value}'" tabindex="201">
						&#xA0;<i18n:text>Create</i18n:text>&#xA0;
					</i2:button>
				</td>		
			</xsl:when>
		      	<xsl:when test="STATUS/@Value = 'Active'">
			<td>
			        <i2:button emphasized="yes" small="yes" onclick="javascript:parent.location='editLocalOrg.jsp?ORG_ID={CUSTOMER_ORG_ID/@Value}'" tabindex="202">
					&#xA0;<i18n:text>Edit</i18n:text>&#xA0;
				</i2:button>
			</td>
			<td> <i2:button small="yes" onclick="javascript:confirmRemoveLocal()" tabindex="203">&#xA0;<i18n:text>Deactivate</i18n:text>&#xA0;</i2:button></td>
		      </xsl:when>
		      <xsl:otherwise>
				<td>
		        		<i2:button emphasized="yes" small="yes" onclick="javascript:parent.location='data/activateLocalCustomer.cmd?LOCAL_ORG_ID={ID/@Value}&amp;ORG_ID={CUSTOMER_ORG_ID/@Value}'" tabindex="204">
						&#xA0;<i18n:text>Activate</i18n:text>&#xA0;
					</i2:button>
				</td>	
		      </xsl:otherwise>
		    </xsl:choose>
		</tr>
		</table>
	</i2:footer>
</xsl:if>

</i2:container>

</xsl:template>

</xsl:stylesheet>


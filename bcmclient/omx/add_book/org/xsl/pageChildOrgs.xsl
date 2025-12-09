<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:import href="addr_book_tabs.xsl"/>
<xsl:import href="orderPointList.xsl"/>
<xsl:import href="billingAddressList.xsl"/>
<xsl:import href="shippingAddressList.xsl"/>

<xsl:output method="html"/>

<xsl:template match="/">

 
<i2:tabbedcontainer>
  <xsl:apply-templates select="/RESPONSES/RESPONSE/TAB_INFO" mode="tabs"/>

<table border="0" cellpadding="0" cellspacing="15" width="100%">
    <tr>
		<td valign="top" width="50%">		
			<xsl:apply-templates select="/RESPONSES/RESPONSE/CHILD_ORGS"/>
		</td>
		<td></td>
		<td valign="top" width="50%">&amp;nbsp;</td>		
	</tr>
</table>
</i2:tabbedcontainer>


</xsl:template>

<xsl:template match="CHILD_ORGS">
  <xsl:variable name="caption_title"><i18n:text>Child Organizations</i18n:text></xsl:variable>
  <i2:container title="{$caption_title}" collapsable="no">			
	  <i2:table>	  
	    <xsl:choose>
		  <xsl:when test="count( ORGANIZATION ) > 0">  
	        <xsl:apply-templates select="ORGANIZATION" mode="list"/>
		  </xsl:when>
		  <xsl:otherwise>
		     <i2:tr><td align="left"><i18n:text>There are no child organizations for this organization.</i18n:text>.</td></i2:tr>
		  </xsl:otherwise>
		</xsl:choose>
	  </i2:table>

  <xsl:if test="EDITABLE">
	<i2:footer>
		<table border="0" cellpadding="0" cellspacing="2" width="100%">
		<tr>
			<td align="right" width="100%">&#xA0;</td>
	    		<td><i2:button emphasized="yes" onclick="javascript:parent.location='editOrg.jsp?PARENT_ORG_ID={ORG_ID/@Value}'" tabindex="201">&#xA0;<i18n:text>Add</i18n:text>&#xA0;</i2:button></td>
		</tr>
		</table>
	</i2:footer>
  </xsl:if>


  </i2:container>
</xsl:template>  		    

<xsl:template match="ORGANIZATION" mode="list">
   <i2:tr>	
		<td align="left">&#xA0;<a  href="viewOrg.jsp?ORG_ID={ID/@Value}" target="appFrame">
		<xsl:value-of select="FULL_NAME/@Value"/>
		</a></td> 
    </i2:tr>
</xsl:template>  



</xsl:stylesheet>
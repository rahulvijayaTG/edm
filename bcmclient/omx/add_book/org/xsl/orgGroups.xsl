<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:import href="addr_book_tabs.xsl"/>

<xsl:output method="html"/>

<xsl:template match="/">

<SCRIPT language="javascript">
function confirmRemoveGroup()
{
  if( confirm( 'Remove this group?' ) )
  {
    document.groupsForm.submit();
  }
}
</SCRIPT>


 

<i2:tabbedcontainer>
  <xsl:apply-templates select="/RESPONSES/RESPONSE/TAB_INFO" mode="tabs"/>
<!-- ORPHAN -->
<form name="groupsForm" method="GET" action="removeGroup.cmd">

<xsl:variable name="caption_title"><i18n:text>Groups</i18n:text></xsl:variable>
<i2:container title="{$caption_title}">
    <i2:table>  
      <i2:tr header="yes">
        <td align="center">&amp;nbsp;</td>
        <td align="center"><i18n:text>Type</i18n:text></td>
        <td align="center"><i18n:text>Name</i18n:text></td>
      </i2:tr>
	  <xsl:apply-templates select="GROUP"/>
	</i2:table>

	   <i2:buttonbar>
	     <i2:button onclick="javascript:parent.location='addGroup.jsp?ORG_ID={ORG_ID/@Value}'"><i18n:text>Add</i18n:text></i2:button>
	     <i2:button onclick="javascript:confirmRemoveGroup()"><i18n:text>Remove</i18n:text></i2:button>
	   </i2:buttonbar>  

</i2:container>

</form>

</i2:tabbedcontainer>
</xsl:template>

<xsl:template match="GROUP">
    <i2:tr>	
	  <td width="30" align="center">
        <input type="radio" name="GROUP_ID" value="{ID/@Value}"/>
	  </td>
	  
	<td nowrap="true">
		<xsl:variable name="type"><xsl:value-of select="TYPE/@Value"/></xsl:variable>
		<xsl:value-of select="/RESPONSES/RESPONSE/GROUP_TYPES/CODE_MASTER_VALUE[VALUE_ID/@Value = $type]/DESCRIPTION/@Value"/>
	</td>

	  <td><xsl:value-of select="NAME/@Value"/></td>
    </i2:tr>
</xsl:template>    


</xsl:stylesheet>

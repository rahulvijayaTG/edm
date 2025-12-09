<?xml version="1.0" standalone='no'?>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:i2="com.i2.ui.web.xsl.xalan.XalanExtension"
  xmlns:i18n="com.i2.x2.xsl.extensions.i18n.I18NExtension"
  extension-element-prefixes="i2 i18n"
  version="1.0">

<xsl:output method="html"/>

<xsl:variable name="numCatalogItems" select="count(/RESPONSES/RESPONSE/CA_ITEM)"/>  
<xsl:variable name="numCustOrders" select="count(/RESPONSES/RESPONSE/CUSTOMER_ORDER)"/>  


<xsl:template match="/RESPONSES/RESPONSE">  
   
  <table bgcolor="gray" border="1" cellspacing="0" cellpadding="0">
		<FORM NAME="calControl" method="POST">
		<input type="hidden" name="day" value="{DAY/@Value}"/>
		<input type="hidden" name="mon" value="{MON/@Value}"/>
		<input type="hidden" name="year" value="{YEAR/@Value}"/>
    <xsl:variable name="formattedDate"><i18n:date format="common"><xsl:value-of select="FORMATTED_DATE/@Value"/></i18n:date></xsl:variable>
		<input type="hidden" name="formattedDate" value="{$formattedDate}"/>
			<tr bgcolor="#bec5e7" bordercolor="#bec5e7">
			<td align="left">
				<i2:button onclick="javascript:setPreviousYear()" >&#xA0;<i2:img src="/back_double_arrow.gif" border="0"/>&#xA0;</i2:button>
			</td>
			<td align="center">
				<b><xsl:value-of select="YEAR/@Value"/></b>
			</td>
			<td align="right">
				<i2:button onclick="javascript:setNextYear()" >&#xA0;<i2:img src="/forward_double_arrow.gif" border="0"/>&#xA0;</i2:button>
			</td>
			</tr>
			<tr bgcolor="#d1d6f0" bordercolor="#d1d6f0">
			<td align="left">
					<i2:button onclick="javascript:setPreviousMonth()" >&#xA0;&#xA0;<i2:img src="/back_single_arrow.gif" border="0"/>&#xA0;</i2:button>
			</td>
			<td align="center">
					<b>
          <xsl:call-template name="getMonthName">
            <xsl:with-param name="month" select="MON/@Value"/>
          </xsl:call-template>
					</b>
			</td>
			<td align="right">
					<i2:button onclick="javascript:setNextMonth()" >&#xA0;<i2:img src="/forward_single_arrow.gif" border="0"/>&#xA0;&#xA0;</i2:button>
			</td>
			</tr>
			<tr bgcolor="#f7f8fd">
				<td colspan="3">
				<table cellpadding="6" align="center" border="0">
				<tr><td>
				
				<table CELLPADDING="0" CELLSPACING="0" ALIGN="CENTER" BORDER="0">
					<tr bordercolor="#f7f8fd">
						<td width="18px" height="18px" align="center" bordercolor="#f7f8fd"><b><i18n:text name="DOW.SUN">S</i18n:text></b></td>
						<td width="18px" height="18px" align="center" bordercolor="#f7f8fd"><b><i18n:text name="DOW.MON">M</i18n:text></b></td>
						<td width="18px" height="18px" align="center" bordercolor="#f7f8fd"><b><i18n:text name="DOW.TUE">T</i18n:text></b></td>
						<td width="18px" height="18px" align="center" bordercolor="#f7f8fd"><b><i18n:text name="DOW.WED">W</i18n:text></b></td>
						<td width="18px" height="18px" align="center" bordercolor="#f7f8fd"><b><i18n:text name="DOW.THU">T</i18n:text></b></td>
						<td width="18px" height="18px" align="center" bordercolor="#f7f8fd"><b><i18n:text name="DOW.FRI">F</i18n:text></b></td>
						<td width="18px" height="18px" align="center" bordercolor="#f7f8fd"><b><i18n:text name="DOW.SAT">S</i18n:text></b></td>
					</tr>
					<tr><td colspan="7">							
					<table CELLPADDING="0" CELLSPACING="0" ALIGN="CENTER" BORDER="1">
					<script>
					buildDays();
					</script>
					</table>
					</td>
					</tr>
				</table>
				</td></tr>
				</table>
			</td>
			</tr>
			<tr bgcolor="#bec5e7">
    		<td colspan="3">
          <table border="0" cellpadding="2" cellspacing="0" width="100%">
					<tr>
					<td><i2:button onclick='javascript:setToday()'>&#xA0;<i18n:text>Today</i18n:text>&#xA0;</i2:button></td>	
					<td align="center"><i2:buttonbar><i2:buttonbardivider></i2:buttonbardivider></i2:buttonbar></td>
					<td><i2:button onclick="javascript:closeCalendar()">&#xA0;<i18n:text>Cancel</i18n:text>&#xA0;</i2:button></td>							
          <td><i2:button emphasized="yes" onclick="javascript:returnDate()">&#xA0;<i18n:text>Ok</i18n:text>&#xA0;</i2:button></td>
					</tr>
 	  			</table>
        </td>
			</tr>
  	</FORM>
  </table>
</xsl:template>

<xsl:template name="getMonthName">
  <xsl:param name="month" select="0"/>
  <xsl:choose>
    <xsl:when test="number($month) = 1"><i18n:text>January</i18n:text></xsl:when>
    <xsl:when test="number($month) = 2"><i18n:text>February</i18n:text></xsl:when>
    <xsl:when test="number($month) = 3"><i18n:text>March</i18n:text></xsl:when>
    <xsl:when test="number($month) = 4"><i18n:text>April</i18n:text></xsl:when>
    <xsl:when test="number($month) = 5"><i18n:text>May</i18n:text></xsl:when>
    <xsl:when test="number($month) = 6"><i18n:text>June</i18n:text></xsl:when>
    <xsl:when test="number($month) = 7"><i18n:text>July</i18n:text></xsl:when>
    <xsl:when test="number($month) = 8"><i18n:text>August</i18n:text></xsl:when>
    <xsl:when test="number($month) = 9"><i18n:text>September</i18n:text></xsl:when>
    <xsl:when test="number($month) = 10"><i18n:text>October</i18n:text></xsl:when>
    <xsl:when test="number($month) = 11"><i18n:text>November</i18n:text></xsl:when>
    <xsl:when test="number($month) = 12"><i18n:text>December</i18n:text></xsl:when>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>